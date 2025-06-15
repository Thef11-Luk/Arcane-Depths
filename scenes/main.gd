extends Node

@export var lobby : PackedScene
var current_scene : Node2D

func start_game() -> void:
    current_scene = lobby.instantiate()
    add_child(current_scene)

func _ready() -> void:
    start_game()
