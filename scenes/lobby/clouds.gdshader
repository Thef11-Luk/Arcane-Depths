shader_type canvas_item;

uniform float speed = 20.0;

void fragment() {
	vec2 offset_uv = UV;
	offset_uv.x += TIME * speed * 0.001;
	COLOR = texture(TEXTURE, offset_uv);
}
