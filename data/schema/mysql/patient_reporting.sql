# $Id$
#
# Authors:
#      Jeff Buchbinder <jeff@freemedsoftware.org>
#
# FreeMED Electronic Medical Record and Practice Management System
# Copyright (C) 1999-2012 FreeMED Software Foundation
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

CREATE TABLE IF NOT EXISTS `patient_reporting` (
	report_name			VARCHAR (100) NOT NULL,
	report_uuid			CHAR (36) NOT NULL,
	report_locale			CHAR (5) NOT NULL DEFAULT 'en_US',
	report_desc			TEXT,
	report_type			VARCHAR (150) NOT NULL DEFAULT 'standard',
	report_sp			VARCHAR (150) NOT NULL,
	report_param_count		TINYINT(3) NOT NULL DEFAULT 0,
	report_param_names		TEXT,
	report_param_types		TEXT,
	report_param_options		TEXT,
	report_param_optional		TEXT,
	report_acl			VARCHAR (150),
	report_formatting		BLOB,

	#	Define keys

	PRIMARY KEY			( report_uuid ),
	KEY				( report_name, report_locale )
);

DROP PROCEDURE IF EXISTS patient_reporting_Upgrade;
DELIMITER //
CREATE PROCEDURE patient_reporting_Upgrade ( ) 
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

	#----- Upgrades
	#CALL FreeMED_Module_GetVersion( 'patient_reporting', @V );

	#CALL FreeMED_Module_UpdateVersion( 'patient_reporting', 1 );
END//
DELIMITER ;
CALL patient_reporting_Upgrade;

#	Load packaged reports

SOURCE data/schema/mysql/patient_reporting/report_PatientAccountActivity.sql
#### SOURCE data/schema/mysql/patient_reporting/report_SomeReportGoesHere.sql

