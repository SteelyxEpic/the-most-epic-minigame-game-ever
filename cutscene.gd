extends Node2D

@onready var themed_timer: Node2D = $Time
@export var win: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	await themed_timer.Timer(7.0)
	Transtition.trans("title_screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
