class_name MainMenu
extends Control


@export_category("OptionsView")
@export var _btn_start: HoverableButton
@export var _buttons: Array[HoverableButton]
@export var _hero: TextureRect
@export var _options_container: Control
@export var _ph_load_menu: Node


func _ready() -> void:
    var actions = InteractActions.new()
    actions.play_bgm("menu")
    _hide_options()

    _btn_start.cb = func():
        _display_options()
    
    # new game options.
    _buttons[0].cb = func():
        Bootstrap.fresh()
        var starting_scene_file = FileAccess.open("res://.starting_scene", FileAccess.READ)
        var scene = starting_scene_file.get_line()
        var initial_player_pos = starting_scene_file.get_line()

        var x = InteractActions.new()
        await x.goto(scene, str_to_var(initial_player_pos))

       
    # continue options.
    _buttons[1].cb = func():
        var continue_slot = Env.CONTINUE_SLOT
        print(continue_slot)
        if continue_slot != -1:
            Bootstrap.slot_save_manager.load_data(continue_slot)


    # load options.
    _buttons[2].cb = func():
        _ph_load_menu = _ph_load_menu as InstancePlaceholder
        var ins = _ph_load_menu.create_instance() as LoadMenu
        # print(Env.SAVE_COLLECTIONS)
        ins.from_save_collections(Env.SAVE_COLLECTIONS)
        ins.slot_clicked.connect((func(slot_id, has_data):
            if has_data:
                # TODO this is bad, env should be read only but, I gues I'll deal with it later
                Env.CONTINUE_SLOT = slot_id
                Bootstrap.slot_save_manager.load_data(slot_id)
            ), CONNECT_ONE_SHOT
        )

    # quit options.
    _buttons[3].cb = func():
        if OS.has_feature("web"):
            JavaScriptBridge.eval("window.close()")
        else:
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
