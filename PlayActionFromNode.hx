package armory.logicnode;

import iron.object.Object;
import iron.object.Animation;
import iron.Scene;

class PlayActionFromNode extends LogicNode {
	
	var anim_prox: Animation;
	var startFrame_prox: Int;
	var endFrame_prox: Int;

	public function new(tree: LogicTree) {
		super(tree);

		tree.notifyOnUpdate(update);
	}

	function update() {
		if (anim_prox.currentFrame() >= endFrame_prox) {
			// anim_prox.frameIndex = startFrame_prox;
			anim_prox.frameIndex = 0;
			// trace(anim_prox.frameIndex);
		}
	}
	
	override function run(from: Int) {
		var object: Object = inputs[1].get();
		var action: String = inputs[2].get();
		var startFrame:Int = inputs[3].get();
		var endFrame:Int = inputs[4].get();
		var blendTime: Float = inputs[5].get();
		var speed: Float = inputs[6].get();
		var loop: Bool = inputs[7].get();

		if (object == null) return;
		var animation = object.animation;
		if (animation == null) animation = object.getParentArmature(object.name);
		
		anim_prox = animation;
		startFrame_prox = startFrame;
		endFrame_prox = endFrame;

		animation.play(action, function() {
			runOutput(1);
		}, blendTime, speed, loop);
		animation.update(startFrame*Scene.active.raw.frame_time);
		
		runOutput(0);
	}
}
