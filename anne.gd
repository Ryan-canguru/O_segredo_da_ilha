extends CharacterBody2D

const WALK_SPEED: float = 150.0
const RUN_SPEED: float = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: Vector2 = Vector2.DOWN


func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	sprite.play("idle_down")


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"esquerda",
		"direita",
		"cima",
		"baixo"
	)

	var running: bool = Input.is_action_pressed("correr")
	var speed: float = RUN_SPEED if running else WALK_SPEED

	velocity = direction * speed
	move_and_slide()

	update_animation(direction, running)


func update_animation(direction: Vector2, running: bool) -> void:
	var moving: bool = direction != Vector2.ZERO

	if moving:
		last_direction = direction

	var prefix: String = "idle"

	if moving:
		prefix = "run" if running else "walk"

	var suffix: String

	# Nas diagonais, prioriza a animação lateral.
	if absf(last_direction.x) >= absf(last_direction.y):
		suffix = "direction"

		# O desenho original olha para a esquerda.
		# Espelha quando o personagem vai para a direita.
		sprite.flip_h = last_direction.x > 0.0
	else:
		suffix = "up" if last_direction.y < 0.0 else "down"
		sprite.flip_h = false

	var animation_name: StringName = StringName(
		prefix + "_" + suffix
	)

	if sprite.animation != animation_name or not sprite.is_playing():
		sprite.play(animation_name)
