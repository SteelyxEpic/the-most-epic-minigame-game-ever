extends LineEdit

var previous: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_changed(new_text: String) -> void:
	if new_text == "":
		previous = ""
		return
	if new_text.is_valid_int():
		previous = new_text
	else:
		text = previous
		caret_column = text.length()


func _on_text_submitted(new_text: String) -> void:
	if(text.to_int() < 1):
		text = "1"
	elif(text.to_int() > 100):
		text = "100"
	Global.minigames_doing = text.to_int()
	
