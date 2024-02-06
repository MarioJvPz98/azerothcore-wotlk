-- DB update 2021_12_28_00 -> 2021_12_28_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_28_00 2021_12_28_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640694155370414400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640694155370414400');

-- High Marshal Whirlaxis unit flags: UNK_6 & IMMUNE_TO_PC
UPDATE `creature_template` SET `unit_flags`=320 WHERE  `entry` = 15204;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_28_01' WHERE sql_rev = '1640694155370414400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;