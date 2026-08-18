extends Node2D

@onready var arrowanim: AnimationPlayer = $OptionButton/AnimationPlayer
@onready var ori: Texture2D = load("res://epicbg.png")
@onready var stranded: Texture2D = load("res://coolbg.png")
@onready var bg: TextureRect = $Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.gamemode = "ori"
	arrowanim.play("arrows")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_3_pressed() -> void:
	Transtition.trans("level_scene")


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		bg.texture = ori 
		Global.gamemode = "ori"
	elif index == 1:
		bg.texture = stranded 
		Global.gamemode = "stranded"
	elif index == 2:
		Global.gamemode = "refined"
	elif index == 3:
		Global.gamemode = "infinity"
