extends CharacterBody3D


@onready var state_machine : StateMachine = $StateMachine
@onready var model = $player
@onready var debug = $Debug
@onready var debug_velocity = $Debug/Velocity
@onready var debug_current_state = $Debug/CurrentState
@onready var debug_direction = $Debug/Direction
@onready var debug_inside_group = $Debug/InsideGroup
@onready var to_do_logs = $ToDo/Control/Logs
@onready var to_do_fish = $ToDo/Control/Fish
@onready var to_do_objects = $ToDo/Control/Objects
@onready var day_timer = $DayTimer/AnimationPlayer
@onready var main = get_tree().get_first_node_in_group("main")
@onready var animation_player = $player/AnimationPlayer
@onready var wood = $wood
@onready var axe = $player/Axe/AnimationPlayer
@onready var fishing_rod = $player/FishingRod
@onready var camera = $Camera3D
@onready var timer_text = $DayTimer/Time
@onready var loading = $Loading

@export var camera_positions = [Vector3(4, 4.724, 2.3), Vector3(4, 4.724, 3.258)]
var logs : int = 0
var fish : int = 0
var boxes : int = 0
var current_count : int = 0
var limits : Array = [0, 0, 3]
var inside_group : String = "none"
var forced_state : String = "none"
var day_over : bool

var rng = RandomNumberGenerator.new()


func _ready():
	camera.position = camera_positions[0]
	wood.hide()
	model.scale = Vector3(0.15, 0.15, 0.15)
	wood.scale = Vector3(0.25, 0.25, 0.25)
	day_timer.play("Timer")
	limits = [rng.randi_range(1, 3), rng.randi_range(2, 5), 3]


func rotation_animation():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		model.rotation_degrees.y = 90
	
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		model.rotation_degrees.y = 135
	
	elif Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		model.rotation_degrees.y = 180
	
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		model.rotation_degrees.y = 225
	
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		model.rotation_degrees.y = 270
	
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		model.rotation_degrees.y = 315
	
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		model.rotation_degrees.y = 0
	
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		model.rotation_degrees.y = 45


func _on_interaction_area_entered(area):
	if area in get_tree().get_nodes_in_group("log"):
		if forced_state == "none":
			inside_group = "log"
		
	if area in get_tree().get_nodes_in_group("tree"):
		if forced_state == "log":
			inside_group = "tree"
	
	if area in get_tree().get_nodes_in_group("water"):
		if forced_state == "none":
			inside_group = "water"
	
	if area in get_tree().get_nodes_in_group("count"):
		if forced_state == "none":
			inside_group = "count"
	
	if area in get_tree().get_nodes_in_group("outside"):
		state_machine.current_state = 6
	
	if area in get_tree().get_nodes_in_group("inside"):
		state_machine.current_state = 7
	
	if area in get_tree().get_nodes_in_group("results"):
		main.send_to_results()


func _on_interaction_area_exited(area):
	if area in get_tree().get_nodes_in_group("tree") or area in get_tree().get_nodes_in_group("water") or area in get_tree().get_nodes_in_group("log"):
		inside_group = "none"


func movement(speed : float, delta : float):
	rotation_animation()
	if Input.is_action_pressed("ui_down"):
		velocity.x = delta * speed
	
	if Input.is_action_pressed("ui_up"):
		velocity.x = -delta * speed
	
	if not Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		velocity.x = 0

	if Input.is_action_pressed("ui_left"):
		velocity.z = delta * speed
	
	if Input.is_action_pressed("ui_right"):
		velocity.z = -delta * speed
	
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.z = 0


func match_forced_state_transfer():
	match forced_state:
		"none":
			state_machine.current_state = 1
		
		"log":
			state_machine.current_state = 2
		
		"tree":
			state_machine.current_state = 3
		
		"water":
			state_machine.current_state = 4
		
		"count":
			state_machine.current_state = 5
		
		"outside":
			state_machine.current_state = 6
		
		"inside":
			state_machine.current_state = 7


func interaction_checks():
	if not day_over and Input.is_action_just_pressed("interact") and not inside_group == "none" and not forced_state == inside_group:
		forced_state = inside_group
		match_forced_state_transfer()


func _process(_delta):
	to_do_logs.text = "Logs to chop: " + str(limits[0] - logs)
	to_do_fish.text = "Fish to catch: " + str(limits[1] - fish)
	to_do_objects.text = "Boxes to count: " + str(limits[2] - boxes)
	if Input.is_action_just_pressed("debug"):
		debug.visible = not debug.visible
	
	if debug.visible:
		match state_machine.current_state:
			0:
				debug_current_state.text = "idle"
			
			1:
				debug_current_state.text = "walking"
			
			2:
				debug_current_state.text = "holding log"
			
			3:
				debug_current_state.text = "chopping log"
			
			4:
				debug_current_state.text = "fishing"
			
			5:
				debug_current_state.text = "counting"
			
			6:
				debug_current_state.text = "exiting to outside"
			
			7:
				debug_current_state.text = "exiting to inside"
		
		debug_velocity.text = str(velocity)
		debug_direction.text = str(model.rotation_degrees.y)
		debug_inside_group.text = inside_group


func _on_timer_update(count : int):
	timer_text.text = str(count)
