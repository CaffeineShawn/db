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

 Date: 05/01/2022 13:08:38
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
INSERT INTO `good` VALUES (1, '卫龙辣条', 10.00, 200.00);
INSERT INTO `good` VALUES (2, '飞机模型', 20.00, 1000.00);
INSERT INTO `good` VALUES (3, '宇航服', 100.00, 1000000.00);
INSERT INTO `good` VALUES (4, '多肉植物', 1.00, 2.30);
INSERT INTO `good` VALUES (5, 'iPhone13ProMax', 0.50, 8799.00);
INSERT INTO `good` VALUES (6, '双汇雪糕', 10.00, 800.00);
INSERT INTO `good` VALUES (7, '电瓶车', 30.00, 1000.00);
INSERT INTO `good` VALUES (8, '华为手机', 0.30, 9999.00);
INSERT INTO `good` VALUES (9, '月球土壤', 1.00, 9999999.00);
INSERT INTO `good` VALUES (10, '水滴', 10000.00, 1000000.00);

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
INSERT INTO `order` VALUES (2, 3, 1, '深圳', '广州', '已发货');
INSERT INTO `order` VALUES (2, 4, 2, '深圳', '南宁', '已发货');
INSERT INTO `order` VALUES (2, 5, 3, '深圳', '北京', '待发货');
INSERT INTO `order` VALUES (3, 4, 4, '天津', '西安', '已送达');
INSERT INTO `order` VALUES (4, 3, 5, '上海', '苏州', '已送达');
INSERT INTO `order` VALUES (4, 2, 6, '上海', '哈尔滨', '已送达');
INSERT INTO `order` VALUES (6, 5, 7, '阿富汗', '北京', '已送达');
INSERT INTO `order` VALUES (6, 2, 8, '纽约', '深圳', '已发货');
INSERT INTO `order` VALUES (6, 4, 9, '月球', '广州', '已送达');
INSERT INTO `order` VALUES (7, 2, 10, '三体星', '纽约', '已发货');

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
INSERT INTO `order_good` VALUES (1, 1);
INSERT INTO `order_good` VALUES (2, 2);
INSERT INTO `order_good` VALUES (3, 3);
INSERT INTO `order_good` VALUES (4, 4);
INSERT INTO `order_good` VALUES (5, 5);
INSERT INTO `order_good` VALUES (6, 6);
INSERT INTO `order_good` VALUES (7, 7);
INSERT INTO `order_good` VALUES (8, 8);
INSERT INTO `order_good` VALUES (9, 9);
INSERT INTO `order_good` VALUES (10, 10);

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
INSERT INTO `track` VALUES (1, '佛山', '2021-12-31 19:28:51');
INSERT INTO `track` VALUES (1, '深圳', '2021-12-30 21:28:51');
INSERT INTO `track` VALUES (2, '佛山', '2020-12-10 18:41:32');
INSERT INTO `track` VALUES (2, '梧州', '2021-07-02 21:31:49');
INSERT INTO `track` VALUES (2, '深圳', '2019-12-01 21:31:49');
INSERT INTO `track` VALUES (3, '深圳', '2022-01-01 21:32:55');
INSERT INTO `track` VALUES (4, '保定', '2021-12-02 21:33:52');
INSERT INTO `track` VALUES (4, '吕梁', '2021-12-06 21:33:52');
INSERT INTO `track` VALUES (4, '咸阳', '2021-12-21 21:33:52');
INSERT INTO `track` VALUES (4, '固原', '2021-12-12 21:33:52');
INSERT INTO `track` VALUES (4, '天水', '2021-12-14 21:33:52');
INSERT INTO `track` VALUES (4, '天津', '2021-11-30 21:33:52');
INSERT INTO `track` VALUES (4, '太原', '2021-12-05 21:33:52');
INSERT INTO `track` VALUES (4, '安康', '2021-12-18 21:33:52');
INSERT INTO `track` VALUES (4, '定西', '2021-12-13 21:33:52');
INSERT INTO `track` VALUES (4, '宝鸡', '2021-12-15 21:33:52');
INSERT INTO `track` VALUES (4, '平凉', '2021-12-09 21:33:52');
INSERT INTO `track` VALUES (4, '庆阳', '2021-12-08 21:33:52');
INSERT INTO `track` VALUES (4, '廊坊', '2021-12-01 21:45:19');
INSERT INTO `track` VALUES (4, '延安', '2021-12-07 21:33:52');
INSERT INTO `track` VALUES (4, '汉中', '2021-12-17 21:33:52');
INSERT INTO `track` VALUES (4, '石家庄', '2021-12-03 21:33:52');
INSERT INTO `track` VALUES (4, '西安', '2021-12-21 23:33:52');
INSERT INTO `track` VALUES (4, '阳泉', '2021-12-04 21:33:52');
INSERT INTO `track` VALUES (5, '上海', '2021-12-31 21:36:33');
INSERT INTO `track` VALUES (5, '苏州', '2022-01-01 18:36:33');
INSERT INTO `track` VALUES (6, '上海', '2021-12-25 21:38:41');
INSERT INTO `track` VALUES (6, '北京', '2021-12-27 21:38:41');
INSERT INTO `track` VALUES (6, '哈尔滨', '2021-12-30 23:38:41');
INSERT INTO `track` VALUES (6, '山东', '2021-12-28 21:38:41');
INSERT INTO `track` VALUES (6, '杭州', '2021-12-26 21:40:08');
INSERT INTO `track` VALUES (7, '兰州', '2021-12-24 22:58:59');
INSERT INTO `track` VALUES (7, '北京', '2021-12-27 22:58:59');
INSERT INTO `track` VALUES (7, '印度', '2021-12-08 23:39:01');
INSERT INTO `track` VALUES (7, '阿富汗', '2021-12-01 22:58:59');
INSERT INTO `track` VALUES (8, '上海', '2021-12-12 22:54:44');
INSERT INTO `track` VALUES (8, '纽约', '2021-12-09 22:54:44');
INSERT INTO `track` VALUES (9, '上海', '2021-12-18 23:04:31');
INSERT INTO `track` VALUES (9, '北京', '2021-12-17 23:04:31');
INSERT INTO `track` VALUES (9, '天宫号', '2021-11-10 22:56:15');
INSERT INTO `track` VALUES (9, '广州', '2021-12-20 23:04:31');
INSERT INTO `track` VALUES (9, '月球', '2021-10-01 22:56:15');
INSERT INTO `track` VALUES (9, '酒泉', '2021-11-12 22:56:15');
INSERT INTO `track` VALUES (10, '三体星', '2021-01-08 22:57:42');
INSERT INTO `track` VALUES (10, '仙女系', '2021-07-08 23:01:03');
INSERT INTO `track` VALUES (10, '冥王星', '2021-12-17 23:01:03');
INSERT INTO `track` VALUES (10, '太阳系', '2021-10-07 23:01:03');
INSERT INTO `track` VALUES (10, '银河系', '2021-08-13 23:01:03');

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
INSERT INTO `user` VALUES (1, 'root', '1234', '男', '12323232231', 1);
INSERT INTO `user` VALUES (2, 'aa', '1234', '男', '13800000000', 0);
INSERT INTO `user` VALUES (3, 'bb', '1234', '女', '13900000000', 0);
INSERT INTO `user` VALUES (4, 'cc', '123456', '女', '14000000000', 0);
INSERT INTO `user` VALUES (5, 'dd', '123456', '男', '14100000000', 0);
INSERT INTO `user` VALUES (6, 'ee', '1234', '男', '14200000000', 0);
INSERT INTO `user` VALUES (7, 'santiman', '1234', '男', '19000000000', 0);

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
