extends TextureButton

@onready var parent = $".."
@onready var image:TextureRect = $image
@onready var broken:Texture2D = load("res://aliended.png") as Texture2D
var movingaway:float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.difficulty == "Hell":
		movingaway = 50
	elif Global.difficulty == "Hard":
		movingaway = 120

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not image.texture == broken:
			var direction = get_global_mouse_position() - global_position
			if direction.length() > 5.0:
				direction = direction.normalized()
				global_position -= direction * movingaway * delta


func _on_pressed() -> void:
	if not Transtition.transtitioning:
		Global.data["achieve"]["aliens_tapped"] += 1
		disabled = true
		image.texture = broken
		image.modulate.a = 0.5
		parent.buttons_pressed += 1
		parent.spawn_button()
		print(parent.buttons_pressed)
