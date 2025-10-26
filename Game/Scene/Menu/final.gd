extends PanelContainer

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel") and visible:
		_on_back_pressed()
	if Global.levels_completed.size() == Global.TOTAL_LEVEL: 
		visible = true
func _on_back_pressed() -> void:
	queue_free()
	
