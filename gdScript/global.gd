extends Node

var score = 0
var path = ""
var background = ""
var score_protect_the_cilok: int = 0
var UI :bool = true
var MainControl : bool = true
var GameControl : bool = false

func _ready() -> void:
	if OS.has_feature("JavaScript"):
		var ua = JavaScriptBridge.eval("navigator.userAgent;", true)
		if ua != null:
			ua = ua.to_lower()
			if "android" in ua or "iphone" in ua or "ipad" in ua:
				UI = false
			else:
				UI = true
