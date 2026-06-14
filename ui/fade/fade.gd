class_name Fade
extends Control

@export var _fade_overlay: ColorRect


func _ready() -> void:
    _fade_overlay.modulate.a = 0

    
func fade_in(dur= 0.2):
    var t = create_tween()
    t.tween_property(_fade_overlay, "modulate:a", 1, dur)
    await t.finished


func fade_out(dur= 0.2):
    var t = create_tween()
    t.tween_property(_fade_overlay, "modulate:a", 0, dur)
    await t.finished


static func spawn():
    var ins = load("res://ui/fade/fade.tscn").instantiate()
    Bootstrap.canvas.add_child(ins)
    return ins