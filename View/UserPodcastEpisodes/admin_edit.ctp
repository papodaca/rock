<div class="userPodcastEpisodes form">
<?php echo $this->Form->create('UserPodcastEpisode'); ?>
	<fieldset>
		<legend><?php echo __('Edit User Podcast Episode'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('users_id');
		echo $this->Form->input('podcast_episode_id');
		echo $this->Form->input('location');
		echo $this->Form->input('played');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $this->Form->value('UserPodcastEpisode.id')), null, __('Are you sure you want to delete # %s?', $this->Form->value('UserPodcastEpisode.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List User Podcast Episodes'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Users'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcast Episodes'), array('controller' => 'podcast_episodes', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcast Episode'), array('controller' => 'podcast_episodes', 'action' => 'add')); ?> </li>
	</ul>
</div>
