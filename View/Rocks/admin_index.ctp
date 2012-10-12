<div class="rocks index">
	<h2><?php echo __('Rocks'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('system_path'); ?></th>
			<th><?php echo $this->Paginator->sort('remote_path'); ?></th>
			<th><?php echo $this->Paginator->sort('m_type_id'); ?></th>
			<th><?php echo $this->Paginator->sort('created'); ?></th>
			<th><?php echo $this->Paginator->sort('modified'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($rocks as $rock): ?>
	<tr>
		<td><?php echo h($rock['Rock']['id']); ?>&nbsp;</td>
		<td><?php echo h($rock['Rock']['system_path']); ?>&nbsp;</td>
		<td><?php echo h($rock['Rock']['remote_path']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($rock['MType']['id'], array('controller' => 'm_types', 'action' => 'view', $rock['MType']['id'])); ?>
		</td>
		<td><?php echo h($rock['Rock']['created']); ?>&nbsp;</td>
		<td><?php echo h($rock['Rock']['modified']); ?>&nbsp;</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $rock['Rock']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $rock['Rock']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $rock['Rock']['id']), null, __('Are you sure you want to delete # %s?', $rock['Rock']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('New Rock'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List M Types'), array('controller' => 'm_types', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New M Type'), array('controller' => 'm_types', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Arts'), array('controller' => 'arts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Art'), array('controller' => 'arts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
