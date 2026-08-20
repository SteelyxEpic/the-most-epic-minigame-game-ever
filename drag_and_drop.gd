extends TextureButton

@export var offsets: Vector2
var player_area: Area2D
var rock: bool
func _ready() -> void:
	get_child(0).area_entered.connect(shape_entered)
	button_down.connect(func():
		offsets =  global_position - get_global_mouse_position()
		)

func _process(delta: float) -> void:
	if button_pressed:
		global_position = get_global_mouse_position() + offsets
	
func shape_entered(area: Area2D):
	if player_area == area:
		hide()
		if rock:
			if !Transtition.transtitioning:
				Global.lost = true
				Global.minigames_done -= 1 #go back a minigame
				Global.lives -= 1 # lose ur lives
				Transtition.trans("level_scene") # back to intermission
		else:
			get_parent().entered()
