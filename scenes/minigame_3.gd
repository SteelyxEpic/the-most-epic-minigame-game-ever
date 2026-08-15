extends Node2D

@onready var time: Node2D = $Time
var timer_end:bool = false
const Asteroids = preload("res://asteriods.tscn")
@onready var player_area: Area2D = $Ship/Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	while Transtition.transtitioning:
		await get_tree().process_frame
	summon()
	await time.Timer(5.0 * Global.speed)
	#after this is completed...
	timer_end = true 
	
	Transtition.trans("level_scene")

func summon():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	print("spawning")
	while true:
		var asteriod_instance = Asteroids.instantiate()
		asteriod_instance.speed = 500 * Global.speed
		add_child(asteriod_instance)
		asteriod_instance.get_child(0).get_child(1).area_entered.connect(shape_entered)
		asteriod_instance.position = Vector2(get_viewport_rect().size.x, rng.randf_range(0, get_viewport_rect().size.y/5) * 5)
		await wait(3/Global.speed)
	
	
func wait(seconds: float) -> void: # write this simple function out for wait!
	if get_tree() != null:
		await get_tree().create_timer(seconds).timeout # makes u wait

func shape_entered(area: Area2D) -> void:
	if player_area == area: 
		hit()
func hit():
	if !timer_end && !Global.lost:
		Global.lost = true
		Global.lives -= 1
		Global.minigames_done -=1
		Transtition.trans("level_scene")
