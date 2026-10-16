extends Node2D

@onready var arrowanim: AnimationPlayer = $OptionButton/AnimationPlayer
@onready var option: OptionButton = $OptionButton
@onready var button: Button = $Button3
var backgrounds: Dictionary = {"ori": load("res://epicbg.png") as Texture2D, "stranded": load("res://coolbg.png") as Texture2D, "refined": load("res://awesomebg.png") as Texture2D, "hideout": load("res://alienbg.png") as Texture2D, "infinity": load("res://infbg.png") as Texture2D}
var diffbackgrounds: Dictionary = {"Normal": null, "Hard": load("res://hard.png") as Texture2D, "Hell": load("res://hell.png") as Texture2D}
@onready var bg: TextureRect = $Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.difficulty = "Normal"
	Global.gamemode = "ori"
	arrowanim.play("arrows")
	for i in Global.data["Gamemodes"]:
		option.set_item_disabled(i - 1, false)



func _on_button_3_pressed() -> void:
	Acheivements.alerts = []
	option.disabled = true
	button.disabled = true
	if Global.difficulty == "Hell":
		Global.lives = 1
	Transtition.trans("level_scene")


func _on_option_button_item_selected(index: int) -> void:
	Global.gamemode = backgrounds.keys()[index]
	bg.texture = backgrounds[Global.gamemode] 


func _on_option_button_2_item_selected(index: int) -> void:
	Global.difficulty = diffbackgrounds.keys()[index]
	$Background/Node2D/TextureRect.texture = diffbackgrounds[Global.difficulty] 
