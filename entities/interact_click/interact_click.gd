@tool
extends Node2D

@export var interact_pages: Array[InteractPage]


@export_category("Node References")
@export var spr_graphic: Sprite2D
@export var click_area: Control
@export var lb_hover: Label
@export_category("")

static var interact_count = 0

var pre_interact = func(pos): pass
var _active_page: InteractPage
var _is_mouse_inside = false


func _ready() -> void:
    if Engine.is_editor_hint():
        for page: InteractPage in interact_pages:
            if page.use_for_preview:
                page.prop_changed.connect(func(p_name, value):
                    match  p_name:
                        "graphic":
                            spr_graphic.texture = value
                        "offset":
                            spr_graphic.offset = value
                )

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

    # since this is smaller project, I just assign the logic here for player to reach the interact point.
    pre_interact = func(pos):
        await Player.instance.move_to_pos(pos, 120)


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
                if !_can_interact(): return
                
                _focus_state()
                interact_count += 1
                Bootstrap.state.is_interact = true
                await pre_interact.call(global_position)
                await _active_page.interact()
                Bootstrap.state.is_interact = false
                if !_is_mouse_inside:
                    _reset_state()
                interact_count -= 1


func handle_item_drop(item_id, drop_position):
    if !get_click_rect().has_point(drop_position):
        return
    interact_count += 1    
    await _active_page.item_dropped(item_id)
    _reset_state()
    interact_count -= 1


func get_click_rect():
    return Rect2(click_area.global_position, click_area.size)


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


func _can_interact():
    var conditions = [
        interact_count == 0,
        get_click_rect().has_point(get_global_mouse_position())
    ]

    return conditions.all(func(cond): return cond == true) 
