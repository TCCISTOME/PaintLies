extends Control


@onready var clock_timer: Timer = $container/clock_timer
@onready var timer_counter: Label = $container/timer_container/timer_counter

@onready var life_counter: Label = $container/life_container/life_counter
@onready var potion_counter: Label = $container/potion_container/potion_counter

@export_range(0, 9) var default_minutes := 1
@export_range(0, 59) var default_seconds := 0

var minutes = 0
var seconds = 0


func _ready() -> void:
	GlobalSabrina.countLifeHelanor = 3
	GlobalSabrina.countPotionHelanor = 0
	life_counter.text = str("%02d" % GlobalSabrina.countLifeHelanor)
	potion_counter.text = str("%02d" % GlobalSabrina.countPotionHelanor)
	reset_clock_timer()
	clock_timer.start()

func _process(delta: float) -> void:
	life_counter.text = str("%02d" % GlobalSabrina.countLifeHelanor)
	potion_counter.text = str("%02d" % GlobalSabrina.countPotionHelanor)
	

func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59
		else:
			clock_timer.stop()
#			Colocar game over da Heleanor
			#get_tree().change_scene_to_file("res://cenas")

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
