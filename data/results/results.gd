extends CanvasLayer


@onready var main = get_tree().get_first_node_in_group("main")
@onready var animation_player = $AnimationPlayer
@onready var day = $VBoxContainer/Day
@onready var time = $VBoxContainer/Time
@onready var points = $VBoxContainer/Points
@onready var log_points = $VBoxContainer/LogPoints
@onready var fish_points = $VBoxContainer/FishPoints
@onready var box_points = $VBoxContainer/BoxPoints
@onready var time_penalty = $VBoxContainer/TimePenalty
@onready var time_points = $VBoxContainer/TimePoints
@onready var transition = $Transition


var going_out : bool


func _ready():
	main.swipe_sound.play()
	animation_player.play("RESET")
	animation_player.play("In")
	day.text = "Day " + str(main.day)
	if main.time_left_today > 60:
		time.text = "Time left: 1:" + str(main.time_left_today - 60)
	
	elif main.time_left_today == 60:
		time.text = "Time left: 1:00"
	
	elif main.time_left_today >= 10 and main.time_left_today < 60:
		time.text = "Time left: 0:" + str(main.time_left_today)
	
	elif main.time_left_today > 0 and main.time_left_today < 10:
		time.text = "Time left: 0: 0" + str(main.time_left_today)
	
	elif main.time_left_today == 0:
		time.text = "Time left: 0:00"
	
	log_points.text = "Log points: " + str(main.current_tasks_done[0] * 100)
	fish_points.text = "Fish points: " + str(main.current_tasks_done[1] * 70)
	box_points.text = "Box points: " + str(main.current_tasks_done[2] * 100)
	time_points.text = "Time points: " + str(main.time_left_today * 10)
	var penalty : int = 0
	if main.current_day_over:
		penalty = 250
		time_penalty.text = "Time penalty: -250"
	
	main.points += (main.current_tasks_done[0] * 100) + (main.current_tasks_done[1] * 70) + (main.current_tasks_done[2] * 100) + (main.time_left_today * 10) - penalty
	points.text = "Points: " + str(main.points)


func _physics_process(_delta):
	if not going_out:
		if Input.is_action_just_pressed("interact"):
			transition.animation_player.play("In")
			animation_player.play("Out")


func next_day():
	main.current_tasks_done = [0, 0, 0]
	main.day += 1
	main.time_left_today = 0
	main.current_day_over = false
	main.send_to_inside(true)
	queue_free()
