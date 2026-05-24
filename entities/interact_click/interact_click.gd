extends Node2D

@export var interact_pages: Array[InteractPage]

var _active_page: InteractPage

@export_category("Node References")
@export var spr_graphic: Sprite2D
@export_category("")


func refresh_page(tag_list):
    for page in interact_pages:
        if page.is_active(tag_list):
            _active_page = page
            _update_page(page)
            return


func _update_page(page: InteractPage):
    spr_graphic.texture = page.idle_graphic
    spr_graphic.offset = page.offset
