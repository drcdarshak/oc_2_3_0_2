<?php

class ModelStoreLocator extends Model {

    public function setStoreData($data) {
        $this->db->query("UPDATE `" . DB_PREFIX . "store_locator` SET store_locator_google_map_api = '" . $this->db->escape($data['store_locator_google_map_api']) . "'");
    }
    public function getStoreData() {
        $query=$this->db->query("SELECT * FROM  `" . DB_PREFIX . "store_locator`");
        return $query->row;
    }

}
