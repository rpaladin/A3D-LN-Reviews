package armory.logicnode;

import iron.Scene;

class GroupNode extends LogicNode {

	public var property0: String;
	public var value: Array<Dynamic> = [];

	public function new(tree: LogicTree) {
		super(tree);

		iron.Scene.active.notifyOnInit(function() {
			get(0);
		});
	}

	override function get(from: Int): Dynamic {
		if (property0 != null) {
			value = Scene.active.getGroup(property0);
		}

		return value;
	}

	override function set(value: Dynamic) {
		this.value = value;
	}
}
