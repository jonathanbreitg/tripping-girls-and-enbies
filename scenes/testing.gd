extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Material) var material
# Called when the node enters the scene tree for the first time.
func _ready():
	#set skin logic
	get_node("player2/KinematicBody/MeshInstance").set_surface_material(0,material)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
