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
var ids = []
var pos_arr = []
var move_arr = []
var got_move
var act_move
var got_data
var act_pos = Vector3.ZERO
var got_id
var got_skin
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
	if data.begins_with("s:"):
		data = data.substr(2)
		got_data = data.split(",")
		got_id = got_data[0]
		got_skin = got_data[1]
		print_tree()
		print(got_id)
		id = Globals.id
		if (got_id != id):
			get_node(got_id).get_node("KinematicBody/MeshInstance").set_surface_material(0,load("res://skins-materials/"+got_skin+".material"))
		
	else:
		got_data = data.split("~")
		got_pos = got_data[0]
		got_pos = got_pos.substr(1)
		got_move = got_data[1]
		act_move = str2var(got_move)
		#print(act_move)
		got_id = got_data[2]
		act_pos = str2var(got_pos)
		#print("len:",len(PLAYERS),"num:",num_of_players)
		#print("set act pos of:",got_id,"as :",act_pos)
	#	print_tree()
	#	print(got_id)
		
	#	print(ids)
		got_id = got_id.replace("]","")
		get_node(got_id).global_transform.origin = lerp(get_node(got_id).global_transform.origin,act_pos,0.8)
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
		print(ids)
		model.set_name(str(ids[i]))
		model.global_transform.origin = changing_trans
		changing_trans.x += (width / (num_of_players+1))
		i += 1
	i = 0
