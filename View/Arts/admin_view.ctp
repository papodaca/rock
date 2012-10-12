<div class="arts view">
<h2><?php  echo __('Art'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($art['Art']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Rock'); ?></dt>
		<dd>
			<?php echo $this->Html->link($art['Rock']['id'], array('controller' => 'rocks', 'action' => 'view', $art['Rock']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($art['Art']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($art['Art']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Art'), array('action' => 'edit', $art['Art']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Art'), array('action' => 'delete', $art['Art']['id']), null, __('Are you sure you want to delete # %s?', $art['Art']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Arts'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Art'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rock'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Albums'), array('controller' => 'albums', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Album'), array('controller' => 'albums', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Artists'), array('controller' => 'artists', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Artist'), array('controller' => 'artists', 'action' => 'add')); ?> </li>
	</ul>
</div>
<div class="related">
	<h3><?php echo __('Related Albums'); ?></h3>
	<?php if (!empty($art['Album'])): ?>
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
		foreach ($art['Album'] as $album): ?>
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
	<h3><?php echo __('Related Artists'); ?></h3>
	<?php if (!empty($art['Artist'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Name'); ?></th>
		<th><?php echo __('Art Id'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($art['Artist'] as $artist): ?>
		<tr>
			<td><?php echo $artist['id']; ?></td>
			<td><?php echo $artist['name']; ?></td>
			<td><?php echo $artist['art_id']; ?></td>
			<td><?php echo $artist['created']; ?></td>
			<td><?php echo $artist['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'artists', 'action' => 'view', $artist['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'artists', 'action' => 'edit', $artist['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'artists', 'action' => 'delete', $artist['id']), null, __('Are you sure you want to delete # %s?', $artist['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New Artist'), array('controller' => 'artists', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
