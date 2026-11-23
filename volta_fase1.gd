
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Entrou no portal de retorno: ", body.name)

	if body.name == "anne":
		get_tree().change_scene_to_file.call_deferred("res://mapa_do_mundo.tscn")
