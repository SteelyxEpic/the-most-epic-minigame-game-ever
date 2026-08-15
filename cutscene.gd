extends Node2D

@onready var themed_timer: Node2D = $Time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	await themed_timer.Timer(7.0)
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
