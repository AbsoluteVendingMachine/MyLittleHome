extends Area3D


var can_collect : bool

@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var keybind = $Keybind


func _on_area_entered(area):
	if area in get_tree().get_nodes_in_group("player"):
		if not player.day_over and player.forced_state == "none" and not player.forced_state == "water" and not player.fish == player.limits[1]:
			can_collect = true
			keybind.show()


func _on_area_exited(area):
	if area in get_tree().get_nodes_in_group("player"):
		can_collect = false
		keybind.hide()


func _physics_process(_delta):
	if can_collect and player.forced_state == "water":
		queue_free()
