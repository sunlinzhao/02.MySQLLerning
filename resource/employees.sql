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

 Date: 15/03/2023 15:28:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees`  (
  `id` int(11) NOT NULL COMMENT '主键',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `age` int(11) NULL DEFAULT NULL COMMENT '员工年龄',
  `gender` int(1) NULL DEFAULT NULL COMMENT '员工性别（0-男，1-女）',
  `salary` decimal(10, 2) NULL DEFAULT NULL COMMENT '月薪',
  `dept_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO `employees` VALUES (1, '1001', '张三', 32, 0, 10000.00, '1');
INSERT INTO `employees` VALUES (2, '1002', '李四', 30, 0, 12000.00, '1');
INSERT INTO `employees` VALUES (3, '1003', '王五', 28, 0, 15000.00, '2');
INSERT INTO `employees` VALUES (4, '1004', '赵六', 25, 0, 18000.00, '9');
INSERT INTO `employees` VALUES (5, '1005', 'Jack', 33, 0, 12000.00, '1');
INSERT INTO `employees` VALUES (6, '1006', 'Rose', 30, 1, 9000.00, '9');
INSERT INTO `employees` VALUES (7, '1007', 'Mary', 28, 1, 15400.00, '2');
INSERT INTO `employees` VALUES (8, '1008', 'Tom', 25, 0, 8600.00, '9');
INSERT INTO `employees` VALUES (9, '1009', 'Jarry', 26, 0, 11000.00, '2');
INSERT INTO `employees` VALUES (10, '1010', 'Aaron', 22, 1, 12000.00, '2');
INSERT INTO `employees` VALUES (11, '1011', 'Alex', 27, 1, 9560.00, '9');
INSERT INTO `employees` VALUES (12, '1012', 'Ben', 31, 1, 8170.00, '9');
INSERT INTO `employees` VALUES (13, '1013', 'Bob', 36, 1, 8500.00, '1');
INSERT INTO `employees` VALUES (14, '1014', 'Chris', 29, 1, 13000.00, '2');
INSERT INTO `employees` VALUES (15, '1015', 'Carl', 26, 1, 7800.00, '1');
INSERT INTO `employees` VALUES (16, '1016', 'Duke', 31, 1, 10500.00, '2');
INSERT INTO `employees` VALUES (17, '1017', 'Ford', 30, 1, 9600.00, '1');
INSERT INTO `employees` VALUES (18, '1018', 'James', 29, 1, 9600.00, '1');
INSERT INTO `employees` VALUES (19, '1019', 'Trump', 55, 1, 21000.00, '6');
INSERT INTO `employees` VALUES (20, '1020', 'Billy', 36, 1, 15600.00, '3');
INSERT INTO `employees` VALUES (21, '1021', 'Ezreal', 24, 1, 16800.00, '4');
INSERT INTO `employees` VALUES (22, '1022', 'Annie', 22, 0, 12000.00, '5');
INSERT INTO `employees` VALUES (23, '1023', 'Jax', 35, 1, 15000.00, '8');

SET FOREIGN_KEY_CHECKS = 1;
