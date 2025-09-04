extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "sabrina" && body.has_method("take_demage_traps"):
		body.take_demage_traps(Vector2(0, -70))
	
	if body.is_in_group("enemy"):
			# Verifica se o corpo tem o método take_demage_traps antes de chamá-lo
		if body.has_method("take_demage_traps"):
			body.take_demage_traps(Vector2(0, -70))  # Aplica o dano
