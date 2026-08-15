extends Node2D
@onready var themed_timer: Node2D = $Time
@onready var buttons: HBoxContainer = $Buttons
@onready var arrow: Sprite2D = $Arrow
@onready var sound: AudioStreamPlayer2D = $ping
var hovering: bool = false
var order = []
var index: int = 0


var timer_end = false # boolean (true or false) stating whether the timer ended

func _ready() -> void:
	
	while Transtition.transtitioning:
		await get_tree().process_frame
	Global.minigame4.connect(click)
	await wait(1/Global.speed)
	for i in range((Global.minigames_done)/2 + 3):
		arrow.show()
		var temp = randi_range(1, 4)
		print(temp)
		order.append(temp)
		var button = buttons.get_child(temp - 1)
		arrow.global_position = button.get_global_rect().get_center() - Vector2(0, 150)
		sound.play()
		
		await wait(1/Global.speed)
	arrow.hide()
	for i in buttons.get_children():
		i.disabled = false
	
	
	await themed_timer.Timer(5.0 / Global.speed) #accessing a function from this node
	#after this is compeleted...
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn") # back to intermission
		
func hover():
	hovering = true
func hoverleft():
	hovering = true

func click(num: int):
	sound.play()
	print(num)
	if order[index] == num:
		index += 1
		if index == len(order):
			for i in buttons.get_children():
				i.disabled = true
			
			Transtition.trans("level_scene")
	else:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene")
		

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait
