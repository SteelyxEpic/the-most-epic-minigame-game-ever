extends Camera2D

var initial: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func zoomin(new_position: Vector2):
	while zoom.x < 2.5:
		zoom += Vector2(0.01, 0.01)
		position = position.move_toward(new_position, 10)
		await wait(0.02)
func zoomout():
	while zoom.x > 1:
		zoom -= Vector2(0.01, 0.01)
		position = position.move_toward(initial, 4)
		await wait(0.02)
func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout 
