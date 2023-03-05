var ng:Bool = SettingsAPI.get(mod + ":FPSNoteGlow");
var ngL:Bool = SettingsAPI.get(mod + ":FPSNoteGlowLerp");
var ngV:Float = SettingsAPI.get(mod + ":FPSNoteGlowIntensity");

function onUpdatePost() {
	notes.forEach(function(note:Note) {
		if (ng && note.canBeHit) {
			note.colorTransform.redOffset = ngL ? FlxMath.lerp(note.colorTransform.redOffset, ngV, (FlxG.elapsed * 60) * 0.25) : ngV;
			note.colorTransform.greenOffset = ngL ? FlxMath.lerp(note.colorTransform.greenOffset, ngV, (FlxG.elapsed * 60) * 0.25) : ngV;
			note.colorTransform.blueOffset = ngL ? FlxMath.lerp(note.colorTransform.blueOffset, ngV, (FlxG.elapsed * 60) * 0.25) : ngV;
		}
	});
}
