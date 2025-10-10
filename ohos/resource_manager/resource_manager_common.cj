/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.resource_manager

import ohos.labels.APILevel
import std.deriving.Derive
import ohos.hilog.HilogChannel
import ohos.business_exception.BusinessException

type StageContext = CPointer<Unit>
const ESCAPE_CHARACTER: Rune = r'%'
const RAWFILE_TYPE: Int32 = 30000
const HAR_TYPE = "har"
const DEFAULT_HAR_BUNDLE_NAME = "__harDefaultBundleName__"
const DEFAULT_HAR_MODULE_NAME = "__harDefaultModuleName__"
let RES_LOG = HilogChannel(0, 0xD001E00, "CJ-ResourceManager")

/**
 * Provides the device configuration.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public class Configuration {
    /**
     * Indicates the screen direction of the current device.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var direction: Direction
    /**
     * Indicates the current system language, for example, zh-Hans-CN.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var locale: String

    /**
     * Indicates the device type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var deviceType: DeviceType
    /**
     * Indicates the screen density.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var screenDensity: ScreenDensity
    /**
     * Indicates the color mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var colorMode: ColorMode
    /**
     * Indicates the mcc.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var mcc: UInt32
    /**
     * Indicates the mnc.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public var mnc: UInt32

    /**
     * Configuration constructor.
     */
    init(
        direction: Direction,
        locale: String,
        deviceType: DeviceType,
        screenDensity: ScreenDensity,
        colorMode: ColorMode,
        mcc: UInt32,
        mnc: UInt32
    ) {
        this.direction = direction
        this.locale = locale
        this.deviceType = deviceType
        this.screenDensity = screenDensity
        this.colorMode = colorMode
        this.mcc = mcc
        this.mnc = mnc
    }
}

/**
 * Provides the device capability.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public class DeviceCapability {
    /**
     * Indicates the screen density of the current device.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let screenDensity: ScreenDensity
    /**
     * Indicates the type of the current device.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public let deviceType: DeviceType

    /**
     * DeviceCapability constructor.
     */
    init(screenDensity: ScreenDensity, deviceType: DeviceType) {
        this.screenDensity = screenDensity
        this.deviceType = deviceType
    }
}

/**
 * Enumerates color mode types.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public enum ColorMode {
    /**
     * Indicates dark mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    Dark
    /**
     * Indicates light mode.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    Light
    | ...

    static func parse(val: Int32): ColorMode {
        match (val) {
            case 0 => Dark
            case 1 => Light
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates screen density types.
 *
 * export enum ScreenDensity
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public enum ScreenDensity {
    /**
     * Indicates small screen density.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    ScreenSdpi
    /**
     * Indicates medium screen density.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    ScreenMdpi
    /**
     * Indicates large screen density.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    ScreenLdpi
    /**
     * Indicates extra-large screen density.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    ScreenXldpi
    /**
     * Indicates extra-extra-large screen density.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    ScreenXxldpi
    /**
     * Indicates extra-extra-extra-large screen density.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    ScreenXxxldpi
    | ...

    /**
     * Gets the corresponding mapping value.
     */
    func getValue(): UInt32 {
        match (this) {
            case ScreenSdpi => 120
            case ScreenMdpi => 160
            case ScreenLdpi=> 240
            case ScreenXldpi=> 320
            case ScreenXxldpi => 480
            case ScreenXxxldpi => 640
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    /**
     * Parses ScreenDensity from the corresponding mapping value.
     */
    static func parse(val: Int32): ScreenDensity {
        match (val) {
            case 120 => ScreenSdpi
            case 160 => ScreenMdpi
            case 240 => ScreenLdpi
            case 320 => ScreenXldpi
            case 480 => ScreenXxldpi
            case 640 => ScreenXxxldpi
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates device types.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public enum DeviceType {
    /**
     * Indicates a phone.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceTypePhone
    /**
     * Indicates a tablet.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceTypeTablet
    /**
     * Indicates a car.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceTypeCar
    /**
     * Indicates a PC.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceTypePc
    /**
     * Indicates a smart TV.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceTypeTv
    /**
     * Indicates a wearable device.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceTypeWearable
    /**
     * Indicates a 2in1 device.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DeviceType2In1
    | ...

    /**
     * Parses DeviceType from the corresponding mapping value.
     */
    static func parse(val: Int32): DeviceType {
        match (val) {
            case 0 => DeviceTypePhone
            case 1 => DeviceTypeTablet
            case 2 => DeviceTypeCar
            case 3 => DeviceTypePc
            case 4 => DeviceTypeTv
            case 6 => DeviceTypeWearable
            case 7 => DeviceType2In1
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates screen directions.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public enum Direction {
    /**
     * Enumerates screen directions.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DirectionVertical
    /**
     * Indicates the horizontal direction.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    DirectionHorizontal
    | ...

    /**
     * Parses Direction from the corresponding mapping value.
     */
    static func parse(val: Int32): Direction {
        match (val) {
            case 0 => DirectionVertical
            case 1 => DirectionHorizontal
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * for some API returns two type : Int32 Float32
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public enum NumberValueType {
    /**
     * Represents Int32.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    Int32Value(Int32)
    /**
     * Represents Float32.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    Float32Value(Float32)
    | ...
}

/**
 * For the formatting parameter using.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public enum ArgsValueType {
    /**
     * Formats %d.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    Int32Value(Int32)
    /**
     * Formats %f.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    Float32Value(Float32)
    /**
     * Formats %s.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    StringValue(String)
    | ...

    func shouldFormat(r: Rune): Bool {
        let l: Rune = match (this) {
            case Int32Value(_) => r'd'
            case Float32Value(_) => r'f'
            case StringValue(_) => r's'
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
        return l == r
    }

    func toString(): String {
        match (this) {
            case Int32Value(v) => v.toString()
            case Float32Value(v) => v.toString()
            case StringValue(v) => v
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

func formatString(str: String, args: Array<ArgsValueType>) {
    if (str.size == 0 || args.size == 0) {
        return str
    }
    let runeArr = str.toRuneArray()
    let sb = StringBuilder()
    var signIndex = runeArr.find(ESCAPE_CHARACTER, 0)
    var nonplaceholderStart = 0
    var countPlaceholder = 0
    // ignore ESCAPE_CHARACTER at the end of line
    while (signIndex < runeArr.size - 1) {
        var nonplaceholderSize = signIndex - nonplaceholderStart
        signIndex++
        var rune = runeArr[signIndex]
        // if input is "%%", output is "%"
        if (rune == ESCAPE_CHARACTER) {
            nonplaceholderSize++
            sb.append(runeArr.slice(nonplaceholderStart, nonplaceholderSize))
            signIndex++
            nonplaceholderStart = signIndex
            signIndex = runeArr.find(ESCAPE_CHARACTER, signIndex)
            continue
        }
        // ignore invalid ESCAPE_CHARACTER
        if (!(rune == r'd' || rune == r'f' || rune == r's')) {
            signIndex = runeArr.find(ESCAPE_CHARACTER, signIndex + 1)
            continue
        }
        // valid input list: %d %f %s, format it
        sb.append(runeArr.slice(nonplaceholderStart, nonplaceholderSize))
        if (countPlaceholder >= args.size || !args[countPlaceholder].shouldFormat(rune)) {
            throw BusinessException(ERROR_CODE_RES_ID_FORMAT_ERROR, "Resource manager: parameters error!")
        }
        sb.append(args[countPlaceholder].toString())
        signIndex++
        countPlaceholder++
        nonplaceholderStart = signIndex
        signIndex = runeArr.find(ESCAPE_CHARACTER, signIndex)
    }
    if (countPlaceholder != args.size) {
        throw BusinessException(ERROR_CODE_RES_ID_FORMAT_ERROR, "Resource manager: extra parameter!")
    }
    sb.append(runeArr.slice(nonplaceholderStart, runeArr.size - nonplaceholderStart))
    return sb.toString()
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
