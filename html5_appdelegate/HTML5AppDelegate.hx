/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package html5_appdelegate;

import js.html.Element;
import js.html.Window;
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
    public var rootView(default, default):Element;

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
    //
    // native calls
    //
    public function openURL(url:String): Bool
    {
        untyped window.open(url, "_blank");// open a link in a new tab
        return true;
    }

}
