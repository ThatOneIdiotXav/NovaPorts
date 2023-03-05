function onCreatePost() {
	startTimer.active = false;
	FlxG.sound.music.pause();
	vocals.pause();
  
	FlxG.sound.music.time = vocals.time = Conductor.songPosition = 0;
  
	FlxG.sound.music.play();
	vocals.play();
  }