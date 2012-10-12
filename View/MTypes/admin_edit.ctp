<div class="mTypes form">
<?php echo $this->Form->create('MType'); ?>
	<fieldset>
		<legend><?php echo __('Edit M Type'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('type');
		echo $this->Form->input('extension');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $this->Form->value('MType.id')), null, __('Are you sure you want to delete # %s?', $this->Form->value('MType.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List M Types'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rock'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
	</ul>
</div>
