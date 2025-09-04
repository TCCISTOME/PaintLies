extends Node2D
@export var bug_scene: PackedScene
var score:int = 0
var barra: int = 100

# Referências de nós e sinais
@onready var bug_timer: Timer = $BugTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var start_timer: Timer = $StartTimer
@onready var hud:CanvasLayer = $HUD
@onready var player:Node2D = $player
@onready var bg_music:AudioStreamPlayer = $bgMusic
@onready var game_over_sound:AudioStreamPlayer = $gameOverSound
var tempoDiminui:int = 0

func _ready():
	get_node("/root/main/HUD/Control/shieldBar")._set_shield(100)
	$player.beber.connect(changeBarra)
	tempoDiminui=1

func gameOver() -> void:
	$BugTimer.stop()
	$ScoreTimer.stop()
	$HUD.ShowGameover()
	$bgMusic.stop()
	$gameOverSound.play()
	$player/anim.play("die")
	await $player/anim.animation_finished
	$player/anim.hide()
	await get_tree().create_timer(1.2).timeout
	
	# Verifique se o jogo está pausado e desative o estado de pausa
	if get_tree().paused:
		get_tree().paused = false
	
	get_tree().change_scene_to_file("res://cenas/game_over_dodgethebugs.tscn")

func newGame():
	bug_timer["wait_time"]=0.5
	tempoDiminui=1
	player["scale"] = Vector2(3,3)
	barra = 100
	$HUD/Control/shieldBar._set_shield(100)
	$player/anim.show()
	$player.viva = true
	$player.PocaoResto = 5
	$StartTimer.start()
	$player.start_pos($StartPosition.position)
	score = 0
	$HUD.updateScore(score)
	$HUD.showMenssage("Se prepare!")
	get_tree().call_group("bugs", "queue_free")
	$bgMusic.play()

func _on_score_timer_timeout():
	score += 1
	hud.updateScore(score)
	if (score == tempoDiminui):
		tempoDiminui += 1
		bug_timer["wait_time"] = bug_timer["wait_time"]-0.002

func _on_start_timer_timeout():
	# Inicia os timers de Bug e Score
	bug_timer.start()
	score_timer.start()

func _on_bug_timer_timeout():
	var bug = bug_scene.instantiate()
	var bug_location = $BugPath/BugPathLocation
	bug_location.progress_ratio = randf()
	
	var direction = bug_location.rotation + PI / 2
	bug.position = bug_location.position 
	direction += randf_range(-PI / 4, PI / 4)
	bug.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	bug.linear_velocity = velocity.rotated(direction)
	add_child(bug)

func _on_player_hit() -> void:
	# Função de quando o player é atingido
	gameOver()

func changeBarra():
	# Reduz o valor da barra de escudo e atualiza o HUD
	barra -= 20
	hud.get_node("Control/shieldBar")._set_shield(barra)
