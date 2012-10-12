<?php
App::uses('AppController', 'Controller');
/**
 * Arts Controller
 *
 * @property Art $Art
 * @property RequestHandlerComponent $RequestHandler
 */
class ArtsController extends AppController {

/**
 * Components
 *
 * @var array
 */
	public $components = array('RequestHandler');

/***********************************************************************

							ADMIN

***********************************************************************/
	
/**
 * admin_index method
 *
 * @return void
 */
	public function admin_index() {
		$this->Art->recursive = 0;
		$this->set('arts', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->Art->id = $id;
		if (!$this->Art->exists()) {
			throw new NotFoundException(__('Invalid art'));
		}
		$this->set('art', $this->Art->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->Art->create();
			if ($this->Art->save($this->request->data)) {
				$this->Session->setFlash(__('The art has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The art could not be saved. Please, try again.'));
			}
		}
		$rocks = $this->Art->Rock->find('list');
		$this->set(compact('rocks'));
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->Art->id = $id;
		if (!$this->Art->exists()) {
			throw new NotFoundException(__('Invalid art'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Art->save($this->request->data)) {
				$this->Session->setFlash(__('The art has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The art could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Art->read(null, $id);
		}
		$rocks = $this->Art->Rock->find('list');
		$this->set(compact('rocks'));
	}

/**
 * admin_delete method
 *
 * @throws MethodNotAllowedException
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_delete($id = null) {
		if (!$this->request->is('post')) {
			throw new MethodNotAllowedException();
		}
		$this->Art->id = $id;
		if (!$this->Art->exists()) {
			throw new NotFoundException(__('Invalid art'));
		}
		if ($this->Art->delete()) {
			$this->Session->setFlash(__('Art deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Art was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
