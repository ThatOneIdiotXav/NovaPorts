import game.cutscenes.VideoSprite;
import openfl.display.BlendMode;

var lg:FNFSprite;
var bgVid:VideoSprite;
var weGone:Bool = false;

function onCreate() {
	runDefaultCode = false;

	CoolUtil.playMusic(Paths.music('smileyTitle'));
	FlxG.camera.flash(0xFFFFFFFF, 4);

	bgVid = new VideoSprite();
	bgVid.play(Paths.video('titleKickBG'), true);
	add(bgVid);
	bgVid.bitmap.skippable = false;

	add(lg = new FNFSprite().loadGraphic(Paths.image('game/ui/title/logo')));
	lg.blend = BlendMode.LIGHTEN;
	lg.y -= (FlxG.height / 16) + 5;
}

function onUpdate(_) {
	if (controls.ACCEPT && !weGone) {
		weGone = true;
		FlxG.camera.flash(0xFFFFFFFF, 1);
		CoolUtil.playMenuSFX(1);

		new FlxTimer().start(2, function(tmr:FlxTimer) {
			FlxG.switchState(new states.menus.MainMenuState());
		});
	}
}
