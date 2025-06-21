extends CharacterBody2D

# --- Exported Variables ---
@export var max_jump_trigger_time: float = 0.5  # Maximum time jump can be triggered
@export var jump_velocity: float = -300.0       # Initial jump velocity
@export var lowest_camera_y_position: float = 0.0
@export var SPEED = 100.0 # Horizontal movement speed

# --- Node References ---
@onready var camera_2d: Camera2D = $Camera2D
@onready var dying_particles: CPUParticles2D = $DyingParticles
@onready var sprite_2d: Sprite2D = $Sprite2D

# --- Member Variables ---
var jump_trigger_time: float = 0.0  # Tracks jump trigger duration

func _physics_process(delta: float) -> void:
    # --- Gravity ---
    # Apply gravity if not on the floor
    if not is_on_floor():
        velocity += get_gravity() * delta

    # --- Jump Handling ---
    # If jump is being triggered and within allowed time, apply jump logic
    if jump_trigger_time > 0.0 and jump_trigger_time < max_jump_trigger_time:
        jump_trigger_time += delta
        velocity.y = jump_velocity * 1.0 - max_jump_trigger_time / jump_trigger_time
    else:
        jump_trigger_time = 0.0

    # Start jump if 'w' is just pressed and on the floor
    if Input.is_action_just_pressed("w") and is_on_floor():
        jump_trigger_time = delta
    # Cancel jump if 'w' is just released
    if Input.is_action_just_released("w"):
        jump_trigger_time = 0.0

    # --- Horizontal Movement ---
    var direction := Input.get_axis("a", "d")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    # --- Downward Nudge ---
    # Move player slightly down if 's' is pressed and on the floor
    if Input.is_action_just_pressed("s") and is_on_floor():
        position.y += 1

    # --- Apply Movement ---
    move_and_slide()

func _ready() -> void:
    # --- Custom Mouse Cursor Setup ---
    var image = load("res://assets/sprites/player/cursor.png").get_image()  # Load cursor image
    image.resize(
        image.get_width() * int(Globals.canvas_scale.x),
        image.get_height() * Globals.canvas_scale.x,
        false
    )  # Resize image based on canvas scale
    Input.set_custom_mouse_cursor(image, Input.CURSOR_ARROW, image.get_size() / 2.0)  # Set custom cursor
    
func _process(_delta: float) -> void:
    move_camera()   # handling camera movement
    
    
func move_camera() -> void:
    if is_on_floor():
        camera_2d.position.y = lowest_camera_y_position    #moves the camera up- or downwards if the player is on the floor

func shake_camera(intensity) -> void:
    camera_2d.shake_amount = intensity
