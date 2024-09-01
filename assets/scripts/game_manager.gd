extends Node

var in_battle = false
var in_battle_with = ""
var pct_left = 100

func set_battling(name):
	in_battle = true
	in_battle_with = name
	pct_left = 100
	
func not_battling():
	in_battle = false
	in_battle_with = ""
	pct_left = 0
