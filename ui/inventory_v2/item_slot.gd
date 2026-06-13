class_name ItemSlot
extends PanelContainer

signal item_picked()
signal item_dropped()

@export var icon: Texture2D
@export var item_id: String
@export var _tr_item: TextureRect

func _ready() -> void:
    mouse_entered.connect(func():
        var t = create_tween()
        t.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)    
    )

    mouse_exited.connect(func():
        var t = create_tween()
        t.tween_property(self, "scale", Vector2(1, 1), 0.1)    
    )

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
            item_picked.emit()
            var dragable_item = DragableItem.spawn(global_position + event.position, item_id, icon)
            dragable_item.item_dropped.connect(func(id, pos):
                item_dropped.emit()
                _tr_item.show()  
            , CONNECT_ONE_SHOT)
            _tr_item.hide()


    elif event is InputEventScreenTouch:
        if event.is_pressed():
            item_picked.emit()
            var dragable_item = DragableItem.spawn(global_position + event.position, item_id, icon)
            dragable_item.item_dropped.connect(func(id, pos):
                item_dropped.emit()
                _tr_item.show()  
            , CONNECT_ONE_SHOT)
            _tr_item.hide()
          
