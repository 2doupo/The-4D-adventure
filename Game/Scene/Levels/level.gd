extends Node
var level_win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Views/PlanDisplay1.basis = [Vector4(1,0,0,0),Vector4(0,1,0,0)]
	$Views/PlanDisplay2.basis = [Vector4(12,0,-1.5,0),Vector4(0,1,0,-2)]
	if $Views/PlanDisplay1.get_meta("BaseVector1") != Vector4.ZERO:
		$Views/PlanDisplay1.basis = [$Views/PlanDisplay1.get_meta("BaseVector1"),$Views/PlanDisplay1.get_meta("BaseVector2")]
	if $Views/PlanDisplay2.get_meta("BaseVector1") != Vector4.ZERO:
		$Views/PlanDisplay2.basis = [$Views/PlanDisplay2.get_meta("BaseVector1"),$Views/PlanDisplay2.get_meta("BaseVector2")]
	$Views/PlanDisplay1.basis = normalized_basis($Views/PlanDisplay1.basis)
	$Views/PlanDisplay2.basis = normalized_basis($Views/PlanDisplay2.basis)
	#$Destination.position = Vector4(randi_range(),randi_range(),randi_range(),randi_range())
	$Player.current_plan_basis = $Views/PlanDisplay1.basis
	$UI/Level_number.text = "Level " + str(Global.current_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$UI/PositionText.text = "position : " + str(round($Player.position))
	$UI/BasisText1.text = "basis 1 : " + str([round($Views/PlanDisplay1.basis[0]),round($Views/PlanDisplay1.basis[1])])
	$UI/BasisText2.text = "basis 2 : " + str([round($Views/PlanDisplay2.basis[0]),round($Views/PlanDisplay2.basis[1])])
	if on_flags() && not level_win: 
		win()
	
func normalized_basis(basis):
	var result=[]
	for i in range(2):
		result.append(basis[i].normalized())
	return result

func random_destination():
	return randi_range(-150,150) * $Player.current_plan_basis[0] + randi_range(-150,150) * $Player.current_plan_basis[1]
	
func on_flags():
	return $Views/PlanDisplay1.on_flag && $Views/PlanDisplay2.on_flag
	
func win(): 
	level_win = true
	Global.levels_completed.append(Global.current_level)
	$Views/PopupMenu.visible = true
	$Views/PopupMenu.title = "You win !"
func lost():
	$Views/PopupMenu.visible = true
	$Views/PopupMenu.title = "You lose !"
func _on_popup_menu_id_pressed(id: int) -> void:
	get_node("/root/Main/Levels").icon_update()
	match id:
		0:
			Global.current_state = Global.GameState.LEVELMENU
			get_node("/root/Main/Levels").visible = true
			queue_free()
		1:
			var main = get_node("/root/Main")
			Global.current_level = Global.current_level + 1 
			if not main.load_level():
				Global.current_state = Global.GameState.LEVELMENU
				get_node("/root/Main/Levels").visible = true
			queue_free()
		2:
			reset()

func reset():
	level_win = false
	$Player.position = Vector4.ZERO


func _on_menu_pressed() -> void:
	Global.current_state = Global.GameState.LEVELMENU
	get_node("/root/Main/Levels").visible = true
	queue_free()
func modulate(color):
	$Views/PlanDisplay1.modulate(color)
	$Views/PlanDisplay2.modulate(color)
