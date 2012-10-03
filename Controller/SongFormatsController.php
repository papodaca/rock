<?php
App::uses('AppController', 'Controller');
/**
 * SongFormats Controller
 *
 * @property SongFormat $SongFormat
 */
class SongFormatsController extends AppController {

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->SongFormat->recursive = 0;
		$this->set('songFormats', $this->paginate());
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->SongFormat->id = $id;
		if (!$this->SongFormat->exists()) {
			throw new NotFoundException(__('Invalid song format'));
		}
		$this->set('songFormat', $this->SongFormat->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->SongFormat->create();
			if ($this->SongFormat->save($this->request->data)) {
				$this->Session->setFlash(__('The song format has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The song format could not be saved. Please, try again.'));
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
		$this->SongFormat->id = $id;
		if (!$this->SongFormat->exists()) {
			throw new NotFoundException(__('Invalid song format'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->SongFormat->save($this->request->data)) {
				$this->Session->setFlash(__('The song format has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The song format could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->SongFormat->read(null, $id);
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
		$this->SongFormat->id = $id;
		if (!$this->SongFormat->exists()) {
			throw new NotFoundException(__('Invalid song format'));
		}
		if ($this->SongFormat->delete()) {
			$this->Session->setFlash(__('Song format deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Song format was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
