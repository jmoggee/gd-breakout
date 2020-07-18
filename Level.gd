extends Node

var is_game_over = false
var has_won = false

onready var play_label = $PlayLabel
onready var game_over_label = $GameOverLabel
onready var game_over_sound = $GameOverSound
onready var win_sound = $WinSound

func _ready():
	pause_game()
	
func _process(delta):
	if is_paused() and Input.is_action_just_pressed("ui_accept"):
		if is_game_over:
			restart_game()
		unpause_game()
		
	check_win()

func check_win():
	if not has_won and get_tree().get_nodes_in_group("tile").size() == 0:
		has_won = true
		set_game_over()
		win_sound.play()

func is_paused():
	return get_tree().paused

func pause_game():
	get_tree().paused = true
	play_label.visible = true
	
func unpause_game():
	get_tree().paused = false
	play_label.visible = false

func restart_game():
	is_game_over = false
	get_tree().reload_current_scene()
	
func set_game_over():
	is_game_over = true
	game_over_label.visible = true
	get_tree().paused = true

func _on_Ball_tile_hit(body):
	body.queue_free()

func _on_game_over(body):
	set_game_over()
	game_over_sound.play()
