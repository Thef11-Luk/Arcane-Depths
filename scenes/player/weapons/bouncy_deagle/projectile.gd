extends Sprite2D

# --- Node References ---
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D  # Plays bounce/hit sounds
@onready var raycast: RayCast2D = $RayCast2D                                    # Detects collisions ahead
@onready var collision_particles: CPUParticles2D = $CollisionParticles           # Particles on collision
@onready var tail: CPUParticles2D = $Tail                                        # Trail effect

# --- Projectile Properties ---
var speed = 250.0                        # Movement speed
var velocity = Vector2(1, 1)             # Current velocity vector
var duration = 0.0                       # Lifetime tracker

func _process(delta: float) -> void:
    # --- RayCast Setup ---
    # Align RayCast in the direction of movement, scaled by canvas
    raycast.target_position = velocity.normalized() * 1.5 * Globals.canvas_scale.x
    raycast.force_raycast_update()  # Immediate collision check

    # --- Collision Handling ---
    # If RayCast collides with something
    if raycast.is_colliding():
        # If hit is an enemy, handle enemy hit
        if raycast.get_collider().is_in_group("enemy"):
            hit_enemy(raycast.get_collider())
        # Bounce off surface
        var normal = raycast.get_collision_normal()
        velocity = velocity.bounce(normal)
        audio_stream_player_2d.play()  # Play bounce sound
        collision_particles.emitting = true  # Emit collision particles

    # --- Movement ---
    # Move projectile forward
    position += velocity.normalized() * speed * delta

    # --- Lifetime ---
    # Destroy projectile after a certain time
    duration += delta
    if duration > 500.0:
        queue_free()

func hit_enemy(enemy) -> void:
    # --- Enemy Hit Logic ---
    audio_stream_player_2d.stream = null
    tail.emitting = false
    collision_particles.emitting = true
    texture = null
    velocity = Vector2(0,0)
    enemy.hit(10.0)
    await get_tree().create_timer(1.0).timeout
    queue_free()
