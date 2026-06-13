extends InteractPageSource

func _hover_text():
    if Bootstrap.state.item_being_dragged:
        return "Give"
    else:
        return "talk"


func _interact():
    var x = InteractActions.new()
    var shane = "Shane shane.png %s"
    var lilian = "Lilian lilian.png %s"

    var arr = []
    arr.append( shane % "Yo what up." )
    arr.append( lilian % "All's fine boss!" )

    await x.text(arr)


func _item_dropped(item_id):
    var x = InteractActions.new()
    var shane = "Shane shane.png %s"
    var lilian = "Lilian lilian.png %s"

    var arr = []
    arr.append( shane % "Here's for you." )
    arr.append( lilian % "Nah, I don't need that..." )

    await x.text(arr)
   