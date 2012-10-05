<div class="rocks form">
<?php echo $this->Form->create('Rock'); ?>
	<fieldset>
		<legend><?php echo __('Add Rock'); ?></legend>
	<?php
		echo $this->Form->input('system_path');
		echo $this->Form->input('remote_path');
		echo $this->Form->input('m_type_id');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Rocks'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List M Types'), array('controller' => 'm_types', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New M Type'), array('controller' => 'm_types', 'action' => 'add')); ?> </li>
	</ul>
</div>
