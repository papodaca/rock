<?php
App::uses('AppModel', 'Model');
/**
 * Art Model
 *
 * @property Rock $Rock
 * @property Album $Album
 * @property Artist $Artist
 */
class Art extends AppModel {

/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'rock_id' => array(
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
		'Rock' => array(
			'className' => 'Rock',
			'foreignKey' => 'rock_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		)
	);

/**
 * hasMany associations
 *
 * @var array
 */
	public $hasMany = array(
		'Album' => array(
			'className' => 'Album',
			'foreignKey' => 'art_id',
			'dependent' => false,
			'conditions' => '',
			'fields' => '',
			'order' => '',
			'limit' => '',
			'offset' => '',
			'exclusive' => '',
			'finderQuery' => '',
			'counterQuery' => ''
		),
		'Artist' => array(
			'className' => 'Artist',
			'foreignKey' => 'art_id',
			'dependent' => false,
			'conditions' => '',
			'fields' => '',
			'order' => '',
			'limit' => '',
			'offset' => '',
			'exclusive' => '',
			'finderQuery' => '',
			'counterQuery' => ''
		)
	);

}
