package lcann.glitch.level;
import js.html.Point;
import lcann.glitch.level.Platform;

/**
 * ...
 * @author Luke Cann
 */
class Level{
	public var platformLayer(default, null):Array<Platform>;
	public var player(default, null):Player;
	
	public function new(levelDef:LevelDef, spawnIndex:Int) {
		platformLayer = new Array<Platform>();
		
		for(p in levelDef.platformLayer){
			platformLayer.push(new Platform(p.x, p.y, p.width, p.height));
		}
		
		player = new Player(320, 240);
	}
	
	public function update(s:Float):Void{
		for (p in platformLayer) {
			p.update(this, s);
		}
		
		player.update(this, s);
	}
}