extends Node

func _ready() -> void:
	Global.current_state = Global.GameState.MENU
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func load_level() -> bool:
	var level_scene = load("res://Scene/Levels/" + str(Global.current_level) + ".tscn")
	if level_scene:
		var level = level_scene.instantiate()
		level.modulate($CanvasModulate.color)
		$CurrentLevel.add_child(level)
		return true
	else : 
		print("This level don't exist")
		return false
