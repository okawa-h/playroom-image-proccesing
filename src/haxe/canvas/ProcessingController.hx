package canvas;

import js.jquery.JQuery;
import js.jquery.Event;
import jp.okawa.js.canvas.ImageProcessing;

class ProcessingController {

	private static var _jParent:JQuery;
	private static var PROCESSING_LIST:Map<String,Dynamic> = [

		'Default'    => function(canvas){},
		'Dot'        => ImageProcessing.drawDot,
		'GrayScale'  => ImageProcessing.drawGrayScale,
		'Monochrome' => ImageProcessing.drawMonochrome,
		'Mosaic'     => ImageProcessing.drawMosaic,
		'Quantize'   => ImageProcessing.drawQuantize,
		'Threshold'  => ImageProcessing.drawThreshold,
		'Detect Edge'      => ImageProcessing.drawDetectEdge,
		'Negative Reverse' => ImageProcessing.drawNegativeReverse,
		'Sobel' => ImageProcessing.drawSobel

	];

	/* =======================================================================
		Constractor
	========================================================================== */
	public static function init():Void {

		_jParent = new JQuery(getHtml());
		Main.addBody(_jParent);
		_jParent.on('click','li',onClick);

	}

	/* =======================================================================
		Get Html
	========================================================================== */
	private static function getHtml():String {

		var html : String = '<ul id="processing-controller">';
		for (key in PROCESSING_LIST.keys()) {
			html += '<li data-processing="$key">$key</li>';
		}
		return html + '</ul>';

	}

	/* =======================================================================
		On Click
	========================================================================== */
	private static function onClick(event:Event):Void {

		CanvasManager.redraw();
		var processing:String = new JQuery(event.currentTarget).data('processing');
		PROCESSING_LIST[processing](CanvasManager.getCanvas());

	}

}
