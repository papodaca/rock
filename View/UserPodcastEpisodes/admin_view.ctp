<div class="userPodcastEpisodes view">
<h2><?php  echo __('User Podcast Episode'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($userPodcastEpisode['UserPodcastEpisode']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Users'); ?></dt>
		<dd>
			<?php echo $this->Html->link($userPodcastEpisode['Users']['name'], array('controller' => 'users', 'action' => 'view', $userPodcastEpisode['Users']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Podcast Episode'); ?></dt>
		<dd>
			<?php echo $this->Html->link($userPodcastEpisode['PodcastEpisode']['id'], array('controller' => 'podcast_episodes', 'action' => 'view', $userPodcastEpisode['PodcastEpisode']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Location'); ?></dt>
		<dd>
			<?php echo h($userPodcastEpisode['UserPodcastEpisode']['location']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Played'); ?></dt>
		<dd>
			<?php echo h($userPodcastEpisode['UserPodcastEpisode']['played']); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit User Podcast Episode'), array('action' => 'edit', $userPodcastEpisode['UserPodcastEpisode']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete User Podcast Episode'), array('action' => 'delete', $userPodcastEpisode['UserPodcastEpisode']['id']), null, __('Are you sure you want to delete # %s?', $userPodcastEpisode['UserPodcastEpisode']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List User Podcast Episodes'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New User Podcast Episode'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Users'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcast Episodes'), array('controller' => 'podcast_episodes', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcast Episode'), array('controller' => 'podcast_episodes', 'action' => 'add')); ?> </li>
	</ul>
</div>
