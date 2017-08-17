<?php
require_once(__DIR__ . '/../inc/config.php');
require_once(__DIR__ . '/_admin_inc.php'); // checks session and user id; die() if not admin

// csrf check
require_once(__DIR__ . '/_admin_inc_request_with_ajax.php');

try {
	$conn->beginTransaction();

	// delete photos
	$query = "SELECT
				p.place_id,
				ph.dir, ph.filename
			FROM places p
			LEFT JOIN photos ph ON p.place_id = ph.place_id
			WHERE p.status = 'trashed'";
	$stmt = $conn->prepare($query);
	$stmt->execute();

	while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
		$dir      = (!empty($row['dir']     )) ? $row['dir']      : '';
		$filename = (!empty($row['filename'])) ? $row['filename'] : '';

		if(!empty($dir) && !empty($filename)) {
			$full_pic = __DIR__ . '/../place_pic_full/' . $dir . '/' . $filename;
			$thumb_pic = __DIR__ . '/../place_pic_thumb/' . $dir . '/' . $filename;

			if(is_file($full_pic)) {
				@unlink(__DIR__ . '/../place_pic_full/' . $dir . '/' . $filename);
			}
			if(is_file($thumb_pic)) {
				@unlink(__DIR__ . '/../place_pic_thumb/' . $dir . '/' . $filename);
			}
		}
	}

	// delete places from db
	$query = "DELETE FROM places WHERE status = 'trashed'";
	$stmt = $conn->prepare($query);
	$stmt->execute();

	$conn->commit();

	echo 'OK';
} // end try block ()
catch(PDOException $e) {
	$conn->rollBack();
	$result_message =  $e->getMessage();

	echo $result_message;
}
