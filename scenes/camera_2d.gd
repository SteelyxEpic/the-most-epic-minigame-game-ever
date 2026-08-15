extends Camera2D

var initial: Vector2
var zoom_in: Tween
var zoom_in2: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func zoomin(new_position: Vector2):
	zoom_in = create_tween()
	zoom_in2 = create_tween()
	zoom_in.tween_property($"." , "zoom", Vector2(2.5, 2.5), 1)
	zoom_in2.tween_property($".", "position", new_position, 1)

func shake(seconds: float):
	var temp = position
	for i in range(seconds/0.05):
		zoom_in = create_tween()
		zoom_in.tween_property(self, "position", temp + Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 10, 0.05)
		await wait(0.05)
	position = temp
		
func zoomout():
	zoom_in = create_tween()
	zoom_in2 = create_tween()
	zoom_in.tween_property($"." , "zoom", Vector2(1, 1), 1)
	zoom_in2.tween_property($".", "position", initial, 1)


func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
