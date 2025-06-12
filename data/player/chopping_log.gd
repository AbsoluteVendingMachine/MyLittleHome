extends State


var can_hit : bool
var chopped : bool

var rng = RandomNumberGenerator.new()

@onready var animation_player : AnimationPlayer = $Minigame1/AnimationPlayer
@onready var minigame : CanvasLayer = $Minigame1


func physics_update(_delta):
	state_machine.body.wood.hide()
	if not animation_player.is_playing() and not chopped:
		if not get_tree().get_first_node_in_group("log_object") == null:
			get_tree().get_first_node_in_group("log_object").display(1)
			
		chopped = false
		state_machine.body.animation_player.play("Idle")
		state_machine.body.axe.play("RESET")
		animation_player.play("RESET")
		animation_player.play("Minigame1")
		rng.randomize()
		animation_player.speed_scale = rng.randf_range(0.25, 1.25)
		minigame.show()
		
	if can_hit and Input.is_action_just_pressed("interact"):
		state_machine.body.main.correct_sound.play()
		state_machine.body.animation_player.play("Chop")
		state_machine.body.axe.play("Animation")
		chopped = true
		can_hit = false
		animation_player.stop()
		minigame.hide()
		# add animation of player here
		await get_tree().create_timer(0.45).timeout
		if not get_tree().get_first_node_in_group("log_object") == null:
			get_tree().get_first_node_in_group("log_object").display(2)
		
		await get_tree().create_timer(0.5).timeout
		if not get_tree().get_first_node_in_group("log_object") == null:
			get_tree().get_first_node_in_group("log_object").display(0)
			
		state_machine.body.logs += 1
		state_machine.body.forced_state = "none"
		state_machine.body.inside_group = "none"
		state_machine.current_state = 0
		chopped = false


func _on_marker_area_entered(area):
	if area in get_tree().get_nodes_in_group("hitter"):
		can_hit = true


func _on_marker_area_exited(area):
	if area in get_tree().get_nodes_in_group("hitter"):
		can_hit = false
