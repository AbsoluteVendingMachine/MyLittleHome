extends CharacterBody2D


var rng = RandomNumberGenerator.new()

var origin_position : Vector2
var power : float
var finished : bool

@onready var timer : Timer = $Timer
@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var squeal_sound = $Squeal


func _ready():
	rng.randomize()
	power = 1 + rng.randf_range(0, 64)
	origin_position = Vector2(160 + rng.randi_range(-90, 90), 288 + rng.randi_range(-90, 90))
	position = origin_position


func _on_timer_timeout():
	finished = true
	player.fish += 1
	get_tree().get_first_node_in_group("main").catch_fish_sound.play()
	queue_free()
