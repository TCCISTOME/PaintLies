extends Control
@onready var xp_counter: Label = $container/xp_container/xp_counter as Label
@onready var timer_counter: Label = $container/timer_container/timer_counter as Label
@onready var potion_counter: Label = $container/potion_container/potion_icon/potion_counter as Label
@onready var clock_timer: Timer = $container/clock_timer as Timer

var minutes = 0
var seconds = 0
@export_range(0,5) var default_minutes := 1
@export_range(0,59) var default_seconds := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	potion_counter.text = str("%02d" % Global.countPotion)
	reset_clock_timer()
	clock_timer.start()  # Inicia o temporizador para a contagem regressiva


# Update counters each frame
func _process(delta: float) -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	potion_counter.text = str("%02d" % Global.countPotion)


func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59  # Ajuste para 59 ao invés de 60, já que contamos de 0 a 59
	else:
		seconds -= 1
	
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	
	# Opcional: Se quiser que algo aconteça ao zerar o timer
	if minutes == 0 and seconds == 0:
		clock_timer.stop()
		# Insira a lógica para o que acontece quando o timer termina


func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	clock_timer.start()  # Certifique-se de reiniciar o temporizador
