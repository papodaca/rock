<?php
App::uses('AppController', 'Controller');
/**
 * Genres Controller
 *
 * @property Genre $Genre
 */
class GenresController extends AppController {

    public $components = array('RequestHandler');

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->Genre->recursive = 0;
		$this->set('genres', $this->paginate());
		$this->set('_serialize', 'genres');
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->Genre->id = $id;
		if (!$this->Genre->exists()) {
			throw new NotFoundException(__('Invalid genre'));
		}
		$this->set('genre', $this->Genre->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
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
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
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
