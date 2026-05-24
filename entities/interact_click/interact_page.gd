class_name InteractPage
extends Resource

@export var source: GDScript:
    get():
        return source.new()

@export var idle_graphic: Texture2D
@export var hover_graphic: Texture2D
@export var offset: Vector2
@export var tags: Array[String]

var hover_text:
    get():
        return source._hover_text()


func interact():
    await source._interact()
        

func is_active(tags_list):
    if tags.is_empty():
        return true
        
    return tags.all(func(tag):
        return tag.strip_edges() in tags_list
    )
    
    
