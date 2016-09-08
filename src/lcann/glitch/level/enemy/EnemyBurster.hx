package lcann.glitch.level.enemy;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class EnemyBurster extends EnemyWalker{
	private var t:Float;
	
	public function new(x:Float, y:Float, width:Float, height:Float, right:Bool) {
		super(x, y, width, height, right);
		t = 3;
		hp = 4;
	}
	
	override public function update(level:Level, s:Float):Void {
		super.update(level, s);
		
		t -= s;
		
		if(t < 0.5){
			xs = 0;
		}
		
		if(t < 0){
			xs = 400;
			t = 3;
			
			for(i in 0...5){
				var dir = Math.PI + (Math.PI / 4) * i;
				level.eb.add(new EnemyBurstBullet(x, y + aabbTop, Math.cos(dir) * 500, Math.sin(dir) * 500));
			}
			
			Main.sound.play("bst");
		}
	}
	
	override public function draw():Void {
		if(ht > 0){
			Main.c.fillStyle = "white";
		}else{
			Main.c.fillStyle = "red";
		}
		Main.c.fillRect(x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
	}
	
}