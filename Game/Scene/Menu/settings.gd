extends PanelContainer

var music_player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_player = get_node("/root/Main/MusicPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_volume_value_changed(value: float) -> void:
	music_player.volume_db = (((value/100)**0.3)*100-100)*0.8

func _on_luminosity_value_changed(value: float) -> void:
	var tmp = value/100
	get_node("/root/Main/CanvasModulate").color = Color(tmp,tmp,tmp,1)
	
func _on_back_pressed() -> void:
	visible = false
	Global.current_state = Global.GameState.MENU
