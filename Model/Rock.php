<?php
App::uses('AppModel', 'Model');
/**
 * Rock Model
 *
 * @property MType $MType
 */
class Rock extends AppModel {

/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'm_type_id' => array(
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

/**
 * belongsTo associations
 *
 * @var array
 */
	public $belongsTo = array(
		'MType' => array(
			'className' => 'MType',
			'foreignKey' => 'm_type_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		)
	);
}
