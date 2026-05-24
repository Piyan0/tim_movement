@tool
extends Control

@export var item_container: Control
@export var open_center: OpenCenter
@export var container: Control

var _is_closed = false
@export_tool_button("toggle_close") var _toggle_close = func():
    _is_closed = not _is_closed
    if _is_closed:
        await close()
    else:
        await open()

func _ready() -> void:
    for i in item_container.get_children():
        i.item_clicked.connect(func(item_name, texture):
            await i.reset_scale()
            close()
            DragItemGlobal.add_drag_item(item_name, texture, i.global_position)
        )
    await get_tree().process_frame
    open_center.close_state()
    container.hide()
    open()


func open():
    await open_center.open()
    container.show()


func close():
    container.hide()
    await open_center.close()
    queue_free()
