-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: mc_center
-- ------------------------------------------------------
-- Server version	5.7.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `flyway_schema_history`
--

DROP TABLE IF EXISTS `flyway_schema_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_bin NOT NULL,
  `type` varchar(20) COLLATE utf8_bin NOT NULL,
  `script` varchar(1000) COLLATE utf8_bin NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) COLLATE utf8_bin NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_account_cfg`
--

DROP TABLE IF EXISTS `sys_account_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_account_cfg` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `pd_level` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '密码级别',
  `pd_valid_day` int(11) DEFAULT NULL COMMENT '密码有效时长 (天)',
  `pd_expire_policy` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '密码过期策略',
  `pd_lock_time` int(11) DEFAULT NULL COMMENT '一小时内允许错误次数',
  `lock_hours` int(11) DEFAULT NULL COMMENT '账户锁定时间',
  `page_lock_time` int(11) DEFAULT '10' COMMENT '网页锁定时间',
  `week_pd_dict` varchar(2056) COLLATE utf8_bin DEFAULT '' COMMENT '弱密码库',
  `week_pd_switch` tinyint(1) DEFAULT '0' COMMENT '弱密码库开关',
  `max_pd_length` int(11) DEFAULT '32' COMMENT '最大密码长度',
  `min_pd_length` int(11) DEFAULT '6' COMMENT '最小密码长度',
  `origin_passwd` varchar(255) COLLATE utf8_bin DEFAULT 'hzmc123456' COMMENT '初始密码',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '配置类型',
  `config_item` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '配置内容',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_perm`
--

DROP TABLE IF EXISTS `t_app_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_perm` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'PermID',
  `app_id` bigint(11) DEFAULT NULL COMMENT '应用ID',
  `perm_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用下的权限唯一标识',
  `parent_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '父权限分组',
  `parent_id` bigint(11) DEFAULT NULL COMMENT '父级PermID,0为第一级',
  `path` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '节点路径',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `type` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '类型,MODEL 模块,TAB 页面,AUTH 权限',
  `perm_info` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '额外信息',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '页面状态',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `is_common` tinyint(1) DEFAULT NULL COMMENT 'License权限控制',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '权限描述',
  `option_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_perm` (`app_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='应用权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_application`
--

DROP TABLE IF EXISTS `t_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_application` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用编码',
  `security_code` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '应用安全码，应用需在每个请求中附带安全码字段',
  `app_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用名称',
  `app_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用类型',
  `app_type_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用类型的code',
  `app_version` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用编码',
  `new_tab` tinyint(1) DEFAULT '1' COMMENT '是否打开新窗口',
  `index_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用首页',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '应用状态',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `app_description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用描述',
  `is_sop` tinyint(1) DEFAULT '0' COMMENT '三权分立标记,0 是三权分立的应用,1 不是三权分立的应用',
  `allow_guest` tinyint(1) DEFAULT '0' COMMENT '是否支持游客访问,0 不支持,1 支持',
  `is_public_service` tinyint(1) DEFAULT '0' COMMENT '是否是公共服务',
  `kafka_config` json DEFAULT NULL COMMENT 'kafka相关配置',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_appcode` (`app_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='应用信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_application_config`
--

DROP TABLE IF EXISTS `t_application_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_application_config` (
  `app_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '应用ID',
  `type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '资源Key',
  `config_item` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '资源Value',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_application_data_role`
--

DROP TABLE IF EXISTS `t_application_data_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_application_data_role` (
  `role_id` bigint(11) NOT NULL COMMENT '角色ID',
  `app_id` bigint(11) NOT NULL COMMENT '应用ID',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`role_id`,`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='应用角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_certificate`
--

DROP TABLE IF EXISTS `t_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cert_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '证书名称',
  `cert_type` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '证书类型',
  `cert_manager` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '发证机构',
  `cert_validate` datetime DEFAULT NULL COMMENT '有效截止日期',
  `cert_file` mediumtext COLLATE utf8_bin COMMENT '证书内容',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `create_by` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_client_info`
--

DROP TABLE IF EXISTS `t_client_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `version` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '版本号',
  `package_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '安装包名称',
  `ip` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_client_message`
--

DROP TABLE IF EXISTS `t_client_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_message` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `msg_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '消息类型',
  `send_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '消息时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '消息状态',
  `content` text COLLATE utf8_bin COMMENT '消息内容',
  `user_account` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_client_terminate`
--

DROP TABLE IF EXISTS `t_client_terminate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_terminate` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '用户的ID',
  `ip_address` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'IP地址',
  `mac_address` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'MAC地址',
  `host_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '主机名',
  `os_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '操作系统类型',
  `os_version` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '操作系统版本',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_role`
--

DROP TABLE IF EXISTS `t_data_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '角色名称',
  `role_desc` text COLLATE utf8_bin COMMENT '角色描述',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `is_delete_index` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '角色删除唯一索引',
  `built_in` tinyint(1) DEFAULT '0' COMMENT '是否是内置角色,0 是内置角色,1 不是内置角色',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk1_role_name_uk2_is_delete_index` (`role_name`,`is_delete_index`),
  KEY `idx_role_name` (`role_name`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_database_account`
--

DROP TABLE IF EXISTS `t_database_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_database_account` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `app_type` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库类型',
  `container_type` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `container_name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `host` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库地址',
  `port` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '端口号',
  `account` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库账户',
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '账户密码',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '状态，启用ON，禁用OFF',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `is_delete_index` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '删除标记唯一索引',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_depart`
--

DROP TABLE IF EXISTS `t_depart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_depart` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `dept_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '部门名称',
  `parent_id` bigint(11) DEFAULT '0' COMMENT '父级ID ,0代表根节点',
  `dept_level` int(11) DEFAULT '1' COMMENT '部门层级,默认1',
  `dept_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '部门描述',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '部门状态',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_level` (`dept_level`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='部门信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_dept_data_role`
--

DROP TABLE IF EXISTS `t_dept_data_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dept_data_role` (
  `role_id` bigint(11) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(11) NOT NULL COMMENT '部门ID',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='部门角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_dept_role`
--

DROP TABLE IF EXISTS `t_dept_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dept_role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_id` bigint(11) DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint(11) DEFAULT NULL COMMENT '部门ID',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_dept` (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='部门角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_dict_cfg`
--

DROP TABLE IF EXISTS `t_dict_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dict_cfg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` int(11) DEFAULT '0' COMMENT '父级ID ,0代表根节点',
  `code` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '字典编码',
  `code_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '编码描述',
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '编码值',
  `idx` int(11) DEFAULT '0' COMMENT '同级别字典值排序',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='系统字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_email_attachment`
--

DROP TABLE IF EXISTS `t_email_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_email_attachment` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `original_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `generate_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name_index` (`generate_name`),
  KEY `original_name_index` (`original_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_email_support`
--

DROP TABLE IF EXISTS `t_email_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_email_support` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `icon` text COLLATE utf8_bin COMMENT '图标',
  `status` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `email_addr` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱服务器',
  `email_port` int(11) DEFAULT NULL COMMENT '端口',
  `ssl_enable` tinyint(1) DEFAULT '0' COMMENT '是否开启ssl',
  `email_account` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱账号',
  `email_passwd` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱密码',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='邮箱配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_identity`
--

DROP TABLE IF EXISTS `t_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_identity` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '主键',
  `identity_no` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '身份编号',
  `tripartite_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '三方唯一标识',
  `identity_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '身份名称',
  `application_id` bigint(11) DEFAULT NULL COMMENT '身份来源的应用id',
  `trust` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '信任度',
  `sensitive_tag` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '敏感标签',
  `audit_level` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '审计级别',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '父级id',
  `path` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '身份路径',
  `name_path` text COLLATE utf8_bin COMMENT '身份名称路径',
  `is_black` tinyint(1) DEFAULT '0' COMMENT '是否黑名单',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `is_delete_index` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '身份删除唯一索引',
  `end_time` datetime DEFAULT NULL COMMENT '身份有效期',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '身份状态',
  `discover_status` tinyint(1) DEFAULT NULL COMMENT '发现状态',
  `major_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '主身份类型',
  `description` text COLLATE utf8_bin COMMENT '身份描述',
  `identity_digest` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '身份摘要',
  `identity_digest_index` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '身份唯一索引',
  `time_limit` json DEFAULT NULL COMMENT '时间限制',
  `is_expire` tinyint(1) DEFAULT '0' COMMENT '身份是否过期',
  `block_identity_id` json DEFAULT NULL COMMENT '阻断该身份的黑名单身份id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identity_no_unique_key` (`identity_no`,`is_delete_index`),
  UNIQUE KEY `uni_digest` (`identity_digest`,`identity_digest_index`),
  KEY `idx_identity_no` (`identity_no`) USING BTREE,
  KEY `idx_identity_name` (`identity_name`) USING BTREE,
  KEY `idx_is_delete` (`is_delete`),
  KEY `idx_status` (`status`),
  KEY `idx_is_black` (`is_black`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='身份表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_identity_base_attribute`
--

DROP TABLE IF EXISTS `t_identity_base_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_identity_base_attribute` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `identity_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '身份id',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '身份状态',
  `attribute_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `is_major` tinyint(1) DEFAULT '0' COMMENT '是否是主属性,0 不是,1 是',
  `base_attribute` json DEFAULT NULL COMMENT '基础信息',
  `class_attribute` json DEFAULT NULL COMMENT '分类属性',
  `service_id` bigint(11) DEFAULT NULL COMMENT '账户业务id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identity_id_attribute_type_unique_key` (`identity_id`,`attribute_type`),
  KEY `identity_id` (`identity_id`),
  KEY `idx_user_id_index` (`user_id`),
  KEY `idx_service_id_index` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='身份基础属性表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_identity_group`
--

DROP TABLE IF EXISTS `t_identity_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_identity_group` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `identity_group_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '分组名称',
  `identity_group_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '分组类型',
  `identity_group_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '分组描述',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '分组状态',
  `label` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '分组标签',
  `built_in` tinyint(1) DEFAULT '0' COMMENT '是否内置',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `is_delete_index` varchar(32) COLLATE utf8_bin DEFAULT 'UNIQUE' COMMENT '删除标记唯一索引',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk1_identity_group_name_uk2_is_delete_index` (`identity_group_name`,`is_delete_index`) USING BTREE,
  KEY `idx_identity_group_name` (`identity_group_name`) USING BTREE,
  KEY `idx_identity_group_type` (`identity_group_type`) USING BTREE,
  KEY `idx_status` (`status`),
  KEY `idx_is_delete` (`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='身份分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_identity_identity_group`
--

DROP TABLE IF EXISTS `t_identity_identity_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_identity_identity_group` (
  `identity_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '身份表主键',
  `identity_group_id` bigint(11) NOT NULL COMMENT '身份和身份分组关联表主键',
  PRIMARY KEY (`identity_id`,`identity_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='身份和身份分组关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_identity_operation`
--

DROP TABLE IF EXISTS `t_identity_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_identity_operation` (
  `identity_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '身份id',
  `terminal_white` text COLLATE utf8_bin COMMENT '允许访问的终端',
  `terminal_black` text COLLATE utf8_bin COMMENT '禁止访问的终端',
  `application_white` text COLLATE utf8_bin COMMENT '允许访问的应用',
  `application_black` text COLLATE utf8_bin COMMENT '禁止访问的应用',
  `account_white` text COLLATE utf8_bin COMMENT '允许访问的账号',
  `account_black` text COLLATE utf8_bin COMMENT '禁止访问的账号',
  UNIQUE KEY `identity_id_unique_key` (`identity_id`),
  KEY `identity_id` (`identity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='身份操作属性表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_interface_log`
--

DROP TABLE IF EXISTS `t_interface_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_interface_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `log_no` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '日志编号',
  `oper_time` datetime(6) DEFAULT NULL COMMENT '操作时间',
  `app_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '应用类型',
  `interface_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '接口类型',
  `interface_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '接口名称',
  `result` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '结果',
  `client_ip` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '客户端IP',
  `inte_desc` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '接口描述',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_log_no` (`log_no`) USING BTREE,
  KEY `idx_interface_name` (`interface_name`) USING BTREE,
  KEY `idx_oper_time` (`oper_time`) USING BTREE,
  KEY `idx_interface_type` (`interface_type`) USING BTREE,
  KEY `idx_app_type` (`app_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='接口日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_license`
--

DROP TABLE IF EXISTS `t_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_license` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `key_name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `register_time` datetime DEFAULT NULL COMMENT '开始时间',
  `expire_time` datetime DEFAULT NULL COMMENT '结束时间',
  `host_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '主机ID',
  `tenant_number` int(10) DEFAULT NULL COMMENT '租户数量',
  `verify_value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `md5_value` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `version` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '版本信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `host_key` (`host_id`,`key_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_license_rule`
--

DROP TABLE IF EXISTS `t_license_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_license_rule` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `host_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '主机ID',
  `option_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `verify_value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enable` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_manager_log`
--

DROP TABLE IF EXISTS `t_manager_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_manager_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `log_no` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '日志编号',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `user_account` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  `oper_model` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '操作模块',
  `oper_type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '操作类型',
  `oper_time` datetime(6) DEFAULT NULL COMMENT '操作时间',
  `result` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '事件结果',
  `oper_desc` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '描述信息',
  `client_ip` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '客户端IP',
  `device_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '设备类型',
  `browser_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '浏览器类型',
  `os_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作系统类型',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '日志分类',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_account` (`user_account`) USING BTREE,
  KEY `idx_oper_time` (`oper_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='管理日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_mckj_app`
--

DROP TABLE IF EXISTS `t_mckj_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_mckj_app` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用编码',
  `app_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用名称',
  `app_version` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用版本',
  `app_icon` text COLLATE utf8_bin COMMENT '应用图标(BASE64)',
  `app_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用描述',
  `app_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '状态',
  `qr_code` text COLLATE utf8_bin COMMENT '公众号二维码',
  `prod_advice` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '咨询电话',
  `ad_phone` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '总部电话',
  `ad_mail` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '咨询邮箱',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='美创应用库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_operate_log`
--

DROP TABLE IF EXISTS `t_operate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_operate_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `user_account` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  `login_type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '账号类型',
  `oper_type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '操作类型',
  `oper_time` datetime(6) DEFAULT NULL COMMENT '操作时间',
  `result` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '事件结果',
  `err_msg` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '错误原因',
  `app_code` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '应用code',
  `client_ip` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '客户端IP',
  `device_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '设备类型',
  `browser_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '浏览器类型',
  `os_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作系统类型',
  `oper_desc` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '描述信息',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '日志分类',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_account` (`user_account`) USING BTREE,
  KEY `idx_oper_time` (`oper_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_passwd_history`
--

DROP TABLE IF EXISTS `t_passwd_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_passwd_history` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `user_passwd` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户历史密码(加密)',
  `expire_time` datetime DEFAULT NULL COMMENT '失效时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `passwd_user` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户历史密码记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_position`
--

DROP TABLE IF EXISTS `t_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_position` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `position_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '职位名称',
  `position_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `built_in` tinyint(1) DEFAULT '0' COMMENT '是否内置',
  `field_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '字段类型是用于区分-字段配置-分类属性-是用户职位(用户的分类属性)还是账户业务(账户的分类属性)',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `is_delete_index` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '删除标记唯一索引',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk1_position_name_uk2_is_delete_index_uk3_field_type` (`position_name`,`is_delete_index`,`field_type`) USING BTREE,
  KEY `idx_position_name` (`position_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户职位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_question`
--

DROP TABLE IF EXISTS `t_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_question` (
  `code` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '主键',
  `question` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '问题',
  PRIMARY KEY (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='安全问题表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '角色code',
  `parent_code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '父角色code',
  `role_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '角色描述',
  `app_id` bigint(11) DEFAULT NULL COMMENT '应用编码',
  `role_auth` json DEFAULT NULL COMMENT '权限列表',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `built_in` tinyint(1) DEFAULT '0' COMMENT '是否是内置角色,0 是内置角色,1 不是内置角色',
  `need_update` tinyint(1) DEFAULT '0' COMMENT '是否需要手动更新角色,1 需要更新,0 不需要更新',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_app` (`app_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_send_message`
--

DROP TABLE IF EXISTS `t_send_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_send_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `user_id` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '账号ID',
  `message` mediumtext COLLATE utf8_bin,
  `receivers` text COLLATE utf8_bin,
  `send_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `is_send` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `receiver_type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '接收人类型',
  `subject` text COLLATE utf8_bin COMMENT '邮件标题',
  `attachment` text COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  KEY `send_index` (`is_send`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_send_message_log`
--

DROP TABLE IF EXISTS `t_send_message_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_send_message_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL,
  `result_msg` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `receiver` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `send_status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `user_id` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sms_support`
--

DROP TABLE IF EXISTS `t_sms_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sms_support` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '图标',
  `type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '短信类型',
  `catagory` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '类型分类',
  `status` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `sms_conf` json DEFAULT NULL COMMENT '连接配置信息',
  `default_flag` tinyint(1) DEFAULT '0' COMMENT '是否为默认配置',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='短信配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_system_info`
--

DROP TABLE IF EXISTS `t_system_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_system_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_id` bigint(11) NOT NULL COMMENT '应用id',
  `sys_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '系统名称',
  `sys_icon` mediumtext COLLATE utf8_bin COMMENT 'icon图标',
  `logo_image` mediumtext COLLATE utf8_bin COMMENT 'logo图片',
  `login_image` mediumtext COLLATE utf8_bin COMMENT 'login图标',
  `copyright` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '版权信息',
  `background_path` text COLLATE utf8_bin COMMENT '背景图片',
  `template_type` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '模板类型',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '初始化时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_third_support`
--

DROP TABLE IF EXISTS `t_third_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_third_support` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '图标',
  `type` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `catagory` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '类型分类',
  `status` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `third_conf` json DEFAULT NULL COMMENT '连接配置信息',
  `last_sync_time` datetime DEFAULT NULL COMMENT '上次同步时间',
  `last_sync_result` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '同步结果',
  `last_sync_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '同步人',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='第三方登录配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_token`
--

DROP TABLE IF EXISTS `t_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_token` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '应用类型',
  `app_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '应用ID',
  `src_app_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '目的应用ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `token` text COLLATE utf8_bin COMMENT '用户TOKEN',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'TOKEN状态',
  `reason` text COLLATE utf8_bin COMMENT '附加信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '第三方用户id',
  `user_account` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  `user_password` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户密码',
  `user_gender` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '用户性别,MALE 男,FEMALE 女',
  `user_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '用户姓名',
  `user_phone` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户电话',
  `user_mail` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '用户邮箱',
  `status` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '账户状态',
  `init_flag` tinyint(1) DEFAULT '0' COMMENT '初始化标记 1 已初始化',
  `info_flag` tinyint(1) DEFAULT '0' COMMENT '信息初始化标记',
  `reset_pd_flag` tinyint(1) DEFAULT '0' COMMENT '密码是否被重置',
  `user_origin` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户来源',
  `built_in` tinyint(1) DEFAULT '0' COMMENT '是否是内置用户',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `is_delete_index` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '删除唯一标记',
  `can_delete` tinyint(1) DEFAULT '0' COMMENT '能否被删除',
  `ac_active_time` datetime DEFAULT NULL COMMENT '账户有效期',
  `pw_active_time` datetime DEFAULT NULL COMMENT '密码有效期',
  `ac_lock_time` datetime DEFAULT NULL COMMENT '账户解锁时间',
  `dept_id` bigint(11) NOT NULL DEFAULT '0' COMMENT '部门ID',
  `is_manager` tinyint(1) DEFAULT '0' COMMENT '是否部门负责人',
  `extern_dn` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'LDAP的DN路径',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登录时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`,`is_delete_index`),
  UNIQUE KEY `user_account` (`user_account`,`is_delete_index`),
  UNIQUE KEY `user_phone` (`user_phone`,`is_delete_index`),
  UNIQUE KEY `user_mail` (`user_mail`,`is_delete_index`),
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_dept` (`dept_id`) USING BTREE,
  KEY `idx_account` (`user_account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_application_statistic`
--

DROP TABLE IF EXISTS `t_user_application_statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_application_statistic` (
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `app_id` bigint(11) NOT NULL COMMENT '应用id',
  `enter_count` double(11,5) DEFAULT '0.00000' COMMENT '进入次数',
  `last_flush_date` date DEFAULT NULL COMMENT '上次更新进入次数时间',
  PRIMARY KEY (`user_id`,`app_id`),
  UNIQUE KEY `UNIQUEUSERID` (`user_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户应用关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_certificate`
--

DROP TABLE IF EXISTS `t_user_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `cid` int(11) DEFAULT NULL COMMENT '证书id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `bind_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '绑定类型',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UNIQUEUSERID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_data_role`
--

DROP TABLE IF EXISTS `t_user_data_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_data_role` (
  `role_id` bigint(11) NOT NULL COMMENT '数据角色ID',
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`role_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_database_account`
--

DROP TABLE IF EXISTS `t_user_database_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_database_account` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `account_id` bigint(11) NOT NULL COMMENT '数据库账户ID',
  `app_info` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库信息标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户和数据库账户关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_dept_permission`
--

DROP TABLE IF EXISTS `t_user_dept_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_dept_permission` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `data_perm` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '数据权限',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_data_perm` (`data_perm`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户数据权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_dynamic_code`
--

DROP TABLE IF EXISTS `t_user_dynamic_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_dynamic_code` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '提供给接入应用的用户ID',
  `dynamic_code` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '动态码',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新人',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否被删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_user_dynamic_code_user_id_IDX` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_finger`
--

DROP TABLE IF EXISTS `t_user_finger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_finger` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `finger_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '指纹名称',
  `finger_desc` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '指纹描述',
  `status` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '状态,ON,OFF',
  `reg_time` datetime DEFAULT NULL COMMENT '注册时间',
  `device_sn` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '设备序列号',
  `finger_detail` text COLLATE utf8_bin COMMENT '指纹详细信息 BASE64字符串',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户指纹信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_message`
--

DROP TABLE IF EXISTS `t_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_message` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '第三方用户id',
  `app_code` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用编码',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '消息标题',
  `content` text COLLATE utf8_bin COMMENT '消息内容',
  `send_time` datetime DEFAULT NULL COMMENT '消息发送时间',
  `status` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '消息状态',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '删除标记,0 未删除,1已删除',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_position`
--

DROP TABLE IF EXISTS `t_user_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_position` (
  `user_id` bigint(11) NOT NULL COMMENT '用户表主键',
  `position_id` bigint(11) NOT NULL COMMENT '职位表主键',
  PRIMARY KEY (`user_id`,`position_id`),
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_position_id` (`position_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户职位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_question`
--

DROP TABLE IF EXISTS `t_user_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_question` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `question_code` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '问题id',
  `answer` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '问题答案',
  `question_number` int(11) DEFAULT NULL COMMENT '问题编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUEUSERID` (`user_id`,`question_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户安全问题关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_role`
--

DROP TABLE IF EXISTS `t_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_id` bigint(11) DEFAULT NULL COMMENT '角色ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_third`
--

DROP TABLE IF EXISTS `t_user_third`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_third` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `third_account` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '第三方账户标识',
  `type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '第三方账户种类,ECHAT(企业微信),DING(钉钉),LDAP,AD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUEUSERID` (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户第三方绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-18 11:42:59

