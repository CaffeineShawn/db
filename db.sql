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

 Date: 23/12/2021 17:10:08
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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES (7, 'k380', 120.00, '待发货', '广州', '深圳', 120.00);
INSERT INTO `good` VALUES (8, 'ipad', 250.00, '已发货', '广州', '杭州', 3560.00);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `consignor_id` int UNSIGNED NOT NULL,
  `consignee_id` int UNSIGNED NOT NULL,
  `good_id` int UNSIGNED NOT NULL,
  `order_price` double(10, 2) NOT NULL,
  PRIMARY KEY (`consignor_id`, `good_id`, `consignee_id`) USING BTREE,
  INDEX `good_id`(`good_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`good_id`) REFERENCES `good` (`good_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 2, 8, 10.00);
INSERT INTO `order` VALUES (2, 1, 7, 0.00);

-- ----------------------------
-- Table structure for track
-- ----------------------------
DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`  (
  `good_id` int UNSIGNED NOT NULL,
  `current_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `current_time` datetime NOT NULL,
  PRIMARY KEY (`good_id`) USING BTREE,
  CONSTRAINT `track_ibfk_1` FOREIGN KEY (`good_id`) REFERENCES `good` (`good_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of track
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'dzq', 'aaaaaaaa66', '男', '15384390694');
INSERT INTO `user` VALUES (2, 'sb', '123456', '男', '11111111111');
INSERT INTO `user` VALUES (3, 'as', '1234', '女', '4132141.021');

SET FOREIGN_KEY_CHECKS = 1;
