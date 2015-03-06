/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */
package html5_appdelegate;

import msignal.Signal;

class HTML5AppDelegate 
{
    static private var appDelegateInstance: HTML5AppDelegate;

	private function new(): Void
    {
        connectListeners();
	}

    private function connectListeners(): Void
    {

    }

	static public inline function instance(): HTML5AppDelegate
	{
		if(appDelegateInstance == null)
		{
			appDelegateInstance = new HTML5AppDelegate();
		}
		return appDelegateInstance;
	}
}