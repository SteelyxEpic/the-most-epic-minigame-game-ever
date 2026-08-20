extends Node2D
@onready var themed_timer: Node2D = $Time 
const DRAG = preload("res://draggable.tscn")
@onready var rock:Texture2D = load("res://rock.png") as Texture2D
@onready var ore: Texture2D = load("res://ore.png") as Texture2D
@onready var player_area: Area2D = $Furnace/Area2D
var amount: int
var needed: int
var given: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	amount = randi_range(3, 5+Global.minigames_done/2)
	for i in range(amount):
		var drag_instance = DRAG.instantiate()
		add_child(drag_instance)
		drag_instance.position = Vector2(randf_range(201, 602), randf_range(-2, 415))
		drag_instance.texture_normal = ore
		if randi_range(0, 1) && i > 0:
			drag_instance.texture_normal = rock
			drag_instance.rock = true
		else:
			needed += 1
		drag_instance.player_area = player_area
	await themed_timer.Timer(5.0 / Global.speed) #accessing a function from this node
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene") # back to intermission

# Called every frame. 'delta' is the elapsed time since the previous frame.
func entered():
	given += 1
	if needed == given:
		Transtition.trans("level_scene")
