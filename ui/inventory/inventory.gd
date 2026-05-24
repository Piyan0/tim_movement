extends Control

@export var item_container: Control

func _ready() -> void:
    for i in item_container.get_children():
        i.item_picked.connect(func():
            DragItemGlobal.add_drag_item(i)
            for j in item_container.get_children():
                self_modulate = Color.TRANSPARENT
                j.allow_pick = false    
            queue_free()
        )

        i.item_released.connect(func():
            for j in item_container.get_children():
                j.allow_pick = true    
        )
