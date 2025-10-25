extends Window

var basis 
var player_pos = Vector4.ZERO
#var destination_pos = Vector4.ZERO
var on_flag = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	player_pos = get_node("/root/Main/CurrentLevel/" + str(Global.current_level) + "/Player").position
	#destination_pos = get_node("/root/Main/CurrentLevel/" + str(Global.current_level) + "/Destination").position
	$Origin/Player2D.position = projected_position(player_pos)
	#$Origin/Destination2D.position = projected_position(destination_pos)
func projected_position(pos) -> Vector2:
	return Vector2(pos.dot(basis[0]), pos.dot(basis[1]))

func _on_flag(_area: Node2D) -> void:
	on_flag = true 

func _out_flag(_area: Node2D) -> void:
	on_flag = false

func _on_holes_body_entered(_body: Node2D) -> void:
	get_parent().get_parent().lost()
func modulate(color):
	$CanvasModulate.color = color
