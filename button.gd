extends Node2D

@onready var gearanim:AnimationPlayer = $Gear/AnimationPlayer
@onready var gear:Sprite2D = $Gear
@onready var traveller:Sprite2D = $Traveller
@onready var travelleranim:AnimationPlayer = $Traveller/AnimationPlayer
@onready var achieve:TextureButton = $acheivements
@onready var achievebling:Sprite2D = $acheivements/Th
@onready var achieveanim:AnimationPlayer = $acheivements/AnimationPlayer
@onready var buttoncontainer: VBoxContainer = $VBoxContainer

var current_tween: Tween
var play_tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	achieveanim.play("thorpy")
	if Global.data["achieve"]["minigames_played"] >= 20 and Global.data["Gamemodes"].find(4) == -1:
		Global.data["Gamemodes"].append(4)
	achieve.pressed.connect(func():
		Transtition.trans("achievements"))
	achieve.mouse_entered.connect(func():
		achieve.scale += Vector2(0.1, 0.1)
		achievebling.show())
	achieve.mouse_exited.connect(func():
		achieve.scale -= Vector2(0.1, 0.1)
		achievebling.hide())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_3_pressed() -> void:
	Global.speed = 1
	Global.lives = 5
	Global.minigames_done = 0
	for i in buttoncontainer.get_children():
		i.disabled = true
	Transtition.trans("modeselect")


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")



func _on_button_2_mouse_entered():
	if current_tween:
		current_tween.kill()

	gearanim.play("gearspin")
	current_tween = create_tween()
	current_tween.tween_property(gear, "global_position:x", 975, 0.5)

func _on_button_2_mouse_exited():
	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_property(gear, "global_position:x", 1400, 0.5)


func _on_button_3_mouse_entered() -> void:
	if play_tween:
		play_tween.kill()
	travelleranim.play("hover")
	play_tween = create_tween()
	play_tween.tween_property(traveller, "global_position:x", 150, 0.5)


func _on_button_3_mouse_exited() -> void:
	if play_tween:
		play_tween.kill()
	play_tween = create_tween()
	play_tween.tween_property(traveller, "global_position:x", -260, 0.5)
