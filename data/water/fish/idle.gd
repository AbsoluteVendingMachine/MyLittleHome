extends State


var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func physics_update(delta : float) -> void:
	state_machine.body.position = Vector2(lerp(state_machine.body.position.x, state_machine.body.origin_position.x + rng.randf_range(-state_machine.body.power / 4, state_machine.body.power / 4), delta * 5), lerp(state_machine.body.position.y, state_machine.body.origin_position.y + rng.randf_range(-state_machine.body.power / 4, state_machine.body.power / 4), delta * 5))


func _on_area_2d_area_entered(area):
	if area in get_tree().get_nodes_in_group("hitter"):
		state_machine.current_state = 1
		state_machine.body.timer.start()
