extends Node3D


@onready var transition = $Transition


func _ready():
	transition.animation_player.play("Black")
	await get_tree().create_timer(0.15).timeout
	transition.animation_player.play("Out")
