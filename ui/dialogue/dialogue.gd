class_name Dialogue
extends Control

signal finished()
@export var lb_content: Label
@export var lb_name: Label
@export var open_center: OpenCenter
@export var main_container: Control
@export var tr_avatar: TextureRect
@export var tr_next_hint: TextureRect

var dialogue_base: DialogueBase
var dialogue_batch = [
    DialogueLine.new("Godot", "This is a message."),
    DialogueLine.new("Godot", "Okay.")
    ]
    
func _ready():
    modulate = Color.TRANSPARENT
    lb_content.text = ""
    lb_name.text = ""
    tr_avatar.hide()
    tr_next_hint.hide()
    dialogue_base = DialogueBase.new()
    dialogue_base.on_progress = func(dialogue, v_chars, just_finished):
        tr_next_hint.hide()
        if dialogue.get_avatar() != null:
            tr_avatar.show()
            tr_avatar.texture = dialogue.get_avatar()
        else:
            tr_avatar.hide()
            
        lb_content.text = dialogue.msg
        lb_name.text = dialogue.speaker
        lb_content.visible_characters = v_chars
    dialogue_base.line_finished.connect(func():
        tr_next_hint.show()
    )
    
    dialogue_base.batch_finished.connect(func():
        main_container.hide()
        await open_center.close()
        finished.emit()
        queue_free()
    )
    
    await get_tree().process_frame
    modulate = Color.WHITE
    open_center.close_state()
    main_container.hide()
    await open_center.open()
    main_container.show()

    
    dialogue_base.dialogue_batch = dialogue_batch
   

func _input(event: InputEvent) -> void:
    dialogue_base.input(event)

    
class DialogueLine:
    extends DialogueBase.DialogueNormal
    
    var avatar_path = "lilian"
    func get_avatar():
        if avatar_path.is_empty():
            return null
        return load("res://assets/images/portraits/"+avatar_path+".png")
