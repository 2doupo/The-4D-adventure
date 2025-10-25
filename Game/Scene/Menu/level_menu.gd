extends PanelContainer

var flag = load("res://Sprite/Flag.png")
func _ready() -> void:
	icon_update()
	
func _process(_delta: float) -> void:
	if visible:
		level_menu_check_input()
func _on_back_pressed() -> void:
	$VBoxContainer/LevelList.deselect_all()
	visible = false
	get_node("/root/Main/MainMenu").visible = true
	Global.current_state = Global.GameState.MENU
	
func _on_level_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	launch_level(index)
func icon_update():
	for number in Global.levels_completed:
		$VBoxContainer/LevelList.set_item_icon(number-1,flag)
func level_menu_check_input():
	if Input.get_vector("ui_left","ui_right","ui_up","ui_down") && visible && $VBoxContainer/LevelList.get_selected_items().size() == 0:
		$VBoxContainer/LevelList.select(0)
	elif Input.is_action_just_pressed("ui_left"):
		$VBoxContainer/LevelList.select(max(0,$VBoxContainer/LevelList.get_selected_items()[0]-1))
	elif Input.is_action_just_pressed("ui_right"):
		$VBoxContainer/LevelList.select(min($VBoxContainer/LevelList.item_count-1,$VBoxContainer/LevelList.get_selected_items()[0]+1))
	elif Input.is_action_just_pressed("ui_up"):
		$VBoxContainer/LevelList.select(max(0,$VBoxContainer/LevelList.get_selected_items()[0]-$VBoxContainer/LevelList.max_columns))
	elif Input.is_action_just_pressed("ui_down"):
		$VBoxContainer/LevelList.select(min($VBoxContainer/LevelList.item_count-1,$VBoxContainer/LevelList.get_selected_items()[0]+$VBoxContainer/LevelList.max_columns))	
	elif Input.is_action_pressed("ui_accept") && $VBoxContainer/LevelList.get_selected_items().size() != 0:
		launch_level($VBoxContainer/LevelList.get_selected_items()[0])
	elif Input.is_action_pressed("ui_cancel"):
		_on_back_pressed()
func launch_level(index):
	$VBoxContainer/LevelList.deselect_all()
	Global.current_state = Global.GameState.LEVEL
	var main = get_node("/root/Main")
	Global.current_level = index + 1
	if load("res://Scene/Levels/" + str(Global.current_level) + ".tscn"):
		visible = false
		main.load_level()
	else : print("This level doesn't exist")
