extends Control

const PASSO := TAU / 8.0
const SIGLAS := ["L", "SE", "S", "SO", "O", "NO", "N", "NE"]
const ILHAS := ["Ilha tropical", "Ilha do tesouro", "Floresta e ruínas", "Ilha de ruínas"]

@onready var barco: Node2D = $"../../barco_pirata"
@onready var destino: OptionButton = $Destino
@onready var indicacao: Label = $Indicacao
@onready var coordenadas: Label = $Coordenadas
@onready var portais: Array[Node2D] = [
	$"../../Sprite2D/Area2D/CollisionShape2D",
	$"../../ilha_inicial/ilha_inicial/CollisionShape2D",
	$"../../ilha_3/ilha_3/CollisionShape2D",
	$"../../ilha_4/ilha_4/CollisionShape2D",
]

var direcao := Vector2.ZERO

func _ready() -> void:
	for ilha in ILHAS:
		destino.add_item(ilha)
	destino.select(0)
	destino.get_popup().window_input.connect(_on_popup_input)

func _input(evento: InputEvent) -> void:
	if eh_tecla_de_destino(evento) and not destino.get_popup().visible:
		get_viewport().set_input_as_handled()
		selecionar_proximo_destino()

func eh_tecla_de_destino(evento: InputEvent) -> bool:
	return evento is InputEventKey and evento.keycode == KEY_Q and evento.pressed and not evento.echo

func selecionar_proximo_destino() -> void:
	destino.select(wrapi(destino.selected + 1, 0, portais.size()))

func _process(_delta: float) -> void:
	var portal := portais[destino.selected]
	var posicao_portal := portal.global_position
	var ate_o_portal := posicao_portal - barco.global_position
	coordenadas.text = "Q troca  |  X: %d  Y: %d" % [roundi(posicao_portal.x), roundi(posicao_portal.y)]
	direcao = ate_o_portal.normalized()

	if ate_o_portal.length_squared() < 1.0:
		indicacao.text = "Você está no portal"
	else:
		var setor := wrapi(roundi(direcao.angle() / PASSO), 0, SIGLAS.size())
		indicacao.text = "Rumo: %s  |  %d px" % [SIGLAS[setor], roundi(ate_o_portal.length())]

	queue_redraw()

func _draw() -> void:
	var centro := Vector2(120, 124)
	var dourado := Color("#f4cc73")
	var fonte := ThemeDB.fallback_font

	draw_circle(centro, 77.0, Color("#142434"), true, -1.0, true)
	draw_arc(centro, 76.0, 0.0, TAU, 64, dourado, 2.0, true)

	for i in SIGLAS.size():
		var posicao := centro + Vector2.RIGHT.rotated(i * PASSO) * 61.0
		var largura := fonte.get_string_size(SIGLAS[i], HORIZONTAL_ALIGNMENT_LEFT, -1, 14).x
		draw_string(fonte, posicao + Vector2(-largura / 2.0, 5), SIGLAS[i],
			HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color.WHITE)

	if direcao != Vector2.ZERO:
		var haste := centro + direcao * 32.0
		var ponta := centro + direcao * 49.0
		var lado := direcao.orthogonal() * 8.0
		draw_line(centro, haste, dourado, 4.0, true)
		draw_colored_polygon(PackedVector2Array([ponta, haste + lado, haste - lado]), dourado)


func _on_popup_input(evento: InputEvent) -> void:
	var popup := destino.get_popup()
	if not popup.visible:
		return

	if MenuPausa.eh_tecla_de_pausa(evento):
		popup.set_input_as_handled()
		popup.hide()
		MenuPausa.definir_pausa(true)
	elif eh_tecla_de_destino(evento):
		popup.set_input_as_handled()
		popup.hide()
		selecionar_proximo_destino()
