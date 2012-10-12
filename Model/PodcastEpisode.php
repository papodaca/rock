<?php
App::uses('AppModel', 'Model');
/**
 * PodcastEpisode Model
 *
 * @property Podcasts $Podcasts
 * @property Songs $Songs
 * @property User $User
 */
class PodcastEpisode extends AppModel {

/**
 * Use table
 *
 * @var mixed False or table name
 */
	public $useTable = 'podcast_episode';

/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'podcasts_id' => array(
			'numeric' => array(
				'rule' => array('numeric'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'songs_id' => array(
			'numeric' => array(
				'rule' => array('numeric'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
	);

	//The Associations below have been created with all possible keys, those that are not needed can be removed

/**
 * belongsTo associations
 *
 * @var array
 */
	public $belongsTo = array(
		'Podcasts' => array(
			'className' => 'Podcasts',
			'foreignKey' => 'podcasts_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		),
		'Songs' => array(
			'className' => 'Songs',
			'foreignKey' => 'songs_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		)
	);

/**
 * hasAndBelongsToMany associations
 *
 * @var array
 */
	public $hasAndBelongsToMany = array(
		'User' => array(
			'className' => 'User',
			'joinTable' => 'user_podcast_episodes',
			'foreignKey' => 'podcast_episode_id',
			'associationForeignKey' => 'user_id',
			'unique' => 'keepExisting',
			'conditions' => '',
			'fields' => '',
			'order' => '',
			'limit' => '',
			'offset' => '',
			'finderQuery' => '',
			'deleteQuery' => '',
			'insertQuery' => ''
		)
	);

}
