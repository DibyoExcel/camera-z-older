package;

import flixel.FlxCamera;
import flixel.FlxG;
class CameraZOrder {
    public static function moveBehind(camera:FlxCamera, targetCamera:FlxCamera):Void {
        if (camera == null || targetCamera == null || FlxG.cameras.list.indexOf(camera) == -1 || FlxG.cameras.list.indexOf(targetCamera) == -1) return;
        FlxG.game.removeChild(camera.flashSprite);
        FlxG.cameras.list.remove(camera);
        var targetIndex:Int = FlxG.game.getChildIndex(targetCamera.flashSprite);
		var targetList = FlxG.cameras.list.indexOf(targetCamera);
        FlxG.game.addChildAt(camera.flashSprite, targetIndex);
        FlxG.cameras.list.insert(targetList, camera);
        reloadIDs();
    }

    public static function moveVeryTop(camera:FlxCamera):Void {
        if (camera == null || FlxG.cameras.list.indexOf(camera) == -1) return;
        FlxG.game.removeChild(camera.flashSprite);
        FlxG.cameras.list.remove(camera);
        FlxG.game.addChildAt(camera.flashSprite, @:privateAccess FlxG.game.getChildIndex(FlxG.game._inputContainer));
        FlxG.cameras.list.push(camera);
        reloadIDs();
    }

    public static function moveVeryBehind(camera:FlxCamera):Void {
        if (camera == null || FlxG.cameras.list.indexOf(camera) == -1) return;
        var childIdx = -1;
        for (cam in FlxG.cameras.list) {
            if (cam != null) {
                childIdx = FlxG.game.getChildIndex(cam.flashSprite);
                break;
            }
        }
        //sorry kinda bit redundant but is worked i guess
        //get lowest index from all cam in list
        for (cam in FlxG.cameras.list) {
            if (cam != null) {
                if (childIdx > FlxG.game.getChildIndex(cam.flashSprite) && FlxG.game.getChildIndex(cam.flashSprite) > -1) {
                    childIdx = FlxG.game.getChildIndex(cam.flashSprite);
                }
            }
        }
        if (childIdx > -1) {
            FlxG.game.removeChild(camera.flashSprite);
            FlxG.cameras.list.remove(camera);
            FlxG.cameras.list.insert(0, camera);
            FlxG.game.addChildAt(camera.flashSprite, childIdx);
            reloadIDs();    
        }
    }

    public static function reorderCamera(cameraList:Array<FlxCamera>):Void {
        var camList = FlxG.cameras.list;
        for (camera in camList) {
            if (camera == null || cameraList.indexOf(camera) == -1) continue;
            FlxG.game.removeChild(camera.flashSprite);
            FlxG.cameras.list.remove(camera);
        }
        for (camera in cameraList) {
            if (camera == null || camList.indexOf(camera) == -1) continue;
            FlxG.game.addChildAt(camera.flashSprite, @:privateAccess FlxG.game.getChildIndex(FlxG.game._inputContainer));
            FlxG.cameras.list.push(camera);
        }
        reloadIDs();
    }

    static function reloadIDs():Void {
        for (i in 0...FlxG.cameras.list.length) {
            if (FlxG.cameras.list[i] != null) {
                FlxG.cameras.list[i].ID = i;
            }
        }
    }
}