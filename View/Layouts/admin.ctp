<?php
/**
 *
 * PHP 5
 *
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @package       app.View.Layouts
 * @since         CakePHP(tm) v 0.10.0.1076
 * @license       MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<?php echo $this->Html->charset(); ?>
	<title>
		<?php echo __('Rock:'); ?>
		<?php echo $title_for_layout; ?>
	</title>
	<?php
		echo $this->Html->css('admin');

		echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->fetch('script');
	?>
</head>
<body>
	<div id="container">
		<div id="header">
			<h1><?php echo __('Rock Admin.') ?></h1>
		</div>
		<div id="content">

			<?php echo $this->Session->flash(); ?>

			<?php echo $this->fetch('content'); ?>
		</div>
		<div id="footer">
			<a href="http://cakephp.org"><img src="data:image/gif;base64,R0lGODdhYgANAPEAAAA0QcDAwP///wAAACwAAAAAYgANAAACopSPqcvtDyMDtNqLs946+A+G4kiOBoemala27huc60yz8I3Llw7oAvXryT6VAMUIIHZGRSXxiUxGSTygtXf9BbHFozf5jV5I0rLHDD6DzKIqt4IAboVBpfR835CPaqM6PRXYNpdViLU1Jwa2qIhBFsKWxvZHRSgHZxh08NXFiPIIeeeXxzcJ4laTmoLD+oKqCmvTOjsYa8tBm3sqwdvr+/tbAAA7"></a>
		</div>
	</div>
	<?php echo $this->element('sql_dump'); ?>
</body>
</html>
