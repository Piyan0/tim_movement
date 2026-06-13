extends Control


@export_category("OptionsView")
@export var _btn_start: HoverableButton
@export var _buttons: Array[HoverableButton]
@export var _hero: TextureRect
@export var _options_container: Control
@export var _ph_load_menu: Node


func _ready() -> void:
    _hide_options()

    _btn_start.cb = func():
        _display_options()
    
    # new game options.
    _buttons[0].cb = func():
        modulate.a = 0        
        var x = ResourceLoader.load_threaded_request("res://levels/main/main.tscn")
        while true:
            if ResourceLoader.load_threaded_get_status("res://levels/main/main.tscn") == ResourceLoader.THREAD_LOAD_LOADED:
                break
            await get_tree().process_frame

        get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://levels/main/main.tscn"))
        print(1)       

    # continue options.
    _buttons[1].cb = func():
        print("continue")

    # load options.
    _buttons[2].cb = func():
        _ph_load_menu = _ph_load_menu as InstancePlaceholder
        var ins = _ph_load_menu.create_instance() as LoadMenu
        ins.slot_clicked.connect(func(slot):
            print(slot)
            if slot == -1:
                ins.queue_free()    
        )

    # quit options.
    _buttons[3].cb = func():
        get_tree().quit()


func _hide_options():
    _options_container.hide()
    _hero.modulate = Color.TRANSPARENT

    for btn in _buttons:
        btn.modulate = Color.TRANSPARENT


func _display_options():
    _options_container.show()
    var t = create_tween()
    t.tween_property(_hero, "modulate", Color.WHITE, 0.5)

    await t.finished

    for button in _buttons:
        t = create_tween()
        t.tween_property(button, "modulate", Color.WHITE, 0.1)
        await get_tree().create_timer(0.1).timeout
