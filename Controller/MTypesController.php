<?php
App::uses('AppController', 'Controller');
/**
 * MTypes Controller
 *
 * @property MType $MType
 * @property RequestHandlerComponent $RequestHandler
 */
class MTypesController extends AppController {

/**
 * Components
 *
 * @var array
 */
	public $components = array('RequestHandler');

/***********************************************************************

							ADMIN

***********************************************************************/

    public $paginate = array(
            'limit' => 20
        );	

/**
 * admin_index method
 *
 * @return void
 */
	public function admin_index($Limit = null) {
        if($Limit != null) {
            $paginate['limit'] = $Limit;
        }

		$this->MType->recursive = 0;
		$this->set('mTypes', $this->paginate());
	}

/**
 * admin_view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_view($id = null) {
		$this->MType->id = $id;
		if (!$this->MType->exists()) {
			throw new NotFoundException(__('Invalid m type'));
		}
		$this->set('mType', $this->MType->read(null, $id));
	}

/**
 * admin_add method
 *
 * @return void
 */
	public function admin_add() {
		if ($this->request->is('post')) {
			$this->MType->create();
			if ($this->MType->save($this->request->data)) {
				$this->Session->setFlash(__('The m type has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The m type could not be saved. Please, try again.'));
			}
		}
	}

/**
 * admin_edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function admin_edit($id = null) {
		$this->MType->id = $id;
		if (!$this->MType->exists()) {
			throw new NotFoundException(__('Invalid m type'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->MType->save($this->request->data)) {
				$this->Session->setFlash(__('The m type has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The m type could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->MType->read(null, $id);
		}
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
		$this->MType->id = $id;
		if (!$this->MType->exists()) {
			throw new NotFoundException(__('Invalid m type'));
		}
		if ($this->MType->delete()) {
			$this->Session->setFlash(__('M type deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('M type was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
}
