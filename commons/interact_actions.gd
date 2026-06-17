class_name InteractActions


func text(arr = ["Shane shane.png owh is that right"]):
    var batches: Array[HUDDialogue.DialogueWithPortrait]

    for el in arr:
        var split = Array(el.split(" "))
        var name = split[0]
        var portrait_id = split[1]
        var content = split.slice(2)
        content = " ".join(content)
        # printt(name, portrait_id, content)
        var batch_el = HUDDialogue.DialogueWithPortrait.new(
            name,
            content,
            Bootstrap.portraits.get_asset(portrait_id)
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


func add_item(id, type):
    Bootstrap.items.push_back({
        id = id,
        type = type,
    })


func remove_item(id):
    var to_remove = {}
    for value in Bootstrap.items:
        if value.id == id:
            to_remove = value
            break
    Bootstrap.items.erase(to_remove)