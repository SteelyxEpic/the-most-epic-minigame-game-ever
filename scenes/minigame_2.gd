extends Node2D

@onready var themed_timer: Node2D = $Time
@onready var remain: RichTextLabel = $remain

var buttons_pressed := 0
var timer_end = false
const MY_BUTTON_SCENE = preload("res://button_minigame2.tscn")

var numberbuttons = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	numberbuttons = rng.randi_range(5, 5 + Global.minigames_done/2)
	spawn_button()
	await themed_timer.Timer(7.0 / Global.speed)
	#after this is completed...
	timer_end = true 

func spawn_button() -> void:
	remain.text = str(numberbuttons - buttons_pressed) + " remaining"
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	print("spawning")
	var button_instance = MY_BUTTON_SCENE.instantiate()
	button_instance.name = str(buttons_pressed)
	add_child(button_instance)
	button_instance.position = Vector2(rng.randf_range(0, get_viewport_rect().size.x/1.5), rng.randf_range(0, get_viewport_rect().size.y/1.5))
	
	
	

func _process(delta: float) -> void:
	if buttons_pressed == numberbuttons:
		
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
	
	if timer_end:
		Global.lost = true
		Global.lives -= 1
		Global.minigames_done -=1
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
