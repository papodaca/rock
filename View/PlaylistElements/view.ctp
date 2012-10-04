<div class="playlistElements view">
<h2><?php  echo __('Playlist Element'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($playlistElement['PlaylistElement']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Playlist'); ?></dt>
		<dd>
			<?php echo $this->Html->link($playlistElement['Playlist']['name'], array('controller' => 'playlists', 'action' => 'view', $playlistElement['Playlist']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Song'); ?></dt>
		<dd>
			<?php echo $this->Html->link($playlistElement['Song']['name'], array('controller' => 'songs', 'action' => 'view', $playlistElement['Song']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Order Nr'); ?></dt>
		<dd>
			<?php echo h($playlistElement['PlaylistElement']['order_nr']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($playlistElement['PlaylistElement']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($playlistElement['PlaylistElement']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Playlist Element'), array('action' => 'edit', $playlistElement['PlaylistElement']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Playlist Element'), array('action' => 'delete', $playlistElement['PlaylistElement']['id']), null, __('Are you sure you want to delete # %s?', $playlistElement['PlaylistElement']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Playlist Elements'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist Element'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Playlists'), array('controller' => 'playlists', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist'), array('controller' => 'playlists', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
