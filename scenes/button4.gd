extends TextureButton

@onready var arrow:Sprite2D = $"../../Arrow"
@onready var minigame:Node2D = $"../.."
var clr

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clr  = Color(randf(), randf(), randf(), 1.0)
	self_modulate = clr
	pressed.connect(press)

func press():
	Global.emit_signal("minigame4",name.to_int())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !disabled:
		if is_hovered():
			arrow.show()
			self_modulate = clr + Color(0.1, 0.1, 0.1, 1.0)
			arrow.position = get_global_rect().get_center() - Vector2(0, 150)
		else:
			self_modulate = clr
			if minigame.hovering == false:
				arrow.hide()
