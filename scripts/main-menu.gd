extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var home = get_node("home")
onready var skins = get_node("skins")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/waiting-area.tscn")


func _on_Button2_pressed():
	home.visible = false
	skins.visible = true


func _on_TextureButton_pressed():
	home.visible = true
	skins.visible = false


func _on_TextureButton_rainbow_pressed():
	Globals.skin = preload("res://skins-materials/rainbow.material")

func _on_TextureButton_red_pressed():
	Globals.skin = preload("res://skins-materials/red.material")

func _on_TextureButton_orange_pressed():
	Globals.skin = preload("res://skins-materials/orange.material")
	
func _on_TextureButton_yellow_pressed():
	Globals.skin = preload("res://skins-materials/yellow.material")
	
func _on_TextureButton_purple_pressed():
	Globals.skin = preload("res://skins-materials/purple.material")

func _on_TextureButton_cyan_pressed():
	Globals.skin = preload("res://skins-materials/cyan.material")

func _on_TextureButton_floral_pressed():
	Globals.skin = preload("res://skins-materials/floral.material")


func _on_TextureButton_purple_striped_pressed():
	Globals.skin = preload("res://skins-materials/purple-striped.material")
