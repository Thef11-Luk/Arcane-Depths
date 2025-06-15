extends CharacterBody2D

@export var max_jump_trigger_time: float = 0.5
@export var jump_velocity: float = -300.0

const SPEED = 100.0

var jump_trigger_time = 0.0

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if jump_trigger_time > 0.0 and jump_trigger_time < max_jump_trigger_time:
        jump_trigger_time += delta
        velocity.y = jump_velocity * 1.0 - max_jump_trigger_time / jump_trigger_time
    else:
        jump_trigger_time = 0.0
    if Input.is_action_just_pressed("w") and is_on_floor():
        jump_trigger_time = delta
    if Input.is_action_just_released("w"):
        jump_trigger_time = 0.0

    var direction := Input.get_axis("a", "d")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        
    if Input.is_action_just_pressed("s") and is_on_floor():
        position.y += 1
        
    move_and_slide()

func _ready() -> void:
    var image = load("res://assets/sprites/player/cursor.png").get_image()  # Lade das Bild
    image.resize(image.get_width() * int(Globals.canvas_scale.x), image.get_height() * Globals.canvas_scale.x, false)  # Verdoppelt die Größe
    Input.set_custom_mouse_cursor(image, Input.CURSOR_ARROW, image.get_size() / 2.0)
