<?php
App::uses('SongFormat', 'Model');

/**
 * SongFormat Test Case
 *
 */
class SongFormatTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.song_format',
		'app.song'
	);

/**
 * setUp method
 *
 * @return void
 */
	public function setUp() {
		parent::setUp();
		$this->SongFormat = ClassRegistry::init('SongFormat');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->SongFormat);

		parent::tearDown();
	}

}
