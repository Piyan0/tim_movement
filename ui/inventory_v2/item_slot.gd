class_name ItemSlot
extends PanelContainer

signal item_picked()
signal item_dropped()

@export var icon: Texture2D:
    set(value):
        icon = value
        if _tr_item:
            _tr_item.texture = value

@export var item_id: String = ""
@export var _tr_item: TextureRect
var is_empty:
    get():
        return item_id.is_empty()


func _ready() -> void:
    _tr_item.texture = icon
    mouse_entered.connect(func():
        if is_empty: return
        var t = create_tween()
        t.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)    
    )

    mouse_exited.connect(func():
        if is_empty: return
        var t = create_tween()
        t.tween_property(self, "scale", Vector2(1, 1), 0.1)    
    )

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
            _pick_item(event)

    elif event is InputEventScreenTouch:
        if event.is_pressed():
            _pick_item(event)


func _pick_item(event):
    if is_empty: return
    
    Bootstrap.state.current_item = item_id
    item_picked.emit()
    var dragable_item = DragableItem.spawn(global_position + event.position, item_id, icon)
    dragable_item.item_dropped.connect(func(id, pos):
        item_dropped.emit()
        _tr_item.show()  
    , CONNECT_ONE_SHOT)
    _tr_item.hide()
