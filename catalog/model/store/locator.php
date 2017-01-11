<?php

class ModelStoreLocator extends Model {

    public function getStoreData() {
        $query = $this->db->query("SELECT * FROM  `" . DB_PREFIX . "store_locator`");
        return $query->row;
    }
    public function getAllStoreList(){
        $query=$this->db->query("SELECT * FROM ".DB_PREFIX."location");
         return $query->rows;
    }

}

?>
