extends InteractPageSource

func _hover_text():
    return "talk"


func _interact():
    var x = InteractActions.new()
    var text = []
    text.append("Lilian/lilian/ It's a good day right...")
    text.append("Shane/ shane / See you later")
    await x.text(text)
