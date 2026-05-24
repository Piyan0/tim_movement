extends Control

@export var btn_world_map: Button
@export var btn_inventory: Button

func _ready():
    btn_inventory.pressed.connect(func():
        var inv = load("uid://b8kkjdii5quo6").instantiate()
        btn_inventory.disabled = true
        GlobalCanvas.add_child(inv)
        await inv.tree_exited
        btn_inventory.disabled = false
    )
    
