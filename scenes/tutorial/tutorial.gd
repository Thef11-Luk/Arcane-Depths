extends Node2D

# --- Node References ---
@onready var player: CharacterBody2D = $Player
var bouncy_deagle

# --- Preloaded Resources ---
const preloaded_bouncy_deagle = preload("res://scenes/player/weapons/bouncy_deagle/bouncy_deagle.tscn")

# --- Temporary Variables ---
var last_player_position : Vector2
var is_player_dead: bool = false

func _process(_delta: float) -> void:
    track_player_position()


func track_player_position() -> void:
    if player.is_on_floor():
        last_player_position = player.position  # updates the position where the player last touched the ground 
    if player.position.y > 360.0 and !is_player_dead:   # tracks if player is under allowed position
        respawn_player()  

func respawn_player() -> void:
    # "killing" player
    is_player_dead = true
    player.set_physics_process(false)   # stops player from continue falling
    player.sprite_2d.hide() # hides the player
    if bouncy_deagle:
        bouncy_deagle.hide()    # hides weapon if it exists
    player.dying_particles.emitting = true  # makes the player look exploding
    await get_tree().create_timer(2.0).timeout  # waiting 2 seconds to respawn
    
    # respawning player
    is_player_dead = false
    player.position = last_player_position - Vector2(0, 2.0)  # teleports player back to the last position touching the ground
    player.set_physics_process(true)    # makes player able to move again
    player.sprite_2d.show()   # shows the player again
    if bouncy_deagle:
        bouncy_deagle.show()    # shows weapon if it exists
        
    
