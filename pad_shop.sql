/*
Navicat MySQL Data Transfer

Source Server         : 主库
Source Server Version : 50716
Source Host           : 192.168.1.252:3306
Source Database       : pad_shop

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2016-11-11 09:23:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `pad_admin_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_admin_info`;
CREATE TABLE `pad_admin_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `admin_account` char(15) NOT NULL COMMENT '管理员账号',
  `admin_pass` char(32) NOT NULL COMMENT '管理员密码',
  `admin_salt` char(10) NOT NULL COMMENT '密码盐值',
  `admin_name` varchar(30) DEFAULT NULL COMMENT '管理员姓名',
  `admin_mobile` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态信息,1:正常,2:停用,99:删除',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员信息表';

-- ----------------------------
-- Records of pad_admin_info
-- ----------------------------
INSERT INTO `pad_admin_info` VALUES ('1', 'admin', '5efc2b563780668b9810e46883052ea0', 'jeTOxri3FN', 'admin', '15912345677', '1', '1461122460', '1461131124', '1');

-- ----------------------------
-- Table structure for `pad_admin_logs`
-- ----------------------------
DROP TABLE IF EXISTS `pad_admin_logs`;
CREATE TABLE `pad_admin_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `control_name` varchar(15) NOT NULL COMMENT '控制器名称',
  `action_name` varchar(15) NOT NULL COMMENT '动作名称',
  `ip_address` varchar(15) NOT NULL COMMENT '登录IP',
  `log_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '日志类型',
  `log_msg` varchar(255) NOT NULL COMMENT '日志内容',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员日志信息表';

-- ----------------------------
-- Records of pad_admin_logs
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_admin_roles`
-- ----------------------------
DROP TABLE IF EXISTS `pad_admin_roles`;
CREATE TABLE `pad_admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(20) NOT NULL COMMENT '角色名称',
  `role_powers` varchar(255) DEFAULT NULL COMMENT '角色权限集合,权限以逗号间隔',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '角色状态,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员角色信息表';

-- ----------------------------
-- Records of pad_admin_roles
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_advert_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_advert_info`;
CREATE TABLE `pad_advert_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '广告ID',
  `advert_name` varchar(30) NOT NULL COMMENT '广告名称',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布来源,0:平台发布,其余对应酒店ID',
  `advertiser_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '广告主ID',
  `advert_position` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '广告位置，1:首页广告',
  `hotel_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '展示商户数',
  `exposure_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '累计曝光数',
  `release_time` varchar(23) DEFAULT NULL COMMENT '投放时间,展示用(例:2016.01.03 - 2016.01.10)',
  `begin_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投放开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投放结束时间',
  `weight` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '位置权重,权重系数0-5,数字越大广告位置越前',
  `material_type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '素材类型,1:图片,2:视频',
  `source_path` varchar(255) DEFAULT NULL COMMENT '素材来源地址(主广告图/广告视频)',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '广告缩略图',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='广告内容基础信息表';

-- ----------------------------
-- Records of pad_advert_info
-- ----------------------------
INSERT INTO `pad_advert_info` VALUES ('1', '广告测试数据', '1', '1', '1', '1', '0', '2016.11.03 - 2017.11.03', '1478102400', '1509724799', '1', '1', '/', '/', '1478662289', '1478662289', '1');

-- ----------------------------
-- Table structure for `pad_advert_release`
-- ----------------------------
DROP TABLE IF EXISTS `pad_advert_release`;
CREATE TABLE `pad_advert_release` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '发布ID',
  `advert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '广告ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `begin_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投放开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投放结束时间',
  `exposure_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '曝光数',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='广告发布信息表';

-- ----------------------------
-- Records of pad_advert_release
-- ----------------------------
INSERT INTO `pad_advert_release` VALUES ('1', '1', '1', '1478102400', '1509724799', '0', '1');

-- ----------------------------
-- Table structure for `pad_advertisers_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_advertisers_info`;
CREATE TABLE `pad_advertisers_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告主ID',
  `advert_name` varchar(50) NOT NULL COMMENT '广告主名称',
  `company_name` varchar(50) DEFAULT NULL COMMENT '公司名称',
  `industry_desc` varchar(255) NOT NULL COMMENT '行业描述,以英文逗号间隔行业ID',
  `contacts` varchar(15) DEFAULT NULL COMMENT '联系人',
  `contact_way` varchar(20) DEFAULT NULL COMMENT '联系方式',
  `advert_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '当前发布广告数',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告主基础信息表';

-- ----------------------------
-- Records of pad_advertisers_info
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_app_logs`
-- ----------------------------
DROP TABLE IF EXISTS `pad_app_logs`;
CREATE TABLE `pad_app_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'APP操作日志ID',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间ID',
  `device_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '设备ID',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '员工ID',
  `operate_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '操作类型(1:迷你吧入账,2:改房态,3:查房反馈)',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '记录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='客房操作日志记录表';

-- ----------------------------
-- Records of pad_app_logs
-- ----------------------------
INSERT INTO `pad_app_logs` VALUES ('1', '1', '1', '1', '1', '1478769872');
INSERT INTO `pad_app_logs` VALUES ('2', '1', '1', '1', '1', '1478773965');

-- ----------------------------
-- Table structure for `pad_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `pad_auth_group`;
CREATE TABLE `pad_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `title` char(100) NOT NULL DEFAULT '' COMMENT '组名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用、0：停用',
  `rules` char(80) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则","隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员组';

-- ----------------------------
-- Records of pad_auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `pad_auth_group_access`;
CREATE TABLE `pad_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL COMMENT '管理员id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '管理员组ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组明细';

-- ----------------------------
-- Records of pad_auth_group_access
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `pad_auth_rule`;
CREATE TABLE `pad_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `pid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上级ID',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则名称,规则唯一标识;如：Admin/Index/index',
  `icon_name` varchar(20) NOT NULL COMMENT '图标名称',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则名称',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型：1:应用、2：控制器、3：方法  ',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用、0：停用',
  `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1：显示 、0：不显示',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则附件条件,满足附加条件的规则,才认为是有效的规则',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_index` (`name`) USING BTREE,
  KEY `pid_status_show_index` (`pid`,`status`,`is_show`) USING BTREE,
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='认证规则';

-- ----------------------------
-- Records of pad_auth_rule
-- ----------------------------
INSERT INTO `pad_auth_rule` VALUES ('1', '0', 'System', 'icon-cogs', '系统管理', '1', '1', '1', '10', '');
INSERT INTO `pad_auth_rule` VALUES ('2', '1', 'Admin/Node', 'icon-user-md', '权限管理', '2', '1', '1', '0', '');
INSERT INTO `pad_auth_rule` VALUES ('3', '2', 'Admin/Node/index', 'icon-key', '权限节点', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('4', '2', 'Admin/Node/addNode', '', '添加节点', '3', '1', '0', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('5', '2', 'Admin/Node/editNode', '', '编辑节点', '3', '1', '0', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('6', '2', 'Admin/Node/user', 'icon-user', '用户管理', '3', '1', '1', '4', '');
INSERT INTO `pad_auth_rule` VALUES ('7', '2', 'Admin/Node/', 'icon-group', '组别管理', '3', '1', '1', '5', '');
INSERT INTO `pad_auth_rule` VALUES ('8', '0', 'Shop', 'icon-user', '商户管理', '1', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('9', '8', 'Admin/Shop', 'icon-wrench', '商户信息维护', '2', '1', '1', '0', '');
INSERT INTO `pad_auth_rule` VALUES ('10', '9', 'Admin/Shop/index', 'icon-group', '商户列表', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('11', '9', 'Admin/Shop/floor', 'icon-building', '楼层管理', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('12', '9', 'Admin/Shop/device', 'icon-h-sign', '设备管理', '3', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('13', '8', 'Admin/Shopsetiing', ' icon-picture', '商户界面设置', '2', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('14', '13', 'Admin/Shopsetting/service', 'icon-comment', '酒店服务指南', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('15', '13', 'Admin/Shopsetting/wifi', 'icon-rss', 'WIFI服务', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('16', '13', 'Admin/Shopsetting/tel', 'icon-tablet', '服务电话', '3', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('17', '13', 'Admin/Shopsetting/room', ' icon-building', '客房服务', '3', '1', '1', '4', '');
INSERT INTO `pad_auth_rule` VALUES ('18', '0', 'Admin/Adv', 'icon-desktop', '广告管理', '2', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('19', '18', 'Admin/Adv/advMain', 'icon-bar-chart', '广告主信息', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('20', '18', 'Admin/Adv/advRelease', 'icon-tags', '广告发布', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('21', '0', 'Admin/Room', 'icon-key', '客房管理', '2', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('22', '21', 'Admin/Room/infoFind', 'icon-zoom-in', '客房信息查询', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('23', '21', 'Admin/Room/serviceFind', 'icon-th-large', '客房服务查询', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('24', '0', 'Mall', 'icon-shopping-cart', '商城管理', '1', '1', '1', '4', '');
INSERT INTO `pad_auth_rule` VALUES ('25', '24', 'Admin/Goods', 'icon-heart', '商品管理', '2', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('26', '25', 'Admin/Goods/index', 'icon-align-justify', '商品列表', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('27', '25', 'Admin/Goods/cate', 'icon-copy', '商品分类', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('28', '25', 'Admin/Goods/makeCode', 'icon-barcode', '商品编号配对', '3', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('29', '24', 'Admin/Stock', 'icon-table', '库存管理', '2', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('30', '29', 'Admin/Stock/purchase', 'icon-sitemap', '采购管理', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('31', '29', 'Admin/Stock/setting', 'icon-book', '库存设置和分配', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('32', '24', 'Admin/Mall/orderFind', 'icon-search', '订单查询', '3', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('33', '0', 'Report', 'icon-list-alt', '报表管理', '2', '1', '1', '5', '');
INSERT INTO `pad_auth_rule` VALUES ('34', '33', 'Admin/Report/orderReport', 'icon-money', '迷你吧订单报表', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('35', '33', 'Admin/Report/debtOrder', 'icon-list-alt', '入账订单报表', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('36', '33', 'Admin/Report/consume', 'icon-list-ol', '消费账目报表', '3', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('37', '1', 'Admin/Baseinfo', 'icon-file-alt', '基础信息管理', '2', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('38', '37', 'Admin/Baseinfo/shopType', 'icon-tag', '商户类型标签', '3', '1', '1', '1', '');
INSERT INTO `pad_auth_rule` VALUES ('39', '37', 'Admin/Baseinfo/tradeCate', 'icon-bookmark', '行业分类标签', '3', '1', '1', '2', '');
INSERT INTO `pad_auth_rule` VALUES ('40', '37', 'Admin/Baseinfo/roomService', 'icon-certificate', '客房服务信息', '3', '1', '1', '3', '');
INSERT INTO `pad_auth_rule` VALUES ('41', '37', 'Admin/Baseinfo/iconList', 'icon-lightbulb', 'icon图标维护', '3', '1', '1', '4', '');
INSERT INTO `pad_auth_rule` VALUES ('42', '9', 'Admin/Shop/add', 'icon', '添加商户', '3', '1', '0', '0', '');

-- ----------------------------
-- Table structure for `pad_building_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_building_info`;
CREATE TABLE `pad_building_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '楼宇ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `floor_ids` varchar(255) DEFAULT NULL COMMENT '楼层ID集合,以|分割ID',
  `floor_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '总楼层数',
  `room_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总房间数',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '楼宇状态, 1: 有效, 2: 无效, 99: 删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='楼宇基础信息表';

-- ----------------------------
-- Records of pad_building_info
-- ----------------------------
INSERT INTO `pad_building_info` VALUES ('1', '1', '1,2,3', '3', '3', '1');

-- ----------------------------
-- Table structure for `pad_business_district`
-- ----------------------------
DROP TABLE IF EXISTS `pad_business_district`;
CREATE TABLE `pad_business_district` (
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `trade_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商圈ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='酒店所属商圈信息表';

-- ----------------------------
-- Records of pad_business_district
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_category_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_category_info`;
CREATE TABLE `pad_category_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(30) NOT NULL COMMENT '分类名称',
  `category_desc` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='行业分类基础信息';

-- ----------------------------
-- Records of pad_category_info
-- ----------------------------
INSERT INTO `pad_category_info` VALUES ('1', 'vv', 'aa', '1');
INSERT INTO `pad_category_info` VALUES ('5', 'bbbb', 'ccc', '1');

-- ----------------------------
-- Table structure for `pad_city_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_city_info`;
CREATE TABLE `pad_city_info` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `city_name` char(50) NOT NULL COMMENT '城市名称',
  `all_name` char(255) DEFAULT NULL COMMENT '城市全称',
  `city_domain` char(30) DEFAULT NULL COMMENT '城市域名',
  `first_letter` char(1) DEFAULT NULL COMMENT '名称首字母',
  `city_jianpin` char(10) DEFAULT NULL COMMENT '城市简拼',
  `city_qp` char(50) DEFAULT NULL COMMENT '城市全拼',
  `circle_code` char(10) DEFAULT NULL COMMENT '城市编码',
  `parent_id` int(10) unsigned DEFAULT '0' COMMENT '上级城市ID',
  `city_level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '城市级别',
  `city_msg` char(255) DEFAULT NULL COMMENT '城市信息(备注)',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '城市状态信息, 1:启用,2:停用,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='城市商圈信息表';

-- ----------------------------
-- Records of pad_city_info
-- ----------------------------
INSERT INTO `pad_city_info` VALUES ('1', '全国', '全国', null, null, null, null, null, '0', '0', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110000', '北京', '北京', null, 'B', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110100', '北京市', '北京·北京市', null, 'B', null, null, null, '110000', '2', '', '1466752634', '1466752634', '1');
INSERT INTO `pad_city_info` VALUES ('110101', '东城区', '北京·北京市·东城区', null, 'D', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110102', '西城区', '北京·北京市·西城区', null, 'X', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110103', '崇文区', '北京·北京市·崇文区', null, 'C', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110104', '宣武区', '北京·北京市·宣武区', null, 'X', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110105', '朝阳区', '北京·北京市·朝阳区', null, 'C', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110106', '丰台区', '北京·北京市·丰台区', null, 'F', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110107', '石景山区', '北京·北京市·石景山区', null, 'S', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110108', '海淀区', '北京·北京市·海淀区', null, 'H', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110109', '门头沟区', '北京·北京市·门头沟区', null, 'M', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110111', '房山区', '北京·北京市·房山区', null, 'F', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110112', '通州区', '北京·北京市·通州区', null, 'T', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110113', '顺义区', '北京·北京市·顺义区', null, 'S', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110114', '昌平区', '北京·北京市·昌平区', null, 'C', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110115', '大兴区', '北京·北京市·大兴区', null, 'D', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110116', '怀柔区', '北京·北京市·怀柔区', null, 'H', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110117', '平谷区', '北京·北京市·平谷区', null, 'P', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110228', '密云县', '北京·北京市·密云县', null, 'M', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110229', '延庆县', '北京·北京市·延庆县', null, 'Y', null, null, null, '110100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120000', '天津', '天津', null, 't', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120100', '天津市', '天津·天津市', null, 'T', null, null, null, '120000', '2', '天津', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120101', '和平区', '天津·天津市·和平区', null, 'H', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120102', '河东区', '天津·天津市·河东区', null, 'H', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120103', '河西区', '天津·天津市·河西区', null, 'H', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120104', '南开区', '天津·天津市·南开区', null, 'N', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120105', '河北区', '天津·天津市·河北区', null, 'H', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120106', '红桥区', '天津·天津市·红桥区', null, 'H', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120107', '塘沽区', '天津·天津市·塘沽区', null, 'T', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120108', '汉沽区', '天津·天津市·汉沽区', null, 'H', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120109', '大港区', '天津·天津市·大港区', null, 'D', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120110', '东丽区', '天津·天津市·东丽区', null, 'D', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120111', '西青区', '天津·天津市·西青区', null, 'X', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120112', '津南区', '天津·天津市·津南区', null, 'J', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120113', '北辰区', '天津·天津市·北辰区', null, 'B', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120114', '武清区', '天津·天津市·武清区', null, 'W', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120115', '宝坻区', '天津·天津市·宝坻区', null, 'B', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120116', '滨海新区', '天津·天津市·滨海新区', null, 'B', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120221', '宁河县', '天津·天津市·宁河县', null, 'N', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120223', '静海县', '天津·天津市·静海县', null, 'J', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('120225', '蓟县', '天津·天津市·蓟县', null, 'J', null, null, null, '120100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130000', '河北省', '河北省', null, 'H', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130100', '石家庄市', '河北省·石家庄市', null, 'S', null, null, null, '130000', '2', '', '1466752668', '1466752668', '1');
INSERT INTO `pad_city_info` VALUES ('130102', '长安区', '河北省·石家庄市·长安区', null, 'Z', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130103', '桥东区', '河北省·石家庄市·桥东区', null, 'Q', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130104', '桥西区', '河北省·石家庄市·桥西区', null, 'Q', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130105', '新华区', '河北省·石家庄市·新华区', null, 'X', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130107', '井陉矿区', '河北省·石家庄市·井陉矿区', null, 'J', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130108', '裕华区', '河北省·石家庄市·裕华区', null, 'Y', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130121', '井陉县', '河北省·石家庄市·井陉县', null, 'J', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130123', '正定县', '河北省·石家庄市·正定县', null, 'Z', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130124', '栾城县', '河北省·石家庄市·栾城县', null, 'L', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130125', '行唐县', '河北省·石家庄市·行唐县', null, 'H', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130126', '灵寿县', '河北省·石家庄市·灵寿县', null, 'L', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130127', '高邑县', '河北省·石家庄市·高邑县', null, 'G', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130128', '深泽县', '河北省·石家庄市·深泽县', null, 'S', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130129', '赞皇县', '河北省·石家庄市·赞皇县', null, 'Z', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130130', '无极县', '河北省·石家庄市·无极县', null, 'W', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130131', '平山县', '河北省·石家庄市·平山县', null, 'P', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130132', '元氏县', '河北省·石家庄市·元氏县', null, 'Y', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130133', '赵县', '河北省·石家庄市·赵县', null, 'Z', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130181', '辛集市', '河北省·石家庄市·辛集市', null, 'X', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130182', '藁城市', '河北省·石家庄市·藁城市', null, 'G', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130183', '晋州市', '河北省·石家庄市·晋州市', null, 'J', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130184', '新乐市', '河北省·石家庄市·新乐市', null, 'X', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130185', '鹿泉市', '河北省·石家庄市·鹿泉市', null, 'L', null, null, null, '130100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130200', '唐山市', '河北省·唐山市', null, 'T', null, null, null, '130000', '2', '唐山市', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130202', '路南区', '河北省·唐山市·路南区', null, 'L', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130203', '路北区', '河北省·唐山市·路北区', null, 'L', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130204', '古冶区', '河北省·唐山市·古冶区', null, 'G', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130205', '开平区', '河北省·唐山市·开平区', null, 'K', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130207', '丰南区', '河北省·唐山市·丰南区', null, 'F', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130208', '丰润区', '河北省·唐山市·丰润区', null, 'F', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130223', '滦县', '河北省·唐山市·滦县', null, 'L', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130224', '滦南县', '河北省·唐山市·滦南县', null, 'L', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130225', '乐亭县', '河北省·唐山市·乐亭县', null, 'L', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130227', '迁西县', '河北省·唐山市·迁西县', null, 'Q', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130229', '玉田县', '河北省·唐山市·玉田县', null, 'Y', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130230', '唐海县', '河北省·唐山市·唐海县', null, 'T', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130281', '遵化市', '河北省·唐山市·遵化市', null, 'Z', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130283', '迁安市', '河北省·唐山市·迁安市', null, 'Q', null, null, null, '130200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130300', '秦皇岛市', '河北省·秦皇岛市', null, 'Q', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130302', '海港区', '河北省·秦皇岛市·海港区', null, 'H', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130303', '山海关区', '河北省·秦皇岛市·山海关区', null, 'S', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130304', '北戴河区', '河北省·秦皇岛市·北戴河区', null, 'B', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130321', '青龙满族自治县', '河北省·秦皇岛市·青龙满族自治县', null, 'Q', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130322', '昌黎县', '河北省·秦皇岛市·昌黎县', null, 'C', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130323', '抚宁县', '河北省·秦皇岛市·抚宁县', null, 'F', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130324', '卢龙县', '河北省·秦皇岛市·卢龙县', null, 'L', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130399', '经济技术开发区', '河北省·秦皇岛市·经济技术开发区', null, 'J', null, null, null, '130300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130400', '邯郸市', '河北省·邯郸市', null, 'H', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130402', '邯山区', '河北省·邯郸市·邯山区', null, 'H', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130403', '丛台区', '河北省·邯郸市·丛台区', null, 'C', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130404', '复兴区', '河北省·邯郸市·复兴区', null, 'F', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130406', '峰峰矿区', '河北省·邯郸市·峰峰矿区', null, 'F', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130421', '邯郸县', '河北省·邯郸市·邯郸县', null, 'H', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130423', '临漳县', '河北省·邯郸市·临漳县', null, 'L', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130424', '成安县', '河北省·邯郸市·成安县', null, 'C', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130425', '大名县', '河北省·邯郸市·大名县', null, 'D', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130426', '涉县', '河北省·邯郸市·涉县', null, 'S', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130427', '磁县', '河北省·邯郸市·磁县', null, 'C', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130428', '肥乡县', '河北省·邯郸市·肥乡县', null, 'F', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130429', '永年县', '河北省·邯郸市·永年县', null, 'Y', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130430', '邱县', '河北省·邯郸市·邱县', null, 'Q', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130431', '鸡泽县', '河北省·邯郸市·鸡泽县', null, 'J', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130432', '广平县', '河北省·邯郸市·广平县', null, 'G', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130433', '馆陶县', '河北省·邯郸市·馆陶县', null, 'G', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130434', '魏县', '河北省·邯郸市·魏县', null, 'W', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130435', '曲周县', '河北省·邯郸市·曲周县', null, 'Q', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130481', '武安市', '河北省·邯郸市·武安市', null, 'W', null, null, null, '130400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130500', '邢台市', '河北省·邢台市', null, 'X', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130502', '桥东区', '河北省·邢台市·桥东区', null, 'Q', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130503', '桥西区', '河北省·邢台市·桥西区', null, 'Q', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130521', '邢台县', '河北省·邢台市·邢台县', null, 'X', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130522', '临城县', '河北省·邢台市·临城县', null, 'L', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130523', '内丘县', '河北省·邢台市·内丘县', null, 'N', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130524', '柏乡县', '河北省·邢台市·柏乡县', null, 'B', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130525', '隆尧县', '河北省·邢台市·隆尧县', null, 'L', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130526', '任县', '河北省·邢台市·任县', null, 'R', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130527', '南和县', '河北省·邢台市·南和县', null, 'N', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130528', '宁晋县', '河北省·邢台市·宁晋县', null, 'N', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130529', '巨鹿县', '河北省·邢台市·巨鹿县', null, 'J', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130530', '新河县', '河北省·邢台市·新河县', null, 'X', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130531', '广宗县', '河北省·邢台市·广宗县', null, 'G', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130532', '平乡县', '河北省·邢台市·平乡县', null, 'P', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130533', '威县', '河北省·邢台市·威县', null, 'W', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130534', '清河县', '河北省·邢台市·清河县', null, 'Q', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130535', '临西县', '河北省·邢台市·临西县', null, 'L', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130581', '南宫市', '河北省·邢台市·南宫市', null, 'N', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130582', '沙河市', '河北省·邢台市·沙河市', null, 'S', null, null, null, '130500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130600', '保定市', '河北省·保定市', null, 'B', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130602', '新市区', '河北省·保定市·新市区', null, 'X', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130603', '北市区', '河北省·保定市·北市区', null, 'B', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130604', '南市区', '河北省·保定市·南市区', null, 'N', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130621', '满城县', '河北省·保定市·满城县', null, 'M', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130622', '清苑县', '河北省·保定市·清苑县', null, 'Q', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130623', '涞水县', '河北省·保定市·涞水县', null, 'L', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130624', '阜平县', '河北省·保定市·阜平县', null, 'F', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130625', '徐水县', '河北省·保定市·徐水县', null, 'X', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130626', '定兴县', '河北省·保定市·定兴县', null, 'D', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130627', '唐县', '河北省·保定市·唐县', null, 'T', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130628', '高阳县', '河北省·保定市·高阳县', null, 'G', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130629', '容城县', '河北省·保定市·容城县', null, 'R', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130630', '涞源县', '河北省·保定市·涞源县', null, 'L', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130631', '望都县', '河北省·保定市·望都县', null, 'W', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130632', '安新县', '河北省·保定市·安新县', null, 'A', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130633', '易县', '河北省·保定市·易县', null, 'Y', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130634', '曲阳县', '河北省·保定市·曲阳县', null, 'Q', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130635', '蠡县', '河北省·保定市·蠡县', null, 'L', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130636', '顺平县', '河北省·保定市·顺平县', null, 'S', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130637', '博野县', '河北省·保定市·博野县', null, 'B', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130638', '雄县', '河北省·保定市·雄县', null, 'X', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130681', '涿州市', '河北省·保定市·涿州市', null, 'Z', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130682', '定州市', '河北省·保定市·定州市', null, 'D', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130683', '安国市', '河北省·保定市·安国市', null, 'A', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130684', '高碑店市', '河北省·保定市·高碑店市', null, 'G', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130698', '高开区', '河北省·保定市·高开区', null, 'G', null, null, null, '130600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130700', '张家口市', '河北省·张家口市', null, 'Z', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130702', '桥东区', '河北省·张家口市·桥东区', null, 'Q', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130703', '桥西区', '河北省·张家口市·桥西区', null, 'Q', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130705', '宣化区', '河北省·张家口市·宣化区', null, 'X', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130706', '下花园区', '河北省·张家口市·下花园区', null, 'X', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130721', '宣化县', '河北省·张家口市·宣化县', null, 'X', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130722', '张北县', '河北省·张家口市·张北县', null, 'Z', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130723', '康保县', '河北省·张家口市·康保县', null, 'K', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130724', '沽源县', '河北省·张家口市·沽源县', null, 'G', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130725', '尚义县', '河北省·张家口市·尚义县', null, 'S', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130726', '蔚县', '河北省·张家口市·蔚县', null, 'W', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130727', '阳原县', '河北省·张家口市·阳原县', null, 'Y', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130728', '怀安县', '河北省·张家口市·怀安县', null, 'H', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130729', '万全县', '河北省·张家口市·万全县', null, 'W', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130730', '怀来县', '河北省·张家口市·怀来县', null, 'H', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130731', '涿鹿县', '河北省·张家口市·涿鹿县', null, 'Z', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130732', '赤城县', '河北省·张家口市·赤城县', null, 'C', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130733', '崇礼县', '河北省·张家口市·崇礼县', null, 'C', null, null, null, '130700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130800', '承德市', '河北省·承德市', null, 'C', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130802', '双桥区', '河北省·承德市·双桥区', null, 'S', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130803', '双滦区', '河北省·承德市·双滦区', null, 'S', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130804', '鹰手营子矿区', '河北省·承德市·鹰手营子矿区', null, 'Y', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130821', '承德县', '河北省·承德市·承德县', null, 'C', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130822', '兴隆县', '河北省·承德市·兴隆县', null, 'X', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130823', '平泉县', '河北省·承德市·平泉县', null, 'P', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130824', '滦平县', '河北省·承德市·滦平县', null, 'L', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130825', '隆化县', '河北省·承德市·隆化县', null, 'L', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130826', '丰宁满族自治县', '河北省·承德市·丰宁满族自治县', null, 'F', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130827', '宽城满族自治县', '河北省·承德市·宽城满族自治县', null, 'K', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130828', '围场满族蒙古族自治县', '河北省·承德市·围场满族蒙古族自治县', null, 'W', null, null, null, '130800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130900', '沧州市', '河北省·沧州市', null, 'C', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130902', '新华区', '河北省·沧州市·新华区', null, 'X', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130903', '运河区', '河北省·沧州市·运河区', null, 'Y', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130921', '沧县', '河北省·沧州市·沧县', null, 'C', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130922', '青县', '河北省·沧州市·青县', null, 'Q', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130923', '东光县', '河北省·沧州市·东光县', null, 'D', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130924', '海兴县', '河北省·沧州市·海兴县', null, 'H', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130925', '盐山县', '河北省·沧州市·盐山县', null, 'Y', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130926', '肃宁县', '河北省·沧州市·肃宁县', null, 'S', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130927', '南皮县', '河北省·沧州市·南皮县', null, 'N', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130928', '吴桥县', '河北省·沧州市·吴桥县', null, 'W', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130929', '献县', '河北省·沧州市·献县', null, 'X', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130930', '孟村回族自治县', '河北省·沧州市·孟村回族自治县', null, 'M', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130981', '泊头市', '河北省·沧州市·泊头市', null, 'B', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130982', '任丘市', '河北省·沧州市·任丘市', null, 'R', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130983', '黄骅市', '河北省·沧州市·黄骅市', null, 'H', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130984', '河间市', '河北省·沧州市·河间市', null, 'H', null, null, null, '130900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131000', '廊坊市', '河北省·廊坊市', null, 'L', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131002', '安次区', '河北省·廊坊市·安次区', null, 'A', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131003', '广阳区', '河北省·廊坊市·广阳区', null, 'G', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131022', '固安县', '河北省·廊坊市·固安县', null, 'G', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131023', '永清县', '河北省·廊坊市·永清县', null, 'Y', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131024', '香河县', '河北省·廊坊市·香河县', null, 'X', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131025', '大城县', '河北省·廊坊市·大城县', null, 'D', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131026', '文安县', '河北省·廊坊市·文安县', null, 'W', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131028', '大厂回族自治县', '河北省·廊坊市·大厂回族自治县', null, 'D', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131051', '开发区', '河北省·廊坊市·开发区', null, 'K', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131052', '燕郊经济技术开发区', '河北省·廊坊市·燕郊经济技术开发区', null, 'Y', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131081', '霸州市', '河北省·廊坊市·霸州市', null, 'B', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131082', '三河市', '河北省·廊坊市·三河市', null, 'S', null, null, null, '131000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131100', '衡水市', '河北省·衡水市', null, 'H', null, null, null, '130000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131102', '桃城区', '河北省·衡水市·桃城区', null, 'T', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131121', '枣强县', '河北省·衡水市·枣强县', null, 'Z', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131122', '武邑县', '河北省·衡水市·武邑县', null, 'W', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131123', '武强县', '河北省·衡水市·武强县', null, 'W', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131124', '饶阳县', '河北省·衡水市·饶阳县', null, 'R', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131125', '安平县', '河北省·衡水市·安平县', null, 'A', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131126', '故城县', '河北省·衡水市·故城县', null, 'G', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131127', '景县', '河北省·衡水市·景县', null, 'J', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131128', '阜城县', '河北省·衡水市·阜城县', null, 'F', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131181', '冀州市', '河北省·衡水市·冀州市', null, 'J', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('131182', '深州市', '河北省·衡水市·深州市', null, 'S', null, null, null, '131100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140000', '山西省', '山西省', null, 'S', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140100', '太原市', '山西省·太原市', null, 'T', null, null, null, '140000', '2', '山西开通太原市', '0', '0', '99');
INSERT INTO `pad_city_info` VALUES ('140105', '小店区', '山西省·太原市·小店区', null, 'X', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140106', '迎泽区', '山西省·太原市·迎泽区', null, 'Y', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140107', '杏花岭区', '山西省·太原市·杏花岭区', null, 'X', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140108', '尖草坪区', '山西省·太原市·尖草坪区', null, 'J', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140109', '万柏林区', '山西省·太原市·万柏林区', null, 'W', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140110', '晋源区', '山西省·太原市·晋源区', null, 'J', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140121', '清徐县', '山西省·太原市·清徐县', null, 'Q', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140122', '阳曲县', '山西省·太原市·阳曲县', null, 'Y', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140123', '娄烦县', '山西省·太原市·娄烦县', null, 'L', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140181', '古交市', '山西省·太原市·古交市', null, 'G', null, null, null, '140100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140200', '大同市', '山西省·大同市', null, 'D', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140202', '城区', '山西省·大同市·城区', null, 'C', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140203', '矿区', '山西省·大同市·矿区', null, 'K', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140211', '南郊区', '山西省·大同市·南郊区', null, 'N', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140212', '新荣区', '山西省·大同市·新荣区', null, 'X', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140221', '阳高县', '山西省·大同市·阳高县', null, 'Y', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140222', '天镇县', '山西省·大同市·天镇县', null, 'T', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140223', '广灵县', '山西省·大同市·广灵县', null, 'G', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140224', '灵丘县', '山西省·大同市·灵丘县', null, 'L', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140225', '浑源县', '山西省·大同市·浑源县', null, 'H', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140226', '左云县', '山西省·大同市·左云县', null, 'Z', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140227', '大同县', '山西省·大同市·大同县', null, 'D', null, null, null, '140200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140300', '阳泉市', '山西省·阳泉市', null, 'Y', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140302', '城区', '山西省·阳泉市·城区', null, 'C', null, null, null, '140300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140303', '矿区', '山西省·阳泉市·矿区', null, 'K', null, null, null, '140300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140311', '郊区', '山西省·阳泉市·郊区', null, 'J', null, null, null, '140300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140321', '平定县', '山西省·阳泉市·平定县', null, 'P', null, null, null, '140300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140322', '盂县', '山西省·阳泉市·盂县', null, 'Y', null, null, null, '140300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140400', '长治市', '山西省·长治市', null, 'Z', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140421', '长治县', '山西省·长治市·长治县', null, 'Z', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140423', '襄垣县', '山西省·长治市·襄垣县', null, 'X', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140424', '屯留县', '山西省·长治市·屯留县', null, 'T', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140425', '平顺县', '山西省·长治市·平顺县', null, 'P', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140426', '黎城县', '山西省·长治市·黎城县', null, 'L', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140427', '壶关县', '山西省·长治市·壶关县', null, 'H', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140428', '长子县', '山西省·长治市·长子县', null, 'Z', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140429', '武乡县', '山西省·长治市·武乡县', null, 'W', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140430', '沁县', '山西省·长治市·沁县', null, 'Q', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140431', '沁源县', '山西省·长治市·沁源县', null, 'Q', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140481', '潞城市', '山西省·长治市·潞城市', null, 'L', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140482', '城区', '山西省·长治市·城区', null, 'C', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140483', '郊区', '山西省·长治市·郊区', null, 'J', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140484', '高新区', '山西省·长治市·高新区', null, 'G', null, null, null, '140400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140500', '晋城市', '山西省·晋城市', null, 'J', null, null, null, '140000', '2', '', '1472711665', '1472711665', '1');
INSERT INTO `pad_city_info` VALUES ('140502', '城区', '山西省·晋城市·城区', null, 'C', null, null, null, '140500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140521', '沁水县', '山西省·晋城市·沁水县', null, 'Q', null, null, null, '140500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140522', '阳城县', '山西省·晋城市·阳城县', null, 'Y', null, null, null, '140500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140524', '陵川县', '山西省·晋城市·陵川县', null, 'L', null, null, null, '140500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140525', '泽州县', '山西省·晋城市·泽州县', null, 'Z', null, null, null, '140500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140581', '高平市', '山西省·晋城市·高平市', null, 'G', null, null, null, '140500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140600', '朔州市', '山西省·朔州市', null, 'S', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140602', '朔城区', '山西省·朔州市·朔城区', null, 'S', null, null, null, '140600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140603', '平鲁区', '山西省·朔州市·平鲁区', null, 'P', null, null, null, '140600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140621', '山阴县', '山西省·朔州市·山阴县', null, 'S', null, null, null, '140600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140622', '应县', '山西省·朔州市·应县', null, 'Y', null, null, null, '140600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140623', '右玉县', '山西省·朔州市·右玉县', null, 'Y', null, null, null, '140600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140624', '怀仁县', '山西省·朔州市·怀仁县', null, 'H', null, null, null, '140600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140700', '晋中市', '山西省·晋中市', null, 'J', null, null, null, '140000', '2', '', '1472711672', '1472711672', '1');
INSERT INTO `pad_city_info` VALUES ('140702', '榆次区', '山西省·晋中市·榆次区', null, 'Y', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140721', '榆社县', '山西省·晋中市·榆社县', null, 'Y', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140722', '左权县', '山西省·晋中市·左权县', null, 'Z', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140723', '和顺县', '山西省·晋中市·和顺县', null, 'H', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140724', '昔阳县', '山西省·晋中市·昔阳县', null, 'X', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140725', '寿阳县', '山西省·晋中市·寿阳县', null, 'S', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140726', '太谷县', '山西省·晋中市·太谷县', null, 'T', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140727', '祁县', '山西省·晋中市·祁县', null, 'Q', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140728', '平遥县', '山西省·晋中市·平遥县', null, 'P', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140729', '灵石县', '山西省·晋中市·灵石县', null, 'L', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140781', '介休市', '山西省·晋中市·介休市', null, 'J', null, null, null, '140700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140800', '运城市', '山西省·运城市', null, 'Y', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140802', '盐湖区', '山西省·运城市·盐湖区', null, 'Y', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140821', '临猗县', '山西省·运城市·临猗县', null, 'L', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140822', '万荣县', '山西省·运城市·万荣县', null, 'W', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140823', '闻喜县', '山西省·运城市·闻喜县', null, 'W', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140824', '稷山县', '山西省·运城市·稷山县', null, 'J', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140825', '新绛县', '山西省·运城市·新绛县', null, 'X', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140826', '绛县', '山西省·运城市·绛县', null, 'J', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140827', '垣曲县', '山西省·运城市·垣曲县', null, 'Y', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140828', '夏县', '山西省·运城市·夏县', null, 'X', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140829', '平陆县', '山西省·运城市·平陆县', null, 'P', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140830', '芮城县', '山西省·运城市·芮城县', null, 'R', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140881', '永济市', '山西省·运城市·永济市', null, 'Y', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140882', '河津市', '山西省·运城市·河津市', null, 'H', null, null, null, '140800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140900', '忻州市', '山西省·忻州市', null, 'X', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140902', '忻府区', '山西省·忻州市·忻府区', null, 'X', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140921', '定襄县', '山西省·忻州市·定襄县', null, 'D', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140922', '五台县', '山西省·忻州市·五台县', null, 'W', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140923', '代县', '山西省·忻州市·代县', null, 'D', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140924', '繁峙县', '山西省·忻州市·繁峙县', null, 'F', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140925', '宁武县', '山西省·忻州市·宁武县', null, 'N', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140926', '静乐县', '山西省·忻州市·静乐县', null, 'J', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140927', '神池县', '山西省·忻州市·神池县', null, 'S', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140928', '五寨县', '山西省·忻州市·五寨县', null, 'W', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140929', '岢岚县', '山西省·忻州市·岢岚县', null, 'K', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140930', '河曲县', '山西省·忻州市·河曲县', null, 'H', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140931', '保德县', '山西省·忻州市·保德县', null, 'B', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140932', '偏关县', '山西省·忻州市·偏关县', null, 'P', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('140981', '原平市', '山西省·忻州市·原平市', null, 'Y', null, null, null, '140900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141000', '临汾市', '山西省·临汾市', null, 'L', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141002', '尧都区', '山西省·临汾市·尧都区', null, 'Y', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141021', '曲沃县', '山西省·临汾市·曲沃县', null, 'Q', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141022', '翼城县', '山西省·临汾市·翼城县', null, 'Y', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141023', '襄汾县', '山西省·临汾市·襄汾县', null, 'X', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141024', '洪洞县', '山西省·临汾市·洪洞县', null, 'H', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141025', '古县', '山西省·临汾市·古县', null, 'G', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141026', '安泽县', '山西省·临汾市·安泽县', null, 'A', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141027', '浮山县', '山西省·临汾市·浮山县', null, 'F', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141028', '吉县', '山西省·临汾市·吉县', null, 'J', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141029', '乡宁县', '山西省·临汾市·乡宁县', null, 'X', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141030', '大宁县', '山西省·临汾市·大宁县', null, 'D', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141031', '隰县', '山西省·临汾市·隰县', null, 'X', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141032', '永和县', '山西省·临汾市·永和县', null, 'Y', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141033', '蒲县', '山西省·临汾市·蒲县', null, 'P', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141034', '汾西县', '山西省·临汾市·汾西县', null, 'F', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141081', '侯马市', '山西省·临汾市·侯马市', null, 'H', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141082', '霍州市', '山西省·临汾市·霍州市', null, 'H', null, null, null, '141000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141100', '吕梁市', '山西省·吕梁市', null, 'L', null, null, null, '140000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141102', '离石区', '山西省·吕梁市·离石区', null, 'L', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141121', '文水县', '山西省·吕梁市·文水县', null, 'W', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141122', '交城县', '山西省·吕梁市·交城县', null, 'J', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141123', '兴县', '山西省·吕梁市·兴县', null, 'X', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141124', '临县', '山西省·吕梁市·临县', null, 'L', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141125', '柳林县', '山西省·吕梁市·柳林县', null, 'L', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141126', '石楼县', '山西省·吕梁市·石楼县', null, 'S', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141127', '岚县', '山西省·吕梁市·岚县', null, 'L', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141128', '方山县', '山西省·吕梁市·方山县', null, 'F', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141129', '中阳县', '山西省·吕梁市·中阳县', null, 'Z', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141130', '交口县', '山西省·吕梁市·交口县', null, 'J', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141181', '孝义市', '山西省·吕梁市·孝义市', null, 'X', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('141182', '汾阳市', '山西省·吕梁市·汾阳市', null, 'F', null, null, null, '141100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150000', '内蒙古自治区', '内蒙古自治区', null, 'N', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150100', '呼和浩特市', '内蒙古自治区·呼和浩特市', null, 'H', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150102', '新城区', '内蒙古自治区·呼和浩特市·新城区', null, 'X', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150103', '回民区', '内蒙古自治区·呼和浩特市·回民区', null, 'H', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150104', '玉泉区', '内蒙古自治区·呼和浩特市·玉泉区', null, 'Y', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150105', '赛罕区', '内蒙古自治区·呼和浩特市·赛罕区', null, 'S', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150121', '土默特左旗', '内蒙古自治区·呼和浩特市·土默特左旗', null, 'T', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150122', '托克托县', '内蒙古自治区·呼和浩特市·托克托县', null, 'T', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150123', '和林格尔县', '内蒙古自治区·呼和浩特市·和林格尔县', null, 'H', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150124', '清水河县', '内蒙古自治区·呼和浩特市·清水河县', null, 'Q', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150125', '武川县', '内蒙古自治区·呼和浩特市·武川县', null, 'W', null, null, null, '150100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150200', '包头市', '内蒙古自治区·包头市', null, 'B', null, null, null, '150000', '2', '内蒙开通包头市', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150202', '东河区', '内蒙古自治区·包头市·东河区', null, 'D', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150203', '昆都仑区', '内蒙古自治区·包头市·昆都仑区', null, 'K', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150204', '青山区', '内蒙古自治区·包头市·青山区', null, 'Q', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150205', '石拐区', '内蒙古自治区·包头市·石拐区', null, 'S', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150206', '白云矿区', '内蒙古自治区·包头市·白云矿区', null, 'B', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150207', '九原区', '内蒙古自治区·包头市·九原区', null, 'J', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150221', '土默特右旗', '内蒙古自治区·包头市·土默特右旗', null, 'T', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150222', '固阳县', '内蒙古自治区·包头市·固阳县', null, 'G', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150223', '达尔罕茂明安联合旗', '内蒙古自治区·包头市·达尔罕茂明安联合旗', null, 'D', null, null, null, '150200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150300', '乌海市', '内蒙古自治区·乌海市', null, 'W', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150302', '海勃湾区', '内蒙古自治区·乌海市·海勃湾区', null, 'H', null, null, null, '150300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150303', '海南区', '内蒙古自治区·乌海市·海南区', null, 'H', null, null, null, '150300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150304', '乌达区', '内蒙古自治区·乌海市·乌达区', null, 'W', null, null, null, '150300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150400', '赤峰市', '内蒙古自治区·赤峰市', null, 'C', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150402', '红山区', '内蒙古自治区·赤峰市·红山区', null, 'H', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150403', '元宝山区', '内蒙古自治区·赤峰市·元宝山区', null, 'Y', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150404', '松山区', '内蒙古自治区·赤峰市·松山区', null, 'S', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150421', '阿鲁科尔沁旗', '内蒙古自治区·赤峰市·阿鲁科尔沁旗', null, 'A', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150422', '巴林左旗', '内蒙古自治区·赤峰市·巴林左旗', null, 'B', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150423', '巴林右旗', '内蒙古自治区·赤峰市·巴林右旗', null, 'B', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150424', '林西县', '内蒙古自治区·赤峰市·林西县', null, 'L', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150425', '克什克腾旗', '内蒙古自治区·赤峰市·克什克腾旗', null, 'K', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150426', '翁牛特旗', '内蒙古自治区·赤峰市·翁牛特旗', null, 'W', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150428', '喀喇沁旗', '内蒙古自治区·赤峰市·喀喇沁旗', null, 'K', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150429', '宁城县', '内蒙古自治区·赤峰市·宁城县', null, 'N', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150430', '敖汉旗', '内蒙古自治区·赤峰市·敖汉旗', null, 'A', null, null, null, '150400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150500', '通辽市', '内蒙古自治区·通辽市', null, 'T', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150502', '科尔沁区', '内蒙古自治区·通辽市·科尔沁区', null, 'K', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150521', '科尔沁左翼中旗', '内蒙古自治区·通辽市·科尔沁左翼中旗', null, 'K', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150522', '科尔沁左翼后旗', '内蒙古自治区·通辽市·科尔沁左翼后旗', null, 'K', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150523', '开鲁县', '内蒙古自治区·通辽市·开鲁县', null, 'K', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150524', '库伦旗', '内蒙古自治区·通辽市·库伦旗', null, 'K', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150525', '奈曼旗', '内蒙古自治区·通辽市·奈曼旗', null, 'N', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150526', '扎鲁特旗', '内蒙古自治区·通辽市·扎鲁特旗', null, 'Z', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150581', '霍林郭勒市', '内蒙古自治区·通辽市·霍林郭勒市', null, 'H', null, null, null, '150500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150600', '鄂尔多斯市', '内蒙古自治区·鄂尔多斯市', null, 'E', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150602', '东胜区', '内蒙古自治区·鄂尔多斯市·东胜区', null, 'D', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150621', '达拉特旗', '内蒙古自治区·鄂尔多斯市·达拉特旗', null, 'D', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150622', '准格尔旗', '内蒙古自治区·鄂尔多斯市·准格尔旗', null, 'Z', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150623', '鄂托克前旗', '内蒙古自治区·鄂尔多斯市·鄂托克前旗', null, 'E', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150624', '鄂托克旗', '内蒙古自治区·鄂尔多斯市·鄂托克旗', null, 'E', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150625', '杭锦旗', '内蒙古自治区·鄂尔多斯市·杭锦旗', null, 'H', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150626', '乌审旗', '内蒙古自治区·鄂尔多斯市·乌审旗', null, 'W', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150627', '伊金霍洛旗', '内蒙古自治区·鄂尔多斯市·伊金霍洛旗', null, 'Y', null, null, null, '150600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150700', '呼伦贝尔市', '内蒙古自治区·呼伦贝尔市', null, 'H', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150702', '海拉尔区', '内蒙古自治区·呼伦贝尔市·海拉尔区', null, 'H', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150721', '阿荣旗', '内蒙古自治区·呼伦贝尔市·阿荣旗', null, 'A', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '内蒙古自治区·呼伦贝尔市·莫力达瓦达斡尔族自治旗', null, 'M', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150723', '鄂伦春自治旗', '内蒙古自治区·呼伦贝尔市·鄂伦春自治旗', null, 'E', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150724', '鄂温克族自治旗', '内蒙古自治区·呼伦贝尔市·鄂温克族自治旗', null, 'E', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150725', '陈巴尔虎旗', '内蒙古自治区·呼伦贝尔市·陈巴尔虎旗', null, 'C', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150726', '新巴尔虎左旗', '内蒙古自治区·呼伦贝尔市·新巴尔虎左旗', null, 'X', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150727', '新巴尔虎右旗', '内蒙古自治区·呼伦贝尔市·新巴尔虎右旗', null, 'X', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150781', '满洲里市', '内蒙古自治区·呼伦贝尔市·满洲里市', null, 'M', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150782', '牙克石市', '内蒙古自治区·呼伦贝尔市·牙克石市', null, 'Y', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150783', '扎兰屯市', '内蒙古自治区·呼伦贝尔市·扎兰屯市', null, 'Z', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150784', '额尔古纳市', '内蒙古自治区·呼伦贝尔市·额尔古纳市', null, 'E', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150785', '根河市', '内蒙古自治区·呼伦贝尔市·根河市', null, 'G', null, null, null, '150700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150800', '巴彦淖尔市', '内蒙古自治区·巴彦淖尔市', null, 'B', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150802', '临河区', '内蒙古自治区·巴彦淖尔市·临河区', null, 'L', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150821', '五原县', '内蒙古自治区·巴彦淖尔市·五原县', null, 'W', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150822', '磴口县', '内蒙古自治区·巴彦淖尔市·磴口县', null, 'D', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150823', '乌拉特前旗', '内蒙古自治区·巴彦淖尔市·乌拉特前旗', null, 'W', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150824', '乌拉特中旗', '内蒙古自治区·巴彦淖尔市·乌拉特中旗', null, 'W', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150825', '乌拉特后旗', '内蒙古自治区·巴彦淖尔市·乌拉特后旗', null, 'W', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150826', '杭锦后旗', '内蒙古自治区·巴彦淖尔市·杭锦后旗', null, 'H', null, null, null, '150800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150900', '乌兰察布市', '内蒙古自治区·乌兰察布市', null, 'W', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150902', '集宁区', '内蒙古自治区·乌兰察布市·集宁区', null, 'J', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150921', '卓资县', '内蒙古自治区·乌兰察布市·卓资县', null, 'Z', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150922', '化德县', '内蒙古自治区·乌兰察布市·化德县', null, 'H', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150923', '商都县', '内蒙古自治区·乌兰察布市·商都县', null, 'S', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150924', '兴和县', '内蒙古自治区·乌兰察布市·兴和县', null, 'X', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150925', '凉城县', '内蒙古自治区·乌兰察布市·凉城县', null, 'L', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150926', '察哈尔右翼前旗', '内蒙古自治区·乌兰察布市·察哈尔右翼前旗', null, 'C', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150927', '察哈尔右翼中旗', '内蒙古自治区·乌兰察布市·察哈尔右翼中旗', null, 'C', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150928', '察哈尔右翼后旗', '内蒙古自治区·乌兰察布市·察哈尔右翼后旗', null, 'C', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150929', '四子王旗', '内蒙古自治区·乌兰察布市·四子王旗', null, 'S', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('150981', '丰镇市', '内蒙古自治区·乌兰察布市·丰镇市', null, 'F', null, null, null, '150900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152200', '兴安盟', '内蒙古自治区·兴安盟', null, 'X', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152201', '乌兰浩特市', '内蒙古自治区·兴安盟·乌兰浩特市', null, 'W', null, null, null, '152200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152202', '阿尔山市', '内蒙古自治区·兴安盟·阿尔山市', null, 'A', null, null, null, '152200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152221', '科尔沁右翼前旗', '内蒙古自治区·兴安盟·科尔沁右翼前旗', null, 'K', null, null, null, '152200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152222', '科尔沁右翼中旗', '内蒙古自治区·兴安盟·科尔沁右翼中旗', null, 'K', null, null, null, '152200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152223', '扎赉特旗', '内蒙古自治区·兴安盟·扎赉特旗', null, 'Z', null, null, null, '152200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152224', '突泉县', '内蒙古自治区·兴安盟·突泉县', null, 'T', null, null, null, '152200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152500', '锡林郭勒盟', '内蒙古自治区·锡林郭勒盟', null, 'X', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152501', '二连浩特市', '内蒙古自治区·锡林郭勒盟·二连浩特市', null, 'E', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152502', '锡林浩特市', '内蒙古自治区·锡林郭勒盟·锡林浩特市', null, 'X', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152522', '阿巴嘎旗', '内蒙古自治区·锡林郭勒盟·阿巴嘎旗', null, 'A', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152523', '苏尼特左旗', '内蒙古自治区·锡林郭勒盟·苏尼特左旗', null, 'S', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152524', '苏尼特右旗', '内蒙古自治区·锡林郭勒盟·苏尼特右旗', null, 'S', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152525', '东乌珠穆沁旗', '内蒙古自治区·锡林郭勒盟·东乌珠穆沁旗', null, 'D', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152526', '西乌珠穆沁旗', '内蒙古自治区·锡林郭勒盟·西乌珠穆沁旗', null, 'X', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152527', '太仆寺旗', '内蒙古自治区·锡林郭勒盟·太仆寺旗', null, 'T', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152528', '镶黄旗', '内蒙古自治区·锡林郭勒盟·镶黄旗', null, 'X', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152529', '正镶白旗', '内蒙古自治区·锡林郭勒盟·正镶白旗', null, 'Z', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152530', '正蓝旗', '内蒙古自治区·锡林郭勒盟·正蓝旗', null, 'Z', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152531', '多伦县', '内蒙古自治区·锡林郭勒盟·多伦县', null, 'D', null, null, null, '152500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152900', '阿拉善盟', '内蒙古自治区·阿拉善盟', null, 'A', null, null, null, '150000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152921', '阿拉善左旗', '内蒙古自治区·阿拉善盟·阿拉善左旗', null, 'A', null, null, null, '152900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152922', '阿拉善右旗', '内蒙古自治区·阿拉善盟·阿拉善右旗', null, 'A', null, null, null, '152900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('152923', '额济纳旗', '内蒙古自治区·阿拉善盟·额济纳旗', null, 'E', null, null, null, '152900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210000', '辽宁省', '辽宁省', null, 'L', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210100', '沈阳市', '辽宁省·沈阳市', null, 'S', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210102', '和平区', '辽宁省·沈阳市·和平区', null, 'H', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210103', '沈河区', '辽宁省·沈阳市·沈河区', null, 'S', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210104', '大东区', '辽宁省·沈阳市·大东区', null, 'D', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210105', '皇姑区', '辽宁省·沈阳市·皇姑区', null, 'H', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210106', '铁西区', '辽宁省·沈阳市·铁西区', null, 'T', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210111', '苏家屯区', '辽宁省·沈阳市·苏家屯区', null, 'S', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210112', '东陵区', '辽宁省·沈阳市·东陵区', null, 'D', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210113', '新城子区', '辽宁省·沈阳市·新城子区', null, 'X', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210114', '于洪区', '辽宁省·沈阳市·于洪区', null, 'Y', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210122', '辽中县', '辽宁省·沈阳市·辽中县', null, 'L', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210123', '康平县', '辽宁省·沈阳市·康平县', null, 'K', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210124', '法库县', '辽宁省·沈阳市·法库县', null, 'F', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210181', '新民市', '辽宁省·沈阳市·新民市', null, 'X', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210182', '浑南新区', '辽宁省·沈阳市·浑南新区', null, 'H', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210183', '张士开发区', '辽宁省·沈阳市·张士开发区', null, 'Z', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210184', '沈北新区', '辽宁省·沈阳市·沈北新区', null, 'S', null, null, null, '210100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210200', '大连市', '辽宁省·大连市', null, 'D', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210202', '中山区', '辽宁省·大连市·中山区', null, 'Z', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210203', '西岗区', '辽宁省·大连市·西岗区', null, 'X', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210204', '沙河口区', '辽宁省·大连市·沙河口区', null, 'S', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210211', '甘井子区', '辽宁省·大连市·甘井子区', null, 'G', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210212', '旅顺口区', '辽宁省·大连市·旅顺口区', null, 'L', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210213', '金州区', '辽宁省·大连市·金州区', null, 'J', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210224', '长海县', '辽宁省·大连市·长海县', null, 'Z', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210251', '开发区', '辽宁省·大连市·开发区', null, 'K', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210281', '瓦房店市', '辽宁省·大连市·瓦房店市', null, 'W', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210282', '普兰店市', '辽宁省·大连市·普兰店市', null, 'P', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210283', '庄河市', '辽宁省·大连市·庄河市', null, 'Z', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210297', '岭前区', '辽宁省·大连市·岭前区', null, 'L', null, null, null, '210200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210300', '鞍山市', '辽宁省·鞍山市', null, 'A', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210302', '铁东区', '辽宁省·鞍山市·铁东区', null, 'T', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210303', '铁西区', '辽宁省·鞍山市·铁西区', null, 'T', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210304', '立山区', '辽宁省·鞍山市·立山区', null, 'L', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210311', '千山区', '辽宁省·鞍山市·千山区', null, 'Q', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210321', '台安县', '辽宁省·鞍山市·台安县', null, 'T', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210323', '岫岩满族自治县', '辽宁省·鞍山市·岫岩满族自治县', null, 'X', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210351', '高新区', '辽宁省·鞍山市·高新区', null, 'G', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210381', '海城市', '辽宁省·鞍山市·海城市', null, 'H', null, null, null, '210300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210400', '抚顺市', '辽宁省·抚顺市', null, 'F', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210402', '新抚区', '辽宁省·抚顺市·新抚区', null, 'X', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210403', '东洲区', '辽宁省·抚顺市·东洲区', null, 'D', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210404', '望花区', '辽宁省·抚顺市·望花区', null, 'W', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210411', '顺城区', '辽宁省·抚顺市·顺城区', null, 'S', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210421', '抚顺县', '辽宁省·抚顺市·抚顺县', null, 'F', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210422', '新宾满族自治县', '辽宁省·抚顺市·新宾满族自治县', null, 'X', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210423', '清原满族自治县', '辽宁省·抚顺市·清原满族自治县', null, 'Q', null, null, null, '210400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210500', '本溪市', '辽宁省·本溪市', null, 'B', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210502', '平山区', '辽宁省·本溪市·平山区', null, 'P', null, null, null, '210500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210503', '溪湖区', '辽宁省·本溪市·溪湖区', null, 'X', null, null, null, '210500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210504', '明山区', '辽宁省·本溪市·明山区', null, 'M', null, null, null, '210500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210505', '南芬区', '辽宁省·本溪市·南芬区', null, 'N', null, null, null, '210500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210521', '本溪满族自治县', '辽宁省·本溪市·本溪满族自治县', null, 'B', null, null, null, '210500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210522', '桓仁满族自治县', '辽宁省·本溪市·桓仁满族自治县', null, 'H', null, null, null, '210500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210600', '丹东市', '辽宁省·丹东市', null, 'D', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210602', '元宝区', '辽宁省·丹东市·元宝区', null, 'Y', null, null, null, '210600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210603', '振兴区', '辽宁省·丹东市·振兴区', null, 'Z', null, null, null, '210600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210604', '振安区', '辽宁省·丹东市·振安区', null, 'Z', null, null, null, '210600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210624', '宽甸满族自治县', '辽宁省·丹东市·宽甸满族自治县', null, 'K', null, null, null, '210600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210681', '东港市', '辽宁省·丹东市·东港市', null, 'D', null, null, null, '210600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210682', '凤城市', '辽宁省·丹东市·凤城市', null, 'F', null, null, null, '210600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210700', '锦州市', '辽宁省·锦州市', null, 'J', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210702', '古塔区', '辽宁省·锦州市·古塔区', null, 'G', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210703', '凌河区', '辽宁省·锦州市·凌河区', null, 'L', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210711', '太和区', '辽宁省·锦州市·太和区', null, 'T', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210726', '黑山县', '辽宁省·锦州市·黑山县', null, 'H', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210727', '义县', '辽宁省·锦州市·义县', null, 'Y', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210781', '凌海市', '辽宁省·锦州市·凌海市', null, 'L', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210782', '北镇市', '辽宁省·锦州市·北镇市', null, 'B', null, null, null, '210700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210800', '营口市', '辽宁省·营口市', null, 'Y', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210802', '站前区', '辽宁省·营口市·站前区', null, 'Z', null, null, null, '210800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210803', '西市区', '辽宁省·营口市·西市区', null, 'X', null, null, null, '210800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210804', '鲅鱼圈区', '辽宁省·营口市·鲅鱼圈区', null, 'B', null, null, null, '210800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210811', '老边区', '辽宁省·营口市·老边区', null, 'L', null, null, null, '210800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210881', '盖州市', '辽宁省·营口市·盖州市', null, 'G', null, null, null, '210800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210882', '大石桥市', '辽宁省·营口市·大石桥市', null, 'D', null, null, null, '210800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210900', '阜新市', '辽宁省·阜新市', null, 'F', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210902', '海州区', '辽宁省·阜新市·海州区', null, 'H', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210903', '新邱区', '辽宁省·阜新市·新邱区', null, 'X', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210904', '太平区', '辽宁省·阜新市·太平区', null, 'T', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210905', '清河门区', '辽宁省·阜新市·清河门区', null, 'Q', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210911', '细河区', '辽宁省·阜新市·细河区', null, 'X', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210921', '阜新蒙古族自治县', '辽宁省·阜新市·阜新蒙古族自治县', null, 'F', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('210922', '彰武县', '辽宁省·阜新市·彰武县', null, 'Z', null, null, null, '210900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211000', '辽阳市', '辽宁省·辽阳市', null, 'L', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211002', '白塔区', '辽宁省·辽阳市·白塔区', null, 'B', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211003', '文圣区', '辽宁省·辽阳市·文圣区', null, 'W', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211004', '宏伟区', '辽宁省·辽阳市·宏伟区', null, 'H', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211005', '弓长岭区', '辽宁省·辽阳市·弓长岭区', null, 'G', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211011', '太子河区', '辽宁省·辽阳市·太子河区', null, 'T', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211021', '辽阳县', '辽宁省·辽阳市·辽阳县', null, 'L', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211081', '灯塔市', '辽宁省·辽阳市·灯塔市', null, 'D', null, null, null, '211000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211100', '盘锦市', '辽宁省·盘锦市', null, 'P', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211102', '双台子区', '辽宁省·盘锦市·双台子区', null, 'S', null, null, null, '211100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211103', '兴隆台区', '辽宁省·盘锦市·兴隆台区', null, 'X', null, null, null, '211100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211121', '大洼县', '辽宁省·盘锦市·大洼县', null, 'D', null, null, null, '211100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211122', '盘山县', '辽宁省·盘锦市·盘山县', null, 'P', null, null, null, '211100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211200', '铁岭市', '辽宁省·铁岭市', null, 'T', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211202', '银州区', '辽宁省·铁岭市·银州区', null, 'Y', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211204', '清河区', '辽宁省·铁岭市·清河区', null, 'Q', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211221', '铁岭县', '辽宁省·铁岭市·铁岭县', null, 'T', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211223', '西丰县', '辽宁省·铁岭市·西丰县', null, 'X', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211224', '昌图县', '辽宁省·铁岭市·昌图县', null, 'C', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211281', '调兵山市', '辽宁省·铁岭市·调兵山市', null, 'T', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211282', '开原市', '辽宁省·铁岭市·开原市', null, 'K', null, null, null, '211200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211300', '朝阳市', '辽宁省·朝阳市', null, 'C', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211302', '双塔区', '辽宁省·朝阳市·双塔区', null, 'S', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211303', '龙城区', '辽宁省·朝阳市·龙城区', null, 'L', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211321', '朝阳县', '辽宁省·朝阳市·朝阳县', null, 'C', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211322', '建平县', '辽宁省·朝阳市·建平县', null, 'J', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '辽宁省·朝阳市·喀喇沁左翼蒙古族自治县', null, 'K', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211381', '北票市', '辽宁省·朝阳市·北票市', null, 'B', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211382', '凌源市', '辽宁省·朝阳市·凌源市', null, 'L', null, null, null, '211300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211400', '葫芦岛市', '辽宁省·葫芦岛市', null, 'H', null, null, null, '210000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211402', '连山区', '辽宁省·葫芦岛市·连山区', null, 'L', null, null, null, '211400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211403', '龙港区', '辽宁省·葫芦岛市·龙港区', null, 'L', null, null, null, '211400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211404', '南票区', '辽宁省·葫芦岛市·南票区', null, 'N', null, null, null, '211400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211421', '绥中县', '辽宁省·葫芦岛市·绥中县', null, 'S', null, null, null, '211400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211422', '建昌县', '辽宁省·葫芦岛市·建昌县', null, 'J', null, null, null, '211400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('211481', '兴城市', '辽宁省·葫芦岛市·兴城市', null, 'X', null, null, null, '211400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220000', '吉林省', '吉林省', null, 'J', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220100', '长春市', '吉林省·长春市', null, 'Z', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220102', '南关区', '吉林省·长春市·南关区', null, 'N', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220103', '宽城区', '吉林省·长春市·宽城区', null, 'K', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220104', '朝阳区', '吉林省·长春市·朝阳区', null, 'C', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220105', '二道区', '吉林省·长春市·二道区', null, 'E', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220106', '绿园区', '吉林省·长春市·绿园区', null, 'L', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220112', '双阳区', '吉林省·长春市·双阳区', null, 'S', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220122', '农安县', '吉林省·长春市·农安县', null, 'N', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220181', '九台市', '吉林省·长春市·九台市', null, 'J', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220182', '榆树市', '吉林省·长春市·榆树市', null, 'Y', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220183', '德惠市', '吉林省·长春市·德惠市', null, 'D', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220184', '高新技术产业开发区', '吉林省·长春市·高新技术产业开发区', null, 'G', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220185', '汽车产业开发区', '吉林省·长春市·汽车产业开发区', null, 'Q', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220186', '经济技术开发区', '吉林省·长春市·经济技术开发区', null, 'J', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220187', '净月旅游开发区', '吉林省·长春市·净月旅游开发区', null, 'J', null, null, null, '220100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220200', '吉林市', '吉林省·吉林市', null, 'J', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220202', '昌邑区', '吉林省·吉林市·昌邑区', null, 'C', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220203', '龙潭区', '吉林省·吉林市·龙潭区', null, 'L', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220204', '船营区', '吉林省·吉林市·船营区', null, 'C', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220211', '丰满区', '吉林省·吉林市·丰满区', null, 'F', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220221', '永吉县', '吉林省·吉林市·永吉县', null, 'Y', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220281', '蛟河市', '吉林省·吉林市·蛟河市', null, 'J', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220282', '桦甸市', '吉林省·吉林市·桦甸市', null, 'H', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220283', '舒兰市', '吉林省·吉林市·舒兰市', null, 'S', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220284', '磐石市', '吉林省·吉林市·磐石市', null, 'P', null, null, null, '220200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220300', '四平市', '吉林省·四平市', null, 'S', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220302', '铁西区', '吉林省·四平市·铁西区', null, 'T', null, null, null, '220300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220303', '铁东区', '吉林省·四平市·铁东区', null, 'T', null, null, null, '220300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220322', '梨树县', '吉林省·四平市·梨树县', null, 'L', null, null, null, '220300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220323', '伊通满族自治县', '吉林省·四平市·伊通满族自治县', null, 'Y', null, null, null, '220300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220381', '公主岭市', '吉林省·四平市·公主岭市', null, 'G', null, null, null, '220300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220382', '双辽市', '吉林省·四平市·双辽市', null, 'S', null, null, null, '220300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220400', '辽源市', '吉林省·辽源市', null, 'L', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220402', '龙山区', '吉林省·辽源市·龙山区', null, 'L', null, null, null, '220400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220403', '西安区', '吉林省·辽源市·西安区', null, 'X', null, null, null, '220400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220421', '东丰县', '吉林省·辽源市·东丰县', null, 'D', null, null, null, '220400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220422', '东辽县', '吉林省·辽源市·东辽县', null, 'D', null, null, null, '220400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220500', '通化市', '吉林省·通化市', null, 'T', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220502', '东昌区', '吉林省·通化市·东昌区', null, 'D', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220503', '二道江区', '吉林省·通化市·二道江区', null, 'E', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220521', '通化县', '吉林省·通化市·通化县', null, 'T', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220523', '辉南县', '吉林省·通化市·辉南县', null, 'H', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220524', '柳河县', '吉林省·通化市·柳河县', null, 'L', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220581', '梅河口市', '吉林省·通化市·梅河口市', null, 'M', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220582', '集安市', '吉林省·通化市·集安市', null, 'J', null, null, null, '220500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220600', '白山市', '吉林省·白山市', null, 'B', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220602', '八道江区', '吉林省·白山市·八道江区', null, 'B', null, null, null, '220600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220621', '抚松县', '吉林省·白山市·抚松县', null, 'F', null, null, null, '220600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220622', '靖宇县', '吉林省·白山市·靖宇县', null, 'J', null, null, null, '220600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220623', '长白朝鲜族自治县', '吉林省·白山市·长白朝鲜族自治县', null, 'Z', null, null, null, '220600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220625', '江源市', '吉林省·白山市·江源市', null, 'J', null, null, null, '220600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220681', '临江市', '吉林省·白山市·临江市', null, 'L', null, null, null, '220600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220700', '松原市', '吉林省·松原市', null, 'S', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220702', '宁江区', '吉林省·松原市·宁江区', null, 'N', null, null, null, '220700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '吉林省·松原市·前郭尔罗斯蒙古族自治县', null, 'Q', null, null, null, '220700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220722', '长岭县', '吉林省·松原市·长岭县', null, 'Z', null, null, null, '220700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220723', '乾安县', '吉林省·松原市·乾安县', null, 'Q', null, null, null, '220700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220724', '扶余县', '吉林省·松原市·扶余县', null, 'F', null, null, null, '220700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220800', '白城市', '吉林省·白城市', null, 'B', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220802', '洮北区', '吉林省·白城市·洮北区', null, 'T', null, null, null, '220800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220821', '镇赉县', '吉林省·白城市·镇赉县', null, 'Z', null, null, null, '220800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220822', '通榆县', '吉林省·白城市·通榆县', null, 'T', null, null, null, '220800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220881', '洮南市', '吉林省·白城市·洮南市', null, 'T', null, null, null, '220800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('220882', '大安市', '吉林省·白城市·大安市', null, 'D', null, null, null, '220800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222400', '延边朝鲜族自治州', '吉林省·延边朝鲜族自治州', null, 'Y', null, null, null, '220000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222401', '延吉市', '吉林省·延边朝鲜族自治州·延吉市', null, 'Y', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222402', '图们市', '吉林省·延边朝鲜族自治州·图们市', null, 'T', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222403', '敦化市', '吉林省·延边朝鲜族自治州·敦化市', null, 'D', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222404', '珲春市', '吉林省·延边朝鲜族自治州·珲春市', null, 'H', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222405', '龙井市', '吉林省·延边朝鲜族自治州·龙井市', null, 'L', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222406', '和龙市', '吉林省·延边朝鲜族自治州·和龙市', null, 'H', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222424', '汪清县', '吉林省·延边朝鲜族自治州·汪清县', null, 'W', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('222426', '安图县', '吉林省·延边朝鲜族自治州·安图县', null, 'A', null, null, null, '222400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230000', '黑龙江省', '黑龙江省', null, 'H', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230100', '哈尔滨市', '黑龙江省·哈尔滨市', null, 'H', null, null, null, '230000', '2', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230102', '道里区', '黑龙江省·哈尔滨市·道里区', null, 'D', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230103', '南岗区', '黑龙江省·哈尔滨市·南岗区', null, 'N', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230104', '道外区', '黑龙江省·哈尔滨市·道外区', null, 'D', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230106', '香坊区', '黑龙江省·哈尔滨市·香坊区', null, 'X', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230107', '动力区', '黑龙江省·哈尔滨市·动力区', null, 'D', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230108', '平房区', '黑龙江省·哈尔滨市·平房区', null, 'P', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230109', '松北区', '黑龙江省·哈尔滨市·松北区', null, 'S', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230111', '呼兰区', '黑龙江省·哈尔滨市·呼兰区', null, 'H', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230123', '依兰县', '黑龙江省·哈尔滨市·依兰县', null, 'Y', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230124', '方正县', '黑龙江省·哈尔滨市·方正县', null, 'F', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230125', '宾县', '黑龙江省·哈尔滨市·宾县', null, 'B', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230126', '巴彦县', '黑龙江省·哈尔滨市·巴彦县', null, 'B', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230127', '木兰县', '黑龙江省·哈尔滨市·木兰县', null, 'M', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230128', '通河县', '黑龙江省·哈尔滨市·通河县', null, 'T', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230129', '延寿县', '黑龙江省·哈尔滨市·延寿县', null, 'Y', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230181', '阿城市', '黑龙江省·哈尔滨市·阿城市', null, 'A', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230182', '双城市', '黑龙江省·哈尔滨市·双城市', null, 'S', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230183', '尚志市', '黑龙江省·哈尔滨市·尚志市', null, 'S', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230184', '五常市', '黑龙江省·哈尔滨市·五常市', null, 'W', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230185', '阿城市', '黑龙江省·哈尔滨市·阿城市', null, 'A', null, null, null, '230100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230200', '齐齐哈尔市', '黑龙江省·齐齐哈尔市', null, 'Q', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230202', '龙沙区', '黑龙江省·齐齐哈尔市·龙沙区', null, 'L', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230203', '建华区', '黑龙江省·齐齐哈尔市·建华区', null, 'J', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230204', '铁锋区', '黑龙江省·齐齐哈尔市·铁锋区', null, 'T', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230205', '昂昂溪区', '黑龙江省·齐齐哈尔市·昂昂溪区', null, 'A', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230206', '富拉尔基区', '黑龙江省·齐齐哈尔市·富拉尔基区', null, 'F', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230207', '碾子山区', '黑龙江省·齐齐哈尔市·碾子山区', null, 'N', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230208', '梅里斯达斡尔族区', '黑龙江省·齐齐哈尔市·梅里斯达斡尔族区', null, 'M', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230221', '龙江县', '黑龙江省·齐齐哈尔市·龙江县', null, 'L', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230223', '依安县', '黑龙江省·齐齐哈尔市·依安县', null, 'Y', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230224', '泰来县', '黑龙江省·齐齐哈尔市·泰来县', null, 'T', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230225', '甘南县', '黑龙江省·齐齐哈尔市·甘南县', null, 'G', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230227', '富裕县', '黑龙江省·齐齐哈尔市·富裕县', null, 'F', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230229', '克山县', '黑龙江省·齐齐哈尔市·克山县', null, 'K', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230230', '克东县', '黑龙江省·齐齐哈尔市·克东县', null, 'K', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230231', '拜泉县', '黑龙江省·齐齐哈尔市·拜泉县', null, 'B', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230281', '讷河市', '黑龙江省·齐齐哈尔市·讷河市', null, 'N', null, null, null, '230200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230300', '鸡西市', '黑龙江省·鸡西市', null, 'J', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230302', '鸡冠区', '黑龙江省·鸡西市·鸡冠区', null, 'J', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230303', '恒山区', '黑龙江省·鸡西市·恒山区', null, 'H', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230304', '滴道区', '黑龙江省·鸡西市·滴道区', null, 'D', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230305', '梨树区', '黑龙江省·鸡西市·梨树区', null, 'L', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230306', '城子河区', '黑龙江省·鸡西市·城子河区', null, 'C', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230307', '麻山区', '黑龙江省·鸡西市·麻山区', null, 'M', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230321', '鸡东县', '黑龙江省·鸡西市·鸡东县', null, 'J', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230381', '虎林市', '黑龙江省·鸡西市·虎林市', null, 'H', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230382', '密山市', '黑龙江省·鸡西市·密山市', null, 'M', null, null, null, '230300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230400', '鹤岗市', '黑龙江省·鹤岗市', null, 'H', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230402', '向阳区', '黑龙江省·鹤岗市·向阳区', null, 'X', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230403', '工农区', '黑龙江省·鹤岗市·工农区', null, 'G', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230404', '南山区', '黑龙江省·鹤岗市·南山区', null, 'N', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230405', '兴安区', '黑龙江省·鹤岗市·兴安区', null, 'X', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230406', '东山区', '黑龙江省·鹤岗市·东山区', null, 'D', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230407', '兴山区', '黑龙江省·鹤岗市·兴山区', null, 'X', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230421', '萝北县', '黑龙江省·鹤岗市·萝北县', null, 'L', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230422', '绥滨县', '黑龙江省·鹤岗市·绥滨县', null, 'S', null, null, null, '230400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230500', '双鸭山市', '黑龙江省·双鸭山市', null, 'S', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230502', '尖山区', '黑龙江省·双鸭山市·尖山区', null, 'J', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230503', '岭东区', '黑龙江省·双鸭山市·岭东区', null, 'L', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230505', '四方台区', '黑龙江省·双鸭山市·四方台区', null, 'S', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230506', '宝山区', '黑龙江省·双鸭山市·宝山区', null, 'B', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230521', '集贤县', '黑龙江省·双鸭山市·集贤县', null, 'J', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230522', '友谊县', '黑龙江省·双鸭山市·友谊县', null, 'Y', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230523', '宝清县', '黑龙江省·双鸭山市·宝清县', null, 'B', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230524', '饶河县', '黑龙江省·双鸭山市·饶河县', null, 'R', null, null, null, '230500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230600', '大庆市', '黑龙江省·大庆市', null, 'D', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230602', '萨尔图区', '黑龙江省·大庆市·萨尔图区', null, 'S', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230603', '龙凤区', '黑龙江省·大庆市·龙凤区', null, 'L', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230604', '让胡路区', '黑龙江省·大庆市·让胡路区', null, 'R', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230605', '红岗区', '黑龙江省·大庆市·红岗区', null, 'H', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230606', '大同区', '黑龙江省·大庆市·大同区', null, 'D', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230621', '肇州县', '黑龙江省·大庆市·肇州县', null, 'Z', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230622', '肇源县', '黑龙江省·大庆市·肇源县', null, 'Z', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230623', '林甸县', '黑龙江省·大庆市·林甸县', null, 'L', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230624', '杜尔伯特蒙古族自治县', '黑龙江省·大庆市·杜尔伯特蒙古族自治县', null, 'D', null, null, null, '230600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230700', '伊春市', '黑龙江省·伊春市', null, 'Y', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230702', '伊春区', '黑龙江省·伊春市·伊春区', null, 'Y', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230703', '南岔区', '黑龙江省·伊春市·南岔区', null, 'N', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230704', '友好区', '黑龙江省·伊春市·友好区', null, 'Y', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230705', '西林区', '黑龙江省·伊春市·西林区', null, 'X', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230706', '翠峦区', '黑龙江省·伊春市·翠峦区', null, 'C', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230707', '新青区', '黑龙江省·伊春市·新青区', null, 'X', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230708', '美溪区', '黑龙江省·伊春市·美溪区', null, 'M', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230709', '金山屯区', '黑龙江省·伊春市·金山屯区', null, 'J', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230710', '五营区', '黑龙江省·伊春市·五营区', null, 'W', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230711', '乌马河区', '黑龙江省·伊春市·乌马河区', null, 'W', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230712', '汤旺河区', '黑龙江省·伊春市·汤旺河区', null, 'T', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230713', '带岭区', '黑龙江省·伊春市·带岭区', null, 'D', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230714', '乌伊岭区', '黑龙江省·伊春市·乌伊岭区', null, 'W', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230715', '红星区', '黑龙江省·伊春市·红星区', null, 'H', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230716', '上甘岭区', '黑龙江省·伊春市·上甘岭区', null, 'S', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230722', '嘉荫县', '黑龙江省·伊春市·嘉荫县', null, 'J', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230781', '铁力市', '黑龙江省·伊春市·铁力市', null, 'T', null, null, null, '230700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230800', '佳木斯市', '黑龙江省·佳木斯市', null, 'J', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230802', '永红区', '黑龙江省·佳木斯市·永红区', null, 'Y', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230803', '向阳区', '黑龙江省·佳木斯市·向阳区', null, 'X', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230804', '前进区', '黑龙江省·佳木斯市·前进区', null, 'Q', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230805', '东风区', '黑龙江省·佳木斯市·东风区', null, 'D', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230811', '郊区', '黑龙江省·佳木斯市·郊区', null, 'J', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230822', '桦南县', '黑龙江省·佳木斯市·桦南县', null, 'H', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230826', '桦川县', '黑龙江省·佳木斯市·桦川县', null, 'H', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230828', '汤原县', '黑龙江省·佳木斯市·汤原县', null, 'T', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230833', '抚远县', '黑龙江省·佳木斯市·抚远县', null, 'F', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230881', '同江市', '黑龙江省·佳木斯市·同江市', null, 'T', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230882', '富锦市', '黑龙江省·佳木斯市·富锦市', null, 'F', null, null, null, '230800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230900', '七台河市', '黑龙江省·七台河市', null, 'Q', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230902', '新兴区', '黑龙江省·七台河市·新兴区', null, 'X', null, null, null, '230900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230903', '桃山区', '黑龙江省·七台河市·桃山区', null, 'T', null, null, null, '230900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230904', '茄子河区', '黑龙江省·七台河市·茄子河区', null, 'Q', null, null, null, '230900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('230921', '勃利县', '黑龙江省·七台河市·勃利县', null, 'B', null, null, null, '230900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231000', '牡丹江市', '黑龙江省·牡丹江市', null, 'M', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231002', '东安区', '黑龙江省·牡丹江市·东安区', null, 'D', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231003', '阳明区', '黑龙江省·牡丹江市·阳明区', null, 'Y', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231004', '爱民区', '黑龙江省·牡丹江市·爱民区', null, 'A', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231005', '西安区', '黑龙江省·牡丹江市·西安区', null, 'X', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231024', '东宁县', '黑龙江省·牡丹江市·东宁县', null, 'D', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231025', '林口县', '黑龙江省·牡丹江市·林口县', null, 'L', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231081', '绥芬河市', '黑龙江省·牡丹江市·绥芬河市', null, 'S', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231083', '海林市', '黑龙江省·牡丹江市·海林市', null, 'H', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231084', '宁安市', '黑龙江省·牡丹江市·宁安市', null, 'N', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231085', '穆棱市', '黑龙江省·牡丹江市·穆棱市', null, 'M', null, null, null, '231000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231100', '黑河市', '黑龙江省·黑河市', null, 'H', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231102', '爱辉区', '黑龙江省·黑河市·爱辉区', null, 'A', null, null, null, '231100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231121', '嫩江县', '黑龙江省·黑河市·嫩江县', null, 'N', null, null, null, '231100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231123', '逊克县', '黑龙江省·黑河市·逊克县', null, 'X', null, null, null, '231100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231124', '孙吴县', '黑龙江省·黑河市·孙吴县', null, 'S', null, null, null, '231100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231181', '北安市', '黑龙江省·黑河市·北安市', null, 'B', null, null, null, '231100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231182', '五大连池市', '黑龙江省·黑河市·五大连池市', null, 'W', null, null, null, '231100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231200', '绥化市', '黑龙江省·绥化市', null, 'S', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231202', '北林区', '黑龙江省·绥化市·北林区', null, 'B', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231221', '望奎县', '黑龙江省·绥化市·望奎县', null, 'W', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231222', '兰西县', '黑龙江省·绥化市·兰西县', null, 'L', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231223', '青冈县', '黑龙江省·绥化市·青冈县', null, 'Q', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231224', '庆安县', '黑龙江省·绥化市·庆安县', null, 'Q', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231225', '明水县', '黑龙江省·绥化市·明水县', null, 'M', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231226', '绥棱县', '黑龙江省·绥化市·绥棱县', null, 'S', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231281', '安达市', '黑龙江省·绥化市·安达市', null, 'A', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231282', '肇东市', '黑龙江省·绥化市·肇东市', null, 'Z', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('231283', '海伦市', '黑龙江省·绥化市·海伦市', null, 'H', null, null, null, '231200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('232700', '大兴安岭地区', '黑龙江省·大兴安岭地区', null, 'D', null, null, null, '230000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('232721', '呼玛县', '黑龙江省·大兴安岭地区·呼玛县', null, 'H', null, null, null, '232700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('232722', '塔河县', '黑龙江省·大兴安岭地区·塔河县', null, 'T', null, null, null, '232700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('232723', '漠河县', '黑龙江省·大兴安岭地区·漠河县', null, 'M', null, null, null, '232700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('232724', '加格达奇区', '黑龙江省·大兴安岭地区·加格达奇区', null, 'J', null, null, null, '232700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310000', '上海', '上海', null, 'S', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310100', '上海市', '上海·上海市', null, 'S', null, null, null, '310000', '2', '', '1469411884', '1469411884', '1');
INSERT INTO `pad_city_info` VALUES ('310101', '黄浦区', '上海·上海市·黄浦区', null, 'H', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310103', '卢湾区', '上海·上海市·卢湾区', null, 'L', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310104', '徐汇区', '上海·上海市·徐汇区', null, 'X', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310105', '长宁区', '上海·上海市·长宁区', null, 'Z', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310106', '静安区', '上海·上海市·静安区', null, 'J', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310107', '普陀区', '上海·上海市·普陀区', null, 'P', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310108', '闸北区', '上海·上海市·闸北区', null, 'Z', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310109', '虹口区', '上海·上海市·虹口区', null, 'H', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310110', '杨浦区', '上海·上海市·杨浦区', null, 'Y', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310112', '闵行区', '上海·上海市·闵行区', null, 'M', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310113', '宝山区', '上海·上海市·宝山区', null, 'B', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310114', '嘉定区', '上海·上海市·嘉定区', null, 'J', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310115', '浦东新区', '上海·上海市·浦东新区', null, 'P', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310116', '金山区', '上海·上海市·金山区', null, 'J', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310117', '松江区', '上海·上海市·松江区', null, 'S', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310118', '青浦区', '上海·上海市·青浦区', null, 'Q', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310119', '南汇区', '上海·上海市·南汇区', null, 'N', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310120', '奉贤区', '上海·上海市·奉贤区', null, 'F', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310152', '川沙区', '上海·上海市·川沙区', null, 'C', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('310230', '崇明县', '上海·上海市·崇明县', null, 'C', null, null, null, '310100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320000', '江苏省', '江苏省', null, 'J', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320100', '南京市', '江苏省·南京市', null, 'N', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320102', '玄武区', '江苏省·南京市·玄武区', null, 'X', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320103', '白下区', '江苏省·南京市·白下区', null, 'B', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320104', '秦淮区', '江苏省·南京市·秦淮区', null, 'Q', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320105', '建邺区', '江苏省·南京市·建邺区', null, 'J', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320106', '鼓楼区', '江苏省·南京市·鼓楼区', null, 'G', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320107', '下关区', '江苏省·南京市·下关区', null, 'X', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320111', '浦口区', '江苏省·南京市·浦口区', null, 'P', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320113', '栖霞区', '江苏省·南京市·栖霞区', null, 'Q', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320114', '雨花台区', '江苏省·南京市·雨花台区', null, 'Y', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320115', '江宁区', '江苏省·南京市·江宁区', null, 'J', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320116', '六合区', '江苏省·南京市·六合区', null, 'L', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320124', '溧水县', '江苏省·南京市·溧水县', null, 'L', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320125', '高淳县', '江苏省·南京市·高淳县', null, 'G', null, null, null, '320100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320200', '无锡市', '江苏省·无锡市', null, 'W', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320202', '崇安区', '江苏省·无锡市·崇安区', null, 'C', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320203', '南长区', '江苏省·无锡市·南长区', null, 'N', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320204', '北塘区', '江苏省·无锡市·北塘区', null, 'B', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320205', '锡山区', '江苏省·无锡市·锡山区', null, 'X', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320206', '惠山区', '江苏省·无锡市·惠山区', null, 'H', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320211', '滨湖区', '江苏省·无锡市·滨湖区', null, 'B', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320281', '江阴市', '江苏省·无锡市·江阴市', null, 'J', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320282', '宜兴市', '江苏省·无锡市·宜兴市', null, 'Y', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320296', '新区', '江苏省·无锡市·新区', null, 'X', null, null, null, '320200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320300', '徐州市', '江苏省·徐州市', null, 'X', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320302', '鼓楼区', '江苏省·徐州市·鼓楼区', null, 'G', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320303', '云龙区', '江苏省·徐州市·云龙区', null, 'Y', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320304', '九里区', '江苏省·徐州市·九里区', null, 'J', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320305', '贾汪区', '江苏省·徐州市·贾汪区', null, 'J', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320311', '泉山区', '江苏省·徐州市·泉山区', null, 'Q', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320321', '丰县', '江苏省·徐州市·丰县', null, 'F', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320322', '沛县', '江苏省·徐州市·沛县', null, 'P', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320323', '铜山县', '江苏省·徐州市·铜山县', null, 'T', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320324', '睢宁县', '江苏省·徐州市·睢宁县', null, 'S', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320381', '新沂市', '江苏省·徐州市·新沂市', null, 'X', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320382', '邳州市', '江苏省·徐州市·邳州市', null, 'P', null, null, null, '320300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320400', '常州市', '江苏省·常州市', null, 'C', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320402', '天宁区', '江苏省·常州市·天宁区', null, 'T', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320404', '钟楼区', '江苏省·常州市·钟楼区', null, 'Z', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320405', '戚墅堰区', '江苏省·常州市·戚墅堰区', null, 'Q', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320411', '新北区', '江苏省·常州市·新北区', null, 'X', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320412', '武进区', '江苏省·常州市·武进区', null, 'W', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320481', '溧阳市', '江苏省·常州市·溧阳市', null, 'L', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320482', '金坛市', '江苏省·常州市·金坛市', null, 'J', null, null, null, '320400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320500', '苏州市', '江苏省·苏州市', null, 'S', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320502', '沧浪区', '江苏省·苏州市·沧浪区', null, 'C', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320503', '平江区', '江苏省·苏州市·平江区', null, 'P', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320504', '金阊区', '江苏省·苏州市·金阊区', null, 'J', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320505', '虎丘区', '江苏省·苏州市·虎丘区', null, 'H', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320506', '吴中区', '江苏省·苏州市·吴中区', null, 'W', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320507', '相城区', '江苏省·苏州市·相城区', null, 'X', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320581', '常熟市', '江苏省·苏州市·常熟市', null, 'C', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320582', '张家港市', '江苏省·苏州市·张家港市', null, 'Z', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320583', '昆山市', '江苏省·苏州市·昆山市', null, 'K', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320584', '吴江市', '江苏省·苏州市·吴江市', null, 'W', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320585', '太仓市', '江苏省·苏州市·太仓市', null, 'T', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320594', '新区', '江苏省·苏州市·新区', null, 'X', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320595', '园区', '江苏省·苏州市·园区', null, 'Y', null, null, null, '320500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320600', '南通市', '江苏省·南通市', null, 'N', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320602', '崇川区', '江苏省·南通市·崇川区', null, 'C', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320611', '港闸区', '江苏省·南通市·港闸区', null, 'G', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320612', '通州区', '江苏省·南通市·通州区', null, 'T', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320621', '海安县', '江苏省·南通市·海安县', null, 'H', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320623', '如东县', '江苏省·南通市·如东县', null, 'R', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320681', '启东市', '江苏省·南通市·启东市', null, 'Q', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320682', '如皋市', '江苏省·南通市·如皋市', null, 'R', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320683', '通州市', '江苏省·南通市·通州市', null, 'T', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320684', '海门市', '江苏省·南通市·海门市', null, 'H', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320693', '开发区', '江苏省·南通市·开发区', null, 'K', null, null, null, '320600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320700', '连云港市', '江苏省·连云港市', null, 'L', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320703', '连云区', '江苏省·连云港市·连云区', null, 'L', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320705', '新浦区', '江苏省·连云港市·新浦区', null, 'X', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320706', '海州区', '江苏省·连云港市·海州区', null, 'H', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320721', '赣榆县', '江苏省·连云港市·赣榆县', null, 'G', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320722', '东海县', '江苏省·连云港市·东海县', null, 'D', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320723', '灌云县', '江苏省·连云港市·灌云县', null, 'G', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320724', '灌南县', '江苏省·连云港市·灌南县', null, 'G', null, null, null, '320700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320800', '淮安市', '江苏省·淮安市', null, 'H', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320802', '清河区', '江苏省·淮安市·清河区', null, 'Q', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320803', '楚州区', '江苏省·淮安市·楚州区', null, 'C', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320804', '淮阴区', '江苏省·淮安市·淮阴区', null, 'H', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320811', '清浦区', '江苏省·淮安市·清浦区', null, 'Q', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320826', '涟水县', '江苏省·淮安市·涟水县', null, 'L', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320829', '洪泽县', '江苏省·淮安市·洪泽县', null, 'H', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320830', '盱眙县', '江苏省·淮安市·盱眙县', null, 'X', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320831', '金湖县', '江苏省·淮安市·金湖县', null, 'J', null, null, null, '320800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320900', '盐城市', '江苏省·盐城市', null, 'Y', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320902', '亭湖区', '江苏省·盐城市·亭湖区', null, 'T', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320903', '盐都区', '江苏省·盐城市·盐都区', null, 'Y', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320921', '响水县', '江苏省·盐城市·响水县', null, 'X', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320922', '滨海县', '江苏省·盐城市·滨海县', null, 'B', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320923', '阜宁县', '江苏省·盐城市·阜宁县', null, 'F', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320924', '射阳县', '江苏省·盐城市·射阳县', null, 'S', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320925', '建湖县', '江苏省·盐城市·建湖县', null, 'J', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320981', '东台市', '江苏省·盐城市·东台市', null, 'D', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('320982', '大丰市', '江苏省·盐城市·大丰市', null, 'D', null, null, null, '320900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321000', '扬州市', '江苏省·扬州市', null, 'Y', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321002', '广陵区', '江苏省·扬州市·广陵区', null, 'G', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321003', '邗江区', '江苏省·扬州市·邗江区', null, 'H', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321011', '维扬区', '江苏省·扬州市·维扬区', null, 'W', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321023', '宝应县', '江苏省·扬州市·宝应县', null, 'B', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321081', '仪征市', '江苏省·扬州市·仪征市', null, 'Y', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321084', '高邮市', '江苏省·扬州市·高邮市', null, 'G', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321088', '江都市', '江苏省·扬州市·江都市', null, 'J', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321092', '经济开发区', '江苏省·扬州市·经济开发区', null, 'J', null, null, null, '321000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321100', '镇江市', '江苏省·镇江市', null, 'Z', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321102', '京口区', '江苏省·镇江市·京口区', null, 'J', null, null, null, '321100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321111', '润州区', '江苏省·镇江市·润州区', null, 'R', null, null, null, '321100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321112', '丹徒区', '江苏省·镇江市·丹徒区', null, 'D', null, null, null, '321100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321181', '丹阳市', '江苏省·镇江市·丹阳市', null, 'D', null, null, null, '321100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321182', '扬中市', '江苏省·镇江市·扬中市', null, 'Y', null, null, null, '321100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321183', '句容市', '江苏省·镇江市·句容市', null, 'J', null, null, null, '321100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321200', '泰州市', '江苏省·泰州市', null, 'T', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321202', '海陵区', '江苏省·泰州市·海陵区', null, 'H', null, null, null, '321200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321203', '高港区', '江苏省·泰州市·高港区', null, 'G', null, null, null, '321200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321281', '兴化市', '江苏省·泰州市·兴化市', null, 'X', null, null, null, '321200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321282', '靖江市', '江苏省·泰州市·靖江市', null, 'J', null, null, null, '321200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321283', '泰兴市', '江苏省·泰州市·泰兴市', null, 'T', null, null, null, '321200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321284', '姜堰市', '江苏省·泰州市·姜堰市', null, 'J', null, null, null, '321200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321300', '宿迁市', '江苏省·宿迁市', null, 'X', null, null, null, '320000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321302', '宿城区', '江苏省·宿迁市·宿城区', null, 'X', null, null, null, '321300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321311', '宿豫区', '江苏省·宿迁市·宿豫区', null, 'X', null, null, null, '321300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321322', '沭阳县', '江苏省·宿迁市·沭阳县', null, 'S', null, null, null, '321300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321323', '泗阳县', '江苏省·宿迁市·泗阳县', null, 'S', null, null, null, '321300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('321324', '泗洪县', '江苏省·宿迁市·泗洪县', null, 'S', null, null, null, '321300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330000', '浙江省', '浙江省', null, 'Z', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330100', '杭州市', '浙江省·杭州市', null, 'H', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330102', '上城区', '浙江省·杭州市·上城区', null, 'S', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330103', '下城区', '浙江省·杭州市·下城区', null, 'X', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330104', '江干区', '浙江省·杭州市·江干区', null, 'J', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330105', '拱墅区', '浙江省·杭州市·拱墅区', null, 'G', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330106', '西湖区', '浙江省·杭州市·西湖区', null, 'X', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330108', '滨江区', '浙江省·杭州市·滨江区', null, 'B', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330109', '萧山区', '浙江省·杭州市·萧山区', null, 'X', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330110', '余杭区', '浙江省·杭州市·余杭区', null, 'Y', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330122', '桐庐县', '浙江省·杭州市·桐庐县', null, 'T', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330127', '淳安县', '浙江省·杭州市·淳安县', null, 'C', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330182', '建德市', '浙江省·杭州市·建德市', null, 'J', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330183', '富阳市', '浙江省·杭州市·富阳市', null, 'F', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330185', '临安市', '浙江省·杭州市·临安市', null, 'L', null, null, null, '330100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330200', '宁波市', '浙江省·宁波市', null, 'N', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330203', '海曙区', '浙江省·宁波市·海曙区', null, 'H', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330204', '江东区', '浙江省·宁波市·江东区', null, 'J', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330205', '江北区', '浙江省·宁波市·江北区', null, 'J', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330206', '北仑区', '浙江省·宁波市·北仑区', null, 'B', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330211', '镇海区', '浙江省·宁波市·镇海区', null, 'Z', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330212', '鄞州区', '浙江省·宁波市·鄞州区', null, 'Y', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330225', '象山县', '浙江省·宁波市·象山县', null, 'X', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330226', '宁海县', '浙江省·宁波市·宁海县', null, 'N', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330281', '余姚市', '浙江省·宁波市·余姚市', null, 'Y', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330282', '慈溪市', '浙江省·宁波市·慈溪市', null, 'C', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330283', '奉化市', '浙江省·宁波市·奉化市', null, 'F', null, null, null, '330200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330300', '温州市', '浙江省·温州市', null, 'W', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330302', '鹿城区', '浙江省·温州市·鹿城区', null, 'L', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330303', '龙湾区', '浙江省·温州市·龙湾区', null, 'L', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330304', '瓯海区', '浙江省·温州市·瓯海区', null, 'O', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330322', '洞头县', '浙江省·温州市·洞头县', null, 'D', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330324', '永嘉县', '浙江省·温州市·永嘉县', null, 'Y', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330326', '平阳县', '浙江省·温州市·平阳县', null, 'P', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330327', '苍南县', '浙江省·温州市·苍南县', null, 'C', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330328', '文成县', '浙江省·温州市·文成县', null, 'W', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330329', '泰顺县', '浙江省·温州市·泰顺县', null, 'T', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330381', '瑞安市', '浙江省·温州市·瑞安市', null, 'R', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330382', '乐清市', '浙江省·温州市·乐清市', null, 'L', null, null, null, '330300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330400', '嘉兴市', '浙江省·嘉兴市', null, 'J', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330402', '南湖区', '浙江省·嘉兴市·南湖区', null, 'N', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330411', '秀洲区', '浙江省·嘉兴市·秀洲区', null, 'X', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330421', '嘉善县', '浙江省·嘉兴市·嘉善县', null, 'J', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330424', '海盐县', '浙江省·嘉兴市·海盐县', null, 'H', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330481', '海宁市', '浙江省·嘉兴市·海宁市', null, 'H', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330482', '平湖市', '浙江省·嘉兴市·平湖市', null, 'P', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330483', '桐乡市', '浙江省·嘉兴市·桐乡市', null, 'T', null, null, null, '330400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330500', '湖州市', '浙江省·湖州市', null, 'H', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330502', '吴兴区', '浙江省·湖州市·吴兴区', null, 'W', null, null, null, '330500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330503', '南浔区', '浙江省·湖州市·南浔区', null, 'N', null, null, null, '330500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330521', '德清县', '浙江省·湖州市·德清县', null, 'D', null, null, null, '330500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330522', '长兴县', '浙江省·湖州市·长兴县', null, 'Z', null, null, null, '330500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330523', '安吉县', '浙江省·湖州市·安吉县', null, 'A', null, null, null, '330500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330600', '绍兴市', '浙江省·绍兴市', null, 'S', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330602', '越城区', '浙江省·绍兴市·越城区', null, 'Y', null, null, null, '330600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330621', '绍兴县', '浙江省·绍兴市·绍兴县', null, 'S', null, null, null, '330600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330624', '新昌县', '浙江省·绍兴市·新昌县', null, 'X', null, null, null, '330600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330681', '诸暨市', '浙江省·绍兴市·诸暨市', null, 'Z', null, null, null, '330600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330682', '上虞市', '浙江省·绍兴市·上虞市', null, 'S', null, null, null, '330600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330683', '嵊州市', '浙江省·绍兴市·嵊州市', null, 'S', null, null, null, '330600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330700', '金华市', '浙江省·金华市', null, 'J', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330702', '婺城区', '浙江省·金华市·婺城区', null, 'W', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330703', '金东区', '浙江省·金华市·金东区', null, 'J', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330723', '武义县', '浙江省·金华市·武义县', null, 'W', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330726', '浦江县', '浙江省·金华市·浦江县', null, 'P', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330727', '磐安县', '浙江省·金华市·磐安县', null, 'P', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330781', '兰溪市', '浙江省·金华市·兰溪市', null, 'L', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330782', '义乌市', '浙江省·金华市·义乌市', null, 'Y', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330783', '东阳市', '浙江省·金华市·东阳市', null, 'D', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330784', '永康市', '浙江省·金华市·永康市', null, 'Y', null, null, null, '330700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330800', '衢州市', '浙江省·衢州市', null, 'Q', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330802', '柯城区', '浙江省·衢州市·柯城区', null, 'K', null, null, null, '330800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330803', '衢江区', '浙江省·衢州市·衢江区', null, 'Q', null, null, null, '330800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330822', '常山县', '浙江省·衢州市·常山县', null, 'C', null, null, null, '330800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330824', '开化县', '浙江省·衢州市·开化县', null, 'K', null, null, null, '330800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330825', '龙游县', '浙江省·衢州市·龙游县', null, 'L', null, null, null, '330800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330881', '江山市', '浙江省·衢州市·江山市', null, 'J', null, null, null, '330800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330900', '舟山市', '浙江省·舟山市', null, 'Z', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330902', '定海区', '浙江省·舟山市·定海区', null, 'D', null, null, null, '330900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330903', '普陀区', '浙江省·舟山市·普陀区', null, 'P', null, null, null, '330900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330921', '岱山县', '浙江省·舟山市·岱山县', null, 'D', null, null, null, '330900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('330922', '嵊泗县', '浙江省·舟山市·嵊泗县', null, 'S', null, null, null, '330900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331000', '台州市', '浙江省·台州市', null, 'T', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331002', '椒江区', '浙江省·台州市·椒江区', null, 'J', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331003', '黄岩区', '浙江省·台州市·黄岩区', null, 'H', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331004', '路桥区', '浙江省·台州市·路桥区', null, 'L', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331021', '玉环县', '浙江省·台州市·玉环县', null, 'Y', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331022', '三门县', '浙江省·台州市·三门县', null, 'S', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331023', '天台县', '浙江省·台州市·天台县', null, 'T', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331024', '仙居县', '浙江省·台州市·仙居县', null, 'X', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331081', '温岭市', '浙江省·台州市·温岭市', null, 'W', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331082', '临海市', '浙江省·台州市·临海市', null, 'L', null, null, null, '331000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331100', '丽水市', '浙江省·丽水市', null, 'L', null, null, null, '330000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331102', '莲都区', '浙江省·丽水市·莲都区', null, 'L', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331121', '青田县', '浙江省·丽水市·青田县', null, 'Q', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331122', '缙云县', '浙江省·丽水市·缙云县', null, 'J', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331123', '遂昌县', '浙江省·丽水市·遂昌县', null, 'S', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331124', '松阳县', '浙江省·丽水市·松阳县', null, 'S', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331125', '云和县', '浙江省·丽水市·云和县', null, 'Y', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331126', '庆元县', '浙江省·丽水市·庆元县', null, 'Q', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331127', '景宁畲族自治县', '浙江省·丽水市·景宁畲族自治县', null, 'J', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('331181', '龙泉市', '浙江省·丽水市·龙泉市', null, 'L', null, null, null, '331100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340000', '安徽省', '安徽省', null, 'A', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340100', '合肥市', '安徽省·合肥市', null, 'H', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340102', '瑶海区', '安徽省·合肥市·瑶海区', null, 'Y', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340103', '庐阳区', '安徽省·合肥市·庐阳区', null, 'L', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340104', '蜀山区', '安徽省·合肥市·蜀山区', null, 'S', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340111', '包河区', '安徽省·合肥市·包河区', null, 'B', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340121', '长丰县', '安徽省·合肥市·长丰县', null, 'Z', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340122', '肥东县', '安徽省·合肥市·肥东县', null, 'F', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340123', '肥西县', '安徽省·合肥市·肥西县', null, 'F', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340151', '高新区', '安徽省·合肥市·高新区', null, 'G', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340191', '中区', '安徽省·合肥市·中区', null, 'Z', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340200', '芜湖市', '安徽省·芜湖市', null, 'W', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340202', '镜湖区', '安徽省·芜湖市·镜湖区', null, 'J', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340203', '弋江区', '安徽省·芜湖市·弋江区', null, 'Y', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340207', '鸠江区', '安徽省·芜湖市·鸠江区', null, 'J', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340208', '三山区', '安徽省·芜湖市·三山区', null, 'S', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340221', '芜湖县', '安徽省·芜湖市·芜湖县', null, 'W', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340222', '繁昌县', '安徽省·芜湖市·繁昌县', null, 'F', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340223', '南陵县', '安徽省·芜湖市·南陵县', null, 'N', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340300', '蚌埠市', '安徽省·蚌埠市', null, 'B', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340302', '龙子湖区', '安徽省·蚌埠市·龙子湖区', null, 'L', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340303', '蚌山区', '安徽省·蚌埠市·蚌山区', null, 'B', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340304', '禹会区', '安徽省·蚌埠市·禹会区', null, 'Y', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340311', '淮上区', '安徽省·蚌埠市·淮上区', null, 'H', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340321', '怀远县', '安徽省·蚌埠市·怀远县', null, 'H', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340322', '五河县', '安徽省·蚌埠市·五河县', null, 'W', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340323', '固镇县', '安徽省·蚌埠市·固镇县', null, 'G', null, null, null, '340300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340400', '淮南市', '安徽省·淮南市', null, 'H', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340402', '大通区', '安徽省·淮南市·大通区', null, 'D', null, null, null, '340400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340403', '田家庵区', '安徽省·淮南市·田家庵区', null, 'T', null, null, null, '340400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340404', '谢家集区', '安徽省·淮南市·谢家集区', null, 'X', null, null, null, '340400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340405', '八公山区', '安徽省·淮南市·八公山区', null, 'B', null, null, null, '340400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340406', '潘集区', '安徽省·淮南市·潘集区', null, 'P', null, null, null, '340400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340421', '凤台县', '安徽省·淮南市·凤台县', null, 'F', null, null, null, '340400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340500', '马鞍山市', '安徽省·马鞍山市', null, 'M', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340502', '金家庄区', '安徽省·马鞍山市·金家庄区', null, 'J', null, null, null, '340500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340503', '花山区', '安徽省·马鞍山市·花山区', null, 'H', null, null, null, '340500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340504', '雨山区', '安徽省·马鞍山市·雨山区', null, 'Y', null, null, null, '340500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340521', '当涂县', '安徽省·马鞍山市·当涂县', null, 'D', null, null, null, '340500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340600', '淮北市', '安徽省·淮北市', null, 'H', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340602', '杜集区', '安徽省·淮北市·杜集区', null, 'D', null, null, null, '340600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340603', '相山区', '安徽省·淮北市·相山区', null, 'X', null, null, null, '340600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340604', '烈山区', '安徽省·淮北市·烈山区', null, 'L', null, null, null, '340600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340621', '濉溪县', '安徽省·淮北市·濉溪县', null, 'S', null, null, null, '340600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340700', '铜陵市', '安徽省·铜陵市', null, 'T', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340702', '铜官山区', '安徽省·铜陵市·铜官山区', null, 'T', null, null, null, '340700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340703', '狮子山区', '安徽省·铜陵市·狮子山区', null, 'S', null, null, null, '340700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340711', '郊区', '安徽省·铜陵市·郊区', null, 'J', null, null, null, '340700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340721', '铜陵县', '安徽省·铜陵市·铜陵县', null, 'T', null, null, null, '340700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340800', '安庆市', '安徽省·安庆市', null, 'A', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340802', '迎江区', '安徽省·安庆市·迎江区', null, 'Y', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340803', '大观区', '安徽省·安庆市·大观区', null, 'D', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340811', '宜秀区', '安徽省·安庆市·宜秀区', null, 'Y', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340822', '怀宁县', '安徽省·安庆市·怀宁县', null, 'H', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340823', '枞阳县', '安徽省·安庆市·枞阳县', null, 'C', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340824', '潜山县', '安徽省·安庆市·潜山县', null, 'Q', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340825', '太湖县', '安徽省·安庆市·太湖县', null, 'T', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340826', '宿松县', '安徽省·安庆市·宿松县', null, 'X', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340827', '望江县', '安徽省·安庆市·望江县', null, 'W', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340828', '岳西县', '安徽省·安庆市·岳西县', null, 'Y', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('340881', '桐城市', '安徽省·安庆市·桐城市', null, 'T', null, null, null, '340800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341000', '黄山市', '安徽省·黄山市', null, 'H', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341002', '屯溪区', '安徽省·黄山市·屯溪区', null, 'T', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341003', '黄山区', '安徽省·黄山市·黄山区', null, 'H', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341004', '徽州区', '安徽省·黄山市·徽州区', null, 'H', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341021', '歙县', '安徽省·黄山市·歙县', null, 'X', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341022', '休宁县', '安徽省·黄山市·休宁县', null, 'X', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341023', '黟县', '安徽省·黄山市·黟县', null, 'Y', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341024', '祁门县', '安徽省·黄山市·祁门县', null, 'Q', null, null, null, '341000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341100', '滁州市', '安徽省·滁州市', null, 'C', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341102', '琅琊区', '安徽省·滁州市·琅琊区', null, 'L', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341103', '南谯区', '安徽省·滁州市·南谯区', null, 'N', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341122', '来安县', '安徽省·滁州市·来安县', null, 'L', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341124', '全椒县', '安徽省·滁州市·全椒县', null, 'Q', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341125', '定远县', '安徽省·滁州市·定远县', null, 'D', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341126', '凤阳县', '安徽省·滁州市·凤阳县', null, 'F', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341181', '天长市', '安徽省·滁州市·天长市', null, 'T', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341182', '明光市', '安徽省·滁州市·明光市', null, 'M', null, null, null, '341100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341200', '阜阳市', '安徽省·阜阳市', null, 'F', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341202', '颍州区', '安徽省·阜阳市·颍州区', null, 'Y', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341203', '颍东区', '安徽省·阜阳市·颍东区', null, 'Y', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341204', '颍泉区', '安徽省·阜阳市·颍泉区', null, 'Y', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341221', '临泉县', '安徽省·阜阳市·临泉县', null, 'L', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341222', '太和县', '安徽省·阜阳市·太和县', null, 'T', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341225', '阜南县', '安徽省·阜阳市·阜南县', null, 'F', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341226', '颍上县', '安徽省·阜阳市·颍上县', null, 'Y', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341282', '界首市', '安徽省·阜阳市·界首市', null, 'J', null, null, null, '341200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341300', '宿州市', '安徽省·宿州市', null, 'X', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341302', '埇桥区', '安徽省·宿州市·埇桥区', null, '', null, null, null, '341300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341321', '砀山县', '安徽省·宿州市·砀山县', null, 'D', null, null, null, '341300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341322', '萧县', '安徽省·宿州市·萧县', null, 'X', null, null, null, '341300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341323', '灵璧县', '安徽省·宿州市·灵璧县', null, 'L', null, null, null, '341300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341324', '泗县', '安徽省·宿州市·泗县', null, 'S', null, null, null, '341300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341400', '巢湖市', '安徽省·合肥市·巢湖市', null, 'C', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341402', '居巢区', '安徽省·合肥市·居巢区', null, 'J', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341421', '庐江县', '安徽省·合肥市·庐江县', null, 'L', null, null, null, '340100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341422', '无为县', '安徽省·芜湖市·无为县', null, 'W', null, null, null, '340200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341423', '含山县', '安徽省·马鞍山市·含山县', null, 'H', null, null, null, '340500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341424', '和县', '安徽省·马鞍山市·和县', null, 'H', null, null, null, '340500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341500', '六安市', '安徽省·六安市', null, 'L', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341502', '金安区', '安徽省·六安市·金安区', null, 'J', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341503', '裕安区', '安徽省·六安市·裕安区', null, 'Y', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341521', '寿县', '安徽省·六安市·寿县', null, 'S', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341522', '霍邱县', '安徽省·六安市·霍邱县', null, 'H', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341523', '舒城县', '安徽省·六安市·舒城县', null, 'S', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341524', '金寨县', '安徽省·六安市·金寨县', null, 'J', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341525', '霍山县', '安徽省·六安市·霍山县', null, 'H', null, null, null, '341500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341600', '亳州市', '安徽省·亳州市', null, 'B', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341602', '谯城区', '安徽省·亳州市·谯城区', null, 'Q', null, null, null, '341600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341621', '涡阳县', '安徽省·亳州市·涡阳县', null, 'W', null, null, null, '341600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341622', '蒙城县', '安徽省·亳州市·蒙城县', null, 'M', null, null, null, '341600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341623', '利辛县', '安徽省·亳州市·利辛县', null, 'L', null, null, null, '341600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341700', '池州市', '安徽省·池州市', null, 'C', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341702', '贵池区', '安徽省·池州市·贵池区', null, 'G', null, null, null, '341700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341721', '东至县', '安徽省·池州市·东至县', null, 'D', null, null, null, '341700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341722', '石台县', '安徽省·池州市·石台县', null, 'S', null, null, null, '341700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341723', '青阳县', '安徽省·池州市·青阳县', null, 'Q', null, null, null, '341700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341800', '宣城市', '安徽省·宣城市', null, 'X', null, null, null, '340000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341802', '宣州区', '安徽省·宣城市·宣州区', null, 'X', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341821', '郎溪县', '安徽省·宣城市·郎溪县', null, 'L', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341822', '广德县', '安徽省·宣城市·广德县', null, 'G', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341823', '泾县', '安徽省·宣城市·泾县', null, 'J', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341824', '绩溪县', '安徽省·宣城市·绩溪县', null, 'J', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341825', '旌德县', '安徽省·宣城市·旌德县', null, 'J', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('341881', '宁国市', '安徽省·宣城市·宁国市', null, 'N', null, null, null, '341800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350000', '福建省', '福建省', null, 'F', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350100', '福州市', '福建省·福州市', null, 'F', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350102', '鼓楼区', '福建省·福州市·鼓楼区', null, 'G', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350103', '台江区', '福建省·福州市·台江区', null, 'T', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350104', '仓山区', '福建省·福州市·仓山区', null, 'C', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350105', '马尾区', '福建省·福州市·马尾区', null, 'M', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350111', '晋安区', '福建省·福州市·晋安区', null, 'J', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350121', '闽侯县', '福建省·福州市·闽侯县', null, 'M', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350122', '连江县', '福建省·福州市·连江县', null, 'L', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350123', '罗源县', '福建省·福州市·罗源县', null, 'L', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350124', '闽清县', '福建省·福州市·闽清县', null, 'M', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350125', '永泰县', '福建省·福州市·永泰县', null, 'Y', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350128', '平潭县', '福建省·福州市·平潭县', null, 'P', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350181', '福清市', '福建省·福州市·福清市', null, 'F', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350182', '长乐市', '福建省·福州市·长乐市', null, 'Z', null, null, null, '350100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350200', '厦门市', '福建省·厦门市', null, 'S', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350203', '思明区', '福建省·厦门市·思明区', null, 'S', null, null, null, '350200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350205', '海沧区', '福建省·厦门市·海沧区', null, 'H', null, null, null, '350200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350206', '湖里区', '福建省·厦门市·湖里区', null, 'H', null, null, null, '350200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350211', '集美区', '福建省·厦门市·集美区', null, 'J', null, null, null, '350200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350212', '同安区', '福建省·厦门市·同安区', null, 'T', null, null, null, '350200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350213', '翔安区', '福建省·厦门市·翔安区', null, 'X', null, null, null, '350200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350300', '莆田市', '福建省·莆田市', null, 'P', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350302', '城厢区', '福建省·莆田市·城厢区', null, 'C', null, null, null, '350300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350303', '涵江区', '福建省·莆田市·涵江区', null, 'H', null, null, null, '350300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350304', '荔城区', '福建省·莆田市·荔城区', null, 'L', null, null, null, '350300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350305', '秀屿区', '福建省·莆田市·秀屿区', null, 'X', null, null, null, '350300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350322', '仙游县', '福建省·莆田市·仙游县', null, 'X', null, null, null, '350300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350400', '三明市', '福建省·三明市', null, 'S', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350402', '梅列区', '福建省·三明市·梅列区', null, 'M', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350403', '三元区', '福建省·三明市·三元区', null, 'S', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350421', '明溪县', '福建省·三明市·明溪县', null, 'M', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350423', '清流县', '福建省·三明市·清流县', null, 'Q', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350424', '宁化县', '福建省·三明市·宁化县', null, 'N', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350425', '大田县', '福建省·三明市·大田县', null, 'D', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350426', '尤溪县', '福建省·三明市·尤溪县', null, 'Y', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350427', '沙县', '福建省·三明市·沙县', null, 'S', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350428', '将乐县', '福建省·三明市·将乐县', null, 'J', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350429', '泰宁县', '福建省·三明市·泰宁县', null, 'T', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350430', '建宁县', '福建省·三明市·建宁县', null, 'J', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350481', '永安市', '福建省·三明市·永安市', null, 'Y', null, null, null, '350400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350500', '泉州市', '福建省·泉州市', null, 'Q', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350502', '鲤城区', '福建省·泉州市·鲤城区', null, 'L', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350503', '丰泽区', '福建省·泉州市·丰泽区', null, 'F', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350504', '洛江区', '福建省·泉州市·洛江区', null, 'L', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350505', '泉港区', '福建省·泉州市·泉港区', null, 'Q', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350521', '惠安县', '福建省·泉州市·惠安县', null, 'H', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350524', '安溪县', '福建省·泉州市·安溪县', null, 'A', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350525', '永春县', '福建省·泉州市·永春县', null, 'Y', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350526', '德化县', '福建省·泉州市·德化县', null, 'D', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350527', '金门县', '福建省·泉州市·金门县', null, 'J', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350581', '石狮市', '福建省·泉州市·石狮市', null, 'S', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350582', '晋江市', '福建省·泉州市·晋江市', null, 'J', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350583', '南安市', '福建省·泉州市·南安市', null, 'N', null, null, null, '350500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350600', '漳州市', '福建省·漳州市', null, 'Z', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350602', '芗城区', '福建省·漳州市·芗城区', null, 'X', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350603', '龙文区', '福建省·漳州市·龙文区', null, 'L', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350622', '云霄县', '福建省·漳州市·云霄县', null, 'Y', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350623', '漳浦县', '福建省·漳州市·漳浦县', null, 'Z', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350624', '诏安县', '福建省·漳州市·诏安县', null, 'Z', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350625', '长泰县', '福建省·漳州市·长泰县', null, 'Z', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350626', '东山县', '福建省·漳州市·东山县', null, 'D', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350627', '南靖县', '福建省·漳州市·南靖县', null, 'N', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350628', '平和县', '福建省·漳州市·平和县', null, 'P', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350629', '华安县', '福建省·漳州市·华安县', null, 'H', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350681', '龙海市', '福建省·漳州市·龙海市', null, 'L', null, null, null, '350600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350700', '南平市', '福建省·南平市', null, 'N', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350702', '延平区', '福建省·南平市·延平区', null, 'Y', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350721', '顺昌县', '福建省·南平市·顺昌县', null, 'S', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350722', '浦城县', '福建省·南平市·浦城县', null, 'P', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350723', '光泽县', '福建省·南平市·光泽县', null, 'G', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350724', '松溪县', '福建省·南平市·松溪县', null, 'S', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350725', '政和县', '福建省·南平市·政和县', null, 'Z', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350781', '邵武市', '福建省·南平市·邵武市', null, 'S', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350782', '武夷山市', '福建省·南平市·武夷山市', null, 'W', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350783', '建瓯市', '福建省·南平市·建瓯市', null, 'J', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350784', '建阳市', '福建省·南平市·建阳市', null, 'J', null, null, null, '350700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350800', '龙岩市', '福建省·龙岩市', null, 'L', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350802', '新罗区', '福建省·龙岩市·新罗区', null, 'X', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350821', '长汀县', '福建省·龙岩市·长汀县', null, 'Z', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350822', '永定县', '福建省·龙岩市·永定县', null, 'Y', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350823', '上杭县', '福建省·龙岩市·上杭县', null, 'S', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350824', '武平县', '福建省·龙岩市·武平县', null, 'W', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350825', '连城县', '福建省·龙岩市·连城县', null, 'L', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350881', '漳平市', '福建省·龙岩市·漳平市', null, 'Z', null, null, null, '350800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350900', '宁德市', '福建省·宁德市', null, 'N', null, null, null, '350000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350902', '蕉城区', '福建省·宁德市·蕉城区', null, 'J', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350921', '霞浦县', '福建省·宁德市·霞浦县', null, 'X', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350922', '古田县', '福建省·宁德市·古田县', null, 'G', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350923', '屏南县', '福建省·宁德市·屏南县', null, 'P', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350924', '寿宁县', '福建省·宁德市·寿宁县', null, 'S', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350925', '周宁县', '福建省·宁德市·周宁县', null, 'Z', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350926', '柘荣县', '福建省·宁德市·柘荣县', null, 'Z', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350981', '福安市', '福建省·宁德市·福安市', null, 'F', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('350982', '福鼎市', '福建省·宁德市·福鼎市', null, 'F', null, null, null, '350900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360000', '江西省', '江西省', null, 'J', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360100', '南昌市', '江西省·南昌市', null, 'N', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360102', '东湖区', '江西省·南昌市·东湖区', null, 'D', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360103', '西湖区', '江西省·南昌市·西湖区', null, 'X', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360104', '青云谱区', '江西省·南昌市·青云谱区', null, 'Q', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360105', '湾里区', '江西省·南昌市·湾里区', null, 'W', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360111', '青山湖区', '江西省·南昌市·青山湖区', null, 'Q', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360121', '南昌县', '江西省·南昌市·南昌县', null, 'N', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360122', '新建县', '江西省·南昌市·新建县', null, 'X', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360123', '安义县', '江西省·南昌市·安义县', null, 'A', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360124', '进贤县', '江西省·南昌市·进贤县', null, 'J', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360125', '红谷滩新区', '江西省·南昌市·红谷滩新区', null, 'H', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360126', '经济技术开发区', '江西省·南昌市·经济技术开发区', null, 'J', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360127', '昌北区', '江西省·南昌市·昌北区', null, 'C', null, null, null, '360100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360200', '景德镇市', '江西省·景德镇市', null, 'J', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360202', '昌江区', '江西省·景德镇市·昌江区', null, 'C', null, null, null, '360200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360203', '珠山区', '江西省·景德镇市·珠山区', null, 'Z', null, null, null, '360200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360222', '浮梁县', '江西省·景德镇市·浮梁县', null, 'F', null, null, null, '360200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360281', '乐平市', '江西省·景德镇市·乐平市', null, 'L', null, null, null, '360200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360300', '萍乡市', '江西省·萍乡市', null, 'P', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360302', '安源区', '江西省·萍乡市·安源区', null, 'A', null, null, null, '360300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360313', '湘东区', '江西省·萍乡市·湘东区', null, 'X', null, null, null, '360300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360321', '莲花县', '江西省·萍乡市·莲花县', null, 'L', null, null, null, '360300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360322', '上栗县', '江西省·萍乡市·上栗县', null, 'S', null, null, null, '360300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360323', '芦溪县', '江西省·萍乡市·芦溪县', null, 'L', null, null, null, '360300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360400', '九江市', '江西省·九江市', null, 'J', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360402', '庐山区', '江西省·九江市·庐山区', null, 'L', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360403', '浔阳区', '江西省·九江市·浔阳区', null, 'X', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360421', '九江县', '江西省·九江市·九江县', null, 'J', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360423', '武宁县', '江西省·九江市·武宁县', null, 'W', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360424', '修水县', '江西省·九江市·修水县', null, 'X', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360425', '永修县', '江西省·九江市·永修县', null, 'Y', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360426', '德安县', '江西省·九江市·德安县', null, 'D', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360427', '星子县', '江西省·九江市·星子县', null, 'X', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360428', '都昌县', '江西省·九江市·都昌县', null, 'D', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360429', '湖口县', '江西省·九江市·湖口县', null, 'H', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360430', '彭泽县', '江西省·九江市·彭泽县', null, 'P', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360481', '瑞昌市', '江西省·九江市·瑞昌市', null, 'R', null, null, null, '360400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360500', '新余市', '江西省·新余市', null, 'X', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360502', '渝水区', '江西省·新余市·渝水区', null, 'Y', null, null, null, '360500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360521', '分宜县', '江西省·新余市·分宜县', null, 'F', null, null, null, '360500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360600', '鹰潭市', '江西省·鹰潭市', null, 'Y', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360602', '月湖区', '江西省·鹰潭市·月湖区', null, 'Y', null, null, null, '360600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360622', '余江县', '江西省·鹰潭市·余江县', null, 'Y', null, null, null, '360600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360681', '贵溪市', '江西省·鹰潭市·贵溪市', null, 'G', null, null, null, '360600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360700', '赣州市', '江西省·赣州市', null, 'G', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360702', '章贡区', '江西省·赣州市·章贡区', null, 'Z', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360721', '赣县', '江西省·赣州市·赣县', null, 'G', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360722', '信丰县', '江西省·赣州市·信丰县', null, 'X', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360723', '大余县', '江西省·赣州市·大余县', null, 'D', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360724', '上犹县', '江西省·赣州市·上犹县', null, 'S', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360725', '崇义县', '江西省·赣州市·崇义县', null, 'C', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360726', '安远县', '江西省·赣州市·安远县', null, 'A', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360727', '龙南县', '江西省·赣州市·龙南县', null, 'L', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360728', '定南县', '江西省·赣州市·定南县', null, 'D', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360729', '全南县', '江西省·赣州市·全南县', null, 'Q', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360730', '宁都县', '江西省·赣州市·宁都县', null, 'N', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360731', '于都县', '江西省·赣州市·于都县', null, 'Y', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360732', '兴国县', '江西省·赣州市·兴国县', null, 'X', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360733', '会昌县', '江西省·赣州市·会昌县', null, 'H', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360734', '寻乌县', '江西省·赣州市·寻乌县', null, 'X', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360735', '石城县', '江西省·赣州市·石城县', null, 'S', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360751', '黄金区', '江西省·赣州市·黄金区', null, 'H', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360781', '瑞金市', '江西省·赣州市·瑞金市', null, 'R', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360782', '南康市', '江西省·赣州市·南康市', null, 'N', null, null, null, '360700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360800', '吉安市', '江西省·吉安市', null, 'J', null, null, null, '360000', '2', '江西开通吉安市', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360802', '吉州区', '江西省·吉安市·吉州区', null, 'J', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360803', '青原区', '江西省·吉安市·青原区', null, 'Q', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360821', '吉安县', '江西省·吉安市·吉安县', null, 'J', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360822', '吉水县', '江西省·吉安市·吉水县', null, 'J', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360823', '峡江县', '江西省·吉安市·峡江县', null, 'X', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360824', '新干县', '江西省·吉安市·新干县', null, 'X', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360825', '永丰县', '江西省·吉安市·永丰县', null, 'Y', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360826', '泰和县', '江西省·吉安市·泰和县', null, 'T', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360827', '遂川县', '江西省·吉安市·遂川县', null, 'S', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360828', '万安县', '江西省·吉安市·万安县', null, 'W', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360829', '安福县', '江西省·吉安市·安福县', null, 'A', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360830', '永新县', '江西省·吉安市·永新县', null, 'Y', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360881', '井冈山市', '江西省·吉安市·井冈山市', null, 'J', null, null, null, '360800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360900', '宜春市', '江西省·宜春市', null, 'Y', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360902', '袁州区', '江西省·宜春市·袁州区', null, 'Y', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360921', '奉新县', '江西省·宜春市·奉新县', null, 'F', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360922', '万载县', '江西省·宜春市·万载县', null, 'W', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360923', '上高县', '江西省·宜春市·上高县', null, 'S', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360924', '宜丰县', '江西省·宜春市·宜丰县', null, 'Y', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360925', '靖安县', '江西省·宜春市·靖安县', null, 'J', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360926', '铜鼓县', '江西省·宜春市·铜鼓县', null, 'T', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360981', '丰城市', '江西省·宜春市·丰城市', null, 'F', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360982', '樟树市', '江西省·宜春市·樟树市', null, 'Z', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('360983', '高安市', '江西省·宜春市·高安市', null, 'G', null, null, null, '360900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361000', '抚州市', '江西省·抚州市', null, 'F', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361002', '临川区', '江西省·抚州市·临川区', null, 'L', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361021', '南城县', '江西省·抚州市·南城县', null, 'N', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361022', '黎川县', '江西省·抚州市·黎川县', null, 'L', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361023', '南丰县', '江西省·抚州市·南丰县', null, 'N', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361024', '崇仁县', '江西省·抚州市·崇仁县', null, 'C', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361025', '乐安县', '江西省·抚州市·乐安县', null, 'L', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361026', '宜黄县', '江西省·抚州市·宜黄县', null, 'Y', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361027', '金溪县', '江西省·抚州市·金溪县', null, 'J', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361028', '资溪县', '江西省·抚州市·资溪县', null, 'Z', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361029', '东乡县', '江西省·抚州市·东乡县', null, 'D', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361030', '广昌县', '江西省·抚州市·广昌县', null, 'G', null, null, null, '361000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361100', '上饶市', '江西省·上饶市', null, 'S', null, null, null, '360000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361102', '信州区', '江西省·上饶市·信州区', null, 'X', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361121', '上饶县', '江西省·上饶市·上饶县', null, 'S', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361122', '广丰县', '江西省·上饶市·广丰县', null, 'G', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361123', '玉山县', '江西省·上饶市·玉山县', null, 'Y', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361124', '铅山县', '江西省·上饶市·铅山县', null, 'Q', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361125', '横峰县', '江西省·上饶市·横峰县', null, 'H', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361126', '弋阳县', '江西省·上饶市·弋阳县', null, 'Y', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361127', '余干县', '江西省·上饶市·余干县', null, 'Y', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361128', '鄱阳县', '江西省·上饶市·鄱阳县', null, 'P', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361129', '万年县', '江西省·上饶市·万年县', null, 'W', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361130', '婺源县', '江西省·上饶市·婺源县', null, 'W', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('361181', '德兴市', '江西省·上饶市·德兴市', null, 'D', null, null, null, '361100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370000', '山东省', '山东省', null, 'S', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370100', '济南市', '山东省·济南市', null, 'J', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370102', '历下区', '山东省·济南市·历下区', null, 'L', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370103', '市中区', '山东省·济南市·市中区', null, 'S', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370104', '槐荫区', '山东省·济南市·槐荫区', null, 'H', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370105', '天桥区', '山东省·济南市·天桥区', null, 'T', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370112', '历城区', '山东省·济南市·历城区', null, 'L', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370113', '长清区', '山东省·济南市·长清区', null, 'Z', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370124', '平阴县', '山东省·济南市·平阴县', null, 'P', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370125', '济阳县', '山东省·济南市·济阳县', null, 'J', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370126', '商河县', '山东省·济南市·商河县', null, 'S', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370181', '章丘市', '山东省·济南市·章丘市', null, 'Z', null, null, null, '370100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370200', '青岛市', '山东省·青岛市', null, 'Q', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370202', '市南区', '山东省·青岛市·市南区', null, 'S', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370203', '市北区', '山东省·青岛市·市北区', null, 'S', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370205', '四方区', '山东省·青岛市·四方区', null, 'S', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370211', '黄岛区', '山东省·青岛市·黄岛区', null, 'H', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370212', '崂山区', '山东省·青岛市·崂山区', null, 'L', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370213', '李沧区', '山东省·青岛市·李沧区', null, 'L', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370214', '城阳区', '山东省·青岛市·城阳区', null, 'C', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370251', '开发区', '山东省·青岛市·开发区', null, 'K', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370281', '胶州市', '山东省·青岛市·胶州市', null, 'J', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370282', '即墨市', '山东省·青岛市·即墨市', null, 'J', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370283', '平度市', '山东省·青岛市·平度市', null, 'P', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370284', '胶南市', '山东省·青岛市·胶南市', null, 'J', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370285', '莱西市', '山东省·青岛市·莱西市', null, 'L', null, null, null, '370200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370300', '淄博市', '山东省·淄博市', null, 'Z', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370302', '淄川区', '山东省·淄博市·淄川区', null, 'Z', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370303', '张店区', '山东省·淄博市·张店区', null, 'Z', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370304', '博山区', '山东省·淄博市·博山区', null, 'B', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370305', '临淄区', '山东省·淄博市·临淄区', null, 'L', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370306', '周村区', '山东省·淄博市·周村区', null, 'Z', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370321', '桓台县', '山东省·淄博市·桓台县', null, 'H', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370322', '高青县', '山东省·淄博市·高青县', null, 'G', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370323', '沂源县', '山东省·淄博市·沂源县', null, 'Y', null, null, null, '370300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370400', '枣庄市', '山东省·枣庄市', null, 'Z', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370402', '市中区', '山东省·枣庄市·市中区', null, 'S', null, null, null, '370400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370403', '薛城区', '山东省·枣庄市·薛城区', null, 'X', null, null, null, '370400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370404', '峄城区', '山东省·枣庄市·峄城区', null, 'Y', null, null, null, '370400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370405', '台儿庄区', '山东省·枣庄市·台儿庄区', null, 'T', null, null, null, '370400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370406', '山亭区', '山东省·枣庄市·山亭区', null, 'S', null, null, null, '370400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370481', '滕州市', '山东省·枣庄市·滕州市', null, 'T', null, null, null, '370400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370500', '东营市', '山东省·东营市', null, 'D', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370502', '东营区', '山东省·东营市·东营区', null, 'D', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370503', '河口区', '山东省·东营市·河口区', null, 'H', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370521', '垦利县', '山东省·东营市·垦利县', null, 'K', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370522', '利津县', '山东省·东营市·利津县', null, 'L', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370523', '广饶县', '山东省·东营市·广饶县', null, 'G', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370589', '西城区', '山东省·东营市·西城区', null, 'X', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370590', '东城区', '山东省·东营市·东城区', null, 'D', null, null, null, '370500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370600', '烟台市', '山东省·烟台市', null, 'Y', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370602', '芝罘区', '山东省·烟台市·芝罘区', null, 'Z', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370611', '福山区', '山东省·烟台市·福山区', null, 'F', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370612', '牟平区', '山东省·烟台市·牟平区', null, 'M', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370613', '莱山区', '山东省·烟台市·莱山区', null, 'L', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370634', '长岛县', '山东省·烟台市·长岛县', null, 'Z', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370681', '龙口市', '山东省·烟台市·龙口市', null, 'L', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370682', '莱阳市', '山东省·烟台市·莱阳市', null, 'L', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370683', '莱州市', '山东省·烟台市·莱州市', null, 'L', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370684', '蓬莱市', '山东省·烟台市·蓬莱市', null, 'P', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370685', '招远市', '山东省·烟台市·招远市', null, 'Z', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370686', '栖霞市', '山东省·烟台市·栖霞市', null, 'Q', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370687', '海阳市', '山东省·烟台市·海阳市', null, 'H', null, null, null, '370600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370700', '潍坊市', '山东省·潍坊市', null, 'W', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370702', '潍城区', '山东省·潍坊市·潍城区', null, 'W', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370703', '寒亭区', '山东省·潍坊市·寒亭区', null, 'H', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370704', '坊子区', '山东省·潍坊市·坊子区', null, 'F', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370705', '奎文区', '山东省·潍坊市·奎文区', null, 'K', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370724', '临朐县', '山东省·潍坊市·临朐县', null, 'L', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370725', '昌乐县', '山东省·潍坊市·昌乐县', null, 'C', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370751', '开发区', '山东省·潍坊市·开发区', null, 'K', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370781', '青州市', '山东省·潍坊市·青州市', null, 'Q', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370782', '诸城市', '山东省·潍坊市·诸城市', null, 'Z', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370783', '寿光市', '山东省·潍坊市·寿光市', null, 'S', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370784', '安丘市', '山东省·潍坊市·安丘市', null, 'A', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370785', '高密市', '山东省·潍坊市·高密市', null, 'G', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370786', '昌邑市', '山东省·潍坊市·昌邑市', null, 'C', null, null, null, '370700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370800', '济宁市', '山东省·济宁市', null, 'J', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370802', '市中区', '山东省·济宁市·市中区', null, 'S', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370811', '任城区', '山东省·济宁市·任城区', null, 'R', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370826', '微山县', '山东省·济宁市·微山县', null, 'W', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370827', '鱼台县', '山东省·济宁市·鱼台县', null, 'Y', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370828', '金乡县', '山东省·济宁市·金乡县', null, 'J', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370829', '嘉祥县', '山东省·济宁市·嘉祥县', null, 'J', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370830', '汶上县', '山东省·济宁市·汶上县', null, 'W', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370831', '泗水县', '山东省·济宁市·泗水县', null, 'S', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370832', '梁山县', '山东省·济宁市·梁山县', null, 'L', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370881', '曲阜市', '山东省·济宁市·曲阜市', null, 'Q', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370882', '兖州市', '山东省·济宁市·兖州市', null, 'Y', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370883', '邹城市', '山东省·济宁市·邹城市', null, 'Z', null, null, null, '370800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370900', '泰安市', '山东省·泰安市', null, 'T', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370902', '泰山区', '山东省·泰安市·泰山区', null, 'T', null, null, null, '370900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370903', '岱岳区', '山东省·泰安市·岱岳区', null, 'D', null, null, null, '370900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370921', '宁阳县', '山东省·泰安市·宁阳县', null, 'N', null, null, null, '370900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370923', '东平县', '山东省·泰安市·东平县', null, 'D', null, null, null, '370900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370982', '新泰市', '山东省·泰安市·新泰市', null, 'X', null, null, null, '370900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('370983', '肥城市', '山东省·泰安市·肥城市', null, 'F', null, null, null, '370900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371000', '威海市', '山东省·威海市', null, 'W', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371002', '环翠区', '山东省·威海市·环翠区', null, 'H', null, null, null, '371000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371081', '文登市', '山东省·威海市·文登市', null, 'W', null, null, null, '371000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371082', '荣成市', '山东省·威海市·荣成市', null, 'R', null, null, null, '371000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371083', '乳山市', '山东省·威海市·乳山市', null, 'R', null, null, null, '371000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371100', '日照市', '山东省·日照市', null, 'R', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371102', '东港区', '山东省·日照市·东港区', null, 'D', null, null, null, '371100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371103', '岚山区', '山东省·日照市·岚山区', null, 'L', null, null, null, '371100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371121', '五莲县', '山东省·日照市·五莲县', null, 'W', null, null, null, '371100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371122', '莒县', '山东省·日照市·莒县', null, 'J', null, null, null, '371100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371200', '莱芜市', '山东省·莱芜市', null, 'L', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371202', '莱城区', '山东省·莱芜市·莱城区', null, 'L', null, null, null, '371200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371203', '钢城区', '山东省·莱芜市·钢城区', null, 'G', null, null, null, '371200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371300', '临沂市', '山东省·临沂市', null, 'L', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371302', '兰山区', '山东省·临沂市·兰山区', null, 'L', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371311', '罗庄区', '山东省·临沂市·罗庄区', null, 'L', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371312', '河东区', '山东省·临沂市·河东区', null, 'H', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371321', '沂南县', '山东省·临沂市·沂南县', null, 'Y', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371322', '郯城县', '山东省·临沂市·郯城县', null, 'T', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371323', '沂水县', '山东省·临沂市·沂水县', null, 'Y', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371324', '苍山县', '山东省·临沂市·苍山县', null, 'C', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371325', '费县', '山东省·临沂市·费县', null, 'F', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371326', '平邑县', '山东省·临沂市·平邑县', null, 'P', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371327', '莒南县', '山东省·临沂市·莒南县', null, 'J', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371328', '蒙阴县', '山东省·临沂市·蒙阴县', null, 'M', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371329', '临沭县', '山东省·临沂市·临沭县', null, 'L', null, null, null, '371300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371400', '德州市', '山东省·德州市', null, 'D', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371402', '德城区', '山东省·德州市·德城区', null, 'D', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371421', '陵县', '山东省·德州市·陵县', null, 'L', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371422', '宁津县', '山东省·德州市·宁津县', null, 'N', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371423', '庆云县', '山东省·德州市·庆云县', null, 'Q', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371424', '临邑县', '山东省·德州市·临邑县', null, 'L', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371425', '齐河县', '山东省·德州市·齐河县', null, 'Q', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371426', '平原县', '山东省·德州市·平原县', null, 'P', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371427', '夏津县', '山东省·德州市·夏津县', null, 'X', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371428', '武城县', '山东省·德州市·武城县', null, 'W', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371451', '开发区', '山东省·德州市·开发区', null, 'K', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371481', '乐陵市', '山东省·德州市·乐陵市', null, 'L', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371482', '禹城市', '山东省·德州市·禹城市', null, 'Y', null, null, null, '371400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371500', '聊城市', '山东省·聊城市', null, 'L', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371502', '东昌府区', '山东省·聊城市·东昌府区', null, 'D', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371521', '阳谷县', '山东省·聊城市·阳谷县', null, 'Y', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371522', '莘县', '山东省·聊城市·莘县', null, 'S', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371523', '茌平县', '山东省·聊城市·茌平县', null, 'C', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371524', '东阿县', '山东省·聊城市·东阿县', null, 'D', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371525', '冠县', '山东省·聊城市·冠县', null, 'G', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371526', '高唐县', '山东省·聊城市·高唐县', null, 'G', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371581', '临清市', '山东省·聊城市·临清市', null, 'L', null, null, null, '371500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371600', '滨州市', '山东省·滨州市', null, 'B', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371602', '滨城区', '山东省·滨州市·滨城区', null, 'B', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371621', '惠民县', '山东省·滨州市·惠民县', null, 'H', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371622', '阳信县', '山东省·滨州市·阳信县', null, 'Y', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371623', '无棣县', '山东省·滨州市·无棣县', null, 'W', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371624', '沾化县', '山东省·滨州市·沾化县', null, 'Z', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371625', '博兴县', '山东省·滨州市·博兴县', null, 'B', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371626', '邹平县', '山东省·滨州市·邹平县', null, 'Z', null, null, null, '371600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371700', '菏泽市', '山东省·菏泽市', null, 'H', null, null, null, '370000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371702', '牡丹区', '山东省·菏泽市·牡丹区', null, 'M', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371721', '曹县', '山东省·菏泽市·曹县', null, 'C', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371722', '单县', '山东省·菏泽市·单县', null, 'D', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371723', '成武县', '山东省·菏泽市·成武县', null, 'C', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371724', '巨野县', '山东省·菏泽市·巨野县', null, 'J', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371725', '郓城县', '山东省·菏泽市·郓城县', null, 'Y', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371726', '鄄城县', '山东省·菏泽市·鄄城县', null, 'J', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371727', '定陶县', '山东省·菏泽市·定陶县', null, 'D', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('371728', '东明县', '山东省·菏泽市·东明县', null, 'D', null, null, null, '371700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410000', '河南省', '河南省', null, 'H', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410100', '郑州市', '河南省·郑州市', null, 'Z', null, null, null, '410000', '2', '', '1472695224', '1472695224', '1');
INSERT INTO `pad_city_info` VALUES ('410102', '中原区', '河南省·郑州市·中原区', null, 'Z', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410103', '二七区', '河南省·郑州市·二七区', null, 'E', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410104', '管城回族区', '河南省·郑州市·管城回族区', null, 'G', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410105', '金水区', '河南省·郑州市·金水区', null, 'J', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410106', '上街区', '河南省·郑州市·上街区', null, 'S', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410108', '惠济区', '河南省·郑州市·惠济区', null, 'H', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410122', '中牟县', '河南省·郑州市·中牟县', null, 'Z', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410181', '巩义市', '河南省·郑州市·巩义市', null, 'G', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410182', '荥阳市', '河南省·郑州市·荥阳市', null, 'Y', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410183', '新密市', '河南省·郑州市·新密市', null, 'X', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410184', '新郑市', '河南省·郑州市·新郑市', null, 'X', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410185', '登封市', '河南省·郑州市·登封市', null, 'D', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410186', '郑东新区', '河南省·郑州市·郑东新区', null, 'Z', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410187', '高新区', '河南省·郑州市·高新区', null, 'G', null, null, null, '410100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410188', 'ad', null, null, null, null, null, null, '410100', '3', null, '1472695244', '1472695244', '99');
INSERT INTO `pad_city_info` VALUES ('410200', '开封市', '河南省·开封市', null, 'K', null, null, null, '410000', '2', '', '1472711475', '1472711475', '1');
INSERT INTO `pad_city_info` VALUES ('410202', '龙亭区', '河南省·开封市·龙亭区', null, 'L', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410203', '顺河回族区', '河南省·开封市·顺河回族区', null, 'S', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410204', '鼓楼区', '河南省·开封市·鼓楼区', null, 'G', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410205', '禹王台区', '河南省·开封市·禹王台区', null, 'Y', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410211', '金明区', '河南省·开封市·金明区', null, 'J', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410221', '杞县', '河南省·开封市·杞县', null, 'Q', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410222', '通许县', '河南省·开封市·通许县', null, 'T', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410223', '尉氏县', '河南省·开封市·尉氏县', null, 'W', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410224', '开封县', '河南省·开封市·开封县', null, 'K', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410225', '兰考县', '河南省·开封市·兰考县', null, 'L', null, null, null, '410200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410300', '洛阳市', '河南省·洛阳市', null, 'L', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410302', '老城区', '河南省·洛阳市·老城区', null, 'L', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410303', '西工区', '河南省·洛阳市·西工区', null, 'X', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410304', '廛河回族区', '河南省·洛阳市·廛河回族区', null, 'C', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410305', '涧西区', '河南省·洛阳市·涧西区', null, 'J', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410306', '吉利区', '河南省·洛阳市·吉利区', null, 'J', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410307', '洛龙区', '河南省·洛阳市·洛龙区', null, 'L', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410322', '孟津县', '河南省·洛阳市·孟津县', null, 'M', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410323', '新安县', '河南省·洛阳市·新安县', null, 'X', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410324', '栾川县', '河南省·洛阳市·栾川县', null, 'L', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410325', '嵩县', '河南省·洛阳市·嵩县', null, 'S', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410326', '汝阳县', '河南省·洛阳市·汝阳县', null, 'R', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410327', '宜阳县', '河南省·洛阳市·宜阳县', null, 'Y', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410328', '洛宁县', '河南省·洛阳市·洛宁县', null, 'L', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410329', '伊川县', '河南省·洛阳市·伊川县', null, 'Y', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410381', '偃师市', '河南省·洛阳市·偃师市', null, 'Y', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410400', '平顶山市', '河南省·平顶山市', null, 'P', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410402', '新华区', '河南省·平顶山市·新华区', null, 'X', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410403', '卫东区', '河南省·平顶山市·卫东区', null, 'W', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410404', '石龙区', '河南省·平顶山市·石龙区', null, 'S', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410411', '湛河区', '河南省·平顶山市·湛河区', null, 'Z', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410421', '宝丰县', '河南省·平顶山市·宝丰县', null, 'B', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410422', '叶县', '河南省·平顶山市·叶县', null, 'Y', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410423', '鲁山县', '河南省·平顶山市·鲁山县', null, 'L', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410425', '郏县', '河南省·平顶山市·郏县', null, 'J', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410481', '舞钢市', '河南省·平顶山市·舞钢市', null, 'W', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410482', '汝州市', '河南省·平顶山市·汝州市', null, 'R', null, null, null, '410400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410500', '安阳市', '河南省·安阳市', null, 'A', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410502', '文峰区', '河南省·安阳市·文峰区', null, 'W', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410503', '北关区', '河南省·安阳市·北关区', null, 'B', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410505', '殷都区', '河南省·安阳市·殷都区', null, 'Y', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410506', '龙安区', '河南省·安阳市·龙安区', null, 'L', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410522', '安阳县', '河南省·安阳市·安阳县', null, 'A', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410523', '汤阴县', '河南省·安阳市·汤阴县', null, 'T', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410526', '滑县', '河南省·安阳市·滑县', null, 'H', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410527', '内黄县', '河南省·安阳市·内黄县', null, 'N', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410581', '林州市', '河南省·安阳市·林州市', null, 'L', null, null, null, '410500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410600', '鹤壁市', '河南省·鹤壁市', null, 'H', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410602', '鹤山区', '河南省·鹤壁市·鹤山区', null, 'H', null, null, null, '410600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410603', '山城区', '河南省·鹤壁市·山城区', null, 'S', null, null, null, '410600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410611', '淇滨区', '河南省·鹤壁市·淇滨区', null, 'Q', null, null, null, '410600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410621', '浚县', '河南省·鹤壁市·浚县', null, 'J', null, null, null, '410600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410622', '淇县', '河南省·鹤壁市·淇县', null, 'Q', null, null, null, '410600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410700', '新乡市', '河南省·新乡市', null, 'X', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410702', '红旗区', '河南省·新乡市·红旗区', null, 'H', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410703', '卫滨区', '河南省·新乡市·卫滨区', null, 'W', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410704', '凤泉区', '河南省·新乡市·凤泉区', null, 'F', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410711', '牧野区', '河南省·新乡市·牧野区', null, 'M', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410721', '新乡县', '河南省·新乡市·新乡县', null, 'X', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410724', '获嘉县', '河南省·新乡市·获嘉县', null, 'H', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410725', '原阳县', '河南省·新乡市·原阳县', null, 'Y', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410726', '延津县', '河南省·新乡市·延津县', null, 'Y', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410727', '封丘县', '河南省·新乡市·封丘县', null, 'F', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410728', '长垣县', '河南省·新乡市·长垣县', null, 'Z', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410781', '卫辉市', '河南省·新乡市·卫辉市', null, 'W', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410782', '辉县市', '河南省·新乡市·辉县市', null, 'H', null, null, null, '410700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410800', '焦作市', '河南省·焦作市', null, 'J', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410802', '解放区', '河南省·焦作市·解放区', null, 'J', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410803', '中站区', '河南省·焦作市·中站区', null, 'Z', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410804', '马村区', '河南省·焦作市·马村区', null, 'M', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410811', '山阳区', '河南省·焦作市·山阳区', null, 'S', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410821', '修武县', '河南省·焦作市·修武县', null, 'X', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410822', '博爱县', '河南省·焦作市·博爱县', null, 'B', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410823', '武陟县', '河南省·焦作市·武陟县', null, 'W', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410825', '温县', '河南省·焦作市·温县', null, 'W', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410881', '济源市', '河南省·济源市', null, 'J', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410882', '沁阳市', '河南省·焦作市·沁阳市', null, 'Q', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410883', '孟州市', '河南省·焦作市·孟州市', null, 'M', null, null, null, '410800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410900', '濮阳市', '河南省·濮阳市', null, 'P', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410902', '华龙区', '河南省·濮阳市·华龙区', null, 'H', null, null, null, '410900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410922', '清丰县', '河南省·濮阳市·清丰县', null, 'Q', null, null, null, '410900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410923', '南乐县', '河南省·濮阳市·南乐县', null, 'N', null, null, null, '410900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410926', '范县', '河南省·濮阳市·范县', null, 'F', null, null, null, '410900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410927', '台前县', '河南省·濮阳市·台前县', null, 'T', null, null, null, '410900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('410928', '濮阳县', '河南省·濮阳市·濮阳县', null, 'P', null, null, null, '410900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411000', '许昌市', '河南省·许昌市', null, 'X', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411002', '魏都区', '河南省·许昌市·魏都区', null, 'W', null, null, null, '411000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411023', '许昌县', '河南省·许昌市·许昌县', null, 'X', null, null, null, '411000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411024', '鄢陵县', '河南省·许昌市·鄢陵县', null, 'Y', null, null, null, '411000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411025', '襄城县', '河南省·许昌市·襄城县', null, 'X', null, null, null, '411000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411081', '禹州市', '河南省·许昌市·禹州市', null, 'Y', null, null, null, '411000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411082', '长葛市', '河南省·许昌市·长葛市', null, 'Z', null, null, null, '411000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411100', '漯河市', '河南省·漯河市', null, 'L', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411102', '源汇区', '河南省·漯河市·源汇区', null, 'Y', null, null, null, '411100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411103', '郾城区', '河南省·漯河市·郾城区', null, 'Y', null, null, null, '411100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411104', '召陵区', '河南省·漯河市·召陵区', null, 'Z', null, null, null, '411100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411121', '舞阳县', '河南省·漯河市·舞阳县', null, 'W', null, null, null, '411100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411122', '临颍县', '河南省·漯河市·临颍县', null, 'L', null, null, null, '411100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411200', '三门峡市', '河南省·三门峡市', null, 'S', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411202', '湖滨区', '河南省·三门峡市·湖滨区', null, 'H', null, null, null, '411200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411221', '渑池县', '河南省·三门峡市·渑池县', null, 'M', null, null, null, '411200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411222', '陕县', '河南省·三门峡市·陕县', null, 'S', null, null, null, '411200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411224', '卢氏县', '河南省·三门峡市·卢氏县', null, 'L', null, null, null, '411200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411281', '义马市', '河南省·三门峡市·义马市', null, 'Y', null, null, null, '411200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411282', '灵宝市', '河南省·三门峡市·灵宝市', null, 'L', null, null, null, '411200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411300', '南阳市', '河南省·南阳市', null, 'N', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411302', '宛城区', '河南省·南阳市·宛城区', null, 'W', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411303', '卧龙区', '河南省·南阳市·卧龙区', null, 'W', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411321', '南召县', '河南省·南阳市·南召县', null, 'N', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411322', '方城县', '河南省·南阳市·方城县', null, 'F', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411323', '西峡县', '河南省·南阳市·西峡县', null, 'X', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411324', '镇平县', '河南省·南阳市·镇平县', null, 'Z', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411325', '内乡县', '河南省·南阳市·内乡县', null, 'N', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411326', '淅川县', '河南省·南阳市·淅川县', null, 'X', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411327', '社旗县', '河南省·南阳市·社旗县', null, 'S', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411328', '唐河县', '河南省·南阳市·唐河县', null, 'T', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411329', '新野县', '河南省·南阳市·新野县', null, 'X', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411330', '桐柏县', '河南省·南阳市·桐柏县', null, 'T', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411381', '邓州市', '河南省·南阳市·邓州市', null, 'D', null, null, null, '411300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411400', '商丘市', '河南省·商丘市', null, 'S', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411402', '梁园区', '河南省·商丘市·梁园区', null, 'L', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411403', '睢阳区', '河南省·商丘市·睢阳区', null, 'S', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411421', '民权县', '河南省·商丘市·民权县', null, 'M', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411422', '睢县', '河南省·商丘市·睢县', null, 'S', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411423', '宁陵县', '河南省·商丘市·宁陵县', null, 'N', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411424', '柘城县', '河南省·商丘市·柘城县', null, 'Z', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411425', '虞城县', '河南省·商丘市·虞城县', null, 'Y', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411426', '夏邑县', '河南省·商丘市·夏邑县', null, 'X', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411481', '永城市', '河南省·商丘市·永城市', null, 'Y', null, null, null, '411400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411500', '信阳市', '河南省·信阳市', null, 'X', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411502', '浉河区', '河南省·信阳市·浉河区', null, '', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411503', '平桥区', '河南省·信阳市·平桥区', null, 'P', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411521', '罗山县', '河南省·信阳市·罗山县', null, 'L', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411522', '光山县', '河南省·信阳市·光山县', null, 'G', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411523', '新县', '河南省·信阳市·新县', null, 'X', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411524', '商城县', '河南省·信阳市·商城县', null, 'S', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411525', '固始县', '河南省·信阳市·固始县', null, 'G', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411526', '潢川县', '河南省·信阳市·潢川县', null, 'H', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411527', '淮滨县', '河南省·信阳市·淮滨县', null, 'H', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411528', '息县', '河南省·信阳市·息县', null, 'X', null, null, null, '411500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411600', '周口市', '河南省·周口市', null, 'Z', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411602', '川汇区', '河南省·周口市·川汇区', null, 'C', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411621', '扶沟县', '河南省·周口市·扶沟县', null, 'F', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411622', '西华县', '河南省·周口市·西华县', null, 'X', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411623', '商水县', '河南省·周口市·商水县', null, 'S', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411624', '沈丘县', '河南省·周口市·沈丘县', null, 'S', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411625', '郸城县', '河南省·周口市·郸城县', null, 'D', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411626', '淮阳县', '河南省·周口市·淮阳县', null, 'H', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411627', '太康县', '河南省·周口市·太康县', null, 'T', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411628', '鹿邑县', '河南省·周口市·鹿邑县', null, 'L', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411681', '项城市', '河南省·周口市·项城市', null, 'X', null, null, null, '411600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411700', '驻马店市', '河南省·驻马店市', null, 'Z', null, null, null, '410000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411702', '驿城区', '河南省·驻马店市·驿城区', null, 'Y', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411721', '西平县', '河南省·驻马店市·西平县', null, 'X', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411722', '上蔡县', '河南省·驻马店市·上蔡县', null, 'S', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411723', '平舆县', '河南省·驻马店市·平舆县', null, 'P', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411724', '正阳县', '河南省·驻马店市·正阳县', null, 'Z', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411725', '确山县', '河南省·驻马店市·确山县', null, 'Q', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411726', '泌阳县', '河南省·驻马店市·泌阳县', null, 'M', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411727', '汝南县', '河南省·驻马店市·汝南县', null, 'R', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411728', '遂平县', '河南省·驻马店市·遂平县', null, 'S', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('411729', '新蔡县', '河南省·驻马店市·新蔡县', null, 'X', null, null, null, '411700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420000', '湖北省', '湖北省', null, 'H', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420100', '武汉市', '湖北省·武汉市', null, 'W', null, null, null, '420000', '2', '', '1472711316', '1472711316', '1');
INSERT INTO `pad_city_info` VALUES ('420102', '江岸区', '湖北省·武汉市·江岸区', null, 'J', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420103', '江汉区', '湖北省·武汉市·江汉区', null, 'J', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420104', '硚口区', '湖北省·武汉市·硚口区', null, '', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420105', '汉阳区', '湖北省·武汉市·汉阳区', null, 'H', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420106', '武昌区', '湖北省·武汉市·武昌区', null, 'W', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420107', '青山区', '湖北省·武汉市·青山区', null, 'Q', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420111', '洪山区', '湖北省·武汉市·洪山区', null, 'H', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420112', '东西湖区', '湖北省·武汉市·东西湖区', null, 'D', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420113', '汉南区', '湖北省·武汉市·汉南区', null, 'H', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420114', '蔡甸区', '湖北省·武汉市·蔡甸区', null, 'C', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420115', '江夏区', '湖北省·武汉市·江夏区', null, 'J', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420116', '黄陂区', '湖北省·武汉市·黄陂区', null, 'H', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420117', '新洲区', '湖北省·武汉市·新洲区', null, 'X', null, null, null, '420100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420200', '黄石市', '湖北省·黄石市', null, 'H', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420202', '黄石港区', '湖北省·黄石市·黄石港区', null, 'H', null, null, null, '420200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420203', '西塞山区', '湖北省·黄石市·西塞山区', null, 'X', null, null, null, '420200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420204', '下陆区', '湖北省·黄石市·下陆区', null, 'X', null, null, null, '420200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420205', '铁山区', '湖北省·黄石市·铁山区', null, 'T', null, null, null, '420200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420222', '阳新县', '湖北省·黄石市·阳新县', null, 'Y', null, null, null, '420200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420281', '大冶市', '湖北省·黄石市·大冶市', null, 'D', null, null, null, '420200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420300', '十堰市', '湖北省·十堰市', null, 'S', null, null, null, '420000', '2', '', '1472711363', '1472711363', '1');
INSERT INTO `pad_city_info` VALUES ('420302', '茅箭区', '湖北省·十堰市·茅箭区', null, 'M', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420303', '张湾区', '湖北省·十堰市·张湾区', null, 'Z', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420321', '郧县', '湖北省·十堰市·郧县', null, 'Y', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420322', '郧西县', '湖北省·十堰市·郧西县', null, 'Y', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420323', '竹山县', '湖北省·十堰市·竹山县', null, 'Z', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420324', '竹溪县', '湖北省·十堰市·竹溪县', null, 'Z', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420325', '房县', '湖北省·十堰市·房县', null, 'F', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420381', '丹江口市', '湖北省·十堰市·丹江口市', null, 'D', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420382', '城区', '湖北省·十堰市·城区', null, 'C', null, null, null, '420300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420500', '宜昌市', '湖北省·宜昌市', null, 'Y', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420502', '西陵区', '湖北省·宜昌市·西陵区', null, 'X', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420503', '伍家岗区', '湖北省·宜昌市·伍家岗区', null, 'W', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420504', '点军区', '湖北省·宜昌市·点军区', null, 'D', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420505', '猇亭区', '湖北省·宜昌市·猇亭区', null, '', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420506', '夷陵区', '湖北省·宜昌市·夷陵区', null, 'Y', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420525', '远安县', '湖北省·宜昌市·远安县', null, 'Y', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420526', '兴山县', '湖北省·宜昌市·兴山县', null, 'X', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420527', '秭归县', '湖北省·宜昌市·秭归县', null, 'Z', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420528', '长阳土家族自治县', '湖北省·宜昌市·长阳土家族自治县', null, 'Z', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420529', '五峰土家族自治县', '湖北省·宜昌市·五峰土家族自治县', null, 'W', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420551', '葛洲坝区', '湖北省·宜昌市·葛洲坝区', null, 'G', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420552', '开发区', '湖北省·宜昌市·开发区', null, 'K', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420581', '宜都市', '湖北省·宜昌市·宜都市', null, 'Y', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420582', '当阳市', '湖北省·宜昌市·当阳市', null, 'D', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420583', '枝江市', '湖北省·宜昌市·枝江市', null, 'Z', null, null, null, '420500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420600', '襄阳市', '湖北省·襄阳市', null, 'X', null, null, null, '420000', '2', '', '1472694978', '1472694978', '1');
INSERT INTO `pad_city_info` VALUES ('420602', '襄城区', '湖北省·襄阳市·襄城区', null, 'X', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420606', '樊城区', '湖北省·襄阳市·樊城区', null, 'F', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420607', '襄州区', '湖北省·襄阳市·襄州区', null, 'X', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420624', '南漳县', '湖北省·襄阳市·南漳县', null, 'N', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420625', '谷城县', '湖北省·襄阳市·谷城县', null, 'G', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420626', '保康县', '湖北省·襄阳市·保康县', null, 'B', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420682', '老河口市', '湖北省·襄阳市·老河口市', null, 'L', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420683', '枣阳市', '湖北省·襄阳市·枣阳市', null, 'Z', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420684', '宜城市', '湖北省·襄阳市·宜城市', null, 'Y', null, null, null, '420600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420700', '鄂州市', '湖北省·鄂州市', null, 'E', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420702', '梁子湖区', '湖北省·鄂州市·梁子湖区', null, 'L', null, null, null, '420700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420703', '华容区', '湖北省·鄂州市·华容区', null, 'H', null, null, null, '420700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420704', '鄂城区', '湖北省·鄂州市·鄂城区', null, 'E', null, null, null, '420700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420800', '荆门市', '湖北省·荆门市', null, 'J', null, null, null, '420000', '2', '', '1472711512', '1472711512', '1');
INSERT INTO `pad_city_info` VALUES ('420802', '东宝区', '湖北省·荆门市·东宝区', null, 'D', null, null, null, '420800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420804', '掇刀区', '湖北省·荆门市·掇刀区', null, 'D', null, null, null, '420800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420821', '京山县', '湖北省·荆门市·京山县', null, 'J', null, null, null, '420800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420822', '沙洋县', '湖北省·荆门市·沙洋县', null, 'S', null, null, null, '420800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420881', '钟祥市', '湖北省·荆门市·钟祥市', null, 'Z', null, null, null, '420800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420900', '孝感市', '湖北省·孝感市', null, 'X', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420902', '孝南区', '湖北省·孝感市·孝南区', null, 'X', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420921', '孝昌县', '湖北省·孝感市·孝昌县', null, 'X', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420922', '大悟县', '湖北省·孝感市·大悟县', null, 'D', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420923', '云梦县', '湖北省·孝感市·云梦县', null, 'Y', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420981', '应城市', '湖北省·孝感市·应城市', null, 'Y', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420982', '安陆市', '湖北省·孝感市·安陆市', null, 'A', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420984', '汉川市', '湖北省·孝感市·汉川市', null, 'H', null, null, null, '420900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421000', '荆州市', '湖北省·荆州市', null, 'J', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421002', '沙市区', '湖北省·荆州市·沙市区', null, 'S', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421003', '荆州区', '湖北省·荆州市·荆州区', null, 'J', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421022', '公安县', '湖北省·荆州市·公安县', null, 'G', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421023', '监利县', '湖北省·荆州市·监利县', null, 'J', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421024', '江陵县', '湖北省·荆州市·江陵县', null, 'J', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421081', '石首市', '湖北省·荆州市·石首市', null, 'S', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421083', '洪湖市', '湖北省·荆州市·洪湖市', null, 'H', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421087', '松滋市', '湖北省·荆州市·松滋市', null, 'S', null, null, null, '421000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421100', '黄冈市', '湖北省·黄冈市', null, 'H', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421102', '黄州区', '湖北省·黄冈市·黄州区', null, 'H', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421121', '团风县', '湖北省·黄冈市·团风县', null, 'T', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421122', '红安县', '湖北省·黄冈市·红安县', null, 'H', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421123', '罗田县', '湖北省·黄冈市·罗田县', null, 'L', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421124', '英山县', '湖北省·黄冈市·英山县', null, 'Y', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421125', '浠水县', '湖北省·黄冈市·浠水县', null, 'X', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421126', '蕲春县', '湖北省·黄冈市·蕲春县', null, 'Q', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421127', '黄梅县', '湖北省·黄冈市·黄梅县', null, 'H', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421181', '麻城市', '湖北省·黄冈市·麻城市', null, 'M', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421182', '武穴市', '湖北省·黄冈市·武穴市', null, 'W', null, null, null, '421100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421200', '咸宁市', '湖北省·咸宁市', null, 'X', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421202', '咸安区', '湖北省·咸宁市·咸安区', null, 'X', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421221', '嘉鱼县', '湖北省·咸宁市·嘉鱼县', null, 'J', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421222', '通城县', '湖北省·咸宁市·通城县', null, 'T', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421223', '崇阳县', '湖北省·咸宁市·崇阳县', null, 'C', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421224', '通山县', '湖北省·咸宁市·通山县', null, 'T', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421281', '赤壁市', '湖北省·咸宁市·赤壁市', null, 'C', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421282', '温泉城区', '湖北省·咸宁市·温泉城区', null, 'W', null, null, null, '421200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421300', '随州市', '湖北省·随州市', null, 'S', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421302', '曾都区', '湖北省·随州市·曾都区', null, 'C', null, null, null, '421300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421321', '随县', '湖北省·随州市·随县', null, 'S', null, null, null, '421300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('421381', '广水市', '湖北省·随州市·广水市', null, 'G', null, null, null, '421300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422800', '恩施土家族苗族自治州', '湖北省·恩施土家族苗族自治州', null, 'E', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422801', '恩施市', '湖北省·恩施土家族苗族自治州·恩施市', null, 'E', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422802', '利川市', '湖北省·恩施土家族苗族自治州·利川市', null, 'L', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422822', '建始县', '湖北省·恩施土家族苗族自治州·建始县', null, 'J', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422823', '巴东县', '湖北省·恩施土家族苗族自治州·巴东县', null, 'B', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422825', '宣恩县', '湖北省·恩施土家族苗族自治州·宣恩县', null, 'X', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422826', '咸丰县', '湖北省·恩施土家族苗族自治州·咸丰县', null, 'X', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422827', '来凤县', '湖北省·恩施土家族苗族自治州·来凤县', null, 'L', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('422828', '鹤峰县', '湖北省·恩施土家族苗族自治州·鹤峰县', null, 'H', null, null, null, '422800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('429004', '仙桃市', '湖北省·仙桃市', null, 'X', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('429005', '潜江市', '湖北省·潜江市', null, 'Q', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('429006', '天门市', '湖北省·天门市', null, 'T', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('429021', '神农架林区', '湖北省·神农架林区', null, 'S', null, null, null, '420000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430000', '湖南省', '湖南省', null, 'H', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430100', '长沙市', '湖南省·长沙市', null, 'Z', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430102', '芙蓉区', '湖南省·长沙市·芙蓉区', null, 'F', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430103', '天心区', '湖南省·长沙市·天心区', null, 'T', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430104', '岳麓区', '湖南省·长沙市·岳麓区', null, 'Y', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430105', '开福区', '湖南省·长沙市·开福区', null, 'K', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430111', '雨花区', '湖南省·长沙市·雨花区', null, 'Y', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430121', '长沙县', '湖南省·长沙市·长沙县', null, 'Z', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430122', '望城县', '湖南省·长沙市·望城县', null, 'W', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430124', '宁乡县', '湖南省·长沙市·宁乡县', null, 'N', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430181', '浏阳市', '湖南省·长沙市·浏阳市', null, 'L', null, null, null, '430100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430200', '株洲市', '湖南省·株洲市', null, 'Z', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430202', '荷塘区', '湖南省·株洲市·荷塘区', null, 'H', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430203', '芦淞区', '湖南省·株洲市·芦淞区', null, 'L', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430204', '石峰区', '湖南省·株洲市·石峰区', null, 'S', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430211', '天元区', '湖南省·株洲市·天元区', null, 'T', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430221', '株洲县', '湖南省·株洲市·株洲县', null, 'Z', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430223', '攸县', '湖南省·株洲市·攸县', null, 'Y', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430224', '茶陵县', '湖南省·株洲市·茶陵县', null, 'C', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430225', '炎陵县', '湖南省·株洲市·炎陵县', null, 'Y', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430281', '醴陵市', '湖南省·株洲市·醴陵市', null, 'L', null, null, null, '430200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430300', '湘潭市', '湖南省·湘潭市', null, 'X', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430302', '雨湖区', '湖南省·湘潭市·雨湖区', null, 'Y', null, null, null, '430300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430304', '岳塘区', '湖南省·湘潭市·岳塘区', null, 'Y', null, null, null, '430300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430321', '湘潭县', '湖南省·湘潭市·湘潭县', null, 'X', null, null, null, '430300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430381', '湘乡市', '湖南省·湘潭市·湘乡市', null, 'X', null, null, null, '430300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430382', '韶山市', '湖南省·湘潭市·韶山市', null, 'S', null, null, null, '430300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430400', '衡阳市', '湖南省·衡阳市', null, 'H', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430405', '珠晖区', '湖南省·衡阳市·珠晖区', null, 'Z', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430406', '雁峰区', '湖南省·衡阳市·雁峰区', null, 'Y', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430407', '石鼓区', '湖南省·衡阳市·石鼓区', null, 'S', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430408', '蒸湘区', '湖南省·衡阳市·蒸湘区', null, 'Z', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430412', '南岳区', '湖南省·衡阳市·南岳区', null, 'N', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430421', '衡阳县', '湖南省·衡阳市·衡阳县', null, 'H', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430422', '衡南县', '湖南省·衡阳市·衡南县', null, 'H', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430423', '衡山县', '湖南省·衡阳市·衡山县', null, 'H', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430424', '衡东县', '湖南省·衡阳市·衡东县', null, 'H', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430426', '祁东县', '湖南省·衡阳市·祁东县', null, 'Q', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430481', '耒阳市', '湖南省·衡阳市·耒阳市', null, 'L', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430482', '常宁市', '湖南省·衡阳市·常宁市', null, 'C', null, null, null, '430400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430500', '邵阳市', '湖南省·邵阳市', null, 'S', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430502', '双清区', '湖南省·邵阳市·双清区', null, 'S', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430503', '大祥区', '湖南省·邵阳市·大祥区', null, 'D', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430511', '北塔区', '湖南省·邵阳市·北塔区', null, 'B', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430521', '邵东县', '湖南省·邵阳市·邵东县', null, 'S', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430522', '新邵县', '湖南省·邵阳市·新邵县', null, 'X', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430523', '邵阳县', '湖南省·邵阳市·邵阳县', null, 'S', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430524', '隆回县', '湖南省·邵阳市·隆回县', null, 'L', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430525', '洞口县', '湖南省·邵阳市·洞口县', null, 'D', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430527', '绥宁县', '湖南省·邵阳市·绥宁县', null, 'S', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430528', '新宁县', '湖南省·邵阳市·新宁县', null, 'X', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430529', '城步苗族自治县', '湖南省·邵阳市·城步苗族自治县', null, 'C', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430581', '武冈市', '湖南省·邵阳市·武冈市', null, 'W', null, null, null, '430500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430600', '岳阳市', '湖南省·岳阳市', null, 'Y', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430602', '岳阳楼区', '湖南省·岳阳市·岳阳楼区', null, 'Y', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430603', '云溪区', '湖南省·岳阳市·云溪区', null, 'Y', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430611', '君山区', '湖南省·岳阳市·君山区', null, 'J', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430621', '岳阳县', '湖南省·岳阳市·岳阳县', null, 'Y', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430623', '华容县', '湖南省·岳阳市·华容县', null, 'H', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430624', '湘阴县', '湖南省·岳阳市·湘阴县', null, 'X', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430626', '平江县', '湖南省·岳阳市·平江县', null, 'P', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430681', '汨罗市', '湖南省·岳阳市·汨罗市', null, 'M', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430682', '临湘市', '湖南省·岳阳市·临湘市', null, 'L', null, null, null, '430600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430700', '常德市', '湖南省·常德市', null, 'C', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430702', '武陵区', '湖南省·常德市·武陵区', null, 'W', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430703', '鼎城区', '湖南省·常德市·鼎城区', null, 'D', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430721', '安乡县', '湖南省·常德市·安乡县', null, 'A', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430722', '汉寿县', '湖南省·常德市·汉寿县', null, 'H', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430723', '澧县', '湖南省·常德市·澧县', null, 'L', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430724', '临澧县', '湖南省·常德市·临澧县', null, 'L', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430725', '桃源县', '湖南省·常德市·桃源县', null, 'T', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430726', '石门县', '湖南省·常德市·石门县', null, 'S', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430781', '津市市', '湖南省·常德市·津市市', null, 'J', null, null, null, '430700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430800', '张家界市', '湖南省·张家界市', null, 'Z', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430802', '永定区', '湖南省·张家界市·永定区', null, 'Y', null, null, null, '430800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430811', '武陵源区', '湖南省·张家界市·武陵源区', null, 'W', null, null, null, '430800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430821', '慈利县', '湖南省·张家界市·慈利县', null, 'C', null, null, null, '430800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430822', '桑植县', '湖南省·张家界市·桑植县', null, 'S', null, null, null, '430800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430900', '益阳市', '湖南省·益阳市', null, 'Y', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430902', '资阳区', '湖南省·益阳市·资阳区', null, 'Z', null, null, null, '430900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430903', '赫山区', '湖南省·益阳市·赫山区', null, 'H', null, null, null, '430900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430921', '南县', '湖南省·益阳市·南县', null, 'N', null, null, null, '430900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430922', '桃江县', '湖南省·益阳市·桃江县', null, 'T', null, null, null, '430900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430923', '安化县', '湖南省·益阳市·安化县', null, 'A', null, null, null, '430900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('430981', '沅江市', '湖南省·益阳市·沅江市', null, 'Y', null, null, null, '430900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431000', '郴州市', '湖南省·郴州市', null, 'C', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431002', '北湖区', '湖南省·郴州市·北湖区', null, 'B', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431003', '苏仙区', '湖南省·郴州市·苏仙区', null, 'S', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431021', '桂阳县', '湖南省·郴州市·桂阳县', null, 'G', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431022', '宜章县', '湖南省·郴州市·宜章县', null, 'Y', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431023', '永兴县', '湖南省·郴州市·永兴县', null, 'Y', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431024', '嘉禾县', '湖南省·郴州市·嘉禾县', null, 'J', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431025', '临武县', '湖南省·郴州市·临武县', null, 'L', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431026', '汝城县', '湖南省·郴州市·汝城县', null, 'R', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431027', '桂东县', '湖南省·郴州市·桂东县', null, 'G', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431028', '安仁县', '湖南省·郴州市·安仁县', null, 'A', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431081', '资兴市', '湖南省·郴州市·资兴市', null, 'Z', null, null, null, '431000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431100', '永州市', '湖南省·永州市', null, 'Y', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431102', '零陵区', '湖南省·永州市·零陵区', null, 'L', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431103', '冷水滩区', '湖南省·永州市·冷水滩区', null, 'L', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431121', '祁阳县', '湖南省·永州市·祁阳县', null, 'Q', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431122', '东安县', '湖南省·永州市·东安县', null, 'D', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431123', '双牌县', '湖南省·永州市·双牌县', null, 'S', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431124', '道县', '湖南省·永州市·道县', null, 'D', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431125', '江永县', '湖南省·永州市·江永县', null, 'J', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431126', '宁远县', '湖南省·永州市·宁远县', null, 'N', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431127', '蓝山县', '湖南省·永州市·蓝山县', null, 'L', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431128', '新田县', '湖南省·永州市·新田县', null, 'X', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431129', '江华瑶族自治县', '湖南省·永州市·江华瑶族自治县', null, 'J', null, null, null, '431100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431200', '怀化市', '湖南省·怀化市', null, 'H', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431202', '鹤城区', '湖南省·怀化市·鹤城区', null, 'H', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431221', '中方县', '湖南省·怀化市·中方县', null, 'Z', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431222', '沅陵县', '湖南省·怀化市·沅陵县', null, 'Y', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431223', '辰溪县', '湖南省·怀化市·辰溪县', null, 'C', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431224', '溆浦县', '湖南省·怀化市·溆浦县', null, 'X', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431225', '会同县', '湖南省·怀化市·会同县', null, 'H', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431226', '麻阳苗族自治县', '湖南省·怀化市·麻阳苗族自治县', null, 'M', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431227', '新晃侗族自治县', '湖南省·怀化市·新晃侗族自治县', null, 'X', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431228', '芷江侗族自治县', '湖南省·怀化市·芷江侗族自治县', null, 'Z', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431229', '靖州苗族侗族自治县', '湖南省·怀化市·靖州苗族侗族自治县', null, 'J', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431230', '通道侗族自治县', '湖南省·怀化市·通道侗族自治县', null, 'T', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431281', '洪江市', '湖南省·怀化市·洪江市', null, 'H', null, null, null, '431200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431300', '娄底市', '湖南省·娄底市', null, 'L', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431302', '娄星区', '湖南省·娄底市·娄星区', null, 'L', null, null, null, '431300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431321', '双峰县', '湖南省·娄底市·双峰县', null, 'S', null, null, null, '431300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431322', '新化县', '湖南省·娄底市·新化县', null, 'X', null, null, null, '431300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431381', '冷水江市', '湖南省·娄底市·冷水江市', null, 'L', null, null, null, '431300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431382', '涟源市', '湖南省·娄底市·涟源市', null, 'L', null, null, null, '431300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433100', '湘西土家族苗族自治州', '湖南省·湘西土家族苗族自治州', null, 'X', null, null, null, '430000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433101', '吉首市', '湖南省·湘西土家族苗族自治州·吉首市', null, 'J', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433122', '泸溪县', '湖南省·湘西土家族苗族自治州·泸溪县', null, 'L', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433123', '凤凰县', '湖南省·湘西土家族苗族自治州·凤凰县', null, 'F', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433124', '花垣县', '湖南省·湘西土家族苗族自治州·花垣县', null, 'H', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433125', '保靖县', '湖南省·湘西土家族苗族自治州·保靖县', null, 'B', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433126', '古丈县', '湖南省·湘西土家族苗族自治州·古丈县', null, 'G', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433127', '永顺县', '湖南省·湘西土家族苗族自治州·永顺县', null, 'Y', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('433130', '龙山县', '湖南省·湘西土家族苗族自治州·龙山县', null, 'L', null, null, null, '433100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440000', '广东省', '广东省', null, 'G', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440100', '广州市', '广东省·广州市', null, 'G', null, null, null, '440000', '2', '', '1467599163', '1467599163', '1');
INSERT INTO `pad_city_info` VALUES ('440103', '荔湾区', '广东省·广州市·荔湾区', null, 'L', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440104', '越秀区', '广东省·广州市·越秀区', null, 'Y', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440105', '海珠区', '广东省·广州市·海珠区', null, 'H', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440106', '天河区', '广东省·广州市·天河区', null, 'T', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440111', '白云区', '广东省·广州市·白云区', null, 'B', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440112', '黄埔区', '广东省·广州市·黄埔区', null, 'H', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440113', '番禺区', '广东省·广州市·番禺区', null, 'F', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440114', '花都区', '广东省·广州市·花都区', null, 'H', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440115', '南沙区', '广东省·广州市·南沙区', null, 'N', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440116', '萝岗区', '广东省·广州市·萝岗区', null, 'L', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440183', '增城市', '广东省·广州市·增城市', null, 'Z', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440184', '从化市', '广东省·广州市·从化市', null, 'C', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440188', '东山区', '广东省·广州市·东山区', null, 'D', null, null, null, '440100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440200', '韶关市', '广东省·韶关市', null, 'S', null, null, null, '440000', '2', '广东开通韶关市', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440203', '武江区', '广东省·韶关市·武江区', null, 'W', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440204', '浈江区', '广东省·韶关市·浈江区', null, 'Z', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440205', '曲江区', '广东省·韶关市·曲江区', null, 'Q', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440222', '始兴县', '广东省·韶关市·始兴县', null, 'S', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440224', '仁化县', '广东省·韶关市·仁化县', null, 'R', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440229', '翁源县', '广东省·韶关市·翁源县', null, 'W', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440232', '乳源瑶族自治县', '广东省·韶关市·乳源瑶族自治县', null, 'R', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440233', '新丰县', '广东省·韶关市·新丰县', null, 'X', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440281', '乐昌市', '广东省·韶关市·乐昌市', null, 'L', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440282', '南雄市', '广东省·韶关市·南雄市', null, 'N', null, null, null, '440200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440300', '深圳市', '广东省·深圳市', null, 'S', null, null, null, '440000', '2', '', '1469427102', '1469427102', '1');
INSERT INTO `pad_city_info` VALUES ('440303', '罗湖区', '广东省·深圳市·罗湖区', null, 'L', null, null, null, '440300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440304', '福田区', '广东省·深圳市·福田区', null, 'F', null, null, null, '440300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440305', '南山区', '广东省·深圳市·南山区', null, 'N', null, null, null, '440300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440306', '宝安区', '广东省·深圳市·宝安区', null, 'B', null, null, null, '440300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440307', '龙岗区', '广东省·深圳市·龙岗区', null, 'L', null, null, null, '440300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440308', '盐田区', '广东省·深圳市·盐田区', null, 'Y', null, null, null, '440300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440310', '前海区', null, null, null, null, null, null, '440300', '3', null, '1468291102', '1468291102', '99');
INSERT INTO `pad_city_info` VALUES ('440311', '蛇口区', null, null, null, null, null, null, '440300', '3', null, '1468303968', '1468303968', '99');
INSERT INTO `pad_city_info` VALUES ('440312', '大鹏新区', null, null, null, null, null, null, '440300', '3', null, '1468303992', '1468303992', '1');
INSERT INTO `pad_city_info` VALUES ('440313', '龙华区', null, null, null, null, null, null, '440300', '3', null, '1469599453', '1469599453', '99');
INSERT INTO `pad_city_info` VALUES ('440314', '龙华新区', null, null, null, null, null, null, '440300', '3', null, '1469599596', '1469599596', '1');
INSERT INTO `pad_city_info` VALUES ('440315', '光明新区', null, null, null, null, null, null, '440300', '3', null, '1469600675', '1469600675', '1');
INSERT INTO `pad_city_info` VALUES ('440316', '平山新区', null, null, null, null, null, null, '440300', '3', null, '1469600682', '1469600682', '1');
INSERT INTO `pad_city_info` VALUES ('440400', '珠海市', '广东省·珠海市', null, 'Z', null, null, null, '440000', '2', '', '1467599172', '1467599172', '1');
INSERT INTO `pad_city_info` VALUES ('440402', '香洲区', '广东省·珠海市·香洲区', null, 'X', null, null, null, '440400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440403', '斗门区', '广东省·珠海市·斗门区', null, 'D', null, null, null, '440400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440404', '金湾区', '广东省·珠海市·金湾区', null, 'J', null, null, null, '440400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440486', '金唐区', '广东省·珠海市·金唐区', null, 'J', null, null, null, '440400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440487', '南湾区', '广东省·珠海市·南湾区', null, 'N', null, null, null, '440400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440500', '汕头市', '广东省·汕头市', null, 'S', null, null, null, '440000', '2', '666666', '1468307119', '1468307119', '1');
INSERT INTO `pad_city_info` VALUES ('440507', '龙湖区', '广东省·汕头市·龙湖区', null, 'L', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440511', '金平区', '广东省·汕头市·金平区', null, 'J', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440512', '濠江区', '广东省·汕头市·濠江区', null, 'H', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440513', '潮阳区', '广东省·汕头市·潮阳区', null, 'C', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440514', '潮南区', '广东省·汕头市·潮南区', null, 'C', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440515', '澄海区', '广东省·汕头市·澄海区', null, 'C', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440523', '南澳县', '广东省·汕头市·南澳县', null, 'N', null, null, null, '440500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440600', '佛山市', '广东省·佛山市', null, 'S', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440604', '禅城区', '广东省·佛山市·禅城区', null, 'C', null, null, null, '440600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440605', '南海区', '广东省·佛山市·南海区', null, 'N', null, null, null, '440600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440606', '顺德区', '广东省·佛山市·顺德区', null, 'S', null, null, null, '440600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440607', '三水区', '广东省·佛山市·三水区', null, 'S', null, null, null, '440600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440608', '高明区', '广东省·佛山市·高明区', null, 'G', null, null, null, '440600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440700', '江门市', '广东省·江门市', null, 'J', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440703', '蓬江区', '广东省·江门市·蓬江区', null, 'P', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440704', '江海区', '广东省·江门市·江海区', null, 'J', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440705', '新会区', '广东省·江门市·新会区', null, 'X', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440781', '台山市', '广东省·江门市·台山市', null, 'T', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440783', '开平市', '广东省·江门市·开平市', null, 'K', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440784', '鹤山市', '广东省·江门市·鹤山市', null, 'H', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440785', '恩平市', '广东省·江门市·恩平市', null, 'E', null, null, null, '440700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440800', '湛江市', '广东省·湛江市', null, 'Z', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440802', '赤坎区', '广东省·湛江市·赤坎区', null, 'C', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440803', '霞山区', '广东省·湛江市·霞山区', null, 'X', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440804', '坡头区', '广东省·湛江市·坡头区', null, 'P', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440811', '麻章区', '广东省·湛江市·麻章区', null, 'M', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440823', '遂溪县', '广东省·湛江市·遂溪县', null, 'S', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440825', '徐闻县', '广东省·湛江市·徐闻县', null, 'X', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440881', '廉江市', '广东省·湛江市·廉江市', null, 'L', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440882', '雷州市', '广东省·湛江市·雷州市', null, 'L', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440883', '吴川市', '广东省·湛江市·吴川市', null, 'W', null, null, null, '440800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440900', '茂名市', '广东省·茂名市', null, 'M', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440902', '茂南区', '广东省·茂名市·茂南区', null, 'M', null, null, null, '440900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440903', '茂港区', '广东省·茂名市·茂港区', null, 'M', null, null, null, '440900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440923', '电白县', '广东省·茂名市·电白县', null, 'D', null, null, null, '440900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440981', '高州市', '广东省·茂名市·高州市', null, 'G', null, null, null, '440900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440982', '化州市', '广东省·茂名市·化州市', null, 'H', null, null, null, '440900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440983', '信宜市', '广东省·茂名市·信宜市', null, 'X', null, null, null, '440900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441200', '肇庆市', '广东省·肇庆市', null, 'Z', null, null, null, '440000', '2', '', '1468405059', '1468405059', '1');
INSERT INTO `pad_city_info` VALUES ('441202', '端州区', '广东省·肇庆市·端州区', null, 'D', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441203', '鼎湖区', '广东省·肇庆市·鼎湖区', null, 'D', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441223', '广宁县', '广东省·肇庆市·广宁县', null, 'G', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441224', '怀集县', '广东省·肇庆市·怀集县', null, 'H', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441225', '封开县', '广东省·肇庆市·封开县', null, 'F', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441226', '德庆县', '广东省·肇庆市·德庆县', null, 'D', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441283', '高要市', '广东省·肇庆市·高要市', null, 'G', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441284', '四会市', '广东省·肇庆市·四会市', null, 'S', null, null, null, '441200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441300', '惠州市', '广东省·惠州市', null, 'H', null, null, null, '440000', '2', '', '1468201559', '1468201559', '1');
INSERT INTO `pad_city_info` VALUES ('441302', '惠城区', '广东省·惠州市·惠城区', null, 'H', null, null, null, '441300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441303', '惠阳区', '广东省·惠州市·惠阳区', null, 'H', null, null, null, '441300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441322', '博罗县', '广东省·惠州市·博罗县', null, 'B', null, null, null, '441300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441323', '惠东县', '广东省·惠州市·惠东县', null, 'H', null, null, null, '441300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441324', '龙门县', '广东省·惠州市·龙门县', null, 'L', null, null, null, '441300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441326', 'hh', null, null, null, null, null, null, '441300', '3', null, '1468201556', '1468201556', '1');
INSERT INTO `pad_city_info` VALUES ('441400', '梅州市', '广东省·梅州市', null, 'M', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441402', '梅江区', '广东省·梅州市·梅江区', null, 'M', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441421', '梅县', '广东省·梅州市·梅县', null, 'M', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441422', '大埔县', '广东省·梅州市·大埔县', null, 'D', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441423', '丰顺县', '广东省·梅州市·丰顺县', null, 'F', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441424', '五华县', '广东省·梅州市·五华县', null, 'W', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441426', '平远县', '广东省·梅州市·平远县', null, 'P', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441427', '蕉岭县', '广东省·梅州市·蕉岭县', null, 'J', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441481', '兴宁市', '广东省·梅州市·兴宁市', null, 'X', null, null, null, '441400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441500', '汕尾市', '广东省·汕尾市', null, 'S', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441502', '城区', '广东省·汕尾市·城区', null, 'C', null, null, null, '441500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441521', '海丰县', '广东省·汕尾市·海丰县', null, 'H', null, null, null, '441500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441523', '陆河县', '广东省·汕尾市·陆河县', null, 'L', null, null, null, '441500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441581', '陆丰市', '广东省·汕尾市·陆丰市', null, 'L', null, null, null, '441500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441600', '河源市', '广东省·河源市', null, 'H', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441602', '源城区', '广东省·河源市·源城区', null, 'Y', null, null, null, '441600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441621', '紫金县', '广东省·河源市·紫金县', null, 'Z', null, null, null, '441600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441622', '龙川县', '广东省·河源市·龙川县', null, 'L', null, null, null, '441600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441623', '连平县', '广东省·河源市·连平县', null, 'L', null, null, null, '441600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441624', '和平县', '广东省·河源市·和平县', null, 'H', null, null, null, '441600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441625', '东源县', '广东省·河源市·东源县', null, 'D', null, null, null, '441600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441700', '阳江市', '广东省·阳江市', null, 'Y', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441702', '江城区', '广东省·阳江市·江城区', null, 'J', null, null, null, '441700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441721', '阳西县', '广东省·阳江市·阳西县', null, 'Y', null, null, null, '441700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441723', '阳东县', '广东省·阳江市·阳东县', null, 'Y', null, null, null, '441700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441781', '阳春市', '广东省·阳江市·阳春市', null, 'Y', null, null, null, '441700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441800', '清远市', '广东省·清远市', null, 'Q', null, null, null, '440000', '2', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441802', '清城区', '广东省·清远市·清城区', null, 'Q', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441821', '佛冈县', '广东省·清远市·佛冈县', null, 'G', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441823', '阳山县', '广东省·清远市·阳山县', null, 'Y', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441825', '连山壮族瑶族自治县', '广东省·清远市·连山壮族瑶族自治县', null, 'L', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441826', '连南瑶族自治县', '广东省·清远市·连南瑶族自治县', null, 'L', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441827', '清新县', '广东省·清远市·清新县', null, 'Q', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441881', '英德市', '广东省·清远市·英德市', null, 'Y', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441882', '连州市', '广东省·清远市·连州市', null, 'L', null, null, null, '441800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('441900', '东莞市', '广东省·东莞市', null, 'D', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('442000', '中山市', '广东省·中山市', null, 'Z', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445100', '潮州市', '广东省·潮州市', null, 'C', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445102', '湘桥区', '广东省·潮州市·湘桥区', null, 'X', null, null, null, '445100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445121', '潮安县', '广东省·潮州市·潮安县', null, 'C', null, null, null, '445100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445122', '饶平县', '广东省·潮州市·饶平县', null, 'R', null, null, null, '445100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445185', '枫溪区', '广东省·潮州市·枫溪区', null, 'F', null, null, null, '445100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445200', '揭阳市', '广东省·揭阳市', null, 'J', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445202', '榕城区', '广东省·揭阳市·榕城区', null, 'R', null, null, null, '445200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445221', '揭东县', '广东省·揭阳市·揭东县', null, 'J', null, null, null, '445200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445222', '揭西县', '广东省·揭阳市·揭西县', null, 'J', null, null, null, '445200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445224', '惠来县', '广东省·揭阳市·惠来县', null, 'H', null, null, null, '445200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445281', '普宁市', '广东省·揭阳市·普宁市', null, 'P', null, null, null, '445200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445284', '东山区', '广东省·揭阳市·东山区', null, 'D', null, null, null, '445200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445300', '云浮市', '广东省·云浮市', null, 'Y', null, null, null, '440000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445302', '云城区', '广东省·云浮市·云城区', null, 'Y', null, null, null, '445300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445321', '新兴县', '广东省·云浮市·新兴县', null, 'X', null, null, null, '445300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445322', '郁南县', '广东省·云浮市·郁南县', null, 'Y', null, null, null, '445300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445323', '云安县', '广东省·云浮市·云安县', null, 'Y', null, null, null, '445300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('445381', '罗定市', '广东省·云浮市·罗定市', null, 'L', null, null, null, '445300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450000', '广西壮族自治区', '广西壮族自治区', null, 'G', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450100', '南宁市', '广西壮族自治区·南宁市', null, 'N', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450102', '兴宁区', '广西壮族自治区·南宁市·兴宁区', null, 'X', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450103', '青秀区', '广西壮族自治区·南宁市·青秀区', null, 'Q', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450105', '江南区', '广西壮族自治区·南宁市·江南区', null, 'J', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450107', '西乡塘区', '广西壮族自治区·南宁市·西乡塘区', null, 'X', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450108', '良庆区', '广西壮族自治区·南宁市·良庆区', null, 'L', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450109', '邕宁区', '广西壮族自治区·南宁市·邕宁区', null, 'Y', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450122', '武鸣县', '广西壮族自治区·南宁市·武鸣县', null, 'W', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450123', '隆安县', '广西壮族自治区·南宁市·隆安县', null, 'L', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450124', '马山县', '广西壮族自治区·南宁市·马山县', null, 'M', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450125', '上林县', '广西壮族自治区·南宁市·上林县', null, 'S', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450126', '宾阳县', '广西壮族自治区·南宁市·宾阳县', null, 'B', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450127', '横县', '广西壮族自治区·南宁市·横县', null, 'H', null, null, null, '450100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450200', '柳州市', '广西壮族自治区·柳州市', null, 'L', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450202', '城中区', '广西壮族自治区·柳州市·城中区', null, 'C', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450203', '鱼峰区', '广西壮族自治区·柳州市·鱼峰区', null, 'Y', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450204', '柳南区', '广西壮族自治区·柳州市·柳南区', null, 'L', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450205', '柳北区', '广西壮族自治区·柳州市·柳北区', null, 'L', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450221', '柳江县', '广西壮族自治区·柳州市·柳江县', null, 'L', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450222', '柳城县', '广西壮族自治区·柳州市·柳城县', null, 'L', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450223', '鹿寨县', '广西壮族自治区·柳州市·鹿寨县', null, 'L', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450224', '融安县', '广西壮族自治区·柳州市·融安县', null, 'R', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450225', '融水苗族自治县', '广西壮族自治区·柳州市·融水苗族自治县', null, 'R', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450226', '三江侗族自治县', '广西壮族自治区·柳州市·三江侗族自治县', null, 'S', null, null, null, '450200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450300', '桂林市', '广西壮族自治区·桂林市', null, 'G', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450302', '秀峰区', '广西壮族自治区·桂林市·秀峰区', null, 'X', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450303', '叠彩区', '广西壮族自治区·桂林市·叠彩区', null, 'D', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450304', '象山区', '广西壮族自治区·桂林市·象山区', null, 'X', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450305', '七星区', '广西壮族自治区·桂林市·七星区', null, 'Q', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450311', '雁山区', '广西壮族自治区·桂林市·雁山区', null, 'Y', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450321', '阳朔县', '广西壮族自治区·桂林市·阳朔县', null, 'Y', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450322', '临桂县', '广西壮族自治区·桂林市·临桂县', null, 'L', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450323', '灵川县', '广西壮族自治区·桂林市·灵川县', null, 'L', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450324', '全州县', '广西壮族自治区·桂林市·全州县', null, 'Q', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450325', '兴安县', '广西壮族自治区·桂林市·兴安县', null, 'X', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450326', '永福县', '广西壮族自治区·桂林市·永福县', null, 'Y', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450327', '灌阳县', '广西壮族自治区·桂林市·灌阳县', null, 'G', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450328', '龙胜各族自治县', '广西壮族自治区·桂林市·龙胜各族自治县', null, 'L', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450329', '资源县', '广西壮族自治区·桂林市·资源县', null, 'Z', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450330', '平乐县', '广西壮族自治区·桂林市·平乐县', null, 'P', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450331', '荔浦县', '广西壮族自治区·桂林市·荔浦县', null, 'L', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450332', '恭城瑶族自治县', '广西壮族自治区·桂林市·恭城瑶族自治县', null, 'G', null, null, null, '450300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450400', '梧州市', '广西壮族自治区·梧州市', null, 'W', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450403', '万秀区', '广西壮族自治区·梧州市·万秀区', null, 'W', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450404', '蝶山区', '广西壮族自治区·梧州市·蝶山区', null, 'D', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450405', '长洲区', '广西壮族自治区·梧州市·长洲区', null, 'Z', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450421', '苍梧县', '广西壮族自治区·梧州市·苍梧县', null, 'C', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450422', '藤县', '广西壮族自治区·梧州市·藤县', null, 'T', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450423', '蒙山县', '广西壮族自治区·梧州市·蒙山县', null, 'M', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450481', '岑溪市', '广西壮族自治区·梧州市·岑溪市', null, 'C', null, null, null, '450400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450500', '北海市', '广西壮族自治区·北海市', null, 'B', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450502', '海城区', '广西壮族自治区·北海市·海城区', null, 'H', null, null, null, '450500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450503', '银海区', '广西壮族自治区·北海市·银海区', null, 'Y', null, null, null, '450500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450512', '铁山港区', '广西壮族自治区·北海市·铁山港区', null, 'T', null, null, null, '450500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450521', '合浦县', '广西壮族自治区·北海市·合浦县', null, 'H', null, null, null, '450500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450600', '防城港市', '广西壮族自治区·防城港市', null, 'F', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450602', '港口区', '广西壮族自治区·防城港市·港口区', null, 'G', null, null, null, '450600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450603', '防城区', '广西壮族自治区·防城港市·防城区', null, 'F', null, null, null, '450600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450621', '上思县', '广西壮族自治区·防城港市·上思县', null, 'S', null, null, null, '450600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450681', '东兴市', '广西壮族自治区·防城港市·东兴市', null, 'D', null, null, null, '450600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450700', '钦州市', '广西壮族自治区·钦州市', null, 'Q', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450702', '钦南区', '广西壮族自治区·钦州市·钦南区', null, 'Q', null, null, null, '450700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450703', '钦北区', '广西壮族自治区·钦州市·钦北区', null, 'Q', null, null, null, '450700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450721', '灵山县', '广西壮族自治区·钦州市·灵山县', null, 'L', null, null, null, '450700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450722', '浦北县', '广西壮族自治区·钦州市·浦北县', null, 'P', null, null, null, '450700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450800', '贵港市', '广西壮族自治区·贵港市', null, 'G', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450802', '港北区', '广西壮族自治区·贵港市·港北区', null, 'G', null, null, null, '450800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450803', '港南区', '广西壮族自治区·贵港市·港南区', null, 'G', null, null, null, '450800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450804', '覃塘区', '广西壮族自治区·贵港市·覃塘区', null, 'T', null, null, null, '450800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450821', '平南县', '广西壮族自治区·贵港市·平南县', null, 'P', null, null, null, '450800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450881', '桂平市', '广西壮族自治区·贵港市·桂平市', null, 'G', null, null, null, '450800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450900', '玉林市', '广西壮族自治区·玉林市', null, 'Y', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450902', '玉州区', '广西壮族自治区·玉林市·玉州区', null, 'Y', null, null, null, '450900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450921', '容县', '广西壮族自治区·玉林市·容县', null, 'R', null, null, null, '450900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450922', '陆川县', '广西壮族自治区·玉林市·陆川县', null, 'L', null, null, null, '450900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450923', '博白县', '广西壮族自治区·玉林市·博白县', null, 'B', null, null, null, '450900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450924', '兴业县', '广西壮族自治区·玉林市·兴业县', null, 'X', null, null, null, '450900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('450981', '北流市', '广西壮族自治区·玉林市·北流市', null, 'B', null, null, null, '450900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451000', '百色市', '广西壮族自治区·百色市', null, 'B', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451002', '右江区', '广西壮族自治区·百色市·右江区', null, 'Y', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451021', '田阳县', '广西壮族自治区·百色市·田阳县', null, 'T', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451022', '田东县', '广西壮族自治区·百色市·田东县', null, 'T', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451023', '平果县', '广西壮族自治区·百色市·平果县', null, 'P', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451024', '德保县', '广西壮族自治区·百色市·德保县', null, 'D', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451025', '靖西县', '广西壮族自治区·百色市·靖西县', null, 'J', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451026', '那坡县', '广西壮族自治区·百色市·那坡县', null, 'N', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451027', '凌云县', '广西壮族自治区·百色市·凌云县', null, 'L', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451028', '乐业县', '广西壮族自治区·百色市·乐业县', null, 'L', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451029', '田林县', '广西壮族自治区·百色市·田林县', null, 'T', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451030', '西林县', '广西壮族自治区·百色市·西林县', null, 'X', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451031', '隆林各族自治县', '广西壮族自治区·百色市·隆林各族自治县', null, 'L', null, null, null, '451000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451100', '贺州市', '广西壮族自治区·贺州市', null, 'H', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451102', '八步区', '广西壮族自治区·贺州市·八步区', null, 'B', null, null, null, '451100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451121', '昭平县', '广西壮族自治区·贺州市·昭平县', null, 'Z', null, null, null, '451100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451122', '钟山县', '广西壮族自治区·贺州市·钟山县', null, 'Z', null, null, null, '451100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451123', '富川瑶族自治县', '广西壮族自治区·贺州市·富川瑶族自治县', null, 'F', null, null, null, '451100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451200', '河池市', '广西壮族自治区·河池市', null, 'H', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451202', '金城江区', '广西壮族自治区·河池市·金城江区', null, 'J', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451221', '南丹县', '广西壮族自治区·河池市·南丹县', null, 'N', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451222', '天峨县', '广西壮族自治区·河池市·天峨县', null, 'T', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451223', '凤山县', '广西壮族自治区·河池市·凤山县', null, 'F', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451224', '东兰县', '广西壮族自治区·河池市·东兰县', null, 'D', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451225', '罗城仫佬族自治县', '广西壮族自治区·河池市·罗城仫佬族自治县', null, 'L', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451226', '环江毛南族自治县', '广西壮族自治区·河池市·环江毛南族自治县', null, 'H', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451227', '巴马瑶族自治县', '广西壮族自治区·河池市·巴马瑶族自治县', null, 'B', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451228', '都安瑶族自治县', '广西壮族自治区·河池市·都安瑶族自治县', null, 'D', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451229', '大化瑶族自治县', '广西壮族自治区·河池市·大化瑶族自治县', null, 'D', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451281', '宜州市', '广西壮族自治区·河池市·宜州市', null, 'Y', null, null, null, '451200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451300', '来宾市', '广西壮族自治区·来宾市', null, 'L', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451302', '兴宾区', '广西壮族自治区·来宾市·兴宾区', null, 'X', null, null, null, '451300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451321', '忻城县', '广西壮族自治区·来宾市·忻城县', null, 'X', null, null, null, '451300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451322', '象州县', '广西壮族自治区·来宾市·象州县', null, 'X', null, null, null, '451300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451323', '武宣县', '广西壮族自治区·来宾市·武宣县', null, 'W', null, null, null, '451300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451324', '金秀瑶族自治县', '广西壮族自治区·来宾市·金秀瑶族自治县', null, 'J', null, null, null, '451300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451381', '合山市', '广西壮族自治区·来宾市·合山市', null, 'H', null, null, null, '451300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451400', '崇左市', '广西壮族自治区·崇左市', null, 'C', null, null, null, '450000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451402', '江洲区', '广西壮族自治区·崇左市·江洲区', null, 'J', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451421', '扶绥县', '广西壮族自治区·崇左市·扶绥县', null, 'F', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451422', '宁明县', '广西壮族自治区·崇左市·宁明县', null, 'N', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451423', '龙州县', '广西壮族自治区·崇左市·龙州县', null, 'L', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451424', '大新县', '广西壮族自治区·崇左市·大新县', null, 'D', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451425', '天等县', '广西壮族自治区·崇左市·天等县', null, 'T', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('451481', '凭祥市', '广西壮族自治区·崇左市·凭祥市', null, 'P', null, null, null, '451400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460000', '海南省', '海南省', null, 'H', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460100', '海口市', '海南省·海口市', null, 'H', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460105', '秀英区', '海南省·海口市·秀英区', null, 'X', null, null, null, '460100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460106', '龙华区', '海南省·海口市·龙华区', null, 'L', null, null, null, '460100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460107', '琼山区', '海南省·海口市·琼山区', null, 'Q', null, null, null, '460100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460108', '美兰区', '海南省·海口市·美兰区', null, 'M', null, null, null, '460100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('460200', '三亚市', '海南省·三亚市', null, 'S', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469001', '五指山市', '海南省·五指山市', null, 'W', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469002', '琼海市', '海南省·琼海市', null, 'Q', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469003', '儋州市', '海南省·儋州市', null, 'D', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469005', '文昌市', '海南省·文昌市', null, 'W', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469006', '万宁市', '海南省·万宁市', null, 'W', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469007', '东方市', '海南省·东方市', null, 'D', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469025', '定安县', '海南省·定安县', null, 'D', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469026', '屯昌县', '海南省·屯昌县', null, 'T', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469027', '澄迈县', '海南省·澄迈县', null, 'C', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469028', '临高县', '海南省·临高县', null, 'L', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469030', '白沙黎族自治县', '海南省·白沙黎族自治县', null, 'B', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469031', '昌江黎族自治县', '海南省·昌江黎族自治县', null, 'C', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469033', '乐东黎族自治县', '海南省·乐东黎族自治县', null, 'L', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469034', '陵水黎族自治县', '海南省·陵水黎族自治县', null, 'L', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469035', '保亭黎族苗族自治县', '海南省·保亭黎族苗族自治县', null, 'B', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469036', '琼中黎族苗族自治县', '海南省·琼中黎族苗族自治县', null, 'Q', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469037', '西沙群岛', '海南省·西沙群岛', null, 'X', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469038', '南沙群岛', '海南省·南沙群岛', null, 'N', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('469039', '中沙群岛的岛礁及其海域', '海南省·中沙群岛的岛礁及其海域', null, 'Z', null, null, null, '460000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('471004', '高新区', '河南省·洛阳市·高新区', null, 'G', null, null, null, '410300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500000', '重庆', '重庆', null, 'Z', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500100', '重庆市', '重庆·重庆市', null, 'Z', null, null, null, '500000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500101', '万州区', '重庆·重庆市·万州区', null, 'W', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500102', '涪陵区', '重庆·重庆市·涪陵区', null, 'F', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500103', '渝中区', '重庆·重庆市·渝中区', null, 'Y', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500104', '大渡口区', '重庆·重庆市·大渡口区', null, 'D', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500105', '江北区', '重庆·重庆市·江北区', null, 'J', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500106', '沙坪坝区', '重庆·重庆市·沙坪坝区', null, 'S', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500107', '九龙坡区', '重庆·重庆市·九龙坡区', null, 'J', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500108', '南岸区', '重庆·重庆市·南岸区', null, 'N', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500109', '北碚区', '重庆·重庆市·北碚区', null, 'B', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500110', '万盛区', '重庆·重庆市·万盛区', null, 'W', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500111', '双桥区', '重庆·重庆市·双桥区', null, 'S', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500112', '渝北区', '重庆·重庆市·渝北区', null, 'Y', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500113', '巴南区', '重庆·重庆市·巴南区', null, 'B', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500114', '黔江区', '重庆·重庆市·黔江区', null, 'Q', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500115', '长寿区', '重庆·重庆市·长寿区', null, 'Z', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500222', '綦江县', '重庆·重庆市·綦江县', null, 'Q', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500223', '潼南县', '重庆·重庆市·潼南县', null, 'T', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500224', '铜梁县', '重庆·重庆市·铜梁县', null, 'T', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500225', '大足县', '重庆·重庆市·大足县', null, 'D', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500226', '荣昌县', '重庆·重庆市·荣昌县', null, 'R', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500227', '璧山县', '重庆·重庆市·璧山县', null, 'B', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500228', '梁平县', '重庆·重庆市·梁平县', null, 'L', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500229', '城口县', '重庆·重庆市·城口县', null, 'C', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500230', '丰都县', '重庆·重庆市·丰都县', null, 'F', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500231', '垫江县', '重庆·重庆市·垫江县', null, 'D', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500232', '武隆县', '重庆·重庆市·武隆县', null, 'W', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500233', '忠县', '重庆·重庆市·忠县', null, 'Z', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500234', '开县', '重庆·重庆市·开县', null, 'K', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500235', '云阳县', '重庆·重庆市·云阳县', null, 'Y', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500236', '奉节县', '重庆·重庆市·奉节县', null, 'F', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500237', '巫山县', '重庆·重庆市·巫山县', null, 'W', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500238', '巫溪县', '重庆·重庆市·巫溪县', null, 'W', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500240', '石柱土家族自治县', '重庆·重庆市·石柱土家族自治县', null, 'S', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500241', '秀山土家族苗族自治县', '重庆·重庆市·秀山土家族苗族自治县', null, 'X', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500242', '酉阳土家族苗族自治县', '重庆·重庆市·酉阳土家族苗族自治县', null, 'Y', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500243', '彭水苗族土家族自治县', '重庆·重庆市·彭水苗族土家族自治县', null, 'P', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500381', '江津区', '重庆·重庆市·江津区', null, 'J', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500382', '合川区', '重庆·重庆市·合川区', null, 'H', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500383', '永川区', '重庆·重庆市·永川区', null, 'Y', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('500384', '南川区', '重庆·重庆市·南川区', null, 'N', null, null, null, '500100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510000', '四川省', '四川省', null, 'S', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510100', '成都市', '四川省·成都市', null, 'C', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510104', '锦江区', '四川省·成都市·锦江区', null, 'J', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510105', '青羊区', '四川省·成都市·青羊区', null, 'Q', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510106', '金牛区', '四川省·成都市·金牛区', null, 'J', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510107', '武侯区', '四川省·成都市·武侯区', null, 'W', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510108', '成华区', '四川省·成都市·成华区', null, 'C', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510112', '龙泉驿区', '四川省·成都市·龙泉驿区', null, 'L', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510113', '青白江区', '四川省·成都市·青白江区', null, 'Q', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510114', '新都区', '四川省·成都市·新都区', null, 'X', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510115', '温江区', '四川省·成都市·温江区', null, 'W', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510121', '金堂县', '四川省·成都市·金堂县', null, 'J', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510122', '双流县', '四川省·成都市·双流县', null, 'S', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510124', '郫县', '四川省·成都市·郫县', null, 'P', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510129', '大邑县', '四川省·成都市·大邑县', null, 'D', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510131', '蒲江县', '四川省·成都市·蒲江县', null, 'P', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510132', '新津县', '四川省·成都市·新津县', null, 'X', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510181', '都江堰市', '四川省·成都市·都江堰市', null, 'D', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510182', '彭州市', '四川省·成都市·彭州市', null, 'P', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510183', '邛崃市', '四川省·成都市·邛崃市', null, 'Q', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510184', '崇州市', '四川省·成都市·崇州市', null, 'C', null, null, null, '510100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510300', '自贡市', '四川省·自贡市', null, 'Z', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510302', '自流井区', '四川省·自贡市·自流井区', null, 'Z', null, null, null, '510300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510303', '贡井区', '四川省·自贡市·贡井区', null, 'G', null, null, null, '510300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510304', '大安区', '四川省·自贡市·大安区', null, 'D', null, null, null, '510300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510311', '沿滩区', '四川省·自贡市·沿滩区', null, 'Y', null, null, null, '510300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510321', '荣县', '四川省·自贡市·荣县', null, 'R', null, null, null, '510300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510322', '富顺县', '四川省·自贡市·富顺县', null, 'F', null, null, null, '510300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510400', '攀枝花市', '四川省·攀枝花市', null, 'P', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510402', '东区', '四川省·攀枝花市·东区', null, 'D', null, null, null, '510400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510403', '西区', '四川省·攀枝花市·西区', null, 'X', null, null, null, '510400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510411', '仁和区', '四川省·攀枝花市·仁和区', null, 'R', null, null, null, '510400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510421', '米易县', '四川省·攀枝花市·米易县', null, 'M', null, null, null, '510400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510422', '盐边县', '四川省·攀枝花市·盐边县', null, 'Y', null, null, null, '510400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510500', '泸州市', '四川省·泸州市', null, 'L', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510502', '江阳区', '四川省·泸州市·江阳区', null, 'J', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510503', '纳溪区', '四川省·泸州市·纳溪区', null, 'N', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510504', '龙马潭区', '四川省·泸州市·龙马潭区', null, 'L', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510521', '泸县', '四川省·泸州市·泸县', null, 'L', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510522', '合江县', '四川省·泸州市·合江县', null, 'H', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510524', '叙永县', '四川省·泸州市·叙永县', null, 'X', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510525', '古蔺县', '四川省·泸州市·古蔺县', null, 'G', null, null, null, '510500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510600', '德阳市', '四川省·德阳市', null, 'D', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510603', '旌阳区', '四川省·德阳市·旌阳区', null, 'J', null, null, null, '510600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510623', '中江县', '四川省·德阳市·中江县', null, 'Z', null, null, null, '510600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510626', '罗江县', '四川省·德阳市·罗江县', null, 'L', null, null, null, '510600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510681', '广汉市', '四川省·德阳市·广汉市', null, 'G', null, null, null, '510600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510682', '什邡市', '四川省·德阳市·什邡市', null, 'S', null, null, null, '510600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510683', '绵竹市', '四川省·德阳市·绵竹市', null, 'M', null, null, null, '510600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510700', '绵阳市', '四川省·绵阳市', null, 'M', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510703', '涪城区', '四川省·绵阳市·涪城区', null, 'F', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510704', '游仙区', '四川省·绵阳市·游仙区', null, 'Y', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510722', '三台县', '四川省·绵阳市·三台县', null, 'S', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510723', '盐亭县', '四川省·绵阳市·盐亭县', null, 'Y', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510724', '安县', '四川省·绵阳市·安县', null, 'A', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510725', '梓潼县', '四川省·绵阳市·梓潼县', null, 'Z', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510726', '北川羌族自治县', '四川省·绵阳市·北川羌族自治县', null, 'B', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510727', '平武县', '四川省·绵阳市·平武县', null, 'P', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510751', '高新区', '四川省·绵阳市·高新区', null, 'G', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510781', '江油市', '四川省·绵阳市·江油市', null, 'J', null, null, null, '510700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510800', '广元市', '四川省·广元市', null, 'G', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510802', '利州区', '四川省·广元市·利州区', null, 'L', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510811', '元坝区', '四川省·广元市·元坝区', null, 'Y', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510812', '朝天区', '四川省·广元市·朝天区', null, 'C', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510821', '旺苍县', '四川省·广元市·旺苍县', null, 'W', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510822', '青川县', '四川省·广元市·青川县', null, 'Q', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510823', '剑阁县', '四川省·广元市·剑阁县', null, 'J', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510824', '苍溪县', '四川省·广元市·苍溪县', null, 'C', null, null, null, '510800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510900', '遂宁市', '四川省·遂宁市', null, 'S', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510903', '船山区', '四川省·遂宁市·船山区', null, 'C', null, null, null, '510900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510904', '安居区', '四川省·遂宁市·安居区', null, 'A', null, null, null, '510900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510921', '蓬溪县', '四川省·遂宁市·蓬溪县', null, 'P', null, null, null, '510900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510922', '射洪县', '四川省·遂宁市·射洪县', null, 'S', null, null, null, '510900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('510923', '大英县', '四川省·遂宁市·大英县', null, 'D', null, null, null, '510900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511000', '内江市', '四川省·内江市', null, 'N', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511002', '市中区', '四川省·内江市·市中区', null, 'S', null, null, null, '511000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511011', '东兴区', '四川省·内江市·东兴区', null, 'D', null, null, null, '511000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511024', '威远县', '四川省·内江市·威远县', null, 'W', null, null, null, '511000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511025', '资中县', '四川省·内江市·资中县', null, 'Z', null, null, null, '511000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511028', '隆昌县', '四川省·内江市·隆昌县', null, 'L', null, null, null, '511000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511100', '乐山市', '四川省·乐山市', null, 'L', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511102', '市中区', '四川省·乐山市·市中区', null, 'S', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511111', '沙湾区', '四川省·乐山市·沙湾区', null, 'S', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511112', '五通桥区', '四川省·乐山市·五通桥区', null, 'W', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511113', '金口河区', '四川省·乐山市·金口河区', null, 'J', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511123', '犍为县', '四川省·乐山市·犍为县', null, 'J', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511124', '井研县', '四川省·乐山市·井研县', null, 'J', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511126', '夹江县', '四川省·乐山市·夹江县', null, 'J', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511129', '沐川县', '四川省·乐山市·沐川县', null, 'M', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511132', '峨边彝族自治县', '四川省·乐山市·峨边彝族自治县', null, 'E', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511133', '马边彝族自治县', '四川省·乐山市·马边彝族自治县', null, 'M', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511181', '峨眉山市', '四川省·乐山市·峨眉山市', null, 'E', null, null, null, '511100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511300', '南充市', '四川省·南充市', null, 'N', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511302', '顺庆区', '四川省·南充市·顺庆区', null, 'S', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511303', '高坪区', '四川省·南充市·高坪区', null, 'G', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511304', '嘉陵区', '四川省·南充市·嘉陵区', null, 'J', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511321', '南部县', '四川省·南充市·南部县', null, 'N', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511322', '营山县', '四川省·南充市·营山县', null, 'Y', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511323', '蓬安县', '四川省·南充市·蓬安县', null, 'P', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511324', '仪陇县', '四川省·南充市·仪陇县', null, 'Y', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511325', '西充县', '四川省·南充市·西充县', null, 'X', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511381', '阆中市', '四川省·南充市·阆中市', null, 'L', null, null, null, '511300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511400', '眉山市', '四川省·眉山市', null, 'M', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511402', '东坡区', '四川省·眉山市·东坡区', null, 'D', null, null, null, '511400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511421', '仁寿县', '四川省·眉山市·仁寿县', null, 'R', null, null, null, '511400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511422', '彭山县', '四川省·眉山市·彭山县', null, 'P', null, null, null, '511400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511423', '洪雅县', '四川省·眉山市·洪雅县', null, 'H', null, null, null, '511400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511424', '丹棱县', '四川省·眉山市·丹棱县', null, 'D', null, null, null, '511400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511425', '青神县', '四川省·眉山市·青神县', null, 'Q', null, null, null, '511400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511500', '宜宾市', '四川省·宜宾市', null, 'Y', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511502', '翠屏区', '四川省·宜宾市·翠屏区', null, 'C', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511521', '宜宾县', '四川省·宜宾市·宜宾县', null, 'Y', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511522', '南溪县', '四川省·宜宾市·南溪县', null, 'N', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511523', '江安县', '四川省·宜宾市·江安县', null, 'J', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511524', '长宁县', '四川省·宜宾市·长宁县', null, 'Z', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511525', '高县', '四川省·宜宾市·高县', null, 'G', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511526', '珙县', '四川省·宜宾市·珙县', null, 'G', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511527', '筠连县', '四川省·宜宾市·筠连县', null, 'J', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511528', '兴文县', '四川省·宜宾市·兴文县', null, 'X', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511529', '屏山县', '四川省·宜宾市·屏山县', null, 'P', null, null, null, '511500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511600', '广安市', '四川省·广安市', null, 'G', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511602', '广安区', '四川省·广安市·广安区', null, 'G', null, null, null, '511600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511621', '岳池县', '四川省·广安市·岳池县', null, 'Y', null, null, null, '511600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511622', '武胜县', '四川省·广安市·武胜县', null, 'W', null, null, null, '511600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511623', '邻水县', '四川省·广安市·邻水县', null, 'L', null, null, null, '511600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511681', '华蓥市', '四川省·广安市·华蓥市', null, 'H', null, null, null, '511600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511682', '市辖区', '四川省·广安市·市辖区', null, 'S', null, null, null, '511600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511700', '达州市', '四川省·达州市', null, 'D', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511702', '通川区', '四川省·达州市·通川区', null, 'T', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511721', '达县', '四川省·达州市·达县', null, 'D', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511722', '宣汉县', '四川省·达州市·宣汉县', null, 'X', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511723', '开江县', '四川省·达州市·开江县', null, 'K', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511724', '大竹县', '四川省·达州市·大竹县', null, 'D', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511725', '渠县', '四川省·达州市·渠县', null, 'Q', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511781', '万源市', '四川省·达州市·万源市', null, 'W', null, null, null, '511700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511800', '雅安市', '四川省·雅安市', null, 'Y', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511802', '雨城区', '四川省·雅安市·雨城区', null, 'Y', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511821', '名山县', '四川省·雅安市·名山县', null, 'M', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511822', '荥经县', '四川省·雅安市·荥经县', null, 'Y', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511823', '汉源县', '四川省·雅安市·汉源县', null, 'H', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511824', '石棉县', '四川省·雅安市·石棉县', null, 'S', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511825', '天全县', '四川省·雅安市·天全县', null, 'T', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511826', '芦山县', '四川省·雅安市·芦山县', null, 'L', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511827', '宝兴县', '四川省·雅安市·宝兴县', null, 'B', null, null, null, '511800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511900', '巴中市', '四川省·巴中市', null, 'B', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511902', '巴州区', '四川省·巴中市·巴州区', null, 'B', null, null, null, '511900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511921', '通江县', '四川省·巴中市·通江县', null, 'T', null, null, null, '511900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511922', '南江县', '四川省·巴中市·南江县', null, 'N', null, null, null, '511900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('511923', '平昌县', '四川省·巴中市·平昌县', null, 'P', null, null, null, '511900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('512000', '资阳市', '四川省·资阳市', null, 'Z', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('512002', '雁江区', '四川省·资阳市·雁江区', null, 'Y', null, null, null, '512000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('512021', '安岳县', '四川省·资阳市·安岳县', null, 'A', null, null, null, '512000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('512022', '乐至县', '四川省·资阳市·乐至县', null, 'L', null, null, null, '512000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('512081', '简阳市', '四川省·资阳市·简阳市', null, 'J', null, null, null, '512000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513200', '阿坝藏族羌族自治州', '四川省·阿坝藏族羌族自治州', null, 'A', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513221', '汶川县', '四川省·阿坝藏族羌族自治州·汶川县', null, 'W', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513222', '理县', '四川省·阿坝藏族羌族自治州·理县', null, 'L', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513223', '茂县', '四川省·阿坝藏族羌族自治州·茂县', null, 'M', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513224', '松潘县', '四川省·阿坝藏族羌族自治州·松潘县', null, 'S', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513225', '九寨沟县', '四川省·阿坝藏族羌族自治州·九寨沟县', null, 'J', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513226', '金川县', '四川省·阿坝藏族羌族自治州·金川县', null, 'J', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513227', '小金县', '四川省·阿坝藏族羌族自治州·小金县', null, 'X', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513228', '黑水县', '四川省·阿坝藏族羌族自治州·黑水县', null, 'H', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513229', '马尔康县', '四川省·阿坝藏族羌族自治州·马尔康县', null, 'M', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513230', '壤塘县', '四川省·阿坝藏族羌族自治州·壤塘县', null, 'R', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513231', '阿坝县', '四川省·阿坝藏族羌族自治州·阿坝县', null, 'A', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513232', '若尔盖县', '四川省·阿坝藏族羌族自治州·若尔盖县', null, 'R', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513233', '红原县', '四川省·阿坝藏族羌族自治州·红原县', null, 'H', null, null, null, '513200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513300', '甘孜藏族自治州', '四川省·甘孜藏族自治州', null, 'G', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513321', '康定县', '四川省·甘孜藏族自治州·康定县', null, 'K', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513322', '泸定县', '四川省·甘孜藏族自治州·泸定县', null, 'L', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513323', '丹巴县', '四川省·甘孜藏族自治州·丹巴县', null, 'D', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513324', '九龙县', '四川省·甘孜藏族自治州·九龙县', null, 'J', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513325', '雅江县', '四川省·甘孜藏族自治州·雅江县', null, 'Y', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513326', '道孚县', '四川省·甘孜藏族自治州·道孚县', null, 'D', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513327', '炉霍县', '四川省·甘孜藏族自治州·炉霍县', null, 'L', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513328', '甘孜县', '四川省·甘孜藏族自治州·甘孜县', null, 'G', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513329', '新龙县', '四川省·甘孜藏族自治州·新龙县', null, 'X', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513330', '德格县', '四川省·甘孜藏族自治州·德格县', null, 'D', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513331', '白玉县', '四川省·甘孜藏族自治州·白玉县', null, 'B', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513332', '石渠县', '四川省·甘孜藏族自治州·石渠县', null, 'S', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513333', '色达县', '四川省·甘孜藏族自治州·色达县', null, 'S', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513334', '理塘县', '四川省·甘孜藏族自治州·理塘县', null, 'L', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513335', '巴塘县', '四川省·甘孜藏族自治州·巴塘县', null, 'B', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513336', '乡城县', '四川省·甘孜藏族自治州·乡城县', null, 'X', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513337', '稻城县', '四川省·甘孜藏族自治州·稻城县', null, 'D', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513338', '得荣县', '四川省·甘孜藏族自治州·得荣县', null, 'D', null, null, null, '513300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513400', '凉山彝族自治州', '四川省·凉山彝族自治州', null, 'L', null, null, null, '510000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513401', '西昌市', '四川省·凉山彝族自治州·西昌市', null, 'X', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513422', '木里藏族自治县', '四川省·凉山彝族自治州·木里藏族自治县', null, 'M', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513423', '盐源县', '四川省·凉山彝族自治州·盐源县', null, 'Y', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513424', '德昌县', '四川省·凉山彝族自治州·德昌县', null, 'D', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513425', '会理县', '四川省·凉山彝族自治州·会理县', null, 'H', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513426', '会东县', '四川省·凉山彝族自治州·会东县', null, 'H', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513427', '宁南县', '四川省·凉山彝族自治州·宁南县', null, 'N', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513428', '普格县', '四川省·凉山彝族自治州·普格县', null, 'P', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513429', '布拖县', '四川省·凉山彝族自治州·布拖县', null, 'B', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513430', '金阳县', '四川省·凉山彝族自治州·金阳县', null, 'J', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513431', '昭觉县', '四川省·凉山彝族自治州·昭觉县', null, 'Z', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513432', '喜德县', '四川省·凉山彝族自治州·喜德县', null, 'X', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513433', '冕宁县', '四川省·凉山彝族自治州·冕宁县', null, 'M', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513434', '越西县', '四川省·凉山彝族自治州·越西县', null, 'Y', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513435', '甘洛县', '四川省·凉山彝族自治州·甘洛县', null, 'G', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513436', '美姑县', '四川省·凉山彝族自治州·美姑县', null, 'M', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('513437', '雷波县', '四川省·凉山彝族自治州·雷波县', null, 'L', null, null, null, '513400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520000', '贵州省', '贵州省', null, 'G', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520100', '贵阳市', '贵州省·贵阳市', null, 'G', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520102', '南明区', '贵州省·贵阳市·南明区', null, 'N', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520103', '云岩区', '贵州省·贵阳市·云岩区', null, 'Y', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520111', '花溪区', '贵州省·贵阳市·花溪区', null, 'H', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520112', '乌当区', '贵州省·贵阳市·乌当区', null, 'W', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520113', '白云区', '贵州省·贵阳市·白云区', null, 'B', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520114', '小河区', '贵州省·贵阳市·小河区', null, 'X', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520121', '开阳县', '贵州省·贵阳市·开阳县', null, 'K', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520122', '息烽县', '贵州省·贵阳市·息烽县', null, 'X', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520123', '修文县', '贵州省·贵阳市·修文县', null, 'X', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520151', '金阳开发区', '贵州省·贵阳市·金阳开发区', null, 'J', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520181', '清镇市', '贵州省·贵阳市·清镇市', null, 'Q', null, null, null, '520100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520200', '六盘水市', '贵州省·六盘水市', null, 'L', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520201', '钟山区', '贵州省·六盘水市·钟山区', null, 'Z', null, null, null, '520200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520203', '六枝特区', '贵州省·六盘水市·六枝特区', null, 'L', null, null, null, '520200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520221', '水城县', '贵州省·六盘水市·水城县', null, 'S', null, null, null, '520200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520222', '盘县', '贵州省·六盘水市·盘县', null, 'P', null, null, null, '520200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520300', '遵义市', '贵州省·遵义市', null, 'Z', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520302', '红花岗区', '贵州省·遵义市·红花岗区', null, 'H', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520303', '汇川区', '贵州省·遵义市·汇川区', null, 'H', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520321', '遵义县', '贵州省·遵义市·遵义县', null, 'Z', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520322', '桐梓县', '贵州省·遵义市·桐梓县', null, 'T', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520323', '绥阳县', '贵州省·遵义市·绥阳县', null, 'S', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520324', '正安县', '贵州省·遵义市·正安县', null, 'Z', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520325', '道真仡佬族苗族自治县', '贵州省·遵义市·道真仡佬族苗族自治县', null, 'D', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520326', '务川仡佬族苗族自治县', '贵州省·遵义市·务川仡佬族苗族自治县', null, 'W', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520327', '凤冈县', '贵州省·遵义市·凤冈县', null, 'F', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520328', '湄潭县', '贵州省·遵义市·湄潭县', null, 'M', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520329', '余庆县', '贵州省·遵义市·余庆县', null, 'Y', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520330', '习水县', '贵州省·遵义市·习水县', null, 'X', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520381', '赤水市', '贵州省·遵义市·赤水市', null, 'C', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520382', '仁怀市', '贵州省·遵义市·仁怀市', null, 'R', null, null, null, '520300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520400', '安顺市', '贵州省·安顺市', null, 'A', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520402', '西秀区', '贵州省·安顺市·西秀区', null, 'X', null, null, null, '520400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520421', '平坝县', '贵州省·安顺市·平坝县', null, 'P', null, null, null, '520400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520422', '普定县', '贵州省·安顺市·普定县', null, 'P', null, null, null, '520400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520423', '镇宁布依族苗族自治县', '贵州省·安顺市·镇宁布依族苗族自治县', null, 'Z', null, null, null, '520400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520424', '关岭布依族苗族自治县', '贵州省·安顺市·关岭布依族苗族自治县', null, 'G', null, null, null, '520400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('520425', '紫云苗族布依族自治县', '贵州省·安顺市·紫云苗族布依族自治县', null, 'Z', null, null, null, '520400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522200', '铜仁地区', '贵州省·铜仁地区', null, 'T', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522201', '铜仁市', '贵州省·铜仁地区·铜仁市', null, 'T', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522222', '江口县', '贵州省·铜仁地区·江口县', null, 'J', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522223', '玉屏侗族自治县', '贵州省·铜仁地区·玉屏侗族自治县', null, 'Y', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522224', '石阡县', '贵州省·铜仁地区·石阡县', null, 'S', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522225', '思南县', '贵州省·铜仁地区·思南县', null, 'S', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522226', '印江土家族苗族自治县', '贵州省·铜仁地区·印江土家族苗族自治县', null, 'Y', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522227', '德江县', '贵州省·铜仁地区·德江县', null, 'D', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522228', '沿河土家族自治县', '贵州省·铜仁地区·沿河土家族自治县', null, 'Y', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522229', '松桃苗族自治县', '贵州省·铜仁地区·松桃苗族自治县', null, 'S', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522230', '万山特区', '贵州省·铜仁地区·万山特区', null, 'W', null, null, null, '522200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522300', '黔西南布依族苗族自治州', '贵州省·黔西南布依族苗族自治州', null, 'Q', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522301', '兴义市', '贵州省·黔西南布依族苗族自治州·兴义市', null, 'X', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522322', '兴仁县', '贵州省·黔西南布依族苗族自治州·兴仁县', null, 'X', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522323', '普安县', '贵州省·黔西南布依族苗族自治州·普安县', null, 'P', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522324', '晴隆县', '贵州省·黔西南布依族苗族自治州·晴隆县', null, 'Q', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522325', '贞丰县', '贵州省·黔西南布依族苗族自治州·贞丰县', null, 'Z', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522326', '望谟县', '贵州省·黔西南布依族苗族自治州·望谟县', null, 'W', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522327', '册亨县', '贵州省·黔西南布依族苗族自治州·册亨县', null, 'C', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522328', '安龙县', '贵州省·黔西南布依族苗族自治州·安龙县', null, 'A', null, null, null, '522300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522400', '毕节地区', '贵州省·毕节地区', null, 'B', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522401', '毕节市', '贵州省·毕节地区·毕节市', null, 'B', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522422', '大方县', '贵州省·毕节地区·大方县', null, 'D', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522423', '黔西县', '贵州省·毕节地区·黔西县', null, 'Q', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522424', '金沙县', '贵州省·毕节地区·金沙县', null, 'J', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522425', '织金县', '贵州省·毕节地区·织金县', null, 'Z', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522426', '纳雍县', '贵州省·毕节地区·纳雍县', null, 'N', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522427', '威宁彝族回族苗族自治县', '贵州省·毕节地区·威宁彝族回族苗族自治县', null, 'W', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522428', '赫章县', '贵州省·毕节地区·赫章县', null, 'H', null, null, null, '522400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522600', '黔东南苗族侗族自治州', '贵州省·黔东南苗族侗族自治州', null, 'Q', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522601', '凯里市', '贵州省·黔东南苗族侗族自治州·凯里市', null, 'K', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522622', '黄平县', '贵州省·黔东南苗族侗族自治州·黄平县', null, 'H', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522623', '施秉县', '贵州省·黔东南苗族侗族自治州·施秉县', null, 'S', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522624', '三穗县', '贵州省·黔东南苗族侗族自治州·三穗县', null, 'S', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522625', '镇远县', '贵州省·黔东南苗族侗族自治州·镇远县', null, 'Z', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522626', '岑巩县', '贵州省·黔东南苗族侗族自治州·岑巩县', null, 'C', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522627', '天柱县', '贵州省·黔东南苗族侗族自治州·天柱县', null, 'T', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522628', '锦屏县', '贵州省·黔东南苗族侗族自治州·锦屏县', null, 'J', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522629', '剑河县', '贵州省·黔东南苗族侗族自治州·剑河县', null, 'J', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522630', '台江县', '贵州省·黔东南苗族侗族自治州·台江县', null, 'T', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522631', '黎平县', '贵州省·黔东南苗族侗族自治州·黎平县', null, 'L', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522632', '榕江县', '贵州省·黔东南苗族侗族自治州·榕江县', null, 'R', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522633', '从江县', '贵州省·黔东南苗族侗族自治州·从江县', null, 'C', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522634', '雷山县', '贵州省·黔东南苗族侗族自治州·雷山县', null, 'L', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522635', '麻江县', '贵州省·黔东南苗族侗族自治州·麻江县', null, 'M', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522636', '丹寨县', '贵州省·黔东南苗族侗族自治州·丹寨县', null, 'D', null, null, null, '522600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522700', '黔南布依族苗族自治州', '贵州省·黔南布依族苗族自治州', null, 'Q', null, null, null, '520000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522701', '都匀市', '贵州省·黔南布依族苗族自治州·都匀市', null, 'D', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522702', '福泉市', '贵州省·黔南布依族苗族自治州·福泉市', null, 'F', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522722', '荔波县', '贵州省·黔南布依族苗族自治州·荔波县', null, 'L', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522723', '贵定县', '贵州省·黔南布依族苗族自治州·贵定县', null, 'G', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522725', '瓮安县', '贵州省·黔南布依族苗族自治州·瓮安县', null, 'W', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522726', '独山县', '贵州省·黔南布依族苗族自治州·独山县', null, 'D', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522727', '平塘县', '贵州省·黔南布依族苗族自治州·平塘县', null, 'P', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522728', '罗甸县', '贵州省·黔南布依族苗族自治州·罗甸县', null, 'L', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522729', '长顺县', '贵州省·黔南布依族苗族自治州·长顺县', null, 'Z', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522730', '龙里县', '贵州省·黔南布依族苗族自治州·龙里县', null, 'L', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522731', '惠水县', '贵州省·黔南布依族苗族自治州·惠水县', null, 'H', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('522732', '三都水族自治县', '贵州省·黔南布依族苗族自治州·三都水族自治县', null, 'S', null, null, null, '522700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530000', '云南省', '云南省', null, 'Y', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530100', '昆明市', '云南省·昆明市', null, 'K', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530102', '五华区', '云南省·昆明市·五华区', null, 'W', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530103', '盘龙区', '云南省·昆明市·盘龙区', null, 'P', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530111', '官渡区', '云南省·昆明市·官渡区', null, 'G', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530112', '西山区', '云南省·昆明市·西山区', null, 'X', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530113', '东川区', '云南省·昆明市·东川区', null, 'D', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530121', '呈贡县', '云南省·昆明市·呈贡县', null, 'C', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530122', '晋宁县', '云南省·昆明市·晋宁县', null, 'J', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530124', '富民县', '云南省·昆明市·富民县', null, 'F', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530125', '宜良县', '云南省·昆明市·宜良县', null, 'Y', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530126', '石林彝族自治县', '云南省·昆明市·石林彝族自治县', null, 'S', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530127', '嵩明县', '云南省·昆明市·嵩明县', null, 'S', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530128', '禄劝彝族苗族自治县', '云南省·昆明市·禄劝彝族苗族自治县', null, 'L', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530129', '寻甸回族彝族自治县', '云南省·昆明市·寻甸回族彝族自治县', null, 'X', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530181', '安宁市', '云南省·昆明市·安宁市', null, 'A', null, null, null, '530100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530300', '曲靖市', '云南省·曲靖市', null, 'Q', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530302', '麒麟区', '云南省·曲靖市·麒麟区', null, 'Q', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530321', '马龙县', '云南省·曲靖市·马龙县', null, 'M', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530322', '陆良县', '云南省·曲靖市·陆良县', null, 'L', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530323', '师宗县', '云南省·曲靖市·师宗县', null, 'S', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530324', '罗平县', '云南省·曲靖市·罗平县', null, 'L', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530325', '富源县', '云南省·曲靖市·富源县', null, 'F', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530326', '会泽县', '云南省·曲靖市·会泽县', null, 'H', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530328', '沾益县', '云南省·曲靖市·沾益县', null, 'Z', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530381', '宣威市', '云南省·曲靖市·宣威市', null, 'X', null, null, null, '530300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530400', '玉溪市', '云南省·玉溪市', null, 'Y', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530402', '红塔区', '云南省·玉溪市·红塔区', null, 'H', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530421', '江川县', '云南省·玉溪市·江川县', null, 'J', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530422', '澄江县', '云南省·玉溪市·澄江县', null, 'C', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530423', '通海县', '云南省·玉溪市·通海县', null, 'T', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530424', '华宁县', '云南省·玉溪市·华宁县', null, 'H', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530425', '易门县', '云南省·玉溪市·易门县', null, 'Y', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530426', '峨山彝族自治县', '云南省·玉溪市·峨山彝族自治县', null, 'E', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530427', '新平彝族傣族自治县', '云南省·玉溪市·新平彝族傣族自治县', null, 'X', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530428', '元江哈尼族彝族傣族自治县', '云南省·玉溪市·元江哈尼族彝族傣族自治县', null, 'Y', null, null, null, '530400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530500', '保山市', '云南省·保山市', null, 'B', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530502', '隆阳区', '云南省·保山市·隆阳区', null, 'L', null, null, null, '530500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530521', '施甸县', '云南省·保山市·施甸县', null, 'S', null, null, null, '530500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530522', '腾冲县', '云南省·保山市·腾冲县', null, 'T', null, null, null, '530500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530523', '龙陵县', '云南省·保山市·龙陵县', null, 'L', null, null, null, '530500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530524', '昌宁县', '云南省·保山市·昌宁县', null, 'C', null, null, null, '530500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530600', '昭通市', '云南省·昭通市', null, 'Z', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530602', '昭阳区', '云南省·昭通市·昭阳区', null, 'Z', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530621', '鲁甸县', '云南省·昭通市·鲁甸县', null, 'L', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530622', '巧家县', '云南省·昭通市·巧家县', null, 'Q', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530623', '盐津县', '云南省·昭通市·盐津县', null, 'Y', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530624', '大关县', '云南省·昭通市·大关县', null, 'D', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530625', '永善县', '云南省·昭通市·永善县', null, 'Y', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530626', '绥江县', '云南省·昭通市·绥江县', null, 'S', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530627', '镇雄县', '云南省·昭通市·镇雄县', null, 'Z', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530628', '彝良县', '云南省·昭通市·彝良县', null, 'Y', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530629', '威信县', '云南省·昭通市·威信县', null, 'W', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530630', '水富县', '云南省·昭通市·水富县', null, 'S', null, null, null, '530600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530700', '丽江市', '云南省·丽江市', null, 'L', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530702', '古城区', '云南省·丽江市·古城区', null, 'G', null, null, null, '530700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530721', '玉龙纳西族自治县', '云南省·丽江市·玉龙纳西族自治县', null, 'Y', null, null, null, '530700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530722', '永胜县', '云南省·丽江市·永胜县', null, 'Y', null, null, null, '530700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530723', '华坪县', '云南省·丽江市·华坪县', null, 'H', null, null, null, '530700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530724', '宁蒗彝族自治县', '云南省·丽江市·宁蒗彝族自治县', null, 'N', null, null, null, '530700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530800', '普洱市', '云南省·普洱市', null, 'P', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530802', '思茅区', '云南省·普洱市·思茅区', null, 'S', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530821', '宁洱哈尼族彝族自治县', '云南省·普洱市·宁洱哈尼族彝族自治县', null, 'N', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530822', '墨江哈尼族自治县', '云南省·普洱市·墨江哈尼族自治县', null, 'M', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530823', '景东彝族自治县', '云南省·普洱市·景东彝族自治县', null, 'J', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530824', '景谷傣族彝族自治县', '云南省·普洱市·景谷傣族彝族自治县', null, 'J', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '云南省·普洱市·镇沅彝族哈尼族拉祜族自治县', null, 'Z', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530826', '江城哈尼族彝族自治县', '云南省·普洱市·江城哈尼族彝族自治县', null, 'J', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '云南省·普洱市·孟连傣族拉祜族佤族自治县', null, 'M', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530828', '澜沧拉祜族自治县', '云南省·普洱市·澜沧拉祜族自治县', null, 'L', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530829', '西盟佤族自治县', '云南省·普洱市·西盟佤族自治县', null, 'X', null, null, null, '530800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530900', '临沧市', '云南省·临沧市', null, 'L', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530902', '临翔区', '云南省·临沧市·临翔区', null, 'L', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530921', '凤庆县', '云南省·临沧市·凤庆县', null, 'F', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530922', '云县', '云南省·临沧市·云县', null, 'Y', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530923', '永德县', '云南省·临沧市·永德县', null, 'Y', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530924', '镇康县', '云南省·临沧市·镇康县', null, 'Z', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '云南省·临沧市·双江拉祜族佤族布朗族傣族自治县', null, 'S', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530926', '耿马傣族佤族自治县', '云南省·临沧市·耿马傣族佤族自治县', null, 'G', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('530927', '沧源佤族自治县', '云南省·临沧市·沧源佤族自治县', null, 'C', null, null, null, '530900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532300', '楚雄彝族自治州', '云南省·楚雄彝族自治州', null, 'C', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532301', '楚雄市', '云南省·楚雄彝族自治州·楚雄市', null, 'C', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532322', '双柏县', '云南省·楚雄彝族自治州·双柏县', null, 'S', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532323', '牟定县', '云南省·楚雄彝族自治州·牟定县', null, 'M', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532324', '南华县', '云南省·楚雄彝族自治州·南华县', null, 'N', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532325', '姚安县', '云南省·楚雄彝族自治州·姚安县', null, 'Y', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532326', '大姚县', '云南省·楚雄彝族自治州·大姚县', null, 'D', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532327', '永仁县', '云南省·楚雄彝族自治州·永仁县', null, 'Y', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532328', '元谋县', '云南省·楚雄彝族自治州·元谋县', null, 'Y', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532329', '武定县', '云南省·楚雄彝族自治州·武定县', null, 'W', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532331', '禄丰县', '云南省·楚雄彝族自治州·禄丰县', null, 'L', null, null, null, '532300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532500', '红河哈尼族彝族自治州', '云南省·红河哈尼族彝族自治州', null, 'H', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532501', '个旧市', '云南省·红河哈尼族彝族自治州·个旧市', null, 'G', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532502', '开远市', '云南省·红河哈尼族彝族自治州·开远市', null, 'K', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532522', '蒙自县', '云南省·红河哈尼族彝族自治州·蒙自县', null, 'M', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532523', '屏边苗族自治县', '云南省·红河哈尼族彝族自治州·屏边苗族自治县', null, 'P', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532524', '建水县', '云南省·红河哈尼族彝族自治州·建水县', null, 'J', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532525', '石屏县', '云南省·红河哈尼族彝族自治州·石屏县', null, 'S', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532526', '弥勒县', '云南省·红河哈尼族彝族自治州·弥勒县', null, 'M', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532527', '泸西县', '云南省·红河哈尼族彝族自治州·泸西县', null, 'L', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532528', '元阳县', '云南省·红河哈尼族彝族自治州·元阳县', null, 'Y', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532529', '红河县', '云南省·红河哈尼族彝族自治州·红河县', null, 'H', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532530', '金平苗族瑶族傣族自治县', '云南省·红河哈尼族彝族自治州·金平苗族瑶族傣族自治县', null, 'J', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532531', '绿春县', '云南省·红河哈尼族彝族自治州·绿春县', null, 'L', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532532', '河口瑶族自治县', '云南省·红河哈尼族彝族自治州·河口瑶族自治县', null, 'H', null, null, null, '532500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532600', '文山壮族苗族自治州', '云南省·文山壮族苗族自治州', null, 'W', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532621', '文山县', '云南省·文山壮族苗族自治州·文山县', null, 'W', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532622', '砚山县', '云南省·文山壮族苗族自治州·砚山县', null, 'Y', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532623', '西畴县', '云南省·文山壮族苗族自治州·西畴县', null, 'X', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532624', '麻栗坡县', '云南省·文山壮族苗族自治州·麻栗坡县', null, 'M', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532625', '马关县', '云南省·文山壮族苗族自治州·马关县', null, 'M', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532626', '丘北县', '云南省·文山壮族苗族自治州·丘北县', null, 'Q', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532627', '广南县', '云南省·文山壮族苗族自治州·广南县', null, 'G', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532628', '富宁县', '云南省·文山壮族苗族自治州·富宁县', null, 'F', null, null, null, '532600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532800', '西双版纳傣族自治州', '云南省·西双版纳傣族自治州', null, 'X', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532801', '景洪市', '云南省·西双版纳傣族自治州·景洪市', null, 'J', null, null, null, '532800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532822', '勐海县', '云南省·西双版纳傣族自治州·勐海县', null, 'M', null, null, null, '532800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532823', '勐腊县', '云南省·西双版纳傣族自治州·勐腊县', null, 'M', null, null, null, '532800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532900', '大理白族自治州', '云南省·大理白族自治州', null, 'D', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532901', '大理市', '云南省·大理白族自治州·大理市', null, 'D', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532922', '漾濞彝族自治县', '云南省·大理白族自治州·漾濞彝族自治县', null, 'Y', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532923', '祥云县', '云南省·大理白族自治州·祥云县', null, 'X', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532924', '宾川县', '云南省·大理白族自治州·宾川县', null, 'B', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532925', '弥渡县', '云南省·大理白族自治州·弥渡县', null, 'M', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532926', '南涧彝族自治县', '云南省·大理白族自治州·南涧彝族自治县', null, 'N', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532927', '巍山彝族回族自治县', '云南省·大理白族自治州·巍山彝族回族自治县', null, 'W', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532928', '永平县', '云南省·大理白族自治州·永平县', null, 'Y', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532929', '云龙县', '云南省·大理白族自治州·云龙县', null, 'Y', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532930', '洱源县', '云南省·大理白族自治州·洱源县', null, 'E', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532931', '剑川县', '云南省·大理白族自治州·剑川县', null, 'J', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('532932', '鹤庆县', '云南省·大理白族自治州·鹤庆县', null, 'H', null, null, null, '532900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533100', '德宏傣族景颇族自治州', '云南省·德宏傣族景颇族自治州', null, 'D', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533102', '瑞丽市', '云南省·德宏傣族景颇族自治州·瑞丽市', null, 'R', null, null, null, '533100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533103', '潞西市', '云南省·德宏傣族景颇族自治州·潞西市', null, 'L', null, null, null, '533100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533122', '梁河县', '云南省·德宏傣族景颇族自治州·梁河县', null, 'L', null, null, null, '533100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533123', '盈江县', '云南省·德宏傣族景颇族自治州·盈江县', null, 'Y', null, null, null, '533100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533124', '陇川县', '云南省·德宏傣族景颇族自治州·陇川县', null, 'L', null, null, null, '533100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533300', '怒江傈僳族自治州', '云南省·怒江傈僳族自治州', null, 'N', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533321', '泸水县', '云南省·怒江傈僳族自治州·泸水县', null, 'L', null, null, null, '533300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533323', '福贡县', '云南省·怒江傈僳族自治州·福贡县', null, 'F', null, null, null, '533300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533324', '贡山独龙族怒族自治县', '云南省·怒江傈僳族自治州·贡山独龙族怒族自治县', null, 'G', null, null, null, '533300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533325', '兰坪白族普米族自治县', '云南省·怒江傈僳族自治州·兰坪白族普米族自治县', null, 'L', null, null, null, '533300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533400', '迪庆藏族自治州', '云南省·迪庆藏族自治州', null, 'D', null, null, null, '530000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533421', '香格里拉县', '云南省·迪庆藏族自治州·香格里拉县', null, 'X', null, null, null, '533400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533422', '德钦县', '云南省·迪庆藏族自治州·德钦县', null, 'D', null, null, null, '533400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('533423', '维西傈僳族自治县', '云南省·迪庆藏族自治州·维西傈僳族自治县', null, 'W', null, null, null, '533400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540000', '西藏自治区', '西藏自治区', null, 'X', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540100', '拉萨市', '西藏自治区·拉萨市', null, 'L', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540102', '城关区', '西藏自治区·拉萨市·城关区', null, 'C', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540121', '林周县', '西藏自治区·拉萨市·林周县', null, 'L', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540122', '当雄县', '西藏自治区·拉萨市·当雄县', null, 'D', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540123', '尼木县', '西藏自治区·拉萨市·尼木县', null, 'N', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540124', '曲水县', '西藏自治区·拉萨市·曲水县', null, 'Q', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540125', '堆龙德庆县', '西藏自治区·拉萨市·堆龙德庆县', null, 'D', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540126', '达孜县', '西藏自治区·拉萨市·达孜县', null, 'D', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('540127', '墨竹工卡县', '西藏自治区·拉萨市·墨竹工卡县', null, 'M', null, null, null, '540100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542100', '昌都地区', '西藏自治区·昌都地区', null, 'C', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542121', '昌都县', '西藏自治区·昌都地区·昌都县', null, 'C', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542122', '江达县', '西藏自治区·昌都地区·江达县', null, 'J', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542123', '贡觉县', '西藏自治区·昌都地区·贡觉县', null, 'G', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542124', '类乌齐县', '西藏自治区·昌都地区·类乌齐县', null, 'L', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542125', '丁青县', '西藏自治区·昌都地区·丁青县', null, 'D', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542126', '察雅县', '西藏自治区·昌都地区·察雅县', null, 'C', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542127', '八宿县', '西藏自治区·昌都地区·八宿县', null, 'B', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542128', '左贡县', '西藏自治区·昌都地区·左贡县', null, 'Z', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542129', '芒康县', '西藏自治区·昌都地区·芒康县', null, 'M', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542132', '洛隆县', '西藏自治区·昌都地区·洛隆县', null, 'L', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542133', '边坝县', '西藏自治区·昌都地区·边坝县', null, 'B', null, null, null, '542100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542200', '山南地区', '西藏自治区·山南地区', null, 'S', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542221', '乃东县', '西藏自治区·山南地区·乃东县', null, 'N', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542222', '扎囊县', '西藏自治区·山南地区·扎囊县', null, 'Z', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542223', '贡嘎县', '西藏自治区·山南地区·贡嘎县', null, 'G', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542224', '桑日县', '西藏自治区·山南地区·桑日县', null, 'S', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542225', '琼结县', '西藏自治区·山南地区·琼结县', null, 'Q', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542226', '曲松县', '西藏自治区·山南地区·曲松县', null, 'Q', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542227', '措美县', '西藏自治区·山南地区·措美县', null, 'C', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542228', '洛扎县', '西藏自治区·山南地区·洛扎县', null, 'L', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542229', '加查县', '西藏自治区·山南地区·加查县', null, 'J', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542231', '隆子县', '西藏自治区·山南地区·隆子县', null, 'L', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542232', '错那县', '西藏自治区·山南地区·错那县', null, 'C', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542233', '浪卡子县', '西藏自治区·山南地区·浪卡子县', null, 'L', null, null, null, '542200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542300', '日喀则地区', '西藏自治区·日喀则地区', null, 'R', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542301', '日喀则市', '西藏自治区·日喀则地区·日喀则市', null, 'R', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542322', '南木林县', '西藏自治区·日喀则地区·南木林县', null, 'N', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542323', '江孜县', '西藏自治区·日喀则地区·江孜县', null, 'J', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542324', '定日县', '西藏自治区·日喀则地区·定日县', null, 'D', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542325', '萨迦县', '西藏自治区·日喀则地区·萨迦县', null, 'S', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542326', '拉孜县', '西藏自治区·日喀则地区·拉孜县', null, 'L', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542327', '昂仁县', '西藏自治区·日喀则地区·昂仁县', null, 'A', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542328', '谢通门县', '西藏自治区·日喀则地区·谢通门县', null, 'X', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542329', '白朗县', '西藏自治区·日喀则地区·白朗县', null, 'B', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542330', '仁布县', '西藏自治区·日喀则地区·仁布县', null, 'R', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542331', '康马县', '西藏自治区·日喀则地区·康马县', null, 'K', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542332', '定结县', '西藏自治区·日喀则地区·定结县', null, 'D', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542333', '仲巴县', '西藏自治区·日喀则地区·仲巴县', null, 'Z', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542334', '亚东县', '西藏自治区·日喀则地区·亚东县', null, 'Y', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542335', '吉隆县', '西藏自治区·日喀则地区·吉隆县', null, 'J', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542336', '聂拉木县', '西藏自治区·日喀则地区·聂拉木县', null, 'N', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542337', '萨嘎县', '西藏自治区·日喀则地区·萨嘎县', null, 'S', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542338', '岗巴县', '西藏自治区·日喀则地区·岗巴县', null, 'G', null, null, null, '542300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542400', '那曲地区', '西藏自治区·那曲地区', null, 'N', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542421', '那曲县', '西藏自治区·那曲地区·那曲县', null, 'N', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542422', '嘉黎县', '西藏自治区·那曲地区·嘉黎县', null, 'J', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542423', '比如县', '西藏自治区·那曲地区·比如县', null, 'B', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542424', '聂荣县', '西藏自治区·那曲地区·聂荣县', null, 'N', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542425', '安多县', '西藏自治区·那曲地区·安多县', null, 'A', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542426', '申扎县', '西藏自治区·那曲地区·申扎县', null, 'S', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542427', '索县', '西藏自治区·那曲地区·索县', null, 'S', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542428', '班戈县', '西藏自治区·那曲地区·班戈县', null, 'B', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542429', '巴青县', '西藏自治区·那曲地区·巴青县', null, 'B', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542430', '尼玛县', '西藏自治区·那曲地区·尼玛县', null, 'N', null, null, null, '542400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542500', '阿里地区', '西藏自治区·阿里地区', null, 'A', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542521', '普兰县', '西藏自治区·阿里地区·普兰县', null, 'P', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542522', '札达县', '西藏自治区·阿里地区·札达县', null, 'Z', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542523', '噶尔县', '西藏自治区·阿里地区·噶尔县', null, 'G', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542524', '日土县', '西藏自治区·阿里地区·日土县', null, 'R', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542525', '革吉县', '西藏自治区·阿里地区·革吉县', null, 'G', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542526', '改则县', '西藏自治区·阿里地区·改则县', null, 'G', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542527', '措勤县', '西藏自治区·阿里地区·措勤县', null, 'C', null, null, null, '542500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542600', '林芝地区', '西藏自治区·林芝地区', null, 'L', null, null, null, '540000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542621', '林芝县', '西藏自治区·林芝地区·林芝县', null, 'L', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542622', '工布江达县', '西藏自治区·林芝地区·工布江达县', null, 'G', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542623', '米林县', '西藏自治区·林芝地区·米林县', null, 'M', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542624', '墨脱县', '西藏自治区·林芝地区·墨脱县', null, 'M', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542625', '波密县', '西藏自治区·林芝地区·波密县', null, 'B', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542626', '察隅县', '西藏自治区·林芝地区·察隅县', null, 'C', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('542627', '朗县', '西藏自治区·林芝地区·朗县', null, 'L', null, null, null, '542600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610000', '陕西省', '陕西省', null, 'S', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610100', '西安市', '陕西省·西安市', null, 'X', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610102', '新城区', '陕西省·西安市·新城区', null, 'X', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610103', '碑林区', '陕西省·西安市·碑林区', null, 'B', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610104', '莲湖区', '陕西省·西安市·莲湖区', null, 'L', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610111', '灞桥区', '陕西省·西安市·灞桥区', null, 'B', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610112', '未央区', '陕西省·西安市·未央区', null, 'W', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610113', '雁塔区', '陕西省·西安市·雁塔区', null, 'Y', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610114', '阎良区', '陕西省·西安市·阎良区', null, 'Y', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610115', '临潼区', '陕西省·西安市·临潼区', null, 'L', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610116', '长安区', '陕西省·西安市·长安区', null, 'Z', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610122', '蓝田县', '陕西省·西安市·蓝田县', null, 'L', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610124', '周至县', '陕西省·西安市·周至县', null, 'Z', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610125', '户县', '陕西省·西安市·户县', null, 'H', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610126', '高陵县', '陕西省·西安市·高陵县', null, 'G', null, null, null, '610100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610200', '铜川市', '陕西省·铜川市', null, 'T', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610202', '王益区', '陕西省·铜川市·王益区', null, 'W', null, null, null, '610200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610203', '印台区', '陕西省·铜川市·印台区', null, 'Y', null, null, null, '610200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610204', '耀州区', '陕西省·铜川市·耀州区', null, 'Y', null, null, null, '610200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610222', '宜君县', '陕西省·铜川市·宜君县', null, 'Y', null, null, null, '610200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610300', '宝鸡市', '陕西省·宝鸡市', null, 'B', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610302', '渭滨区', '陕西省·宝鸡市·渭滨区', null, 'W', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610303', '金台区', '陕西省·宝鸡市·金台区', null, 'J', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610304', '陈仓区', '陕西省·宝鸡市·陈仓区', null, 'C', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610322', '凤翔县', '陕西省·宝鸡市·凤翔县', null, 'F', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610323', '岐山县', '陕西省·宝鸡市·岐山县', null, 'Q', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610324', '扶风县', '陕西省·宝鸡市·扶风县', null, 'F', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610326', '眉县', '陕西省·宝鸡市·眉县', null, 'M', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610327', '陇县', '陕西省·宝鸡市·陇县', null, 'L', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610328', '千阳县', '陕西省·宝鸡市·千阳县', null, 'Q', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610329', '麟游县', '陕西省·宝鸡市·麟游县', null, 'L', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610330', '凤县', '陕西省·宝鸡市·凤县', null, 'F', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610331', '太白县', '陕西省·宝鸡市·太白县', null, 'T', null, null, null, '610300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610400', '咸阳市', '陕西省·咸阳市', null, 'X', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610402', '秦都区', '陕西省·咸阳市·秦都区', null, 'Q', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610403', '杨陵区', '陕西省·咸阳市·杨陵区', null, 'Y', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610404', '渭城区', '陕西省·咸阳市·渭城区', null, 'W', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610422', '三原县', '陕西省·咸阳市·三原县', null, 'S', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610423', '泾阳县', '陕西省·咸阳市·泾阳县', null, 'J', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610424', '乾县', '陕西省·咸阳市·乾县', null, 'Q', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610425', '礼泉县', '陕西省·咸阳市·礼泉县', null, 'L', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610426', '永寿县', '陕西省·咸阳市·永寿县', null, 'Y', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610427', '彬县', '陕西省·咸阳市·彬县', null, 'B', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610428', '长武县', '陕西省·咸阳市·长武县', null, 'Z', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610429', '旬邑县', '陕西省·咸阳市·旬邑县', null, 'X', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610430', '淳化县', '陕西省·咸阳市·淳化县', null, 'C', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610431', '武功县', '陕西省·咸阳市·武功县', null, 'W', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610481', '兴平市', '陕西省·咸阳市·兴平市', null, 'X', null, null, null, '610400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610500', '渭南市', '陕西省·渭南市', null, 'W', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610502', '临渭区', '陕西省·渭南市·临渭区', null, 'L', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610521', '华县', '陕西省·渭南市·华县', null, 'H', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610522', '潼关县', '陕西省·渭南市·潼关县', null, 'T', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610523', '大荔县', '陕西省·渭南市·大荔县', null, 'D', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610524', '合阳县', '陕西省·渭南市·合阳县', null, 'H', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610525', '澄城县', '陕西省·渭南市·澄城县', null, 'C', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610526', '蒲城县', '陕西省·渭南市·蒲城县', null, 'P', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610527', '白水县', '陕西省·渭南市·白水县', null, 'B', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610528', '富平县', '陕西省·渭南市·富平县', null, 'F', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610581', '韩城市', '陕西省·渭南市·韩城市', null, 'H', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610582', '华阴市', '陕西省·渭南市·华阴市', null, 'H', null, null, null, '610500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610600', '延安市', '陕西省·延安市', null, 'Y', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610602', '宝塔区', '陕西省·延安市·宝塔区', null, 'B', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610621', '延长县', '陕西省·延安市·延长县', null, 'Y', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610622', '延川县', '陕西省·延安市·延川县', null, 'Y', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610623', '子长县', '陕西省·延安市·子长县', null, 'Z', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610624', '安塞县', '陕西省·延安市·安塞县', null, 'A', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610625', '志丹县', '陕西省·延安市·志丹县', null, 'Z', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610626', '吴起县', '陕西省·延安市·吴起县', null, 'W', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610627', '甘泉县', '陕西省·延安市·甘泉县', null, 'G', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610628', '富县', '陕西省·延安市·富县', null, 'F', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610629', '洛川县', '陕西省·延安市·洛川县', null, 'L', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610630', '宜川县', '陕西省·延安市·宜川县', null, 'Y', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610631', '黄龙县', '陕西省·延安市·黄龙县', null, 'H', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610632', '黄陵县', '陕西省·延安市·黄陵县', null, 'H', null, null, null, '610600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610700', '汉中市', '陕西省·汉中市', null, 'H', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610702', '汉台区', '陕西省·汉中市·汉台区', null, 'H', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610721', '南郑县', '陕西省·汉中市·南郑县', null, 'N', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610722', '城固县', '陕西省·汉中市·城固县', null, 'C', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610723', '洋县', '陕西省·汉中市·洋县', null, 'Y', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610724', '西乡县', '陕西省·汉中市·西乡县', null, 'X', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610725', '勉县', '陕西省·汉中市·勉县', null, 'M', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610726', '宁强县', '陕西省·汉中市·宁强县', null, 'N', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610727', '略阳县', '陕西省·汉中市·略阳县', null, 'L', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610728', '镇巴县', '陕西省·汉中市·镇巴县', null, 'Z', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610729', '留坝县', '陕西省·汉中市·留坝县', null, 'L', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610730', '佛坪县', '陕西省·汉中市·佛坪县', null, 'P', null, null, null, '610700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610800', '榆林市', '陕西省·榆林市', null, 'Y', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610802', '榆阳区', '陕西省·榆林市·榆阳区', null, 'Y', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610821', '神木县', '陕西省·榆林市·神木县', null, 'S', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610822', '府谷县', '陕西省·榆林市·府谷县', null, 'F', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610823', '横山县', '陕西省·榆林市·横山县', null, 'H', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610824', '靖边县', '陕西省·榆林市·靖边县', null, 'J', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610825', '定边县', '陕西省·榆林市·定边县', null, 'D', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610826', '绥德县', '陕西省·榆林市·绥德县', null, 'S', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610827', '米脂县', '陕西省·榆林市·米脂县', null, 'M', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610828', '佳县', '陕西省·榆林市·佳县', null, 'J', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610829', '吴堡县', '陕西省·榆林市·吴堡县', null, 'W', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610830', '清涧县', '陕西省·榆林市·清涧县', null, 'Q', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610831', '子洲县', '陕西省·榆林市·子洲县', null, 'Z', null, null, null, '610800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610900', '安康市', '陕西省·安康市', null, 'A', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610902', '汉滨区', '陕西省·安康市·汉滨区', null, 'H', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610921', '汉阴县', '陕西省·安康市·汉阴县', null, 'H', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610922', '石泉县', '陕西省·安康市·石泉县', null, 'S', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610923', '宁陕县', '陕西省·安康市·宁陕县', null, 'N', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610924', '紫阳县', '陕西省·安康市·紫阳县', null, 'Z', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610925', '岚皋县', '陕西省·安康市·岚皋县', null, 'L', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610926', '平利县', '陕西省·安康市·平利县', null, 'P', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610927', '镇坪县', '陕西省·安康市·镇坪县', null, 'Z', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610928', '旬阳县', '陕西省·安康市·旬阳县', null, 'X', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('610929', '白河县', '陕西省·安康市·白河县', null, 'B', null, null, null, '610900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611000', '商洛市', '陕西省·商洛市', null, 'S', null, null, null, '610000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611002', '商州区', '陕西省·商洛市·商州区', null, 'S', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611021', '洛南县', '陕西省·商洛市·洛南县', null, 'L', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611022', '丹凤县', '陕西省·商洛市·丹凤县', null, 'D', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611023', '商南县', '陕西省·商洛市·商南县', null, 'S', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611024', '山阳县', '陕西省·商洛市·山阳县', null, 'S', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611025', '镇安县', '陕西省·商洛市·镇安县', null, 'Z', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('611026', '柞水县', '陕西省·商洛市·柞水县', null, 'Z', null, null, null, '611000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620000', '甘肃省', '甘肃省', null, 'G', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620100', '兰州市', '甘肃省·兰州市', null, 'L', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620102', '城关区', '甘肃省·兰州市·城关区', null, 'C', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620103', '七里河区', '甘肃省·兰州市·七里河区', null, 'Q', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620104', '西固区', '甘肃省·兰州市·西固区', null, 'X', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620105', '安宁区', '甘肃省·兰州市·安宁区', null, 'A', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620111', '红古区', '甘肃省·兰州市·红古区', null, 'H', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620121', '永登县', '甘肃省·兰州市·永登县', null, 'Y', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620122', '皋兰县', '甘肃省·兰州市·皋兰县', null, 'G', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620123', '榆中县', '甘肃省·兰州市·榆中县', null, 'Y', null, null, null, '620100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620200', '嘉峪关市', '甘肃省·嘉峪关市', null, 'J', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620300', '金昌市', '甘肃省·金昌市', null, 'J', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620302', '金川区', '甘肃省·金昌市·金川区', null, 'J', null, null, null, '620300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620321', '永昌县', '甘肃省·金昌市·永昌县', null, 'Y', null, null, null, '620300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620400', '白银市', '甘肃省·白银市', null, 'B', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620402', '白银区', '甘肃省·白银市·白银区', null, 'B', null, null, null, '620400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620403', '平川区', '甘肃省·白银市·平川区', null, 'P', null, null, null, '620400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620421', '靖远县', '甘肃省·白银市·靖远县', null, 'J', null, null, null, '620400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620422', '会宁县', '甘肃省·白银市·会宁县', null, 'H', null, null, null, '620400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620423', '景泰县', '甘肃省·白银市·景泰县', null, 'J', null, null, null, '620400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620500', '天水市', '甘肃省·天水市', null, 'T', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620502', '秦州区', '甘肃省·天水市·秦州区', null, 'Q', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620503', '麦积区', '甘肃省·天水市·麦积区', null, 'M', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620521', '清水县', '甘肃省·天水市·清水县', null, 'Q', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620522', '秦安县', '甘肃省·天水市·秦安县', null, 'Q', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620523', '甘谷县', '甘肃省·天水市·甘谷县', null, 'G', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620524', '武山县', '甘肃省·天水市·武山县', null, 'W', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620525', '张家川回族自治县', '甘肃省·天水市·张家川回族自治县', null, 'Z', null, null, null, '620500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620600', '武威市', '甘肃省·武威市', null, 'W', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620602', '凉州区', '甘肃省·武威市·凉州区', null, 'L', null, null, null, '620600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620621', '民勤县', '甘肃省·武威市·民勤县', null, 'M', null, null, null, '620600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620622', '古浪县', '甘肃省·武威市·古浪县', null, 'G', null, null, null, '620600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620623', '天祝藏族自治县', '甘肃省·武威市·天祝藏族自治县', null, 'T', null, null, null, '620600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620700', '张掖市', '甘肃省·张掖市', null, 'Z', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620702', '甘州区', '甘肃省·张掖市·甘州区', null, 'G', null, null, null, '620700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620721', '肃南裕固族自治县', '甘肃省·张掖市·肃南裕固族自治县', null, 'S', null, null, null, '620700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620722', '民乐县', '甘肃省·张掖市·民乐县', null, 'M', null, null, null, '620700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620723', '临泽县', '甘肃省·张掖市·临泽县', null, 'L', null, null, null, '620700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620724', '高台县', '甘肃省·张掖市·高台县', null, 'G', null, null, null, '620700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620725', '山丹县', '甘肃省·张掖市·山丹县', null, 'S', null, null, null, '620700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620800', '平凉市', '甘肃省·平凉市', null, 'P', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620802', '崆峒区', '甘肃省·平凉市·崆峒区', null, 'K', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620821', '泾川县', '甘肃省·平凉市·泾川县', null, 'J', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620822', '灵台县', '甘肃省·平凉市·灵台县', null, 'L', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620823', '崇信县', '甘肃省·平凉市·崇信县', null, 'C', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620824', '华亭县', '甘肃省·平凉市·华亭县', null, 'H', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620825', '庄浪县', '甘肃省·平凉市·庄浪县', null, 'Z', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620826', '静宁县', '甘肃省·平凉市·静宁县', null, 'J', null, null, null, '620800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620900', '酒泉市', '甘肃省·酒泉市', null, 'J', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620902', '肃州区', '甘肃省·酒泉市·肃州区', null, 'S', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620921', '金塔县', '甘肃省·酒泉市·金塔县', null, 'J', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620922', '安西县', '甘肃省·酒泉市·安西县', null, 'A', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620923', '肃北蒙古族自治县', '甘肃省·酒泉市·肃北蒙古族自治县', null, 'S', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620924', '阿克塞哈萨克族自治县', '甘肃省·酒泉市·阿克塞哈萨克族自治县', null, 'A', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620981', '玉门市', '甘肃省·酒泉市·玉门市', null, 'Y', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('620982', '敦煌市', '甘肃省·酒泉市·敦煌市', null, 'D', null, null, null, '620900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621000', '庆阳市', '甘肃省·庆阳市', null, 'Q', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621002', '西峰区', '甘肃省·庆阳市·西峰区', null, 'X', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621021', '庆城县', '甘肃省·庆阳市·庆城县', null, 'Q', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621022', '环县', '甘肃省·庆阳市·环县', null, 'H', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621023', '华池县', '甘肃省·庆阳市·华池县', null, 'H', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621024', '合水县', '甘肃省·庆阳市·合水县', null, 'H', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621025', '正宁县', '甘肃省·庆阳市·正宁县', null, 'Z', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621026', '宁县', '甘肃省·庆阳市·宁县', null, 'N', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621027', '镇原县', '甘肃省·庆阳市·镇原县', null, 'Z', null, null, null, '621000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621100', '定西市', '甘肃省·定西市', null, 'D', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621102', '安定区', '甘肃省·定西市·安定区', null, 'A', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621121', '通渭县', '甘肃省·定西市·通渭县', null, 'T', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621122', '陇西县', '甘肃省·定西市·陇西县', null, 'L', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621123', '渭源县', '甘肃省·定西市·渭源县', null, 'W', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621124', '临洮县', '甘肃省·定西市·临洮县', null, 'L', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621125', '漳县', '甘肃省·定西市·漳县', null, 'Z', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621126', '岷县', '甘肃省·定西市·岷县', null, 'M', null, null, null, '621100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621200', '陇南市', '甘肃省·陇南市', null, 'L', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621202', '武都区', '甘肃省·陇南市·武都区', null, 'W', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621221', '成县', '甘肃省·陇南市·成县', null, 'C', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621222', '文县', '甘肃省·陇南市·文县', null, 'W', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621223', '宕昌县', '甘肃省·陇南市·宕昌县', null, 'D', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621224', '康县', '甘肃省·陇南市·康县', null, 'K', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621225', '西和县', '甘肃省·陇南市·西和县', null, 'X', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621226', '礼县', '甘肃省·陇南市·礼县', null, 'L', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621227', '徽县', '甘肃省·陇南市·徽县', null, 'H', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('621228', '两当县', '甘肃省·陇南市·两当县', null, 'L', null, null, null, '621200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622900', '临夏回族自治州', '甘肃省·临夏回族自治州', null, 'L', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622901', '临夏市', '甘肃省·临夏回族自治州·临夏市', null, 'L', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622921', '临夏县', '甘肃省·临夏回族自治州·临夏县', null, 'L', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622922', '康乐县', '甘肃省·临夏回族自治州·康乐县', null, 'K', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622923', '永靖县', '甘肃省·临夏回族自治州·永靖县', null, 'Y', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622924', '广河县', '甘肃省·临夏回族自治州·广河县', null, 'G', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622925', '和政县', '甘肃省·临夏回族自治州·和政县', null, 'H', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622926', '东乡族自治县', '甘肃省·临夏回族自治州·东乡族自治县', null, 'D', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '甘肃省·临夏回族自治州·积石山保安族东乡族撒拉族自治县', null, 'J', null, null, null, '622900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623000', '甘南藏族自治州', '甘肃省·甘南藏族自治州', null, 'G', null, null, null, '620000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623001', '合作市', '甘肃省·甘南藏族自治州·合作市', null, 'H', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623021', '临潭县', '甘肃省·甘南藏族自治州·临潭县', null, 'L', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623022', '卓尼县', '甘肃省·甘南藏族自治州·卓尼县', null, 'Z', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623023', '舟曲县', '甘肃省·甘南藏族自治州·舟曲县', null, 'Z', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623024', '迭部县', '甘肃省·甘南藏族自治州·迭部县', null, 'D', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623025', '玛曲县', '甘肃省·甘南藏族自治州·玛曲县', null, 'M', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623026', '碌曲县', '甘肃省·甘南藏族自治州·碌曲县', null, 'L', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('623027', '夏河县', '甘肃省·甘南藏族自治州·夏河县', null, 'X', null, null, null, '623000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630000', '青海省', '青海省', null, 'Q', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630100', '西宁市', '青海省·西宁市', null, 'X', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630102', '城东区', '青海省·西宁市·城东区', null, 'C', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630103', '城中区', '青海省·西宁市·城中区', null, 'C', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630104', '城西区', '青海省·西宁市·城西区', null, 'C', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630105', '城北区', '青海省·西宁市·城北区', null, 'C', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630121', '大通回族土族自治县', '青海省·西宁市·大通回族土族自治县', null, 'D', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630122', '湟中县', '青海省·西宁市·湟中县', null, 'H', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('630123', '湟源县', '青海省·西宁市·湟源县', null, 'H', null, null, null, '630100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632100', '海东地区', '青海省·海东地区', null, 'H', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632121', '平安县', '青海省·海东地区·平安县', null, 'P', null, null, null, '632100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632122', '民和回族土族自治县', '青海省·海东地区·民和回族土族自治县', null, 'M', null, null, null, '632100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632123', '乐都县', '青海省·海东地区·乐都县', null, 'L', null, null, null, '632100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632126', '互助土族自治县', '青海省·海东地区·互助土族自治县', null, 'H', null, null, null, '632100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632127', '化隆回族自治县', '青海省·海东地区·化隆回族自治县', null, 'H', null, null, null, '632100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632128', '循化撒拉族自治县', '青海省·海东地区·循化撒拉族自治县', null, 'X', null, null, null, '632100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632200', '海北藏族自治州', '青海省·海北藏族自治州', null, 'H', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632221', '门源回族自治县', '青海省·海北藏族自治州·门源回族自治县', null, 'M', null, null, null, '632200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632222', '祁连县', '青海省·海北藏族自治州·祁连县', null, 'Q', null, null, null, '632200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632223', '海晏县', '青海省·海北藏族自治州·海晏县', null, 'H', null, null, null, '632200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632224', '刚察县', '青海省·海北藏族自治州·刚察县', null, 'G', null, null, null, '632200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632300', '黄南藏族自治州', '青海省·黄南藏族自治州', null, 'H', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632321', '同仁县', '青海省·黄南藏族自治州·同仁县', null, 'T', null, null, null, '632300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632322', '尖扎县', '青海省·黄南藏族自治州·尖扎县', null, 'J', null, null, null, '632300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632323', '泽库县', '青海省·黄南藏族自治州·泽库县', null, 'Z', null, null, null, '632300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632324', '河南蒙古族自治县', '青海省·黄南藏族自治州·河南蒙古族自治县', null, 'H', null, null, null, '632300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632500', '海南藏族自治州', '青海省·海南藏族自治州', null, 'H', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632521', '共和县', '青海省·海南藏族自治州·共和县', null, 'G', null, null, null, '632500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632522', '同德县', '青海省·海南藏族自治州·同德县', null, 'T', null, null, null, '632500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632523', '贵德县', '青海省·海南藏族自治州·贵德县', null, 'G', null, null, null, '632500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632524', '兴海县', '青海省·海南藏族自治州·兴海县', null, 'X', null, null, null, '632500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632525', '贵南县', '青海省·海南藏族自治州·贵南县', null, 'G', null, null, null, '632500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632600', '果洛藏族自治州', '青海省·果洛藏族自治州', null, 'G', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632621', '玛沁县', '青海省·果洛藏族自治州·玛沁县', null, 'M', null, null, null, '632600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632622', '班玛县', '青海省·果洛藏族自治州·班玛县', null, 'B', null, null, null, '632600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632623', '甘德县', '青海省·果洛藏族自治州·甘德县', null, 'G', null, null, null, '632600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632624', '达日县', '青海省·果洛藏族自治州·达日县', null, 'D', null, null, null, '632600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632625', '久治县', '青海省·果洛藏族自治州·久治县', null, 'J', null, null, null, '632600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632626', '玛多县', '青海省·果洛藏族自治州·玛多县', null, 'M', null, null, null, '632600', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632700', '玉树藏族自治州', '青海省·玉树藏族自治州', null, 'Y', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632721', '玉树县', '青海省·玉树藏族自治州·玉树县', null, 'Y', null, null, null, '632700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632722', '杂多县', '青海省·玉树藏族自治州·杂多县', null, 'Z', null, null, null, '632700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632723', '称多县', '青海省·玉树藏族自治州·称多县', null, 'C', null, null, null, '632700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632724', '治多县', '青海省·玉树藏族自治州·治多县', null, 'Z', null, null, null, '632700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632725', '囊谦县', '青海省·玉树藏族自治州·囊谦县', null, 'N', null, null, null, '632700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632726', '曲麻莱县', '青海省·玉树藏族自治州·曲麻莱县', null, 'Q', null, null, null, '632700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632800', '海西蒙古族藏族自治州', '青海省·海西蒙古族藏族自治州', null, 'H', null, null, null, '630000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632801', '格尔木市', '青海省·海西蒙古族藏族自治州·格尔木市', null, 'G', null, null, null, '632800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632802', '德令哈市', '青海省·海西蒙古族藏族自治州·德令哈市', null, 'D', null, null, null, '632800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632821', '乌兰县', '青海省·海西蒙古族藏族自治州·乌兰县', null, 'W', null, null, null, '632800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632822', '都兰县', '青海省·海西蒙古族藏族自治州·都兰县', null, 'D', null, null, null, '632800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('632823', '天峻县', '青海省·海西蒙古族藏族自治州·天峻县', null, 'T', null, null, null, '632800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640000', '宁夏回族自治区', '宁夏回族自治区', null, 'N', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640100', '银川市', '宁夏回族自治区·银川市', null, 'Y', null, null, null, '640000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640104', '兴庆区', '宁夏回族自治区·银川市·兴庆区', null, 'X', null, null, null, '640100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640105', '西夏区', '宁夏回族自治区·银川市·西夏区', null, 'X', null, null, null, '640100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640106', '金凤区', '宁夏回族自治区·银川市·金凤区', null, 'J', null, null, null, '640100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640121', '永宁县', '宁夏回族自治区·银川市·永宁县', null, 'Y', null, null, null, '640100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640122', '贺兰县', '宁夏回族自治区·银川市·贺兰县', null, 'H', null, null, null, '640100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640181', '灵武市', '宁夏回族自治区·银川市·灵武市', null, 'L', null, null, null, '640100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640200', '石嘴山市', '宁夏回族自治区·石嘴山市', null, 'S', null, null, null, '640000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640202', '大武口区', '宁夏回族自治区·石嘴山市·大武口区', null, 'D', null, null, null, '640200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640205', '惠农区', '宁夏回族自治区·石嘴山市·惠农区', null, 'H', null, null, null, '640200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640221', '平罗县', '宁夏回族自治区·石嘴山市·平罗县', null, 'P', null, null, null, '640200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640300', '吴忠市', '宁夏回族自治区·吴忠市', null, 'W', null, null, null, '640000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640302', '利通区', '宁夏回族自治区·吴忠市·利通区', null, 'L', null, null, null, '640300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640303', '红寺堡区', '宁夏回族自治区·吴忠市·红寺堡区', null, 'H', null, null, null, '640300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640323', '盐池县', '宁夏回族自治区·吴忠市·盐池县', null, 'Y', null, null, null, '640300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640324', '同心县', '宁夏回族自治区·吴忠市·同心县', null, 'T', null, null, null, '640300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640381', '青铜峡市', '宁夏回族自治区·吴忠市·青铜峡市', null, 'Q', null, null, null, '640300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640400', '固原市', '宁夏回族自治区·固原市', null, 'G', null, null, null, '640000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640402', '原州区', '宁夏回族自治区·固原市·原州区', null, 'Y', null, null, null, '640400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640422', '西吉县', '宁夏回族自治区·固原市·西吉县', null, 'X', null, null, null, '640400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640423', '隆德县', '宁夏回族自治区·固原市·隆德县', null, 'L', null, null, null, '640400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640424', '泾源县', '宁夏回族自治区·固原市·泾源县', null, 'J', null, null, null, '640400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640425', '彭阳县', '宁夏回族自治区·固原市·彭阳县', null, 'P', null, null, null, '640400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640500', '中卫市', '宁夏回族自治区·中卫市', null, 'Z', null, null, null, '640000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640502', '沙坡头区', '宁夏回族自治区·中卫市·沙坡头区', null, 'S', null, null, null, '640500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640521', '中宁县', '宁夏回族自治区·中卫市·中宁县', null, 'Z', null, null, null, '640500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('640522', '海原县', '宁夏回族自治区·中卫市·海原县', null, 'H', null, null, null, '640500', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650000', '新疆维吾尔自治区', '新疆维吾尔自治区', null, 'X', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650100', '乌鲁木齐市', '新疆维吾尔自治区·乌鲁木齐市', null, 'W', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650102', '天山区', '新疆维吾尔自治区·乌鲁木齐市·天山区', null, 'T', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650103', '沙依巴克区', '新疆维吾尔自治区·乌鲁木齐市·沙依巴克区', null, 'S', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650104', '新市区', '新疆维吾尔自治区·乌鲁木齐市·新市区', null, 'X', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650105', '水磨沟区', '新疆维吾尔自治区·乌鲁木齐市·水磨沟区', null, 'S', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650106', '头屯河区', '新疆维吾尔自治区·乌鲁木齐市·头屯河区', null, 'T', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650107', '达坂城区', '新疆维吾尔自治区·乌鲁木齐市·达坂城区', null, 'D', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650108', '东山区', '新疆维吾尔自治区·乌鲁木齐市·东山区', null, 'D', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650109', '米东区', '新疆维吾尔自治区·乌鲁木齐市·米东区', null, 'M', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650121', '乌鲁木齐县', '新疆维吾尔自治区·乌鲁木齐市·乌鲁木齐县', null, 'W', null, null, null, '650100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650200', '克拉玛依市', '新疆维吾尔自治区·克拉玛依市', null, 'K', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650202', '独山子区', '新疆维吾尔自治区·克拉玛依市·独山子区', null, 'D', null, null, null, '650200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650203', '克拉玛依区', '新疆维吾尔自治区·克拉玛依市·克拉玛依区', null, 'K', null, null, null, '650200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650204', '白碱滩区', '新疆维吾尔自治区·克拉玛依市·白碱滩区', null, 'B', null, null, null, '650200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('650205', '乌尔禾区', '新疆维吾尔自治区·克拉玛依市·乌尔禾区', null, 'W', null, null, null, '650200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652100', '吐鲁番地区', '新疆维吾尔自治区·吐鲁番地区', null, 'T', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652101', '吐鲁番市', '新疆维吾尔自治区·吐鲁番地区·吐鲁番市', null, 'T', null, null, null, '652100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652122', '鄯善县', '新疆维吾尔自治区·吐鲁番地区·鄯善县', null, 'S', null, null, null, '652100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652123', '托克逊县', '新疆维吾尔自治区·吐鲁番地区·托克逊县', null, 'T', null, null, null, '652100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652200', '哈密地区', '新疆维吾尔自治区·哈密地区', null, 'H', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652201', '哈密市', '新疆维吾尔自治区·哈密地区·哈密市', null, 'H', null, null, null, '652200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652222', '巴里坤哈萨克自治县', '新疆维吾尔自治区·哈密地区·巴里坤哈萨克自治县', null, 'B', null, null, null, '652200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652223', '伊吾县', '新疆维吾尔自治区·哈密地区·伊吾县', null, 'Y', null, null, null, '652200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652300', '昌吉回族自治州', '新疆维吾尔自治区·昌吉回族自治州', null, 'C', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652301', '昌吉市', '新疆维吾尔自治区·昌吉回族自治州·昌吉市', null, 'C', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652302', '阜康市', '新疆维吾尔自治区·昌吉回族自治州·阜康市', null, 'F', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652303', '米泉市', '新疆维吾尔自治区·昌吉回族自治州·米泉市', null, 'M', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652323', '呼图壁县', '新疆维吾尔自治区·昌吉回族自治州·呼图壁县', null, 'H', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652324', '玛纳斯县', '新疆维吾尔自治区·昌吉回族自治州·玛纳斯县', null, 'M', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652325', '奇台县', '新疆维吾尔自治区·昌吉回族自治州·奇台县', null, 'Q', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652327', '吉木萨尔县', '新疆维吾尔自治区·昌吉回族自治州·吉木萨尔县', null, 'J', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652328', '木垒哈萨克自治县', '新疆维吾尔自治区·昌吉回族自治州·木垒哈萨克自治县', null, 'M', null, null, null, '652300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652700', '博尔塔拉蒙古自治州', '新疆维吾尔自治区·博尔塔拉蒙古自治州', null, 'B', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652701', '博乐市', '新疆维吾尔自治区·博尔塔拉蒙古自治州·博乐市', null, 'B', null, null, null, '652700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652722', '精河县', '新疆维吾尔自治区·博尔塔拉蒙古自治州·精河县', null, 'J', null, null, null, '652700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652723', '温泉县', '新疆维吾尔自治区·博尔塔拉蒙古自治州·温泉县', null, 'W', null, null, null, '652700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652800', '巴音郭楞蒙古自治州', '新疆维吾尔自治区·巴音郭楞蒙古自治州', null, 'B', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652801', '库尔勒市', '新疆维吾尔自治区·巴音郭楞蒙古自治州·库尔勒市', null, 'K', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652822', '轮台县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·轮台县', null, 'L', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652823', '尉犁县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·尉犁县', null, 'W', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652824', '若羌县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·若羌县', null, 'R', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652825', '且末县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·且末县', null, 'Q', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652826', '焉耆回族自治县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·焉耆回族自治县', null, 'Y', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652827', '和静县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·和静县', null, 'H', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652828', '和硕县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·和硕县', null, 'H', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652829', '博湖县', '新疆维吾尔自治区·巴音郭楞蒙古自治州·博湖县', null, 'B', null, null, null, '652800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652900', '阿克苏地区', '新疆维吾尔自治区·阿克苏地区', null, 'A', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652901', '阿克苏市', '新疆维吾尔自治区·阿克苏地区·阿克苏市', null, 'A', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652922', '温宿县', '新疆维吾尔自治区·阿克苏地区·温宿县', null, 'W', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652923', '库车县', '新疆维吾尔自治区·阿克苏地区·库车县', null, 'K', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652924', '沙雅县', '新疆维吾尔自治区·阿克苏地区·沙雅县', null, 'S', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652925', '新和县', '新疆维吾尔自治区·阿克苏地区·新和县', null, 'X', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652926', '拜城县', '新疆维吾尔自治区·阿克苏地区·拜城县', null, 'B', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652927', '乌什县', '新疆维吾尔自治区·阿克苏地区·乌什县', null, 'W', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652928', '阿瓦提县', '新疆维吾尔自治区·阿克苏地区·阿瓦提县', null, 'A', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('652929', '柯坪县', '新疆维吾尔自治区·阿克苏地区·柯坪县', null, 'K', null, null, null, '652900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '新疆维吾尔自治区·克孜勒苏柯尔克孜自治州', null, 'K', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653001', '阿图什市', '新疆维吾尔自治区·克孜勒苏柯尔克孜自治州·阿图什市', null, 'A', null, null, null, '653000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653022', '阿克陶县', '新疆维吾尔自治区·克孜勒苏柯尔克孜自治州·阿克陶县', null, 'A', null, null, null, '653000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653023', '阿合奇县', '新疆维吾尔自治区·克孜勒苏柯尔克孜自治州·阿合奇县', null, 'A', null, null, null, '653000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653024', '乌恰县', '新疆维吾尔自治区·克孜勒苏柯尔克孜自治州·乌恰县', null, 'W', null, null, null, '653000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653100', '喀什地区', '新疆维吾尔自治区·喀什地区', null, 'K', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653101', '喀什市', '新疆维吾尔自治区·喀什地区·喀什市', null, 'K', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653121', '疏附县', '新疆维吾尔自治区·喀什地区·疏附县', null, 'S', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653122', '疏勒县', '新疆维吾尔自治区·喀什地区·疏勒县', null, 'S', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653123', '英吉沙县', '新疆维吾尔自治区·喀什地区·英吉沙县', null, 'Y', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653124', '泽普县', '新疆维吾尔自治区·喀什地区·泽普县', null, 'Z', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653125', '莎车县', '新疆维吾尔自治区·喀什地区·莎车县', null, 'S', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653126', '叶城县', '新疆维吾尔自治区·喀什地区·叶城县', null, 'Y', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653127', '麦盖提县', '新疆维吾尔自治区·喀什地区·麦盖提县', null, 'M', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653128', '岳普湖县', '新疆维吾尔自治区·喀什地区·岳普湖县', null, 'Y', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653129', '伽师县', '新疆维吾尔自治区·喀什地区·伽师县', null, 'G', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653130', '巴楚县', '新疆维吾尔自治区·喀什地区·巴楚县', null, 'B', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653131', '塔什库尔干塔吉克自治县', '新疆维吾尔自治区·喀什地区·塔什库尔干塔吉克自治县', null, 'T', null, null, null, '653100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653200', '和田地区', '新疆维吾尔自治区·和田地区', null, 'H', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653201', '和田市', '新疆维吾尔自治区·和田地区·和田市', null, 'H', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653221', '和田县', '新疆维吾尔自治区·和田地区·和田县', null, 'H', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653222', '墨玉县', '新疆维吾尔自治区·和田地区·墨玉县', null, 'M', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653223', '皮山县', '新疆维吾尔自治区·和田地区·皮山县', null, 'P', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653224', '洛浦县', '新疆维吾尔自治区·和田地区·洛浦县', null, 'L', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653225', '策勒县', '新疆维吾尔自治区·和田地区·策勒县', null, 'C', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653226', '于田县', '新疆维吾尔自治区·和田地区·于田县', null, 'Y', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('653227', '民丰县', '新疆维吾尔自治区·和田地区·民丰县', null, 'M', null, null, null, '653200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654000', '伊犁哈萨克自治州', '新疆维吾尔自治区·伊犁哈萨克自治州', null, 'Y', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654002', '伊宁市', '新疆维吾尔自治区·伊犁哈萨克自治州·伊宁市', null, 'Y', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654003', '奎屯市', '新疆维吾尔自治区·伊犁哈萨克自治州·奎屯市', null, 'K', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654021', '伊宁县', '新疆维吾尔自治区·伊犁哈萨克自治州·伊宁县', null, 'Y', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654022', '察布查尔锡伯自治县', '新疆维吾尔自治区·伊犁哈萨克自治州·察布查尔锡伯自治县', null, 'C', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654023', '霍城县', '新疆维吾尔自治区·伊犁哈萨克自治州·霍城县', null, 'H', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654024', '巩留县', '新疆维吾尔自治区·伊犁哈萨克自治州·巩留县', null, 'G', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654025', '新源县', '新疆维吾尔自治区·伊犁哈萨克自治州·新源县', null, 'X', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654026', '昭苏县', '新疆维吾尔自治区·伊犁哈萨克自治州·昭苏县', null, 'Z', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654027', '特克斯县', '新疆维吾尔自治区·伊犁哈萨克自治州·特克斯县', null, 'T', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654028', '尼勒克县', '新疆维吾尔自治区·伊犁哈萨克自治州·尼勒克县', null, 'N', null, null, null, '654000', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654200', '塔城地区', '新疆维吾尔自治区·塔城地区', null, 'T', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654201', '塔城市', '新疆维吾尔自治区·塔城地区·塔城市', null, 'T', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654202', '乌苏市', '新疆维吾尔自治区·塔城地区·乌苏市', null, 'W', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654221', '额敏县', '新疆维吾尔自治区·塔城地区·额敏县', null, 'E', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654223', '沙湾县', '新疆维吾尔自治区·塔城地区·沙湾县', null, 'S', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654224', '托里县', '新疆维吾尔自治区·塔城地区·托里县', null, 'T', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654225', '裕民县', '新疆维吾尔自治区·塔城地区·裕民县', null, 'Y', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654226', '和布克赛尔蒙古自治县', '新疆维吾尔自治区·塔城地区·和布克赛尔蒙古自治县', null, 'H', null, null, null, '654200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654300', '阿勒泰地区', '新疆维吾尔自治区·阿勒泰地区', null, 'A', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654301', '阿勒泰市', '新疆维吾尔自治区·阿勒泰地区·阿勒泰市', null, 'A', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654321', '布尔津县', '新疆维吾尔自治区·阿勒泰地区·布尔津县', null, 'B', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654322', '富蕴县', '新疆维吾尔自治区·阿勒泰地区·富蕴县', null, 'F', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654323', '福海县', '新疆维吾尔自治区·阿勒泰地区·福海县', null, 'F', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654324', '哈巴河县', '新疆维吾尔自治区·阿勒泰地区·哈巴河县', null, 'H', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654325', '青河县', '新疆维吾尔自治区·阿勒泰地区·青河县', null, 'Q', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('654326', '吉木乃县', '新疆维吾尔自治区·阿勒泰地区·吉木乃县', null, 'J', null, null, null, '654300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('659001', '石河子市', '新疆维吾尔自治区·石河子市', null, 'S', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('659002', '阿拉尔市', '新疆维吾尔自治区·阿拉尔市', null, 'A', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('659003', '图木舒克市', '新疆维吾尔自治区·图木舒克市', null, 'T', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('659004', '五家渠市', '新疆维吾尔自治区·五家渠市', null, 'W', null, null, null, '650000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710000', '台湾省', '台湾省', null, 'T', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710100', '台北市', '台湾省·台北市', null, 'T', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710101', '中正区', '台湾省·台北市·中正区', null, 'Z', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710102', '大同区', '台湾省·台北市·大同区', null, 'D', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710103', '中山区', '台湾省·台北市·中山区', null, 'Z', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710104', '松山区', '台湾省·台北市·松山区', null, 'S', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710105', '大安区', '台湾省·台北市·大安区', null, 'D', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710106', '万华区', '台湾省·台北市·万华区', null, 'W', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710107', '信义区', '台湾省·台北市·信义区', null, 'X', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710108', '士林区', '台湾省·台北市·士林区', null, 'S', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710109', '北投区', '台湾省·台北市·北投区', null, 'B', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710110', '内湖区', '台湾省·台北市·内湖区', null, 'N', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710111', '南港区', '台湾省·台北市·南港区', null, 'N', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710112', '文山区', '台湾省·台北市·文山区', null, 'W', null, null, null, '710100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710200', '高雄市', '台湾省·高雄市', null, 'G', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710201', '新兴区', '台湾省·高雄市·新兴区', null, 'X', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710202', '前金区', '台湾省·高雄市·前金区', null, 'Q', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710203', '芩雅区', '台湾省·高雄市·芩雅区', null, 'Q', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710204', '盐埕区', '台湾省·高雄市·盐埕区', null, 'Y', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710205', '鼓山区', '台湾省·高雄市·鼓山区', null, 'G', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710206', '旗津区', '台湾省·高雄市·旗津区', null, 'Q', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710207', '前镇区', '台湾省·高雄市·前镇区', null, 'Q', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710208', '三民区', '台湾省·高雄市·三民区', null, 'S', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710209', '左营区', '台湾省·高雄市·左营区', null, 'Z', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710210', '楠梓区', '台湾省·高雄市·楠梓区', null, 'N', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710211', '小港区', '台湾省·高雄市·小港区', null, 'X', null, null, null, '710200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710300', '台南市', '台湾省·台南市', null, 'T', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710301', '中西区', '台湾省·台南市·中西区', null, 'Z', null, null, null, '710300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710302', '东区', '台湾省·台南市·东区', null, 'D', null, null, null, '710300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710303', '南区', '台湾省·台南市·南区', null, 'N', null, null, null, '710300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710304', '北区', '台湾省·台南市·北区', null, 'B', null, null, null, '710300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710305', '安平区', '台湾省·台南市·安平区', null, 'A', null, null, null, '710300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710306', '安南区', '台湾省·台南市·安南区', null, 'A', null, null, null, '710300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710400', '台中市', '台湾省·台中市', null, 'T', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710401', '中区', '台湾省·台中市·中区', null, 'Z', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710402', '东区', '台湾省·台中市·东区', null, 'D', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710403', '南区', '台湾省·台中市·南区', null, 'N', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710404', '西区', '台湾省·台中市·西区', null, 'X', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710405', '北区', '台湾省·台中市·北区', null, 'B', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710406', '北屯区', '台湾省·台中市·北屯区', null, 'B', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710407', '西屯区', '台湾省·台中市·西屯区', null, 'X', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710408', '南屯区', '台湾省·台中市·南屯区', null, 'N', null, null, null, '710400', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710500', '金门县', '台湾省·金门县', null, 'J', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710600', '南投县', '台湾省·南投县', null, 'N', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710700', '基隆市', '台湾省·基隆市', null, 'J', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710701', '仁爱区', '台湾省·基隆市·仁爱区', null, 'R', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710702', '信义区', '台湾省·基隆市·信义区', null, 'X', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710703', '中正区', '台湾省·基隆市·中正区', null, 'Z', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710704', '中山区', '台湾省·基隆市·中山区', null, 'Z', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710705', '安乐区', '台湾省·基隆市·安乐区', null, 'A', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710706', '暖暖区', '台湾省·基隆市·暖暖区', null, 'N', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710707', '七堵区', '台湾省·基隆市·七堵区', null, 'Q', null, null, null, '710700', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710800', '新竹市', '台湾省·新竹市', null, 'X', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710801', '东区', '台湾省·新竹市·东区', null, 'D', null, null, null, '710800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710802', '北区', '台湾省·新竹市·北区', null, 'B', null, null, null, '710800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710803', '香山区', '台湾省·新竹市·香山区', null, 'X', null, null, null, '710800', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710900', '嘉义市', '台湾省·嘉义市', null, 'J', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710901', '东区', '台湾省·嘉义市·东区', null, 'D', null, null, null, '710900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('710902', '西区', '台湾省·嘉义市·西区', null, 'X', null, null, null, '710900', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711100', '新北市', '台湾省·新北市', null, 'X', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711200', '宜兰县', '台湾省·宜兰县', null, 'Y', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711300', '新竹县', '台湾省·新竹县', null, 'X', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711400', '桃园县', '台湾省·桃园县', null, 'T', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711500', '苗栗县', '台湾省·苗栗县', null, 'M', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711700', '彰化县', '台湾省·彰化县', null, 'Z', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('711900', '嘉义县', '台湾省·嘉义县', null, 'J', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('712100', '云林县', '台湾省·云林县', null, 'Y', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('712400', '屏东县', '台湾省·屏东县', null, 'P', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('712500', '台东县', '台湾省·台东县', null, 'T', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('712600', '花莲县', '台湾省·花莲县', null, 'H', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('712700', '澎湖县', '台湾省·澎湖县', null, 'P', null, null, null, '710000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810000', '香港特别行政区', '香港特别行政区', null, 'X', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810100', '香港岛', '香港特别行政区·香港岛', null, 'X', null, null, null, '810000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810101', '中西区', '香港特别行政区·香港岛·中西区', null, 'Z', null, null, null, '810100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810102', '湾仔', '香港特别行政区·香港岛·湾仔', null, 'W', null, null, null, '810100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810103', '东区', '香港特别行政区·香港岛·东区', null, 'D', null, null, null, '810100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810104', '南区', '香港特别行政区·香港岛·南区', null, 'N', null, null, null, '810100', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810200', '九龙', '香港特别行政区·九龙', null, 'J', null, null, null, '810000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810201', '九龙城区', '香港特别行政区·九龙·九龙城区', null, 'J', null, null, null, '810200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810202', '油尖旺区', '香港特别行政区·九龙·油尖旺区', null, 'Y', null, null, null, '810200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810203', '深水埗区', '香港特别行政区·九龙·深水埗区', null, '', null, null, null, '810200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810204', '黄大仙区', '香港特别行政区·九龙·黄大仙区', null, 'H', null, null, null, '810200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810205', '观塘区', '香港特别行政区·九龙·观塘区', null, 'G', null, null, null, '810200', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810300', '新界', '香港特别行政区·新界', null, 'X', null, null, null, '810000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810301', '北区', '香港特别行政区·新界·北区', null, 'B', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810302', '大埔区', '香港特别行政区·新界·大埔区', null, 'D', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810303', '沙田区', '香港特别行政区·新界·沙田区', null, 'S', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810304', '西贡区', '香港特别行政区·新界·西贡区', null, 'X', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810305', '元朗区', '香港特别行政区·新界·元朗区', null, 'Y', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810306', '屯门区', '香港特别行政区·新界·屯门区', null, 'T', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810307', '荃湾区', '香港特别行政区·新界·荃湾区', null, 'Q', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810308', '葵青区', '香港特别行政区·新界·葵青区', null, 'K', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('810309', '离岛区', '香港特别行政区·新界·离岛区', null, 'L', null, null, null, '810300', '3', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('820000', '澳门特别行政区', '澳门特别行政区', null, 'A', null, null, null, '1', '1', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('820100', '澳门半岛', '澳门特别行政区·澳门半岛', null, 'A', null, null, null, '820000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('820200', '离岛', '澳门特别行政区·离岛', null, 'L', null, null, null, '820000', '2', null, '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('110102001', '123', '北京·北京市·西城区·123', null, null, null, null, null, '110102', '4', '测试下', '1466753282', '1466753282', '1');
INSERT INTO `pad_city_info` VALUES ('110108001', '中关村', '北京·北京市·海淀区·中关村', null, null, null, null, null, '110108', '4', '中关村硅谷基地', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('130103001', '123', '河北省·石家庄市·桥东区·123', null, null, null, null, null, '130103', '4', '测试下', '1466753272', '1466753272', '1');
INSERT INTO `pad_city_info` VALUES ('230102001', '道里区', '黑龙江省·哈尔滨市·道里区·道里区', null, null, null, null, null, '230102', '4', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('420111001', '光谷', '湖北省·武汉市·洪山区·光谷', null, null, null, null, null, '420111', '4', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('431022001', '', '湖南省·郴州市·宜章县·', null, null, null, null, null, '431022', '4', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440303001', '布心', '广东省·深圳市·罗湖区·布心', null, null, null, null, null, '440303', '4', '', '1469674186', '1469674186', '1');
INSERT INTO `pad_city_info` VALUES ('440303002', '水库', '广东省·深圳市·罗湖区·水库', null, null, null, null, null, '440303', '4', '', '1469674393', '1469674393', '1');
INSERT INTO `pad_city_info` VALUES ('440303003', '翠竹', '广东省·深圳市·罗湖区·翠竹', null, null, null, null, null, '440303', '4', '', '1469674400', '1469674400', '1');
INSERT INTO `pad_city_info` VALUES ('440304001', '华强北', '广东省·深圳市·福田区·华强北', '', 'G', '', '', '', '440304', '4', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440304002', '欢乐海岸', '广东省·深圳市·福田区·欢乐海岸', null, null, null, null, null, '440304', '4', '欢乐海岸商圈', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440305001', '前海自贸区', '广东省·深圳市·南山区·前海自贸区', null, null, null, null, null, '440305', '4', '前海自贸区商圈', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440305002', '蛇口', '广东省·深圳市·南山区·蛇口', null, null, null, null, null, '440305', '4', '蛇口自贸区', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440305003', '南油', '广东省·深圳市·南山区·南油', null, null, null, null, null, '440305', '4', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440305004', '前海', '广东省·深圳市·南山区·前海', null, null, null, null, null, '440305', '4', '', '0', '0', '1');
INSERT INTO `pad_city_info` VALUES ('440305005', '科技园', '广东省·深圳市·南山区·科技园', null, null, null, null, null, '440305', '4', '', '1469604484', '1469604484', '1');
INSERT INTO `pad_city_info` VALUES ('440306001', '海雅缤纷城', '广东省·深圳市·宝安区·海雅缤纷城', null, null, null, null, null, '440306', '4', '', '1469584349', '1469584349', '1');
INSERT INTO `pad_city_info` VALUES ('440314001', '清湖', '·清湖', null, null, null, null, null, '440314', '4', '', '1469608337', '1469608337', '1');
INSERT INTO `pad_city_info` VALUES ('440314002', '民治', '·民治', null, null, null, null, null, '440314', '4', '', '1469608344', '1469608344', '1');
INSERT INTO `pad_city_info` VALUES ('440314003', '坂田', '·坂田', null, null, null, null, null, '440314', '4', '', '1469608351', '1469608351', '1');
INSERT INTO `pad_city_info` VALUES ('440403001', '珠海测试商圈', '广东省·珠海市·斗门区·珠海测试商圈', null, null, null, null, null, '440403', '4', '测试商圈', '1464832990', '1464832990', '1');

-- ----------------------------
-- Table structure for `pad_config_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_config_info`;
CREATE TABLE `pad_config_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `conf_name` varchar(30) NOT NULL COMMENT '配置名称',
  `conf_code` char(10) NOT NULL COMMENT '配置编码',
  `conf_value` varchar(255) DEFAULT NULL COMMENT '配置内容',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息 1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `conf_code_index` (`conf_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='派锋平台配置信息表';

-- ----------------------------
-- Records of pad_config_info
-- ----------------------------
INSERT INTO `pad_config_info` VALUES ('1', 'pad_pic_path', 'PIC_PATH', '/', '1');

-- ----------------------------
-- Table structure for `pad_feedback_answer`
-- ----------------------------
DROP TABLE IF EXISTS `pad_feedback_answer`;
CREATE TABLE `pad_feedback_answer` (
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷ID',
  `option_id` int(10) unsigned DEFAULT '0' COMMENT '选项ID',
  `answer_content` varchar(255) DEFAULT NULL COMMENT '答案内容',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  KEY `subject_id_index` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='选择题答案信息';

-- ----------------------------
-- Records of pad_feedback_answer
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_feedback_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_feedback_info`;
CREATE TABLE `pad_feedback_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `topic_quantity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '题目数量',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息 1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='服务意见反馈信息';

-- ----------------------------
-- Records of pad_feedback_info
-- ----------------------------
INSERT INTO `pad_feedback_info` VALUES ('1', '1', '3', '1478748693', '1478748693', '1');

-- ----------------------------
-- Table structure for `pad_feedback_option`
-- ----------------------------
DROP TABLE IF EXISTS `pad_feedback_option`;
CREATE TABLE `pad_feedback_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '选项ID',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷ID',
  `option_name` varchar(30) NOT NULL COMMENT '选项名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='反馈题目选项内容信息';

-- ----------------------------
-- Records of pad_feedback_option
-- ----------------------------
INSERT INTO `pad_feedback_option` VALUES ('1', '1', '选项A');
INSERT INTO `pad_feedback_option` VALUES ('2', '1', '选项B');
INSERT INTO `pad_feedback_option` VALUES ('3', '1', '选项C');
INSERT INTO `pad_feedback_option` VALUES ('4', '1', '选项D');
INSERT INTO `pad_feedback_option` VALUES ('5', '2', '还算满意');
INSERT INTO `pad_feedback_option` VALUES ('6', '2', '比较满意');
INSERT INTO `pad_feedback_option` VALUES ('7', '2', '满意');
INSERT INTO `pad_feedback_option` VALUES ('8', '2', '非常满意');

-- ----------------------------
-- Table structure for `pad_feedback_subject`
-- ----------------------------
DROP TABLE IF EXISTS `pad_feedback_subject`;
CREATE TABLE `pad_feedback_subject` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '问卷ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID(当酒店ID为0时，则是平台添加内容)',
  `title` varchar(200) NOT NULL COMMENT '问卷标题',
  `subject_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '问卷类型 1:选择题,2:填空题',
  `feedback_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_sort` int(10) unsigned DEFAULT '0' COMMENT '问卷排序',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '问卷状态 1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='反馈问卷定义信息';

-- ----------------------------
-- Records of pad_feedback_subject
-- ----------------------------
INSERT INTO `pad_feedback_subject` VALUES ('1', '1', '本次酒店入住评价xxxxxx', '1', '1', '1478748693', '1478748693', '1', '1');
INSERT INTO `pad_feedback_subject` VALUES ('2', '1', '你对酒店服务满意度。', '1', '1', '1478748693', '1478748693', '2', '1');
INSERT INTO `pad_feedback_subject` VALUES ('3', '1', '您对话机使用的建议？', '2', '1', '1478748693', '1478748693', '3', '1');

-- ----------------------------
-- Table structure for `pad_floor_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_floor_info`;
CREATE TABLE `pad_floor_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '楼层ID',
  `floor_name` char(32) NOT NULL COMMENT '楼层名称',
  `floor_code` char(10) DEFAULT NULL COMMENT '楼层编号',
  `room_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间数量',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `build_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼宇ID',
  `floor_remark` varchar(255) DEFAULT NULL COMMENT '楼层备注',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '关于楼层状态信息，1:启用,2:停用,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='酒店楼层信息';

-- ----------------------------
-- Records of pad_floor_info
-- ----------------------------
INSERT INTO `pad_floor_info` VALUES ('1', '一楼', 'F001', '1', '1', '1', null, '1');
INSERT INTO `pad_floor_info` VALUES ('2', '二楼', 'F002', '1', '1', '1', null, '1');
INSERT INTO `pad_floor_info` VALUES ('3', '三楼', 'F003', '1', '1', '1', null, '1');

-- ----------------------------
-- Table structure for `pad_goods_category`
-- ----------------------------
DROP TABLE IF EXISTS `pad_goods_category`;
CREATE TABLE `pad_goods_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类ID',
  `category_name` varchar(30) NOT NULL COMMENT '分类名称',
  `category_desc` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `data_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分类排序',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '分类状态,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类信息表';

-- ----------------------------
-- Records of pad_goods_category
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_goods_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_goods_info`;
CREATE TABLE `pad_goods_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `goods_name` varchar(30) CHARACTER SET utf32 NOT NULL COMMENT '商品名称',
  `goods_desc` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `goods_price` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '商品售价,单位为分',
  `goods_stock` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品库存',
  `original_cost` varchar(9) NOT NULL DEFAULT '0.00' COMMENT '商品原价,展示用',
  `goods_pic` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `cate_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类ID',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '商品状态,1:上架,2:下架,99:删除',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品基础信息表';

-- ----------------------------
-- Records of pad_goods_info
-- ----------------------------
INSERT INTO `pad_goods_info` VALUES ('1', 'test', 'test', '0', '0', '0.00', '12', '0', '1');

-- ----------------------------
-- Table structure for `pad_goods_match`
-- ----------------------------
DROP TABLE IF EXISTS `pad_goods_match`;
CREATE TABLE `pad_goods_match` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配对ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `match_code` varchar(12) NOT NULL COMMENT '配对编号',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息 1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品编号配对信息表';

-- ----------------------------
-- Records of pad_goods_match
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_goods_promotion`
-- ----------------------------
DROP TABLE IF EXISTS `pad_goods_promotion`;
CREATE TABLE `pad_goods_promotion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '促销ID',
  `promotion_name` varchar(30) NOT NULL COMMENT '促销名称',
  `data_sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '页面排列号',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '促销状态,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品促销信息表';

-- ----------------------------
-- Records of pad_goods_promotion
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_goods_shelves`
-- ----------------------------
DROP TABLE IF EXISTS `pad_goods_shelves`;
CREATE TABLE `pad_goods_shelves` (
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `up_shelves` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后上架时间',
  `down_shelves` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后下架时间',
  `data_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息 1:上架,2:下架,99:删除',
  UNIQUE KEY `hotel_goods_index` (`hotel_id`,`goods_id`) COMMENT '酒店上架商品索引',
  KEY `hotel_id` (`hotel_id`) COMMENT '酒店ID索引',
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品上架信息表';

-- ----------------------------
-- Records of pad_goods_shelves
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_hotel_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_hotel_info`;
CREATE TABLE `pad_hotel_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '酒店ID',
  `hotel_code` char(5) NOT NULL COMMENT '酒店编码',
  `group_code` varchar(10) NOT NULL COMMENT '对应客户集团编码',
  `customer_code` varchar(10) NOT NULL COMMENT '对应客户酒店编码',
  `hotel_name` varchar(50) NOT NULL COMMENT '酒店名称',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `interface_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '接口类型 1：西软XMS 2：西软X系列  3：西软SMART系列',
  `interface_url` varchar(255) DEFAULT NULL COMMENT '接口地址',
  `para1` varchar(100) DEFAULT NULL COMMENT '参数一, interface_type=1：CMMCODE',
  `para2` varchar(100) DEFAULT NULL COMMENT '参数二, interface_type=1：PCCODE',
  `para3` varchar(100) DEFAULT NULL COMMENT '参数三, interface_type=1：SECRET',
  `para4` varchar(100) DEFAULT NULL COMMENT '参数四, interface_type=1：APPKEY',
  `contacts` varchar(10) DEFAULT NULL COMMENT '联系人',
  `contact_way` varchar(20) DEFAULT NULL COMMENT '联系方式',
  `province_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行政区ID',
  `address` varchar(50) DEFAULT NULL COMMENT '商户地址',
  `logo_path` varchar(255) DEFAULT NULL COMMENT '商户图片',
  `adver_number` tinyint(1) NOT NULL DEFAULT '0' COMMENT '广告位数量,0为不开放,最大量为6',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '酒店状态, 1: 有效, 2: 无效, 99: 删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hotel_code_index` (`hotel_code`) COMMENT '酒店编码索引'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='酒店基础信息表';

-- ----------------------------
-- Records of pad_hotel_info
-- ----------------------------
INSERT INTO `pad_hotel_info` VALUES ('1', '10001', 'G000001', 'H000001', '派锋国际酒店', '1', '1', 'http://xop.test.foxhis.com/xmsopen-web/rest', 'WEB', '5101', 'GtRvhZw6kTv2wd0mi15', 'PFKJ', 'xxx', 'xxxxxxxx', '1', '1', '1', 'xxxxxxxxxxxx', 'xxxxxx', '5', '1478657775', '1478657775', '1');

-- ----------------------------
-- Table structure for `pad_hotel_service`
-- ----------------------------
DROP TABLE IF EXISTS `pad_hotel_service`;
CREATE TABLE `pad_hotel_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '酒店服务ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `pic_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '图片数量',
  `data_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='酒店服务指南基础信息';

-- ----------------------------
-- Records of pad_hotel_service
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_hotel_service_pic`
-- ----------------------------
DROP TABLE IF EXISTS `pad_hotel_service_pic`;
CREATE TABLE `pad_hotel_service_pic` (
  `service_id` int(11) NOT NULL COMMENT '酒店服务ID',
  `pic_path` varchar(255) NOT NULL COMMENT '图片地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='酒店服务指南图片信息';

-- ----------------------------
-- Records of pad_hotel_service_pic
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_hotel_type`
-- ----------------------------
DROP TABLE IF EXISTS `pad_hotel_type`;
CREATE TABLE `pad_hotel_type` (
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商户类型ID',
  UNIQUE KEY `hotel_type_index` (`hotel_id`,`type_id`) COMMENT '酒店类型唯一索引',
  KEY `hotel_id` (`hotel_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='酒店商户类型关系表';

-- ----------------------------
-- Records of pad_hotel_type
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `pad_order_goods`;
CREATE TABLE `pad_order_goods` (
  `order_no` char(16) NOT NULL COMMENT '订单编号',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `goods_name` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `goods_cate` varchar(30) DEFAULT NULL COMMENT '商品分类',
  `goods_thum` varchar(255) DEFAULT NULL COMMENT '商品缩略图',
  `goods_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品单价 单位为分',
  `goods_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品数量',
  KEY `order_no_index` (`order_no`),
  KEY `goods_id_index` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品详情表';

-- ----------------------------
-- Records of pad_order_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_order_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_order_info`;
CREATE TABLE `pad_order_info` (
  `order_no` char(16) NOT NULL COMMENT '订单编号',
  `goods_name` varchar(10) DEFAULT NULL COMMENT '商品信息',
  `order_amount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单金额 单位为分',
  `sale_hotel` varchar(50) DEFAULT NULL COMMENT '销售商户',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `room_name` varchar(30) DEFAULT NULL COMMENT '销售房号',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间ID',
  `device_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '设备ID',
  `payment` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '支付方式 1:在线支付,2:货到付款,3:转房账',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '支付状态 1:未支付,2:已支付',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '订单状态 1:待处理,2:配送中,3:订单取消,4:交易成功',
  UNIQUE KEY `order_no_index` (`order_no`),
  KEY `hotel_room_status_index` (`hotel_id`,`room_id`,`data_status`) USING BTREE,
  KEY `device_id_index` (`device_id`),
  KEY `hotel_room_index` (`hotel_id`,`room_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单信息主表';

-- ----------------------------
-- Records of pad_order_info
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_order_logs`
-- ----------------------------
DROP TABLE IF EXISTS `pad_order_logs`;
CREATE TABLE `pad_order_logs` (
  `order_no` char(16) NOT NULL COMMENT '订单编号',
  `order_msg` varchar(255) DEFAULT NULL COMMENT '日志信息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  KEY `order_no_index` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单操作日志记录表';

-- ----------------------------
-- Records of pad_order_logs
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_phone_service`
-- ----------------------------
DROP TABLE IF EXISTS `pad_phone_service`;
CREATE TABLE `pad_phone_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '电话服务ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `call_name` varchar(10) NOT NULL COMMENT '呼叫名称',
  `telephone` varchar(8) NOT NULL COMMENT '服务电话',
  `icon_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图标ID',
  `data_sort` tinyint(2) unsigned DEFAULT '0' COMMENT '排列号',
  `data_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务电话基础信息';

-- ----------------------------
-- Records of pad_phone_service
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_query_room`
-- ----------------------------
DROP TABLE IF EXISTS `pad_query_room`;
CREATE TABLE `pad_query_room` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '入住客房ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `build_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼宇ID',
  `floor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层ID',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间ID',
  `room_type` varchar(15) DEFAULT NULL COMMENT '房间类型',
  `customer_name` varchar(20) DEFAULT NULL COMMENT '入住客人姓名',
  `in_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入住时间',
  `out_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '离开时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '房间状态 1:空房,2:有人,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客房信息查询总表';

-- ----------------------------
-- Records of pad_query_room
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_query_room_detail`
-- ----------------------------
DROP TABLE IF EXISTS `pad_query_room_detail`;
CREATE TABLE `pad_query_room_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '客房查询明细ID',
  `check_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入住客房ID',
  `guest_name` varchar(15) DEFAULT NULL COMMENT '客人名称',
  `in_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入住时间',
  `out_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '离店时间',
  `checkin_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '入住人数',
  `checkin_cycle` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入住周期',
  `checking_record` varchar(255) DEFAULT NULL COMMENT '查房记录',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客房信息查询明细';

-- ----------------------------
-- Records of pad_query_room_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_query_room_service`
-- ----------------------------
DROP TABLE IF EXISTS `pad_query_room_service`;
CREATE TABLE `pad_query_room_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '服务详细ID',
  `check_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入住客房ID',
  `service_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '服务ID',
  `service_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '服务状态,1:待处理,2:已处理,3:服务取消',
  `request_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '服务请求时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客房服务查询信息';

-- ----------------------------
-- Records of pad_query_room_service
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_resource`
-- ----------------------------
DROP TABLE IF EXISTS `pad_resource`;
CREATE TABLE `pad_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `res_path` varchar(100) NOT NULL COMMENT '资源存放路径',
  `res_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '资源类型 1:图片 2:视频 3:文档 4:普通文件',
  `res_postfix` varchar(10) NOT NULL DEFAULT '' COMMENT '资源后缀',
  `res_size` int(10) NOT NULL DEFAULT '0' COMMENT '资源大小',
  `res_mime` varchar(50) NOT NULL DEFAULT '' COMMENT 'MIME类型',
  `res_md5val` char(32) NOT NULL COMMENT '资源md5签名',
  `use_times` int(5) NOT NULL DEFAULT '0' COMMENT '应用使用次数',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `data_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '资源类型 1正式文件 2临时文件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统资源信息表';

-- ----------------------------
-- Records of pad_resource
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_room_device`
-- ----------------------------
DROP TABLE IF EXISTS `pad_room_device`;
CREATE TABLE `pad_room_device` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间ID',
  `telephone` varchar(15) NOT NULL COMMENT '话机号码',
  `device_address` char(16) NOT NULL COMMENT '设备地址',
  `position` varchar(15) DEFAULT NULL COMMENT '摆放位置',
  `device_version` varchar(15) DEFAULT NULL COMMENT '设备版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_device_index` (`room_id`,`device_address`),
  UNIQUE KEY `device_address` (`device_address`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='房间绑定设备地址信息';

-- ----------------------------
-- Records of pad_room_device
-- ----------------------------
INSERT INTO `pad_room_device` VALUES ('1', '1', '1001', 'P1K1609100000065', '1', '100');
INSERT INTO `pad_room_device` VALUES ('2', '2', '1002', 'P1K1609100000011', '1', '100');
INSERT INTO `pad_room_device` VALUES ('3', '3', '1003', 'P1K1609100000211', '1', '100');

-- ----------------------------
-- Table structure for `pad_room_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_room_info`;
CREATE TABLE `pad_room_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房间ID',
  `room_name` varchar(30) NOT NULL COMMENT '房间名称(房间号)',
  `room_code` char(10) DEFAULT NULL COMMENT '房间编码',
  `room_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '房间类型,1:客房,2:管家部,3:前台',
  `room_phone` varchar(8) DEFAULT NULL COMMENT '房间电话号码',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '酒店ID',
  `build_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼宇ID',
  `floor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层ID',
  `only_code` char(32) DEFAULT NULL COMMENT '入住客人唯一识别码',
  `in_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入住时间',
  `out_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '离开时间',
  `room_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '实时房态信息,1:空房,2:有人',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '房间状态 1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`),
  KEY `build_id_index` (`build_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='房间基础信息';

-- ----------------------------
-- Records of pad_room_info
-- ----------------------------
INSERT INTO `pad_room_info` VALUES ('1', '3003', '3003', '1', '3003', '1', '0', '1', null, '0', '0', '1', '1');
INSERT INTO `pad_room_info` VALUES ('2', '1002', '1002', '1', '1002', '1', '0', '2', null, '0', '0', '1', '1');
INSERT INTO `pad_room_info` VALUES ('3', '1003', '1003', '1', '1003', '1', '0', '3', null, '0', '0', '1', '1');

-- ----------------------------
-- Table structure for `pad_room_service`
-- ----------------------------
DROP TABLE IF EXISTS `pad_room_service`;
CREATE TABLE `pad_room_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '客房服务ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `two_service_ids` varchar(255) DEFAULT NULL COMMENT '二级服务ID集合,以逗号间隔',
  `telephone` varchar(15) DEFAULT NULL COMMENT '电话号码',
  `service_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '服务ID',
  `service_detail_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '服务详情,1:文字,2:图片',
  `service_content` varchar(255) DEFAULT NULL COMMENT '详情内容信息,当为图片时，保存图片路径',
  `data_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排列号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hotel_service_index` (`hotel_id`,`service_id`) USING BTREE,
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客房服务基础信息';

-- ----------------------------
-- Records of pad_room_service
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_room_service_two`
-- ----------------------------
DROP TABLE IF EXISTS `pad_room_service_two`;
CREATE TABLE `pad_room_service_two` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '二级服务ID',
  `room_server_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客房服务ID',
  `server_name` int(30) DEFAULT NULL COMMENT '二级服务名称',
  PRIMARY KEY (`id`),
  KEY `room_server_id` (`room_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='二级服务信息表';

-- ----------------------------
-- Records of pad_room_service_two
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_service_call`
-- ----------------------------
DROP TABLE IF EXISTS `pad_service_call`;
CREATE TABLE `pad_service_call` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '催叫ID',
  `service_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '服务类型 1:客房催叫服务,2:迷你吧订单催叫服务',
  `order_no` char(16) DEFAULT NULL COMMENT '订单编号',
  `service_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '服务ID',
  `goods_name` varchar(15) DEFAULT NULL COMMENT '服务名称(商品信息)',
  `call_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫时间(记录最后一次)',
  `data_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '处理状态 0:未处理,1:已接收处理',
  PRIMARY KEY (`id`),
  KEY `order_no_index` (`order_no`),
  KEY `service_type_index` (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='催叫服务信息';

-- ----------------------------
-- Records of pad_service_call
-- ----------------------------

-- ----------------------------
-- Table structure for `pad_service_icon`
-- ----------------------------
DROP TABLE IF EXISTS `pad_service_icon`;
CREATE TABLE `pad_service_icon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'LOGO风格ID',
  `icon_category` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '图标分类,1: 服务电话,2:客房服务信息',
  `icon_name` varchar(10) NOT NULL COMMENT '图标名称',
  `icon_path` varchar(255) NOT NULL COMMENT 'icon图标',
  `icon_desc` varchar(255) DEFAULT NULL COMMENT '类型描述',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='ICON图标基础信息';

-- ----------------------------
-- Records of pad_service_icon
-- ----------------------------
INSERT INTO `pad_service_icon` VALUES ('3', '1', '图标名称', '图标路径', '图标描述', '1');
INSERT INTO `pad_service_icon` VALUES ('5', '1', '1', '1', '1', '1');
INSERT INTO `pad_service_icon` VALUES ('6', '1', '11', '11', '11', '1');

-- ----------------------------
-- Table structure for `pad_service_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_service_info`;
CREATE TABLE `pad_service_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '服务ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID,默认为0,表示系统服务',
  `icon_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图标ID',
  `service_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '服务类型(消息类型) 0:未知服务,1:发送请求,2:呼叫电话',
  `service_name` varchar(30) NOT NULL COMMENT '服务名称',
  `service_code` char(10) NOT NULL COMMENT '服务编码',
  `service_info` varchar(255) NOT NULL COMMENT '服务描述',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '服务状态,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='功能服务信息表';

-- ----------------------------
-- Records of pad_service_info
-- ----------------------------
INSERT INTO `pad_service_info` VALUES ('1', '0', '3', '1', '1', '-', '1', '1');
INSERT INTO `pad_service_info` VALUES ('2', '0', '5', '2', '2', '-', '2', '1');

-- ----------------------------
-- Table structure for `pad_staff_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_staff_info`;
CREATE TABLE `pad_staff_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `staff_name` varchar(15) DEFAULT NULL COMMENT '员工名称',
  `staff_account` char(15) NOT NULL COMMENT '员工账号',
  `staff_pwd` char(32) NOT NULL COMMENT '员工密码',
  `staff_salt` char(10) NOT NULL COMMENT '密码盐值',
  `account_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '账号类型(0:未知,1:管家部服务员,2:客房服务员)',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息 1:启用,2:停用,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='酒店员工信息表';

-- ----------------------------
-- Records of pad_staff_info
-- ----------------------------
INSERT INTO `pad_staff_info` VALUES ('1', '1', '张三', 'A001', 'e0c753feaf3f69f7f3279e83a8191166', '123456', '1', '1478759439', '1478759439', '1');

-- ----------------------------
-- Table structure for `pad_type_info`
-- ----------------------------
DROP TABLE IF EXISTS `pad_type_info`;
CREATE TABLE `pad_type_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商户类型ID',
  `type_name` varchar(30) NOT NULL COMMENT '类型名称',
  `type_class` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型分类,1:功能分类,2:星级分类,3:自定义',
  `type_desc` varchar(255) DEFAULT NULL COMMENT '类型描述',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型状态,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='商户类型标签信息';

-- ----------------------------
-- Records of pad_type_info
-- ----------------------------
INSERT INTO `pad_type_info` VALUES ('1', '五星级qwesdf', '1', '五星级（准五）', '1');
INSERT INTO `pad_type_info` VALUES ('6', '三星酒店（准三）', '1', '描述', '1');
INSERT INTO `pad_type_info` VALUES ('7', '三星酒店（准三）', '2', '描述', '1');
INSERT INTO `pad_type_info` VALUES ('9', '商务酒店', '2', '商务办公，出差，会议', '1');
INSERT INTO `pad_type_info` VALUES ('12', 'werwer', '3', 'werwer', '1');
INSERT INTO `pad_type_info` VALUES ('13', 'werwer', '1', '', '1');
INSERT INTO `pad_type_info` VALUES ('14', 'sdf', '3', '', '1');
INSERT INTO `pad_type_info` VALUES ('20', '1', '1', '1', '1');
INSERT INTO `pad_type_info` VALUES ('21', '2', '2', '2', '1');
INSERT INTO `pad_type_info` VALUES ('22', '3', '1', '3', '1');

-- ----------------------------
-- Table structure for `pad_wifi_service`
-- ----------------------------
DROP TABLE IF EXISTS `pad_wifi_service`;
CREATE TABLE `pad_wifi_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'wifi服务ID',
  `hotel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `link_method` tinyint(1) NOT NULL DEFAULT '1' COMMENT '连接方式,1:账号密码,2:商户二维码,3:短信认证',
  `wifi_account` varchar(50) DEFAULT NULL COMMENT 'wifi账号',
  `wifi_password` varchar(16) DEFAULT NULL COMMENT 'wifi密码',
  `qrcode_path` varchar(255) DEFAULT NULL COMMENT '二维码图片',
  `data_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态信息,1:有效,2:无效,99:删除',
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='wifi服务基础信息';

-- ----------------------------
-- Records of pad_wifi_service
-- ----------------------------
INSERT INTO `pad_wifi_service` VALUES ('1', '1', '1', 'wifi-test', '123456', '/', '1');
