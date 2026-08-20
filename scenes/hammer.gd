extends Sprite2D

@onready var smash: Texture2D = load("res://hammershash.png") as Texture2D
@onready var hammer: Texture2D = load("res://hammer.png") as Texture2D
@onready var button: Button = $"../Button"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(smashes)


func smashes():
	texture = smash
	rotation_degrees = 90
	await get_tree().create_timer(0.1).timeout
	rotation_degrees = 50
	texture = hammer
	
	
