

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for table_serial_number
-- ----------------------------
DROP TABLE IF EXISTS `table_serial_number`;
CREATE TABLE `table_serial_number`  (
  `TABID` int(9) NOT NULL AUTO_INCREMENT COMMENT '表ID',
  `TABNAME` varchar(40) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '表名，不允许重复',
  `STARTSERIALNUMBER` decimal(16, 0) NOT NULL COMMENT '起始流水号',
  `CURRSERIALNUMBER` decimal(16, 0) NOT NULL COMMENT '当前流水号，第一次插入的时候就是起始流水号',
  `SERIALNUMBERLEN` decimal(9, 0) NOT NULL COMMENT '流水号长度',
  `ISENABLE` int(1) NOT NULL COMMENT '是否启用，0否1是',
  `CREATER` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '创建人',
  `CRATTEDATE` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`TABID`) USING BTREE,
  UNIQUE INDEX `SYS_C0013410`(`TABID`) USING BTREE,
  UNIQUE INDEX `TABNAME_UNIQUE`(`TABNAME`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流水号表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
