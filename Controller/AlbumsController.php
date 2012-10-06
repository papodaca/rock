<?php
App::uses('AppController', 'Controller');
/**
 * Albums Controller
 *
 * @property Album $Album
 */
class AlbumsController extends AppController {

    public $components = array('RequestHandler');

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->Album->recursive = 0;
		$this->set('albums', $this->paginate());
        $this->set('_serialize', 'albums');
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->Album->id = $id;
		if (!$this->Album->exists()) {
			throw new NotFoundException(__('Invalid album'));
		}
		$this->set('album', $this->Album->read(null, $id));
        $this->set('_serialize', 'album');
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->Album->create();
			if ($this->Album->save($this->request->data)) {
				$this->Session->setFlash(__('The album has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The album could not be saved. Please, try again.'));
			}
		}
		$arts = $this->Album->Art->find('list');
		$artists = $this->Album->Artist->find('list');
		$this->set(compact('arts', 'artists'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->Album->id = $id;
		if (!$this->Album->exists()) {
			throw new NotFoundException(__('Invalid album'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Album->save($this->request->data)) {
				$this->Session->setFlash(__('The album has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The album could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Album->read(null, $id);
		}
		$arts = $this->Album->Art->find('list');
		$artists = $this->Album->Artist->find('list');
		$this->set(compact('arts', 'artists'));
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
		$this->Album->id = $id;
		if (!$this->Album->exists()) {
			throw new NotFoundException(__('Invalid album'));
		}
		if ($this->Album->delete()) {
			$this->Session->setFlash(__('Album deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Album was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
