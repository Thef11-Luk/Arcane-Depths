@tool
extends Node2D
class_name HealthComponent

signal health_changed(amount : int, current_health : int)    # signal emitted when damage is taken or healed
signal health_depleted  # signal emitted when health reaches 0 or below
signal invicibility_changed(mode : bool) # emitted when the player starts or stops being invincible

@export_category("Health Settings")
@export var max_health : int = 100
@export var allow_overheal : bool = false

@export_category("Invincibility")
@export var invincible : bool = false
@export var invincibility_duration : float = 1.0

var current_health : int

func _ready() -> void:
    current_health = max_health


# --- Health ----
func take_damage(amount : int) -> void:
    if invincible or amount <= 0:
        return
        
    current_health = max(current_health - amount, 0)    # ensure health doesn't go below 0
    health_changed.emit(-amount, current_health)
    
    if current_health <= 0:
        health_depleted.emit()
        
func heal(amount : int) -> void:
    if allow_overheal:
        current_health += amount
    else:
        
        current_health = min(current_health + amount, max_health)   # ensure health doesn't exceed max
    health_changed.emit(amount, current_health)
    
func get_health_percentage() -> float:
    return float(current_health) / max_health
    
func reset_health() -> void:
    health_changed.emit(max_health - current_health, max_health)
    current_health = max_health


# --- Invincibility ---
func change_invincibility(mode : bool) -> void:
    invincible = mode
    invicibility_changed.emit(mode)
    
func start_temporary_invincibility() -> void:
    change_invincibility(true)
    await get_tree().create_timer(invincibility_duration).timeout
    change_invincibility(false)
