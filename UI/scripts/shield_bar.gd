extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var shield = 0 : set = _set_shield

func _set_shield(new_shield) -> void:
	var prev_shield = shield
	shield = min(max_value, new_shield)
	value = shield

	if shield < prev_shield:
		timer.start()
	else:
		damage_bar.value = shield

func init_shield(_shield) -> void:
	shield = _shield
	max_value = shield
	value = shield
	damage_bar.max_value = shield
	damage_bar.value = shield

func _on_timer_timeout() -> void:
	damage_bar.value = shield
