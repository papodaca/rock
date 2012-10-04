<?php
/**
 * SongFixture
 *
 */
class SongFixture extends CakeTestFixture {

/**
 * Fields
 *
 * @var array
 */
	public $fields = array(
		'id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'primary'),
		'name' => array('type' => 'string', 'null' => true, 'default' => null, 'length' => 60, 'collate' => 'utf8_general_ci', 'charset' => 'utf8'),
		'track_nr' => array('type' => 'integer', 'null' => true, 'default' => null),
		'disk_nr' => array('type' => 'integer', 'null' => true, 'default' => null),
		'album_id' => array('type' => 'integer', 'null' => true, 'default' => null, 'key' => 'index'),
		'genre_id' => array('type' => 'integer', 'null' => true, 'default' => null, 'key' => 'index'),
		'artist_id' => array('type' => 'integer', 'null' => true, 'default' => null, 'key' => 'index'),
		'song_format_id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'index'),
		'rock_id' => array('type' => 'integer', 'null' => false, 'default' => null, 'key' => 'index'),
		'length_sec' => array('type' => 'integer', 'null' => false, 'default' => null),
		'created' => array('type' => 'datetime', 'null' => false, 'default' => null),
		'modified' => array('type' => 'datetime', 'null' => false, 'default' => null),
		'indexes' => array(
			'PRIMARY' => array('column' => 'id', 'unique' => 1),
			'id_UNIQUE' => array('column' => 'id', 'unique' => 1),
			'fk_Song_Album' => array('column' => 'album_id', 'unique' => 0),
			'fk_Song_Genre1' => array('column' => 'genre_id', 'unique' => 0),
			'fk_Song_Artist1' => array('column' => 'artist_id', 'unique' => 0),
			'fk_Song_SongFormat1' => array('column' => 'song_format_id', 'unique' => 0),
			'fk_Song_Path1' => array('column' => 'rock_id', 'unique' => 0)
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
			'name' => 'Lorem ipsum dolor sit amet',
			'track_nr' => 1,
			'disk_nr' => 1,
			'album_id' => 1,
			'genre_id' => 1,
			'artist_id' => 1,
			'song_format_id' => 1,
			'rock_id' => 1,
			'length_sec' => 1,
			'created' => '2012-10-04 07:46:56',
			'modified' => '2012-10-04 07:46:56'
		),
	);

}
