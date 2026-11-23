
extends CharacterBody2D

@export var velocidade: float = 220.0
@export var aceleracao: float = 4.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

const DIRECOES: Array[String] = [
	"e", "se", "s", "sw", "w", "nw", "n", "ne"
]


func _ready() -> void:
	anim_sprite.play("s")


func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = pegar_entrada_movimento()

	if input_dir != Vector2.ZERO:
		velocity = velocity.lerp(
			input_dir * velocidade,
			minf(aceleracao * delta, 1.0)
		)
		atualizar_direcao_sprite(input_dir)
	else:
		velocity = velocity.lerp(
			Vector2.ZERO,
			minf(aceleracao * 0.5 * delta, 1.0)
		)

	move_and_slide()


func pegar_entrada_movimento() -> Vector2:
	var dir: Vector2 = Vector2.ZERO

	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		dir.x -= 1.0

	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		dir.x += 1.0

	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		dir.y -= 1.0

	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		dir.y += 1.0

	return dir.normalized()


func atualizar_direcao_sprite(dir: Vector2) -> void:
	var angulo: float = dir.angle()
	var indice: int = wrapi(
		roundi(angulo / (TAU / 8.0)), 0, 8
	)

	var nome_animacao: String = DIRECOES[indice]

	if anim_sprite.animation != nome_animacao:
		anim_sprite.play(nome_animacao)
