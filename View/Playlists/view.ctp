<div class="playlists view">
<h2><?php  echo __('Playlist'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($playlist['Playlist']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Name'); ?></dt>
		<dd>
			<?php echo h($playlist['Playlist']['name']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($playlist['Playlist']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($playlist['Playlist']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Playlist'), array('action' => 'edit', $playlist['Playlist']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Playlist'), array('action' => 'delete', $playlist['Playlist']['id']), null, __('Are you sure you want to delete # %s?', $playlist['Playlist']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Playlists'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Playlist Elements'), array('controller' => 'playlist_elements', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Playlist Element'), array('controller' => 'playlist_elements', 'action' => 'add')); ?> </li>
	</ul>
</div>
<div class="related">
	<h3><?php echo __('Related Playlist Elements'); ?></h3>
	<?php if (!empty($playlist['PlaylistElement'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Playlist Id'); ?></th>
		<th><?php echo __('Song Id'); ?></th>
		<th><?php echo __('Order Nr'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($playlist['PlaylistElement'] as $playlistElement): ?>
		<tr>
			<td><?php echo $playlistElement['id']; ?></td>
			<td><?php echo $playlistElement['playlist_id']; ?></td>
			<td><?php echo $playlistElement['song_id']; ?></td>
			<td><?php echo $playlistElement['order_nr']; ?></td>
			<td><?php echo $playlistElement['created']; ?></td>
			<td><?php echo $playlistElement['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'playlist_elements', 'action' => 'view', $playlistElement['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'playlist_elements', 'action' => 'edit', $playlistElement['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'playlist_elements', 'action' => 'delete', $playlistElement['id']), null, __('Are you sure you want to delete # %s?', $playlistElement['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New Playlist Element'), array('controller' => 'playlist_elements', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
