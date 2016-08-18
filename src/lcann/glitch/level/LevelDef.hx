package lcann.glitch.level;

/**
 * @author Luke Cann
 */

typedef LevelDef = {
	var name:String;
	var platformLayer:Array<PlatformDef>;
	var player:Array<Point>;
	var portal:Array<PortalDef>;
}