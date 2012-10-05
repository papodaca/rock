<div class="songs view">
<h2><?php  echo __('Song'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($song['Song']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Name'); ?></dt>
		<dd>
			<?php echo h($song['Song']['name']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Track Nr'); ?></dt>
		<dd>
			<?php echo h($song['Song']['track_nr']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Disk Nr'); ?></dt>
		<dd>
			<?php echo h($song['Song']['disk_nr']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Album'); ?></dt>
		<dd>
			<?php echo $this->Html->link($song['Album']['name'], array('controller' => 'albums', 'action' => 'view', $song['Album']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Genre'); ?></dt>
		<dd>
			<?php echo $this->Html->link($song['Genre']['name'], array('controller' => 'genres', 'action' => 'view', $song['Genre']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Artist'); ?></dt>
		<dd>
			<?php echo $this->Html->link($song['Artist']['name'], array('controller' => 'artists', 'action' => 'view', $song['Artist']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Rock'); ?></dt>
		<dd>
			<?php echo $this->Html->link($song['Rock']['id'], array('controller' => 'rocks', 'action' => 'view', $song['Rock']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Length Sec'); ?></dt>
		<dd>
			<?php echo h($song['Song']['length_sec']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($song['Song']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($song['Song']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Song'), array('action' => 'edit', $song['Song']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Song'), array('action' => 'delete', $song['Song']['id']), null, __('Are you sure you want to delete # %s?', $song['Song']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('action' => 'add')); ?> </li>
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
<div class="related">
	<h3><?php echo __('Related Playlist Elements'); ?></h3>
	<?php if (!empty($song['PlaylistElement'])): ?>
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
		foreach ($song['PlaylistElement'] as $playlistElement): ?>
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
