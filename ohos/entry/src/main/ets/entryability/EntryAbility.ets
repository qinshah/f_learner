import { FlutterAbility, FlutterEngine } from '@ohos/flutter_ohos';
import { GeneratedPluginRegistrant } from '../plugins/GeneratedPluginRegistrant';
import { CustomPlugin } from '../widget/CustomPlugin';
import HarmonyChannel from '../plugins/HarmonyChannel';

export default class EntryAbility extends FlutterAbility {
  configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    GeneratedPluginRegistrant.registerWith(flutterEngine)
    this.addPlugin(new CustomPlugin());
    flutterEngine.getPlugins()?.add(new HarmonyChannel());
  }
}
