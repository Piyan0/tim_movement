class_name HUD
extends Control

@export var dialogue: HUDDialogue
@export var _inventory_place: Control
@export_category("Buttons")
@export var _buttons: Array[HoverableButton]


func _ready() -> void:
    # button menu
    _buttons[0].cb = func():
        print("button menu")

    # button inventory
    _buttons[1].cb = func():
        # print("button inventory")
        var inventory = InventoryV2.spawn() as Control
        _inventory_place.add_child(inventory)
        inventory.set_offsets_preset(PRESET_CENTER_BOTTOM)

    # buttonworld map
    _buttons[2].cb = func():
        print("button map")


static func spawn():
    var ins = load("uid://bxikvddg4fkyy").instantiate()
    Bootstrap.canvas.add_child(ins)
    return ins


func _spawn_inventory():
    pass