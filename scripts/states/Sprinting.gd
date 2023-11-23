extends PlayerState

# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.current_speed = player.SPRINTING_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	print("Sprint")
	# Transitioning to jumping in case the player starts falling without jumping
	# ie.: falling platform or falling
	if not player.is_on_floor():
		state_machine.transition_to("Jumping")
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jumping")
	else:
		if Input.is_action_pressed("crouch") && Input.is_action_pressed("sprint") && player.input_dir:
			state_machine.transition_to("Sliding", {})
		elif Input.is_action_pressed("crouch"):
			state_machine.transition_to("Crouching", {})
		elif !Input.is_action_pressed("sprint"):
			state_machine.transition_to("Walking")
