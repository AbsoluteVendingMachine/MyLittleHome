extends State


func physics_update(delta : float) -> void:
	state_machine.body.interaction_checks()
	state_machine.body.movement(85, delta)
	state_machine.body.animation_player.play("Walk")
	#state_machine.body.model.rotation.y = atan2(state_machine.body.velocity.x, state_machine.body.velocity.z)
	if not Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		state_machine.body.velocity = Vector3.ZERO
		state_machine.current_state = 0 # Idle
	
	state_machine.body.move_and_slide()
