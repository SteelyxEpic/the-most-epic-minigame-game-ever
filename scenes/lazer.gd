extends Sprite2D
var main:Node2D
var hit = false
var aim = false
var target

func _ready() -> void:
	main.fire.connect(func():
		$Line2D.modulate.a = 1
		if hit:
			print("hit")
			main.lose())
	main.aim.connect(func():
		$Line2D.show()
		aim = true)
func _process(delta: float) -> void:
	if not aim:
		look_at(target.position)
		rotation_degrees += 180
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Ship":
		hit = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name == "Ship":
		hit = false
