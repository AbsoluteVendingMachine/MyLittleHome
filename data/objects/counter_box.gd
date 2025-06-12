extends Sprite3D


var rng = RandomNumberGenerator.new()
var amount : int = 0
var can_interact : bool
var submitted_more_than_once : bool

@onready var collision_area = $Area3D2
@onready var keybind = $Keybind
@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var label = $Label3D
@onready var main = get_tree().get_first_node_in_group("main")


func _ready():
	rng.randomize()
	amount = rng.randi_range(1, 5)
	texture = load("res://data/objects/" + str(amount) + ".svg")


func _on_area_entered(area):
	if get_tree().get_nodes_in_group("player"):
		if not player.day_over and player.forced_state == "none" and not player.forced_state == "count" and area in get_tree().get_nodes_in_group("player"):
			can_interact = true
			keybind.show()


func _on_area_exited(area):
	if area in get_tree().get_nodes_in_group("player"):
		can_interact = false
		keybind.hide()


func _physics_process(_delta):
	if can_interact:
		if Input.is_action_just_pressed("interact"):
			if player.current_count == amount:
				main.correct_sound.play()
				collision_area.monitoring = false
				collision_area.monitorable = false
				can_interact = false
				player.boxes += 1
				label.text = str(player.current_count)
			
			else:
				if not submitted_more_than_once:
					submitted_more_than_once = true
				
				else:
					main.wrong_sound.play()
					
				can_interact = true
				await get_tree().create_timer(0.01).timeout
				player.state_machine.current_state = 5
				pass # Make sound
			
			player.current_count = 0
				
