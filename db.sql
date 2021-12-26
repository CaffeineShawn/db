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

 Date: 26/12/2021 16:24:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `user_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES (7, 'k380', 0.10, 120.00);
INSERT INTO `good` VALUES (8, 'ipad', 0.78, 3560.00);
INSERT INTO `good` VALUES (9, 'aa', 1.00, 465.00);
INSERT INTO `good` VALUES (12, '北京烤鸭', 12.00, 5.00);
INSERT INTO `good` VALUES (18, '双汇泡面搭档', 0.38, 20.00);
INSERT INTO `good` VALUES (19, '魔芋爽', 5.00, 1.00);
INSERT INTO `good` VALUES (20, 'ThinkPad', 1.20, 4500.00);
INSERT INTO `good` VALUES (22, '随便', 17.00, 0.12);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (2, 1, 1, '天津', '北京', '待发货');
INSERT INTO `order` VALUES (1, 2, 2, '北京', '天津', '待发货');
INSERT INTO `order` VALUES (1, 3, 3, '深圳', '广州', '待发货');
INSERT INTO `order` VALUES (9, 10, 5, '深圳', '伤害', '待发货');
INSERT INTO `order` VALUES (9, 10, 9, '上海', '天津', '待发货');
INSERT INTO `order` VALUES (9, 10, 10, '重庆', '广西', '待发货');
INSERT INTO `order` VALUES (4, 12, 11, '内蒙古', '广东', '待发货');
INSERT INTO `order` VALUES (13, 14, 12, '广东', '上海', '待发货');
INSERT INTO `order` VALUES (15, 16, 13, '北京', '广州', '待发货');
INSERT INTO `order` VALUES (17, 18, 14, '上海', '重庆', '待发货');
INSERT INTO `order` VALUES (19, 20, 15, '广州', '深圳', '待发货');

-- ----------------------------
-- Table structure for order_good
-- ----------------------------
DROP TABLE IF EXISTS `order_good`;
CREATE TABLE `order_good`  (
  `good_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL,
  INDEX `good_id`(`good_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `order_good_ibfk_1` FOREIGN KEY (`good_id`) REFERENCES `good` (`good_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_good_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_good
-- ----------------------------
INSERT INTO `order_good` VALUES (7, 1);
INSERT INTO `order_good` VALUES (8, 2);
INSERT INTO `order_good` VALUES (9, 3);
INSERT INTO `order_good` VALUES (18, 11);
INSERT INTO `order_good` VALUES (19, 12);
INSERT INTO `order_good` VALUES (22, 14);
INSERT INTO `order_good` VALUES (19, 15);

-- ----------------------------
-- Table structure for track
-- ----------------------------
DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`  (
  `order_id` int UNSIGNED NOT NULL,
  `current_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `current_time` datetime NOT NULL,
  INDEX `track_ibfk_1`(`order_id`) USING BTREE,
  CONSTRAINT `track_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of track
-- ----------------------------
INSERT INTO `track` VALUES (2, '杭州', '2021-12-23 15:49:01');
INSERT INTO `track` VALUES (2, '佛山', '2021-12-24 15:49:10');

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
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'dzq', 'aaaaaaaa66', '男', '15384390694');
INSERT INTO `user` VALUES (2, 'sb', '123456', '男', '11111111111');
INSERT INTO `user` VALUES (3, 'as', '1234', '女', '4132141.021');
INSERT INTO `user` VALUES (4, 'dzq', '1234', '男', '15622291215');
INSERT INTO `user` VALUES (9, 'a', '1234', '男', '15384390694');
INSERT INTO `user` VALUES (10, 'b', '1234', '男', '15622291215');
INSERT INTO `user` VALUES (11, 'b', '1234', '男', '15384390694');
INSERT INTO `user` VALUES (12, 'xy', '1234', '男', '13539539189');
INSERT INTO `user` VALUES (13, 'xy', '1234', '男', '15613327512');
INSERT INTO `user` VALUES (14, 'dzq', '1234', '男', '13312343421');
INSERT INTO `user` VALUES (15, 'yy', '1234', '男', '15384390694');
INSERT INTO `user` VALUES (16, 'bb', '1234', '男', '15622291215');
INSERT INTO `user` VALUES (17, 'p', '1234', '男', '15384390694');
INSERT INTO `user` VALUES (18, 'q', '1234', '男', '15622291215');
INSERT INTO `user` VALUES (19, 'll', '1234', '男', '15384390694');
INSERT INTO `user` VALUES (20, 'pp', '1234', '男', '15622291215');

SET FOREIGN_KEY_CHECKS = 1;
