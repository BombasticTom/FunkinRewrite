package;

import flixel.FlxState;

class MusicBeatState extends FlxState
{
	var curStep:Int = 0;
	var lastStep:Int = 0;

	var curBeat:Int = 0;

	override function create()
	{
		super.create();
	};

	private function updateStep():Void
	{
		curStep = Math.floor(Conductor.songPosition / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
		{
			beatHit();
		}
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	public function beatHit():Void {}

	override public function update(elapsed:Float)
	{
		lastStep = curStep;

		updateStep();
		updateBeat();

		if (curStep > lastStep) {}

		super.update(elapsed);
	}
}
