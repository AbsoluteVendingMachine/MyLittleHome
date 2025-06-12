extends Node3D


@onready var catch_fish_sound = $SoundEffects/CatchFish
@onready var correct_sound = $SoundEffects/Correct
@onready var wrong_sound = $SoundEffects/Wrong
@onready var stomp_sound = $SoundEffects/Stomp
@onready var swipe_sound = $SoundEffects/Swipe
@onready var walk_out = $SoundEffects/WalkOut

var outside = preload("res://data/outside/outside.tscn")
var inside = preload("res://data/inside/inside.tscn")
var results = preload("res://data/results/results.tscn")
var points : int = 0
var current_tasks_done : Array = [0, 0, 0]
var current_day_over : bool
var day : int = 1
var time_left_today : int = 0


func send_to_inside(skip : bool):
	if not skip:
		await get_tree().create_timer(2.5).timeout
	
	if not get_tree().get_first_node_in_group("outside_world") == null:
		get_tree().get_first_node_in_group("outside_world").queue_free()
	
	await get_tree().create_timer(0.005).timeout
		
	var inside_instance = inside.instantiate()
	add_child(inside_instance)


func send_to_outside(skip : bool):
	if not skip:
		await get_tree().create_timer(2.5).timeout
	
	if not get_tree().get_first_node_in_group("inside_world") == null:
		get_tree().get_first_node_in_group("inside_world").queue_free()
	
	await get_tree().create_timer(0.005).timeout
		
	var outside_instance = outside.instantiate()
	add_child(outside_instance)


func send_to_results():
	if not get_tree().get_first_node_in_group("outside_world") == null:
		get_tree().get_first_node_in_group("outside_world").queue_free()
	
	var results_instance = results.instantiate()
	add_child(results_instance)


func _ready():
	pass
