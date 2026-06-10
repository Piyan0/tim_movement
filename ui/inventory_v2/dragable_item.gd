class_name DragableItem
extends Control

signal item_dropped(id, pos)
signal item_dragged(id, pos)


@export var _tr_item: TextureRect
@export var item_id: String = "<item_id>"

var icon:
    set(value):
        icon = value
        _tr_item.texture = value

var _drag = false
var _drag_pos = Vector2.ZERO


func _ready() -> void:
    _drag_pos += position


func _process(delta):
    position = lerp(global_position, _grab_pos(), 0.2)
    item_dragged.emit(item_id, global_position)


func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion || event is InputEventScreenDrag:
        _drag_pos = event.position

    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && !event.is_pressed():
            _drag = false
            var args = [item_id ,global_position]
            item_dropped.emit(args[0], args[1])
            queue_free()

    if event is InputEventScreenTouch:
        if !event.is_pressed():
            _drag = false
            var args = [item_id ,global_position]
            item_dropped.emit(args[0], args[1])
            queue_free()
    

static func spawn(initial_pos, id, icon):
    var ins = load("uid://bs0fevfkhn7d5").instantiate() as DragableItem

    ins.icon = icon
    ins._drag_pos += Vector2(ins.size.x/2, ins.size.y/2)
    ins.position = initial_pos - Vector2(ins.size.x/2, ins.size.y/2)
    ins.item_id = id
    Bootstrap.drag_item_manager.drag_item(ins)
    return ins


func _grab_pos():
    return _drag_pos - Vector2(size.x/2, size.y/2)