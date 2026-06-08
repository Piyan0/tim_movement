extends Control


@export_category("OptionsView")
@export var _btn_start: HoverableButton
@export var _buttons: Array[HoverableButton]
@export var _hero: TextureRect
@export var _options_container: Control


func _ready() -> void:
    _hide_options()

    _btn_start.cb = func():
        _display_options()
    
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
