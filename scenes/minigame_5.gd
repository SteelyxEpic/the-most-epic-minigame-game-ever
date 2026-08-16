extends Node2D


@onready var themed_timer: Node2D = $Time
@onready var code: RichTextLabel = $Paper/RichTextLabel
var answer: String
var their: String = "0000"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	Global.minigame5.connect(change)
	var temp = randi_range(1, 15)
	answer = String.num_uint64(temp, 2).pad_zeros(4)
	code.text = "The code is:\n" + answer
	await themed_timer.Timer(5.0 / Global.speed)
	#after this is compeleted...
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene")

func change(index: int, state: int):
	their[index] = str(state/2)
	if their == answer:
		Transtition.trans("level_scene")
		
