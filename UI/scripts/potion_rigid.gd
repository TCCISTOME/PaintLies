extends RigidBody2D

func _on_potion_life_tree_exited() -> void:
	queue_free()
