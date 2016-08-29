package lcann.glitch.level;

/**
 * @author Luke Cann
 */

typedef PlatformDef ={
	var x:Float;
	var y:Float;
	var w:Float;
	var h:Float;
	var t:String;//type
	@:optional var cv:String;//condition variable;
	@:optional var r:Bool;//direction == right
}