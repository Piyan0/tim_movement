extends Node2D


@export var movement: PlayerMovement
@export var lb_hint: Label

func _ready() -> void:
    movement.on_move_changed.connect(func(pos):
        position = pos    
    ) 

    movement.direction_changed.connect(func(prev_dir, dir):
        lb_hint.text = str(dir)
    )
