extends State


func physics_update(_delta : float) -> void:
	state_machine.body.animation_player.play("Idle")
	state_machine.body.interaction_checks()
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		state_machine.body.match_forced_state_transfer()
