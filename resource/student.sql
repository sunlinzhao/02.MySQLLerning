/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : school

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 12/03/2023 12:21:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学生姓名',
  `age` int NULL DEFAULT NULL COMMENT '学生年龄',
  `gender` int NULL DEFAULT NULL COMMENT '学生性别（0-男，1-女）',
  `height` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学生身高',
  `weight` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学生体重',
  `position` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学生职位id',
  `guardian_name` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '监护人姓名',
  `guardian_phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '监护人手机号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '张三丰', 150, 0, '188', '165', '班长', '张二丰', '18822334567');
INSERT INTO `student` VALUES (2, '杨过', 18, 0, '186', '160', '体育课代表', '杨康', '18822334569');
INSERT INTO `student` VALUES (3, '小龙女', 16, 1, '168', '110', '学习委员', '未知', '18822334568');
INSERT INTO `student` VALUES (4, '郭襄', 3, 1, '160', '60', '普通群众', '郭靖', '18822334566');
INSERT INTO `student` VALUES (5, '黄蓉', 28, 1, '160', '110', '普通群众', '黄药师', '18822334564');
INSERT INTO `student` VALUES (6, '郭芙', 3, 1, '159', '60', '普通群众', '郭靖', '18822334565');
INSERT INTO `student` VALUES (7, '郭啸天', 18, 0, '182', '177', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (8, '杨铁心', 28, 0, '192', '188', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (9, '王重阳', 35, 0, '187', '150', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (10, '周伯通', 45, 0, '150', '90', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (11, '李莫愁', 42, 1, '166', '95', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (12, '杨康', 21, 0, '178', '140', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (13, '黄药师', 37, 0, '180', '160', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (14, '欧阳锋', 25, 0, '183', '145', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (15, '梅超风', 34, 1, '167', '123', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (16, '丘处机', 16, 0, '170', '140', '普通群众', NULL, '18822334565');
INSERT INTO `student` VALUES (17, '洪七公', 22, 0, '172', '155', '普通群众', NULL, '18822334565');

SET FOREIGN_KEY_CHECKS = 1;
