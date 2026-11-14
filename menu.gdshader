shader_type canvas_item;
render_mode unshaded;

uniform float velocidade = 180.0;
uniform float largura = 45.0;
uniform float intervalo = 1400.0;

uniform vec4 cor_brilho : source_color =
	vec4(1.0, 0.97, 0.75, 1.0);


void fragment() {
	vec4 original = COLOR;

	// Cria uma faixa inclinada que passa pela logo.
	float posicao = FRAGCOORD.x - FRAGCOORD.y * 0.3;

	float ciclo = mod(
		posicao - TIME * velocidade,
		intervalo
	);

	float distancia = min(
		ciclo,
		intervalo - ciclo
	);

	float brilho = 1.0 - smoothstep(
		0.0,
		largura,
		distancia
	);

	COLOR = vec4(
		mix(original.rgb, cor_brilho.rgb, brilho * 0.9),
		original.a
	);
}