<?php
 // $Id: Codes.class.php 4860 2010-01-04 13:13:40Z jeff $
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

class Codes extends SupportModule {

	var $MODULE_NAME = "Codes";
	var $MODULE_VERSION = "0.1";
	var $MODULE_FILE = __FILE__;
	var $MODULE_UID = "aee8bdb6-48dc-42ac-ad73-dfbfdd5ad638";
	var $MODULE_HIDDEN = true;

	var $PACKAGE_MINIMUM_VERSION = '0.8.0';

	var $table_name = "codes";

        var $widget_hash = '##codedescripexternal';

	var $variables = array (
		'codedictionary',
		'codevalue',
		'codedescripinternal',
		'codedescripexternal',
		'codelimitgender',
	);

	public function __construct ( ) {

		// Call parent constructor
		parent::__construct();
	} // end constructor Codes

	protected function add_pre ( &$data ) {
	} // end method add_pre

	protected function del_pre ( &$data ) {
	} // end method del_pre
	
}

register_module('Codes');

?>
