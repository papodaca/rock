<?php
App::uses('Art', 'Model');

/**
 * Art Test Case
 *
 */
class ArtTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.art',
		'app.rock',
		'app.album',
		'app.artist',
		'app.song'
	);

/**
 * setUp method
 *
 * @return void
 */
	public function setUp() {
		parent::setUp();
		$this->Art = ClassRegistry::init('Art');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->Art);

		parent::tearDown();
	}

}
