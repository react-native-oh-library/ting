/*
 * Copyright (c) 2024 Huawei Device Co., Ltd. All rights reserved
 * Use of this source code is governed by a MIT license that can be
 * found in the LICENSE file.
 */

import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  toast(options: Object): void;
  alert(options: Object): void;
  dismissAlert(): void;
  setup(options: Object): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('Ting');
