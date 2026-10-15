extends Node2D
@onready var themed_timer: Node2D = $Time 
@onready var lazer: PackedScene = load("res://minigame15/lazer.tscn")

signal fire
signal aim

func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	var needed = randi_range(5, 8 + Global.minigames_done/2)
	for i in range(needed):
		var instance = lazer.instantiate()
		instance.name = str(i)
		instance.main = self
		add_child(instance)
		instance.position = Vector2(randf_range(0, get_viewport_rect().size.x/10)*10, randf_range(0, get_viewport_rect().size.y/10)*10)
		instance.target = $Ship
	await themed_timer.Timer(2.0 / Global.speed) #accessing a function from this node
	emit_signal("aim")
	await themed_timer.Timer(3.0 / Global.speed) #accessing a function from this node
	emit_signal("fire")
	await themed_timer.Timer(1.0 / Global.speed) #accessing a function from this node
	Transtition.trans("level_scene") 

func lose():
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene") # back to intermission
