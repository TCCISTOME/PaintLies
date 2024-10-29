extends Node2D

@onready var blue_slime = preload("res://Enemys/blue_slime.tscn")
@onready var green_slime = preload("res://Enemys/green_slime.tscn")
@onready var yellow_slime = preload("res://Enemys/yellow_slime.tscn")
@onready var pink_slime = preload("res://Enemys/pink_slime.tscn")
@onready var purple_slime = preload("res://Enemys/purple_slime.tscn")

var slime_counts = {
	"blue": 0,
	"green": 0,
	"yellow": 0,
	"pink": 0,
	"purple": 0
}

const SLIME_LIMIT = 3
const SPAWN_DELAY = 1.0 # tempo em segundos entre spawns de slimes

# Timer para controlar o delay entre spawns
var spawn_timer: Timer

func _ready() -> void:
	# Adiciona e configura o temporizador de spawn
	spawn_timer = Timer.new()
	spawn_timer.wait_time = SPAWN_DELAY
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	_spawn_slimes_sequencialmente()

# Função para spawnar slimes com pausas
func _spawn_slimes_sequencialmente() -> void:
	await _spawn_slime("blue", blue_slime)
	spawn_timer.start()
	await spawn_timer.timeout

	await _spawn_slime("green", green_slime)
	spawn_timer.start()
	await spawn_timer.timeout

	await _spawn_slime("yellow", yellow_slime)
	spawn_timer.start()
	await spawn_timer.timeout

	await _spawn_slime("pink", pink_slime)
	spawn_timer.start()
	await spawn_timer.timeout

	await _spawn_slime("purple", purple_slime)

# Função de spawn individual com limite
func _spawn_slime(slime_type: String, slime_scene: PackedScene) -> void:
	if slime_counts[slime_type] < SLIME_LIMIT:
		var slime_instance = slime_scene.instantiate()
		slime_instance.position = position

		# Verifica se o nó "inimigos" existe
		var inimigos_node = get_parent().get_node("inimigos")
		if inimigos_node:
			inimigos_node.add_child(slime_instance)
			slime_counts[slime_type] += 1
			print("Spawned:", slime_type)
		else:
			print("Erro: Nó 'inimigos' não encontrado!")
