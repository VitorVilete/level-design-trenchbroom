class_name Player

extends CharacterBody3D

# Nodes
@onready var neck = $Neck
@onready var head = $Neck/Head
@onready var eyes = $Neck/Head/Eyes
@onready var camera_3d = $Neck/Head/Eyes/Camera3D

@onready var standing_collision_shape = $StandingCollisionShape
@onready var crouching_collision_shape = $CrouchingCollisionShape
@onready var ray_cast_3d = $RayCast3D

# Preferences
@export var can_crouch = true
@export var can_sprint = true

# Speed
var current_speed = 5.0
const CROUCHING_SPEED = 3.0
const WALKING_SPEED = 5.0
const SPRINTING_SPEED = 8.0
const JUMP_VELOCITY = 4.5
var lerp_speed = 10.0
var slide_speed = 10.0

# States
enum CameraState {
	FIRST_PERSON,
	FREE_LOOK
}
enum MovementState {
	WALKING,
	SPRINTING,
	CROUCHING,
	SLIDING,
	JUMPING
}
var currentMovementState = 0
var currentCameraState = 0
var walking = false
var sprinting = false
var crouching = false
var free_looking = false
var sliding = false

# Slide vars
var slide_timer = 0.0
var slide_timer_max = 1.0
var slide_vector = Vector2.ZERO

# Head bobbing vars
const HEAD_BOBBING_SPRINTING_SPEED = 22.0
const HEAD_BOBBING_WALKING_SPEED = 14.0
const HEAD_BOBBING_CROUCHING_SPEED = 10.0

const HEAD_BOBBING_SPRINTING_INTENSITY = 0.2
const HEAD_BOBBING_WALKING_INTENSITY = 0.1
const HEAD_BOBBING_CROUCHING_INTENSITY = 0.05

var head_bobbing_vector = Vector2.ZERO
var head_bobbing_index = 0.0
var head_bobbing_current_intensity = 0.0

# Input
@export var mouse_sense := 0.05
var direction = Vector3.ZERO

# Movement
var crouching_depth = -0.5
var player_height = 0.0
var free_look_tilt_amount = 8

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	player_height = head.position.y

func _unhandled_input(event):
	# Capturing & handling mouse movement
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion:
		if currentCameraState == CameraState.FREE_LOOK:
			neck.rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
			neck.rotation.y = clamp(neck.rotation.y, deg_to_rad(-120), deg_to_rad(120))
			
		rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	print(currentMovementState)
	# Getting movement input
	var input_dir = Input.get_vector("walk_left", "walk_right", 
	"walk_forward", "walk_backwards")
	# Handling movement states
	# Crouching
	if can_crouch && (Input.is_action_pressed("crouch") || currentMovementState == MovementState.SLIDING):
		current_speed = CROUCHING_SPEED
		head.position.y = lerp(head.position.y, 
		player_height + crouching_depth, delta * lerp_speed)
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
		
		if currentMovementState == MovementState.SPRINTING && input_dir != Vector2.ZERO:
			currentMovementState = MovementState.SLIDING
			slide_timer = slide_timer_max
			slide_vector = input_dir

	# Standing
	elif !ray_cast_3d.is_colliding():
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		head.position.y = lerp(head.position.y, 
		player_height, delta * lerp_speed)

		# Sprinting
		if can_sprint && Input.is_action_pressed("sprint"):
			current_speed = SPRINTING_SPEED
			currentMovementState = MovementState.SPRINTING

		# Walking
		else:
			current_speed = WALKING_SPEED
			currentMovementState = MovementState.WALKING
	# Handle free looking
	if Input.is_action_pressed("free_look") || currentMovementState == MovementState.SLIDING:
		currentCameraState = CameraState.FREE_LOOK
		if currentMovementState == MovementState.SLIDING:
			camera_3d.rotation.z = lerp(camera_3d.rotation.z,-deg_to_rad(7.0), delta * lerp_speed)
		else:
			camera_3d.rotation.z = -deg_to_rad(neck.rotation.y * free_look_tilt_amount)
	else:
		currentCameraState = CameraState.FIRST_PERSON
		neck.rotation.y = lerp(neck.rotation.y, 0.0, delta * lerp_speed)
		camera_3d.rotation.z = lerp(camera_3d.rotation.z, 0.0, delta * lerp_speed)
	# Handle sliding
	if currentMovementState == MovementState.SLIDING:
		slide_timer -= delta
		if slide_timer <= 0:
			currentMovementState = MovementState.CROUCHING
			currentCameraState = CameraState.FIRST_PERSON
	# Handle headbob
	if currentMovementState == MovementState.SPRINTING:
		head_bobbing_current_intensity = HEAD_BOBBING_SPRINTING_INTENSITY
		head_bobbing_index += HEAD_BOBBING_SPRINTING_SPEED * delta
	elif currentMovementState == MovementState.WALKING:
		head_bobbing_current_intensity = HEAD_BOBBING_WALKING_INTENSITY 
		head_bobbing_index += HEAD_BOBBING_WALKING_SPEED * delta
	elif currentMovementState == MovementState.CROUCHING:
		head_bobbing_current_intensity = HEAD_BOBBING_CROUCHING_INTENSITY
		head_bobbing_index += HEAD_BOBBING_CROUCHING_SPEED * delta
		
	if is_on_floor() && currentMovementState != MovementState.SLIDING && input_dir != Vector2.ZERO:
		head_bobbing_vector.y = sin(head_bobbing_index)
		head_bobbing_vector.x = sin(head_bobbing_index/2)+0.5
		eyes.position.y = lerp(eyes.position.y, head_bobbing_vector.y*(head_bobbing_current_intensity/2.0),delta*lerp_speed)
		eyes.position.x = lerp(eyes.position.x, head_bobbing_vector.x*head_bobbing_current_intensity,delta*lerp_speed)
	else:
		eyes.position.y = lerp(eyes.position.y, 0.0,delta*lerp_speed)
		eyes.position.x = lerp(eyes.position.x, 0.0,delta*lerp_speed)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		currentMovementState = MovementState.JUMPING
		slide_timer = 0
		velocity.y = JUMP_VELOCITY

	# lerping the direction to make the movement feel less "snappy"
	direction = lerp(direction,
	(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), 
	delta * lerp_speed)
	
	if currentMovementState == MovementState.SLIDING:
		direction = transform.basis * Vector3(slide_vector.x,0,slide_vector.y).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		
		if currentMovementState == MovementState.SLIDING:
			velocity.x = direction.x * (slide_timer  + 0.1) * slide_speed
			velocity.z = direction.z * (slide_timer + 0.1) * slide_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
