@tool
class_name InteractPage
extends Resource

signal prop_changed(name, value)

@export var source: GDScript
@export var use_for_preview = false
@export var idle_graphic: Texture2D:
    set(value):
        idle_graphic = value
        prop_changed.emit("graphic", value)
@export var hover_graphic: Texture2D

@export var offset: Vector2:
    set(value):
        offset = value
        prop_changed.emit("offset",value)
@export var tags: Array[String]

var hover_text:
    get():
        var hover_text = source.new()._hover_text() 
        return hover_text if hover_text != null else ""


func interact():
    await source.new()._interact()


func item_dropped(item_id):
    await source.new()._item_dropped(item_id)


func is_active(tags_list):
    if tags.is_empty():
        return true
        
    return tags.all(func(tag):
        return tag.strip_edges() in tags_list
    )
    
    
