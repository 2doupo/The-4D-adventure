extends PanelContainer

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel") and visible:
		_on_back_pressed()
func _on_back_pressed() -> void:
	Global.current_state = Global.GameState.MENU
	visible = false
	
