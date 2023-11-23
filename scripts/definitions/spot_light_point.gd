extends SpotLight3D

@export var properties : Dictionary

func _ready():
	# split rgb values then converting to a Color class
	var components = properties["light_color"].split(" ")
	light_color = Color(float(components[0])/255, float(components[1])/255,
	float(components[2])/255)
	
	# setting range
	spot_range = properties["range"]
	shadow_enabled = true
	# setting energy
	light_energy = properties["energy"]
		# setting rotation
	var degrees = properties["rotation"].split(" ")
	set_rotation_degrees(Vector3(float(degrees[0]),float(degrees[1]),float(degrees[2])))
	
