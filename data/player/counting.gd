extends State


@onready var label = $Minigame3/Label
@onready var minigame = $Minigame3


func physics_update(_delta : float) -> void:
	state_machine.body.animation_player.play("Idle")
	minigame.show()
	if Input.is_action_just_pressed("ui_up"):
		state_machine.body.main.swipe_sound.play()
		state_machine.body.current_count += 1
		if state_machine.body.current_count >= 5:
			state_machine.body.current_count = 5
		
	if Input.is_action_just_pressed("ui_down"):
		state_machine.body.main.swipe_sound.play()
		state_machine.body.current_count -= 1
		if state_machine.body.current_count <= 0:
			state_machine.body.current_count = 0
	
	if Input.is_action_just_pressed("interact"):
		minigame.hide()
		state_machine.body.inside_group = "none"
		state_machine.body.forced_state = "none"
		state_machine.current_state = 0
		
	label.text = str(state_machine.body.current_count)
	
	
