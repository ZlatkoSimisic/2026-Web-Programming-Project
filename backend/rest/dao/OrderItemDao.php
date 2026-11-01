<?php
require_once __DIR__ . '/BaseDao.php';

class OrderItemDao extends BaseDao
{
    public function __construct()
    {
        parent::__construct('order_items', ['order_id', 'product_id', 'quantity']);
    }

    /** Items of one order with product name and price. */
    public function get_by_order($order_id)
    {
        return $this->query(
            "SELECT oi.*, p.name AS product_name, p.price
             FROM order_items oi
             JOIN products p ON p.id = oi.product_id
             WHERE oi.order_id = :order_id
             ORDER BY oi.id",
            ['order_id' => $order_id]
        );
    }
}
