package lcann.glitch.end;
import lcann.glitch.end.FworkMan;

/**
 * ...
 * @author Luke Cann
 */
class FworkPart implements FWU {
	private var x:Float;
	private var y:Float;
	private var xs:Float;
	private var ys:Float;
	private var c:String;
	private var g:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
		
		var d:Float = Math.random() * (Math.PI * 2);
		var s:Float = 500 + Math.random() * 500;
		
		xs = Math.cos(d) * s;
		ys = Math.sin(d) * s;
		
		g = Math.random() * 400;
		
		var cc:Int = Math.floor(Math.random() * 7);
		c = switch(cc){
			case 0:
				"red";
			case 1:
				"green";
			case 2:
				"blue";
			case 3:
				"pink";
			case 4:
				"yellow";
			case 5:
				"purple";
			case 6:
				"orange";
			default:
				"white";
		}
	}
	
	/* INTERFACE lcann.glitch.end.FWU */
	
	public function update(s:Float, f:FworkMan):Void {
		ys += g * s;
		
		x += xs * s;
		y += ys * s;
		
		if(x < 0 || x > 1920 || y < 0 || y > 1080){
			f.f.remove(this);
		}
		
		//draw
		Main.c.beginPath();
		Main.c.fillStyle = c;
		Main.c.arc(x, y, 10, 0, 2 * Math.PI);
		Main.c.fill();
	}
	
}