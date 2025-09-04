extends AnimatedSprite2D

func _on_animation_finished() -> void:
	print("Explosão finalizada")
	queue_free()
