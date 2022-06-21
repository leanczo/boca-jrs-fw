import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time.Gregorian as Calendar;

class bocajrswfView extends WatchUi.WatchFace {

	var bocaFont;
	var bocaFontMedium;

    function initialize() {
        WatchFace.initialize();
    }
    
    // Load your resources here
    function onLayout(dc as Dc) as Void {
    	bocaFont = WatchUi.loadResource(Rez.Fonts.bocaFont);
    	bocaFontMedium = WatchUi.loadResource(Rez.Fonts.bocaFontMedium);
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        View.onUpdate(dc);
        
		var widthScreen = dc.getWidth();
		var heightScreen = dc.getHeight();
  		var heightRectangle = heightScreen / 3;
  		var heightCenter = heightScreen / 2;
  		var widthCenter = widthScreen / 2;
  		
		dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight() / 3);
		
		dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, heightRectangle, widthScreen, heightRectangle);
		
		dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, heightRectangle * 2, widthScreen, heightRectangle);
		
		dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
		dc.drawText(widthCenter, heightCenter - 23, bocaFontMedium, timeString, Graphics.TEXT_JUSTIFY_CENTER);
		
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.drawText(widthCenter, heightCenter - 21, bocaFont, timeString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
