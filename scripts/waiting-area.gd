extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var id = Globals.id
var num_of_players = Globals.player_num
export var width = 50
var player_base = preload("res://scenes/player-puppet.tscn")
var model
var got_pos
var i = 0
var pos_arr = []
var move_arr = []
var got_move
var act_move
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
	#print("the data:",data)
	got_data = data.split("~")
	got_pos = got_data[0]
	got_pos = got_pos.substr(1)
	got_move = got_data[1]
	act_move = str2var(got_move)
	#print(act_move)
	got_id = got_data[2]
	act_pos = str2var(got_pos)
	#print("len:",len(PLAYERS),"num:",num_of_players)
	if (len(PLAYERS) < num_of_players && PLAYERS.has(got_id) == false):
		get_node(str(i)).set_name(got_id)
		i += 1
		PLAYERS[got_id] = get_node(got_id)
	#print("set act pos of:",got_id,"as :",act_pos)
	get_node(got_id).global_transform.origin = act_pos
	get_node(got_id).get_node("KinematicBody").move = act_move
	

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
	
