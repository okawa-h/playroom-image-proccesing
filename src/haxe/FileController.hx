package ;

import js.html.Image;
import js.jquery.JQuery;
import js.jquery.Event;
import js.html.FileReader;
import js.html.FileList;
import js.html.URL;

using js.Browser;

class FileController {

	private static var _jParent : JQuery;

	/* =======================================================================
		Constractor
	========================================================================== */
	public static function init():Void {

		_jParent = new JQuery(getHtml());
		Main.addBody(_jParent);
		_jParent.on('click','.download',onDownload);
		_jParent.on('click','.upload',onUpload);

	}

	/* =======================================================================
		Get Html
	========================================================================== */
	private static function getHtml():String {

		var html : String = '<ul id="file-controller">';
		html += '<li class="download">Download</li>';
		html += '<li class="upload">Upload</li>';
		return html + '</ul>';

	}

	/* =======================================================================
		On Download
	========================================================================== */
	private static function onDownload(event:Event):Void {

		var dataurl : String = CanvasManager.getCanvas().toDataURL();
		var anchor  = Browser.document.createAnchorElement();
		anchor.href = dataurl;
		anchor.download = 'image.png';
		anchor.click();

	}

	/* =======================================================================
		On Upload
	========================================================================== */
	private static function onUpload(event:Event):Void {

		var input  = Browser.document.createInputElement();
		input.type = 'file';
		input.onchange = function(event) {
			var files  : FileList   = input.files;
			CanvasManager.drawImage(URL.createObjectURL(files[0]));
		}

		input.click();

	}

}
