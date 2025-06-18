extends Node

# --- Global Variables ---
var vars: Dictionary = {}  # General-purpose global dictionary

# --- Canvas Scale ---
var canvas_scale: Vector2  # Stores the current canvas scaling factor

func calculate_canvas_scale() -> void:
    # --- Calculate Canvas Scale Based on Viewport and Original Size ---
    var viewport_size = get_viewport().size
    var original_size = Vector2(
        ProjectSettings.get("display/window/size/viewport_width"),
        ProjectSettings.get("display/window/size/viewport_height")
    )
    canvas_scale = Vector2(viewport_size.x / original_size.x, viewport_size.y / original_size.y)

# --- Settings Management ---
const DEFAULT_SETTINGS: Dictionary =  {
    # Add default settings here as needed
}

var settings = DEFAULT_SETTINGS.duplicate()  # Current settings dictionary

func load_or_initialize_settings() -> void:
    # --- Load Settings from File or Initialize Defaults ---
    if FileAccess.file_exists("user://settings.cfg"):
        var file = FileAccess.open("user://settings.cfg", FileAccess.READ)
        var loaded_settings = file.get_var()
        file.close()
        for key in loaded_settings:
            if DEFAULT_SETTINGS.has(key):
                settings[key] = loaded_settings[key]
    else:
        save_settings()

func save_settings() -> void:
    # --- Save Current Settings to File ---
    var file = FileAccess.open("user://settings.cfg", FileAccess.WRITE)
    file.store_var(settings)
    file.close()
    
func apply_settings():
    # --- Apply Settings to Game (stub) ---
    pass

func _ready() -> void:
    # --- Initialization on Node Ready ---
    calculate_canvas_scale()
    load_or_initialize_settings()
    apply_settings()

