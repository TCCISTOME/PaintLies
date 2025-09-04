shader_type canvas_item;

uniform float threshold: hint_range(0.0, 1.0) = 0.0;
uniform vec4 fade_color: source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    // A opacidade é controlada pelo threshold, aumentando suavemente de 0 a 1.
    float alpha = smoothstep(0.0, 1.0, threshold); 
    COLOR = vec4(fade_color.rgb, fade_color.a * alpha);
}
