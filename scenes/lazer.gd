extends Sprite2D
var main:Node2D
var hit = false

func _ready() -> void:
	main.fire.connect(func():
		$Line2D.modulate.a = 1
		if hit:
			print("hit")
			main.lose())


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Ship":
		hit = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name == "Ship":
		hit = false
