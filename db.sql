/*
 Navicat MySQL Data Transfer

 Source Server         : db
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : db

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 05/01/2022 12:53:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for good
-- ----------------------------
DROP TABLE IF EXISTS `good`;
CREATE TABLE `good`  (
  `good_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `good_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_weight` double(10, 2) UNSIGNED NOT NULL,
  `good_price` double(10, 2) NOT NULL,
  PRIMARY KEY (`good_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES (35, 'k380', 0.10, 1201.00);
INSERT INTO `good` VALUES (36, 'ipad', 0.78, 3560.00);
INSERT INTO `good` VALUES (37, 'aa', 1.00, 465.00);
INSERT INTO `good` VALUES (38, '双汇泡面搭档', 0.38, 20.00);
INSERT INTO `good` VALUES (39, '魔芋爽', 5.00, 1.00);
INSERT INTO `good` VALUES (40, '随便', 17.00, 0.12);
INSERT INTO `good` VALUES (41, 'k380', 0.10, 120.00);
INSERT INTO `good` VALUES (42, '鸡米花', 12.00, 134.00);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `consignor_id` int UNSIGNED NOT NULL,
  `consignee_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_origin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_destination` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '待发货',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `consignor_id`(`consignor_id`) USING BTREE,
  INDEX `consignee_id`(`consignee_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`consignor_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`consignee_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 143 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (39, 40, 135, '天津', '北京', '待发货');
INSERT INTO `order` VALUES (40, 39, 136, '北京', '天津', '待发货');
INSERT INTO `order` VALUES (40, 41, 137, '深圳', '广州', '已发货');
INSERT INTO `order` VALUES (42, 43, 138, '内蒙古', '广东', '待发货');
INSERT INTO `order` VALUES (44, 45, 139, '广东', '上海', '待发货');
INSERT INTO `order` VALUES (46, 47, 140, '广州', '深圳', '待发货');
INSERT INTO `order` VALUES (48, 49, 141, '上海', '重庆', '待发货');
INSERT INTO `order` VALUES (50, 40, 142, '天津', '北京', '待发货');

-- ----------------------------
-- Table structure for order_good
-- ----------------------------
DROP TABLE IF EXISTS `order_good`;
CREATE TABLE `order_good`  (
  `good_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`good_id`, `order_id`) USING BTREE,
  INDEX `good_id`(`good_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `order_good_ibfk_1` FOREIGN KEY (`good_id`) REFERENCES `good` (`good_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_good_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_good
-- ----------------------------
INSERT INTO `order_good` VALUES (36, 136);
INSERT INTO `order_good` VALUES (37, 137);
INSERT INTO `order_good` VALUES (38, 138);
INSERT INTO `order_good` VALUES (39, 139);
INSERT INTO `order_good` VALUES (39, 140);
INSERT INTO `order_good` VALUES (40, 141);
INSERT INTO `order_good` VALUES (41, 135);
INSERT INTO `order_good` VALUES (42, 142);

-- ----------------------------
-- Table structure for track
-- ----------------------------
DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`  (
  `order_id` int UNSIGNED NOT NULL,
  `current_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `current_time` datetime NOT NULL,
  PRIMARY KEY (`order_id`, `current_location`, `current_time`) USING BTREE,
  INDEX `track_ibfk_1`(`order_id`) USING BTREE,
  CONSTRAINT `track_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of track
-- ----------------------------
INSERT INTO `track` VALUES (135, '天津', '2022-01-02 00:23:44');
INSERT INTO `track` VALUES (136, '佛山', '2021-12-24 15:49:10');
INSERT INTO `track` VALUES (136, '北京', '2022-01-02 00:23:45');
INSERT INTO `track` VALUES (136, '杭州', '2021-12-23 15:49:01');
INSERT INTO `track` VALUES (137, '深圳', '2022-01-02 00:23:45');
INSERT INTO `track` VALUES (138, '内蒙古', '2022-01-02 00:23:45');
INSERT INTO `track` VALUES (139, '广东', '2022-01-02 00:23:45');
INSERT INTO `track` VALUES (140, '广州', '2022-01-02 00:23:45');
INSERT INTO `track` VALUES (141, '上海', '2022-01-02 00:23:45');
INSERT INTO `track` VALUES (142, '天津', '2022-01-02 00:40:02');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'sb',
  `user_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1234',
  `user_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男',
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_role` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (39, 'sb', '1234', '男', '11111111111', 1);
INSERT INTO `user` VALUES (40, 'dzq', '1234', '男', '15384390694', 0);
INSERT INTO `user` VALUES (41, 'as', '1234', '男', '4132141.021', 0);
INSERT INTO `user` VALUES (42, 'dzq', '1234', '男', '15622291215', 0);
INSERT INTO `user` VALUES (43, 'xy', '1234', '男', '13539539189', 0);
INSERT INTO `user` VALUES (44, 'xy', '1234', '男', '15613327512', 0);
INSERT INTO `user` VALUES (45, 'dzq', '1234', '男', '13312343421', 0);
INSERT INTO `user` VALUES (46, 'll', '1234', '男', '15384390694', 0);
INSERT INTO `user` VALUES (47, 'pp', '1234', '男', '15622291215', 0);
INSERT INTO `user` VALUES (48, 'p', '1234', '男', '15384390694', 0);
INSERT INTO `user` VALUES (49, 'q', '1234', '男', '15622291215', 0);
INSERT INTO `user` VALUES (50, '13', '1234', '男', '15622291215', 0);

-- ----------------------------
-- View structure for view_goodsale
-- ----------------------------
DROP VIEW IF EXISTS `view_goodsale`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_goodsale` AS select `good`.`good_name` AS `good_name`,count(0) AS `number`,sum(`good`.`good_price`) AS `sale` from (((`user` join `good`) join `order_good`) join (select `user`.`user_name` AS `user_name`,`user`.`user_phone` AS `user_phone`,`order`.`consignee_id` AS `consignee_id`,`order`.`order_id` AS `order_id`,`order`.`order_origin` AS `order_origin`,`order`.`order_destination` AS `order_destination`,`order`.`order_state` AS `order_state` from (`order` join `user`) where (`order`.`consignor_id` = `user`.`user_id`)) `os`) where ((`os`.`consignee_id` = `user`.`user_id`) and (`os`.`order_id` = `order_good`.`order_id`) and (`order_good`.`good_id` = `good`.`good_id`)) group by `good`.`good_name`;

-- ----------------------------
-- View structure for view_order
-- ----------------------------
DROP VIEW IF EXISTS `view_order`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_order` AS select `os`.`order_id` AS `order_id`,`os`.`user_name` AS `consignor`,`os`.`user_phone` AS `consignor_phone`,`os`.`order_destination` AS `order_destination`,`os`.`order_origin` AS `order_origin`,`os`.`order_state` AS `order_state`,`user`.`user_name` AS `consignee`,`user`.`user_phone` AS `consignee_phone`,`good`.`good_id` AS `good_id`,`good`.`good_name` AS `good_name`,`good`.`good_weight` AS `good_weight`,`good`.`good_price` AS `good_price` from (((`user` join `good`) join `order_good`) join (select `user`.`user_name` AS `user_name`,`user`.`user_phone` AS `user_phone`,`order`.`consignee_id` AS `consignee_id`,`order`.`order_id` AS `order_id`,`order`.`order_origin` AS `order_origin`,`order`.`order_destination` AS `order_destination`,`order`.`order_state` AS `order_state` from (`order` join `user`) where (`order`.`consignor_id` = `user`.`user_id`)) `os`) where ((`os`.`consignee_id` = `user`.`user_id`) and (`os`.`order_id` = `order_good`.`order_id`) and (`order_good`.`good_id` = `good`.`good_id`));

-- ----------------------------
-- View structure for view_ordergood
-- ----------------------------
DROP VIEW IF EXISTS `view_ordergood`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_ordergood` AS select `order`.`order_id` AS `order_id`,`order`.`order_state` AS `order_state`,`order`.`order_origin` AS `order_origin`,`order`.`order_destination` AS `order_destination`,`good`.`good_id` AS `good_id`,`good`.`good_name` AS `good_name`,`good`.`good_weight` AS `good_weight`,`good`.`good_price` AS `good_price` from ((`order` join `good`) join `order_good`) where ((`order`.`order_id` = `order_good`.`order_id`) and (`good`.`good_id` = `order_good`.`good_id`));

-- ----------------------------
-- View structure for view_usercost
-- ----------------------------
DROP VIEW IF EXISTS `view_usercost`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_usercost` AS select `user`.`user_id` AS `user_id`,`good`.`good_name` AS `good_name`,sum(`good`.`good_price`) AS `cost` from (((`user` join `good`) join `order_good`) join (select `user`.`user_name` AS `user_name`,`user`.`user_phone` AS `user_phone`,`order`.`consignee_id` AS `consignee_id`,`order`.`order_id` AS `order_id`,`order`.`order_origin` AS `order_origin`,`order`.`order_destination` AS `order_destination`,`order`.`order_state` AS `order_state` from (`order` join `user`) where (`order`.`consignor_id` = `user`.`user_id`)) `os`) where ((`os`.`consignee_id` = `user`.`user_id`) and (`os`.`order_id` = `order_good`.`order_id`) and (`order_good`.`good_id` = `good`.`good_id`)) group by `user`.`user_id`,`good`.`good_name`;

-- ----------------------------
-- Procedure structure for orderInfo
-- ----------------------------
DROP PROCEDURE IF EXISTS `orderInfo`;
delimiter ;;
CREATE PROCEDURE `orderInfo`(in information varchar(255))
begin
    select os.order_id,os.user_name consignor,os.user_phone consignor_phone,
               os.order_destination,os.order_origin,os.order_state,
               `user`.user_name consignee,`user`.user_phone consignee_phone,
               good.*
        from `user`,good,order_good,(
            select user_name,user_phone,consignee_id,order_id,order_origin,order_destination,order_state
            from `order`,`user`
            where consignor_id = user_id
        ) os
        where os.consignee_id = `user`.user_id
          and os.order_id = order_good.order_id
          and order_good.good_id = good.good_id
     and (
       os.user_name like concat('%', information, '%')
            or os.user_phone like concat('%', information, '%')
            or `user`.user_name like concat('%', information, '%')
            or `user`.user_phone like concat('%', information, '%')
     );
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for orderTrack
-- ----------------------------
DROP PROCEDURE IF EXISTS `orderTrack`;
delimiter ;;
CREATE PROCEDURE `orderTrack`()
BEGIN	
		select *
    from track;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
