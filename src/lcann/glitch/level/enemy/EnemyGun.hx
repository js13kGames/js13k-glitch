package lcann.glitch.level.enemy;
import lcann.glitch.level.Level;
/**
 * ...
 * @author Luke Cann
 */
class EnemyGun extends Enemy{
	private var r:Bool;
	private var d:Float;
	
	public function new(x:Float, y:Float, width:Float, height:Float, r:Bool) {
		super(x, y, width, height);
		this.r = r;
		
		hp = 10;
		d = 0.5;
	}
	
	override public function update(level:Level, s:Float):Void {
		super.update(level, s);
		d -= s;
		
		if(d <= 0){
			d = 1.5;
			level.eb.add(new EnemyBullet(x, y + aabbTop / 2, r ? 500 : -500, 0));
			Main.sound.play("esh");
		}
	}
	
	override public function draw():Void {
		Main.c.save();
		if (!r) {
			Main.c.scale( -1, 1);
		}
		Main.c.drawImage(Main.img.get(ht > 0 ? "sht_h" : "sht"),  (r ? x : -x) + aabbLeft, this.y + aabbTop);
		Main.c.restore();
	}
}