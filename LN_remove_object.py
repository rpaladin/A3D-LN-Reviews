from arm.logicnode.arm_nodes import *

class RemoveObjectNode(ArmLogicTreeNode):
    """
    Removes the given object from the scene.
    In = Which input to execute the logic node Haxe code.
    Object = Which object to remove.
    Remove Children = Whether to remove given object's children as well.
    Keep Children Transforms = Whether given object's children will maintain current transforms or revert to initial runtime transforms when un-parented.
    """
    bl_idname = 'LNRemoveObjectNode'
    bl_label = 'Remove Object'
    arm_version = 2

    def arm_init(self, context):
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmNodeSocketObject', 'Object')
        self.add_input('ArmBoolSocket', 'Remove Children', default_value=True)
        self.add_input('ArmBoolSocket', 'Keep Children Transforms', default_value=True)

        self.add_output('ArmNodeSocketAction', 'Out')

    def get_replacement_node(self, node_tree: bpy.types.NodeTree):
        if self.arm_version not in (0, 1):
            raise LookupError()

        return NodeReplacement.Identity(self)