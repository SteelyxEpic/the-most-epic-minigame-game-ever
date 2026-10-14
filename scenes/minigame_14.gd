extends Node2D
@onready var themed_timer: Node2D = $Time 
const DRAG = preload("res://minigame14/nod.tscn")
var amount: int
@onready var left: VBoxContainer = $left
@onready var right: VBoxContainer = $right
var current: TextureButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	amount = randi_range(2, 2+Global.minigames_done/4)
	for i in range(amount):
		var colour: Color = Color(randf(), randf(), randf(), 1.0)
		var lefttemp = DRAG.instantiate()
		lefttemp.main = self
		lefttemp.modulate = colour
		var righttemp = DRAG.instantiate()
		righttemp.main = self
		righttemp.modulate = colour
		left.add_child(lefttemp)
		right.add_child(righttemp)
		righttemp.right = true
	# 1. Fetch all direct children into an array
	var children: Array = right.get_children()
	# 2. Shuffle the array randomly
	children.shuffle()
	# 3. Apply the new order back to the scene tree
	for i in range(children.size()):
		right.move_child(children[i], i)

	await themed_timer.Timer(5.0 / Global.speed) #accessing a function from this node
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene") # back to intermission

func selected(nod:TextureButton):
	if current:
		if not current.stop:
			current.get_child(0).hide()
	current = nod
	current.get_child(0).show()
func chosen(nod:TextureButton):
	if current:
		if current.modulate == nod.modulate:
			current.stop = true
			var finish = true
			for i in left.get_children():
				if not i.stop:
					finish = false
					break
			if finish:
				Transtition.trans("level_scene") 
		else:
			current.get_child(0).hide()
			current = null
			
		
