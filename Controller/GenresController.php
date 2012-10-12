<?php
App::uses('AppController', 'Controller');
/**
 * Genres Controller
 *
 * @property Genre $Genre
 * @property RequestHandlerComponent $RequestHandler
 */
class GenresController extends AppController {

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
		$this->Genre->recursive = 0;
		$this->set('genres', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->Genre->id = $id;
		if (!$this->Genre->exists()) {
			throw new NotFoundException(__('Invalid genre'));
		}
		$this->set('genre', $this->Genre->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->Genre->create();
			if ($this->Genre->save($this->request->data)) {
				$this->Session->setFlash(__('The genre has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The genre could not be saved. Please, try again.'));
			}
		}
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->Genre->id = $id;
		if (!$this->Genre->exists()) {
			throw new NotFoundException(__('Invalid genre'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Genre->save($this->request->data)) {
				$this->Session->setFlash(__('The genre has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The genre could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Genre->read(null, $id);
		}
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
		$this->Genre->id = $id;
		if (!$this->Genre->exists()) {
			throw new NotFoundException(__('Invalid genre'));
		}
		if ($this->Genre->delete()) {
			$this->Session->setFlash(__('Genre deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Genre was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
