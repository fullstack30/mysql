drop database if exists `gtechblog` ;

CREATE database IF NOT EXISTS `gtechblog` ;

USE `gtechblog` ;

CREATE TABLE IF NOT EXISTS `gtechblog`.`user_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `gtechblog`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_id` INT NOT NULL,
  `is_active` TINYINT NULL,
  `email` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_users_user_types1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_user_types1`
    FOREIGN KEY (`type_id`)
    REFERENCES `gtechblog`.`user_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `gtechblog`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `slug` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `image_path` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `gtechblog`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `gtechblog`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `gtechblog`.`profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `picture_path` VARCHAR(255) NULL,
  `bio` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `gtechblog`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `gtechblog`.`posts_tags` (
  `post_id` INT NOT NULL,
  `tags_id` INT NOT NULL,
  INDEX `fk_posts_tags_tags1_idx` (`tags_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_tags_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `gtechblog`.`posts` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_tags_tags1`
    FOREIGN KEY (`tags_id`)
    REFERENCES `gtechblog`.`tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `gtechblog`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `parent_id` INT NULL,
  `content` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_posts1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_comments_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comments_comments1_idx` (`parent_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `gtechblog`.`posts` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `gtechblog`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_comments1`
    FOREIGN KEY (`parent_id`)
    REFERENCES `gtechblog`.`comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- INSERT DATAS

insert into user_types (type) values ('admin'), ('user');

insert into users (type_id, is_active, email, username, password) 
values (1, 1, 'kelvys@mail.com', 'kelvysmoura', '123456'), 
(1, 1, 'rodrigues@mail.com', 'rodrigues', '123456'),
(2, 1, 'joão@mail.com', 'joão', '123456');

insert into profile (user_id, firstname, surname)
values (1, 'Kelvys', 'Moura'),
(2, 'Rodrigues', 'Neto'),
(3, 'Josão', 'Silvera');

insert into posts (id, user_id, title, slug, content)
values (1, 1, 'Post 07', 'post-07', 'Conteúdo do post 07'),
(2, 2, 'Post 08', 'post-08', 'Conteúdo do post 08'),
(3, 3, 'Post 09', 'post-09', 'Conteúdo do post 09'),
(4, 1, 'Post 10', 'post-10', 'Conteúdo do post 10'),
(5, 2, 'Post 11', 'post-11', 'Conteúdo do post 11'),
(6, 3, 'Post 12', 'post-12', 'Conteúdo do post 12'),
(7, 1, 'Post 13', 'post-12', 'Conteúdo do post 12'),
(8, 2, 'Post 14', 'post-12', 'Conteúdo do post 12'),
(9, 3, 'Post 15', 'post-12', 'Conteúdo do post 12'),
(10, 1, 'Post 16', 'post-12', 'Conteúdo do post 12'),
(11, 2, 'Post 17', 'post-12', 'Conteúdo do post 12'),
(12, 3, 'Post 18', 'post-12', 'Conteúdo do post 12');

insert into tags(name)
values ("JS"), ("HTML"), ("CSS"), ("ReactJS"), ("NodeJS"), ("MySQL"), ("Cypress");

insert into posts_tags(post_id, tags_id)
values (7,1), (7,2), (7,3), (7,4), (7,5), (7,6), (7,7),
(8,1), (9,2), (10,3), (11,4), (12,5), (8,6), (9,7),
(9,1), (8,2), (11,3), (12,4), (10,5), (9,6), (8,7);

insert into comments (user_id, post_id, content)
values (1, 1, 'Comentario 01'),
(2, 1, 'Comentario 02'),
(3, 2, 'Comentario 03');

insert into comments (user_id, post_id, parent_id, content)
values (3, 1, 1, 'Comentario filho do 01'),
(2, 1, 2, 'Comentario filho do 02'),
(1, 2, 3, 'Comentario filho do 03');