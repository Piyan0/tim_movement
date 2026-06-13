extends Control
class_name LoadMenu


signal slot_clicked(slot)

@export var slot_list: Array[HoverableButton]

func _ready() -> void:
    for slot in slot_list:
        slot.cb = func():
            slot_clicked.emit(int(slot.name))