class_name InteractPage
extends Resource

@export var source: GDScript
@export var use_for_preview = false
@export var idle_graphic: Texture2D
@export var hover_graphic: Texture2D
@export var offset: Vector2
@export var tags: Array[String]

var hover_text:
    get():
        return source.new()._hover_text()


func interact():
    await source.new()._interact()
        

func is_active(tags_list):
    if tags.is_empty():
        return true
        
    return tags.all(func(tag):
        return tag.strip_edges() in tags_list
    )
    
    
