extends Control

# Define onready variables
@onready var tutorialText : RichTextLabel = $Text

# Declare custom signals
signal exit_signal

# Define bookmark order
var bookmarkOrder : Dictionary = {
	"BookmarkPusat"			: 2,
	"BookmarkPemukiman"		: 3,
	"BookmarkSawah"			: 4,
	"BookmarkHutan"			: 5,
	"BookmarkAspek"			: 6,
	"BookmarkCara"			: 7,
}

# Define tutorial texts
var tutorialTexts : Array = [
	"[p][center][b]Pusat Desa[/b][/center][/p]",
	"[p][center][b]Pemukiman[/b][/center][/p]",
	"[p][center][b]Sawah[/b][/center][/p]",
	"[p][center][b]Hutan[/b][/center][/p]",
	"[p][center][b]Aspek Permainan[/b][/center][/p]",
	"[p][center][b]Cara Bermain[/b][/center][/p][p]Main yang bener ya[/p]",
]

var selectedBookmarkIndex : int = 10 # The index where the selected index will be located


func _ready():
	# Set default tutorial text
	tutorialText.text = tutorialTexts[bookmarkOrder["BookmarkCara"]-2]


# Function to swap bookmarks
func select_bookmark(newBookmarkName: String):
	# Get previously selected bookmark
	var prevBookmark : TextureButton = get_child(selectedBookmarkIndex)
	
	# Move previously selected bookmark back to the correct order
	move_child(prevBookmark, bookmarkOrder[prevBookmark.name])
	
	# Set previous bookmark default cursor to pointing hand and enable it
	prevBookmark.mouse_default_cursor_shape = CURSOR_POINTING_HAND
	prevBookmark.disabled = false
	
	# Get new selected bookmark based on the order
	var newBookmark : TextureButton = get_child(bookmarkOrder[newBookmarkName])
	
	# Move newBookmark to the selectedBookmarkIndex
	move_child(newBookmark, selectedBookmarkIndex)
	
	# Set new bookmark default cursor to arrow and disable it
	newBookmark.mouse_default_cursor_shape = CURSOR_ARROW
	newBookmark.disabled = true
	
	# Set tutorial text
	tutorialText.text = tutorialTexts[bookmarkOrder[newBookmarkName]-2]


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
	exit_signal.emit()
