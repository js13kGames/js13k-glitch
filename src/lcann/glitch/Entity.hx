package lcann.glitch;
import lcann.glitch.level.Level;

/**
 * @author Luke Cann
 */

interface Entity {
	function update(level:Level, s:Float):Void;
}