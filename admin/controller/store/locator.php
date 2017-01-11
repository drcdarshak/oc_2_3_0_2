<?php

class ControllerStoreLocator extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('store/locator');
        $this->load->model('store/locator');


        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_store_locator->setStoreData($this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('store/locator', 'token=' . $this->session->data['token'] . $url, true));
        }
        $this->document->setTitle($this->language->get('heading_title'));
        $url = '';
        $getStoreData=$this->model_store_locator->getStoreData();
        $data['store_locator_google_map_api']=$getStoreData['store_locator_google_map_api'];
        
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('store/locator', 'token=' . $this->session->data['token'] . $url, true)
        );

        $data['heading_title'] = $this->language->get('heading_title');
        $data['store_gmap_api_code'] = $this->language->get('store_gmap_api_code');
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['cancel'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'] . $url, true);
        $data['error_warning'] = "";
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }
        $data['token'] = $this->session->data['token'];
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('store/locator', $data));
    }

    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'store/locator')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ((utf8_strlen($this->request->post['store_locator_google_map_api']) < 1)) {
            $this->error['store_locator_google_map_api'] = $this->language->get('error_store_locator_google_map_api');
        }



        return !$this->error;
    }

}
