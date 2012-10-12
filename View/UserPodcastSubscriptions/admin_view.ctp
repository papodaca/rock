<div class="userPodcastSubscriptions view">
<h2><?php  echo __('User Podcast Subscription'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($userPodcastSubscription['UserPodcastSubscription']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Users'); ?></dt>
		<dd>
			<?php echo $this->Html->link($userPodcastSubscription['Users']['name'], array('controller' => 'users', 'action' => 'view', $userPodcastSubscription['Users']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Podcasts'); ?></dt>
		<dd>
			<?php echo $this->Html->link($userPodcastSubscription['Podcasts']['name'], array('controller' => 'podcasts', 'action' => 'view', $userPodcastSubscription['Podcasts']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Created'); ?></dt>
		<dd>
			<?php echo h($userPodcastSubscription['UserPodcastSubscription']['created']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Modified'); ?></dt>
		<dd>
			<?php echo h($userPodcastSubscription['UserPodcastSubscription']['modified']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit User Podcast Subscription'), array('action' => 'edit', $userPodcastSubscription['UserPodcastSubscription']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete User Podcast Subscription'), array('action' => 'delete', $userPodcastSubscription['UserPodcastSubscription']['id']), null, __('Are you sure you want to delete # %s?', $userPodcastSubscription['UserPodcastSubscription']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List User Podcast Subscriptions'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New User Podcast Subscription'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Users'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('controller' => 'podcasts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcasts'), array('controller' => 'podcasts', 'action' => 'add')); ?> </li>
	</ul>
</div>
