class_name DragItemManager
extends Node2D


func drag_item(ins: DragableItem):
    ins.item_dropped.connect(func(id, pos):
        printt(id, pos)
        Bootstrap.get_tree().call_group("interact_click" ,"handle_item_drop", id, pos) 
        Bootstrap.state.item_being_dragged = null
    )
    ins.item_dragged.connect(func(id, pos):
        Bootstrap.state.item_being_dragged = id
        # print("Dragging at pos:", pos)    
    )
    Bootstrap.canvas.add_child(ins)
