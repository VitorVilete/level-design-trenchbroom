extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	print("Jump")
	if player.is_on_floor():
		if Input.is_action_pressed("crouch") && Input.is_action_pressed("sprint"):
			state_machine.transition_to("Sliding")
		elif Input.is_action_pressed("sprint"):
			state_machine.transition_to("Sprinting")
		elif Input.is_action_pressed("crouch"):
			state_machine.transition_to("Crouching")
		else:
			state_machine.transition_to("Walking")
