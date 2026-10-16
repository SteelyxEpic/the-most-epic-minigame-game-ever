extends Node2D

var alerts:Array[String]

func appear():
	for i in alerts:
		$Notif.show()
		$Notif/RichTextLabel.text = i
		var tween: Tween = create_tween()
		tween.tween_property($Notif, "position:x", 900, 1)
		await tween.finished
		await get_tree().create_timer(3).timeout
		tween.stop()
		tween = create_tween()
		tween.tween_property($Notif, "position:x", 1500, 1)
		await tween.finished
		$Notif.hide()
	alerts = []
