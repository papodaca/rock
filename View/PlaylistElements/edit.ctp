<div class="playlistElements form">
<?php echo $this->Form->create('PlaylistElement'); ?>
	<fieldset>
		<legend><?php echo __('Edit Playlist Element'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('playlist_id');
		echo $this->Form->input('song_id');
		echo $this->Form->input('order_nr');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $this->Form->value('PlaylistElement.id')), null, __('Are you sure you want to delete # %s?', $this->Form->value('PlaylistElement.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List Playlist Elements'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Playlists'), array('controller' => 'playlists', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist'), array('controller' => 'playlists', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
