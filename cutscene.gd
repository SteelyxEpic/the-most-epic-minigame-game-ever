extends Node2D

@onready var themed_timer: Node2D = $Time
@onready var stranded: Sprite2D = $Stranded
@onready var refine = [load("res://refinewin.png"), load("res://refinelose.png")]
@onready var text:RichTextLabel = $RichTextLabel
@export var win: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.pressed.connect(func():
		Transtition.trans("title_screen"))
	if Global.gamemode == "stranded":
		stranded.show()
	elif Global.gamemode == "ori":
		if win:
			Global.new(0, 3) #refined gamemode
		else:
			Global.new(0, 2) #stranded gamemode
	elif Global.gamemode == "refined":
		stranded.show()
		if win:
			stranded.texture = refine[0]
		else:
			stranded.texture = refine[1]
	elif Global.gamemode == "infinity":
		text.text = "Congrats!\nYou survived for " + str(Global.minigames_done) + " rounds!"
		print(Global.minigames_done)
	while Transtition.transtitioning:
		await get_tree().process_frame
	await themed_timer.Timer(7.0)
	Transtition.trans("title_screen")
