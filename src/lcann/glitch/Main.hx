package lcann.glitch;

import js.Lib;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.Browser;

/**
 * ...
 * @author Luke Cann
 */
class Main {
	public static var canvas(default, null):CanvasElement;
	public static var c(default, null):CanvasRenderingContext2D;
	
	static function main() {
		ResBuilder.build();
		
		canvas = cast Browser.window.document.getElementById("c");
		c = canvas.getContext2d();
		
		c.fillStyle = "black";
		c.fillRect(0, 0, 640, 480);
	}
	
}