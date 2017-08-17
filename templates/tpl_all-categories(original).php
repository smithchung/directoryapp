<!DOCTYPE html>
<!--[if IE 9]><html class="lt-ie10" lang="<?= $html_lang; ?>"> <![endif]-->
<html lang="<?= $html_lang; ?>">
<head>
<title><?= $txt_html_title; ?> - <?= $site_name; ?></title>
<meta name="description" content="<?= $txt_meta_desc; ?>" />
<?php require_once('_html_head.php'); ?>

</head>
<body class="tpl-all-categories">
<?php require_once('_header.php'); ?>

<div class="wrapper">
	<h1><?= $txt_main_title; ?></h1>
	<div class="full-block main-categories">
		<div class="block">
			<?= $suggest_cats_in_city; ?>
		</div>

		<div class="tree">
			<!-- start showing categories tree -->
			<?= $tree; ?>
			<div class="clear"></div>
		</div>
	</div><!-- .full-block .main-categories -->
</div><!-- .wrapper -->

<?php require_once('_footer.php'); ?>

</body>
</html>