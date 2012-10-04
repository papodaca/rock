<?php
/**
 * PlaylistElementFixture
 *
 */
class PlaylistElementFixture extends CakeTestFixture {

/**
 * Fields
 *
 * @var array
 */
	public $fields = array(
		'id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'primary'),
		'playlist_id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'index'),
		'song_id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'index'),
		'order_nr' => array('type' => 'integer', 'null' => false, 'default' => null),
		'created' => array('type' => 'datetime', 'null' => false, 'default' => null),
		'modified' => array('type' => 'datetime', 'null' => false, 'default' => null),
		'indexes' => array(
			'PRIMARY' => array('column' => 'id', 'unique' => 1),
			'id_UNIQUE' => array('column' => 'id', 'unique' => 1),
			'fk_Playlist_has_Song_Song1' => array('column' => 'song_id', 'unique' => 0),
			'fk_Playlist_has_Song_Playlist1' => array('column' => 'playlist_id', 'unique' => 0)
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
			'playlist_id' => 1,
			'song_id' => 1,
			'order_nr' => 1,
			'created' => '2012-10-04 07:46:55',
			'modified' => '2012-10-04 07:46:55'
		),
	);

}
