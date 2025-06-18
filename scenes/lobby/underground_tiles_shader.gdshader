shader_type canvas_item;

uniform float offset: hint_range(0.0, 1.0, 0.01); //the y-position where shading starts
uniform float intensity: hint_range(0.5, 5.0, 0.01); //how fast the mixing value goes from 0 to 1
uniform vec4 shading_color: source_color; //the color rect turns in downwards

void fragment() {
    float mixing_value = smoothstep(0.0, 1.0, min(UV.y * intensity - offset, 1.0)); //calculates the mixing-value for mixing the rect texture with the shading color
    COLOR = mix(COLOR, shading_color, mixing_value); //sets the color
}