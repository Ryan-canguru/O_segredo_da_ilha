
extends Control

@onready var iniciar: Button = $VBoxContainer/iniciar
@onready var sair: Button = $VBoxContainer2/sair


func _ready() -> void:
	iniciar.pressed.connect(_on_iniciar_pressed)
	sair.pressed.connect(_on_sair_pressed)


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://fase_2.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
