class_name Dialogue
extends Control

signal finished()
@export var lb_content: Label
@export var lb_name: Label
@export var open_center: OpenCenter
@export var main_container: Control

var dialogue_base: DialogueBase
var dialogue_batch = [
    DialogueBase.DialogueNormal.new("Godot", "This is a message."),
    DialogueBase.DialogueNormal.new("Godot", "Okay.")
    ]
    
func _ready():
    lb_content.text = ""
    lb_name.text = ""
    dialogue_base = DialogueBase.new()
    dialogue_base.on_progress = func(dialogue, v_chars, just_finished):
        lb_content.text = dialogue.msg
        lb_name.text = dialogue.speaker
        lb_content.visible_characters = v_chars
    
    dialogue_base.batch_finished.connect(func():
        main_container.hide()
        await open_center.close()
        finished.emit()
        queue_free()
    )
    
    await get_tree().process_frame
    open_center.close_state()
    main_container.hide()
    await open_center.open()
    main_container.show()

    
    dialogue_base.dialogue_batch = dialogue_batch
   

func _input(event: InputEvent) -> void:
    dialogue_base.input(event)

    
