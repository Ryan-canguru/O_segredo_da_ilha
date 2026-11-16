extends Node2D

# Configurações do Mapa Pirata
@export var largura: int = 90
@export var altura: int = 55
@export var tamanho_bloco: int = 16

var tilemap_chao: TileMapLayer
var tilemap_objetos: TileMapLayer

func _ready() -> void:
	gerar_estrutura_pirata()
	desenhar_arquipelago()

func gerar_estrutura_pirata() -> void:
	# Cria uma folha de sprites 64x32 (4 colunas x 2 linhas)
	var img = Image.create(64, 32, false, Image.FORMAT_RGBA8)
	
	# --- LINHA 0: TERRENOS ---
	img.fill_rect(Rect2i(0, 0, 16, 16), Color("165a9c"))  # (0,0) Mar Profundo
	img.fill_rect(Rect2i(16, 0, 16, 16), Color("28a8c7")) # (1,0) Água Rasa / Recife
	img.fill_rect(Rect2i(32, 0, 16, 16), Color("f5e09b")) # (2,0) Areia da Praia
	img.fill_rect(Rect2i(48, 0, 16, 16), Color("34802a")) # (3,0) Selva Tropical
	
	# --- LINHA 1: OBJETOS PIRATAS (Fundo Transparente) ---
	# (0,1) Madeira do Cais (Pier)
	img.fill_rect(Rect2i(0, 16, 16, 16), Color("7a4923"))
	img.fill_rect(Rect2i(0, 18, 16, 2), Color("593315"))
	img.fill_rect(Rect2i(0, 26, 16, 2), Color("593315"))
	
	# (1,1) Palmeira (Tronco e Folhas verdes)
	img.fill_rect(Rect2i(22, 22, 4, 10), Color("8c582b"))
	img.fill_rect(Rect2i(18, 17, 12, 6), Color("45b035"))
	
	# (2,1) Baú do Tesouro (Madeira com detalhe dourado)
	img.fill_rect(Rect2i(35, 21, 10, 8), Color("6e3b14"))
	img.fill_rect(Rect2i(35, 24, 10, 2), Color("ffd700"))
	
	# (3,1) Barril de Rum / Caveira na areia
	img.fill_rect(Rect2i(52, 20, 8, 10), Color("965a2c"))
	img.fill_rect(Rect2i(52, 22, 8, 1), Color("333333"))
	img.fill_rect(Rect2i(52, 27, 8, 1), Color("333333"))
	
	var textura = ImageTexture.create_from_image(img)
	
	# Configura o TileSet
	var tileset = TileSet.new()
	tileset.tile_size = Vector2i(tamanho_bloco, tamanho_bloco)
	
	var atlas = TileSetAtlasSource.new()
	atlas.texture = textura
	atlas.texture_region_size = Vector2i(tamanho_bloco, tamanho_bloco)
	
	for x in range(4):
		for y in range(2):
			atlas.create_tile(Vector2i(x, y))
			
	tileset.add_source(atlas, 0)
	
	# Camada do Chão/Mar
	tilemap_chao = TileMapLayer.new()
	tilemap_chao.tile_set = tileset
	tilemap_chao.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(tilemap_chao)
	
	# Camada dos Objetos
	tilemap_objetos = TileMapLayer.new()
	tilemap_objetos.tile_set = tileset
	tilemap_objetos.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(tilemap_objetos)

func desenhar_arquipelago() -> void:
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.frequency = 0.045
	
	var centro = Vector2(largura / 2.0, altura / 2.0)
	var max_dist = centro.length()
	var cais_criado = false
	
	for x in range(largura):
		for y in range(altura):
			var pos = Vector2i(x, y)
			
			# Calcula distância das bordas para garantir que o mapa seja uma ilha cercada de mar
			var dist_borda = Vector2(x, y).distance_to(centro) / max_dist
			var valor = noise.get_noise_2d(x, y) - (dist_borda * 0.65)
			
			if valor < -0.22:
				# Mar Profundo
				tilemap_chao.set_cell(pos, 0, Vector2i(0, 0))
			elif valor < -0.10:
				# Água Rasa
				tilemap_chao.set_cell(pos, 0, Vector2i(1, 0))
			elif valor < 0.05:
				# Praia de Areia
				tilemap_chao.set_cell(pos, 0, Vector2i(2, 0))
				
				# Espalha palmeiras e barris na praia
				var sorte = randf()
				if sorte < 0.05:
					tilemap_objetos.set_cell(pos, 0, Vector2i(1, 1)) # Palmeira
				elif sorte < 0.07:
					tilemap_objetos.set_cell(pos, 0, Vector2i(3, 1)) # Barril
				elif not cais_criado and x > 15 and x < largura - 15 and y > altura / 2:
					# Constrói um pequeno cais (pier) apontando para baixo no mar
					construir_cais(pos)
					cais_criado = true
			else:
				# Selva no interior da ilha
				tilemap_chao.set_cell(pos, 0, Vector2i(3, 0))
				
				var sorte = randf()
				if sorte < 0.14:
					tilemap_objetos.set_cell(pos, 0, Vector2i(1, 1)) # Palmeira densa
				elif sorte < 0.155:
					tilemap_objetos.set_cell(pos, 0, Vector2i(2, 1)) # Baú do tesouro escondido!

func construir_cais(inicio: Vector2i) -> void:
	for i in range(1, 5):
		tilemap_objetos.set_cell(Vector2i(inicio.x, inicio.y + i), 0, Vector2i(0, 1))
