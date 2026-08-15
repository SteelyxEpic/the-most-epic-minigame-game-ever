extends Node2D

@onready var button:TextureButton = $TextureButton

@export var rotations: float = -200
@export var index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(press)

func press():
	if button.rotation == rotations * 2:
		button.rotation = 0
	else:
		button.rotation += rotations
	Global.emit_signal("minigame5", index, button.rotation/(rotations*2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
