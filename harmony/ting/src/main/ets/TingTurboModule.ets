/**
 * MIT License
 *
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import { TurboModule } from '@rnoh/react-native-openharmony/ts';
import { TM } from "@rnoh/react-native-openharmony/generated/ts";
import { ComponentContent, PromptAction, promptAction, window } from '@kit.ArkUI';
import { ToastOptions, AlertOptions, Options } from './Type';
import { vibrator } from '@kit.SensorServiceKit';
import { common2D, drawing } from '@kit.ArkGraphics2D';

@Builder
function buildToast(toastOptions: ToastOptions) {
  Row() {
    if (!toastOptions.icon?.uri) {
      if (toastOptions.preset === 'spinner') {
        Progress({ value: 0, total: 100, type: ProgressType.Ring })
          .width('100px')
          .height('100px')
          .color(toastOptions.progressColor || '#008080')
          .style({ strokeWidth: 5, status: ProgressStatus.LOADING })
          .margin({ left: 7 })
      } else if (toastOptions.preset === 'error') {
        Path()
          .commands('M52.5 44.17 L81.67 15 L90 23.33 L60.83 52.5 L90 81.67 L81.67 90 L52.5 60.83 L23.33 90 ' +
            'L15 81.67 L44.17 52.5 L15 23.33 L23.33 15 L52.5 44.17 Z')
          .width('100px')
          .height('100px')
          .fill(Color.Red)
          .stroke(Color.Red)
          .margin({ left: 7 })
      } else if (toastOptions.preset === 'done') {
        Polyline()
          .width('100px')
          .height('100px')
          .points([[9.1787, 15.0323], [18.086, 23.9397], [34.847, 7.1787]])
          .fillOpacity(0)
          .stroke(Color.Green)
          .strokeWidth(4)
      } else if (toastOptions.preset === 'none') {
        // there is no component.
      } else {
        Polyline()
          .width('100px')
          .height('100px')
          .points([[9.1787, 15.0323], [18.086, 23.9397], [34.847, 7.1787]])
          .fillOpacity(0)
          .stroke(Color.Green)
          .strokeWidth(4)
      }
    } else {
      if (typeof toastOptions.icon?.uri === 'string') {
        if (!toastOptions.icon?.tintColor) {
          Image(toastOptions.icon.uri as string)
            .objectFit(ImageFit.Contain)
            .autoResize(true)
            .width(toastOptions.icon.size || '100px')
            .height(toastOptions.icon.size || '100px')
            .borderRadius(17.5)
            .margin({ left: 7 })
        } else {
          Image(toastOptions.icon?.uri as string)
            .objectFit(ImageFit.Contain)
            .autoResize(true)
            .width(toastOptions.icon.size || '100px')
            .height(toastOptions.icon.size || '100px')
            .colorFilter(drawing.ColorFilter.createBlendModeColorFilter(toastOptions.icon.tintColor as common2D.Color
              , drawing.BlendMode.SRC_IN))
            .borderRadius(17.5)
            .margin({ left: 7 })
        }
      }
    }

    Column() {
      Text(toastOptions.title || '')
        .fontSize(13)
        .fontColor(toastOptions.titleColor || '#000000')
        .alignSelf(ItemAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 5 })

      Text(toastOptions.message || '')
        .fontSize(12)
        .fontColor(toastOptions.messageColor || '#BEBEBE')
        .alignSelf(ItemAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .constraintSize({ minWidth: '0px', maxWidth: '830px' })
    .margin({
      right: 14,
      left: 14,
      top: 5,
      bottom: 5
    })
  }
  .height('auto')
  .width('auto')
  .borderRadius('50%')
  .backgroundColor(toastOptions.backgroundColor || '#FFFFFF')
  .padding(5)
}

@Builder
function buildAlert(alertOptions: AlertOptions) {
  Column() {
    if (!alertOptions.icon?.uri) {
      if (alertOptions.preset === 'spinner') {
        Progress({ value: 0, total: 100, type: ProgressType.Ring })
          .width('150px')
          .height('150px')
          .color(alertOptions.progressColor || '#008080')
          .alignSelf(ItemAlign.Center)
          .style({ strokeWidth: 5, status: ProgressStatus.LOADING })
          .margin({ top: 30 })
      } else if (alertOptions.preset === 'error') {
        Path()
          .commands('M 107 140 L 165.34 82.00 L 182.00 98.32 L 123.67 156.67 L 182.00 215.00 L 165.34 231.67 ' +
            'L 107.00 173.33 L 49.33 231.67 L 32 215.00 L 90.34 156.67 L 32 98.32 L 49.33 82.00 L 107.00 140.00 Z')
          .width('225px')
          .height('225px')
          .fill(Color.Red)
          .stroke(Color.Red)
          .margin({ top: 20 })
      } else if (alertOptions.preset === 'done') {
        Polyline()
          .width('225px')
          .height('225px')
          .points([[5.1995, 47.06425], [25.991, 67.1065], [62.95325, 29.39425]])
          .fillOpacity(0)
          .stroke(Color.Green)
          .strokeWidth(7)
          .margin({ top: 15 })
      } else if (alertOptions.preset === 'none') {
        Blank()
          .height('25px')
          .margin({ top: 15 })
      } else {
        Polyline()
          .width('225px')
          .height('225px')
          .points([[5.1995, 47.06425], [25.991, 67.1065], [62.95325, 29.39425]])
          .fillOpacity(0)
          .stroke(Color.Green)
          .strokeWidth(7)
          .margin({ top: 15 })
      }
    } else {
      if (typeof alertOptions.icon?.uri === 'string') {
        if (!alertOptions.icon.tintColor) {
          Image(alertOptions.icon.uri as string)
            .objectFit(ImageFit.Contain)
            .autoResize(true)
            .width(alertOptions.icon.size || '225px')
            .height(alertOptions.icon.size || '225px')
            .margin({ top: 20 })
        } else {
          Image(alertOptions.icon.uri as string)
            .objectFit(ImageFit.Contain)
            .autoResize(true)
            .width(alertOptions.icon.size || '225px')
            .height(alertOptions.icon.size || '225px')
            .colorFilter(drawing.ColorFilter.createBlendModeColorFilter(alertOptions.icon.tintColor as common2D.Color
              , drawing.BlendMode.SRC_IN))
            .margin({ top: 20 })
        }
      }
    }

    Column() {
      Text(alertOptions.title || '')
        .fontSize(16)
        .fontColor(alertOptions.titleColor || '#000000')
        .alignSelf(ItemAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 5 })

      Text(alertOptions.message || '')
        .fontSize(14)
        .fontColor(alertOptions.messageColor || '#BEBEBE')
        .alignSelf(ItemAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .constraintSize({ minWidth: '0px', maxWidth: '830px' })
    .margin({
      right: 18,
      left: 18,
      top: 25,
      bottom: 30
    })
  }
  .constraintSize({
    minWidth: '550px',
    maxWidth: Infinity,
    minHeight: '200px',
    maxHeight: Infinity
  })
  .backgroundColor(alertOptions.backgroundColor || '#FFFFFF')
  .borderRadius(alertOptions.borderRadius || '24');
}

export class TingTurboModule extends TurboModule implements TM.Ting.Spec {
  private alertPromptAction: PromptAction | null = null;
  private alertComponentContent: ComponentContent<object> | null = null;
  private timeoutId: number | null = null;
  private isCancelled: boolean = false;
  private toastOptionInit: ToastOptions | undefined = undefined;
  private alertOptionInit: AlertOptions | undefined = undefined;
  private PREFIX = "asset://";
  private RAWFILE_PREFIX = "resource://RAWFILE/assets/";

  async showToast(toastOptions: ToastOptions) {
    if (this.toastOptionInit) {
      toastOptions = this.mergeToastOptions(this.toastOptionInit, toastOptions);
    }

    const windowValue = await window.getLastWindow(this.ctx.uiAbilityContext);
    const uiContext = windowValue?.getUIContext();
    const promptAction = uiContext?.getPromptAction();

    let option: promptAction.BaseDialogOptions = {
      alignment: DialogAlignment.Top,
      autoCancel: true,
      offset: { dx: 0, dy: 50 },
      isModal: true,
      maskColor: '#00FF0000',
      transition: TransitionEffect.asymmetric(TransitionEffect.move(TransitionEdge.TOP)
        .animation({ curve: Curve.Sharp }),
        TransitionEffect.move(TransitionEdge.TOP).animation({ curve: Curve.Sharp })),
    };

    if (toastOptions.position === "bottom") {
      option.alignment = DialogAlignment.Bottom;
      option.offset = { dx: 0, dy: -50 };
      option.transition = TransitionEffect.asymmetric(TransitionEffect.move(TransitionEdge.BOTTOM)
        .animation({ curve: Curve.Sharp }),
        TransitionEffect.move(TransitionEdge.BOTTOM).animation({ curve: Curve.Sharp }));
    }

    if (toastOptions.shouldDismissByDrag === false) {
      option.autoCancel = false;
    }

    if (toastOptions.duration && toastOptions.duration !== 3000) {
      toastOptions.duration = toastOptions.duration * 1000;
      if (toastOptions.duration > 0 && toastOptions.duration <= 1000) {
        toastOptions.duration += 500;
      }
    }

    if (toastOptions.haptic) {
      option.onDidAppear = () => this.vibrator(toastOptions.haptic as string);
    }

    const contentNode = new ComponentContent(uiContext!, wrapBuilder(buildToast), toastOptions);

    try {
      promptAction?.openCustomDialog(contentNode, option);

      setTimeout(() => {
        promptAction?.closeCustomDialog(contentNode);
      }, toastOptions.duration || 3000);
    } catch (error) {
      throw new Error('Can\'t open CustomDialog: ' + error);
    }
  }

  async showAlert(alertOptions: AlertOptions) {
    if (this.alertOptionInit) {
      alertOptions = this.mergeAlertOptions(this.alertOptionInit, alertOptions);
    }

    const windowValue = await window.getLastWindow(this.ctx.uiAbilityContext);
    const uiContext = windowValue?.getUIContext();
    this.alertPromptAction = uiContext?.getPromptAction();

    let option: promptAction.BaseDialogOptions = {
      alignment: DialogAlignment.Center,
      autoCancel: true,
      isModal: true,
      maskColor: '#00FF0000'
    };

    if (alertOptions.shouldDismissByTap === false) {
      option.autoCancel = false;
    }

    if (alertOptions.backdropOpacity && alertOptions.backdropOpacity >= 1) {
      option.maskColor = '#000000';
    }

    if (alertOptions.duration && alertOptions.duration !== 3000) {
      alertOptions.duration = alertOptions.duration * 1000;
    }

    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
      this.isCancelled = true; // 标记为取消状态
    }

    this.isCancelled = false;

    if (alertOptions.haptic) {
      option.onDidAppear = () => this.vibrator(alertOptions.haptic as string);
    }

    this.alertComponentContent = new ComponentContent(uiContext!, wrapBuilder(buildAlert), alertOptions);

    try {
      this.alertPromptAction?.openCustomDialog(this.alertComponentContent, option);

      this.timeoutId = setTimeout(async () => {
        await this.alertPromptAction?.closeCustomDialog(this.alertComponentContent);
      }, alertOptions.duration || 3000);

    } catch (error) {
      throw new Error('Can\'t open CustomDialog: ' + error);
    }
  }

  toast(options: Object): void {
    if (options && typeof options === 'object') {
      const toastOptions = options as ToastOptions;

      if (toastOptions.icon?.tintColor) {
        toastOptions.icon.tintColor = this.hexToRGBA(toastOptions.icon?.tintColor as string);
      }

      if (toastOptions.icon?.uri) {
        toastOptions.icon!.uri = this.modifyPathIfNeeded(toastOptions.icon?.uri as string);
      }

      this.showToast(toastOptions);
    }
  }

  alert(options: Object): void {
    if (options && typeof options === 'object') {
      const alertOptions = options as AlertOptions;

      if (alertOptions.icon?.tintColor) {
        alertOptions.icon.tintColor = this.hexToRGBA(alertOptions.icon?.tintColor as string);
      }

      if (alertOptions.icon?.uri) {
        alertOptions.icon!.uri = this.modifyPathIfNeeded(alertOptions.icon?.uri as string);
      }

      this.showAlert(alertOptions);
    }
  }

  dismissAlert(): void {
    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
      this.timeoutId = null;
      this.isCancelled = true;

      if (this.alertPromptAction && this.alertComponentContent) {
        this.alertPromptAction.closeCustomDialog(this.alertComponentContent);
      }
    }
  }

  setup(options: Object): void {
    const opts = options as Options;
    this.alertOptionInit = opts.alert;
    this.toastOptionInit = opts.toast;
  }

  mergeToastOptions(mapInit: ToastOptions, map: ToastOptions): ToastOptions {
    if (mapInit) {
      map.title = map.title !== undefined ? map.title : mapInit.title;
      map.message = map.message !== undefined ? map.message : mapInit.message;
      map.titleColor = map.titleColor !== undefined ? map.titleColor : mapInit.titleColor;
      map.messageColor = map.messageColor !== undefined ? map.messageColor : mapInit.messageColor;
      map.preset = map.preset !== undefined ? map.preset : mapInit.preset;
      map.duration = map.duration !== undefined ? map.duration : mapInit.duration;
      map.haptic = map.haptic !== undefined ? map.haptic : mapInit.haptic;
      map.shouldDismissByDrag =
        map.shouldDismissByDrag !== undefined ? map.shouldDismissByDrag : mapInit.shouldDismissByDrag;
      map.position = map.position !== undefined ? map.position : mapInit.position;
      map.backgroundColor = map.backgroundColor !== undefined ? map.backgroundColor : mapInit.backgroundColor;
      map.icon = map.icon !== undefined ? map.icon : mapInit.icon;
      map.progressColor = map.progressColor !== undefined ? map.progressColor : mapInit.progressColor;
    }

    return map;
  }

  mergeAlertOptions(mapInit: AlertOptions, map: AlertOptions): AlertOptions {
    if (mapInit) {
      map.title = map.title !== undefined ? map.title : mapInit.title;
      map.message = map.message !== undefined ? map.message : mapInit.message;
      map.titleColor = map.titleColor !== undefined ? map.titleColor : mapInit.titleColor;
      map.messageColor = map.messageColor !== undefined ? map.messageColor : mapInit.messageColor;
      map.preset = map.preset !== undefined ? map.preset : mapInit.preset;
      map.duration = map.duration !== undefined ? map.duration : mapInit.duration;
      map.haptic = map.haptic !== undefined ? map.haptic : mapInit.haptic;
      map.shouldDismissByTap =
        map.shouldDismissByTap !== undefined ? map.shouldDismissByTap : mapInit.shouldDismissByTap;
      map.backgroundColor = map.backgroundColor !== undefined ? map.backgroundColor : mapInit.backgroundColor;
      map.borderRadius = map.borderRadius !== undefined ? map.borderRadius : mapInit.borderRadius;
      map.blurBackdrop = map.blurBackdrop !== undefined ? map.blurBackdrop : mapInit.blurBackdrop;
      map.backdropOpacity = map.backdropOpacity !== undefined ? map.backdropOpacity : mapInit.backdropOpacity;
      map.icon = map.icon !== undefined ? map.icon : mapInit.icon;
      map.progressColor = map.progressColor !== undefined ? map.progressColor : mapInit.progressColor;
    }

    return map;
  }

  vibrator(haptic: string) {
    if (haptic === 'success') {
      vibrator.startVibration({
        type: 'preset',
        effectId: 'haptic.clock.timer',
        count: 1,
        intensity: 30
      }, {
        id: 0,
        usage: 'alarm'
      })
    } else if (haptic === 'warning') {
      vibrator.startVibration({
        type: 'preset',
        effectId: 'haptic.clock.timer',
        count: 1,
        intensity: 30
      }, {
        id: 0,
        usage: 'alarm'
      })
    } else if (haptic === 'error') {
      vibrator.startVibration({
        type: 'preset',
        effectId: 'haptic.clock.timer',
        count: 7,
        intensity: 30
      }, {
        id: 0,
        usage: 'alarm'
      })
    } else {
      return;
    }
  }

  hexToRGBA(hex: string): common2D.Color {
    hex = hex.replace(/^#/, '');

    if (hex.length === 3) {
      hex = hex.split('').map(char => char + char).join('');
    }

    if (hex.length === 6) {
      const red = parseInt(hex.substring(0, 2), 16);
      const green = parseInt(hex.substring(2, 4), 16);
      const blue = parseInt(hex.substring(4, 6), 16);
      return {
        alpha: 255,
        red,
        green,
        blue
      };
    }

    if (hex.length === 8) {
      const alpha = parseInt(hex.substring(0, 2), 16);
      const red = parseInt(hex.substring(2, 4), 16);
      const green = parseInt(hex.substring(4, 6), 16);
      const blue = parseInt(hex.substring(6, 8), 16);
      return {
        alpha,
        red,
        green,
        blue
      };
    }

    throw new Error('Invalid hex color');
  }

  modifyPathIfNeeded(path: string): string {
    if (path.startsWith(this.PREFIX)) {
      return this.RAWFILE_PREFIX + path.slice(this.PREFIX.length);
    }
    return path;
  }
}
