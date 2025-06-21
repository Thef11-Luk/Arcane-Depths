extends Node2D
class_name DamageComponent

@export var base_damage: int = 10
@export var percentage_damage: float = 1.0

func deal_damage() -> int:
    return int(float(base_damage) * percentage_damage)
