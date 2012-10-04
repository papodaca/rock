<div class="songFormats form">
<?php echo $this->Form->create('SongFormat'); ?>
	<fieldset>
		<legend><?php echo __('Edit Song Format'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('name');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $this->Form->value('SongFormat.id')), null, __('Are you sure you want to delete # %s?', $this->Form->value('SongFormat.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List Song Formats'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Song'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
	</ul>
</div>
