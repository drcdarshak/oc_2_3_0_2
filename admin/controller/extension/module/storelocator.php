<?php
class ControllerExtensionModuleStorelocater extends Controller {
	private $error = array();

	public function index() {
		echo "hello";
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/affiliate')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}