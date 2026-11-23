extends Area2D

@export_file("*.tscn") var cena_da_ilha: String
@export var ponto_de_retorno: Marker2D

var mudando_de_cena := false

func _on_body_entered(body: Node2D) -> void:
	if body.name != &"barco_pirata" or mudando_de_cena:
		return

	if cena_da_ilha.is_empty() or not ResourceLoader.exists(cena_da_ilha):
		push_warning("Esta ilha ainda não tem uma fase disponível.")
		return

	if not is_instance_valid(ponto_de_retorno):
		push_warning("Configure o ponto de retorno deste portal.")
		return

	mudando_de_cena = true
	_entrar_na_ilha.call_deferred(ponto_de_retorno.global_position)

func _entrar_na_ilha(posicao_retorno: Vector2) -> void:
	var resultado := get_tree().change_scene_to_file(cena_da_ilha)
	if resultado != OK:
		mudando_de_cena = false
		return

	EstadoViagem.posicao_retorno = posicao_retorno
	EstadoViagem.tem_retorno = true
