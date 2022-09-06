package;

import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

using StringTools;

typedef SectionMetaData =
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var typeOfSection:Int;
	var mustHitSection:Bool;
	var bpm:Int;
	var changeBPM:Bool;
	var altAnim:Bool;
}

typedef SongMetaData =
{
	var song:String;
	var notes:Array<SectionMetaData>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var validScore:Bool;
}

class SongData
{
	public static function loadFromJson(jsonInput:String, ?folder:String):SongMetaData
	{
		var rawJson = Assets.getText(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase())).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}

		return parseJsonData(rawJson);
	}

	public static function parseJsonData(rawJson:String):SongMetaData
	{
		var swagShit:SongMetaData = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
