extends Node2D

@onready var player: CharacterBody2D = $sabrina
@onready var camera: Camera2D = $camera



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.follow_camera(camera)
	player.player_has_died.connect(reload_game)
	
	#Resetando vida, escudo, xp e poções de cura
	Global.player_life = 100
	Global.player_defese = 100
	Global.countXp = 0
	Global.countPotion = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reload_game():
	#Metódo de reiniciar a fase temporário (Colocar caminho para a tela de game over)
	await get_tree().create_timer(1.5).timeout
	get_tree().quit()
	#get_tree().reload_current_scene()
