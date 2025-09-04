shader_type canvas_item;

uniform vec4 picked_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Cor escolhida

void fragment() {
    vec4 texColor = texture(TEXTURE, UV); // Pega a cor da textura
    COLOR = texColor * picked_color;      // Multiplica a cor da textura pela cor escolhida
}