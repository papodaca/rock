<?php
App::uses('AppController', 'Controller');
/**
 * Playlists Controller
 *
 * @property Playlist $Playlist
 */
class PlaylistsController extends AppController {

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->Playlist->recursive = 0;
		$this->set('playlists', $this->paginate());
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->Playlist->id = $id;
		if (!$this->Playlist->exists()) {
			throw new NotFoundException(__('Invalid playlist'));
		}
		$this->set('playlist', $this->Playlist->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->Playlist->create();
			if ($this->Playlist->save($this->request->data)) {
				$this->Session->setFlash(__('The playlist has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The playlist could not be saved. Please, try again.'));
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
		$this->Playlist->id = $id;
		if (!$this->Playlist->exists()) {
			throw new NotFoundException(__('Invalid playlist'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Playlist->save($this->request->data)) {
				$this->Session->setFlash(__('The playlist has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The playlist could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Playlist->read(null, $id);
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
		$this->Playlist->id = $id;
		if (!$this->Playlist->exists()) {
			throw new NotFoundException(__('Invalid playlist'));
		}
		if ($this->Playlist->delete()) {
			$this->Session->setFlash(__('Playlist deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Playlist was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
