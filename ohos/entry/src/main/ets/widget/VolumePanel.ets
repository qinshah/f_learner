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
              .getPromptAction()
              .openCustomDialog({
                builder: () => {
                  AVVolumePanel({
                    volumeLevel: 1
                  })
                },
                isModal: true,
                showInSubWindow: false,
                maskColor: Color.Pink,
                maskRect: {
                  x: 20,
                  y: 20,
                  width: '90%',
                  height: '90%'
                },

                dialogTransition: // 设置弹窗内容显示的过渡效果
                TransitionEffect.translate({ x: 0, y: 290, z: 0 })
                  .animation({ duration: 4000, curve: Curve.Smooth }), // 四秒钟的偏移渐变动画

                maskTransition: // 设置蒙层显示的过渡效果
                TransitionEffect.opacity(0)
                  .animation({ duration: 4000, curve: Curve.Smooth }) // 四秒钟的透明渐变动画

              })
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
