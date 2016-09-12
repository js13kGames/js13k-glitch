package lcann.glitch;

import js.html.ImageElement;
import js.Browser;
import js.html.URL;
import js.html.Blob;

/**
 * ...
 * @author Luke Cann
 */
class ImgManager{
	private var i:Map<String, ImageElement>;
	
	public function new(imgList:Array<ImgDef>) {
		i = new Map<String, ImageElement>();
		
		for (d in imgList) {
			var svg:Blob = new Blob([d.d], { type: 'image/svg+xml;charset=utf-8' } );
			var url:String = URL.createObjectURL(svg);
			
			var e:ImageElement = Browser.document.createImageElement();
			e.src = url;
			i.set(d.n, e);
		}
	}
	
	public function get(n:String):ImageElement{
		return i.get(n);
	}
	
}