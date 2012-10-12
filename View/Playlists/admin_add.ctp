<div class="playlists form">
<?php echo $this->Form->create('Playlist'); ?>
	<fieldset>
		<legend><?php echo __('Add Playlist'); ?></legend>
	<?php
		echo $this->Form->input('name');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Playlists'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Playlist Elements'), array('controller' => 'playlist_elements', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist Element'), array('controller' => 'playlist_elements', 'action' => 'add')); ?> </li>
	</ul>
</div>
