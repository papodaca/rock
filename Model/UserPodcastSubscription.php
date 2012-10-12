<?php
App::uses('AppModel', 'Model');
/**
 * UserPodcastSubscription Model
 *
 * @property Users $Users
 * @property Podcasts $Podcasts
 */
class UserPodcastSubscription extends AppModel {

/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'users_id' => array(
			'numeric' => array(
				'rule' => array('numeric'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
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
	);

	//The Associations below have been created with all possible keys, those that are not needed can be removed

/**
 * belongsTo associations
 *
 * @var array
 */
	public $belongsTo = array(
		'Users' => array(
			'className' => 'Users',
			'foreignKey' => 'users_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		),
		'Podcasts' => array(
			'className' => 'Podcasts',
			'foreignKey' => 'podcasts_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		)
	);
}
