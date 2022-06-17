extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var id = Globals.id
var num_of_players = Globals.player_num
export var width = 15
var player_base = preload("res://scenes/player-puppet.tscn")
var model
var changing_trans = global_transform.origin

# Called when the node enters the scene tree for the first time.
func _ready():
	changing_trans.x -= (width / 2)
	changing_trans.y = 1
	
	var i = 0
	while (i<num_of_players):
		#spawn player_base at changing_trans
		model = player_base.instance()
		add_child(model)
		model.set_name(str(i))
		model.global_transform.origin = changing_trans
		changing_trans.x += (width / (num_of_players+1))
		i += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process_data(data):
	print("the data:",data)
