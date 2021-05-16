using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.ActivityMonitor as Mon;

class MyFaceView extends WatchUi.WatchFace {

    var d = null;
    var m = null;
    var f = null;

    function initialize() {
        WatchFace.initialize();
        f = WatchUi.loadResource(Rez.Fonts.xmidbold);
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {  	
        setDayAndMonth();
    }

    function setDayAndMonth() {
        var info = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        d = info.day_of_week;

        if (d == 2) {
            d = "Dilluns";
        } else if (d == 3) {
            d = "Dimarts";
        } else if (d == 4) {
            d = "Dimecres";
        } else if (d == 5) {
            d = "Dijous";
        } else if (d == 6) {
            d = "Divendres";
        } else if (d == 7) {
            d = "Dissabte";
        } else if (d == 1) {
            d = "Diumenge";
        }

        m = info.month;

        if (m == 1) {
            m = "gener";
        } else if (m == 2) {
            m = "febrer";
        } else if (m == 3) {
            m = "mar.";
        } else if (m == 4) {
            m = "abril";
        } else if (m == 5) {
            m = "maig";
        } else if (m == 6) {
            m = "juny";
        } else if (m == 7) {
            m = "juliol";
        } else if (m == 8) {
            m = "agost";
        } else if (m == 9) {
            m = "set.";
        } else if (m == 10) {
            m = "oct.";
        } else if (m == 11) {
            m = "nov.";
        } else if (m == 12) {
            m = "des.";
        }

        m = info.day + " " + m;
    }

    function onUpdate(dc) {
        //var startTime = System.getTimer();

        var clockTime = System.getClockTime();
        var h = clockTime.hour;
        var min = clockTime.min;

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        if (h <= 6) {
            // No need to render any complication during night. Time is enough.
            dc.drawText(
                    200,
                    42,
                    Gfx.FONT_NUMBER_HOT,
                    h,
                    Gfx.TEXT_JUSTIFY_RIGHT
                    );

            dc.drawText(
                    200,
                    103,
                    Gfx.FONT_NUMBER_HOT,
                    min.format("%02d"),
                    Gfx.TEXT_JUSTIFY_RIGHT
                    );

            return;
        }

        if (h == 0 && m == 0) {
            setDayAndMonth();
        }

        dc.drawText(
                10,
                78,
                Gfx.FONT_MEDIUM,
                d,
                Gfx.TEXT_JUSTIFY_LEFT
                );

        dc.drawText(
                10,
                110,
                Gfx.FONT_MEDIUM,
                m,
                Gfx.TEXT_JUSTIFY_LEFT
                );

        // Other complications
        var b = System.getSystemStats().battery.toNumber();

        dc.drawRectangle(79, 15, 24, 10);
        dc.drawRectangle(102, 17, 4, 6);
        dc.fillRectangle(81, 17, (b * 0.20), 6);

        dc.drawText(
                110,
                8,
                Gfx.FONT_TINY,
                b + "%",
                Gfx.TEXT_JUSTIFY_LEFT
                );

        dc.drawText(
                108,
                190,
                Gfx.FONT_TINY,
                (Mon.getInfo().steps/1000.0).format("%0.1f"),
                Gfx.TEXT_JUSTIFY_CENTER
                );

        var mb = Mon.getInfo().moveBarLevel;

        if (mb == 1) {
            dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        } else if (mb == 2) {
            dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        } else if (mb == 3) {
            dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        } else if (mb == 4) {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        } else {
            dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
        }

        if (mb != 0) {
            dc.fillPolygon([[77, 48], [95, 48], [105, 58], [95, 68], [77, 68], [87, 58]]);
            dc.drawText(
                    110,
                    40,
                    Gfx.FONT_LARGE,
                    mb,
                    Gfx.TEXT_JUSTIFY_LEFT
                    );
        }

        h = h % 12;
        h = (h == 0) ? 12 : h;

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);

        dc.drawText(
                198,
                -4,
                f,
                h,
                Gfx.TEXT_JUSTIFY_RIGHT
                );

        dc.drawText(
                198,
                60,
                f,
                min.format("%02d"),
                Gfx.TEXT_JUSTIFY_RIGHT
                );

        //var currentTime = System.getTimer();
        //System.println(h + ":" + m.format("%02d") + ". Elapsed: " + (currentTime - startTime) + " ms\r\n");
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
}
