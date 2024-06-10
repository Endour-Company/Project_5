extends Control

# Define onready variables
@onready var tutorialText : RichTextLabel = $Text
@onready var SFX : AudioStreamPlayer = $SFX

# Declare custom signals
signal close_signal

# Define bookmark order
var bookmarkOrder : Dictionary = {
	"BookmarkPusat"			: 3,
	"BookmarkPemukiman"		: 4,
	"BookmarkSawah"			: 5,
	"BookmarkHutan"			: 6,
	"BookmarkAspek"			: 7,
	"BookmarkCara"			: 8,
}

var selectedBookmarkIndex : int = 11 # The index where the selected index will be located


func _ready():
	# Set default tutorial text
	update_tutorial_text()
	
	# Set SFX volume
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Play tutorial open SFX
	GameAudio.play(SFX, GameAudio.SFX_Tutorial_Open)


# Function to swap bookmarks
func select_bookmark(newBookmarkName: String):
	# Play tutorial click SFX
	GameAudio.play(SFX, GameAudio.SFX_Tutorial_Click)
	
	# Get previously selected bookmark
	var prevBookmark : TextureButton = get_child(selectedBookmarkIndex)
	
	# Move previously selected bookmark back to the correct order
	move_child(prevBookmark, bookmarkOrder[prevBookmark.name])
	
	# Set previous bookmark default cursor to pointing hand and enable it
	prevBookmark.set_default_cursor_shape(CURSOR_POINTING_HAND)
	prevBookmark.set_disabled(false)
	
	# Get new selected bookmark based on the order
	var newBookmark : TextureButton = get_child(bookmarkOrder[newBookmarkName])
	
	# Move newBookmark to the selectedBookmarkIndex
	move_child(newBookmark, selectedBookmarkIndex)
	
	# Set new bookmark default cursor to arrow and disable it
	newBookmark.set_default_cursor_shape(CURSOR_ARROW)
	newBookmark.set_disabled(true)
	
	# Set tutorial text
	update_tutorial_text()


# Method to update tutorial text
func update_tutorial_text():
	# Get currently selected bookmark
	var curBookmark : TextureButton = get_child(selectedBookmarkIndex)
	
	# Define tutorial path
	var path : String = "res://Global/Game_UI/Tutorial/Lib/" + curBookmark.name + ".txt"
	
	# Read tutorial content
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	var content : String = file.get_as_text()
	
	# Set tutorial content
	tutorialText.set_text(content)
	


func _on_bookmark_cara_pressed():
	select_bookmark("BookmarkCara")


func _on_bookmark_aspek_pressed():
	select_bookmark("BookmarkAspek")


func _on_bookmark_hutan_pressed():
	select_bookmark("BookmarkHutan")


func _on_bookmark_sawah_pressed():
	select_bookmark("BookmarkSawah")


func _on_bookmark_pemukiman_pressed():
	select_bookmark("BookmarkPemukiman")


func _on_bookmark_pusat_pressed():
	select_bookmark("BookmarkPusat")


func _on_close_button_pressed():
	close_signal.emit()
