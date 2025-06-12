extends Node3D


@onready var logs = [$Area3D2, $Area3D3, $Area3D4]
@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var cycle_animation = $DirectionalLight3D/AnimationPlayer
@onready var music = $AudioStreamPlayer
@onready var transition = $Transition


func _ready():
	transition.animation_player.play("Black")
	await get_tree().create_timer(0.15).timeout
	transition.animation_player.play("Out")
	music.play()
	cycle_animation.play("Cycle")
	await get_tree().create_timer(0.05).timeout
	if not player.limits[0] == 3:
		for count in range(3 - player.limits[0]):
			logs[count].queue_free()
