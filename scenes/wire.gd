extends TextureButton

@onready var line_2d: Line2D = $Line2D

# Set the anchor point where the line should start (e.g., center of the screen)
var start_point: Vector2
var right: bool = false
var main: Node2D
var stop:bool

func _ready() -> void:
	start_point = Vector2(100, 250)
	# Initialize the line with two points
	line_2d.points = [start_point, start_point]
	pressed.connect(func():
		if not right:
			stop = false
			main.selected(self)
		else:
			main.chosen(self))
			

func _process(_delta: float) -> void:
	if not stop:
		var mouse_pos = get_global_mouse_position()
		line_2d.set_point_position(1, line_2d.to_local(mouse_pos))
