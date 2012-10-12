<div class="podcasts view">
<h2><?php  echo __('Podcast'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($podcast['Podcast']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Name'); ?></dt>
		<dd>
			<?php echo h($podcast['Podcast']['name']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Rocks'); ?></dt>
		<dd>
			<?php echo $this->Html->link($podcast['Rocks']['id'], array('controller' => 'rocks', 'action' => 'view', $podcast['Rocks']['id'])); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Podcast'), array('action' => 'edit', $podcast['Podcast']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Podcast'), array('action' => 'delete', $podcast['Podcast']['id']), null, __('Are you sure you want to delete # %s?', $podcast['Podcast']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcast'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Rocks'), array('controller' => 'rocks', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Rocks'), array('controller' => 'rocks', 'action' => 'add')); ?> </li>
	</ul>
</div>
