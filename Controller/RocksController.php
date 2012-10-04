<?php
App::uses('AppController', 'Controller');
/**
 * Rocks Controller
 *
 * @property Rock $Rock
 */
class RocksController extends AppController {

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->Rock->recursive = 0;
		$this->set('rocks', $this->paginate());
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->Rock->id = $id;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
		$this->set('rock', $this->Rock->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->Rock->create();
			if ($this->Rock->save($this->request->data)) {
				$this->Session->setFlash(__('The rock has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The rock could not be saved. Please, try again.'));
			}
		}
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->Rock->id = $id;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Rock->save($this->request->data)) {
				$this->Session->setFlash(__('The rock has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The rock could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Rock->read(null, $id);
		}
	}

/**
 * delete method
 *
 * @throws MethodNotAllowedException
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function delete($id = null) {
		if (!$this->request->is('post')) {
			throw new MethodNotAllowedException();
		}
		$this->Rock->id = $id;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
		if ($this->Rock->delete()) {
			$this->Session->setFlash(__('Rock deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Rock was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
