extends Area3D

signal trigger(is_entering: bool)

func _ready():
	connect("body_entered", handle_body_entered)
	connect("body_exited", handle_body_exited)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)

func handle_body_entered(body: Node):
	if body is StaticBody3D or body is RigidBody3D:
		return
	
	emit_signal("trigger", true)

func handle_body_exited(body: Node):
	if body is StaticBody3D or body is RigidBody3D:
		return
		
	emit_signal("trigger", false)
