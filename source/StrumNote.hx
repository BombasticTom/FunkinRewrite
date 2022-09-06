package;

import flixel.FlxSprite;

class StrumNote extends FlxSprite
{
	private var player:Int;
	private var noteData:Int;

	public function new(x:Float, y:Float, noteData:Int, player:Int)
	{
		this.player = player;
		this.noteData = noteData;

		super(x, y);
		makeGraphic(100, 100, 0xFF00FF00);
	}
}
