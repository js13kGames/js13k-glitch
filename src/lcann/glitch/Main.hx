package lcann.glitch;

import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.Browser;
import js.html.ImageData;
import lcann.glitch.level.Level;
import lcann.glitch.level.LevelDef;
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
	
	private static var lms:Float;
	
	public static var controls(default, null):Controls;
	public static var state(default, null):State;
	private static var level:Level;
	
	static function main() {
		canvas = cast Browser.window.document.getElementById("c");
		
		c = canvas.getContext2d();
		c.imageSmoothingEnabled = false;
		
		controls = new Controls();
		
		state = {
			flags: new Map<String, Bool>(),
			level: "S",
			spawn: 0
		}
		resetLevel();
		
		lms = Browser.window.performance.now();
		Browser.window.requestAnimationFrame(step);
	}
	
	static public function resetLevel():Void{
		loadLevel(state.level, state.spawn);
	}
	
	static public function loadLevel(name:String, spawn:Int):Void {
		c.fillStyle = "black";
		c.fillRect(0, 0, canvas.width, canvas.height);
		clearData = c.getImageData(0, 0, canvas.width, canvas.height);
		
		state.level = name;
		state.spawn = spawn;
		
		for(l in r.levels){
			if(l.name == name){
				level = new Level(l, spawn);
				return;
			}
		}
		level = null;
	}
	
	static private function step(ms:Float):Void {
		var s:Float = Math.min((ms - lms) / 1000, 1/24);
		lms = ms;
		
		if (doClear) {
			if(!isClear){
				clearData = c.getImageData(0, 0, canvas.width, canvas.height);
			}
			c.putImageData(clearData, 0, 0);
		}
		isClear = doClear;
		
		
		if(level != null){
			level.update(s);
		}
		
		Browser.window.requestAnimationFrame(step);
	}
	
	static public function checkStateFlag(f:String):Bool{
		return Main.state.flags.exists(f) ? Main.state.flags[f] : false;
	}
}