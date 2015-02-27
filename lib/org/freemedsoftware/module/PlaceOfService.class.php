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

class PlaceOfService extends SupportModule {

	var $MODULE_NAME = "Place of Service";
	var $MODULE_VERSION = "0.1.1";
	var $MODULE_FILE = __FILE__;
	var $MODULE_UID = "178bb3ad-fb08-433c-9c90-02f830db5992";

	var $PACKAGE_MINIMUM_VERSION = '0.6.0';

	var $record_name = "Place of Service";
	var $table_name  = "pos";
	var $order_field = "posname,posdescrip";
	var $widget_hash = "##posname## (##posdescrip##)";

	var $variables = array (
		"posname",
		"posdescrip",
		"posdtadd",
		"posdtmod"
	);

	public function __construct () {
		$this->list_view = array (
			__("Code") => "posname",
			__("Description") => "posdescrip"
		);

		parent::__construct( );
	} // end constructor PlaceOfService

	protected function add_pre ( &$data ) {
		$data['posdtadd'] = date( 'Y-m-d' );
	}

	protected function mod_pre ( &$data ) {
		$data['posdtmod'] = date( 'Y-m-d' );
	}

} // end class PlaceOfService

register_module ("PlaceOfService");

?>
