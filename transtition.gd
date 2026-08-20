extends Node2D

var tween: Tween
var transtitioning: bool

func trans(scene: String):
	transtitioning = true
	tween = create_tween()
	tween.tween_property(self, "position:x", -1550, 1/Global.speed)
	await get_tree().create_timer(1/Global.speed).timeout
	await get_tree().change_scene_to_file("res://scenes/"+ scene + ".tscn")
	
	
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position:x", -3000, 1/Global.speed)
	await get_tree().create_timer(1/Global.speed).timeout
	Music.add_to_button(get_tree().current_scene)
	position.x = 0
	transtitioning = false
	
	
