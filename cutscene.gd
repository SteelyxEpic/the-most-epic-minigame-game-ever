extends Node2D

@onready var themed_timer: Node2D = $Time
@onready var stranded: Sprite2D = $Stranded
@onready var refine = [load("res://refinewin.png"), load("res://refinelose.png")]
@export var win: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.gamemode == "stranded":
		stranded.show()
	elif Global.gamemode == "ori":
		if win:
			if Global.data["Gamemodes"].find(3) == -1:
				Global.data["Gamemodes"].append(3)
		else:
			if Global.data["Gamemodes"].find(2) == -1:
				Global.data["Gamemodes"].append(2)
	elif Global.gamemode == "refined":
		stranded.show()
		if win:
			stranded.texture = refine[0]
		else:
			stranded.texture = refine[1]
	while Transtition.transtitioning:
		await get_tree().process_frame
	await themed_timer.Timer(7.0)
	Transtition.trans("title_screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
