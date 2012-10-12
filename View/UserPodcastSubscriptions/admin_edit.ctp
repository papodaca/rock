<div class="userPodcastSubscriptions form">
<?php echo $this->Form->create('UserPodcastSubscription'); ?>
	<fieldset>
		<legend><?php echo __('Edit User Podcast Subscription'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('users_id');
		echo $this->Form->input('podcasts_id');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $this->Form->value('UserPodcastSubscription.id')), null, __('Are you sure you want to delete # %s?', $this->Form->value('UserPodcastSubscription.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List User Podcast Subscriptions'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Users'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('controller' => 'podcasts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcasts'), array('controller' => 'podcasts', 'action' => 'add')); ?> </li>
	</ul>
</div>
