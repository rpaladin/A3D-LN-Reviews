package armory.logicnode;

import iron.Scene;
import iron.data.SceneFormat.TSceneFormat;
import iron.data.Data;

class SceneNode extends LogicNode {

	public var property0: String;
	public var value: Scene;

	public function new(tree: LogicTree) {
		super(tree);

		iron.Scene.active.notifyOnInit(function() {
			get(0);
		});
	}

	override function get(from: Int): Dynamic {
		if (property0 != null) {
			value = iron.Scene.active.root.children.get(property0);
		}

		return value;
	}

	override function set(value: Dynamic) {
		this.value = value;
	}
}
