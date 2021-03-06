package lcann.glitch;

import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.ImageData;
import lcann.glitch.end.FworkMan;
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
	
	private static var cd:ImageData;
	public static var doClear:Bool = true;
	private static var isClear:Bool = true;
	
	private static var lms:Float;
	
	public static var controls(default, null):Controls;
	public static var sound(default, null):SoundManager;
	public static var state(default, null):State;
	public static var img(default, null):ImgManager;
	private static var lvl:Level;
	
	private static var lvlStop:Float;
	private static var fwork:FworkMan;
	
	static function main() {
		canvas = cast Browser.window.document.getElementById("c");
		
		c = canvas.getContext2d();
		c.imageSmoothingEnabled = false;
		c.font = '30px "Lucida Console", Monaco, monospace';
		c.textAlign = "center";
		
		controls = new Controls();
		sound = new SoundManager(r.snd);
		img = new ImgManager(r.img);
		
		lvlStop = 1;
		fwork = new FworkMan();
		
		state = {
			flags: new Map<String, Bool>(),
			lvl: "S",
			spawn: 0
		}
		resetLevel();
		
		lms = Browser.window.performance.now();
		Browser.window.requestAnimationFrame(step);
	}
	
	static public function resetLevel():Void{
		loadLevel(state.lvl, state.spawn);
	}
	
	static public function loadLevel(name:String, spawn:Int):Void {
		c.fillStyle = "black";
		c.fillRect(0, 0, canvas.width, canvas.height);
		cd = c.getImageData(0, 0, canvas.width, canvas.height);
		
		state.lvl = name;
		state.spawn = spawn;
		
		for(l in r.levels){
			if(l.name == name){
				lvl = new Level(l, spawn);
				return;
			}
		}
		lvl = null;
	}
	
	static private function step(ms:Float):Void {
		var s:Float = Math.min((ms - lms) / 1000, 1/24);
		lms = ms;
		
		if(checkStateFlag("SE")){
			doClear = false;
			
			lvlStop -= s;
			fwork.update(s);
		}
		
		if (doClear) {
			if (!isClear) {
				c.fillStyle = "rgba(0,0,0,0.5)";
				c.fillRect(0, 0, canvas.width, canvas.height);
				cd = c.getImageData(0, 0, canvas.width, canvas.height);
			}
			c.putImageData(cd, 0, 0);
		}
		isClear = doClear;
		
		
		if(lvl != null && lvlStop > 0){
			lvl.update(s);
		}
		
		Browser.window.requestAnimationFrame(step);
	}
	
	static public function checkStateFlag(f:String):Bool{
		return Main.state.flags.exists(f) ? Main.state.flags[f] : false;
	}
}