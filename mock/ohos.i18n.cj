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

package ohos.i18n

import ohos.labels.APILevel

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.I18n"
]
public func getCalendar(locale: String, calendarType!: ?CalendarType = None): Calendar {
    return Calendar()
}

/**
 * Checks whether a language is an RTL language. For an RTL language, UI mirroring is required.
 *
 * @param { String } locale - System locale, which consists of the language, script, and country/region.
 * @returns { Bool } Whether a language is an RTL language. The value **true** indicates that the language is an
 *     RTL language, and the value **false** indicates the opposite.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Global.I18n"
]
public func isRTL(locale: String): Bool {
    return false
}

/**
 * Provides text transliteration capabilities, such as creating a transliterator and transliterating text.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Global.I18n"
]
public class Transliterator {
    /**
     * Creates a **Transliterator** object based on the specified ID.
     * If the specified ID is not supported, a **BusinessException** is thrown.
     *
     * @param { String } id - ID supported by the **Transliterator** object.
     * @returns { Transliterator } **Transliterator** object.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Global.I18n"
    ]
    public static func getInstance(id: String): Transliterator {
        return Transliterator()
    }

    /**
     * Converts the input text from the source format to the target format.
     *
     * @param { String } text - Input text.
     * @returns { String } Text after conversion.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func transform(text: String): String {
        return String()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.I18n"
]
public class Calendar {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setTime(time: Float64): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func set(year: Int32, month: Int32, date: Int32, hour!: ?Int32 = None, minute!: ?Int32 = None,
        second!: ?Int32 = None): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setTimeZone(timeZone: String): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getTimeZone(): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getFirstDayOfWeek(): Int32 {
        return 0
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setFirstDayOfWeek(value: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getMinimalDaysInFirstWeek(): Int32 {
        return 0
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setMinimalDaysInFirstWeek(value: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func get(field: String): Int32 {
        return 0
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getDisplayName(locale: String): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n",
        throwexception: true
    ]
    public func add(field: String, amount: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getTimeInMillis(): Float64 {
        return 0.0
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.I18n"
]
public enum CalendarType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Buddhist
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Chinese
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Coptic
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Ethiopic
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Hebrew
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Gregory
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Indian
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    IslamicCivil
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    IslamicTbla
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    IslamicUmalqura
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Japanese
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Persian
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.I18n"
]
public class System {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public static func getAppPreferredLanguage(): String {
        return String()
    }

    /**
     * Obtains the current system language.
     * To listen for system language changes, enable listening for Support.COMMON_EVENT_LOCALE_CHANGED.
     *
     * @returns { String } Language ID.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Global.I18n"
    ]
    public static func getSystemLanguage(): String {
        return String()
    }

    /**
     * Obtains the current system country/region.
     * To listen for system region changes, enable listening for Support.COMMON_EVENT_LOCALE_CHANGED.
     *
     * @returns { String } Country/region ID.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Global.I18n"
    ]
    public static func getSystemRegion(): String {
        return String()
    }

    public init() {
        super()
    }
}
