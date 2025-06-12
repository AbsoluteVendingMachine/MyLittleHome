extends State


var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func physics_update(delta : float) -> void:
	if not state_machine.body.squeal_sound.playing:
		state_machine.body.squeal_sound.play()
		
	rng.randomize()
	state_machine.body.position = Vector2(lerp(state_machine.body.position.x, state_machine.body.origin_position.x + rng.randf_range(-state_machine.body.power, state_machine.body.power) + rng.randf_range(-12, 12), delta * 10), lerp(state_machine.body.position.y, state_machine.body.origin_position.y + rng.randf_range(-state_machine.body.power, state_machine.body.power) + rng.randf_range(-12, 12), delta * 10))


func _on_area_2d_area_exited(area):
	if not state_machine.body.finished:
		if not get_tree().get_nodes_in_group("hitter") == null:
			if area in get_tree().get_nodes_in_group("hitter"):
				state_machine.current_state = 0
				state_machine.body.squeal_sound.stop()
				state_machine.body.timer.stop()
