/*
Navicat MySQL Data Transfer

Source Server         : online
Source Server Version : 50718
Source Host           : rm-2zeq9d80a9w2bs3byco.mysql.rds.aliyuncs.com:3306
Source Database       : mywedding

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-03-09 10:32:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `admin_user` varchar(20) NOT NULL COMMENT '用户名',
  `admin_password` varchar(32) NOT NULL COMMENT '密码',
  `last_time` datetime DEFAULT NULL COMMENT '最后登入时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('1', '123', '202cb962ac59075b964b07152d234b70', '2018-03-08 11:30:03', '2018-02-23 15:37:59');

-- ----------------------------
-- Table structure for basic_ad
-- ----------------------------
DROP TABLE IF EXISTS `basic_ad`;
CREATE TABLE `basic_ad` (
  `ad_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `attribute_id` int(11) NOT NULL COMMENT '广告属性',
  `ad_name` varchar(18) NOT NULL COMMENT '广告名',
  `ad_img` varchar(200) NOT NULL COMMENT '广告图片路径',
  `ad_is_show` tinyint(2) NOT NULL COMMENT '是否显示',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='广告';

-- ----------------------------
-- Records of basic_ad
-- ----------------------------
INSERT INTO `basic_ad` VALUES ('1', '1', 'gtfsajhg', 'jhgfjhgujdsx.jpg', '1', '2018-02-26 17:45:25');
INSERT INTO `basic_ad` VALUES ('2', '1', 'asdfdsag', 'dsafdshgbgh.jpg', '1', '2018-02-26 17:45:50');
INSERT INTO `basic_ad` VALUES ('3', '1', 'hykjhkjh', 'kjudsfzgfkj.jpg', '0', '2018-02-26 18:08:52');

-- ----------------------------
-- Table structure for basic_attribute
-- ----------------------------
DROP TABLE IF EXISTS `basic_attribute`;
CREATE TABLE `basic_attribute` (
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `attribute_name` varchar(64) NOT NULL COMMENT '属性名',
  `is_use` tinyint(2) NOT NULL COMMENT '是否可用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of basic_attribute
-- ----------------------------
INSERT INTO `basic_attribute` VALUES ('1', '首页轮播图', '1', '2018-02-26 17:11:15');
INSERT INTO `basic_attribute` VALUES ('2', '首页广告', '1', '2018-02-26 17:11:36');
INSERT INTO `basic_attribute` VALUES ('3', '项目也轮播图', '1', '2018-02-26 17:11:54');
INSERT INTO `basic_attribute` VALUES ('4', '项目也广告图', '1', '2018-02-26 17:12:04');

-- ----------------------------
-- Table structure for commodity_classification
-- ----------------------------
DROP TABLE IF EXISTS `commodity_classification`;
CREATE TABLE `commodity_classification` (
  `type_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `type_name` varchar(50) DEFAULT NULL COMMENT '分类名称',
  `is_use` tinyint(2) NOT NULL COMMENT '是否可用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商品分类';

-- ----------------------------
-- Records of commodity_classification
-- ----------------------------
INSERT INTO `commodity_classification` VALUES ('1', '中式婚礼', '1', '2018-02-27 13:40:16');
INSERT INTO `commodity_classification` VALUES ('2', '草坪婚礼', '1', '2018-02-27 13:40:30');
INSERT INTO `commodity_classification` VALUES ('3', '蒂芙尼蓝', '1', '2018-02-27 13:40:32');
INSERT INTO `commodity_classification` VALUES ('4', '森系婚礼', '1', '2018-02-27 13:40:34');

-- ----------------------------
-- Table structure for goods_admin
-- ----------------------------
DROP TABLE IF EXISTS `goods_admin`;
CREATE TABLE `goods_admin` (
  `goods_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `seller_type` varchar(100) DEFAULT NULL COMMENT '商户类型',
  `online_price` double(10,2) DEFAULT NULL COMMENT '线上销售价格',
  `stock_count` int(50) DEFAULT NULL COMMENT '库存数量',
  `goods_state` varchar(20) DEFAULT NULL COMMENT '商品状态',
  `sell_count` int(50) DEFAULT NULL COMMENT '销量',
  `is_use` tinyint(2) DEFAULT NULL COMMENT '是否可用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_admin
-- ----------------------------

-- ----------------------------
-- Table structure for goods_brands
-- ----------------------------
DROP TABLE IF EXISTS `goods_brands`;
CREATE TABLE `goods_brands` (
  `brands_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `brands_name` varchar(50) NOT NULL COMMENT '商品名',
  `brands_eing` varchar(50) NOT NULL COMMENT '品牌英文名',
  `brands_url` varchar(500) NOT NULL COMMENT '品牌Logo',
  `brands_desc` varchar(500) NOT NULL COMMENT '品牌描述',
  PRIMARY KEY (`brands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品品牌';

-- ----------------------------
-- Records of goods_brands
-- ----------------------------

-- ----------------------------
-- Table structure for goods_comment
-- ----------------------------
DROP TABLE IF EXISTS `goods_comment`;
CREATE TABLE `goods_comment` (
  `comment_id` int(2) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spu_id` int(2) DEFAULT NULL COMMENT '商品id',
  `user_id` int(2) DEFAULT NULL COMMENT '会员id',
  `order_id` int(2) DEFAULT NULL COMMENT '订单id',
  `goods_rank` int(10) DEFAULT NULL COMMENT '商品评级',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `goods_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品评价表';

-- ----------------------------
-- Records of goods_comment
-- ----------------------------
INSERT INTO `goods_comment` VALUES ('1', '1', '2', '102', '1', '0000-00-00 00:00:00', '吉祥凯悦主题婚礼酒店');

-- ----------------------------
-- Table structure for goods_comment_detail
-- ----------------------------
DROP TABLE IF EXISTS `goods_comment_detail`;
CREATE TABLE `goods_comment_detail` (
  `detail_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `comment_id` int(4) DEFAULT NULL COMMENT '评论id',
  `detail_txt` tinytext COMMENT '评价内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品评价详情';

-- ----------------------------
-- Records of goods_comment_detail
-- ----------------------------
INSERT INTO `goods_comment_detail` VALUES ('1', '102', '凯悦的服务真心不错', '2018-01-24 17:01:33');

-- ----------------------------
-- Table structure for goods_comment_img
-- ----------------------------
DROP TABLE IF EXISTS `goods_comment_img`;
CREATE TABLE `goods_comment_img` (
  `img_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `comment_id` int(4) DEFAULT NULL COMMENT '评论id',
  `detail_url` int(20) DEFAULT NULL COMMENT '详情id',
  `img_url` varchar(20) NOT NULL COMMENT '图片路径',
  `img_sort` int(10) NOT NULL COMMENT '排序',
  PRIMARY KEY (`img_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品评价图片';

-- ----------------------------
-- Records of goods_comment_img
-- ----------------------------
INSERT INTO `goods_comment_img` VALUES ('1', null, null, 'http://kaiyue.png', '0');
INSERT INTO `goods_comment_img` VALUES ('2', null, null, 'http://kaiyue.png', '0');
INSERT INTO `goods_comment_img` VALUES ('3', '1', null, 'http://kaiyue.png', '0');

-- ----------------------------
-- Table structure for goods_img
-- ----------------------------
DROP TABLE IF EXISTS `goods_img`;
CREATE TABLE `goods_img` (
  `shop_code` varchar(50) NOT NULL,
  `img_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '图片id',
  `spu_id` int(4) DEFAULT NULL COMMENT '商品编码',
  `use_type` int(4) DEFAULT NULL COMMENT '图片类型',
  `img_url` varchar(500) DEFAULT NULL COMMENT '图片地址',
  `goods_video` varchar(200) DEFAULT NULL COMMENT '视频地址',
  `img_sort` int(4) DEFAULT NULL COMMENT '图片地址排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`img_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='商品图片';

-- ----------------------------
-- Records of goods_img
-- ----------------------------
INSERT INTO `goods_img` VALUES ('1009', '1', '100', null, 'http://mumian.png', 'http://mumian.mp4', null, '0000-00-00 00:00:00');
INSERT INTO `goods_img` VALUES ('1100', '2', '200', null, 'http://hunsha.png', 'http://hunsha.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1200', '3', '300', null, 'http://zulin.png', 'http://zulin.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1300', '4', '400', null, 'http://jiabin.png', 'http://jiabin.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1400', '5', '500', null, 'http://tianpin.png', 'http://tianpin.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1500', '6', '600', null, 'http://daguanjia.png', 'http://daguanjia.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1600', '7', '700', null, 'http://caigou.png', 'http://caigou.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1700', '8', '800', null, 'http://qingjian.png', 'http://qingjian.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1800', '9', '900', null, 'http://didi.png', 'http://didi.mp4', null, null);
INSERT INTO `goods_img` VALUES ('1900', '10', '1000', null, 'http://youbu.png', 'http://youbu.mp4', null, null);
INSERT INTO `goods_img` VALUES ('2000', '11', '1100', null, 'http://bilibili.png', 'http://bilibili.mp4', null, null);
INSERT INTO `goods_img` VALUES ('2100', '12', '1200', null, 'http://burb.png', 'http://burb.mp4', null, null);
INSERT INTO `goods_img` VALUES ('', '13', '53', null, 'http://jixiangky.png', null, null, null);
INSERT INTO `goods_img` VALUES ('', '14', '54', null, 'http://sanyalvpai.png', null, null, null);
INSERT INTO `goods_img` VALUES ('', '15', '55', null, 'http://habhunsha.png', null, null, null);
INSERT INTO `goods_img` VALUES ('', '16', '56', null, 'http://sanyafqzl.png', null, null, null);
INSERT INTO `goods_img` VALUES ('', '17', '57', null, 'http://dbfenghuang.png', null, null, null);
INSERT INTO `goods_img` VALUES ('', '18', '58', null, 'http://xingrui.png', null, null, null);

-- ----------------------------
-- Table structure for goods_label
-- ----------------------------
DROP TABLE IF EXISTS `goods_label`;
CREATE TABLE `goods_label` (
  `label_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `goods_id` varchar(20) DEFAULT NULL COMMENT '商品id',
  `label_content` varchar(20) DEFAULT NULL COMMENT '标签内容',
  `is_use` tinyint(2) NOT NULL COMMENT '是否可用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品标签';

-- ----------------------------
-- Records of goods_label
-- ----------------------------

-- ----------------------------
-- Table structure for goods_movie
-- ----------------------------
DROP TABLE IF EXISTS `goods_movie`;
CREATE TABLE `goods_movie` (
  `movie_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '档期id',
  `spu_id` int(4) NOT NULL COMMENT '商品id',
  `detail_id` int(4) DEFAULT NULL COMMENT '详情id',
  `movie_time` datetime(4) NOT NULL COMMENT '日期',
  `is_use` tinyint(2) DEFAULT NULL COMMENT '是否可用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='商品档期';

-- ----------------------------
-- Records of goods_movie
-- ----------------------------
INSERT INTO `goods_movie` VALUES ('1', '4', '4', '2018-02-28 10:10:10.0000', '1', '2018-02-07 10:26:27');
INSERT INTO `goods_movie` VALUES ('2', '4', '4', '2018-03-01 10:02:49.0000', '1', '2018-02-07 10:26:27');
INSERT INTO `goods_movie` VALUES ('3', '4', '4', '2018-03-03 10:03:43.0000', '1', '2018-02-07 10:26:27');
INSERT INTO `goods_movie` VALUES ('4', '4', '4', '2018-03-04 10:04:10.0000', '1', '2018-02-07 10:26:27');
INSERT INTO `goods_movie` VALUES ('5', '4', '4', '2018-03-05 10:04:35.0000', '1', '2018-02-07 10:26:27');
INSERT INTO `goods_movie` VALUES ('6', '11', '11', '2018-03-01 11:34:25.0000', '1', '2018-02-08 11:34:09');
INSERT INTO `goods_movie` VALUES ('7', '11', '11', '2018-03-02 11:34:33.0000', '1', '2018-02-08 11:34:09');
INSERT INTO `goods_movie` VALUES ('8', '11', '11', '2018-03-05 11:34:39.0000', '1', '2018-02-08 11:34:09');
INSERT INTO `goods_movie` VALUES ('9', '11', '11', '2018-03-06 11:34:50.0000', '1', '2018-02-08 11:34:09');
INSERT INTO `goods_movie` VALUES ('10', '9', '9', '2018-03-07 12:02:05.0000', '1', '2018-03-05 12:02:24');
INSERT INTO `goods_movie` VALUES ('11', '9', '9', '2018-03-08 12:02:10.0000', '1', '2018-03-05 12:02:33');
INSERT INTO `goods_movie` VALUES ('12', '9', '9', '2018-03-09 12:02:12.0000', '1', '2018-03-05 12:02:35');
INSERT INTO `goods_movie` VALUES ('13', '9', '9', '2018-03-10 12:02:15.0000', '1', '2018-03-05 12:02:37');

-- ----------------------------
-- Table structure for goods_package
-- ----------------------------
DROP TABLE IF EXISTS `goods_package`;
CREATE TABLE `goods_package` (
  `package_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '套餐id',
  `spu_id` int(4) DEFAULT NULL COMMENT '商品id',
  `type_id` int(4) DEFAULT NULL COMMENT '分类id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_package
-- ----------------------------
INSERT INTO `goods_package` VALUES ('1', '12', '1', '2018-02-01 15:48:06');
INSERT INTO `goods_package` VALUES ('2', '13', '1', '2018-02-01 15:48:08');
INSERT INTO `goods_package` VALUES ('3', '14', '1', '2018-02-01 15:47:47');
INSERT INTO `goods_package` VALUES ('4', '15', '1', '2018-02-01 15:47:51');
INSERT INTO `goods_package` VALUES ('5', '16', '1', '2018-02-01 15:47:54');
INSERT INTO `goods_package` VALUES ('6', '17', '1', '2018-02-01 15:48:01');
INSERT INTO `goods_package` VALUES ('7', '12', '2', '2018-02-02 15:48:14');
INSERT INTO `goods_package` VALUES ('8', '13', '2', '2018-02-02 15:48:17');
INSERT INTO `goods_package` VALUES ('9', '14', '2', '2018-02-02 15:48:21');
INSERT INTO `goods_package` VALUES ('10', '15', '2', '2018-02-02 15:48:24');
INSERT INTO `goods_package` VALUES ('11', '16', '2', '2018-02-02 15:48:28');
INSERT INTO `goods_package` VALUES ('12', '17', '2', '2018-02-02 15:48:32');
INSERT INTO `goods_package` VALUES ('13', '12', '3', '2018-02-03 15:48:36');
INSERT INTO `goods_package` VALUES ('14', '13', '3', '2018-02-03 15:48:38');
INSERT INTO `goods_package` VALUES ('15', '14', '3', '2018-02-03 15:48:40');
INSERT INTO `goods_package` VALUES ('16', '15', '3', '2018-02-03 15:48:43');
INSERT INTO `goods_package` VALUES ('17', '16', '3', '2018-02-03 15:48:45');
INSERT INTO `goods_package` VALUES ('18', '17', '3', '2018-02-03 15:48:47');
INSERT INTO `goods_package` VALUES ('19', '12', '4', '2018-02-04 15:48:50');
INSERT INTO `goods_package` VALUES ('20', '13', '4', '2018-02-04 15:48:52');
INSERT INTO `goods_package` VALUES ('21', '14', '4', '2018-02-04 15:48:54');
INSERT INTO `goods_package` VALUES ('22', '15', '4', '2018-02-04 15:48:56');
INSERT INTO `goods_package` VALUES ('23', '16', '4', '2018-02-04 15:48:59');
INSERT INTO `goods_package` VALUES ('24', '17', '4', '2018-02-04 15:49:02');

-- ----------------------------
-- Table structure for goods_spu
-- ----------------------------
DROP TABLE IF EXISTS `goods_spu`;
CREATE TABLE `goods_spu` (
  `spu_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `sell_count` int(10) DEFAULT NULL COMMENT '商家编码',
  `type_id` int(4) DEFAULT NULL COMMENT '分类id',
  `brands_id` int(4) DEFAULT NULL COMMENT '品牌id',
  `spu_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `spu_sign` varchar(200) DEFAULT NULL COMMENT '商品标题',
  `spu_desc` text COMMENT '商品详情',
  `spu_sort` int(4) DEFAULT NULL COMMENT '商品排序',
  `stock_count` int(4) NOT NULL COMMENT '库存量',
  `is_marke` tinyint(2) NOT NULL COMMENT '是否上架',
  `spu_price` decimal(10,2) DEFAULT NULL COMMENT '商品单价',
  `look_count` int(4) DEFAULT NULL COMMENT '浏览量',
  `comment_count` int(4) DEFAULT NULL COMMENT '累计评论数',
  `pay_count` int(4) DEFAULT NULL COMMENT '累计交易数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='商品SPU';

-- ----------------------------
-- Records of goods_spu
-- ----------------------------
INSERT INTO `goods_spu` VALUES ('1', '1100', '1', '21', '范思哲', '衣品类', '奢侈品类', '1111', '205', '1', '29999.99', '1698', '3789', '125', '2018-01-23 16:50:28', '2018-01-23 16:50:28');
INSERT INTO `goods_spu` VALUES ('2', '1200', '2', '11', '路易威登', '皮包类', '奢侈品类', '1111', '99', '1', '98888.99', '3598', '1158', '55', '2018-01-23 16:52:24', '2018-01-23 16:52:24');
INSERT INTO `goods_spu` VALUES ('3', '1300', '3', '5', '玛莎拉蒂', '汽车类', '豪华轿车类', '1111', '159', '1', '2998888.99', '2457', '1258', '55', '2018-01-23 16:54:58', '2018-01-23 16:54:58');
INSERT INTO `goods_spu` VALUES ('4', null, null, null, '首席大管家赵一', '天津婚礼大管家服务', null, null, '122', '1', '3500.00', '133', '335', '125', '2018-01-24 15:40:24', '2018-01-24 15:40:24');
INSERT INTO `goods_spu` VALUES ('5', null, null, null, '甜品桌', '蛋糕桌上的秘密花园', null, '1111', '1999', '1', '2800.00', null, null, null, '2018-02-07 11:08:32', '2018-02-07 11:11:50');
INSERT INTO `goods_spu` VALUES ('6', null, null, null, '婚礼蛋糕', '木之棉蛋糕屋', null, null, '1999', '0', '222222.00', null, null, null, '2018-02-11 14:00:56', '2018-02-11 14:01:15');
INSERT INTO `goods_spu` VALUES ('7', null, '444', null, '婚纱照片', null, null, null, '52', '1', '2258.00', null, null, '18', '2018-02-22 13:55:07', '2018-02-22 13:55:07');
INSERT INTO `goods_spu` VALUES ('8', null, '444', null, '婚纱照片', null, null, null, '52', '1', '2258.00', null, null, '18', '2018-02-22 14:10:37', '2018-02-22 14:10:37');
INSERT INTO `goods_spu` VALUES ('9', null, null, null, '婚纱', null, null, null, '22', '0', '222222.00', null, null, '8', '2018-02-22 14:16:06', '2018-02-22 14:29:50');
INSERT INTO `goods_spu` VALUES ('10', null, '334', null, '婚纱照片', null, null, null, '582', '1', '2276.00', null, null, '178', '2018-02-22 14:19:46', '2018-02-22 14:26:01');
INSERT INTO `goods_spu` VALUES ('11', null, '124', null, '首席大管家王三', '北京婚礼大管家服务', null, null, '435', '1', '2500.00', '1458', '3855', '155', '2018-02-01 10:32:53', '2018-02-27 10:33:02');
INSERT INTO `goods_spu` VALUES ('12', null, null, null, '婚礼主持', null, null, null, '10', '1', '3500.00', '150', null, '1255', '2018-02-27 15:29:27', null);
INSERT INTO `goods_spu` VALUES ('13', null, null, null, '婚礼化妆', null, null, null, '12', '1', '2000.00', '222', null, '1288', '2018-02-27 15:29:47', null);
INSERT INTO `goods_spu` VALUES ('14', null, null, null, '婚礼摄影', null, null, null, '16', '1', '1000.00', '158', null, '202', '2018-02-27 15:29:51', null);
INSERT INTO `goods_spu` VALUES ('15', null, null, null, '婚礼摄像', null, null, null, '21', '1', '1580.00', '145', null, '152', '2018-02-27 15:29:55', null);
INSERT INTO `goods_spu` VALUES ('16', null, null, null, '婚礼灯光', null, null, null, '18', '1', '500.00', '652', null, '288', '2018-02-27 15:29:58', null);
INSERT INTO `goods_spu` VALUES ('17', null, null, null, '婚礼舞美', null, null, null, '15', '1', '2800.00', '1588', null, '308', '2018-02-27 15:30:01', null);
INSERT INTO `goods_spu` VALUES ('18', null, null, null, '浪漫公主梦——品诺诚意精品', null, null, null, '0', '1', '29880.00', null, null, null, '2018-02-28 13:35:25', null);
INSERT INTO `goods_spu` VALUES ('19', null, null, null, '璀璨星空主题【蓝、星】', null, null, null, '0', '1', '16888.00', null, null, null, '2018-02-28 13:35:32', null);
INSERT INTO `goods_spu` VALUES ('20', null, null, null, '盛夏的果实——花园别墅主题', null, null, null, '0', '1', '25888.00', null, null, null, '2018-02-28 13:35:34', null);
INSERT INTO `goods_spu` VALUES ('21', null, null, null, '夏日花圃——天津庆王府户外花园', null, null, null, '0', '1', '63668.00', null, null, null, '2018-02-28 13:35:35', null);
INSERT INTO `goods_spu` VALUES ('22', null, null, null, '薇澜婚礼 室内 森系 浪漫草地', null, null, null, '0', '1', '38520.00', null, null, null, '2018-02-28 13:35:37', null);
INSERT INTO `goods_spu` VALUES ('23', null, null, null, '非凡映像天津婚纱拍摄', null, null, null, '0', '1', '4188.00', null, null, null, '2018-02-28 13:35:38', null);
INSERT INTO `goods_spu` VALUES ('24', null, null, null, '青岛旅拍【新建特色的基地】', null, null, null, '0', '1', '4888.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('25', null, null, null, '韩国Miss Luna最新套餐', null, null, null, '0', '1', '6980.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('26', null, null, null, '【定制款】有故事的婚纱照', null, null, null, '0', '1', '5399.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('27', null, null, null, '云南旅拍爆款8666限时抢购', null, null, null, '0', '1', '8666.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('28', null, null, null, '豪华双机位', null, null, null, '0', '1', '4500.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('29', null, null, null, '哏都、幸福记者三机位跟拍', null, null, null, '0', '1', '3000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('30', null, null, null, '单机位韩归老师婚礼纪实跟拍', null, null, null, '0', '1', '1500.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('31', null, null, null, '沐白海外婚纱旅拍——大理站', null, null, null, '0', '1', '12345.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('32', null, null, null, '达达婚礼摄影摄影总监双机位婚礼跟拍', null, null, null, '0', '1', '6800.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('33', null, null, null, 'EagleFilm 超值双机位套餐', null, null, null, '0', '1', '4800.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('34', null, null, null, '【摄手座出品】三机位婚礼当天视频', null, null, null, '0', '1', '5500.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('35', null, null, null, 'MRK总监档3机位婚礼电影', null, null, null, '0', '1', '4800.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('36', null, null, null, '求婚实况全高清视频记录', null, null, null, '0', '1', '3000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('37', null, null, null, '纪北视觉【全球旅拍】斯里兰卡视频记录', null, null, null, '0', '1', '8000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('38', null, null, null, 'Aisha新娘跟妆 森系风格', null, null, null, '0', '1', '888.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('39', null, null, null, '克瑞斯彩妆人气造型师(无典礼半程跟妆)', null, null, null, '0', '1', '1680.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('40', null, null, null, '自然森系新娘造型', null, null, null, '0', '1', '3360.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('41', null, null, null, '新娘全程跟妆，限天津地区', null, null, null, '0', '1', '2080.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('42', null, null, null, '金牌造型师', null, null, null, '0', '1', '2000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('43', null, null, null, '汉式婚礼 传统礼仪文化的洗礼', null, null, null, '0', '1', '2000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('44', null, null, null, '郁松主持', null, null, null, '0', '1', '5200.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('45', null, null, null, '主持人晓光北京地区上午', null, null, null, '0', '1', '4500.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('46', null, null, null, '华艺首席主持人勃翾', null, null, null, '0', '1', '4000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('47', null, null, null, '海外主持价格【套餐一】', null, null, null, '0', '1', '10000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('48', null, null, null, '2017婚纱礼服', null, null, null, '0', '1', '3000.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('49', null, null, null, '伯瓷皇后、尊享套餐、尊贵之选', null, null, null, '0', '1', '8999.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('50', null, null, null, '【蒂凡尼】大码婚纱订制四件套', null, null, null, '0', '1', '3500.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('51', null, null, null, '【人气推荐】张伦硕同款结婚礼服', null, null, null, '0', '1', '3980.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('52', null, null, null, '伯瓷皇后、公主梦幻嫁衣', null, null, null, '0', '1', '14999.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('53', null, null, null, '吉祥凯悦主题婚礼酒店', null, null, null, '10', '1', '1988.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('54', null, null, null, '【精品甄选】三亚旅拍套餐', null, null, null, '1', '1', '10999.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('55', null, null, null, '【人气推荐】黄晓明AB同款结婚礼服', null, null, null, '10', '1', '19999.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('56', null, null, null, '三亚风情之旅', null, null, null, '7', '1', '3999.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('57', null, null, null, '《中国迪拜--凤凰岛》', null, null, null, '9', '1', '6588.00', null, null, null, null, null);
INSERT INTO `goods_spu` VALUES ('58', null, null, null, '星锐经典套餐4688', null, null, null, '11', '0', '4688.00', null, null, null, null, null);

-- ----------------------------
-- Table structure for good_label
-- ----------------------------
DROP TABLE IF EXISTS `good_label`;
CREATE TABLE `good_label` (
  `label_id` int(4) NOT NULL COMMENT '标签id',
  `goods_id` varchar(20) DEFAULT NULL COMMENT '商品id',
  `label_content` varchar(20) DEFAULT NULL COMMENT '标签内容',
  `is_use` tinyint(2) NOT NULL COMMENT '是否可用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品标签';

-- ----------------------------
-- Records of good_label
-- ----------------------------

-- ----------------------------
-- Table structure for keyword_click
-- ----------------------------
DROP TABLE IF EXISTS `keyword_click`;
CREATE TABLE `keyword_click` (
  `keyword_id` varchar(100) NOT NULL COMMENT '主键',
  `package` varchar(100) DEFAULT NULL COMMENT '套餐',
  `key_case` varchar(100) DEFAULT NULL COMMENT '案例',
  `wedding_products` varchar(100) DEFAULT NULL COMMENT '婚品',
  `hotel` varchar(100) DEFAULT NULL COMMENT '酒店',
  `business` varchar(100) DEFAULT NULL COMMENT '商家',
  `topic` varchar(100) DEFAULT NULL COMMENT '话题',
  `question` varchar(100) DEFAULT NULL COMMENT '问答',
  `type_id` varchar(100) NOT NULL COMMENT '类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of keyword_click
-- ----------------------------
INSERT INTO `keyword_click` VALUES ('1', '中式婚礼套餐', '中式婚礼案例', '中式婚礼婚品', '中式婚礼酒店', '中式婚礼商家', '中式婚礼话题', '中式婚礼问答', '中式婚礼', '2018-02-06 12:39:54');
INSERT INTO `keyword_click` VALUES ('2', '草坪婚礼套餐', '草坪婚礼案例', '草坪婚礼婚品', '草坪婚礼酒店', '草坪婚礼商家', '草坪婚礼话题', '草坪婚礼问答', '草坪婚礼', '2018-02-06 12:41:42');
INSERT INTO `keyword_click` VALUES ('3', '蒂芙尼蓝套餐', '蒂芙尼蓝案例', '蒂芙尼蓝婚品', '蒂芙尼蓝酒店', '蒂芙尼蓝商家', '蒂芙尼蓝话题', '蒂芙尼蓝问答', '蒂芙尼蓝', '2018-02-06 12:42:50');
INSERT INTO `keyword_click` VALUES ('4', '森系婚礼套餐', '森系婚礼案例', '森系婚礼婚品', '森系婚礼酒店', '森系婚礼商家', '森系婚礼话题', '森系婚礼问答', '森系婚礼', '2018-02-06 12:43:33');

-- ----------------------------
-- Table structure for mobile_code
-- ----------------------------
DROP TABLE IF EXISTS `mobile_code`;
CREATE TABLE `mobile_code` (
  `mobile_code_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `mobile_code` datetime NOT NULL COMMENT '验证码',
  `state` int(4) DEFAULT NULL COMMENT '类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`mobile_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='手机验证';

-- ----------------------------
-- Records of mobile_code
-- ----------------------------
INSERT INTO `mobile_code` VALUES ('1', '137520807721', '0000-00-00 00:00:00', null, '2018-01-25 11:45:24');

-- ----------------------------
-- Table structure for new_goods
-- ----------------------------
DROP TABLE IF EXISTS `new_goods`;
CREATE TABLE `new_goods` (
  `goods_id` int(4) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(100) DEFAULT NULL,
  `goods_type` varchar(100) DEFAULT NULL,
  `goods_count` int(5) DEFAULT NULL,
  `goods_price` double(10,2) DEFAULT NULL,
  `goods_cover` varchar(20) DEFAULT NULL,
  `goods_case` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_use` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of new_goods
-- ----------------------------
INSERT INTO `new_goods` VALUES ('1', '锦江之星', '开业', null, '222.00', null, null, '2018-02-09 11:35:21', '1');
INSERT INTO `new_goods` VALUES ('2', '木之棉蛋糕房', '开业', '235', '222.00', 'http://muzhimian.png', '玫瑰之缘', '2018-02-09 11:47:50', '1');

-- ----------------------------
-- Table structure for personal_center
-- ----------------------------
DROP TABLE IF EXISTS `personal_center`;
CREATE TABLE `personal_center` (
  `user_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `again_password` varchar(200) DEFAULT NULL COMMENT '重复密码',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `address` varchar(50) DEFAULT NULL COMMENT '地址',
  `is_use` tinyint(2) DEFAULT NULL COMMENT '是否可用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of personal_center
-- ----------------------------
INSERT INTO `personal_center` VALUES ('1', '18622225892', '123456', '123456', '朱重八', '洛阳', '1', '2018-02-09 14:54:06');

-- ----------------------------
-- Table structure for plan_form
-- ----------------------------
DROP TABLE IF EXISTS `plan_form`;
CREATE TABLE `plan_form` (
  `plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `spu_id` int(11) DEFAULT NULL,
  `wedding_ceremony` varchar(10) DEFAULT NULL,
  `plan_time` datetime DEFAULT NULL,
  `booked_merchant` varchar(10) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of plan_form
-- ----------------------------

-- ----------------------------
-- Table structure for seller_reg
-- ----------------------------
DROP TABLE IF EXISTS `seller_reg`;
CREATE TABLE `seller_reg` (
  `seller_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机号',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `mobile_code` varchar(200) DEFAULT NULL COMMENT '验证码',
  `sms_code` varchar(20) DEFAULT NULL COMMENT '短信验证码',
  `is_use` tinyint(2) DEFAULT NULL COMMENT '是否可用',
  `state` varchar(200) DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of seller_reg
-- ----------------------------
INSERT INTO `seller_reg` VALUES ('41', '18622114720', '6e8825dc06755ac2e927b5f3935ffafa', '0b3E6y', '177410', '1', null, '2018-02-08 13:24:39');
INSERT INTO `seller_reg` VALUES ('42', '18622114720', '123456', null, null, null, null, null);

-- ----------------------------
-- Table structure for service_classification
-- ----------------------------
DROP TABLE IF EXISTS `service_classification`;
CREATE TABLE `service_classification` (
  `type_id` int(4) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `is_use` tinyint(2) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_classification
-- ----------------------------
INSERT INTO `service_classification` VALUES ('1', '婚礼策划', '1', '2018-02-28 13:21:27');
INSERT INTO `service_classification` VALUES ('2', '婚纱摄影', '1', '2018-02-28 13:21:29');
INSERT INTO `service_classification` VALUES ('3', '婚礼摄影', '1', '2018-02-28 13:21:37');
INSERT INTO `service_classification` VALUES ('4', '婚礼摄像', '1', '2018-02-28 13:21:39');
INSERT INTO `service_classification` VALUES ('5', '婚礼跟妆', '1', '2018-02-28 13:21:41');
INSERT INTO `service_classification` VALUES ('6', '婚礼司仪', '1', '2018-02-28 13:21:42');
INSERT INTO `service_classification` VALUES ('7', '婚纱礼服', '1', '2018-02-28 13:21:44');

-- ----------------------------
-- Table structure for service_package
-- ----------------------------
DROP TABLE IF EXISTS `service_package`;
CREATE TABLE `service_package` (
  `package_id` int(4) NOT NULL AUTO_INCREMENT,
  `spu_id` int(4) DEFAULT NULL,
  `type_id` int(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_package
-- ----------------------------
INSERT INTO `service_package` VALUES ('1', '18', '1', '2018-02-01 14:06:37');
INSERT INTO `service_package` VALUES ('2', '19', '1', '2018-02-01 14:06:40');
INSERT INTO `service_package` VALUES ('3', '20', '1', '2018-02-01 14:06:43');
INSERT INTO `service_package` VALUES ('4', '21', '1', '2018-02-01 14:06:46');
INSERT INTO `service_package` VALUES ('5', '22', '1', '2018-02-01 14:06:48');
INSERT INTO `service_package` VALUES ('6', '23', '2', '2018-02-02 14:06:51');
INSERT INTO `service_package` VALUES ('7', '24', '2', '2018-02-02 14:06:53');
INSERT INTO `service_package` VALUES ('8', '25', '2', '2018-02-02 14:06:56');
INSERT INTO `service_package` VALUES ('9', '26', '2', '2018-02-02 14:06:58');
INSERT INTO `service_package` VALUES ('10', '27', '2', '2018-02-02 14:07:03');
INSERT INTO `service_package` VALUES ('11', '28', '3', '2018-02-03 14:07:06');
INSERT INTO `service_package` VALUES ('12', '29', '3', '2018-02-03 14:07:08');
INSERT INTO `service_package` VALUES ('13', '30', '3', '2018-02-03 14:07:10');
INSERT INTO `service_package` VALUES ('14', '31', '3', '2018-02-03 14:07:12');
INSERT INTO `service_package` VALUES ('15', '32', '3', '2018-02-03 14:07:15');
INSERT INTO `service_package` VALUES ('16', '33', '4', '2018-02-04 14:07:18');
INSERT INTO `service_package` VALUES ('17', '34', '4', '2018-02-04 14:07:21');
INSERT INTO `service_package` VALUES ('18', '35', '4', '2018-02-04 14:07:23');
INSERT INTO `service_package` VALUES ('19', '36', '4', '2018-02-04 14:07:26');
INSERT INTO `service_package` VALUES ('20', '37', '4', '2018-02-04 14:07:28');
INSERT INTO `service_package` VALUES ('21', '38', '5', '2018-02-05 14:07:30');
INSERT INTO `service_package` VALUES ('22', '39', '5', '2018-02-05 14:07:33');
INSERT INTO `service_package` VALUES ('23', '40', '5', '2018-02-05 14:07:35');
INSERT INTO `service_package` VALUES ('24', '41', '5', '2018-02-05 14:07:38');
INSERT INTO `service_package` VALUES ('25', '42', '5', '2018-02-05 14:07:40');
INSERT INTO `service_package` VALUES ('26', '43', '6', '2018-02-06 14:07:42');
INSERT INTO `service_package` VALUES ('27', '44', '6', '2018-02-06 14:07:45');
INSERT INTO `service_package` VALUES ('28', '45', '6', '2018-02-06 14:07:47');
INSERT INTO `service_package` VALUES ('29', '46', '6', '2018-02-06 14:07:50');
INSERT INTO `service_package` VALUES ('30', '47', '6', '2018-02-06 14:07:52');
INSERT INTO `service_package` VALUES ('31', '48', '7', '2018-02-07 14:07:56');
INSERT INTO `service_package` VALUES ('32', '49', '7', '2018-02-07 14:08:00');
INSERT INTO `service_package` VALUES ('33', '50', '7', '2018-02-07 14:08:02');
INSERT INTO `service_package` VALUES ('34', '51', '7', '2018-02-07 14:08:04');
INSERT INTO `service_package` VALUES ('35', '52', '7', '2018-02-07 14:08:06');

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shop_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '商家id',
  `shop_title` varchar(200) DEFAULT NULL COMMENT '商家名字',
  `shop_logo` varchar(1000) DEFAULT NULL COMMENT 'LOGO',
  `shop_desc` varchar(1000) DEFAULT NULL COMMENT '简介',
  `shop_user` varchar(20) DEFAULT NULL COMMENT '商家用户名',
  `shop_code` varchar(32) DEFAULT NULL COMMENT '商家编号',
  `shop_password` varchar(20) DEFAULT NULL COMMENT '商家密码',
  `shop_attribute` int(4) DEFAULT NULL COMMENT '商家属性',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='商家';

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES ('1', '木棉之家蛋糕房', '木棉之家LOGO', '用心做蛋糕', null, '1009', '0', null, '2018-01-24 13:31:07');
INSERT INTO `shop` VALUES ('2', '韩版婚纱店', '婚纱店LOGO', '抹胸婚纱', null, '1100', null, null, '2018-02-06 09:34:50');
INSERT INTO `shop` VALUES ('3', '婚车租赁公司', '婚车租赁LOGO', '婚车租赁', null, '1200', null, null, '2018-02-06 09:34:53');
INSERT INTO `shop` VALUES ('4', '嘉宾晓光', '晓光LOGO', '刘小光', null, '1300', null, null, '2018-02-06 09:34:55');
INSERT INTO `shop` VALUES ('5', '甜品桌店', '甜品桌LOGO', '甜品桌', null, '1400', null, null, '2018-02-06 09:34:57');
INSERT INTO `shop` VALUES ('6', '大管家租赁', '大管家LOGO', '赵一', null, '1500', null, null, '2018-02-06 09:35:01');
INSERT INTO `shop` VALUES ('7', '婚品采购店', '婚品LOGO', '婚品采购', null, '1600', null, null, '2018-02-06 09:35:03');
INSERT INTO `shop` VALUES ('8', '婚礼请柬', '请柬LOGO', '婚礼请柬', null, '1700', null, null, '2018-02-06 09:35:05');
INSERT INTO `shop` VALUES ('9', '滴滴打车', '滴滴LOGO', '专车出行', null, '1800', null, null, '2018-02-06 09:35:08');
INSERT INTO `shop` VALUES ('10', '优步打车', '优步LOGO', '一键打车', null, '1900', null, null, '2018-02-06 09:35:11');
INSERT INTO `shop` VALUES ('11', 'bilibili', '动漫LOGO', '动漫集结', null, '2000', null, null, '2018-02-06 09:35:13');
INSERT INTO `shop` VALUES ('12', '郊外影楼', '影楼LOGO', '如影随形', null, '2100', null, null, '2018-02-06 09:35:16');
INSERT INTO `shop` VALUES ('13', '123婚车租赁', '123租LOGO', '便捷服务', null, '2200', null, null, '2018-02-06 13:44:36');
INSERT INTO `shop` VALUES ('14', null, null, null, '18622114720', null, '123456', null, null);

-- ----------------------------
-- Table structure for shop_detail
-- ----------------------------
DROP TABLE IF EXISTS `shop_detail`;
CREATE TABLE `shop_detail` (
  `detail_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '详情id',
  `shop_code` varchar(32) DEFAULT NULL COMMENT '商家编号',
  `shop_name` varchar(50) DEFAULT NULL COMMENT '商家名称',
  `shop_phone` varchar(20) DEFAULT NULL COMMENT '商家电话',
  `detail_tell` varchar(20) DEFAULT NULL COMMENT '门店座机',
  `shop_mail` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `address_id` varchar(10) DEFAULT NULL COMMENT '所在地',
  `details_img` varchar(200) DEFAULT NULL COMMENT '案例图片',
  `detail_video` varchar(200) DEFAULT NULL COMMENT '案例视频',
  `shop_business` varchar(200) DEFAULT NULL COMMENT '营业执照',
  `detail_code` varchar(25) DEFAULT NULL COMMENT '法人身份证',
  `detail_remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `is_use` tinyint(2) DEFAULT NULL COMMENT '是否可用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商家详情';

-- ----------------------------
-- Records of shop_detail
-- ----------------------------
INSERT INTO `shop_detail` VALUES ('1', null, '天津婚车租赁', '18752256877', null, null, '天津塘沽区', null, null, '许可', '宝木秋水', null, '1', '2018-02-23 14:08:21');
INSERT INTO `shop_detail` VALUES ('2', null, '南京婚车租赁', '18555555555', null, null, '南京鼓楼区', null, null, '许可', '宝木秋水', null, '1', '2018-02-23 14:10:07');
INSERT INTO `shop_detail` VALUES ('3', null, '北京婚车租赁', '18622224772', '66311579', '10802793@qq.com', '北京海淀区', '婚车网排行', null, '签售许可', '宝木秋水', 'xxxxxxxxxxxx', '1', '2018-02-06 17:09:56');
INSERT INTO `shop_detail` VALUES ('4', null, '广东婚车租赁', '15962274252', null, null, '深圳福田区', null, null, '签售许可', '宝木秋水', null, '1', '2018-02-26 11:58:31');

-- ----------------------------
-- Table structure for sms
-- ----------------------------
DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms` (
  `sms_id` int(12) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sms_phone` varchar(20) NOT NULL COMMENT '手机号',
  `sms_code` varchar(10) NOT NULL COMMENT '验证码',
  `is_use` int(2) DEFAULT NULL COMMENT '是否可用',
  `sms_status` int(2) DEFAULT NULL COMMENT '状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`sms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sms
-- ----------------------------
INSERT INTO `sms` VALUES ('37', '18622114720', '661849', '1', '1', '2018-02-01 18:04:36');
INSERT INTO `sms` VALUES ('38', '18622114720', '469744', '1', '1', '2018-02-08 12:30:29');
INSERT INTO `sms` VALUES ('39', '18622114720', '160618', '1', '1', '2018-02-08 12:31:59');
INSERT INTO `sms` VALUES ('40', '18622114720', '963197', '1', '1', '2018-02-08 12:41:34');
INSERT INTO `sms` VALUES ('41', '18622114720', '440166', '1', '1', '2018-02-08 14:22:10');
INSERT INTO `sms` VALUES ('42', '18526468617', '845494', '1', '1', '2018-03-07 11:38:24');
INSERT INTO `sms` VALUES ('43', '18526468617', '858543', '1', '1', '2018-03-07 11:41:14');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `user_name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `head_photo` varchar(1000) DEFAULT NULL COMMENT '头像url',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_password` varchar(32) NOT NULL,
  `user_address` varchar(1000) DEFAULT NULL,
  `is_use` int(11) DEFAULT '1' COMMENT '是否可用',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('16', '18622114720', null, null, null, '2018-02-23 15:12:06', '', null, '0');
INSERT INTO `user` VALUES ('17', '13762890876', 'qwe', 'qwe', 'swdgfdsg.jpg', '2018-02-23 15:20:52', 'sadfdsgf', null, '0');
INSERT INTO `user` VALUES ('24', '137628908776', 'qwsde', 'qsdgfwe', 'swdgfdsg.jpg', '2018-02-23 14:46:30', 'sadfdsgf', null, '1');

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `add_id` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(12) NOT NULL COMMENT '用户id',
  `add_receiver` varchar(50) DEFAULT NULL COMMENT '收货人',
  `add_mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `area_path` varchar(300) NOT NULL COMMENT '详细地址',
  `is_default` tinyint(2) NOT NULL COMMENT '是否默认',
  `is_user` tinyint(2) NOT NULL COMMENT '是否有用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`add_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收货地址表';

-- ----------------------------
-- Records of user_address
-- ----------------------------

-- ----------------------------
-- Table structure for user_carts
-- ----------------------------
DROP TABLE IF EXISTS `user_carts`;
CREATE TABLE `user_carts` (
  `carts_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `user_id` int(4) DEFAULT NULL COMMENT '会员id',
  `spu_id` int(4) DEFAULT NULL COMMENT '商品id',
  `goods_num` int(10) NOT NULL COMMENT '数量',
  `carts_price` double NOT NULL,
  `is_use` tinyint(2) NOT NULL COMMENT '1,完成 0，未完成',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`carts_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户购物车';

-- ----------------------------
-- Records of user_carts
-- ----------------------------
INSERT INTO `user_carts` VALUES ('1', '17', '1', '20', '74.5', '0', '2018-02-14 15:13:36');
INSERT INTO `user_carts` VALUES ('2', '17', '2', '21', '50.55', '1', '2018-02-24 15:13:47');

-- ----------------------------
-- Table structure for user_myshop
-- ----------------------------
DROP TABLE IF EXISTS `user_myshop`;
CREATE TABLE `user_myshop` (
  `detail_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '详情id',
  `shop_code` varchar(32) DEFAULT NULL COMMENT '商家编号',
  `myshop_name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `myshop_phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `myshop_license` varchar(20) DEFAULT NULL COMMENT '驾驶证',
  `myshop_license_code` varchar(50) DEFAULT NULL COMMENT '行驶证',
  `address_id` varchar(10) DEFAULT NULL COMMENT '所在地',
  `details_img` varchar(200) DEFAULT NULL COMMENT '案例图片',
  `detail_video` varchar(200) DEFAULT NULL COMMENT '案例视频',
  `myshop_mail` varchar(200) DEFAULT NULL COMMENT '电子邮箱',
  `myshop_code` varchar(200) DEFAULT NULL COMMENT '身份证',
  `myshop_id` char(10) DEFAULT NULL COMMENT '手持身份证',
  `myshop_remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `is_use` tinyint(2) DEFAULT NULL COMMENT '是否可用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='个人商家';

-- ----------------------------
-- Records of user_myshop
-- ----------------------------
INSERT INTO `user_myshop` VALUES ('1', null, '赵一婚车租赁', '13752837896', '12222', '12222', '天津', null, null, '29292777@qq.com', '226512', '153264', '车神赵一天', '1', '2018-02-01 11:38:31');
INSERT INTO `user_myshop` VALUES ('2', null, '钱二婚车租赁', '13965232585', '22222', '22222', '成都', null, null, '38292777@qq.com', null, null, null, '1', '2018-02-02 11:38:42');
INSERT INTO `user_myshop` VALUES ('3', null, '孙三婚车租赁', '13820846558', '32222', '32222', '北京', null, null, '58592777@qq.com', null, null, null, '1', '2018-02-03 11:38:45');
INSERT INTO `user_myshop` VALUES ('4', null, '李四婚车租赁', '15266687652', '42222', '42222', '天津', null, null, '22925877@qq.com', '12222222222222', null, null, '1', '2018-02-04 11:39:00');
INSERT INTO `user_myshop` VALUES ('5', null, '周五婚车租赁', '15528568722', '52222', '52222', '上海', null, null, '51292257@qq.com', null, null, null, '1', '2018-02-05 11:39:04');
INSERT INTO `user_myshop` VALUES ('6', null, '吴六婚车租赁', '13328055852', '62222', '62222', '南京', null, null, '25855587@qq.com', null, null, null, '1', '2018-02-06 11:39:08');
INSERT INTO `user_myshop` VALUES ('7', null, '郑七婚车租赁', '18755587585', '72222', '72222', '广东', null, null, '35892247@qq.com', null, null, null, '1', '2018-02-07 11:39:11');
INSERT INTO `user_myshop` VALUES ('9', null, '大管家赵一', '16658743522', '82222', '82222', '天津', null, null, '35353537@qq.com', '12255353535885', null, null, '1', '2018-03-05 10:40:25');

-- ----------------------------
-- Table structure for user_pay
-- ----------------------------
DROP TABLE IF EXISTS `user_pay`;
CREATE TABLE `user_pay` (
  `pay_id` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(12) DEFAULT NULL COMMENT '用户id',
  `pay_way` tinyint(2) NOT NULL COMMENT '支付方式',
  `add_money` double(10,2) DEFAULT NULL COMMENT '交易金额',
  `pay_flag` tinyint(2) NOT NULL COMMENT '是否有效',
  `trade_no` varchar(100) NOT NULL COMMENT '外部流水号',
  `pay_remark` varchar(200) NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户支付表';

-- ----------------------------
-- Records of user_pay
-- ----------------------------
