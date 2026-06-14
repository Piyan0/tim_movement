extends Control


@export var _button: Array[HoverableButton]

func _ready() -> void:
    # resume button
    _button[0].cb = func():
        queue_free()

    # load button
    _button[1].cb = func():
        pass
    
    # tittle screen button
    _button[2].cb = func():
        await Bootstrap.fade.fade_in()
        queue_free()
        var title_screen = load("res://ui/main_menu/main_menu.tscn")
        get_tree().change_scene_to_packed(title_screen)
        await Bootstrap.fade.fade_out()