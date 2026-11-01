create database if not exists zlajashop;
use zlajashop;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items, orders, cart_items, reviews, products, users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('admin','customer') NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB;

CREATE TABLE products (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description TEXT NULL,
    price       DECIMAL(10,2) NOT NULL,
    image_url   VARCHAR(255) NULL
) ENGINE=InnoDB;

CREATE TABLE reviews (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    user_id    INT UNSIGNED NOT NULL,
    comment    TEXT NOT NULL,
    CONSTRAINT fk_reviews_product FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reviews_user FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cart_items (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id    INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity   INT UNSIGNED NOT NULL DEFAULT 1,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE orders (
    id               INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id          INT UNSIGNED NOT NULL,
    status           ENUM('pending','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
    shipping_address VARCHAR(255) NOT NULL,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE order_items (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id   INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity   INT UNSIGNED NOT NULL DEFAULT 1,
    CONSTRAINT fk_oi_order FOREIGN KEY (order_id)
        REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_oi_product FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Sample data

INSERT INTO users (first_name, last_name, email, password_hash, role) VALUES
('Zlatko', 'Simišić',   'admin@zlajashop.ba',  '$2y$10$z/f6D/gyLKzx4e6g9cTqguWBQL2W20SUfO39.KkKojvrAVgL6qyMy', 'admin'),
('Amar',   'Hodžić',    'amar@zlajashop.ba',   '$2y$10$rwdMym2bhoiS2Rzt34aGE.GXxEQ/Erp.vEMcvVLWPGomB63n506Yq', 'customer'),
('Lejla',  'Kovačević', 'lejla@zlajashop.ba',  '$2y$10$rwdMym2bhoiS2Rzt34aGE.GXxEQ/Erp.vEMcvVLWPGomB63n506Yq', 'customer'),
('Emir',   'Begić',     'emir@zlajashop.ba',   '$2y$10$rwdMym2bhoiS2Rzt34aGE.GXxEQ/Erp.vEMcvVLWPGomB63n506Yq', 'customer');

INSERT INTO products (name, description, price, image_url) VALUES
('Wireless Mouse',      'Ergonomic 2.4 GHz wireless mouse with silent clicks.',        29.90, 'assets/images/products/mouse.jpg'),
('Mechanical Keyboard', 'Full-size mechanical keyboard with red switches and RGB.',    119.00, 'assets/images/products/keyboard.jpg'),
('USB-C Hub',           '7-in-1 hub: HDMI, 3x USB-A, SD, microSD and PD charging.',     54.50, 'assets/images/products/hub.jpg'),
('Noise-Cancelling Headphones', 'Over-ear Bluetooth headphones, 30 h battery.',        189.00, 'assets/images/products/headphones.jpg'),
('27" Monitor',         '27-inch IPS monitor, 1440p, 75 Hz.',                          349.00, 'assets/images/products/monitor.jpg'),
('Laptop Stand',        'Adjustable aluminium laptop stand.',                           39.90, NULL);

INSERT INTO reviews (product_id, user_id, comment) VALUES
(1, 2, 'Great mouse for the price, battery lasts for months.'),
(2, 3, 'Typing feels amazing, a bit loud for the office.'),
(4, 2, 'Noise cancelling works really well on the bus.'),
(5, 4, 'Sharp picture, colours are good out of the box.'),
(1, 4, 'Comfortable, but the scroll wheel could be smoother.');

INSERT INTO cart_items (user_id, product_id, quantity) VALUES
(2, 3, 1),
(3, 6, 2),
(3, 1, 1),
(4, 2, 1);

INSERT INTO orders (user_id, status, shipping_address) VALUES
(2, 'delivered', 'Zmaja od Bosne 8, 71000 Sarajevo'),
(3, 'shipped',   'Ferhadija 12, 71000 Sarajevo'),
(4, 'pending',   'Maršala Tita 25, 71000 Sarajevo'),
(2, 'cancelled', 'Zmaja od Bosne 8, 71000 Sarajevo');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 4, 1),
(2, 2, 1),
(2, 6, 1),
(3, 5, 1),
(4, 3, 2);
