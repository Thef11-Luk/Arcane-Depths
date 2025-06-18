extends Node2D

# --- Node References ---
@onready var sprite_2d: Sprite2D = $Sprite2D                          # Weapon sprite
@onready var cpu_particles_2d: CPUParticles2D = $Sprite2D/CPUParticles2D  # Muzzle flash or firing particles
@onready var projectiles: Node = $Projectiles                         # Node to hold spawned projectiles
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D  # Firing sound

# --- Projectile Scene ---
const projectile = preload("res://scenes/player/weapons/bouncy_deagle/projectile.tscn")

# --- Firing State ---
var projectile_origin: Vector2 = Vector2(0.0,0.0)                     # Offset for projectile spawn

func _process(_delta: float) -> void:
    # --- Input Handling ---
    if Input.is_action_just_pressed("left_mouse_button"):  
        shoot()
    # --- Weapon Orientation ---
    handle_direction()
    # --- Calculate Projectile Spawn Offset ---
    calculate_projectile_origin()
    
func handle_direction() -> void:
    # --- Aim Weapon Towards Mouse ---
    var mouse_vector = get_global_mouse_position() - global_position
    if mouse_vector.x > 0.0:
        sprite_2d.scale.x = 1.0
        sprite_2d.rotation = mouse_vector.angle()
    elif mouse_vector.x < 0.0:
        sprite_2d.scale.x = -1.0
        sprite_2d.rotation = mouse_vector.angle() - PI

func calculate_projectile_origin() -> void:
    # --- Calculate Offset for Projectile Spawn Based on Weapon Rotation ---
    var center = Vector2(0.0, 0.0)
    var abs_rotation: float
    if sprite_2d.scale.x == 1.0:
        abs_rotation = sprite_2d.rotation
    else:
        abs_rotation = sprite_2d.rotation + PI
    projectile_origin = center + Vector2(cos(abs_rotation), sin(abs_rotation)) * 12.0

func shoot() -> void:
    # --- Spawn and Fire Projectile ---
    var new_projectile = projectile.instantiate()
    new_projectile.global_position = global_position + projectile_origin
    new_projectile.velocity = projectile_origin.normalized()
    projectiles.add_child(new_projectile)
    cpu_particles_2d.emitting = true
    audio_stream_player_2d.play()
