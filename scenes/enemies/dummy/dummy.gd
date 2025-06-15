extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var dying_particles: CPUParticles2D = $DyingParticles
@onready var name_label: Label = $NameLabel

var hp: float = 1000.0


func hit(damage: float) -> void:
    hp -= damage
    if hp <= 0.0:
        die()
    hit_animation(damage)

func hit_animation(damage) -> void:
    modulate_texture()
    damage_label(damage)
    
func modulate_texture() -> void:
    sprite_2d.modulate = Color(1.0, 0.0, 0.0, 1.0)
    await get_tree().create_timer(0.1).timeout
    sprite_2d.modulate = Color(1.0, 1.0, 1.0, 1.0)

func damage_label(damage) -> void:
    var rng = RandomNumberGenerator.new()
    var label = Label.new()
    label.text = str(int(damage))
    label.add_theme_font_size_override("font_size", int(21.0 / Globals.canvas_scale.x))
    label.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
    add_child(label)
    label.position.x = rng.randf_range(-5.0, 5.0) - label.get_rect().size.x / 2.0
    label.position.y = rng.randf_range(-18.0, -12.0)
    var tween = get_tree().create_tween()
    tween.tween_property(label, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0)
    await tween.finished
    label.queue_free()
    remove_child(label)
    
func die() -> void:
    gravity_scale = 0.0
    sprite_2d.texture = null
    collision_polygon_2d.disabled = true
    dying_particles.emitting = true
    await dying_particles.finished
    queue_free()
