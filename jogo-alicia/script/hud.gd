extends CanvasLayer
signal start_game
@onready var message_label: Label = $Control/MessageLabel
@onready var message_timer: Timer = $MessageTimer
@onready var startbutton: Button = $Control/Startbutton
@onready var score_label: Label = $Control/ScoreLabel

func showMenssage(text):
	message_label.text = text
	message_label.show()
	message_timer.start()
	
func ShowGameover():
	showMenssage("Game Over")
	await message_timer.timeout
	
	message_label.text = "DODGE THE BUGS"
	message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	startbutton.show()
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
	#get_tree().change_scene_to_file("res://cenas/game_over_dodgethebugs.tscn")
	
func updateScore(score):
	score_label.text = str(score)

func _on_startbutton_pressed() -> void:
	startbutton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	message_label.hide()
