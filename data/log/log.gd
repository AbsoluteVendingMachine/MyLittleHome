extends Area3D


var can_collect : bool

@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var keybind = $Keybind


func _on_area_entered(area):
	if get_tree().get_nodes_in_group("player"):
		if not player.day_over and player.forced_state == "none" and not player.forced_state == "log" and area in get_tree().get_nodes_in_group("player"):
			can_collect = true
			keybind.show()


func _on_area_exited(area):
	if area in get_tree().get_nodes_in_group("player"):
		can_collect = false
		keybind.hide()


func _physics_process(_delta):
	if can_collect and player.forced_state == "none" and Input.is_action_just_pressed("interact"):
		get_tree().get_first_node_in_group("main").swipe_sound.play()
		get_tree().get_first_node_in_group("player_body").state_machine.current_state = 2
		queue_free()
