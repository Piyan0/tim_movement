class_name InteractActions


func text(arr = ["Shane shane.png owh is that right"]):
    var batches: Array[HUDDialogue.DialogueWithPortrait]

    for el in arr:
        var split = Array(el.split(" "))
        var name: String = split[0].replace("_", " ")
        # this is bad...
        if name.to_lower() == "info":
            name = ""

        var portrait_id = split[1]
        var content = split.slice(2)
        content = " ".join(content)
        # printt(name, portrait_id, content)
        var batch_el = HUDDialogue.DialogueWithPortrait.new(
            "" if name == "-" else name,
            content,
            null if portrait_id == "-" else Bootstrap.portraits.get_asset(portrait_id)
        ) 
        batches.append(batch_el)
    
    await Bootstrap.hud.dialogue.start_dialogue(batches)


func goto(map_path, player_pos):
    await Bootstrap.fade.fade_in()
    var ins = load("res://levels/level_screen.tscn").instantiate()
    ins.map_path = map_path
    ins.player_position = player_pos
    await Bootstrap.get_tree().process_frame
    await Bootstrap.get_tree().process_frame
    Bootstrap.get_tree().change_scene_to_node(ins)


# TODO add mutiple tags
func add_tag(tag):
    if tag in Bootstrap.tags:
        return
    Bootstrap.tags.append(tag)
    Bootstrap.get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)



func remove_tag(tag):
    Bootstrap.tags.erase(tag)
    Bootstrap.get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)


func play_bgm(bgm_id: String):
    var audio = load(Bootstrap.audio_db.get_item(bgm_id).path)
    Bootstrap.audio_manager.play_bgm(audio)


func play_sfx(sfx_id: String):
    var audio = load(Bootstrap.audio_db.get_item(sfx_id).path)
    Bootstrap.audio_manager.play_sfx(audio)


func add_item(id, type = "normal"):
    Bootstrap.items.push_back({
        id = id,
        type = type,
    })


func remove_item(id = Bootstrap.state.current_item):
    var to_remove = {}
    for value in Bootstrap.items:
        if value.id == id:
            to_remove = value
            break
    Bootstrap.items.erase(to_remove)


func wait(second):
    await Bootstrap.get_tree().create_timer(second).timeout


func find(name):
    return Bootstrap.get_tree().current_scene.find_child(name)


func image(path, delay = 1):
    var image = load(path)
    var tr = TextureRect.new()
    tr.texture = image
    tr.modulate.a = 0
    tr.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_FULL_RECT)
    Bootstrap.canvas.add_child(tr)
    var t = tr.create_tween()
    t.finished.connect(func():
        tr.queue_free()    
    )
    t.tween_property(tr, "modulate:a", 1, 0.5)
    t.tween_interval(delay)
    t.tween_property(tr, "modulate:a", 0, 0.5)
    await t.finished