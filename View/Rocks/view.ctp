<div class="rocks view">
<h2><?php  echo __('Rock'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('System Path'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['system_path']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Remote Path'); ?></dt>
		<dd>
			<?php echo h($rock['Rock']['remote_path']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('M Type'); ?></dt>
		<dd>
			<?php echo $this->Html->link($rock['MType']['id'], array('controller' => 'm_types', 'action' => 'view', $rock['MType']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('List M Types'), array('controller' => 'm_types', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New M Type'), array('controller' => 'm_types', 'action' => 'add')); ?> </li>
	</ul>
</div>
