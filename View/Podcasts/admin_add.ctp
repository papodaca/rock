<div class="podcasts form">
<?php echo $this->Form->create('Podcast'); ?>
	<fieldset>
		<legend><?php echo __('Add Podcast'); ?></legend>
	<?php
		echo $this->Form->input('name');
		echo $this->Form->input('rocks_id');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Podcasts'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rocks'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
	</ul>
</div>
