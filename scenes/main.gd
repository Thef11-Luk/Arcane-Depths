extends Node

# Exported PackedScene for the lobby, set in the editor
@export var lobby : PackedScene
# Reference to the currently active scene (e.g., lobby, game, etc.)
var current_scene : Node2D

# Instantiates and adds the lobby scene as a child
func start_game() -> void:
    current_scene = lobby.instantiate()
    add_child(current_scene)

# Called when the node is added to the scene tree for the first time
func _ready() -> void:
    start_game()
