<?php
App::uses('Song', 'Model');

/**
 * Song Test Case
 *
 */
class SongTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.song',
		'app.album',
		'app.art',
		'app.rock',
		'app.artist',
		'app.genre',
		'app.song_format',
		'app.playlist_element',
		'app.playlist'
	);

/**
 * setUp method
 *
 * @return void
 */
	public function setUp() {
		parent::setUp();
		$this->Song = ClassRegistry::init('Song');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->Song);

		parent::tearDown();
	}

}
