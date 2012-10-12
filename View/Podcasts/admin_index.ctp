<div class="podcasts index">
	<h2><?php echo __('Podcasts'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('name'); ?></th>
			<th><?php echo $this->Paginator->sort('rocks_id'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($podcasts as $podcast): ?>
	<tr>
		<td><?php echo h($podcast['Podcast']['id']); ?>&nbsp;</td>
		<td><?php echo h($podcast['Podcast']['name']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($podcast['Rocks']['id'], array('controller' => 'rocks', 'action' => 'view', $podcast['Rocks']['id'])); ?>
		</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $podcast['Podcast']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $podcast['Podcast']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $podcast['Podcast']['id']), null, __('Are you sure you want to delete # %s?', $podcast['Podcast']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('New Podcast'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rocks'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
	</ul>
</div>
