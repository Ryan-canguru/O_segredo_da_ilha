extends Node2D

@onready var barco: CharacterBody2D = $barco_pirata

func _ready() -> void:
	if EstadoViagem.tem_retorno:
		barco.global_position = EstadoViagem.posicao_retorno
		barco.velocity = Vector2.ZERO
		EstadoViagem.tem_retorno = false
