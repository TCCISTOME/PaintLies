extends Node2D

@onready var player: CharacterBody2D = $sabrina
@onready var camera: Camera2D = $camera
@onready var hud: Control = $HUD/control
@onready var song_bg_sfx: AudioStreamPlayer = $songBg_sfx


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GlobalSabrina.player_defese)
	player.follow_camera(camera)
	player.player_has_died.connect(game_over)

	
	#Resetando vida, escudo, xp e poções de cura
	GlobalSabrina.player_life = 100
	GlobalSabrina.player_defese = 100
	GlobalSabrina.countXp = 0
	GlobalSabrina.countPotion = 0




func game_over():
	song_bg_sfx.stop()
	#Colocar caminho para a cena de gameOver
	await get_tree().create_timer(5).timeout
	# Verifique se o jogo está pausado e desative o estado de pausa
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/game_over_sabrina.tscn")
	#get_tree().reload_current_scene()
