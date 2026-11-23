extends CanvasLayer

@onready var fundo: ColorRect = $Fundo
@onready var continuar: Button = $Fundo/Painel/Botoes/Continuar

func _input(evento: InputEvent) -> void:
	if not eh_tecla_de_pausa(evento):
		return

	var cena := get_tree().current_scene
	if cena == null or cena.scene_file_path == "res://menu.tscn":
		return

	get_viewport().set_input_as_handled()
	definir_pausa(not fundo.visible)

func eh_tecla_de_pausa(evento: InputEvent) -> bool:
	return evento is InputEventKey and evento.keycode == KEY_ESCAPE and evento.pressed and not evento.echo

func definir_pausa(ativa: bool) -> void:
	fundo.visible = ativa
	get_tree().paused = ativa
	if ativa:
		continuar.grab_focus()

func _on_continuar_pressed() -> void:
	definir_pausa(false)

func _on_sair_pressed() -> void:
	get_tree().quit()
