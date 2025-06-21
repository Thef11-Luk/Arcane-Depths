extends Area2D
class_name HitboxComponent

signal hurtbox_entered(area: HurtboxComponent)

@export var damage_component: DamageComponent
@export var projectile_status_effect_component: ProjectileStatusEffectComponent
@export var is_player_projectile: bool 
@export var is_enemy_projectile: bool

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    
func _on_area_entered(area: Area2D) -> void:
    if area is HurtboxComponent:
        if (is_player_projectile and area.is_enemy) or (is_enemy_projectile and area.is_player):
            hurtbox_entered.emit(area)
