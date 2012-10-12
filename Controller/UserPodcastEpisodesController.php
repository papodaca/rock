<?php
App::uses('AppController', 'Controller');
/**
 * UserPodcastEpisodes Controller
 *
 * @property UserPodcastEpisode $UserPodcastEpisode
 * @property RequestHandlerComponent $RequestHandler
 */
class UserPodcastEpisodesController extends AppController {

/**
 * Components
 *
 * @var array
 */
	public $components = array('RequestHandler');

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->UserPodcastEpisode->id = $id;
		if (!$this->UserPodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid user podcast episode'));
		}
		$this->set('userPodcastEpisode', $this->UserPodcastEpisode->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->UserPodcastEpisode->create();
			if ($this->UserPodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast episode could not be saved. Please, try again.'));
			}
		}
		$users = $this->UserPodcastEpisode->User->find('list');
		$podcastEpisodes = $this->UserPodcastEpisode->PodcastEpisode->find('list');
		$this->set(compact('users', 'podcastEpisodes'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->UserPodcastEpisode->id = $id;
		if (!$this->UserPodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid user podcast episode'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->UserPodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast episode could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->UserPodcastEpisode->read(null, $id);
		}
		$users = $this->UserPodcastEpisode->User->find('list');
		$podcastEpisodes = $this->UserPodcastEpisode->PodcastEpisode->find('list');
		$this->set(compact('users', 'podcastEpisodes'));
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
		$this->UserPodcastEpisode->id = $id;
		if (!$this->UserPodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid user podcast episode'));
		}
		if ($this->UserPodcastEpisode->delete()) {
			$this->Session->setFlash(__('User podcast episode deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('User podcast episode was not deleted'));
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
		$this->UserPodcastEpisode->recursive = 0;
		$this->set('userPodcastEpisodes', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->UserPodcastEpisode->id = $id;
		if (!$this->UserPodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid user podcast episode'));
		}
		$this->set('userPodcastEpisode', $this->UserPodcastEpisode->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->UserPodcastEpisode->create();
			if ($this->UserPodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast episode could not be saved. Please, try again.'));
			}
		}
		$users = $this->UserPodcastEpisode->User->find('list');
		$podcastEpisodes = $this->UserPodcastEpisode->PodcastEpisode->find('list');
		$this->set(compact('users', 'podcastEpisodes'));
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->UserPodcastEpisode->id = $id;
		if (!$this->UserPodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid user podcast episode'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->UserPodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The user podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user podcast episode could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->UserPodcastEpisode->read(null, $id);
		}
		$users = $this->UserPodcastEpisode->User->find('list');
		$podcastEpisodes = $this->UserPodcastEpisode->PodcastEpisode->find('list');
		$this->set(compact('users', 'podcastEpisodes'));
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
		$this->UserPodcastEpisode->id = $id;
		if (!$this->UserPodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid user podcast episode'));
		}
		if ($this->UserPodcastEpisode->delete()) {
			$this->Session->setFlash(__('User podcast episode deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('User podcast episode was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
