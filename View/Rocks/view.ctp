<div class="rocks view">
<h2><?php  echo __('Rock'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Path'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['path']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Rock'), array('action' => 'edit', $rock['Rock']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Rock'), array('action' => 'delete', $rock['Rock']['id']), null, __('Are you sure you want to delete # %s?', $rock['Rock']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rock'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Arts'), array('controller' => 'arts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Art'), array('controller' => 'arts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
<div class="related">
	<h3><?php echo __('Related Arts'); ?></h3>
	<?php if (!empty($rock['Art'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Rock Id'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($rock['Art'] as $art): ?>
		<tr>
			<td><?php echo $art['id']; ?></td>
			<td><?php echo $art['rock_id']; ?></td>
			<td><?php echo $art['created']; ?></td>
			<td><?php echo $art['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'arts', 'action' => 'view', $art['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'arts', 'action' => 'edit', $art['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'arts', 'action' => 'delete', $art['id']), null, __('Are you sure you want to delete # %s?', $art['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New Art'), array('controller' => 'arts', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
<div class="related">
	<h3><?php echo __('Related Songs'); ?></h3>
	<?php if (!empty($rock['Song'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Name'); ?></th>
		<th><?php echo __('Track Nr'); ?></th>
		<th><?php echo __('Disk Nr'); ?></th>
		<th><?php echo __('Album Id'); ?></th>
		<th><?php echo __('Genre Id'); ?></th>
		<th><?php echo __('Artist Id'); ?></th>
		<th><?php echo __('Song Format Id'); ?></th>
		<th><?php echo __('Rock Id'); ?></th>
		<th><?php echo __('Length Sec'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($rock['Song'] as $song): ?>
		<tr>
			<td><?php echo $song['id']; ?></td>
			<td><?php echo $song['name']; ?></td>
			<td><?php echo $song['track_nr']; ?></td>
			<td><?php echo $song['disk_nr']; ?></td>
			<td><?php echo $song['album_id']; ?></td>
			<td><?php echo $song['genre_id']; ?></td>
			<td><?php echo $song['artist_id']; ?></td>
			<td><?php echo $song['song_format_id']; ?></td>
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
