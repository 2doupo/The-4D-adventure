extends PanelContainer

func _on_back_pressed() -> void:
	Global.current_state = Global.GameState.MENU
	visible = false
