extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var id = Globals.id
var num_of_players = Globals.player_num
export var width = 15
var player_base = preload("res://scenes/player-puppet.tscn")
var model
var got_pos
var i = 0
var pos_arr = []
var got_data
var act_pos = Vector3.ZERO
var got_id
var changing_trans = global_transform.origin
var PLAYERS = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process_data(data):
	print("the data:",data)
	got_data = data.split(")")
	got_pos = got_data[0]
	got_pos = got_pos.substr(1)
	got_id = got_data[1]
	pos_arr = got_pos.split(",")
	act_pos.x = float(pos_arr[0])
	act_pos.y = float(pos_arr[1])
	act_pos.z = float(pos_arr[2])
	print("len:",len(PLAYERS),"num:",num_of_players)
	print_tree()
	if (len(PLAYERS) < num_of_players && PLAYERS.has(got_id) == false):
		get_node(str(i)).set_name(got_id)
		i += 1
		PLAYERS[got_id] = get_node(got_id)
	print_tree()
	print("set act pos of:",got_id,"as :",act_pos)
	get_node(got_id).global_transform.origin = act_pos
	
	

func start_game():
	changing_trans.x -= (width / 2)
	num_of_players = Globals.player_num
	changing_trans.y = 1
	get_node("player/KinematicBody").global_transform.origin = changing_trans
	while (i<num_of_players):
		#spawn player_base at changing_trans
		model = player_base.instance()
		add_child(model)
		model.set_name(str(i))
		model.global_transform.origin = changing_trans
		changing_trans.x += (width / (num_of_players+1))
		i += 1
	i = 0
	
