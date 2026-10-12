extends Node2D
@onready var themed_timer: Node2D = $Time 
@onready var matching: Sprite2D = $Match/matching
@onready var alienempty: Sprite2D = $Alienempty
var value = [0, 0, 0]
var current = [1, 1, 1]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureButton.pressed.connect(func():
		current[0] += 1
		alienempty.find_child("alieneye").texture = load("res://minigame13/alieneye" + str(current[0]) +  ".png")
		check())
	$TextureButton4.pressed.connect(func():
		current[0] -= 1
		alienempty.find_child("alieneye").texture = load("res://minigame13/alieneye" + str(current[0]) +  ".png")
		check())
	$TextureButton3.pressed.connect(func():
		current[1] += 1
		alienempty.find_child("alienmouth").texture = load("res://minigame13/alienmouth" + str(current[1]) +  ".png")
		check())
	$TextureButton6.pressed.connect(func():
		current[1] -= 1
		alienempty.find_child("alienmouth").texture = load("res://minigame13/alienmouth" + str(current[1]) +  ".png")
		check())
	$TextureButton2.pressed.connect(func():
		current[2] += 1
		alienempty.find_child("aliennose").texture = load("res://minigame13/aliennose" + str(current[2]) +  ".png")
		check())
	$TextureButton5.pressed.connect(func():
		current[2] -= 1
		alienempty.find_child("aliennose").texture = load("res://minigame13/aliennose" + str(current[2]) +  ".png")
		check())
	while Transtition.transtitioning:
		await get_tree().process_frame
	value = [randi_range(1, 3), randi_range(1, 3), randi_range(1, 3)]
	matching.find_child("alieneye").texture = load("res://minigame13/alieneye" + str(value[0]) +  ".png")
	matching.find_child("alienmouth").texture = load("res://minigame13/alienmouth" + str(value[1]) +  ".png")
	matching.find_child("aliennose").texture = load("res://minigame13/aliennose" + str(value[2]) +  ".png")
	await themed_timer.Timer(10.0 / Global.speed) #accessing a function from this node
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene") # back to intermission

func check():
	print("didit!")
	if value == current:
		print("didit!")
		Transtition.trans("level_scene")
