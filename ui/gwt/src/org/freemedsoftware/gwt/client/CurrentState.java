/*
 * $Id$
 *
 * Authors:
 *      Jeff Buchbinder <jeff@freemedsoftware.org>
 *
 * FreeMED Electronic Medical Record and Practice Management System
 * Copyright (C) 1999-2008 FreeMED Software Foundation
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

package org.freemedsoftware.gwt.client;

import org.freemedsoftware.gwt.client.screen.MainScreen;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.TabPanel;
import com.google.gwt.user.client.ui.Widget;
import java.util.HashMap;

public class CurrentState {

	/**
	 * @gwt.typeArgs <java.lang.String,java.lang.String>
	 */
	protected HashMap statusItems;
	protected Label statusBar = null;
	protected TabPanel tabPanel = null;
	
	public CurrentState() {
		statusItems = new HashMap();
	}

	/**
	 * Bulk assign mainscreen object
	 * 
	 * @param m
	 */
	public void assignMainScreen(MainScreen m) {
		assignStatusBar(m.getStatusBar());
		assignTabPanel(m.getTabPanel());
	}
	
	/**
	 * Assign status bar object.
	 * 
	 * @param w
	 */
	public void assignStatusBar(Label l) {
		statusBar = l;
	}

	/**
	 * Assign tab panel object.
	 * 
	 * @param t
	 */
	public void assignTabPanel(TabPanel t) {
		tabPanel = t;
	}
	
	/**
	 * Add an item to the status bar stack.
	 * 
	 * @param module
	 * @param text
	 */
	public void statusBarAdd(String module, String text) {
		statusItems.put(module, text);
		((Label) statusBar).setText("Processing (" + text + ")");
	}
	
	/**
	 * Remove an item from the status bar stack.
	 * 
	 * @param module
	 */
	public void statusBarRemove(String module) {
		statusItems.remove(module);
		if (statusItems.size() > 0) {
			((Label) statusBar).setText("Processing");
		} else {
			((Label) statusBar).setText("Ready");
		}
	}
	
	public TabPanel getTabPanel() {
		return tabPanel;
	}
}
