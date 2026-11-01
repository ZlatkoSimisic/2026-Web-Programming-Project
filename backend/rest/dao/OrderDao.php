<?php
require_once __DIR__ . '/BaseDao.php';

class OrderDao extends BaseDao
{
    public function __construct()
    {
        parent::__construct('orders', ['user_id', 'status', 'shipping_address']);
    }

    public function get_by_user($user_id)
    {
        return $this->query("SELECT * FROM orders WHERE user_id = :user_id ORDER BY id DESC", ['user_id' => $user_id]);
    }

    /** Number of orders per status (for the admin dashboard). */
    public function count_per_status()
    {
        return $this->query(
            "SELECT status, COUNT(id) AS total
             FROM orders
             GROUP BY status
             ORDER BY status"
        );
    }
}
