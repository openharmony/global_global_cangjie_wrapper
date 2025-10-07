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

package ohos.i18n

import ohos.business_exception.BusinessException
import ohos.ffi.{RemoteDataLite, releaseFFIData}
import ohos.labels.APILevel

foreign {
    func FfiOHOSGetCalendar(locale: CString, calendarType: CString): Int64

    func FfiOHOSCalendarSetTime(id: Int64, time: Float64): Unit

    func FfiOHOSCalendarSetDate(id: Int64, year: Int32, month: Int32, day: Int32): Unit

    func FfiOHOSCalendarSetOfDay(id: Int64, hour: Int32, minute: Int32, second: Int32): Unit

    func FfiOHOSCalendarSetTimeOfDay(id: Int64, hour: Int32, minute: Int32, second: Int32, flag: Int32): Unit

    func FfiOHOSCalendarSetTimeZone(id: Int64, timeZone: CString): Unit

    func FfiOHOSCalendarGetTimeZone(id: Int64): CString

    func FfiOHOSCalendarGetFirstDayOfWeek(id: Int64): Int32

    func FfiOHOSCalendarSetFirstDayOfWeek(id: Int64, value: Int32): Unit

    func FfiOHOSCalendarGetMinimalDaysInFirstWeek(id: Int64): Int32

    func FfiOHOSCalendarSetMinimalDaysInFirstWeek(id: Int64, value: Int32): Unit

    func FfiOHOSCalendarGet(id: Int64, field: CString): Int32

    func FfiOHOSCalendarGetDisplayName(id: Int64, locale: CString): CString

    func FfiOHOSCalendarIsWeekend(id: Int64, date: CDate): Bool

    func FfiOHOSCalendarAdd(id: Int64, field: CString, amount: Int32, code: CPointer<Int32>): Unit

    func FfiOHOSCalendarGetTimeInMillis(id: Int64): Float64

    func FfiOHOSCalendarCompareDays(id: Int64, date: CDate): Int32
}


/**
 * Obtains the Calendar object for the specified locale and calendar type.
 *
 * @param { String } locale - Locale ID, which consists of the language, script, and country/region,
 *                            for example, zh-Hans-CN.
 * @param { ?CalendarType } calendarType - Calendar. For details about the meanings and application scenarios of
 *                            different values, see Calendar Setting.
 * @returns { Calendar } Calendar object
 * @relation export function getCalendar(locale: string, type?: string): Calendar
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Global.I18n"
]
public func getCalendar(locale: String, calendarType!: ?CalendarType = None): Calendar {
    var id = 0
    try (
        cLocale = unsafe { LibC.mallocCString(locale).asResource() },
        cCalendarType = if (let Some(v) <- calendarType) {
            unsafe { LibC.mallocCString(v.toString()).asResource() }
        } else {
            CString(CPointer<UInt8>()).asResource()
        }
    ) {
        id = unsafe { FfiOHOSGetCalendar(cLocale.value, cCalendarType.value) }
    }
    Calendar(id)
}

/**
 * Provides the API for accessing Calendar name, time and date related information.
 *
 * @relation export class Calendar
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Global.I18n"
]
public class Calendar <: RemoteDataLite {
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Sets the date and time for a Calendar object.
     *
     * @relation setTime(time: number): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setTime(time: Float64): Unit {
        unsafe {
            FfiOHOSCalendarSetTime(getID(), time)
        }
    }

    /**
     * Sets the year, month, day, hour, minute, and second for this Calendar object.
     *
     * @relation set(year: number, month: number, date: number, hour?: number, minute?: number, second?: number): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func set(year: Int32, month: Int32, date: Int32, hour!: ?Int32 = None, minute!: ?Int32 = None, second!: ?Int32 = None): Unit {
        var cHour: Int32 = 0
        var cMinute: Int32 = 0
        var cSecond: Int32 = 0
        var flag: Int32 = 0
        if (let Some(v) <- hour) {
            flag += 4  // 1xx means that hour needs to be set
            cHour = v
        }
        if (let Some(v) <- minute) {
            flag += 2  // x1x means that minute needs to be set
            cMinute = v
        }
        if (let Some(v) <- second) {
            flag += 1 // xx1 means that second needs to be set
            cSecond = v
        }
        unsafe {
            FfiOHOSCalendarSetDate(getID(), year, month, date)
            FfiOHOSCalendarSetTimeOfDay(getID(), cHour, cMinute, cSecond, flag)
        }
    }

    /**
     * Sets the time zone of this Calendar object.
     *
     * @relation setTimeZone(timezone: string): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setTimeZone(timeZone: String): Unit {
        unsafe {
            let cTimeZone = LibC.mallocCString(timeZone)
            FfiOHOSCalendarSetTimeZone(getID(), cTimeZone)
            LibC.free(cTimeZone)
        }
    }

    /**
     * Obtains the time zone ID of this Calendar object.
     *
     * @relation getTimeZone(): string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getTimeZone(): String {
        unsafe {
            let timeZone = FfiOHOSCalendarGetTimeZone(getID())
            let res = timeZone.toString()
            LibC.free(timeZone)
            return res
        }
    }

    /**
     * Obtains the first day of a week for this Calendar object.
     *
     * @relation getFirstDayOfWeek(): number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getFirstDayOfWeek(): Int32 {
        unsafe {
            return FfiOHOSCalendarGetFirstDayOfWeek(getID())
        }
    }

    /**
     * Sets the first day of a week for this Calendar object.
     *
     * @relation setFirstDayOfWeek(value: number): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setFirstDayOfWeek(value: Int32): Unit {
        unsafe {
            FfiOHOSCalendarSetFirstDayOfWeek(getID(), value)
        }
    }

    /**
     * Obtains the minimum number of days in the first week for this Calendar object.
     *
     * @relation getMinimalDaysInFirstWeek(): number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getMinimalDaysInFirstWeek(): Int32 {
        unsafe {
            return FfiOHOSCalendarGetMinimalDaysInFirstWeek(getID())
        }
    }

    /**
     * Sets the minimum number of days in the first week for this Calendar object.
     *
     * @relation setMinimalDaysInFirstWeek(value: number): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func setMinimalDaysInFirstWeek(value: Int32): Unit {
        unsafe {
            FfiOHOSCalendarSetMinimalDaysInFirstWeek(getID(), value)
        }
    }

    /**
     * Obtains the values of the calendar attributes in this Calendar object.
     *
     * @param { string } field - Calendar attributes. The following table lists the supported attribute values.
     * @returns { Int32 } Value of the calendar attribute. For example, if the year of the internal date of the
     *                     current Calendar object is 1990, get('year') returns 1990.
     * @relation get(field: string): number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func get(field: String): Int32 {
        unsafe {
            let cField = LibC.mallocCString(field)
            let result = FfiOHOSCalendarGet(getID(), cField)
            LibC.free(cField)
            return result
        }
    }

    /**
     * Obtains calendar display name in the specified language.
     *
     * @param { string } locale - System locale, which consists of the language, script, and country/region.
     * @returns { string } Calendar display name in the specified language. For example, buddhist is displayed as
     *                     Buddhist Calendar if the locale is en-US.
     * @relation getDisplayName(locale: string): string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getDisplayName(locale: String): String {
        unsafe {
            let cLocale = LibC.mallocCString(locale)
            let result = FfiOHOSCalendarGetDisplayName(getID(), cLocale)
            let res = result.toString()
            LibC.free(cLocale)
            LibC.free(result)
            return res
        }
    }

    /**
     * Performs addition or subtraction on the calendar attributes of this Calendar object.
     *
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     *                                 2.Incorrect parameter types.
     * @throws { BusinessException } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
     * @relation add(field: string, amount: number): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func add(field: String, amount: Int32): Unit {
        unsafe {
            let cField = LibC.mallocCString(field)
            var errCode: Int32 = 0
            FfiOHOSCalendarAdd(getID(), cField, amount, inout errCode)
            LibC.free(cField)
            if (errCode != 0) {
                throw BusinessException(errCode, getErrorMsg(errCode))
            }
        }
    }

    /**
     * Obtains the timestamp of this Calendar object.
     *
     * @relation getTimeInMillis(): number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Global.I18n"
    ]
    public func getTimeInMillis(): Float64 {
        unsafe {
            return FfiOHOSCalendarGetTimeInMillis(getID())
        }
    }
}
