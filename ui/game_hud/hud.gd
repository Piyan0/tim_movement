class_name HUD
extends Control

@export var dialogue: HUDDialogue

@export var _ph_pause_menu: Node
@export var _ph_mini_map: Node 
@export var _inventory_place: Control
@export var _buttons: Array[HoverableButton]

var _inventory = null

func _ready() -> void:
    # button menu
    _buttons[0].cb = func():
        _ph_pause_menu = _ph_pause_menu as InstancePlaceholder
        var ins = _ph_pause_menu.create_instance()        

    # button inventory
    _buttons[1].cb = func():
        # print("button inventory")
        if _inventory != null:
            _inventory.queue_free()
            return

        Bootstrap.state.is_showing_overlay = true
        var inventory = InventoryV2.spawn() as InventoryV2
        inventory.from_data(Bootstrap.items)
        _inventory = inventory
        _inventory_place.add_child(inventory)
        inventory.set_offsets_preset(PRESET_BOTTOM_RIGHT)
        inventory.tree_exited.connect(func():
            Bootstrap.state.is_showing_overlay = false
            _inventory = null
        )

    # buttonworld map
    _buttons[2].cb = func():
        _ph_mini_map = _ph_mini_map as InstancePlaceholder
        var ins = _ph_mini_map.create_instance()
        var mini_map_scale = 0.0791
        ins.marker_pos = Player.instance.global_position * mini_map_scale

static func spawn():
    var ins = load("uid://bxikvddg4fkyy").instantiate()
    Bootstrap.canvas.add_child(ins)
    return ins


func _spawn_inventory():
    pass
