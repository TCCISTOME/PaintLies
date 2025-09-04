extends Node2D

@onready var player: CharacterBody2D = $player
@onready var camera := $camera as Camera2D
@onready var spawner: Marker2D = $spawner
@onready var bg_music: AudioStreamPlayer = $bgMusic
@onready var door_win: Area2D = $doorWin


func _ready() -> void:
	player.Heleanor_has_died.connect(game_over)
	door_win.player_win.connect(win_game)
	
	player.follow_camera(camera)


func game_over():
	bg_music.stop()
	await get_tree().create_timer(3.1).timeout
	# Verifique se o jogo está pausado e desative o estado de pausa
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/game_over_heleanor.tscn")
	
func win_game():
	bg_music.stop()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
	#get_tree().reload_current_scene()
