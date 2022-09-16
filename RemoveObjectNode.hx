package armory.logicnode;

import iron.object.Object;
import armory.trait.physics.RigidBody;

class RemoveObjectNode extends LogicNode {

	public function new(tree: LogicTree) {
		super(tree);
	}

	override function run(from: Int) {
		var object: Object = inputs[1].get();
		var removeChildren: Bool = inputs[2].get();
		var keepChildrenTransforms: Bool = inputs[3].get();

		if (object == null) return;
		
		if (removeChildren == false) {
			if (object.children.length > 0) {
				for (c in object.children) {
					c.setParent(iron.Scene.active.root, false, keepChildrenTransforms);
					
					#if arm_physics
					var rigidBody = c.getTrait(RigidBody);
					if (rigidBody != null) rigidBody.syncTransform();
					#end
				}
			} else {
				object.remove();
			}
		} else {
			object.remove();
		}
		runOutput(0);
	}
}