extends Node2D

@onready var player: CharacterBody2D = $sabrina
@onready var camera: Camera2D = $camera
@onready var hud: Control = $HUD/control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Global.player_defese)
	player.follow_camera(camera)
	player.player_has_died.connect(game_over)
	 # Conecte o sinal do HUD para detectar quando o temporizador chega a 30 segundos
	#hud.time_to_change_scene.connect(_on_time_to_change_scene)
	
	#Resetando vida, escudo, xp e poções de cura
	Global.player_life = 100
	Global.player_defese = 100
	Global.countXp = 0
	Global.countPotion = 0

#func _on_time_to_change_scene() -> void:


	#print("Tentando mudar de cena...")
	#get_tree().call_deferred("change_scene_to_file", "res://FinalStand/final_stand_boss.tscn")

	#get_tree().change_scene_to_file("C:/Users/Isabella/OneDrive/Documentos/GitHub/Scripts/FinalStand/final_stand_boss.tscn")  # Muda para a nova cena diretamente
	#get_tree().change_scene("res://FinalStand/final_stand_boss.tscn")


func game_over():
	#Colocar caminho para a cena de gameOver
	await get_tree().create_timer(1.5).timeout
	get_tree().quit()
	#get_tree().reload_current_scene()
