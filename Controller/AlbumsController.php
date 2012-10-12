<?php
App::uses('AppController', 'Controller');
/**
 * Albums Controller
 *
 * @property Album $Album
 * @property RequestHandlerComponent $RequestHanlder
 */
class AlbumsController extends AppController {

/**
 * Components
 *
 * @var array
 */
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

/***********************************************************************

							ADMIN

***********************************************************************/
	
/**
 * admin_index method
 *
 * @return void
 */
	public function admin_index() {
		$this->Album->recursive = 0;
		$this->set('albums', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->Album->id = $id;
		if (!$this->Album->exists()) {
			throw new NotFoundException(__('Invalid album'));
		}
		$this->set('album', $this->Album->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
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
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
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
