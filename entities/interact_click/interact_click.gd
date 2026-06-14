@tool
extends Node2D

@export var interact_pages: Array[InteractPage]
@export var _interact_distance = 120
@export_category("Node References")
@export var spr_graphic: Sprite2D
@export var click_area: Control
@export var lb_hover: Label
@export_category("")


var pre_interact = func(pos): pass

var _is_interact = false
var _active_page: InteractPage
var _input: InputHandler

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
   
    # since this is smaller project, I just assign the logic here for player to reach the interact point.
    pre_interact = func(pos):
        var player = Player.instance
        var distance = player.global_position.distance_to(global_position)
        if distance > _interact_distance:
            await Player.instance.move_to_pos(pos, _interact_distance)
        else:
            Player.instance.set_facing_to_pos(global_position)
       

    _input = InputHandler.new(self)

    _input.handler = func(event: InputEvent):
        if event is InputEventMouseMotion || event is InputEventScreenDrag:
            if _is_interact: return
            if get_click_rect().has_point(event.position):
                lb_hover.text = _active_page.hover_text
                spr_graphic.texture = _active_page.hover_graphic
            else:
                lb_hover.text = ""
                spr_graphic.texture = _active_page.idle_graphic
    
    click_area.gui_input.connect(func(event: InputEvent):
        if event is InputEventMouseButton:
            if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
                if get_click_rect().has_point(click_area.get_global_transform_with_canvas().origin + event.position):
                    _interact(func():
                        await _active_page.interact()    
                    )

        if event is InputEventScreenTouch:
            if event.pressed:
                if get_click_rect().has_point(click_area.get_global_transform_with_canvas().origin + event.position):
                    lb_hover.text = _active_page.hover_text
                    spr_graphic.texture = _active_page.hover_graphic
                    await get_tree().create_timer(0.5).timeout
                    lb_hover.text = ""
                    await _interact(func():
                        await _active_page.interact()    
                    )
                    spr_graphic.texture = _active_page.idle_graphic
    )


func handle_item_drop(item_id, drop_position):
    if !_can_interact(): return
    if !get_click_rect().has_point(drop_position):
        return
    _interact(func():
        await _active_page.item_dropped(item_id)    
    )


func get_click_rect():
    return Rect2(click_area.get_global_transform_with_canvas().origin, click_area.size)


func refresh_page(tag_list):
    for page in interact_pages:
        if page.is_active(tag_list):
            _active_page = page
            _update_page(page)
            return


func _interact(interact_cb):
    if !_can_interact(): return
    lb_hover.text = ""
    _is_interact = true
    get_viewport().set_input_as_handled()
    Bootstrap.state.is_interact = true
    await pre_interact.call(global_position)
    await interact_cb.call()
    Bootstrap.state.is_interact = false
    _is_interact = false


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
    var conditions = [!_is_interact]
    return conditions.all(func(cond): return cond == true) 
