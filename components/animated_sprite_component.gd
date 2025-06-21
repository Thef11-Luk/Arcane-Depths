@tool
extends AnimatedSprite2D
class_name AnimatedSpriteComponent

@export var default_animation: String = "idle"
@export var animation_speeds: Dictionary = {"idle": 5.0, "run": 10.0}   # frames per second

func _ready() -> void:
    # set default animation
    play_animation(default_animation)
    
func play_animation(anim_name: String) -> void:
    play_animation(anim_name)
    speed_scale = animation_speeds.get(anim_name, 1.0)

func flip_sprite(is_facing_left: bool) -> void:
    flip_h = is_facing_left
