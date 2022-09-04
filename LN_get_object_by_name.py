import bpy
from arm.logicnode.arm_nodes import *

class GetObjectNode(ArmLogicTreeNode):
    """Searches for a object that uses the given name in the current active scene and returns it."""

    bl_idname = 'LNGetObjectNode'
    bl_label = 'Get Object by Name'
    arm_version = 2

    operators = {
        'by_name': 'By Name',
        'contains': 'Contains',
        'starts_with': 'Starts With',
        'ends_with': 'Ends With'
    }

    def set_mode(self, context):
        if self.property0 == 'by_name':
            if len(self.inputs) > 1:
                self.inputs.remove(self.inputs[1])
        else:
            if len(self.inputs) < 2:
                self.add_input('ArmStringSocket', 'String')

    property0: HaxeEnumProperty(
        'property0',
        items=[
            ('by_name', 'By Name', 'Selects scene object if object name matches given string'),
            None,
            ('contains', 'Contains', 'Selects scene object if object name contains given string'),
            ('starts_with', 'Starts With', 'Selects scene object if object name starts with given string'),
            ('ends_with', 'Ends With', 'Selects scene object if object name ends with given string')
        ],
        name='',
        description='Chosen method for getting a scene object',
        default='by_name',
        update=set_mode
    )

    def arm_init(self, context):
        self.add_input('ArmNodeSocketObject', 'Object')

        self.add_output('ArmNodeSocketObject', 'Object')

    def draw_buttons(self, context, layout):
        layout.prop(self, 'property0')

    def get_replacement_node(self, node_tree: bpy.types.NodeTree):
        if self.arm_version not in (0, 1):
            raise LookupError()

        newnode = node_tree.nodes.new('LNGetObjectNode')
        
        try:
            newnode.inputs[0].default_value_raw = bpy.data.objects[str(self.inputs[0].default_value_raw)]
        except:
            pass

        for link in self.outputs[0].links:
            node_tree.links.new(newnode.outputs[0], link.to_socket)

        return newnode