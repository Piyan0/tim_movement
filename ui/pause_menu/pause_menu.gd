extends Control


@export var _button: Array[HoverableButton]
@export var _ph_slot_select: Node

var slot_select: LoadMenu

func _ready() -> void:
    # resume button
    _button[0].cb = func():
        queue_free()

    # save button
    _button[1].cb = func():
        slot_select = _select_slot()
        slot_select.slot_clicked.connect(func(slot_id, has_data):
            Bootstrap.slot_save_manager.save(slot_id)
            await Bootstrap.save_image_created
            slot_select.from_save_collections(Env.SAVE_COLLECTIONS)    
        )

    # load button
    _button[2].cb = func():
        slot_select = _select_slot()
        slot_select.slot_clicked.connect(func(slot_id, has_data):
            if has_data:
                var data = Bootstrap.slot_save_manager.load_data(slot_id)
        )
    
    # tittle screen button
    _button[3].cb = func():
        await Bootstrap.fade.fade_in()
        queue_free()
        var title_screen = load("res://ui/main_menu/main_menu.tscn")
        get_tree().change_scene_to_packed(title_screen)
        await Bootstrap.fade.fade_out()


func _select_slot():
    _ph_slot_select = _ph_slot_select as InstancePlaceholder
    var ins = _ph_slot_select.create_instance() as LoadMenu
    ins.from_save_collections(Env.SAVE_COLLECTIONS)
    return ins
