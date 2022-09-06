package;

class Paths
{
	inline public static var SOUND_EXT = "ogg";

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function json(key:String)
	{
		return getPreloadPath('data/$key.json');
	}

	inline static public function inst(song:String)
	{
		return 'assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function voices(song:String)
	{
		return 'assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}
}
