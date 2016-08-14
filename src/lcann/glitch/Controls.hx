package lcann.glitch;

import js.Browser;
import js.html.KeyboardEvent;

/**
 * ...
 * @author Luke Cann
 */
class Controls {
	private var keyDown:Array<Bool>;
	
	private var leftKey:Int = KeyboardEvent.DOM_VK_LEFT;
	private var rightKey:Int = KeyboardEvent.DOM_VK_RIGHT;
	private var jumpKey:Int = KeyboardEvent.DOM_VK_UP;
	
	public function new() {
		keyDown = new Array<Bool>();
		
		Browser.window.addEventListener("keydown", onKeyDown);
		Browser.window.addEventListener("keyup", onKeyUp);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void{
		e.preventDefault();
		keyDown[e.keyCode] = true;
	}
	
	private function onKeyUp(e:KeyboardEvent):Void{
		e.preventDefault();
		keyDown[e.keyCode] = false;
	}
	
	private function isKeyDown(keyCode:Int):Bool{
		if(keyDown.length < keyCode){
			return false;
		}
		
		return keyDown[keyCode] == true ? true : false;
	}
	
	public function getMovement():Float{
		var m:Float = 0;
		if(isKeyDown(leftKey)){
			m -= 1;
		}
		
		if(isKeyDown(rightKey)){
			m += 1;
		}
		
		return m;
	}
	
	public function getJump():Bool{
		return isKeyDown(jumpKey);
	}
}