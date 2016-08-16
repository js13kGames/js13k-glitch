package lcann.glitch;

import js.Lib;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.Browser;
import js.html.ImageData;
import lcann.glitch.level.Level;
import lcann.glitch.resource.ResBuilder;

/**
 * ...
 * @author Luke Cann
 */
class Main {
	public static var r(default, null) = ResBuilder.build();
	
	public static var canvas(default, null):CanvasElement;
	public static var c(default, null):CanvasRenderingContext2D;
	
	private static var clearData:ImageData;
	public static var doClear:Bool = true;
	private static var isClear:Bool = true;
	
	public static var controls(default, null):Controls;
	private static var level:Level;
	
	static function main() {
		canvas = cast Browser.window.document.getElementById("c");
		c = canvas.getContext2d();
		
		c.imageSmoothingEnabled = false;
		
		c.fillStyle = "black";
		c.fillRect(0, 0, canvas.width, canvas.height);
		clearData = c.getImageData(0, 0, canvas.width, canvas.height);
		
		controls = new Controls();
		loadLevel("start.json", 0);
		
		Browser.window.setInterval(step, 1000 / 60);
	}
	
	static public function loadLevel(name:String, spawn:Int):Void{
		for(l in r.levels){
			if(l.name == name){
				level = new Level(l, spawn);
				return;
			}
		}
		
		level = null;
	}
	
	static private function step() {
		if (doClear) {
			if(!isClear){
				clearData = c.getImageData(0, 0, canvas.width, canvas.height);
			}
			c.putImageData(clearData, 0, 0);
		}
		isClear = doClear;
		
		if(level != null){
			level.update(1 / 60);
		}
	}
}