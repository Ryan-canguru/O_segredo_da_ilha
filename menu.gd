extends Control

@export var cena_do_jogo: PackedScene

@onready var iniciar: Button = $VBoxContainer/iniciar
@onready var sair: Button = $VBoxContainer2/sair


func _ready() -> void:
	if not iniciar.pressed.is_connected(_on_iniciar_pressed):
		iniciar.pressed.connect(_on_iniciar_pressed)

	if not sair.pressed.is_connected(_on_sair_pressed):
		sair.pressed.connect(_on_sair_pressed)


func _on_iniciar_pressed() -> void:
	if cena_do_jogo == null:
		push_warning("Falta escolher a Cena do Jogo no Inspector.")
		return

	get_tree().change_scene_to_packed(cena_do_jogo)


func _on_sair_pressed() -> void:
	get_tree().quit()
