extends Node2D
@onready var player: CharacterBody2D = $sabrina
@onready var camera: Camera2D = $camera
@onready var boss: CharacterBody2D = $JugleDog
@onready var bg_music: AudioStreamPlayer = $bg_music


func _ready() -> void:
	print(player)
	print(GlobalSabrina.player_defese)
	player.follow_camera(camera)
	player.player_has_died.connect(game_over)
	boss.boss_has_died.connect(win_game)

func game_over():
	bg_music.stop()
	await get_tree().create_timer(5).timeout
	# Verifique se o jogo está pausado e desative o estado de pausa
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/game_over_sabrina.tscn")

	#get_tree().reload_current_scene()

func win_game():
	bg_music.stop()
	#Metódo de reiniciar a fase temporário (Colocar caminho para a tela de venceu o jogo)
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
	#get_tree().reload_current_scene()
