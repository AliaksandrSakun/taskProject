CREATE TABLE `trustproject`.`users` (
                                       `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                       `email` VARCHAR(45) NOT NULL,
                                       `password` VARCHAR(45) NOT NULL,
                                       PRIMARY KEY (`id`),
                                       UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);

INSERT INTO `trustproject`.`users` (`email`, `password`) VALUES ('abc@mail.ru', '12345');
INSERT INTO `trustproject`.`users` (`email`, `password`) VALUES ('cba@mail.ru', '54321');

CREATE TABLE `trustproject`.`roles` (
                                        `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                        `name` VARCHAR(45) NOT NULL,
                                        PRIMARY KEY (`id`),
                                        UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);

CREATE TABLE `trustproject`.`users_roles` (
                                              `user_id` BIGINT(20) NOT NULL,
                                              `role_id` BIGINT(20) NOT NULL,
                                              INDEX `fk_users_idx` (`user_id` ASC) VISIBLE,
                                              INDEX `fk_roles_idx` (`role_id` ASC) VISIBLE,
                                              CONSTRAINT `fk_users`
                                                  FOREIGN KEY (`user_id`)
                                                      REFERENCES `trustproject`.`users` (`id`)
                                                      ON DELETE NO ACTION
                                                      ON UPDATE NO ACTION,
                                              CONSTRAINT `fk_roles`
                                                  FOREIGN KEY (`role_id`)
                                                      REFERENCES `trustproject`.`roles` (`id`)
                                                      ON DELETE NO ACTION
                                                      ON UPDATE NO ACTION);

INSERT INTO `trustproject`.`roles` (`name`) VALUES ('USER');
INSERT INTO `trustproject`.`roles` (`name`) VALUES ('MANAGER');
INSERT INTO `trustproject`.`roles` (`name`) VALUES ('ADMIN');

INSERT INTO `trustproject`.`users_roles` (`user_id`, `role_id`) VALUES ('1', '1');

CREATE TABLE `trustproject`.`en_words` (
                                           `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                           `meaning` VARCHAR(45) NOT NULL,
                                           PRIMARY KEY (`id`),
                                           UNIQUE INDEX `meaning_UNIQUE` (`meaning` ASC) VISIBLE);

CREATE TABLE `trustproject`.`ru_words` (
                                           `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                           `meaning` VARCHAR(45) NOT NULL,
                                           PRIMARY KEY (`id`),
                                           UNIQUE INDEX `meaning_UNIQUE` (`meaning` ASC) VISIBLE);

CREATE TABLE `trustproject`.`cards` (
                                        `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                        `en_word_id` BIGINT(20) NOT NULL,
                                        `ru_word_id` BIGINT(20) NOT NULL,
                                        `rating` BIGINT(20) NULL,
                                        PRIMARY KEY (`id`),
                                        INDEX `fk__idx` (`en_word_id` ASC) VISIBLE,
                                        INDEX `fk_ru_word_idx` (`ru_word_id` ASC) VISIBLE,
                                        CONSTRAINT `fk_en_word`
                                            FOREIGN KEY (`en_word_id`)
                                                REFERENCES `trustproject`.`en_words` (`id`)
                                                ON DELETE NO ACTION
                                                ON UPDATE NO ACTION,
                                        CONSTRAINT `fk_ru_word`
                                            FOREIGN KEY (`ru_word_id`)
                                                REFERENCES `trustproject`.`ru_words` (`id`)
                                                ON DELETE NO ACTION
                                                ON UPDATE NO ACTION);

INSERT INTO `trustproject`.`en_words` (`meaning`) VALUES ('hello');
INSERT INTO `trustproject`.`ru_words` (`meaning`) VALUES ('привет');
INSERT INTO `trustproject`.`cards` (`en_word_id`, `ru_word_id`, `rating`) VALUES ('1', '1', '1');

CREATE TABLE `trustproject`.`images` (
                                         `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                         `name` VARCHAR(45) NOT NULL,
                                         `original_filename` VARCHAR(45) NOT NULL,
                                         `content_type` VARCHAR(45) NOT NULL,
                                         `size` BIGINT(20) NOT NULL,
                                         `bytes` LONGBLOB NOT NULL,
                                         PRIMARY KEY (`id`));

ALTER TABLE `trustproject`.`cards`
    ADD COLUMN `image_id` BIGINT(20) NULL AFTER `rating`,
    ADD INDEX `fk_images_idx` (`image_id` ASC) VISIBLE;
;
ALTER TABLE `trustproject`.`cards`
    ADD CONSTRAINT `fk_images`
        FOREIGN KEY (`image_id`)
            REFERENCES `trustproject`.`images` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION;

