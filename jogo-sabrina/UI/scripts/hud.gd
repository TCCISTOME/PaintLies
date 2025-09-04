extends Control


@onready var timer_counter: Label = $container/timer_container/timer_counter as Label
@onready var potion_counter: Label = $container/potion_container/potion_counter
@onready var clock_timer: Timer = $container/clock_timer as Timer
@onready var health_bar: ProgressBar = $healthBar
@onready var shield_bar: ProgressBar = $shieldBar
@onready var clock_shield: Timer = $clock_shield


var minutes = 0
var seconds = 0
@export_range(0, 9) var default_minutes := 1
@export_range(0, 59) var default_seconds := 0


func _ready() -> void:
	potion_counter.text = str("%02d" % GlobalSabrina.countPotion)
	health_bar.value = GlobalSabrina.player_life
	shield_bar.value = GlobalSabrina.player_defese
	reset_clock_timer()
	clock_timer.start()

	# Configuração do timer de regeneração de escudo
	clock_shield.wait_time = 1.0
	clock_shield.start()

func _process(delta: float) -> void:
	#xp_counter.text = str("%03d" % GlobalSabrina.countXp)
	potion_counter.text = str("%02d" % GlobalSabrina.countPotion)
	health_bar.value = GlobalSabrina.player_life
	shield_bar.value = GlobalSabrina.player_defese

func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59
		else:
			clock_timer.stop()
			get_tree().change_scene_to_file("res://cenas/game_over_sabrina.tscn")

	else:
		seconds -= 1

	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

	# Alterar a cor do texto para vermelho quando o tempo for menor que 10 segundos
	if minutes == 0 and seconds <= 10:
		timer_counter.add_theme_color_override("font_color", Color(1, 0, 0))  # Vermelho
	else:
		timer_counter.add_theme_color_override("font_color", Color(1, 1, 1))  # Branco (ou a cor padrão)

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	clock_timer.start()
	#scene_change_triggered = false  # Reseta o controle de emissão do sinal

func _on_clock_shield_timeout() -> void:
	if GlobalSabrina.player_defese <= 0:
		clock_shield.stop()
		shield_bar.hide()
		return

	if GlobalSabrina.player_defese < GlobalSabrina.player_defese_max:
		GlobalSabrina.player_defese = min(GlobalSabrina.player_defese + 5, GlobalSabrina.player_defese_max)
		shield_bar.value = GlobalSabrina.player_defese

		if not shield_bar.visible:
			shield_bar.show()
