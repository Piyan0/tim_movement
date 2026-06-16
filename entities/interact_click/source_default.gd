extends InteractPageSource


func _hover_text():
    return super()


func _interact():
    actions.add_tag("test")
    await super()


func _item_dropped(item_id):
    await super(item_id)