/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */
package html5_appdelegate;

import msignal.Signal;
import js.JQuery;
import js.Browser;

class HTML5AppDelegate 
{
    /**
      * The blur event is sent to an element when it loses focus.
      * Originally, this event was only applicable to form elements, such as <input>. In recent browsers,
      * the domain of the event has been extended to include all element types.
      * An element can lose focus via keyboard commands, such as the Tab key,
      * or by mouse clicks elsewhere on the page.
    **/
    public var onBlur(default, null): Signal0;

    /**
      * The focus event is sent to an element when it gains focus.
      * This event is implicitly applicable to a limited set of elements,
      * such as form elements (<input>, <select>, etc.) and links (<a href>).
      * In recent browser versions, the event can be extended to include all element types
      * by explicitly setting the element's tabindex property. An element can gain focus via
      * keyboard commands, such as the Tab key, or by mouse clicks on the element.
      * Elements with focus are usually highlighted in some way by the browser,
      * for example with a dotted line surrounding the element.
      * The focus is used to determine which element is the first to receive keyboard-related events.
    **/
    public var onFocus(default, null): Signal0;

    /**
      * The unload event is sent to the window element when the user navigates away from the page.
      * This could mean one of many things. The user could have clicked on a link to leave the page,
      * or typed in a new URL in the address bar. The forward and back buttons will trigger the event.
      * Closing the browser window will cause the event to be triggered.
      * Even a page reload will first create an unload event.
    **/
    public var onUnload(default, null): Signal0;

    static private var appDelegateInstance: HTML5AppDelegate;

    private var jquery: JQuery;

    private function new()
    {
        jquery = new JQuery(Browser.window);

        onBlur = new Signal0();
        onFocus = new Signal0();
        onUnload = new Signal0();
        connectListeners();
    }

    private function connectListeners(): Void
    {
        jquery.ready(function(e): Void
        {
            jquery.blur(function(e: Dynamic)
            {
                onBlur.dispatch();
            });

            jquery.focus(function(e: Dynamic)
            {
                onFocus.dispatch();
            });

            jquery.unload(function(e: Dynamic)
            {
                onUnload.dispatch();
            });
        });
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