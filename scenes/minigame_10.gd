extends Node2D
@onready var themed_timer: Node2D = $Time 
@onready var remainder: RichTextLabel = $remainder
@onready var light: Sprite2D = $Light
const lever = preload("res://lever.tscn")

var amount: int = 1
var done = []
func _ready() -> void:
	amount = randi_range(1, 3 + Global.minigames_done/3)
	remainder.text = str(amount) + "/" + str(amount) + " remaining"
	while Transtition.transtitioning:
		await get_tree().process_frame
	light.show()
	for i in range(amount):
		var lever_instance = lever.instantiate()
		lever_instance.scale = Vector2(0.4, 0.4)
		lever_instance.index = i
		lever_instance.name = str(lever_instance)
		add_child(lever_instance)
		lever_instance.position = Vector2(randf_range(0, get_viewport_rect().size.x/1.5), randf_range(0, get_viewport_rect().size.y/1.5))
	Global.minigame5.connect(turnon)
	await themed_timer.Timer(5.0 / Global.speed) #accessing a function from this node
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene") # back to intermission

func turnon(index: int, state: int):
	var add = true
	for i in done:
		if i == index:
			add = false
			break
	if add and state == 2:
		done.append(index)
		remainder.text = str(amount - len(done)) + "/" + str(amount) + " remaining"
		if len(done) >= amount:
			Global.data["achieve"]["lights_turned_on"] += 1
			Transtition.trans("level_scene") # back to intermission
	elif state == 0:
		done.erase(index)
		remainder.text = str(amount - len(done)) + "/" + str(amount) + " remaining"
