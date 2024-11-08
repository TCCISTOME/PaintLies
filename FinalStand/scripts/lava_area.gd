extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "sabrina" && body.has_method("knockBack"):
		body.knockBack(Vector2(0, -100))
		
