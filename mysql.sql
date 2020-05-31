CREATE TABLE `users` (
	`user_id` INT NOT NULL AUTO_INCREMENT,
	`user_is_customer` BOOLEAN NOT NULL DEFAULT true,
	`user_name` varchar(45) NOT NULL,
	`user_image_url` varchar(255),
	`user_email` varchar(45) NOT NULL UNIQUE,
	`user_password` varchar(255) NOT NULL,
	`user_birthday` TIMESTAMP NOT NULL,
	`user_description` TEXT,
	`user_city_id` INT NOT NULL,
	`user_phone` varchar(45) NOT NULL,
	`user_rating` FLOAT NOT NULL DEFAULT '0',
	`user_created_at` TIMESTAMP NOT NULL,
	`user_lastvisited_at` TIMESTAMP NOT NULL,
	`user_count_view` INT NOT NULL DEFAULT '0',
	PRIMARY KEY (`user_id`)
);

CREATE TABLE `specializations` (
	`specialization_id` INT NOT NULL AUTO_INCREMENT,
	`specialization_name` varchar(45) NOT NULL,
	`specialization_label` varchar(255) NOT NULL,
	PRIMARY KEY (`specialization_id`)
);

CREATE TABLE `users_specializations` (
	`user_id` INT NOT NULL,
	`specialization_id` INT NOT NULL
);

CREATE TABLE `notifications` (
	`notification_id` INT NOT NULL AUTO_INCREMENT,
	`notification_name` varchar(45) NOT NULL,
	`notification_label` varchar(45) NOT NULL,
	PRIMARY KEY (`notification_id`)
);

CREATE TABLE `users_notifications` (
	`user_id` INT NOT NULL,
	`notification_id` INT NOT NULL
);

CREATE TABLE `socials` (
	`social_id` INT NOT NULL AUTO_INCREMENT,
	`social_name` varchar(45) NOT NULL,
	`social_label` varchar(45) NOT NULL,
	PRIMARY KEY (`social_id`)
);

CREATE TABLE `users_socials` (
	`user_id` INT NOT NULL,
	`social_id` INT NOT NULL
);

CREATE TABLE `tasks` (
	`task_id` INT NOT NULL AUTO_INCREMENT,
	`task_customer_id` INT NOT NULL,
	`task_freelancer_id` INT,
	`task_specialization_id` INT NOT NULL,
	`task_title` varchar(45) NOT NULL,
	`task_status` varchar(45) NOT NULL DEFAULT 'new',
	`task_price` INT,
	`task_diedline` TIMESTAMP,
	`task_description` TEXT NOT NULL,
	`task_lat` FLOAT,
	`task_lng` FLOAT,
	`task_city_id` INT,
	`task_address_comment` varchar(255),
	`task_created_at` TIMESTAMP NOT NULL,
	`task_deleted_at` TIMESTAMP NOT NULL,
	`task_done_at` TIMESTAMP NOT NULL,
	PRIMARY KEY (`task_id`)
);

CREATE TABLE `responds` (
	`respond_id` INT NOT NULL AUTO_INCREMENT,
	`respond_author_id` INT NOT NULL,
	`respond_task_id` INT NOT NULL,
	`respond_text` TEXT NOT NULL,
	`respond_price` INT NOT NULL,
	`respond_diedline` TIMESTAMP NOT NULL,
	`respond_created_at` TIMESTAMP NOT NULL,
	`respond_updated_at` TIMESTAMP NOT NULL,
	`respond_deleted_at` TIMESTAMP NOT NULL,
	PRIMARY KEY (`respond_id`)
);

CREATE TABLE `reviews` (
	`review_id` INT NOT NULL AUTO_INCREMENT,
	`review_author_id` INT NOT NULL,
	`review_addressee_id` INT NOT NULL,
	`review_task_id` INT NOT NULL,
	`review_rating` INT NOT NULL,
	`review_text` TEXT NOT NULL,
	`review_created_at` TIMESTAMP NOT NULL,
	PRIMARY KEY (`review_id`)
);

CREATE TABLE `attachments` (
	`attachment_id` INT NOT NULL AUTO_INCREMENT,
	`attachment_task_id` INT,
	`attachment_user_id` INT NOT NULL,
	PRIMARY KEY (`attachment_id`)
);

CREATE TABLE `cities` (
	`city_id` INT NOT NULL AUTO_INCREMENT,
	`city_name` varchar(255) NOT NULL UNIQUE,
	`city_lat` FLOAT NOT NULL,
	`city_lng` FLOAT NOT NULL,
	PRIMARY KEY (`city_id`)
);

CREATE TABLE `messages` (
	`message_id` INT NOT NULL AUTO_INCREMENT,
	`message_task_id` INT NOT NULL,
	`message_author_id` INT NOT NULL,
	`message_text` TEXT NOT NULL,
	`message_created_at` TIMESTAMP NOT NULL,
	PRIMARY KEY (`message_id`)
);

ALTER TABLE `users` ADD CONSTRAINT `users_fk0` FOREIGN KEY (`user_city_id`) REFERENCES `cities`(`city_id`);

ALTER TABLE `users_specializations` ADD CONSTRAINT `users_specializations_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `users_specializations` ADD CONSTRAINT `users_specializations_fk1` FOREIGN KEY (`specialization_id`) REFERENCES `specializations`(`specialization_id`);

ALTER TABLE `users_notifications` ADD CONSTRAINT `users_notifications_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `users_notifications` ADD CONSTRAINT `users_notifications_fk1` FOREIGN KEY (`notification_id`) REFERENCES `notifications`(`notification_id`);

ALTER TABLE `users_socials` ADD CONSTRAINT `users_socials_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `users_socials` ADD CONSTRAINT `users_socials_fk1` FOREIGN KEY (`social_id`) REFERENCES `socials`(`social_id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk0` FOREIGN KEY (`task_customer_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk1` FOREIGN KEY (`task_freelancer_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk2` FOREIGN KEY (`task_specialization_id`) REFERENCES `specializations`(`specialization_id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk3` FOREIGN KEY (`task_city_id`) REFERENCES `cities`(`city_id`);

ALTER TABLE `responds` ADD CONSTRAINT `responds_fk0` FOREIGN KEY (`respond_author_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `responds` ADD CONSTRAINT `responds_fk1` FOREIGN KEY (`respond_task_id`) REFERENCES `tasks`(`task_id`);

ALTER TABLE `reviews` ADD CONSTRAINT `reviews_fk0` FOREIGN KEY (`review_author_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `reviews` ADD CONSTRAINT `reviews_fk1` FOREIGN KEY (`review_addressee_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `reviews` ADD CONSTRAINT `reviews_fk2` FOREIGN KEY (`review_task_id`) REFERENCES `tasks`(`task_id`);

ALTER TABLE `attachments` ADD CONSTRAINT `attachments_fk0` FOREIGN KEY (`attachment_task_id`) REFERENCES `tasks`(`task_id`);

ALTER TABLE `attachments` ADD CONSTRAINT `attachments_fk1` FOREIGN KEY (`attachment_user_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk0` FOREIGN KEY (`message_task_id`) REFERENCES `tasks`(`task_id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk1` FOREIGN KEY (`message_author_id`) REFERENCES `users`(`user_id`);

