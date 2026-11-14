extends CharacterBody2D

const SPEED = 200.0
const RUN_SPEED = 400.0

@onready var animacao := $AnimatedSprite2D as AnimatedSprite2D

# Estados do personagem
var is_dead: bool = false
var is_hit: bool = false
var is_jumping: bool = false 

func _physics_process(delta: float) -> void:
	# Se estiver morto ou sofrendo dano, interrompe a movimentação normal
	if is_dead:
		animacao.play("dead")
		return
		
	if is_hit:
		animacao.play("hit")
		return

	# Captura os inputs dos dois eixos (Horizontal e Vertical)
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("esquerda", "direita")
	input_vector.y = Input.get_axis("cima", "baixo")
	
	
	input_vector = input_vector.normalized()

	
	var current_speed = SPEED
	if Input.is_action_pressed("correr"):
		current_speed = RUN_SPEED

	# Sistema de aceleração e desaceleração suave
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * current_speed, SPEED * 10 * delta)
		
		if input_vector.x != 0:
			animacao.scale.x = sign(input_vector.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED * 10 * delta)

	# Movimenta o personagem na Godot 4
	move_and_slide()

	# --- CONTROLE DE ANIMAÇÕES ---
	update_animations(input_vector)


func update_animations(input_vector: Vector2) -> void:
	if is_jumping:
		animacao.play("jump")
	elif input_vector != Vector2.ZERO:
		animacao.play("run")
	else:
		animacao.play("idle")


func tomar_dano() -> void:
	is_hit = true
	animacao.play("hit")
	await get_tree().create_timer(0.3).timeout
	is_hit = false

func morrer() -> void:
	is_dead = true
	animacao.play("dead")
	
