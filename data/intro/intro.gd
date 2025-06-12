extends CanvasLayer


@onready var animation_player = $AnimationPlayer

var title_screen = preload("res://data/title_screen/title_screen.tscn")


func _ready():
	animation_player.play("Intro")


func send_to_title_screen():
	var title_screen_instance = title_screen.instantiate()
	get_tree().get_root().add_child(title_screen_instance)
	queue_free()
