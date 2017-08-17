SET FOREIGN_KEY_CHECKS=0;
--
-- Update from 1.03 to 1.04
--

-- 1 cats
ALTER TABLE `cats` ADD `cat_status` TINYINT(1) NOT NULL DEFAULT '1' AFTER `cat_order`, ADD INDEX (`cat_status`);

-- 2 places
ALTER TABLE `places` ADD FULLTEXT(`description`);

-- 3 custom_fields
CREATE TABLE IF NOT EXISTS `custom_fields` (
  `field_id` int(11) NOT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `values_list` text COLLATE utf8mb4_unicode_ci,
  `tooltip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `field_order` int(11) NOT NULL DEFAULT '0',
  `field_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4 custom_fields
ALTER TABLE `custom_fields` ADD PRIMARY KEY (`field_id`);

-- 5 custom_fields
ALTER TABLE `custom_fields` MODIFY `field_id` int(11) NOT NULL AUTO_INCREMENT;

-- 6 rel_cat_custom_fields
CREATE TABLE IF NOT EXISTS `rel_cat_custom_fields` (
  `rel_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7 rel_cat_custom_fields
ALTER TABLE `rel_cat_custom_fields`
  ADD PRIMARY KEY (`rel_id`),
  ADD KEY `cat_id` (`cat_id`),
  ADD KEY `field_id` (`field_id`);

-- 8 rel_cat_custom_fields
ALTER TABLE `rel_cat_custom_fields`
  MODIFY `rel_id` int(11) NOT NULL AUTO_INCREMENT;

-- 9 rel_cat_custom_fields
ALTER TABLE `rel_cat_custom_fields`
  ADD CONSTRAINT `rel_cat_custom_fields_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `cats` (`id`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_cat_custom_fields_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `custom_fields` (`field_id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 10 rel_place_custom_fields
CREATE TABLE IF NOT EXISTS `rel_place_custom_fields` (
  `rel_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_value` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11 rel_place_custom_fields
ALTER TABLE `rel_place_custom_fields`
  ADD PRIMARY KEY (`rel_id`),
  ADD KEY `option_id` (`field_id`),
  ADD KEY `place_id` (`place_id`),
  ADD FULLTEXT KEY `field_value` (`field_value`);

-- 12 rel_place_custom_fields
ALTER TABLE `rel_place_custom_fields`
  MODIFY `rel_id` int(11) NOT NULL AUTO_INCREMENT;

-- 13 rel_place_custom_fields
ALTER TABLE `rel_place_custom_fields`
  ADD CONSTRAINT `rel_place_custom_fields_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `custom_fields` (`field_id`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_place_custom_fields_ibfk_3` FOREIGN KEY (`place_id`) REFERENCES `places` (`place_id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 14 photos
ALTER TABLE `photos`
  ADD CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`place_id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 15 places
ALTER TABLE `places` DROP INDEX foursq_id;

-- 16 cities
ALTER TABLE `cities` CHANGE `state` `state` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 17 states
ALTER TABLE `states` CHANGE `state_abbr` `state_abbr` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';

-- 18 reviews
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`place_id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 19 rel_place_cat
ALTER TABLE `rel_place_cat`
  ADD CONSTRAINT `rel_place_cat_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`place_id`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_place_cat_ibfk_2` FOREIGN KEY (`cat_id`) REFERENCES `cats` (`id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 20 business_hours
ALTER TABLE `business_hours`
  ADD CONSTRAINT `business_hours_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`place_id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 21 cities_feat
ALTER TABLE `cities_feat`
  ADD CONSTRAINT `cities_feat_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 22 loggedin
ALTER TABLE `loggedin`
  ADD CONSTRAINT `loggedin_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 23 pass_request
ALTER TABLE `pass_request`
  ADD CONSTRAINT `pass_request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- 24 signup_confirm
ALTER TABLE `signup_confirm`
  ADD CONSTRAINT `signup_confirm_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
  ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Update from 1.04 to 1.05
--

-- 25 config
ALTER TABLE `config`
  CHANGE `value` `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL;

-- 26 contact_msgs
CREATE TABLE IF NOT EXISTS `contact_msgs` (
  `id` int(11) NOT NULL,
  `sender_email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_ip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place_id` int(11) NOT NULL,
  `msg` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 27 contact_msgs
ALTER TABLE `contact_msgs` ADD PRIMARY KEY (`id`);

-- 28 contact_msgs
ALTER TABLE `contact_msgs` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- 29 config
INSERT INTO `config` (`id`, `type`, `property`, `value`) VALUES
(28, 'api', 'facebook_key', ''),
(29, 'api', 'facebook_secret', ''),
(30, 'api', 'twitter_key', ''),
(31, 'api', 'twitter_secret', '');

-- 30 config
INSERT INTO `config` (`id`, `type`, `property`, `value`) VALUES
(101, 'plugin', 'plugin_contact_owner', 'a:3:{s:8:"question";s:6:"2 + 3?";s:6:"answer";s:1:"5";s:13:"email_subject";s:32:"Message from a DirectoryApp user";}');

-- 31 states
ALTER TABLE `states` CHANGE `country_abbr` `country_abbr` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'country';

-- 32 countries
ALTER TABLE `countries` CHANGE `country_abbr` `country_abbr` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'country';

-- 33 rel_place_custom_fields
ALTER TABLE `rel_place_custom_fields` CHANGE `field_value` `field_value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

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