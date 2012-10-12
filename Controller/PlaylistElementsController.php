<?php
App::uses('AppController', 'Controller');
/**
 * PlaylistElements Controller
 *
 * @property PlaylistElement $PlaylistElement
 * @property RequestHandlerComponent $RequestHandler
 */
class PlaylistElementsController extends AppController {

/**
 * Components
 *
 * @var array
 */
	public $components = array('RequestHandler');

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->PlaylistElement->id = $id;
		if (!$this->PlaylistElement->exists()) {
			throw new NotFoundException(__('Invalid playlist element'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->PlaylistElement->save($this->request->data)) {
				$this->Session->setFlash(__('The playlist element has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The playlist element could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->PlaylistElement->read(null, $id);
		}
		$playlists = $this->PlaylistElement->Playlist->find('list');
		$songs = $this->PlaylistElement->Song->find('list');
		$this->set(compact('playlists', 'songs'));
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
		$this->PlaylistElement->id = $id;
		if (!$this->PlaylistElement->exists()) {
			throw new NotFoundException(__('Invalid playlist element'));
		}
		if ($this->PlaylistElement->delete()) {
			$this->Session->setFlash(__('Playlist element deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Playlist element was not deleted'));
		$this->redirect(array('action' => 'index'));
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
		$this->PlaylistElement->recursive = 0;
		$this->set('playlistElements', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->PlaylistElement->id = $id;
		if (!$this->PlaylistElement->exists()) {
			throw new NotFoundException(__('Invalid playlist element'));
		}
		$this->set('playlistElement', $this->PlaylistElement->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->PlaylistElement->create();
			if ($this->PlaylistElement->save($this->request->data)) {
				$this->Session->setFlash(__('The playlist element has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The playlist element could not be saved. Please, try again.'));
			}
		}
		$playlists = $this->PlaylistElement->Playlist->find('list');
		$songs = $this->PlaylistElement->Song->find('list');
		$this->set(compact('playlists', 'songs'));
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->PlaylistElement->id = $id;
		if (!$this->PlaylistElement->exists()) {
			throw new NotFoundException(__('Invalid playlist element'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->PlaylistElement->save($this->request->data)) {
				$this->Session->setFlash(__('The playlist element has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The playlist element could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->PlaylistElement->read(null, $id);
		}
		$playlists = $this->PlaylistElement->Playlist->find('list');
		$songs = $this->PlaylistElement->Song->find('list');
		$this->set(compact('playlists', 'songs'));
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
		$this->PlaylistElement->id = $id;
		if (!$this->PlaylistElement->exists()) {
			throw new NotFoundException(__('Invalid playlist element'));
		}
		if ($this->PlaylistElement->delete()) {
			$this->Session->setFlash(__('Playlist element deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Playlist element was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
