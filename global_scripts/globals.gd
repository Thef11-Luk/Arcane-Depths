extends Node

var vars: Dictionary = {}

#canvas scale
var canvas_scale: Vector2

func calculate_canvas_scale() -> void:
    var viewport_size = get_viewport().size
    var original_size = Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))
    canvas_scale = Vector2(viewport_size.x / original_size.x, viewport_size.y / original_size.y)


#settings
const DEFAULT_SETTINGS: Dictionary =  {
}

var settings = DEFAULT_SETTINGS.duplicate()

func load_or_initialize_settings() -> void:
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
    var file = FileAccess.open("user://settings.cfg", FileAccess.WRITE)
    file.store_var(settings)
    file.close()
    
func apply_settings():
    pass


func _ready() -> void:
    calculate_canvas_scale()
    load_or_initialize_settings()
    apply_settings()
    
