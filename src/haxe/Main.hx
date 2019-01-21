package ;

import js.Browser;
import js.jquery.JQuery;
import js.jquery.Event;

class Main {

	private static var _jWindow : JQuery;
	private static var _jAll : JQuery;

	public static function main():Void {

		new JQuery(Browser.document).ready(init);

	}

	/* =======================================================================
		Constractor
	========================================================================== */
	private static function init(event:Event):Void {

		_jWindow = new JQuery(Browser.window);
		_jAll    = new JQuery('#all');

		CanvasManager.init();
		_jWindow.on({ 'resize':onResize }).trigger('resize');

	}

		/* =======================================================================
			Trigger
		========================================================================== */
		public static function trigger(name:String):Void {

			_jWindow.trigger(name);

		}

	/* =======================================================================
		On Resize
	========================================================================== */
	private static function onResize(event:Event):Void {

		var winW : Float = _jWindow.innerWidth();
		var winH : Float = _jWindow.innerHeight();
		CanvasManager.onResize(winW,winH);

	}

		/* =======================================================================
			Add Body
		========================================================================== */
		public static function addBody(jTarget:JQuery):Void {

			_jAll.append(jTarget);

		}


}
