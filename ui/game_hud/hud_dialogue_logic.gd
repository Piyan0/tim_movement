extends Node
class_name HUDDialogue

@export var _dlg_speed = 30
@export var _tr_portrait: TextureRect
@export var _lb_name: Label
@export var _deco: Array[Label]
@export var _lb_content: Label
@export var _click_target: Control


var _base_dlg: DialogueBase

func _ready() -> void:
    reset_content()
    _base_dlg = DialogueBase.new(owner)
    _base_dlg.speed = _dlg_speed
    _base_dlg.on_progress = func(dialogue: DialogueWithPortrait, vis_chars, just_changed):
        if just_changed:
            if dialogue.portrait != null:
                _tr_portrait.show()
                _tr_portrait.texture = dialogue.portrait
            else:
                _tr_portrait.hide()

            _deco.map(func(value):
                value.show()    
            )

        _lb_name.text = dialogue.speaker
        _lb_content.text = dialogue.msg
        _lb_content.visible_characters = vis_chars
    _base_dlg.batch_finished.connect(reset_content)    

    get_parent().set_meta("text", func(batch: Array):
        _base_dlg.dialogue_batch = batch
        await _base_dlg.batch_finished
    )
    

func start_dialogue(batches: Array):
    var prn = get_parent() as Control
    prn.mouse_filter = Control.MOUSE_FILTER_STOP
    _base_dlg.dialogue_batch = batches
    await _base_dlg.batch_finished
    prn.mouse_filter = Control.MOUSE_FILTER_IGNORE


func reset_content():
    _deco.map(func(value):
        value.hide()    
    )
    _tr_portrait.hide()
    _lb_content.text = ""
    _lb_name.text = ""


class DialogueWithPortrait:
    extends DialogueBase.DialogueNormal
    var portrait: Texture2D

    func _init(speaker, msg, portrait):
        super._init(speaker, msg)
        self.portrait = portrait