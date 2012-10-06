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
}
