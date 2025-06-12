extends State


var done : bool


func physics_update(_delta : float) -> void:
	state_machine.body.animation_player.play("Idle")
	if not done:
		done = true
		get_tree().get_first_node_in_group("outside_transition").animation_player.play("In")
		get_tree().get_first_node_in_group("main").send_to_outside(false)


