<?php
error_reporting(E_ERROR); 
defined('BASEPATH') OR exit('No direct script access allowed');

class Autoexec extends CI_Controller {

	public function index()
	{
		echo "<b>PROJECT REPOLYO: Online Paluwagan V0.5</b>";		
		echo "<br/>A Facebook Social Application";
		echo "<br/>Copyright &copy; by Globe Hackathon 2017. All Rights Reserved.";		
		echo "<br/>Developed by Raymond Morfe, Team Rocket";
		echo "<ul>";
		echo "<li>registerUser()";
		echo "<li>getUserBalance()";
		echo "<li>getUserCrowds()";
		echo "</ul>";
	}

	public function registerUser()
	{
		$json['transaction'] = 'registerUser';
		$json['status'] = 'error';
		$json['timestamp'] = date("Y-m-d H:i:s");

		if ($_POST) {
			$facebookID = $_POST['facebookID'];
			$firstName 	= $_POST['firstName'];
			$lastName 	= $_POST['lastName'];
			$emailAddr 	= $_POST['emailAddr'];
			$avatarURL 	= $_POST['avatarURL'];

			if ($facebookID=='null') $facebookID=''; 
			if ($firstName=='null') $firstName=''; 
			if ($lastName=='null') $lastName=''; 
			if ($emailAddr=='null') $emailAddr=''; 
			if ($avatarURL=='null') $avatarURL=''; 

			if ($facebookID && $firstName && $lastName && $emailAddr && $avatarURL) {
				$sql = "INSERT INTO users (facebookID, firstName, lastName, emailAddr, avatarURL) VALUES ('".mysql_real_escape_string($facebookID)."','".mysql_real_escape_string($firstName)."','".mysql_real_escape_string($lastName)."','".mysql_real_escape_string($emailAddr)."','".mysql_real_escape_string($avatarURL)."') ON DUPLICATE KEY UPDATE firstName='".mysql_real_escape_string($firstName)."', lastName='".mysql_real_escape_string($lastName)."', emailAddr='".mysql_real_escape_string($emailAddr)."', avatarURL='".mysql_real_escape_string($avatarURL)."', loginDate=NOW()";
				$data = $this->db->query($sql);
				if ($data) {
					$sql = "SELECT COUNT(*) as recordCount FROM wallets WHERE walletType='user' AND walletTypeID='".$facebookID."' LIMIT 1";
					$data = $this->db->query($sql);
					$row  = $data->result();
					$recordCount = $row[0]->recordCount;
					if ($recordCount==0) {
						$sql = "INSERT INTO wallets (walletType, walletTypeID) VALUES ('user','".$facebookID."')";
						$data = $this->db->query($sql);
						if ($data) {
							$json['status'] = 'success';
							$json['timestamp'] = date("Y-m-d H:i:s");
						}
					}
				}
			}
		}
		print_r(json_encode($json));
	}

	public function getUserBalance($facebookID='')
	{
		$json['transaction'] = 'getUserBalance';
		$json['status'] = 'error';
		$json['timestamp'] = date("Y-m-d H:i:s");
		$json['facebookID'] = $facebookID;
		//$json['balanceAmount'] = 0;
		//$json['availableAmount'] = 0;

		if ($facebookID) {
			$sql = "SELECT * FROM wallets WHERE walletType='user' AND walletTypeID='".$facebookID."' LIMIT 1";
			$data = $this->db->query($sql);
			$row  = $data->result();
			$json['status'] = 'success';
			$json['timestamp'] = date("Y-m-d H:i:s");
			$json['facebookID'] = $facebookID;
			$json['balanceAmount'] = $row[0]->balanceAmount;
			$json['availableAmount'] = $row[0]->availAmount;
		}
		print_r(json_encode($json));
	}

	public function getUserCrowds($facebookID='')
	{
		$json['transaction'] = 'getUserCrowds';
		$json['status'] = 'error';
		$json['timestamp'] = date("Y-m-d H:i:s");
		$json['facebookID'] = $facebookID;

		if ($facebookID) {
			$sql = "SELECT i.nodeID, c.crowdID, c.crowdName, c.avatarURL, c.createBy, c.createDate, c.joinFee, m.memberCount, m.memberAmount, i.userID, i.inviteCount, i.inviteAmount, i.isPaid
					from crowd c
					LEFT JOIN (
						select crowdID, count(distinct userID) as memberCount, sum(amount) as memberAmount from crowd_nodes 
						where userID!=0 and status='success'
						group by crowdID
					) m on m.crowdID=c.crowdID
					LEFT JOIN (
						select max(nodeID) as nodeID, crowdID, userParent as userID, count(distinct userID) as inviteCount, sum(amount) as inviteAmount, max(payoutOK) as isPaid from crowd_nodes 
						where userParent!=0 and status='success'
						group by crowdID, userParent
					) i on i.crowdID=c.crowdID
					WHERE i.userID='".$facebookID."'";
			$data = $this->db->query($sql);
			if ($data) {
				$json['status'] = 'success';
				$json['timestamp'] = date("Y-m-d H:i:s");
				$i=0;
				foreach ($data->result() as $row) {
					$json['crowd'][$i]['nodeID'] = $row->nodeID;
					$json['crowd'][$i]['crowdID'] = $row->crowdID;
					$json['crowd'][$i]['crowdName'] = $row->crowdName;
					$json['crowd'][$i]['avatarURL'] = base_url().'images/'.$row->avatarURL;
					$json['crowd'][$i]['createBy'] = $row->createBy;
					$json['crowd'][$i]['createDate'] = $row->createDate;
					$json['crowd'][$i]['joinFee'] = $row->joinFee;
					$json['crowd'][$i]['memberCount'] = $row->memberCount;
					if (is_null($json['crowd'][$i]['memberCount'])) $json['crowd'][$i]['memberCount']=0;
					$json['crowd'][$i]['memberAmount'] = $row->memberAmount;
					if (is_null($json['crowd'][$i]['memberAmount'])) $json['crowd'][$i]['memberAmount']=0;
					$json['crowd'][$i]['inviteCount'] = $row->inviteCount;
					$json['crowd'][$i]['inviteAmount'] = $row->inviteAmount;
					$json['crowd'][$i]['isPaid'] = $row->isPaid;
					$json['crowd'][$i]['inviteRate'] = 0;
					$json['crowd'][$i]['payoutRate'] = 0;
					$i++;
				}
			}
		}
		print_r(json_encode($json));
	}

	public function getCrowds($crowdID='')
	{
		$json['transaction'] = 'getCrowds';
		$json['status'] = 'error';
		$json['timestamp'] = date("Y-m-d H:i:s");
		$json['crowdID'] = $crowdID;

		//if ($nodeID) {
			$sqlfilter = "";
			if ($crowdID) $sqlfilter=" WHERE c.crowdID='".$crowdID."'";
			$sql = "SELECT c.crowdID, c.crowdName, c.avatarURL, c.createBy, c.createDate, c.joinFee, m.memberCount, m.memberAmount
					from crowd c
					LEFT JOIN (
						select crowdID, count(distinct userID) as memberCount, sum(amount) as memberAmount from crowd_nodes 
						where userID!=0 and status='success'
						group by crowdID
					) m on m.crowdID=c.crowdID".$sqlfilter;
			//		WHERE i.userID='".$facebookID."'";
			$data = $this->db->query($sql);
			if ($data) {
				$json['status'] = 'success';
				$json['timestamp'] = date("Y-m-d H:i:s");
				$i=0;
				foreach ($data->result() as $row) {
					$json['crowd'][$i]['crowdID'] = $row->crowdID;
					$json['crowd'][$i]['crowdName'] = $row->crowdName;
					$json['crowd'][$i]['avatarURL'] = base_url().'images/'.$row->avatarURL;
					$json['crowd'][$i]['createBy'] = $row->createBy;
					$json['crowd'][$i]['createDate'] = $row->createDate;
					$json['crowd'][$i]['joinFee'] = $row->joinFee;
					$json['crowd'][$i]['memberCount'] = $row->memberCount;
					if (is_null($json['crowd'][$i]['memberCount'])) $json['crowd'][$i]['memberCount']=0;
					$json['crowd'][$i]['memberAmount'] = $row->memberAmount;
					if (is_null($json['crowd'][$i]['memberAmount'])) $json['crowd'][$i]['memberAmount']=0;
					$json['crowd'][$i]['inviteRate'] = 0;
					$json['crowd'][$i]['payoutRate'] = 0;
					$i++;
				}
			}
		//}
		print_r(json_encode($json));
	}

	public function getNode($nodeID='',$facebookID='',$jsonOn='yes')
	{
		$json['transaction'] = 'getNode';
		$json['status'] = 'error';
		$json['timestamp'] = date("Y-m-d H:i:s");
		$json['nodeID'] = $nodeID;
		$json['facebookID'] = $facebookID;

		if ($nodeID && $facebookID) {
			$sqlfilter = "";
			if ($nodeID) $sqlfilter=" AND n.nodeID='".$nodeID."'";
			$sql = "SELECT n.nodeID, n.parentID, n.crowdID, n.createDate as joinDate, n.confirmDate, n.userID, n.userParent, n.amount as joinFee, n.transID
						, i.inviteCount, i.inviteAmount, i.isPaid
					from crowd_nodes n
					LEFT JOIN (
						select max(nodeID) as nodeID, crowdID, userParent as userID, count(distinct userID) as inviteCount, sum(amount) as inviteAmount, max(payoutOK) as isPaid from crowd_nodes 
						where userParent!=0 and status='success' and userParent='".$facebookID."'
						group by crowdID, userParent
					) i on i.crowdID=n.crowdID
					where n.userParent!=0 and n.status='success'".$sqlfilter;
			$data = $this->db->query($sql);
			$row  = $data->result();
			$json['status'] = 'success';
			$json['timestamp'] = date("Y-m-d H:i:s");
			$json['nodeID'] = $row[0]->nodeID;
			$json['parentID'] = $row[0]->parentID;
			$json['crowdID'] = $row[0]->crowdID;
			$json['userID'] = $row[0]->userID;
			$json['userParent'] = $row[0]->userParent;
			$json['joinDate'] = $row[0]->joinDate;
			$json['joinFee'] = $row[0]->joinFee;
			$json['transID'] = $row[0]->transID;
			$json['confirmDate'] = $row[0]->confirmDate;
			$json['inviteCount'] = $row[0]->inviteCount;
			$json['inviteAmount'] = $row[0]->inviteAmount;
			$json['isPaid'] = $row[0]->isPaid;
		}
		if ($jsonOn=='yes') print_r(json_encode($json));
		return $json;
	}

	public function joinNode($nodeID='',$facebookID='')
	{
		$json['transaction'] = 'joinNode';
		$json['status'] = 'error';
		$json['timestamp'] = date("Y-m-d H:i:s");
		$json['nodeID'] = $nodeID;
		$json['facebookID'] = $facebookID;

		if ($nodeID && $facebookID) {
			$json = $this->getNode($nodeID, $facebookID, 'no');
			if (is_null($json['inviteCount'])) {
				$json['status'] = 'success';
				$json['timestamp'] = date("Y-m-d H:i:s");
			};
		}
		//print_r(json_encode($json['inviteCount']));
		print_r(json_encode($json));
	}

}
