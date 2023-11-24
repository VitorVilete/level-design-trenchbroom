@tool
extends QodotEntity

var light_node: Light3D = null

func update_properties():
	if not Engine.is_editor_hint():
		return
	
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	light_node = SpotLight3D.new()
	
	if 'rotation' in properties:
		var degrees = properties['rotation'].split(" ")
		light_node.set_rotation_degrees(Vector3(float(degrees[0]),float(degrees[1]),float(degrees[2])))
	
	if 'angle' in properties:
		light_node.spot_angle = properties['angle']
	
	var light_brightness = 300
	if 'energy' in properties:
		light_brightness = properties['energy']
		light_node.set_param(Light3D.PARAM_ENERGY, light_brightness / 100.0)
		light_node.set_param(Light3D.PARAM_INDIRECT_ENERGY, light_brightness / 100.0)
	
	var spot_range = 1.0
	if 'range' in properties:
		light_node.spot_range = properties['range']
	
	var light_range := 1.0
	if 'wait' in properties:
		light_node.light_range = properties['wait']
	
	light_node.set_shadow(true)
	light_node.set_bake_mode(Light3D.BAKE_STATIC)
	
	var light_color = Color.WHITE
	if 'light_color' in properties:
		light_color = properties['light_color']
	
	light_node.set_color(light_color)
	
	add_child(light_node)
	
	if is_inside_tree():
		var tree = get_tree()
		if tree:
			var edited_scene_root = tree.get_edited_scene_root()
			if edited_scene_root:
				light_node.set_owner(edited_scene_root)

