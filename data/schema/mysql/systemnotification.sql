# $Id$
#
# Authors:
#      Jeff Buchbinder <jeff@freemedsoftware.org>
#
# FreeMED Electronic Medical Record and Practice Management System
# Copyright (C) 1999-2015 FreeMED Software Foundation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

CREATE TABLE IF NOT EXISTS `systemnotification` (
	  stamp			TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, nuser			BIGINT UNSIGNED NOT NULL DEFAULT 0
	, ntext			VARCHAR (250) NOT NULL DEFAULT ''
	, naction		VARCHAR (25) NOT NULL DEFAULT ''
	, nmodule		VARCHAR (250) NOT NULL DEFAULT ''
	, npatient		BIGINT UNSIGNED NOT NULL DEFAULT 0
	, id			BIGINT UNSIGNED NOT NULL AUTO_INCREMENT

	#	Default key

	, PRIMARY KEY		( id )
	, KEY			( stamp, nuser )
);

DROP PROCEDURE IF EXISTS systemnotification_Upgrade;
DELIMITER //
CREATE PROCEDURE systemnotification_Upgrade ( )
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

	#----- Remove triggers
	DROP TRIGGER systemtaskinbox_Insert;
	DROP TRIGGER systemtaskinbox_Update;
	DROP TRIGGER systemtaskinbox_Delete;

	#----- Upgrades
        CALL FreeMED_Module_GetVersion( 'systemnotification', @V );

        # Version 2
        IF @V < 2 THEN
		ALTER IGNORE TABLE systemnotification ADD COLUMN naction VARCHAR (25) NOT NULL DEFAULT '' AFTER ntext;
	END IF;

	CALL FreeMED_Module_UpdateVersion( 'systemnotification', 2 );
END
//
DELIMITER ;
CALL systemnotification_Upgrade( );

CREATE TABLE IF NOT EXISTS `systemtaskinbox` (
	  stamp			TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, user			INT UNSIGNED NOT NULL DEFAULT 0
	, patient		BIGINT (20) UNSIGNED NOT NULL DEFAULT 0
	, box			VARCHAR (250) NOT NULL DEFAULT ''
	, module		VARCHAR (250) NOT NULL DEFAULT ''
	, oid			BIGINT (20) UNSIGNED NOT NULL
	, summary		VARCHAR (250) NOT NULL DEFAULT ''
	, id			SERIAL

	#	Keys
	, KEY			( user, box )
	, KEY			( patient )
);

CREATE TABLE IF NOT EXISTS `systemtaskinboxsummary` (
	  user			INT UNSIGNED NOT NULL DEFAULT 0
	, box			VARCHAR (250) NOT NULL DEFAULT ''
	, count			INT UNSIGNED NOT NULL DEFAULT 0

	, PRIMARY KEY		( user, box )
);

CREATE TABLE IF NOT EXISTS `systemtaskinboxpatientsummary` (
	  patient		INT UNSIGNED NOT NULL DEFAULT 0
	, box			VARCHAR (250) NOT NULL DEFAULT ''
	, count			INT UNSIGNED NOT NULL DEFAULT 0

	, PRIMARY KEY		( patient, box )
);

DELIMITER //

CREATE TRIGGER systemtaskinbox_Insert
	AFTER INSERT ON systemtaskinbox
	FOR EACH ROW BEGIN
		CALL systemtaskinbox_UpdateUserCount( NEW.user, NEW.box );
		CALL systemtaskinbox_UpdatePatientCount( NEW.patient, NEW.box );
        END;
//

CREATE TRIGGER systemtaskinbox_Update
	AFTER UPDATE ON systemtaskinbox
	FOR EACH ROW BEGIN
		CALL systemtaskinbox_UpdateUserCount( NEW.user, NEW.box );
		CALL systemtaskinbox_UpdatePatientCount( NEW.patient, NEW.box );
        END;
//

CREATE TRIGGER systemtaskinbox_Delete
	AFTER DELETE ON systemtaskinbox
	FOR EACH ROW BEGIN
		CALL systemtaskinbox_UpdateUserCount( OLD.user, OLD.box );
		CALL systemtaskinbox_UpdatePatientCount( OLD.patient, OLD.box );
        END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS systemtaskinbox_UpdateUserCount;

DELIMITER //

CREATE PROCEDURE systemtaskinbox_UpdateUserCount ( IN u INT UNSIGNED, IN b VARCHAR (250) )
BEGIN
	DECLARE count INT UNSIGNED;

	SELECT COUNT(*) INTO count FROM systemtaskinboxsummary WHERE user = u AND box = b;
	IF count < 1 THEN
		#	Create blank box
		INSERT INTO systemtaskinboxsummary ( user, box, count ) VALUES ( u, b, 0 );
	END IF;

	#	Update aggregate total
	UPDATE systemtaskinboxsummary SET count = ( SELECT COUNT(*) FROM systemtaskinbox WHERE user = u AND box = b ) WHERE user = u AND box = b;
END
//

DELIMITER ;

DROP PROCEDURE IF EXISTS systemtaskinbox_UpdatePatientCount;

DELIMITER //

CREATE PROCEDURE systemtaskinbox_UpdatePatientCount ( IN p INT UNSIGNED, IN b VARCHAR (250) )
BEGIN
	DECLARE count INT UNSIGNED;

	IF p > 0 THEN
		SELECT COUNT(*) INTO count FROM systemtaskinboxpatientsummary WHERE patient = p AND box = b;
		IF count < 1 THEN
			#	Create blank box
			INSERT INTO systemtaskinboxpatientsummary ( patient, box, count ) VALUES ( p, b, 0 );
		END IF;

		#	Update aggregate total
		UPDATE systemtaskinboxpatientsummary SET count = ( SELECT COUNT(*) FROM systemtaskinbox WHERE patient = p AND box = b ) WHERE patient = p AND box = b;
	END IF;
END
//

DELIMITER ;

