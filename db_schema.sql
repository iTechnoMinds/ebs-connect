-- --------------------------------------------------------
-- Server version:               5.6.23-log - MySQL Community Server (GPL)
-- Server OS:                    Linux
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table midzprod.app_db_revision
CREATE TABLE IF NOT EXISTS `app_db_revision` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `query` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Query to be executed',
  `description` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the revision',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.app_db_revision_execution
CREATE TABLE IF NOT EXISTS `app_db_revision_execution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `db_revision_id` bigint(20) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of the status',
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  KEY `FK_app_db_revision_execution_app_master_status` (`sys_status_code`),
  KEY `FK_app_db_revision_execution_app_db_revision` (`db_revision_id`),
  CONSTRAINT `FK_app_db_revision_execution_app_db_revision` FOREIGN KEY (`db_revision_id`) REFERENCES `app_db_revision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.app_master_status
CREATE TABLE IF NOT EXISTS `app_master_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Internal code reference',
  `priority` int(10) unsigned NOT NULL COMMENT 'Sequence of the status; Status can only change to higher sequence',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the status',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of the status',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.app_master_user
CREATE TABLE IF NOT EXISTS `app_master_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ID of the user',
  `password` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Password of the user',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_context
CREATE TABLE IF NOT EXISTS `esb_context` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Code for the context',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the context',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of the context',
  `application_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Application related to this context',
  `client_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Client related to this context',
  `content-type` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text/plain' COMMENT 'MIME ENGINE of the context',
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NEW',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `status_code` (`sys_status_code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  CONSTRAINT `esb_context_ibfk_1` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_context_blackout
CREATE TABLE IF NOT EXISTS `esb_context_blackout` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) unsigned NOT NULL,
  `blocked_from` datetime NOT NULL COMMENT 'Starting period of the blackout (inclusive)',
  `blocked_till` datetime NOT NULL COMMENT 'Ending period of the blackout (inclusive)',
  `is_process_blocked` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Indicates whether the blackout affect payload process',
  `is_outbound_blocked` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Indicates whether the blackout affect payload outbound',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the outbound',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of the outbound',
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NEW',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status_code` (`sys_status_code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  KEY `FK_esb_context_outbound_esb_context` (`context_id`),
  KEY `context_id_to_start_on_to_end_on` (`context_id`,`blocked_from`,`blocked_till`),
  CONSTRAINT `esb_context_blackout_ibfk_1` FOREIGN KEY (`context_id`) REFERENCES `esb_context` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `esb_context_blackout_ibfk_2` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='Blackout period for processing and or outbounding';

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_context_outbound
CREATE TABLE IF NOT EXISTS `esb_context_outbound` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) unsigned NOT NULL,
  `sequence_id` int(10) unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the outbound',
  `type` enum('FILE','HTTP','HTTPS','FTP','FTPS','SFTP','SMTP') COLLATE utf8_unicode_ci NOT NULL COMMENT 'Type of the outbound',
  `classname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Class name for the outbound, otherwise default of each ENGINE will be used',
  `cred_user` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cred_pass` text COLLATE utf8_unicode_ci,
  `host` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'text/plain',
  `initial_delay_second` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Initial delay in seconds',
  `retry_max_allowed` int(10) unsigned NOT NULL DEFAULT '5' COMMENT 'Max number of retry allowed',
  `retry_delay_second` int(10) unsigned NOT NULL DEFAULT '30' COMMENT 'Delay in seconds for the subsequent attempt',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of the outbound',
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NEW',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status_code` (`sys_status_code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  KEY `FK_esb_context_outbound_esb_context` (`context_id`),
  CONSTRAINT `FK_esb_context_outbound_esb_context` FOREIGN KEY (`context_id`) REFERENCES `esb_context` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `esb_context_outbound_ibfk_1` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_context_process
CREATE TABLE IF NOT EXISTS `esb_context_process` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) unsigned NOT NULL COMMENT 'Context ID for the process',
  `sequence_id` int(11) NOT NULL COMMENT 'Sequence ID of the process',
  `class_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Class to process the payload',
  `target_context_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Target context ID',
  `target_context_id_mapping` text COLLATE utf8_unicode_ci COMMENT 'Mapping between key and context id in JSON as key value pair',
  `configuration` text COLLATE utf8_unicode_ci COMMENT 'Configuration in JSON',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of the process',
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NEW',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `context_id_sequence_id` (`context_id`,`sequence_id`),
  KEY `status_code` (`sys_status_code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  KEY `FK_esb_context_process_esb_context_2` (`target_context_id`),
  CONSTRAINT `FK_esb_context_process_esb_context` FOREIGN KEY (`context_id`) REFERENCES `esb_context` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_esb_context_process_esb_context_2` FOREIGN KEY (`target_context_id`) REFERENCES `esb_context` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `esb_context_process_ibfk_1` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_payload
CREATE TABLE IF NOT EXISTS `esb_payload` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Reference to parent payload if any',
  `external_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'External ID as extracted from the payload',
  `content` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Actual payload content',
  `content_s3_bucket` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'S3 bucket of the payload',
  `content_s3_key` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'S3 key of the payload',
  `header` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Header of the payload (if any)',
  `ip_address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'IP address from which payload is originated',
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NEW',
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `uuid_flag` char(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_code` (`sys_status_code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  KEY `FK_esb_payload_esb_context` (`context_id`),
  KEY `FK_esb_payload_esb_payload` (`parent_id`),
  KEY `external_id` (`external_id`),
  KEY `uuid_flag` (`uuid_flag`),
  CONSTRAINT `FK_esb_payload_esb_context` FOREIGN KEY (`context_id`) REFERENCES `esb_context` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_esb_payload_esb_payload` FOREIGN KEY (`parent_id`) REFERENCES `esb_payload` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `esb_payload_ibfk_1` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_payload_event
CREATE TABLE IF NOT EXISTS `esb_payload_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payload_id` bigint(20) unsigned NOT NULL COMMENT 'Reference to `payload.id`',
  `context_process_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Reference to `esb_context_process.id`',
  `context_type` enum('PROCESS','OUTBOUND') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'PROCESS',
  `description` text COLLATE utf8_unicode_ci,
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `payload_id` (`payload_id`),
  KEY `context_process_id` (`context_process_id`),
  KEY `context_outbound_id` (`context_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.esb_payload_outbound
CREATE TABLE IF NOT EXISTS `esb_payload_outbound` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payload_id` bigint(20) unsigned NOT NULL COMMENT 'Payload ID',
  `outbound_id` bigint(20) unsigned NOT NULL COMMENT 'Outbound ID',
  `to_process_on` datetime DEFAULT NULL COMMENT 'Indicate when to process',
  `transmission_attempted` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of transmission has been attempted',
  `transmission_retry_left` int(10) unsigned NOT NULL DEFAULT '5',
  `last_response_body` text COLLATE utf8_unicode_ci,
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `uuid_flag` char(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payload_id_outbound_id` (`payload_id`,`outbound_id`),
  KEY `FK_esb_payload_outbound_esb_context_outbound` (`outbound_id`),
  KEY `FK_esb_payload_outbound_app_master_status` (`sys_status_code`),
  KEY `to_process_on` (`to_process_on`),
  KEY `transmission_retry_left` (`transmission_retry_left`),
  KEY `uuid_flag` (`uuid_flag`),
  CONSTRAINT `FK_esb_payload_outbound_app_master_status` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_esb_payload_outbound_esb_context_outbound` FOREIGN KEY (`outbound_id`) REFERENCES `esb_context_outbound` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_esb_payload_outbound_esb_payload` FOREIGN KEY (`payload_id`) REFERENCES `esb_payload` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.


-- Dumping structure for table midzprod.sys_template
CREATE TABLE IF NOT EXISTS `sys_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sys_status_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `sys_created_by` int(10) unsigned NOT NULL,
  `sys_created_on` datetime NOT NULL,
  `sys_modified_by` int(10) unsigned DEFAULT NULL,
  `sys_modified_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status_code` (`sys_status_code`),
  KEY `created_on` (`sys_created_on`),
  KEY `modified_on` (`sys_modified_on`),
  CONSTRAINT `FK_sys_template_app_master_status` FOREIGN KEY (`sys_status_code`) REFERENCES `app_master_status` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
