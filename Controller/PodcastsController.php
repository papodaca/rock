<?php
App::uses('AppController', 'Controller');
/**
 * Podcasts Controller
 *
 * @property Podcast $Podcast
 * @property RequestHandlerComponent $RequestHandler
 */
class PodcastsController extends AppController {

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
		$this->Podcast->recursive = 0;
		$this->set('podcasts', $this->paginate());
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->Podcast->id = $id;
		if (!$this->Podcast->exists()) {
			throw new NotFoundException(__('Invalid podcast'));
		}
		$this->set('podcast', $this->Podcast->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->Podcast->create();
			if ($this->Podcast->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast could not be saved. Please, try again.'));
			}
		}
		$rocks = $this->Podcast->Rocks->find('list');
		$this->set(compact('rocks'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->Podcast->id = $id;
		if (!$this->Podcast->exists()) {
			throw new NotFoundException(__('Invalid podcast'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Podcast->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Podcast->read(null, $id);
		}
		$rocks = $this->Podcast->Rock->find('list');
		$this->set(compact('rocks'));
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
		$this->Podcast->id = $id;
		if (!$this->Podcast->exists()) {
			throw new NotFoundException(__('Invalid podcast'));
		}
		if ($this->Podcast->delete()) {
			$this->Session->setFlash(__('Podcast deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Podcast was not deleted'));
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
		$this->Podcast->recursive = 0;
		$this->set('podcasts', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->Podcast->id = $id;
		if (!$this->Podcast->exists()) {
			throw new NotFoundException(__('Invalid podcast'));
		}
		$this->set('podcast', $this->Podcast->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->Podcast->create();
			if ($this->Podcast->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast could not be saved. Please, try again.'));
			}
		}
		$rocks = $this->Podcast->Rock->find('list');
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
		$this->Podcast->id = $id;
		if (!$this->Podcast->exists()) {
			throw new NotFoundException(__('Invalid podcast'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Podcast->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Podcast->read(null, $id);
		}
		$rocks = $this->Podcast->Rock->find('list');
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
		$this->Podcast->id = $id;
		if (!$this->Podcast->exists()) {
			throw new NotFoundException(__('Invalid podcast'));
		}
		if ($this->Podcast->delete()) {
			$this->Session->setFlash(__('Podcast deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Podcast was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
