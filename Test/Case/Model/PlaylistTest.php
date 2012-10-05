<?php
App::uses('Playlist', 'Model');

/**
 * Playlist Test Case
 *
 */
class PlaylistTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.playlist',
		'app.playlist_element',
		'app.song',
		'app.album',
		'app.art',
		'app.rock',
		'app.mime_type',
		'app.artist',
		'app.genre'
	);

/**
 * setUp method
 *
 * @return void
 */
	public function setUp() {
		parent::setUp();
		$this->Playlist = ClassRegistry::init('Playlist');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->Playlist);

		parent::tearDown();
	}

}
