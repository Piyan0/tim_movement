@tool
class_name HoverableButton
extends MarginContainer


@onready var idle_frame: NinePatchRect = $Control/IdleFrame
@onready var hover_frame: NinePatchRect = $Control/HoverFrame
@onready var label: Label = $MarginContainer/Label
@onready var button: Button = $Button


@export var title: String:
	set(value):		
		title = value
		if label:
			label.text = value
	
var cb = func(): print("the button is pressed.")


func _ready() -> void:
	label.text = title
	button.mouse_entered.connect(func():
		Bootstrap.state.is_hovering_button = true
		idle_frame.hide()
		hover_frame.show()
	)
	
	button.mouse_exited.connect(func():
		idle_frame.show()
		hover_frame.hide()
		Bootstrap.state.is_hovering_button = false
	)
	

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
			cb.call()
	
	elif event is InputEventScreenTouch:
		if event.is_pressed():
			idle_frame.hide()
			hover_frame.show()
		else:
			cb.call()
			idle_frame.show()
			hover_frame.hide()
	
		
