<?php
/**
 * RockFixture
 *
 */
class RockFixture extends CakeTestFixture {

/**
 * Fields
 *
 * @var array
 */
	public $fields = array(
		'id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'primary'),
		'system_path' => array('type' => 'string', 'null' => true, 'default' => null, 'length' => 4096, 'collate' => 'utf8_general_ci', 'charset' => 'utf8'),
		'remote_path' => array('type' => 'string', 'null' => true, 'default' => null, 'length' => 2048, 'collate' => 'utf8_general_ci', 'charset' => 'utf8'),
		'm_type_id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'index'),
		'created' => array('type' => 'datetime', 'null' => false, 'default' => null),
		'modified' => array('type' => 'datetime', 'null' => false, 'default' => null),
		'indexes' => array(
			'PRIMARY' => array('column' => 'id', 'unique' => 1),
			'id_UNIQUE' => array('column' => 'id', 'unique' => 1),
			'fk_rocks_mime_types1' => array('column' => 'm_type_id', 'unique' => 0)
		),
		'tableParameters' => array('charset' => 'utf8', 'collate' => 'utf8_general_ci', 'engine' => 'InnoDB')
	);

/**
 * Records
 *
 * @var array
 */
	public $records = array(
		array(
			'id' => 1,
			'system_path' => 'Lorem ipsum dolor sit amet',
			'remote_path' => 'Lorem ipsum dolor sit amet',
			'm_type_id' => 1,
			'created' => '2012-10-05 07:53:27',
			'modified' => '2012-10-05 07:53:27'
		),
	);

}
