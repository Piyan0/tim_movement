class_name AudioManager
extends Node

var _bgm_player: AudioStreamPlayer
var _sfx_player: AudioStreamPlayer
var bgm_fade_dur = 0.5
var _current_bgm = null

func _ready():
    _bgm_player = AudioStreamPlayer.new()
    _sfx_player = AudioStreamPlayer.new()
    _bgm_player.name = "BGM Player"
    _sfx_player.name = "SFX Player"
    # _bgm_player.playback_type = AudioServer.PLAYBACK_TYPE_SAMPLE
    # _sfx_player.playback_type = AudioServer.PLAYBACK_TYPE_SAMPLE
    add_child(_bgm_player)
    add_child(_sfx_player)


func play_sfx(sfx, custom_db = 0):
    _sfx_player.volume_db = custom_db
    _sfx_player.stream = sfx
    _sfx_player.play()

func play_bgm(bgm: AudioStream, custom_db = 0):
    if _current_bgm != null:
        var t = create_tween()
        t.tween_property(_bgm_player, "volume_db", -18, bgm_fade_dur)
        await t.finished
        _bgm_player.stream = bgm
        # t.tween_property(_bgm_player, "volume_db", custom_db, bgm_fade_dur)
    else:
        _bgm_player.stream = bgm
    
    _bgm_player.volume_db = custom_db
    _current_bgm = bgm
    _bgm_player.play()
    #print(bgm, _bgm_player.playing)
