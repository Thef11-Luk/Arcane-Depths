extends Camera2D

# - shaking parameters -
var shake_amount = 0.0
var shake_decay = 5.0

func _process(delta: float) -> void:
    handle_shaking(delta)
    
    
func handle_shaking(delta) -> void:
    if shake_amount > 0:
        offset = Vector2(
            randf_range(-shake_amount, shake_amount),
            randf_range(-shake_amount, shake_amount)
        )
        shake_amount = move_toward(shake_amount, 0.0, shake_amount * delta)
    else:
        offset = Vector2.ZERO
