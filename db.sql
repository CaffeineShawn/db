/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50528
 Source Host           : localhost:3306
 Source Schema         : db

 Target Server Type    : MySQL
 Target Server Version : 50528
 File Encoding         : 65001

 Date: 26/12/2021 15:48:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '广州');
INSERT INTO `address` VALUES (2, '福州');
INSERT INTO `address` VALUES (3, '南宁');
INSERT INTO `address` VALUES (4, '柳州');
INSERT INTO `address` VALUES (5, '桂林');
INSERT INTO `address` VALUES (6, '北京');
INSERT INTO `address` VALUES (7, '上海');
INSERT INTO `address` VALUES (8, '台湾');
INSERT INTO `address` VALUES (9, '重庆');
INSERT INTO `address` VALUES (10, '杭州');

-- ----------------------------
-- Table structure for good
-- ----------------------------
DROP TABLE IF EXISTS `good`;
CREATE TABLE `good`  (
  `good_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `good_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_weight` double(10, 2) UNSIGNED NOT NULL,
  `good_state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_destination` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_origin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `good_price` double(10, 2) NOT NULL,
  PRIMARY KEY (`good_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES (1, '生鲜蟹', 24.00, '在路上', '台湾', '广州', 450.00);
INSERT INTO `good` VALUES (2, '李宁鞋', 0.50, '已发货', '莆田', '上海', 1000000.00);
INSERT INTO `good` VALUES (3, '干脆面', 1.00, '在路上', '福州', '桂林', 20.00);
INSERT INTO `good` VALUES (4, '剃须刀', 2.00, '待发货', '柳州', '福州', 400.00);
INSERT INTO `good` VALUES (5, 'p60', 1.00, '待发货', '深圳', '北京', 9999.00);
INSERT INTO `good` VALUES (6, '剪刀', 0.30, '已送达', '北京', '桂林', 15.00);
INSERT INTO `good` VALUES (7, 'k380', 0.10, '待发货', '广州', '深圳', 120.00);
INSERT INTO `good` VALUES (8, 'ipad', 0.78, '已送达', '广州', '杭州', 3560.00);
INSERT INTO `good` VALUES (9, 'aa', 1.00, '在路上', '北京', '深圳', 465.00);
INSERT INTO `good` VALUES (10, '2077', 0.20, '待发货', '上海', '广州', 220.00);
INSERT INTO `good` VALUES (11, 'iphone13', 0.30, '在路上', '深圳', '重庆', 5300.00);
INSERT INTO `good` VALUES (12, 'cup', 0.10, '在路上', '北京', '深圳', 20.00);
INSERT INTO `good` VALUES (13, '小猪佩奇', 10.00, '已送达', '上海', '杭州', 10000.00);
INSERT INTO `good` VALUES (14, 'gl550', 2.00, '待发货', '南宁', '广州', 2000.00);
INSERT INTO `good` VALUES (15, 'lv酵素', 0.10, '已送达', '广州', '深圳', 200000.00);
INSERT INTO `good` VALUES (16, 'i9 9900k', 0.50, '已发货', '深圳', '苏州', 5000.00);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `consignor_id` int(10) UNSIGNED NOT NULL,
  `consignee_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `consignor_id`(`consignor_id`) USING BTREE,
  INDEX `consignee_id`(`consignee_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`consignor_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`consignee_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (2, 1, 1);
INSERT INTO `order` VALUES (1, 2, 2);
INSERT INTO `order` VALUES (1, 3, 3);
INSERT INTO `order` VALUES (1, 1, 4);
INSERT INTO `order` VALUES (1, 1, 5);
INSERT INTO `order` VALUES (2, 1, 6);
INSERT INTO `order` VALUES (3, 1, 7);
INSERT INTO `order` VALUES (1, 3, 8);
INSERT INTO `order` VALUES (2, 3, 9);
INSERT INTO `order` VALUES (3, 2, 10);
INSERT INTO `order` VALUES (3, 3, 11);
INSERT INTO `order` VALUES (4, 2, 12);
INSERT INTO `order` VALUES (3, 4, 13);
INSERT INTO `order` VALUES (3, 5, 14);
INSERT INTO `order` VALUES (4, 5, 15);
INSERT INTO `order` VALUES (4, 5, 16);
INSERT INTO `order` VALUES (5, 4, 17);
INSERT INTO `order` VALUES (5, 6, 18);
INSERT INTO `order` VALUES (5, 7, 19);
INSERT INTO `order` VALUES (6, 7, 20);

-- ----------------------------
-- Table structure for order_good
-- ----------------------------
DROP TABLE IF EXISTS `order_good`;
CREATE TABLE `order_good`  (
  `good_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
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
INSERT INTO `order_good` VALUES (10, 4);
INSERT INTO `order_good` VALUES (11, 5);
INSERT INTO `order_good` VALUES (2, 6);
INSERT INTO `order_good` VALUES (7, 7);
INSERT INTO `order_good` VALUES (8, 8);
INSERT INTO `order_good` VALUES (9, 9);
INSERT INTO `order_good` VALUES (10, 10);
INSERT INTO `order_good` VALUES (7, 11);
INSERT INTO `order_good` VALUES (12, 12);
INSERT INTO `order_good` VALUES (11, 13);
INSERT INTO `order_good` VALUES (12, 14);
INSERT INTO `order_good` VALUES (14, 15);
INSERT INTO `order_good` VALUES (16, 16);
INSERT INTO `order_good` VALUES (15, 17);
INSERT INTO `order_good` VALUES (13, 18);
INSERT INTO `order_good` VALUES (12, 19);
INSERT INTO `order_good` VALUES (3, 20);

-- ----------------------------
-- Table structure for track
-- ----------------------------
DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`  (
  `order_id` int(10) UNSIGNED NOT NULL,
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
INSERT INTO `track` VALUES (2, '广州', '2021-12-25 15:49:10');
INSERT INTO `track` VALUES (12, '深圳', '2021-12-20 15:45:29');
INSERT INTO `track` VALUES (12, '上海', '2021-12-21 15:45:46');
INSERT INTO `track` VALUES (12, '南京', '2021-12-22 15:46:20');
INSERT INTO `track` VALUES (12, '郑州', '2021-12-23 15:46:36');
INSERT INTO `track` VALUES (12, '济南', '2021-12-24 15:46:48');
INSERT INTO `track` VALUES (12, '天津', '2021-12-25 15:47:12');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'sb',
  `user_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1234',
  `user_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'dzq', 'aaaaaaaa66', '男', '15384390694');
INSERT INTO `user` VALUES (2, 'sb', '123456', '男', '11111111111');
INSERT INTO `user` VALUES (3, 'as', '1234', '女', '4132141.021');
INSERT INTO `user` VALUES (4, 'nmsl', '12345', '女', '222222222');
INSERT INTO `user` VALUES (5, 'wr', '123564', '男', '234353253');
INSERT INTO `user` VALUES (6, '蔡徐坤', '1234', '女', '43805340583');
INSERT INTO `user` VALUES (7, '薇娅', '1234', '女', '10000000');
INSERT INTO `user` VALUES (8, 'jgo', '1234', '男', '759347554');
INSERT INTO `user` VALUES (9, '李三', '1234', '男', '4654544443');
INSERT INTO `user` VALUES (10, '建瓯', '1234', '女', '465453423');

SET FOREIGN_KEY_CHECKS = 1;
