extends MarginContainer

@export var _player_label: Label
@export var _instructions_label: Label
@export var _game_state: GameState

func _ready():
    GameEvents.play_state_changed.connect(_update_text)

func _update_text():
    _player_label.text = "Player " + str(_game_state.current_player_id + 1)
    

    var new_instructions = ""

    match _game_state.current_play_state:
        Enums.PlayState.AIMING:
            new_instructions = "Aim and shoot"
        

    _instructions_label.text = new_instructions