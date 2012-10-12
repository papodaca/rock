<div class="userPodcastSubscriptions index">
	<h2><?php echo __('User Podcast Subscriptions'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('users_id'); ?></th>
			<th><?php echo $this->Paginator->sort('podcasts_id'); ?></th>
			<th><?php echo $this->Paginator->sort('created'); ?></th>
			<th><?php echo $this->Paginator->sort('modified'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($userPodcastSubscriptions as $userPodcastSubscription): ?>
	<tr>
		<td><?php echo h($userPodcastSubscription['UserPodcastSubscription']['id']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($userPodcastSubscription['Users']['name'], array('controller' => 'users', 'action' => 'view', $userPodcastSubscription['Users']['id'])); ?>
		</td>
		<td>
			<?php echo $this->Html->link($userPodcastSubscription['Podcasts']['name'], array('controller' => 'podcasts', 'action' => 'view', $userPodcastSubscription['Podcasts']['id'])); ?>
		</td>
		<td><?php echo h($userPodcastSubscription['UserPodcastSubscription']['created']); ?>&nbsp;</td>
		<td><?php echo h($userPodcastSubscription['UserPodcastSubscription']['modified']); ?>&nbsp;</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $userPodcastSubscription['UserPodcastSubscription']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $userPodcastSubscription['UserPodcastSubscription']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $userPodcastSubscription['UserPodcastSubscription']['id']), null, __('Are you sure you want to delete # %s?', $userPodcastSubscription['UserPodcastSubscription']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('New User Podcast Subscription'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Users'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('controller' => 'podcasts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcasts'), array('controller' => 'podcasts', 'action' => 'add')); ?> </li>
	</ul>
</div>
