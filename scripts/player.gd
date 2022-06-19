extends KinematicBody
export var SPEED = 42
export var JUMP = 1.5
export var GRAVITY = 0.05
export var websocket_url = "wss://websocket-tripping-girls-and-enbies.jonathanbreitg.repl.co"
export var in_game = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var joystick = $VirtualJoystick
onready var jump_bool = false
onready var to_send_arr = []
onready var old_y = 0
onready var just_jumped = false
onready var move = Vector3.ZERO
onready var scene_name = get_tree().get_current_scene().get_name()
export(NodePath) onready var cameraRig = get_node(cameraRig) as Spatial


var id = Globals.id
var skin = Globals.skin

var _client = WebSocketClient.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MeshInstance").set_surface_material(0,skin)
	print(scene_name)
	if scene_name == "waiting-area":
		in_game = false
		print("not in game")
	else:
		in_game = true
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		get_tree().change_scene("res://scenes/main-menu.tscn")
		#set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	
	
	
	var dir = joystick.get_value()
	move.x = dir.x
	move.z = dir.y
	move.x = -move.x
	move.z = -move.z
	old_y = move.y
	move = move.rotated(Vector3.UP, cameraRig.rotation.y).normalized()
	move.y = old_y
	move_and_slide(move*SPEED,Vector3.UP)
	if is_on_floor():
		move.y = 0
	if just_jumped:
		move.y = JUMP
		just_jumped = false
	if !is_on_floor():
		move.y -= GRAVITY
	_client.poll()
	if in_game:
		var to_send = ""
		to_send += "d:"
		to_send += "["
		to_send += var2str(global_transform.origin)
		to_send += "~"
		to_send += var2str(move)
		to_send += "~"
		to_send += id
		to_send += "]"
		#print(to_send)
		_client.get_peer(1).put_packet(to_send.to_utf8())
		#_client.get_peer(1).put_packet("Test packet".to_utf8())


func _on_TouchScreenButton_pressed():
	#jump logic
	print("jumped!")
	if is_on_floor():
		just_jumped = true



func _closed(was_clean=false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	get_tree().change_scene("res://scenes/main-menu.tscn")
	set_process(false)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	if in_game == false:
		_client.get_peer(1).put_packet("j:".to_utf8())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var data = _client.get_peer(1).get_packet().get_string_from_utf8()
	data = data.replace('"',"")
	#print("Got data from server: ", data)
	if !in_game:
		if (data.begins_with("STARTING GAME")):
			get_parent().get_parent().get_node("Label").text = "STARTING GAME..."
			print("starting epic game")
			if int(id) == -1:
				id =data.trim_prefix("STARTING GAME")
				print("our id is:",id)
				Globals.id = id
			
			#get_tree().change_scene("res://scenes/map.tscn")
			get_parent().get_parent().start_game()
			in_game = true
			return
		elif (data.begins_with("game is already running...")):
			get_parent().get_parent().get_node("Label").text = "game is already running..."
			if int(id) == -1:
				id =data.trim_prefix("game is already running...")
				Globals.id = id
			print("game ongoing")
		elif (data.begins_with("waiting for other players to join...")):
			get_parent().get_parent().get_node("Label").text = "waiting for other players to join..."
			if int(id) == -1:
				id =data.trim_prefix("waiting for other players to join...")
				Globals.id = id
			print("waiting")
		elif (int(data) < 16):
			Globals.player_num = int(data)
			print("this many other players: ",data)
		else:
			get_parent().get_parent().get_node("Label").text = data
	if in_game:
		#other players move logic...
		#print('no logic yet')
		get_parent().get_parent()._process_data(data)
		

func _input(event):
   # Mouse in viewport coordinates.
   if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)
   elif event is InputEventMouseMotion:
	   print("Mouse Motion at: ", event.position)

   # Print the size of the viewport.
  # print("Viewport Resolution is: ", get_viewport_rect().size)
