<?php
 // $Id$
 //
 // Authors:
 // 	Jeff Buchbinder <jeff@freemedsoftware.org>
 //
 // FreeMED Electronic Medical Record and Practice Management System
 // Copyright (C) 1999-2015 FreeMED Software Foundation
 //
 // This program is free software; you can redistribute it and/or modify
 // it under the terms of the GNU General Public License as published by
 // the Free Software Foundation; either version 2 of the License, or
 // (at your option) any later version.
 //
 // This program is distributed in the hope that it will be useful,
 // but WITHOUT ANY WARRANTY; without even the implied warranty of
 // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 // GNU General Public License for more details.
 //
 // You should have received a copy of the GNU General Public License
 // along with this program; if not, write to the Free Software
 // Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

LoadObjectDependency('org.freemedsoftware.core.SupportModule');

class ProviderCertifications extends SupportModule {

	var $MODULE_NAME    = "Provider Certifications";
	var $MODULE_VERSION = "0.1";
	var $MODULE_FILE    = __FILE__;
	var $MODULE_UID     = "69d60f3a-408d-4995-b729-7a3c74ea8c6c";

	var $PACKAGE_MINIMUM_VERSION = '0.8.0';

	var $record_name = "Provider Certifications";
	var $table_name = "degrees";
	var $widget_hash = "##degdegree## (##degname##)";

	var $variables      = array (
		"degdegree",
		"degname",
		"degdate"
	);

	// For i18n: __("Provider Certifications")
	public function __construct ( ) {
		$this->list_view = array(
			__("Degree") => 'degdegree',
			__("Name") => 'degname'
		);
		parent::__construct( );
	}

	protected function add_pre ( &$data ) {
		$data['degdate'] = date ('Y-m-d');
	}

} // end class ProviderCertifications

register_module ("ProviderCertifications");

?>
