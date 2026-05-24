@tool
extends Control

@export var item_container: Control
@export var open_center: OpenCenter
@export var container: Control
var _is_dragging_item = false
var _is_closed = false
var _selected_item
@export_tool_button("toggle_close") var _toggle_close = func():
    _is_closed = not _is_closed
    if _is_closed:
        await close()
    else:
        await open()

func _ready() -> void:
    for i in item_container.get_children():
        i.item_clicked.connect(func(item_name, texture):
            _selected_item = i
            if i.scale != Vector2(1,1):
                await i.reset_scale()
            i.tr_item.hide()
            _is_dragging_item = true
            DragItemGlobal.add_drag_item(item_name, texture, i.global_position)
        )
    await get_tree().process_frame
    open_center.close_state()
    container.hide()
    open()


func _input(e):
    if e is InputEventMouseButton:
        if _is_dragging_item:
            if not e.pressed && e.button_index == MOUSE_BUTTON_LEFT:
                _is_dragging_item = false
                set_process(true)
                _selected_item.tr_item.show()
                
                
func _process(d):
    if _is_dragging_item:
        if not Rect2(container.global_position, container.size).has_point(get_global_mouse_position()):
            set_process(false)
            close()


func open():
    await open_center.open()
    container.show()


func close():
    container.hide()
    await open_center.close()
    queue_free()
