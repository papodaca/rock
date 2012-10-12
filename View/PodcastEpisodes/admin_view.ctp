<div class="podcastEpisodes view">
<h2><?php  echo __('Podcast Episode'); ?></h2>
	<dl>
		<dt><?php echo __('Id'); ?></dt>
		<dd>
			<?php echo h($podcastEpisode['PodcastEpisode']['id']); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Podcasts'); ?></dt>
		<dd>
			<?php echo $this->Html->link($podcastEpisode['Podcasts']['name'], array('controller' => 'podcasts', 'action' => 'view', $podcastEpisode['Podcasts']['id'])); ?>
			&nbsp;
		</dd>
		<dt><?php echo __('Songs'); ?></dt>
		<dd>
			<?php echo $this->Html->link($podcastEpisode['Songs']['name'], array('controller' => 'songs', 'action' => 'view', $podcastEpisode['Songs']['id'])); ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php echo __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Podcast Episode'), array('action' => 'edit', $podcastEpisode['PodcastEpisode']['id'])); ?> </li>
		<li><?php echo $this->Form->postLink(__('Delete Podcast Episode'), array('action' => 'delete', $podcastEpisode['PodcastEpisode']['id']), null, __('Are you sure you want to delete # %s?', $podcastEpisode['PodcastEpisode']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcast Episodes'), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcast Episode'), array('action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Podcasts'), array('controller' => 'podcasts', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Podcasts'), array('controller' => 'podcasts', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Songs'), array('controller' => 'songs', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Songs'), array('controller' => 'songs', 'action' => 'add')); ?> </li>
		<li><?php echo $this->Html->link(__('List Users'), array('controller' => 'users', 'action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New User'), array('controller' => 'users', 'action' => 'add')); ?> </li>
	</ul>
</div>
<div class="related">
	<h3><?php echo __('Related Users'); ?></h3>
	<?php if (!empty($podcastEpisode['User'])): ?>
	<table cellpadding = "0" cellspacing = "0">
	<tr>
		<th><?php echo __('Id'); ?></th>
		<th><?php echo __('Name'); ?></th>
		<th><?php echo __('Email'); ?></th>
		<th><?php echo __('Password Hs'); ?></th>
		<th><?php echo __('Password Sl'); ?></th>
		<th><?php echo __('Role Id'); ?></th>
		<th><?php echo __('Created'); ?></th>
		<th><?php echo __('Modified'); ?></th>
		<th class="actions"><?php echo __('Actions'); ?></th>
	</tr>
	<?php
		$i = 0;
		foreach ($podcastEpisode['User'] as $user): ?>
		<tr>
			<td><?php echo $user['id']; ?></td>
			<td><?php echo $user['name']; ?></td>
			<td><?php echo $user['email']; ?></td>
			<td><?php echo $user['password_hs']; ?></td>
			<td><?php echo $user['password_sl']; ?></td>
			<td><?php echo $user['role_id']; ?></td>
			<td><?php echo $user['created']; ?></td>
			<td><?php echo $user['modified']; ?></td>
			<td class="actions">
				<?php echo $this->Html->link(__('View'), array('controller' => 'users', 'action' => 'view', $user['id'])); ?>
				<?php echo $this->Html->link(__('Edit'), array('controller' => 'users', 'action' => 'edit', $user['id'])); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'users', 'action' => 'delete', $user['id']), null, __('Are you sure you want to delete # %s?', $user['id'])); ?>
			</td>
		</tr>
	<?php endforeach; ?>
	</table>
<?php endif; ?>

	<div class="actions">
		<ul>
			<li><?php echo $this->Html->link(__('New User'), array('controller' => 'users', 'action' => 'add')); ?> </li>
		</ul>
	</div>
</div>
