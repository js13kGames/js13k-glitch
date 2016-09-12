package lcann.glitch.end;

/**
 * ...
 * @author Luke Cann
 */
class FworkMan {

	public var f:List<FWU>;
	private var t:Float;

	public function new() {
		f = new List<FWU>();
		t = 0.3 + Math.random() * 2;
	}

	public function update(s:Float) {
		t -= s;
		if(t <= 0){
			t = 0.3 + Math.random() * 2;
			f.add(new Fwork());
		}
		
		for(i in f){
			i.update(s, this);
		}
	}
	
}