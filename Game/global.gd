extends Node

var current_state

enum GameState {
	MENU,
	SETTINGS,
	LEVEL,
	CREDIT,
	LEVELMENU
} 

var levels_completed = []
var current_level = 1
