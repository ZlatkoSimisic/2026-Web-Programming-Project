<?php
require_once __DIR__ . '/BaseDao.php';

class CartItemDao extends BaseDao
{
    public function __construct()
    {
        parent::__construct('cart_items', ['user_id', 'product_id', 'quantity']);
    }

    /** Cart of one user with product name and price. */
    public function get_by_user($user_id)
    {
        return $this->query(
            "SELECT c.*, p.name AS product_name, p.price, p.image_url
             FROM cart_items c
             JOIN products p ON p.id = c.product_id
             WHERE c.user_id = :user_id
             ORDER BY c.id",
            ['user_id' => $user_id]
        );
    }
}
