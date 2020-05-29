drop database if exists adidas_fec;
create database adidas_fec;
use adidas_fec;

drop table if exists `Reviews`;
CREATE TABLE `Reviews` (
  `id` INTEGER AUTO_INCREMENT,
  `product_id` INTEGER NOT NULL,
  `user_id` INTEGER,
  `title` VARCHAR(255) NOT NULL,
  `text` MEDIUMTEXT NOT NULL,
  `rating_overall` INTEGER NOT NULL,
  `doesRecommend` BOOLEAN NOT NULL,
  `rating_size` INTEGER NOT NULL,
  `rating_width` INTEGER NOT NULL,
  `rating_comfort` INTEGER NOT NULL,
  `rating_quality` INTEGER NOT NULL,
  `isHelpful` INTEGER NOT NULL DEFAULT 0,
  `isNotHelpful` INTEGER NOT NULL DEFAULT 0,
  `created_At` DATETIME DEFAULT now(),
  `uploaded_At` DATETIME,
  `user_nickname` VARCHAR(255) NOT NULL,
  `user_verified` BOOLEAN NOT NULL DEFAULT false,
  `user_email_auth` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
);
	
drop table if exists `Users`;
CREATE TABLE `Users` (
  `id` INTEGER AUTO_INCREMENT,
  `firstname` VARCHAR(255), 
  `lastname` VARCHAR(255),
  `email` VARCHAR(255),
  `top_contributor` BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (`id`)
);

drop table if exists `Products`;		
CREATE TABLE `Products` (
  `id` INTEGER AUTO_INCREMENT,
  `product_code` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255),
  `description` VARCHAR(255),
  `category` VARCHAR(255),
  PRIMARY KEY (`id`)
);

drop table if exists `ReviewPhotos`;
CREATE TABLE `ReviewPhotos` (
  `id` INTEGER  AUTO_INCREMENT,
  `review_id` INTEGER NOT NULL,
  `photo_path` VARCHAR(1024) NOT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

-- ALTER TABLE `Reviews` ADD FOREIGN KEY (product_id) REFERENCES `Products` (`id`);
-- ALTER TABLE `Reviews` ADD FOREIGN KEY (user_id) REFERENCES `Users` (`id`);
-- ALTER TABLE `ReviewPhotos` ADD FOREIGN KEY (review_id) REFERENCES `Reviews` (`id`);

-- ---
-- Test Data
-- ---

INSERT INTO `Products` (`product_code`,`name`,`description`,`category`) VALUES
('EG4958','superstar-shoes','Superstar Shoes Cloud White and Core Black Shoes','shoes');

INSERT INTO `Users` (`firstname`, `lastname`, `email`, `top_contributor`) VALUES
('Beverley','Truman','bebt22@gmail.com', false),
('Vanessa','Gomez','vanesa2@gmail.com', false);

INSERT INTO `Reviews` 
(`product_id`,`user_id`,`title`,`text`,
  `rating_overall`,`doesRecommend`,`rating_size`,`rating_width`,`rating_comfort`,`rating_quality`,
  `isHelpful`,`isNotHelpful`,`created_At`,`uploaded_At`,`user_nickname`,`user_verified`,`user_email_auth`) VALUES
(1,1,'MY FEET FEEL GREAT AFTER A 10 HR SHIFT.',
  'I have been wearing the same shoe for over 6 years. As a healthcare worker, it is very important that my feet stay comfortable and pain free, esp since I\'m on my feet for most of my shift.',
  5,true,3,3,3,3,
  2,0,'2020-04-27 10:10:46','2020-04-27 10:10:47','IROCKSTAR',false,'bebt22@gmail.com'),
(1,2,'CLASSIC',
  'Love them, but do size down. Their sizing is very different. For me it was a whole shoe size.',
  5,true,3,3,3,3,
  1,0,'2020-04-27 09:10:44','2020-04-27 09:10:44','VANESA2',false,'vanesa2@gmail.com');

INSERT INTO `ReviewPhotos` (`review_id`,`photo_path`) VALUES
('1','./dist/photos/1');