<?php
App::uses('PlaylistElement', 'Model');

/**
 * PlaylistElement Test Case
 *
 */
class PlaylistElementTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.playlist_element',
		'app.playlist',
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
		$this->PlaylistElement = ClassRegistry::init('PlaylistElement');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->PlaylistElement);

		parent::tearDown();
	}

}
