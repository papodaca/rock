<div class="podcastEpisodes form">
<?php echo $this->Form->create('PodcastEpisode'); ?>
	<fieldset>
		<legend><?php echo __('Edit Podcast Episode'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('podcasts_id');
		echo $this->Form->input('songs_id');
		echo $this->Form->input('User');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit')); ?>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $this->Form->value('PodcastEpisode.id')), null, __('Are you sure you want to delete # %s?', $this->Form->value('PodcastEpisode.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List Podcast Episodes'), array('action' => 'index')); ?></li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('controller' => 'podcasts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcasts'), array('controller' => 'podcasts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Songs'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New User'), array('controller' => 'users', 'action' => 'add')); ?> </li>
	</ul>
</div>
