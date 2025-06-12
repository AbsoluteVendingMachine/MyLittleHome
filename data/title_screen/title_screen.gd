extends CanvasLayer


@onready var player_animation = $SubViewportContainer/SubViewport/player/AnimationPlayer
@onready var planet = $Planet
@onready var fade = $Sprite2D3
@onready var main = get_tree().get_first_node_in_group("main")

var inside = preload("res://data/inside/inside.tscn")

var transitioning : bool = false


func _process(delta):
	planet.rotate(-delta / 12)
	player_animation.play("Walk")


func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		main.swipe_sound.play()
		print("yes")
		transitioning = true
	
	if transitioning:
		fade.modulate.a8 += 200 * delta
		if fade.modulate.a8 >= 253:
			var inside_instance = inside.instantiate()
			get_tree().get_root().add_child(inside_instance)
			queue_free()
