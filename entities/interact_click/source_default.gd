extends InteractPageSource


func _hover_text():
    return super()


func _interact():
    actions.remove_item("book_of_spell")
    actions.add_tag("test")
    actions.play_sfx("solved")
    await super()


func _item_dropped(item_id):
    await super(item_id)