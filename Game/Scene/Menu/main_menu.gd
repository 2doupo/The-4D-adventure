extends Container

const TITLE_SPEED = 0.01 
const MAX_BOLDNESS = 0.65
var title_direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Buttons/ButtonList.select(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	 #rotate_title(TITLE_SPEED*title_direction*parabole($Timer.time_left/$Timer.wait_time))
	bold_title()
	if visible:
		main_menu_check_input()
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	Global.current_state = Global.GameState.CREDIT
	get_node("/root/Main/Credits").visible = true

func _on_settings_pressed() -> void:
	get_node("/root/Main/Settings").visible = true
	Global.current_state = Global.GameState.SETTINGS


func _on_levels_pressed() -> void:
	Global.current_state = Global.GameState.LEVELMENU
	get_node("/root/Main/Levels").visible = true
	visible = false

func _on_tutorial_pressed() -> void:
	get_node("/root/Main/Tutorial").visible = true
func rotate_title(angle):
	var matrix : Transform2D = Transform2D(angle,Vector2($Buttons/Title.size/2))
	$Buttons/Title.theme.default_font.variation_transform *= matrix
func bold_title():
	$Buttons/Title.theme.default_font.variation_embolden = MAX_BOLDNESS *parabole($Timer.time_left/$Timer.wait_time)



func _on_timer_timeout() -> void:
	title_direction*=-1
func parabole(x):
	return 1-(2*x-1)**(2)


func _on_button_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	match  index:
		0 : _on_levels_pressed()
		1: _on_tutorial_pressed()
		2: _on_settings_pressed()
		3: _on_credits_pressed()
		4: _on_quit_pressed()
func main_menu_check_input():
	if Input.is_action_just_pressed("ui_up"):
		$Buttons/ButtonList.select(max(0,$Buttons/ButtonList.get_selected_items()[0]-1))
	elif Input.is_action_just_pressed("ui_down"):
		$Buttons/ButtonList.select(min($Buttons/ButtonList.item_count-1,$Buttons/ButtonList.get_selected_items()[0]+1))	
	elif Input.is_action_pressed("ui_accept") && $Buttons/ButtonList.get_selected_items().size() != 0:
		_on_button_list_item_clicked($Buttons/ButtonList.get_selected_items()[0],Vector2.ZERO,0)
