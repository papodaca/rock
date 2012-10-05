<?php
App::uses('AppController', 'Controller');
/**
 * Rocks Controller
 *
 * @property Rock $Rock
 */
class RocksController extends AppController {

    public $components = array('RequestHandler');

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$this->Rock->recursive = 0;
		$this->set('rocks', $this->paginate());
        $this->set('_serialize','rocks');
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		$this->Rock->id = $id;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
		$this->set('rock', $this->Rock->read(null, $id));
        $this->set('_serialize','rock');
	}

 /**
 * get method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function get($id = null) {
		$this->Rock->id = $id;
        $this->Rock->recursive = 1;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
        $thisRock = $this->Rock->findById($id);

        if($thisRock["Rock"]["system_path"] == "" and $thisRock["Rock"]["remote_path"] == "") {
            throw new NotFoundException(__('Invalid rock'));
        } elseif($thisRock["Rock"]["system_path"] == "" and $thisRock["Rock"]["remote_path"] != "") {
            //this is a remote resource -> redirection works!
            $this->redirect($thisRock["Rock"]["remote_path"]);
        } else {

            $path = explode(DS, $thisRock["Rock"]["system_path"]);
	        $finalPath = "";

            for($i=0; $i<count($path)-1; $i++) {
	            $finalPath = $finalPath . $path[$i] . DS;
            }

            $fileName = explode(".", $path[count($path)-1]);
            $name = $fileName[0];
            $extension =$fileName[1];

            $this->viewClass = 'Media';

            $params = array(
                'id'        => $name . "." . $extension,
                'name'      => trim(" ", $name),
                'download'  => false,
                'extension' => $thisRock["MType"]["extension"],
                'mimeType'  => array(
                    $thisRock["MType"]["extension"] => $thisRock["MType"]["type"]
                ),
                'path'      => $finalPath
            );
            $this->set($params);
        }
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if ($this->request->is('post')) {
			$this->Rock->create();
			if ($this->Rock->save($this->request->data)) {
				$this->Session->setFlash(__('The rock has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The rock could not be saved. Please, try again.'));
			}
		}
		$mTypes = $this->Rock->MType->find('list');
		$this->set(compact('mTypes'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {
		$this->Rock->id = $id;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->Rock->save($this->request->data)) {
				$this->Session->setFlash(__('The rock has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The rock could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->Rock->read(null, $id);
		}
		$mTypes = $this->Rock->MType->find('list');
		$this->set(compact('mTypes'));
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
		$this->Rock->id = $id;
		if (!$this->Rock->exists()) {
			throw new NotFoundException(__('Invalid rock'));
		}
		if ($this->Rock->delete()) {
			$this->Session->setFlash(__('Rock deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('Rock was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
