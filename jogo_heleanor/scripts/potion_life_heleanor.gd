extends Area2D
@onready var potin_sfx: AudioStreamPlayer = $potin_sfx



func _on_anim_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	$anim.play("colect")
	await $collision.call_deferred("queue_free")
	GlobalSabrina.countPotionHelanor += 1
	print("Colidiu com a poção")
	potin_sfx.play()
