package lcann.glitch;

import js.Browser;
import js.html.KeyboardEvent;

/**
 * ...
 * @author Luke Cann
 */
class Controls {
	private var kd:Array<Bool>;
	
	private var lk:Int = KeyboardEvent.DOM_VK_LEFT;
	private var rk:Int = KeyboardEvent.DOM_VK_RIGHT;
	private var jk:Int = KeyboardEvent.DOM_VK_UP;
	private var sk:Int = KeyboardEvent.DOM_VK_Z;
	private var gk:Int = KeyboardEvent.DOM_VK_X;
	
	public function new() {
		kd = new Array<Bool>();
		
		Browser.window.addEventListener("keydown", onKeyDown);
		Browser.window.addEventListener("keyup", onKeyUp);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void{
		e.preventDefault();
		kd[e.keyCode] = true;
	}
	
	private function onKeyUp(e:KeyboardEvent):Void{
		e.preventDefault();
		kd[e.keyCode] = false;
	}
	
	private function isKeyDown(keyCode:Int):Bool{
		if(kd.length < keyCode){
			return false;
		}
		
		return kd[keyCode] ? true : false;
	}
	
	public function getMovement():Float{
		var m:Float = 0;
		if(isKeyDown(lk)){
			m -= 1;
		}
		
		if(isKeyDown(rk)){
			m += 1;
		}
		
		return m;
	}
	
	public function getJump():Bool{
		return isKeyDown(jk);
	}
	
	public function getShoot():Bool{
		return isKeyDown(sk);
	}
	
	public function getGlitch():Bool{
		return isKeyDown(gk);
	}
}