extends PlayerState

# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	print("Slide")
	# Transitioning to jumping in case the player starts falling without jumping
	# ie.: falling platform or falling
	if not player.is_on_floor():
		state_machine.transition_to("Jumping")
		return
	player.slide_timer -= delta
	if player.slide_timer <= 0:
		state_machine.transition_to("Crouching")
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jumping")
