extends MeshInstance
export var TURN_SPEED = 50
var to = Vector3.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = get_parent().move
	if (move != Vector3.ZERO):
		to.x = lerp(global_transform.origin.x,global_transform.origin.x-move.x,0.1)
		to.y = lerp(global_transform.origin.y,global_transform.origin.y-move.y,0.1)
		to.z = lerp(global_transform.origin.z,global_transform.origin.z-move.z,0.1)
		look_at(to,Vector3.UP)
