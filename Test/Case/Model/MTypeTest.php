<?php
App::uses('MType', 'Model');

/**
 * MType Test Case
 *
 */
class MTypeTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.m_type',
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
		$this->MType = ClassRegistry::init('MType');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->MType);

		parent::tearDown();
	}

}
