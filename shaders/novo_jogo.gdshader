shader_type canvas_item;

uniform float cut_size : hint_range(0.0, 0.5) = 0.1; // Controle do tamanho do corte nas quinas

void fragment() {
    vec2 uv = UV;
    vec2 centered_uv = uv - vec2(0.5);
    vec2 abs_uv = abs(centered_uv);

    // Definir o limite onde as quinas serão removidas
    float corner_cut_limit = 0.5 - cut_size;

    // Remover quinas ao descartar pixels nas regiões dos cantos
    if (abs_uv.x > corner_cut_limit && abs_uv.y > corner_cut_limit) {
        discard; // Descarta pixels nas quinas
    }

    // Aplicar a textura original da imagem sem bordas
    COLOR = texture(TEXTURE, uv);
}
