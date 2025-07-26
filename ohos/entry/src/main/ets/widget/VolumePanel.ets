import { AVVolumePanel } from '@kit.AudioKit'
import { CustomView } from "./CustomView" //这里的CustomView是我们后面需要继承PlatformView的类
import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';

@Component
export struct VolumePanel {
  @State volume: number = 0;

  build() {
    Column() {
      Text('鸿蒙原生视图')
      AVVolumePanel({
        volumeLevel: this.volume,
        volumeParameter: {
          position: {
            x: 100,
            y: 200
          }
        }
      })
    }
  }
}