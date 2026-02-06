extends Node2D

@export var tilesScene: PackedScene 
var tiles:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tiles = tilesScene.instantiate()
	Global.tiles = tiles
	add_child(tiles)


func reset() -> void:
	remove_child(tiles)
	tiles = tilesScene.instantiate()
	Global.tiles = tiles
	add_child(tiles)
	$EndGameLabel.text = ""
