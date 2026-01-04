/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos.resource_manager

import ohos.labels.APILevel
public import ohos.raw_file_descriptor.RawFileDescriptor
public import ohos.resource.AppResource

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public class ResourceManager {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public func getConfiguration(): Configuration {
        return Configuration()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getStringArrayByName(resName: String): Array<String> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getPluralStringByName(resName: String, num: Int64): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getString(resId: UInt32, args: Array<ArgsValueType>): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getStringByName(resName: String, args: Array<ArgsValueType>): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getBoolean(resId: UInt32): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getBooleanByName(resName: String): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getNumber(resId: UInt32): NumberValueType {
        return NumberValueType.Int32Value(0)
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getNumberByName(resName: String): NumberValueType {
        return NumberValueType.Int32Value(0)
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getPluralStringValue(resId: UInt32, num: Int64): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getMediaContent(resId: UInt32, density!: ?ScreenDensity = None): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getRawFileContent(path: String): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getRawFd(path: String): RawFileDescriptor {
        return RawFileDescriptor()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func closeRawFd(path: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getRawFileList(path: String): Array<String> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getColor(resId: UInt32): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getColorByName(resName: String): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func addResource(path: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func removeResource(path: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getMediaContentBase64(resId: UInt32, density!: ?ScreenDensity = None): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getStringArrayValue(resId: UInt32): Array<String> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true, workerthread: true]
    public func getMediaByName(resName: String, density!: ?ScreenDensity = None): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager", throwexception: true]
    public func getMediaBase64ByName(resName: String, density!: ?ScreenDensity = None): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public func getDeviceCapability(): DeviceCapability {
        return DeviceCapability()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public func getLocales(includeSystem!: Bool = false): Array<String> {
        return Array()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public class Configuration {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var direction: Direction

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var locale: String

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var deviceType: DeviceType

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var screenDensity: ScreenDensity

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var colorMode: ColorMode

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var mcc: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var mnc: UInt32
    
    public init() {
        super()
        this.direction = Direction.DirectionVertical
        this.locale = String()
        this.deviceType = DeviceType.DeviceTypePhone
        this.screenDensity = ScreenDensity.ScreenSdpi
        this.colorMode = ColorMode.Dark
        this.mcc = 0
        this.mnc = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public class DeviceCapability {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var screenDensity: ScreenDensity

    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    public var deviceType: DeviceType
    
    public init() {
        super()
        this.screenDensity = ScreenDensity.ScreenSdpi
        this.deviceType = DeviceType.DeviceTypePhone
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public enum ColorMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    Dark
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    Light
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public enum ScreenDensity {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    ScreenSdpi
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    ScreenMdpi
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    ScreenLdpi
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    ScreenXldpi
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    ScreenXxldpi
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    ScreenXxxldpi
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public enum DeviceType {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceTypePhone
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceTypeTablet
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceTypeCar
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceTypePc
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceTypeTv
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceTypeWearable
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DeviceType2In1
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public enum Direction {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DirectionVertical
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
    DirectionHorizontal
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public enum NumberValueType {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"] Int32Value(Int32)
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"] Float32Value(Float32)
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"]
public enum ArgsValueType {
    @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"] Int32Value(Int32)
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"] Float32Value(Float32)
    | @!APILevel[since: "22", syscap: "SystemCapability.Global.ResourceManager"] StringValue(String)
    | ...
}

extend<T> Array<T> where T <: Comparable<T> {
    func find(c: T, index: Int64): Int64 {
        for (i in index..this.size) {
            if (this[i] == c) {
                return i
            }
        }
        return this.size - 1
    }
}
