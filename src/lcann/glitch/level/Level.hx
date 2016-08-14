package lcann.glitch.level;
import js.html.Point;
import lcann.glitch.Platform;

/**
 * ...
 * @author Luke Cann
 */
class Level{
	public var platformLayer(default, null):Array<Platform>;
	
	public function new(levelDef:LevelDef, spawnIndex:Int) {
		platformLayer = new Array<Platform>();
		
		for(p in levelDef.platformLayer){
			platformLayer.push(new Platform(p.x, p.y, p.width, p.height));
		}
	}
	
	public function update(s:Float):Void{
		for (p in platformLayer) {
			p.update(this, s);
		}
	}
}