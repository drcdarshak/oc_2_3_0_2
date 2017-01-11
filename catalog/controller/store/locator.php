<?php

class ControllerStoreLocator extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('store/locator');
        $this->load->model('store/locator');
        $getStoreData=$this->model_store_locator->getStoreData();
        $data['getAllStoreList']=$this->model_store_locator->getAllStoreList();
        
        $data['store_locator_google_map_api']=$getStoreData['store_locator_google_map_api'];
        $data['heading_title'] = $this->language->get('heading_title');
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('store/locator')
        );


        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('store/locator', $data));
    }

}
