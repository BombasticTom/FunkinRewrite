package;

import SongData.SongMetaData;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends MusicBeatState
{
	public static var SONG:SongMetaData;

	public var startingSong:Bool = false;
	public var vocals:FlxSound;

	var startedCountdown:Bool = false;

	override public function create()
	{
		generateSong('blammed');

		startingSong = true;

		startCountdown();
		super.create();
	}

	private function generateSong(song:String):Void
	{
		SONG = SongData.loadFromJson(song, song);
		Conductor.changeBPM(SONG.bpm);

		if (SONG.needsVoices)
		{
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		}
		else
		{
			vocals = new FlxSound();
		}
	}

	private function generateStaticArrows(player:Int):Void
	{
		var seperation:Float = (player == 1) ? FlxG.width / 4 : -FlxG.width / 4;
		var xPosition:Float = FlxG.width / 2 + seperation;
		var swagWidth:Float = 0.7 * 160;

		for (i in 0...4)
		{
			var babyArrow:StrumNote = new StrumNote(xPosition - swagWidth / 2 + (i - (4 - 1) / 2) * swagWidth, 50, i, player);
			add(babyArrow);
		}
	}

	function startCountdown():Void
	{
		generateStaticArrows(0);
		generateStaticArrows(1);

		startedCountdown = true;
		Conductor.songPosition = -Conductor.crochet * 5;
	}

	function startSong():Void
	{
		startingSong = false;

		FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		vocals.play();
	}

	function resyncVocals():Void
	{
		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		if (Conductor.songPosition <= vocals.length)
		{
			vocals.time = Conductor.songPosition;
		}
		vocals.play();
	}

	override public function stepHit()
	{
		super.stepHit();

		if (Math.abs(FlxG.sound.music.time - (Conductor.songPosition)) > 20
			|| (SONG.needsVoices && Math.abs(vocals.time - (Conductor.songPosition)) > 20))
		{
			resyncVocals();
		}
	}

	override public function update(elapsed:Float)
	{
		Conductor.songPosition += elapsed * 1000;

		if (startingSong && Conductor.songPosition >= 0)
		{
			startSong();
		}

		super.update(elapsed);
	}
}
