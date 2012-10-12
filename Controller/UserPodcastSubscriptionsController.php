<?php
App::uses('AppController', 'Controller');
/**
 * UserPodcastSubscriptions Controller
 *
 * @property UserPodcastSubscription $UserPodcastSubscription
 * @property RequestHandlerComponent $RequestHandler
 */
class UserPodcastSubscriptionsController extends AppController {

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
		$this->UserPodcastSubscription->recursive = 0;
		$this->set('userPodcastSubscriptions', $this->paginate());
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->UserPodcastSubscription->id = $id;
		if (!$this->UserPodcastSubscription->exists()) {
			throw new NotFoundException(__('Invalid user podcast subscription'));
		}
		$this->set('userPodcastSubscription', $this->UserPodcastSubscription->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->UserPodcastSubscription->create();
			if ($this->UserPodcastSubscription->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast subscription has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast subscription could not be saved. Please, try again.'));
			}
		}
		$users = $this->UserPodcastSubscription->User->find('list');
		$podcasts = $this->UserPodcastSubscription->Podcast->find('list');
		$this->set(compact('users', 'podcasts'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->UserPodcastSubscription->id = $id;
		if (!$this->UserPodcastSubscription->exists()) {
			throw new NotFoundException(__('Invalid user podcast subscription'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->UserPodcastSubscription->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast subscription has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast subscription could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->UserPodcastSubscription->read(null, $id);
		}
		$users = $this->UserPodcastSubscription->User->find('list');
		$podcasts = $this->UserPodcastSubscription->Podcast->find('list');
		$this->set(compact('users', 'podcasts'));
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
		$this->UserPodcastSubscription->id = $id;
		if (!$this->UserPodcastSubscription->exists()) {
			throw new NotFoundException(__('Invalid user podcast subscription'));
		}
		if ($this->UserPodcastSubscription->delete()) {
			$this->Session->setFlash(__('User podcast subscription deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('User podcast subscription was not deleted'));
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
		$this->UserPodcastSubscription->recursive = 0;
		$this->set('userPodcastSubscriptions', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->UserPodcastSubscription->id = $id;
		if (!$this->UserPodcastSubscription->exists()) {
			throw new NotFoundException(__('Invalid user podcast subscription'));
		}
		$this->set('userPodcastSubscription', $this->UserPodcastSubscription->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->UserPodcastSubscription->create();
			if ($this->UserPodcastSubscription->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast subscription has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast subscription could not be saved. Please, try again.'));
			}
		}
		$users = $this->UserPodcastSubscription->User->find('list');
		$podcasts = $this->UserPodcastSubscription->Podcast->find('list');
		$this->set(compact('users', 'podcasts'));
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->UserPodcastSubscription->id = $id;
		if (!$this->UserPodcastSubscription->exists()) {
			throw new NotFoundException(__('Invalid user podcast subscription'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->UserPodcastSubscription->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast subscription has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast subscription could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->UserPodcastSubscription->read(null, $id);
		}
		$users = $this->UserPodcastSubscription->User->find('list');
		$podcasts = $this->UserPodcastSubscription->Podcast->find('list');
		$this->set(compact('users', 'podcasts'));
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
		$this->UserPodcastSubscription->id = $id;
		if (!$this->UserPodcastSubscription->exists()) {
			throw new NotFoundException(__('Invalid user podcast subscription'));
		}
		if ($this->UserPodcastSubscription->delete()) {
			$this->Session->setFlash(__('User podcast subscription deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('User podcast subscription was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
