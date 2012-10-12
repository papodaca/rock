<div class="albums index">
	<h2><?php echo __('Albums'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('name'); ?></th>
			<th><?php echo $this->Paginator->sort('art_id'); ?></th>
			<th><?php echo $this->Paginator->sort('artist_id'); ?></th>
			<th><?php echo $this->Paginator->sort('created'); ?></th>
			<th><?php echo $this->Paginator->sort('modified'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($albums as $album): ?>
	<tr>
		<td><?php echo h($album['Album']['id']); ?>&nbsp;</td>
		<td><?php echo h($album['Album']['name']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($album['Art']['id'], array('controller' => 'arts', 'action' => 'view', $album['Art']['id'])); ?>
		</td>
		<td>
			<?php echo $this->Html->link($album['Artist']['name'], array('controller' => 'artists', 'action' => 'view', $album['Artist']['id'])); ?>
		</td>
		<td><?php echo h($album['Album']['created']); ?>&nbsp;</td>
		<td><?php echo h($album['Album']['modified']); ?>&nbsp;</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $album['Album']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $album['Album']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $album['Album']['id']), null, __('Are you sure you want to delete # %s?', $album['Album']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('New Album'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List Arts'), array('controller' => 'arts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Art'), array('controller' => 'arts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Artists'), array('controller' => 'artists', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Artist'), array('controller' => 'artists', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
