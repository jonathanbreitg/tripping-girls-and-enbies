extends KinematicBody
export var SPEED = 42
export var JUMP = 1.5
export var GRAVITY = 0.05
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var jump_bool = false
onready var just_jumped = false
onready var move = Vector3.ZERO
onready var dir = Vector3.ZERO
onready var scene_name = get_tree().get_current_scene().get_name()
var id = "-5"
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta):
	#move_and_slide(move*SPEED,Vector3.UP)
	
