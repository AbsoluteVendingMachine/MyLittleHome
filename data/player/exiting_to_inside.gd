extends State


var done : bool


func physics_update(_delta : float) -> void:
	state_machine.body.animation_player.play("Walk")
	if not done:
		done = true
		get_tree().get_first_node_in_group("main").send_to_inside(false)


