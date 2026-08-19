extends Node2D

@onready var arrowanim: AnimationPlayer = $OptionButton/AnimationPlayer
@onready var option: OptionButton = $OptionButton
@onready var button: Button = $Button3
@onready var ori: Texture2D = load("res://epicbg.png")
@onready var stranded: Texture2D = load("res://coolbg.png")
@onready var refine: Texture2D = load("res://awesomebg.png")
@onready var inf: Texture2D = load("res://infbg.png")
@onready var bg: TextureRect = $Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.gamemode = "ori"
	arrowanim.play("arrows")
	for i in Global.data["Gamemodes"]:
		option.set_item_disabled(i - 1, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_3_pressed() -> void:
	option.disabled = true
	button.disabled = true
	Transtition.trans("level_scene")


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		bg.texture = ori 
		Global.gamemode = "ori"
	elif index == 1:
		bg.texture = stranded 
		Global.gamemode = "stranded"
	elif index == 2:
		bg.texture = refine 
		Global.gamemode = "refined"
	elif index == 3:
		bg.texture = inf 
		Global.gamemode = "infinity"
