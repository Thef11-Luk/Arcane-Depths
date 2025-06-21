extends Area2D
class_name HurtboxComponent

signal hitbox_entered(area: HitboxComponent)

@export var health_component: HealthComponent
@export var is_player : bool
@export var is_enemy : bool

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    
func _on_area_entered(area: Area2D) -> void:
    if area is HitboxComponent:
        if (is_player and area.is_enemy_projectile) or (is_enemy and area.is_player_projectile):
            health_component.take_damage(area.damage_component.deal_damage())
            hitbox_entered.emit(area)
