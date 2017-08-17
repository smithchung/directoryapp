SET FOREIGN_KEY_CHECKS=0;

--
-- Update from 1.05 to 1.06
--

-- 34 config
ALTER TABLE `config` CHANGE `property` `property` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 35 config
INSERT INTO `config` (`type`, `property`, `value`) VALUES
('payment', '_2checkout_mode', '0'),
('payment', '_2checkout_sid', '2CHECKOUT_ACCOUNT_ID'),
('payment', '_2checkout_sandbox_sid', '2CHECKOUT_SANDBOX_ACCOUNT_ID'),
('payment', '_2checkout_secret', '2CHECKOUT_SECRET'),
('payment', '_2checkout_currency_code', 'USD'),
('payment', '_2checkout_currency_symbol', '$'),
('payment', '_2checkout_lang', 'en'),
('payment', '_2checkout_notify_url', 'http://example.com/ipn-2checkout.php'),
('payment', 'mercadopago_mode', '1'),
('payment', 'mercadopago_client_id', 'MERCADO_PAGO_ID'),
('payment', 'mercadopago_client_secret', 'MERCADO_PAGO_CLIENT_SECRET'),
('payment', 'mercadopago_currency_id', 'BRL'),
('payment', 'mercadopago_notification_url', 'http://example.com/ipn-mercadopago.php');

--
-- Update from 1.06 to 1.07
--

-- 36 states
ALTER TABLE `states` CHANGE `country_id` `country_id` INT(11) NULL DEFAULT '1';

-- 37 states
ALTER TABLE `states` ADD INDEX(`country_id`);

-- 38 states
ALTER TABLE `states` ADD FOREIGN KEY (`country_id`) REFERENCES `countries`(`country_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- 39 cities
ALTER TABLE `cities` ADD INDEX(`state_id`);

-- 40 places
ALTER TABLE `places` CHANGE `phone` `phone` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 41 places
ALTER TABLE `places` CHANGE `website` `website` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 42 cities
ALTER TABLE `cities` CHANGE `state` `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 43 places
ALTER TABLE `places` CHANGE `area_code` `area_code` VARCHAR(25) NULL DEFAULT NULL;

-- 44 places
ALTER TABLE `places` DROP `last_bump`;

--
-- Update from 1.07 to 1.08
--

-- 45 email_templates
INSERT INTO `email_templates` (`id`, `type`, `description`, `subject`, `body`) VALUES (NULL, 'web_accept_fail', 'One time payment failed email', 'Your most recent payment failed', 'Hi there, Unfortunately your most recent payment for your ad on our site was declined. This could be due to a change in your card number or your card expiring, cancelation of your credit card, or the bank not recognizing the payment and taking action to prevent it. Please update your payment information as soon as possible by logging in here: https://yoursite.com/user/login'' Thanks, Business Directory - http://yoursite.com');

-- 46 email_templates
ALTER TABLE `email_templates` CHANGE `type` `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 47 email_templates
INSERT INTO `email_templates` (`id`, `type`, `description`, `subject`, `body`) VALUES (NULL, 'process_add_place', 'User submission notification', 'A new listing was submitted', 'Hello,

A new listing was submitted on:
http://yoursite.com/admin thanks');

-- 48 email_templates
INSERT INTO `email_templates` (`id`, `type`, `description`, `subject`, `body`) VALUES (NULL, 'process_edit_place', 'User edit listing notification', 'A new listing was edited', 'Hello,

A user has edited a listing on:

http://yoursite.com/admin

thanks');

-- 49 config
INSERT INTO config (`type`, `property`, `value`) VALUES
('payment', 'stripe_mode', '0'),
('payment', 'stripe_test_secret_key', 'YOUR_TEST_SECRET_KEY'),
('payment', 'stripe_test_publishable_key', 'YOUR_TEST_PUBLISHABLE_KEY'),
('payment', 'stripe_live_secret_key', 'YOUR_LIVE_SECRET_KEY'),
('payment', 'stripe_live_publishable_key', 'YOUR_LIVE_PUBLISHABLE_KEY'),
('payment', 'stripe_data_currency', 'usd'),
('payment', 'stripe_currency_symbol', '$'),
('payment', 'stripe_data_image', 'https://stripe.com/img/v3/home/twitter.png'),
('payment', 'stripe_data_description', 'Directoryapp membership');

-- 50 plans
ALTER TABLE `plans` CHANGE `plan_price` `plan_price` DECIMAL(10,2) NOT NULL DEFAULT '0.00';

SET FOREIGN_KEY_CHECKS=1;