class_name DragItemManager
extends Node2D


func drag_item(ins: DragableItem):
    ins.item_dropped.connect(func(id, pos):
        printt(id, pos)    
    )
    ins.item_dragged.connect(func(id, pos):
        print("Dragging at pos:", pos)    
    )
    Bootstrap.get_tree().current_scene.add_child(ins)


# func add_drag_item(item_name, texture, pos):
#     var dragable = DragableItem.create(item_name, texture)
#     dragable.position = pos
#     dragable.item_released.connect(func(item_id, drop_pos):
#         get_tree().call_group("interact_click", "handle_item_drop", item_id, drop_pos)
#     )
#     GlobalCanvas.add_child(dragable)
