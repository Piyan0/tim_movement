extends Node2D


func add_drag_item(item):
    item.reparent(self)
    item.item_released.connect(func():
        item.vanish()
    )

