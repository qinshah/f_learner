import { CustomView } from "./CustomView" //这里的CustomView是我们后面需要继承PlatformView的类
import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';
import { AVVolumePanel } from "@kit.AudioKit";

@Component
export struct VolumePanel {
  build() {
    Row() {
      Column() {
        Text('鸿蒙原生视图')
        Button('音量+10%', { type: ButtonType.Capsule, stateEffect: true })
          .onClick(() => {
            // 调用系统API增加音量10%
            // 需要导入系统音量控制模块
          })
        Button('音量-10%', { type: ButtonType.Capsule, stateEffect: true })
          .onClick(() => {
            // 调用系统API减少音量10%
            // 需要导入系统音量控制模块
          })
        Button('弹窗', { type: ButtonType.Capsule, stateEffect: true })
          .onClick(() => {
            this.getUIContext()
          })
        AVVolumePanel({
          volumeLevel: 1
        })
      }

    }

    .width
    ('50%'
    ).height
    ('50%'
    )
  }
}
