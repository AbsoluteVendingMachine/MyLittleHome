extends State


func physics_update(delta : float) -> void:
	state_machine.body.wood.show()
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		state_machine.body.animation_player.play("Log Walk")
	
	else:
		state_machine.body.animation_player.play("Log Idle")
	
	state_machine.body.interaction_checks()
	state_machine.body.movement(52, delta)
	state_machine.body.move_and_slide()
