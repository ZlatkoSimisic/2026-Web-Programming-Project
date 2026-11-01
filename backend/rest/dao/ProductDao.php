<?php
require_once __DIR__ . '/BaseDao.php';

class ProductDao extends BaseDao
{
    public function __construct()
    {
        parent::__construct('products', ['name', 'description', 'price', 'image_url']);
    }

    public function search_by_name($name)
    {
        return $this->query("SELECT * FROM products WHERE name LIKE :name ORDER BY name", ['name' => '%' . $name . '%']);
    }
}
