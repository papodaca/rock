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
		'app.song'
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
