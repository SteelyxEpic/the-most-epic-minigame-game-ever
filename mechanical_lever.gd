extends Node2D

@export var max: float
@export var min: float
@export var step: float
var held: bool = false
@onready var lever: TextureButton = $lever
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lever.rotation_degrees = min
	lever.button_up.connect(func():
		held = false
		)
	lever.button_down.connect(func():
		held = true
		timer.start()
		)
	timer.timeout.connect(press)


func press():
	if held:
		if lever.rotation_degrees < max:
			lever.rotation_degrees += step
	elif lever.rotation_degrees > min:
		lever.rotation_degrees -= step
	else:
		timer.stop()
		
