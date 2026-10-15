extends Node2D

var type:Dictionary[String, String] = {"gamemode": "[b]New Gamemode Unlocked![/b]", "difficulty": "[b]New Difficulty Unlocked![/b]"}

func check():
	pass
func appear():
	$Notif.show()
	var tween: Tween = create_tween()
	tween.tween_property($Notif, "position:x", 1000, 1)
	await tween.finished
	await get_tree().create_timer(3).timeout
	tween.stop()
	tween = create_tween()
	tween.tween_property($Notif, "position:x", 1500, 1)
	await tween.finished
	$Notif.hide()
