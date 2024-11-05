extends Node2D

@onready var blue_slime = preload("res://Enemys/blue_slime.tscn")

# Timer para controlar o delay entre spawns
var spawn_timer: Timer

func _on_timer_timeout() -> void:
	var spawnador = blue_slime.instantiate()
	spawnador.position = position
	get_parent().get_node("enemies").add_child(spawnador)
