<?php
require_once(__DIR__ . '/../inc/config.php');
require_once(__DIR__ . '/user_area_inc.php'); // checks session and user id

// path info
$frags = '';
if(!empty($_SERVER['PATH_INFO'])) {
	$frags = $_SERVER['PATH_INFO'];
}
else {
	if(!empty($_SERVER['ORIG_PATH_INFO'])) {
		$frags = $_SERVER['ORIG_PATH_INFO'];
	}
}
// frags still empty
if(empty($frags)) {
	$frags = (!empty($_SERVER['QUERY_STRING'])) ? $_SERVER['QUERY_STRING'] : '';
}
$frags = explode("/", $frags);

$stmt = $conn->prepare('SELECT * FROM users WHERE id = :userid');
$stmt->bindValue(':userid', $userid);
$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);

$first_name   = '';
$last_name    = '';
$email        = '';
$profile_city = '';
$gender       = 'u';

$first_name         = (!empty($row['first_name']        )) ? $row['first_name']         : '';
$last_name          = (!empty($row['last_name']         )) ? $row['last_name']          : '';
$email              = (!empty($row['email']             )) ? $row['email']              : '';
$profile_city       = (!empty($row['city_name']         )) ? $row['city_name']          : '';
$profile_country    = (!empty($row['country_name']      )) ? $row['country_name']       : '';
$gender             = (!empty($row['gender']            )) ? $row['gender']             : '';
$b_year             = (!empty($row['b_year']            )) ? $row['b_year']             : '';
$b_month            = (!empty($row['b_month']           )) ? $row['b_month']            : '';
$b_day              = (!empty($row['b_day']             )) ? $row['b_day']              : '';
$profile_pic_status = (!empty($row['profile_pic_status'])) ? $row['profile_pic_status'] : '';

$first_name         = e($first_name);
$last_name          = e($last_name);
$email              = e($email);
$profile_city       = e($profile_city);
$profile_country    = e($profile_country);

/*--------------------------------------------------
Profile pic
--------------------------------------------------*/
$folder = floor($userid / 1000) + 1;

if(strlen($folder) < 1) {
	$folder = '999';
}

// profile pic folder
$profile_pic_folder = '../profile_pic_full/' . $folder;

// thumb path
$profile_pic = '../profile_pic_full/' . $folder . '/' . $userid;

// check if file exists
$profile_pic = glob("$profile_pic.*");

if(!empty($profile_pic)) {
	$profile_pic_tag = '<div class="dummy container-img" style="background-image:url(\'' . $profile_pic[0] . '\');"></div>';
}
else {
	$profile_pic_tag = '<img src="../imgs/blank.png" width="150" height="150" />';
}

/*--------------------------------------------------
Date vars
--------------------------------------------------*/
$months = array(
$txt_mon,
$txt_jan,
$txt_feb,
$txt_mar,
$txt_apr,
$txt_may,
$txt_jun,
$txt_jul,
$txt_aug,
$txt_sep,
$txt_oct,
$txt_nov,
$txt_dec
);

/*--------------------------------------------------
Include template
--------------------------------------------------*/
require_once(__DIR__ . '/../templates/user_templates/tpl_my-profile.php');