package lcann.glitch.level;

/**
 * ...
 * @author Luke Cann
 */
class PlayerBullet extends Bullet{

	public function new(x:Float, y:Float, xs:Float, ys:Float) {
		super(x, y, xs, ys);
	}
	
	override function destroy(level:Level):Void {
		level.pb.remove(this);
	}
}