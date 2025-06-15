extends Sprite2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var raycast: RayCast2D = $RayCast2D
@onready var collision_particles: CPUParticles2D = $CollisionParticles
@onready var tail: CPUParticles2D = $Tail

var speed = 250.0
var velocity = Vector2(1, 1)
var duration = 0.0

func _process(delta: float) -> void:
    # RayCast ausrichten
    raycast.target_position = velocity.normalized() * 1.5 * Globals.canvas_scale.x
    raycast.force_raycast_update()  # Sofortige Kollisionserkennung

    # Prüfen, ob der RayCast eine Wand trifft
    if raycast.is_colliding():
        if raycast.get_collider().is_in_group("enemy"):
            hit_enemy(raycast.get_collider())
        var normal = raycast.get_collision_normal()
        velocity = velocity.bounce(normal) # Abprallwinkel berechnen
        audio_stream_player_2d.play()  # Soundeffekt beim Abprall
        collision_particles.emitting = true

    # Bewegung anwenden
    position += velocity.normalized() * speed * delta

    # Selbstzerstörung nach einer bestimmten Zeit
    duration += delta
    if duration > 500.0:
        queue_free()


func hit_enemy(enemy) -> void:
        audio_stream_player_2d.stream = null
        tail.emitting = false
        collision_particles.emitting = true
        texture = null
        velocity = Vector2(0,0)
        enemy.hit(10.0)
        await get_tree().create_timer(1.0).timeout
        queue_free()
