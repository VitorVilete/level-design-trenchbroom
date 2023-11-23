extends OmniLight3D

@export var properties : Dictionary

func _ready():
	# The name of the "properties" are the names of the actual properties of the
	# OmniLight3D class.
	# This script get the values from Trenchbroom via FGD and you can add
	# any interaction from here on as if it were a OmniLight3D.
	
	# split rgb values then converting to a Color class
	var components = properties["light_color"].split(" ")
	light_color = Color(float(components[0])/255, float(components[1])/255,
	float(components[2])/255)
	omni_range = properties["range"]
	shadow_enabled = true
	light_energy = properties["energy"]
