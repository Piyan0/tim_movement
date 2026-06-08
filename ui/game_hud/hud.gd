class_name HUD
extends Control


@export_category("Buttons")
@export var _buttons: Array[HoverableButton]

func _ready() -> void:
    # button menu
    _buttons[0].cb = func():
        print("button menu")

    # button inventory
    _buttons[1].cb = func():
        print("button inventory")

    # buttonworld map
    _buttons[2].cb = func():
        print("button map")

