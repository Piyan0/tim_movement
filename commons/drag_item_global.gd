extends Node2D


func add_drag_item(item_name, texture, pos):
    var dragable = DragableItem.create(item_name, texture)
    dragable.position = pos
    GlobalCanvas.add_child(dragable)
