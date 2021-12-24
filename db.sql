/*
 Navicat MySQL Data Transfer

 Source Server         : db_test
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : db

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 24/12/2021 19:02:37
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
  `good_state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_destination` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_origin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_price` double(10, 2) NOT NULL,
  PRIMARY KEY (`good_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES (7, 'k380', 0.10, '待发货', '广州', '深圳', 120.00);
INSERT INTO `good` VALUES (8, 'ipad', 0.78, '已发货', '广州', '杭州', 3560.00);
INSERT INTO `good` VALUES (9, 'aa', 1.00, '在路上', '北京', '深圳', 465.00);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `consignor_id` int UNSIGNED NOT NULL,
  `consignee_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `consignor_id`(`consignor_id`) USING BTREE,
  INDEX `consignee_id`(`consignee_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`consignor_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`consignee_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (2, 1, 1);
INSERT INTO `order` VALUES (1, 2, 2);
INSERT INTO `order` VALUES (1, 3, 3);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_good
-- ----------------------------
INSERT INTO `order_good` VALUES (7, 1);
INSERT INTO `order_good` VALUES (8, 2);
INSERT INTO `order_good` VALUES (9, 3);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
  `user_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'dzq', 'aaaaaaaa66', '男', '15384390694');
INSERT INTO `user` VALUES (2, 'sb', '123456', '男', '11111111111');
INSERT INTO `user` VALUES (3, 'as', '1234', '女', '4132141.021');

SET FOREIGN_KEY_CHECKS = 1;
