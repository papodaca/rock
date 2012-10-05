<?php
App::uses('Genre', 'Model');

/**
 * Genre Test Case
 *
 */
class GenreTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.genre',
		'app.song',
		'app.album',
		'app.art',
		'app.rock',
		'app.mime_type',
		'app.artist',
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
		$this->Genre = ClassRegistry::init('Genre');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->Genre);

		parent::tearDown();
	}

}
