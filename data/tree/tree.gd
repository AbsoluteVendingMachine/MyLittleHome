extends Area3D


var can_collect : bool

@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var keybind = $Keybind


func _on_area_entered(area):
	if not player.day_over and player.state_machine.current_state == 2 and get_tree().get_nodes_in_group("player"):
		can_collect = true
		keybind.show()


func _on_area_exited(area):
	if get_tree().get_nodes_in_group("player"):
		can_collect = false
		keybind.hide()


func _physics_process(_delta):
	if Input.is_action_just_pressed("interact") and can_collect:
		keybind.hide()

