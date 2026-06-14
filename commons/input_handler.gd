class_name InputHandler
extends Node

enum InputMode{
    INPUT,
    UNHANDLED_INPUT,
}

var mode = InputMode.INPUT
var handler = func(input_event: InputEvent): pass
var can_process = func() -> Array[bool]: return [true]
var _handler_list = []


func _init(parent) -> void:
    parent.add_child.call_deferred(self)
    name = "InputHandler"


func add(action, cb):
    _handler_list.append({
        action = action,
        cb = cb,
    })


func _process_input(input_event: InputEvent):
    if !can_process.call().all(func(value): return value): return

    for handler in _handler_list:
        if input_event.is_action(handler.action) and input_event.is_pressed():
            handler.cb.call()

    handler.call(input_event)
    

func _input(event: InputEvent) -> void:
    if mode == InputMode.INPUT:
        _process_input(event)


func _unhandled_input(event: InputEvent) -> void:
    if mode == InputMode.UNHANDLED_INPUT:
        _process_input(event)
