class_name Slot
extends PanelContainer

signal slot_clicked(slot_id)

@export var slot_id = -1
@export var _lb_slot: Label
@export var _tr_preview: TextureRect

var image_preview: Texture2D:
    set(value):
        image_preview = value
        if _tr_preview:
            _tr_preview.texture = value
var has_data = false


func _ready() -> void:
    _lb_slot.text = name
    if image_preview != null:
        _tr_preview.texture = image_preview
    

func _gui_input(event: InputEvent) -> void:
    # if !has_data: return
    if event is InputEventMouseButton && event.is_pressed():
        if event.button_index == MOUSE_BUTTON_LEFT:
            slot_clicked.emit(slot_id)

    elif event is InputEventScreenTouch && event.is_pressed():
            slot_clicked.emit(slot_id)
        
