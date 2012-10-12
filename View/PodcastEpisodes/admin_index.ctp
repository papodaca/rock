<div class="podcastEpisodes index">
	<h2><?php echo __('Podcast Episodes'); ?></h2>
	<table cellpadding="0" cellspacing="0">
	<tr>
			<th><?php echo $this->Paginator->sort('id'); ?></th>
			<th><?php echo $this->Paginator->sort('podcasts_id'); ?></th>
			<th><?php echo $this->Paginator->sort('songs_id'); ?></th>
			<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
	foreach ($podcastEpisodes as $podcastEpisode): ?>
	<tr>
		<td><?php echo h($podcastEpisode['PodcastEpisode']['id']); ?>&nbsp;</td>
		<td>
			<?php echo $this->Html->link($podcastEpisode['Podcasts']['name'], array('controller' => 'podcasts', 'action' => 'view', $podcastEpisode['Podcasts']['id'])); ?>
		</td>
		<td>
			<?php echo $this->Html->link($podcastEpisode['Songs']['name'], array('controller' => 'songs', 'action' => 'view', $podcastEpisode['Songs']['id'])); ?>
		</td>
		<td class="actions">
			<?php echo $this->Html->link(__('View'), array('action' => 'view', $podcastEpisode['PodcastEpisode']['id'])); ?>
			<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $podcastEpisode['PodcastEpisode']['id'])); ?>
			<?php echo $this->Form->postLink(__('Delete'), array('action' => 'delete', $podcastEpisode['PodcastEpisode']['id']), null, __('Are you sure you want to delete # %s?', $podcastEpisode['PodcastEpisode']['id'])); ?>
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
		<li><?php echo $this->Html->link(__('New Podcast Episode'), array('action' => 'add')); ?></li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('controller' => 'podcasts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcasts'), array('controller' => 'podcasts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Songs'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New User'), array('controller' => 'users', 'action' => 'add')); ?> </li>
	</ul>
</div>
