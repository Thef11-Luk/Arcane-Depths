extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cpu_particles_2d: CPUParticles2D = $Sprite2D/CPUParticles2D
@onready var projectiles: Node = $Projectiles
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const projectile = preload("res://scenes/player/weapons/bouncy_deagle/projectile.tscn")

var projectile_origin: Vector2 = Vector2(0.0,0.0)

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("left_mouse_button"):  
        shoot()
    handle_direction()
    calculate_projectile_origin()
    
    
func handle_direction() -> void:
    var mouse_vector = get_global_mouse_position() - global_position
    if mouse_vector.x > 0.0:
        sprite_2d.scale.x = 1.0
        sprite_2d.rotation = mouse_vector.angle()
    elif mouse_vector.x < 0.0:
        sprite_2d.scale.x = -1.0
        sprite_2d.rotation = mouse_vector.angle() - PI

func calculate_projectile_origin() -> void:
    var center = Vector2(0.0, 0.0)
    var abs_rotation: float
    if sprite_2d.scale.x == 1.0:
        abs_rotation = sprite_2d.rotation
    else:
        abs_rotation = sprite_2d.rotation + PI
    projectile_origin = center + Vector2(cos(abs_rotation), sin(abs_rotation)) * 12.0

func shoot() -> void:
    var new_projectile = projectile.instantiate()
    new_projectile.global_position = global_position + projectile_origin
    new_projectile.velocity = projectile_origin.normalized()
    projectiles.add_child(new_projectile)
    cpu_particles_2d.emitting = true
    audio_stream_player_2d.play()
