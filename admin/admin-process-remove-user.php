<?php
require_once(__DIR__ . '/../inc/config.php');
require_once(__DIR__ . '/_admin_inc.php'); // checks session and user id; die() if not admin

// csrf check
require_once(__DIR__ . '/_admin_inc_request_with_ajax.php');

$user_id = (!empty($_POST['user_id'])) ? $_POST['user_id'] : 0;

if(!empty($user_id)) {
	// mark user as trashed
	$query = "UPDATE users SET status = 'trashed' WHERE id = :user_id";
	$stmt = $conn->prepare($query);
	$stmt->bindValue(':user_id', $user_id);
	$stmt->execute();

	// remove profile picture
	$folder = floor($user_id / 1000) + 1;

	if(strlen($folder) < 1) {
		$folder = '999';
	}

	// profile pic path
	$full_pic_path  = __DIR__ . '/../profile_pic_full/' . $folder . '/' . $user_id;
	$thumb_pic_path = __DIR__ . '/../profile_pic_thumb/' . $folder . '/' . $user_id;

	// check if file exists
	$full_pic_arr = glob("$full_pic_path.*");
	$thumb_pic_arr = glob("$thumb_pic_path.*");

	if(!empty($full_pic_arr)) {
		foreach($full_pic_arr as $k => $v) {
			if(is_file($v)) {
				unlink($v);
			}
		}
	}
	if(!empty($thumb_pic_arr)) {
		foreach($thumb_pic_path as $k => $v) {
			unlink($v);
		}
	}
}