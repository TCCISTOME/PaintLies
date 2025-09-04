extends Area2D

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D and body.name == "Potion": # Verifica se é a poção
		body.queue_free()
	elif body.has_method("handle_death_zone"): # Verifica se o método existe no corpo
		body.handle_death_zone()
