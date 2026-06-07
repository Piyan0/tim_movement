@tool
extends MarginContainer


@onready var idle_frame: NinePatchRect = $Control/IdleFrame
@onready var hover_frame: NinePatchRect = $Control/HoverFrame
@onready var label: Label = $MarginContainer/Label
@onready var button: Button = $Button


@export var title = "text":
	set(value):
		if !is_inside_tree():
			await ready
		
		title = value
		label.text = value
	
var cb = func(): print("the button is pressed.")


func _ready() -> void:
	button.mouse_entered.connect(func():
		idle_frame.hide()
		hover_frame.show()
	)
	
	button.mouse_exited.connect(func():
		idle_frame.show()
		hover_frame.hide()
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
	
		
