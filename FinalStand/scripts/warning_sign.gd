extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sign: Area2D = $area_sign

const lines: Array[String] = [
	"Bem-vindo, aventureiro!",
	"Preparado para enfrentar suas inseguranças nessa última fase?",
	"Eu irei treiná-lo para enfrentar o grande mal!",
	"Prepare-se!",
	"Primeiro, derrote esses monstros...",
	"Caso receba dano, use as poções de cura dropada por eles",
	"Após derrotar todos eles, a porta abrirá...",
	"Depois que passar por ela, use o treinamento para lutar!",
	"Boa sorte..."
]

func _unhandled_input(event):
	# Verifica se o jogador está dentro da `Area2D`
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()  # Mostra a textura enquanto o jogador está na área
		if event.is_action_pressed("interagir") and not DialogManager.is_message_active:
			texture.hide()  # Esconde a textura quando o diálogo começa
			DialogManager.start_message(global_position, lines)
	else:
		# Oculta a textura quando o jogador sai da área
		texture.hide()
		
		# Fecha a caixa de diálogo se o jogador sair da área durante o diálogo
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
