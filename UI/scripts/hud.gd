extends Control

@onready var xp_counter: Label = $container/xp_container/xp_counter as Label
@onready var timer_counter: Label = $container/timer_container/timer_counter as Label
@onready var potion_counter: Label = $container/potion_container/potion_icon/potion_counter as Label
@onready var clock_timer: Timer = $container/clock_timer as Timer
@onready var health_bar: ProgressBar = $healthBar
@onready var shield_bar: ProgressBar = $shieldBar
@onready var clock_shield: Timer = $clock_shield


var minutes = 0
var seconds = 0
@export_range(0, 5) var default_minutes := 1
@export_range(0, 59) var default_seconds := 0

func _ready() -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	potion_counter.text = str("%02d" % Global.countPotion)
	health_bar.value = Global.player_life
	shield_bar.value = Global.player_defese
	reset_clock_timer()
	clock_timer.start()

	# Configuração do timer de regeneração de escudo
	clock_shield.wait_time = 1.0  # A cada 3 segundos
	clock_shield.start()

func _process(delta: float) -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	potion_counter.text = str("%02d" % Global.countPotion)
	health_bar.value = Global.player_life
	shield_bar.value = Global.player_defese

func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59
	else:
		seconds -= 1

	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

	if minutes == 0 and seconds == 0:
		clock_timer.stop()

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	clock_timer.start()


func _on_clock_shield_timeout() -> void:
	if Global.player_defese < Global.player_defese_max:
		Global.player_defese = min(Global.player_defese + 5, Global.player_defese_max)  # Limita ao máximo
		shield_bar.value = Global.player_defese  # Atualiza visualmente o valor do escudo
