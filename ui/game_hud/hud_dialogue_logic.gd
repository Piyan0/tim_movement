extends Node


@export var _dlg_speed = 30
@export var _tr_portrait: TextureRect
@export var _lb_name: Label
@export var _deco: Array[Label]
@export var _lb_content: Label


var _base_dlg: DialogueBase

func _ready() -> void:
    reset_content()
    _base_dlg = DialogueBase.new(self)
    _base_dlg.speed = _dlg_speed
    _base_dlg.on_progress = func(dialogue: DialogueWithPortrait, vis_chars, just_changed):
        if just_changed:
            if dialogue.portrait_id != "":
                _tr_portrait.show()
                _tr_portrait.texture = Bootstrap.portraits.get_asset(dialogue.portrait_id)
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
    
    # await get_tree().create_timer(1).timeout
    # var x = [
    #     DialogueWithPortrait.new("Anjay", "Mabar"),
    #     DialogueWithPortrait.new("Anjay", "Anjay mabar keren euy...", "shane.png"),
    # ] 
 
    # _base_dlg.dialogue_batch = x

func reset_content():
    _deco.map(func(value):
        value.hide()    
    )
    _tr_portrait.hide()
    _lb_content.text = ""
    _lb_name.text = ""


func _input(event: InputEvent) -> void:
    _base_dlg.input(event)


class DialogueWithPortrait:
    extends DialogueBase.DialogueNormal
    var portrait_id: String

    func _init(speaker, msg, portrait_id = ""):
        super._init(speaker, msg)
        self.portrait_id = portrait_id