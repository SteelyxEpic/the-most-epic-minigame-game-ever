extends TextureButton

@onready var parent = $".."
@onready var image:TextureRect = $image
@onready var broken:Texture2D = load("res://aliended.png") as Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	Global.data["achieve"]["aliens_tapped"] += 1
	
	disabled = true
	image.texture = broken
	image.modulate.a = 0.5
	parent.buttons_pressed += 1
	parent.spawn_button()
	print(parent.buttons_pressed)
