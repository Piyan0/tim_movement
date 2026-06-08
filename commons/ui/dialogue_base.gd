class_name DialogueBase
extends Node

signal batch_finished()
signal line_finished()
signal _input_next()

var speed= 20
var dialogue_batch: Array= []: set= _set_dialogue_batch
var on_progress= func(dialogue, visible_character, just_changed): pass
var click_target: Control
var _is_running_dialogue= false
var _t: Tween
var _just_changed= false
var _current_dialogue= ""


func _init(parent, click_target = null) -> void:
    if click_target == null:
        click_target = parent
    
    parent.add_child.call_deferred(self)
    click_target.gui_input.connect(input)
    

func input(event: InputEvent):
    if (
        event is InputEventMouseButton && event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT ||
        event is InputEventScreenTouch && event.is_pressed() ||
        event.is_action_pressed("ui_accept")
    ):
        if _is_running_dialogue:
            _skip(_current_dialogue)
            return
        _input_next.emit()

        
func _set_dialogue_batch(value):
    if _is_running_dialogue:
        return
    dialogue_batch= value
    _start_batch(dialogue_batch)


func _skip(dialogue):
    _t.finished.emit()
    _t.kill()
    on_progress.call(dialogue, dialogue.msg.length(), false)
    line_finished.emit()


func _trigger_progress(visible_characters):
    # await Engine.get_main_loop().process_frame
    on_progress.call(_current_dialogue, visible_characters, _just_changed)
    _just_changed= false
    

func _start_batch(p_dialogue_batch):
    for i: DialogueNormal in p_dialogue_batch:
        _t= Engine.get_main_loop().create_tween()
        _t.tween_method(_trigger_progress, 0, i.msg.length(), _get_time(i.msg))
        _current_dialogue= i
        _is_running_dialogue= true
        _just_changed= true
        await _t.finished
        line_finished.emit()
        _is_running_dialogue= false
        await _input_next
    
    batch_finished.emit()


func _get_time(msg):
    return msg.length() / float(speed)


class DialogueNormal:
    var msg
    var speaker
    func _init(p_speaker, p_msg,):
        speaker= p_speaker
        msg= p_msg
