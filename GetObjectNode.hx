package armory.logicnode;

import iron.object.Object;

class GetObjectNode extends LogicNode {

  public var property0: String;
  var obj: Object;
  var str: String;

  public function new(tree: LogicTree) {
    super(tree);
  }

  override function get(from: Int): Dynamic {
    
    switch (property0) {
      case "by_name":
        if (inputs[0].get() == null) return null;
        return inputs[0].get();
      case "contains":
        return contains();
      case "starts_with": return startsWith();
      case "ends_with": return endsWith();
    }
    return null;
  }

  function contains(): Object {
    obj = inputs[0].get();
    str = inputs[1].get();
    if (obj == null || str == "") return null;
    if (obj.name.indexOf(str) >= 0) return obj;
    return null;
  }

  function startsWith(): Object {
    obj = inputs[0].get();
    str = inputs[1].get();
    if (obj == null || str == "") return null;
    if (StringTools.startsWith(obj.name, str)) return obj;
		return null;
	}

  function endsWith(): Object {
    obj = inputs[0].get();
    str = inputs[1].get();
    if (obj == null || str == "") return null;
    if (StringTools.endsWith(obj.name, str)) return obj;
		return null;
	}
}