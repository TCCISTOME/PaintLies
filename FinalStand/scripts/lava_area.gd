extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "sabrina" && body.has_method("take_demage_traps"):
		body.take_demage_traps(Vector2(0, -70))
		
