@tool
extends Node2D

@export var interact_pages: Array[InteractPage]


@export_category("Node References")
@export var spr_graphic: Sprite2D
@export var click_area: Area2D
@export var lb_hover: Label
@export_category("")

static var interact_count = 0

var _active_page: InteractPage
var _is_mouse_inside = false


func _ready() -> void:
    if Engine.is_editor_hint():
        for page in interact_pages:
            if page.use_for_preview:
                _update_page(page)
            return

    add_to_group("interact_click")
    lb_hover.text = ""
    click_area.mouse_entered.connect(func():     
        _is_mouse_inside = true
        if interact_count > 0:
            return
        lb_hover.text = _active_page.hover_text
        spr_graphic.texture = _active_page.hover_graphic
         
    )

    click_area.mouse_exited.connect(func():
        _is_mouse_inside = false
        if interact_count > 0:
            return
        lb_hover.text = ""
        spr_graphic.texture = _active_page.idle_graphic
    )



func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
                if interact_count > 0 || !_is_mouse_inside:
                    return
                interact_count += 1
                await _active_page.interact()
                if !_is_mouse_inside:
                    _reset_state()
                interact_count -= 1


func refresh_page(tag_list):
    for page in interact_pages:
        if page.is_active(tag_list):
            _active_page = page
            _update_page(page)
            return


func _reset_state():
    lb_hover.text = ""
    spr_graphic.texture = _active_page.idle_graphic


func _focus_state():
    lb_hover.text = _active_page.hover_text
    spr_graphic.texture = _active_page.hover_graphic


func _update_page(page: InteractPage):
    spr_graphic.texture = page.idle_graphic
    spr_graphic.offset = page.offset
