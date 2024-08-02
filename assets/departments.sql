/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : school

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 15/03/2023 15:29:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments`  (
  `id` int(11) NOT NULL COMMENT '主键id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `manager_id` int(11) NULL DEFAULT NULL COMMENT '部门负责人',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门电话',
  `address` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门位置',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '部门创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of departments
-- ----------------------------
INSERT INTO `departments` VALUES (1, '生产部', 1, '123456', '主楼203', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (2, '营销部', 3, '123456', '主楼202', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (3, '材料部', 20, '123456', '主楼201', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (4, '研发部', 21, '123456', '主楼303', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (5, '产品部', 22, '123456', '主楼301', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (6, '人事部', 19, '123456', '主楼302', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (7, '财务部', 2, '123456', '主楼101', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (8, '测试部', 23, '123456', '主楼102', '2001-01-01 00:00:00');
INSERT INTO `departments` VALUES (9, '后勤部', 4, '123456', '主楼102', '2001-01-01 00:00:00');

SET FOREIGN_KEY_CHECKS = 1;
