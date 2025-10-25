extends Node

var position = Vector4.ZERO #Position in 4D
var current_plan_basis
var current_plan = 1 
const SPEED = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arrows_able_disable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	var input_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	input_direction.normalized()
	if input_direction: 
		var direction = get_4d_direction(input_direction)
		direction.normalized()
		move_to_direction(direction,delta)
		#print("moving")
	if Input.is_action_just_pressed("switch_plan"):
		switch_basis()
#Move the player position in the direction at SPEED
func move_to_direction(direction,delta) -> void:
	position += direction * delta * SPEED

#Get the 4D direction corresponding to input
func get_4d_direction(input_direction) -> Vector4:
	return input_direction.x * current_plan_basis[0] + input_direction.y * current_plan_basis[1]
	
func switch_basis():
	arrows_able_disable()
	current_plan = 3 - current_plan #Switch 1 and 2
	arrows_able_disable()
	current_plan_basis = get_current_plan().basis
func arrows_able_disable():
	var arrows = get_arrows()
	arrows.visible = not arrows.visible
func get_arrows():
	return get_node("/root/Main/CurrentLevel/" + str(Global.current_level) + "/Views/PlanDisplay"+str(current_plan)+"/Origin/Player2D/Arrows")
func get_current_level():
	return get_node("/root/Main/CurrentLevel/" + str(Global.current_level))
func get_current_plan():
	return get_current_level().get_child(0).get_child(current_plan-1)
