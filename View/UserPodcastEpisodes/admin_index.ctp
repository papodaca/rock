<div class="userPodcastEpisodes index">
	<h2><?php echo __('User Podcast Episodes'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('users_id'); ?></th>
			<th><?php echo $this->Paginator->sort('podcast_episode_id'); ?></th>
			<th><?php echo $this->Paginator->sort('location'); ?></th>
			<th><?php echo $this->Paginator->sort('played'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($userPodcastEpisodes as $userPodcastEpisode): ?>
	<tr>
		<td><?php echo h($userPodcastEpisode['UserPodcastEpisode']['id']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($userPodcastEpisode['Users']['name'], array('controller' => 'users', 'action' => 'view', $userPodcastEpisode['Users']['id'])); ?>
		</td>
		<td>
			<?php echo $this->Html->link($userPodcastEpisode['PodcastEpisode']['id'], array('controller' => 'podcast_episodes', 'action' => 'view', $userPodcastEpisode['PodcastEpisode']['id'])); ?>
		</td>
		<td><?php echo h($userPodcastEpisode['UserPodcastEpisode']['location']); ?>&nbsp;</td>
		<td><?php echo h($userPodcastEpisode['UserPodcastEpisode']['played']); ?>&nbsp;</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $userPodcastEpisode['UserPodcastEpisode']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $userPodcastEpisode['UserPodcastEpisode']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $userPodcastEpisode['UserPodcastEpisode']['id']), null, __('Are you sure you want to delete # %s?', $userPodcastEpisode['UserPodcastEpisode']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('New User Podcast Episode'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Users'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcast Episodes'), array('controller' => 'podcast_episodes', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcast Episode'), array('controller' => 'podcast_episodes', 'action' => 'add')); ?> </li>
	</ul>
</div>
