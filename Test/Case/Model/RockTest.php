<?php
App::uses('Rock', 'Model');

/**
 * Rock Test Case
 *
 */
class RockTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.rock',
		'app.mime_type'
	);

/**
 * setUp method
 *
 * @return void
 */
	public function setUp() {
		parent::setUp();
		$this->Rock = ClassRegistry::init('Rock');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->Rock);

		parent::tearDown();
	}

}
