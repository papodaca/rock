<?php
App::uses('AppController', 'Controller');
/**
 * PodcastEpisodes Controller
 *
 * @property PodcastEpisode $PodcastEpisode
 * @property RequestHandlerComponent $RequestHandler
 */
class PodcastEpisodesController extends AppController {

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
		$this->PodcastEpisode->recursive = 0;
		$this->set('podcastEpisodes', $this->paginate());
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->PodcastEpisode->id = $id;
		if (!$this->PodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid podcast episode'));
		}
		$this->set('podcastEpisode', $this->PodcastEpisode->read(null, $id));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->PodcastEpisode->create();
			if ($this->PodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast episode could not be saved. Please, try again.'));
			}
		}
		$podcasts = $this->PodcastEpisode->Podcast->find('list');
		$songs = $this->PodcastEpisode->Song->find('list');
		$users = $this->PodcastEpisode->User->find('list');
		$this->set(compact('podcasts', 'songs', 'users'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->PodcastEpisode->id = $id;
		if (!$this->PodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid podcast episode'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->PodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast episode could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->PodcastEpisode->read(null, $id);
		}
		$podcasts = $this->PodcastEpisode->Podcast->find('list');
		$songs = $this->PodcastEpisode->Song->find('list');
		$users = $this->PodcastEpisode->User->find('list');
		$this->set(compact('podcasts', 'songs', 'users'));
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
		$this->PodcastEpisode->id = $id;
		if (!$this->PodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid podcast episode'));
		}
		if ($this->PodcastEpisode->delete()) {
			$this->Session->setFlash(__('Podcast episode deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Podcast episode was not deleted'));
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
		$this->PodcastEpisode->recursive = 0;
		$this->set('podcastEpisodes', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->PodcastEpisode->id = $id;
		if (!$this->PodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid podcast episode'));
		}
		$this->set('podcastEpisode', $this->PodcastEpisode->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->PodcastEpisode->create();
			if ($this->PodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast episode could not be saved. Please, try again.'));
			}
		}
		$podcasts = $this->PodcastEpisode->Podcast->find('list');
		$songs = $this->PodcastEpisode->Song->find('list');
		$users = $this->PodcastEpisode->User->find('list');
		$this->set(compact('podcasts', 'songs', 'users'));
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->PodcastEpisode->id = $id;
		if (!$this->PodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid podcast episode'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->PodcastEpisode->save($this->request->data)) {
				$this->Session->setFlash(__('The podcast episode has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The podcast episode could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->PodcastEpisode->read(null, $id);
		}
		$podcasts = $this->PodcastEpisode->Podcast->find('list');
		$songs = $this->PodcastEpisode->Song->find('list');
		$users = $this->PodcastEpisode->User->find('list');
		$this->set(compact('podcasts', 'songs', 'users'));
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
		$this->PodcastEpisode->id = $id;
		if (!$this->PodcastEpisode->exists()) {
			throw new NotFoundException(__('Invalid podcast episode'));
		}
		if ($this->PodcastEpisode->delete()) {
			$this->Session->setFlash(__('Podcast episode deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Podcast episode was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
