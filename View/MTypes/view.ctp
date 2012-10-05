<div class="mTypes view">
<h2><?php  echo __('M Type'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($mType['MType']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Type'); ?></dt>
		<dd>
			<?php echo h($mType['MType']['type']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Extension'); ?></dt>
		<dd>
			<?php echo h($mType['MType']['extension']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit M Type'), array('action' => 'edit', $mType['MType']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete M Type'), array('action' => 'delete', $mType['MType']['id']), null, __('Are you sure you want to delete # %s?', $mType['MType']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List M Types'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New M Type'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rock'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
	</ul>
</div>
<div class="related">
	<h3><?php echo __('Related Rocks'); ?></h3>
	<?php if (!empty($mType['Rock'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('System Path'); ?></th>
		<th><?php echo __('Remote Path'); ?></th>
		<th><?php echo __('M Type Id'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($mType['Rock'] as $rock): ?>
		<tr>
			<td><?php echo $rock['id']; ?></td>
			<td><?php echo $rock['system_path']; ?></td>
			<td><?php echo $rock['remote_path']; ?></td>
			<td><?php echo $rock['m_type_id']; ?></td>
			<td><?php echo $rock['created']; ?></td>
			<td><?php echo $rock['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'rocks', 'action' => 'view', $rock['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'rocks', 'action' => 'edit', $rock['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'rocks', 'action' => 'delete', $rock['id']), null, __('Are you sure you want to delete # %s?', $rock['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New Rock'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
