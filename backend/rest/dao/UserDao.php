<?php
require_once __DIR__ . '/BaseDao.php';

class UserDao extends BaseDao
{
    /** Never SELECT the password hash unless we really need it (login). */
    private const PUBLIC_COLUMNS = "id, first_name, last_name, email, role";

    public function __construct()
    {
        parent::__construct('users', ['first_name', 'last_name', 'email', 'password_hash', 'role']);
    }

    public function get_all()
    {
        return $this->query("SELECT " . self::PUBLIC_COLUMNS . " FROM users ORDER BY first_name, last_name");
    }

    /** Includes the password hash -- used only to check a login. */
    public function get_by_email($email)
    {
        return $this->query_unique("SELECT * FROM users WHERE email = :email", ['email' => $email]);
    }
}
