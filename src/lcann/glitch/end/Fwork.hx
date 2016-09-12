package lcann.glitch.end;
import lcann.glitch.end.FworkMan;

/**
 * ...
 * @author Luke Cann
 */
class Fwork implements FWU{
	private var x:Float;
	private var y:Float;
	private var xs:Float;
	private var ys:Float;
	private var t:Float;
	
	public function new() {
		x = 640 + Math.random() * 640;
		y = 1080;
		t = 1 + Math.random() * 2;
		
		var d:Float = 500 + Math.random() * 500;
		var s:Float = d / t;
		var a:Float = 3.4 + Math.random() * 2;
		
		xs = Math.cos(a) * s;
		ys = Math.sin(a) * s;
		
		Main.sound.play("fwl");
	}
	
	/* INTERFACE lcann.glitch.end.FWU */
	public function update(s:Float, f:FworkMan):Void {
		x += xs * s;
		y += ys * s;
		
		t -= s;
		
		if (t <= 0) {
			Main.sound.play("fwe");
			f.f.remove(this);
			
			//create parts
			var pc:Int = 10 + Math.floor(Math.random() * 10);
			for(i in 0...pc){
				var p:FworkPart = new FworkPart(x, y);
				f.f.add(p);
			}
		}
		
		//draw
		Main.c.beginPath();
		Main.c.fillStyle = "white";
		Main.c.arc(x, y, 10, 0, 2 * Math.PI);
		Main.c.fill();
	}
	
}