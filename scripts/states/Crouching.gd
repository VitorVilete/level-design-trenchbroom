extends PlayerState

func enter(_msg := {}) -> void:
	player.current_speed = player.CROUCHING_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	print("Crouch")
	# Transitioning to jumping in case the player starts falling without jumping
	# ie.: falling platform or falling
	if not player.is_on_floor():
		state_machine.transition_to("Jumping")
		return

	if !player.ray_cast_3d.is_colliding():
		if Input.is_action_just_pressed("jump"):
			state_machine.transition_to("Jumping")
		else:
			if !Input.is_action_pressed("crouch"):
				state_machine.transition_to("Walking")
