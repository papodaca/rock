<div class="playlistElements index">
	<h2><?php echo __('Playlist Elements'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('playlist_id'); ?></th>
			<th><?php echo $this->Paginator->sort('song_id'); ?></th>
			<th><?php echo $this->Paginator->sort('order_nr'); ?></th>
			<th><?php echo $this->Paginator->sort('created'); ?></th>
			<th><?php echo $this->Paginator->sort('modified'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($playlistElements as $playlistElement): ?>
	<tr>
		<td><?php echo h($playlistElement['PlaylistElement']['id']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($playlistElement['Playlist']['name'], array('controller' => 'playlists', 'action' => 'view', $playlistElement['Playlist']['id'])); ?>
		</td>
		<td>
			<?php echo $this->Html->link($playlistElement['Song']['name'], array('controller' => 'songs', 'action' => 'view', $playlistElement['Song']['id'])); ?>
		</td>
		<td><?php echo h($playlistElement['PlaylistElement']['order_nr']); ?>&nbsp;</td>
		<td><?php echo h($playlistElement['PlaylistElement']['created']); ?>&nbsp;</td>
		<td><?php echo h($playlistElement['PlaylistElement']['modified']); ?>&nbsp;</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $playlistElement['PlaylistElement']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $playlistElement['PlaylistElement']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $playlistElement['PlaylistElement']['id']), null, __('Are you sure you want to delete # %s?', $playlistElement['PlaylistElement']['id'])); ?>
		</td>
	</tr>
<?php endforeach; ?>
	</table>
	<p>
	<?php
	echo $this->Paginator->counter(array(
	'format' => __('Page {:page} of {:pages}, showing {:current} records out of {:count} total, starting on record {:start}, ending on {:end}')
	));
	?>	</p>

	<div class="paging">
	<?php
		echo $this->Paginator->prev('< ' . __('previous'), array(), null, array('class' => 'prev disabled'));
		echo $this->Paginator->numbers(array('separator' => ''));
		echo $this->Paginator->next(__('next') . ' >', array(), null, array('class' => 'next disabled'));
	?>
	</div>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('New Playlist Element'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List Playlists'), array('controller' => 'playlists', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist'), array('controller' => 'playlists', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
