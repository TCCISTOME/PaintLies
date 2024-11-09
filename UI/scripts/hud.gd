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
@export_range(0, 9) var default_minutes := 1
@export_range(0, 59) var default_seconds := 0

# Define o sinal para quando o tempo chegar a 3 segundos
signal time_to_change_scene

# Variável para garantir que o sinal seja emitido uma vez
var scene_change_triggered = false

func _ready() -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	potion_counter.text = str("%02d" % Global.countPotion)
	health_bar.value = Global.player_life
	shield_bar.value = Global.player_defese
	reset_clock_timer()
	clock_timer.start()

	# Configuração do timer de regeneração de escudo
	clock_shield.wait_time = 1.0
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
			clock_timer.stop()
			return
	else:
		seconds -= 1

	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

	# Verifique se o tempo chegou a 3 segundos e se o sinal ainda não foi emitido
	if minutes == 0 and seconds == 3 and not scene_change_triggered:
		emit_signal("time_to_change_scene")  # Emite o sinal
		scene_change_triggered = true  # Garante que o sinal só será emitido uma vez

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	clock_timer.start()
	scene_change_triggered = false  # Reseta o controle de emissão do sinal

func _on_clock_shield_timeout() -> void:
	if Global.player_defese <= 0:
		clock_shield.stop()
		shield_bar.hide()
		return

	if Global.player_defese < Global.player_defese_max:
		Global.player_defese = min(Global.player_defese + 5, Global.player_defese_max)
		shield_bar.value = Global.player_defese

		if not shield_bar.visible:
			shield_bar.show()
