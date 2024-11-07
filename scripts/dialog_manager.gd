extends Node

@onready var dialog_box_scene = preload("res://UI/scenes/dialog_box.tscn")
var message_lines: Array[String] = []
var current_line = 0  # Atualizado o nome para melhor entendimento

var dialog_box
var dialog_box_position = Vector2.ZERO

var is_message_active = false
var can_advance_message = false

func start_message(position: Vector2, lines: Array[String]):
	if is_message_active:
		return
	message_lines = lines
	dialog_box_position = position
	current_line = 0  # Reinicia para a primeira linha de diálogo
	show_text()
	is_message_active = true

func show_text():
	dialog_box = dialog_box_scene.instantiate()
	dialog_box.text_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_text(message_lines[current_line])
	can_advance_message = false  # Bloqueia o avanço enquanto a linha está sendo exibida

func _on_all_text_displayed():
	can_advance_message = true  # Permite o avanço da mensagem

func _unhandled_input(event):
	# Verifica se a ação "avancar" foi pressionada e as condições para avançar
	if event.is_action_pressed("avancar") and is_message_active and can_advance_message:
		dialog_box.queue_free()
		current_line += 1
		if current_line >= message_lines.size():
			# Se todas as mensagens foram exibidas, termina o diálogo
			is_message_active = false
			current_line = 0
			return
		show_text()  # Exibe a próxima linha de diálogo
