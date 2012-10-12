<div class="artists view">
<h2><?php  echo __('Artist'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($artist['Artist']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Name'); ?></dt>
		<dd>
			<?php echo h($artist['Artist']['name']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Art'); ?></dt>
		<dd>
			<?php echo $this->Html->link($artist['Art']['id'], array('controller' => 'arts', 'action' => 'view', $artist['Art']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($artist['Artist']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($artist['Artist']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Artist'), array('action' => 'edit', $artist['Artist']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Artist'), array('action' => 'delete', $artist['Artist']['id']), null, __('Are you sure you want to delete # %s?', $artist['Artist']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Artists'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Artist'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Arts'), array('controller' => 'arts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Art'), array('controller' => 'arts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Albums'), array('controller' => 'albums', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Album'), array('controller' => 'albums', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
<div class="related">
	<h3><?php echo __('Related Albums'); ?></h3>
	<?php if (!empty($artist['Album'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Name'); ?></th>
		<th><?php echo __('Art Id'); ?></th>
		<th><?php echo __('Artist Id'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($artist['Album'] as $album): ?>
		<tr>
			<td><?php echo $album['id']; ?></td>
			<td><?php echo $album['name']; ?></td>
			<td><?php echo $album['art_id']; ?></td>
			<td><?php echo $album['artist_id']; ?></td>
			<td><?php echo $album['created']; ?></td>
			<td><?php echo $album['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'albums', 'action' => 'view', $album['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'albums', 'action' => 'edit', $album['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'albums', 'action' => 'delete', $album['id']), null, __('Are you sure you want to delete # %s?', $album['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New Album'), array('controller' => 'albums', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
<div class="related">
	<h3><?php echo __('Related Songs'); ?></h3>
	<?php if (!empty($artist['Song'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Name'); ?></th>
		<th><?php echo __('Track Nr'); ?></th>
		<th><?php echo __('Disk Nr'); ?></th>
		<th><?php echo __('Album Id'); ?></th>
		<th><?php echo __('Genre Id'); ?></th>
		<th><?php echo __('Artist Id'); ?></th>
		<th><?php echo __('Rock Id'); ?></th>
		<th><?php echo __('Length Sec'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($artist['Song'] as $song): ?>
		<tr>
			<td><?php echo $song['id']; ?></td>
			<td><?php echo $song['name']; ?></td>
			<td><?php echo $song['track_nr']; ?></td>
			<td><?php echo $song['disk_nr']; ?></td>
			<td><?php echo $song['album_id']; ?></td>
			<td><?php echo $song['genre_id']; ?></td>
			<td><?php echo $song['artist_id']; ?></td>
			<td><?php echo $song['rock_id']; ?></td>
			<td><?php echo $song['length_sec']; ?></td>
			<td><?php echo $song['created']; ?></td>
			<td><?php echo $song['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'songs', 'action' => 'view', $song['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'songs', 'action' => 'edit', $song['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'songs', 'action' => 'delete', $song['id']), null, __('Are you sure you want to delete # %s?', $song['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
