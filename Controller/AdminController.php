<?php
App::uses('AppController', 'Controller');
/**
 * Albums Controller
 *
 * @property Album $Album
 */
class AdminController extends AppController {

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->layout = 'admin';
		//authenticate?
	}
}
