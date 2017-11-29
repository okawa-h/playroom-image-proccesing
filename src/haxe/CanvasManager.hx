package ;

import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Image;
import js.jquery.JQuery;
import js.jquery.Event;
import canvas.ProcessingController;
import jp.okawa.js.canvas.ImageProcessing;

using js.Browser;

class CanvasManager {

	private static var _jCanvas : JQuery;
	private static var _canvas  : CanvasElement;
	private static var _context : CanvasRenderingContext2D;
	private static inline var IMAGE_PATH : String = 'files/img/image.jpg';

	/* =======================================================================
		Constractor
	========================================================================== */
	public static function init():Void {

		_canvas  = Browser.document.createCanvasElement();
		_jCanvas = new JQuery(_canvas);
		_context = _canvas.getContext2d();

		FileController.init();
		Main.addBody(_jCanvas);
		ProcessingController.init();

		drawImage();

	}

		/* =======================================================================
			On Resize
		========================================================================== */
		public static function onResize(winW:Float,winH:Float):Void {

			setPosition(winW,winH);

		}

		/* =======================================================================
			Get Canvas
		========================================================================== */
		public static function getCanvas():CanvasElement {

			return _canvas;

		}

		/* =======================================================================
			Redraw
		========================================================================== */
		public static function redraw():Void {

			_jCanvas.trigger('redraw');

		}

		/* =======================================================================
			Draw Image
		========================================================================== */
		public static function drawImage(src:String=IMAGE_PATH):Void {

			var image : Image = new Image();
			image.onload = function(event) {

				_jCanvas.off('redraw').on('redraw',function(event):Void {

					clear();
					var imageW : Int = image.width;
					var imageH : Int = image.height;
					_canvas.width  = imageW;
					_canvas.height = imageH;
					_context.drawImage(image, 0, 0, imageW, imageH, 0, 0, imageW, imageH);
					Main.trigger('resize');

				}).trigger('redraw');

			}
			image.src = src;

		}

	/* =======================================================================
		Clear
	========================================================================== */
	private static function clear():Void {

		_context.clearRect(0,0,_canvas.width,_canvas.height);

	}

	/* =======================================================================
		Set Position
	========================================================================== */
	private static function setPosition(winW:Float,winH:Float):Void {

		_jCanvas.css({
			top  : (winH * .5) - (_jCanvas.height() * .5),
			left : (winW * .5) - (_jCanvas.width() * .5)
		});

	}

}
