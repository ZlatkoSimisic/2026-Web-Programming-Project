<?php
require_once __DIR__ . '/BaseDao.php';

class ReviewDao extends BaseDao
{
    public function __construct()
    {
        parent::__construct('reviews', ['product_id', 'user_id', 'comment']);
    }

    /** Reviews of one product with the name of the user who wrote them. */
    public function get_by_product($product_id)
    {
        return $this->query(
            "SELECT r.*, u.first_name, u.last_name
             FROM reviews r
             JOIN users u ON u.id = r.user_id
             WHERE r.product_id = :product_id
             ORDER BY r.id DESC",
            ['product_id' => $product_id]
        );
    }

    /** Number of reviews per product -- LEFT JOIN keeps products without reviews (total 0). */
    public function count_per_product()
    {
        return $this->query(
            "SELECT p.name AS product, COUNT(r.id) AS total
             FROM products p
             LEFT JOIN reviews r ON r.product_id = p.id
             GROUP BY p.id, p.name
             ORDER BY p.id"
        );
    }
}
