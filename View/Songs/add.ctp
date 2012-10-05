<div class="songs form">
<?php echo $this->Form->create('Song'); ?>
	<fieldset>
		<legend><?php echo __('Add Song'); ?></legend>
	<?php
		echo $this->Form->input('name');
		echo $this->Form->input('track_nr');
		echo $this->Form->input('disk_nr');
		echo $this->Form->input('album_id');
		echo $this->Form->input('genre_id');
		echo $this->Form->input('artist_id');
		echo $this->Form->input('rock_id');
		echo $this->Form->input('length_sec');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Songs'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Albums'), array('controller' => 'albums', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Album'), array('controller' => 'albums', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Genres'), array('controller' => 'genres', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Genre'), array('controller' => 'genres', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Artists'), array('controller' => 'artists', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Artist'), array('controller' => 'artists', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rock'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Playlist Elements'), array('controller' => 'playlist_elements', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist Element'), array('controller' => 'playlist_elements', 'action' => 'add')); ?> </li>
	</ul>
</div>
