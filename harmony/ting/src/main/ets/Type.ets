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

import { common2D } from '@kit.ArkGraphics2D';

export interface Icon {
  size?: number;
  uri?: string | number;
  tintColor?: string | common2D.Color;
}

export interface Options {
  alert?: AlertOptions;
  toast?: ToastOptions;
}

export interface ToastOptions {
  title?: string;
  message?: string;
  titleColor?: string;
  messageColor?: string;
  /**
   * Defaults to `done`.
   */
  preset?: 'done' | 'error' | 'none' | 'spinner';
  /**
   * Duration in seconds.
   */
  duration?: number;
  haptic?: 'success' | 'warning' | 'error' | 'none';
  /**
   * Defaults to `true`.
   */
  shouldDismissByDrag?: boolean;
  /**
   * Change the presentation side.
   * Defaults to `top`.
   */
  position?: 'top' | 'bottom';
  /**
   * backgroundColor for toastView
   * Defaults to `null`.
   */
  backgroundColor?: string;

  /**
   * custom icon
   *  Defaults to `null`.
   */
  icon?: Icon;

  /**
   * progress color for spinner preset
   * @platform android
   */
  progressColor?: string;
}

export interface AlertOptions {
  title?: string;
  message?: string;
  titleColor?: string;
  messageColor?: string;
  /**
   * Defaults to `done`.
   */
  preset?: 'done' | 'error' | 'none' | 'spinner';
  /**
   * Duration in seconds.
   * Defaults to 3.
   */
  duration?: number;
  /**
   * @platform ios
   */
  haptic?: 'success' | 'warning' | 'error' | 'none';
  /**
   * Defaults to `true`.
   */
  shouldDismissByTap?: boolean;
  /**
   * backgroundColor for alertView
   * Defaults to `null`.
   */
  backgroundColor?: string;
  /**
   * borderRadius for alertView
   * Defaults to `24`.
   */
  borderRadius?: number;
  /**
   *  blur for backdrop
   * @platform android
   */
  blurBackdrop?: number;
  /**
   * @platform android
   * 0 -> 1
   * Defaults to 0.
   */
  backdropOpacity?: number;
  /**
   * custom icon
   */
  icon?: Icon;

  /**
   * progress color for spinner preset
   * @platform android
   */
  progressColor?: string;
}
