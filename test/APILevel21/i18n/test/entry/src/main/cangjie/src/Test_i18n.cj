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

/**
 * Created on 2024/6/6
 */
package ohos_app_cangjie_entry

internal import AbilityKit.{UIAbilityContext, Ability, Want, LaunchParam}
import std.unittest.testmacro.*
import ohos.i18n.*
import ohos.business_exception.*
import std.time.DateTime
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import ohos.hilog.Hilog
import std.runtime.gc

@Test
class Test_i18n {
    let calendar = getCalendar("zh-Hans")

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_getCalendar_TimeZone() {
        calendar.setTimeZone("Asia/Shanghai")
        let timeZoneAfterSet = calendar.getTimeZone()
        @Expect(timeZoneAfterSet, "Asia/Shanghai")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_Time() {
        calendar.setTime(5000.0)
        let millis = calendar.getTimeInMillis();
        @Expect(millis, 5000.0)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_Set_Get() {
        calendar.set(2000, 1, 1)
        calendar.set(2000, 1, 1, hour: 12, minute: 30, second: 30)
        let year = calendar.get("year")
        let month = calendar.get("month")
        let date = calendar.get("date")
        let hour = calendar.get("hour_of_day")
        let minute = calendar.get("minute")
        let second = calendar.get("second")
        @Expect(year, 2000)
        @Expect(month, 1)
        @Expect(date, 1)
        @Expect(hour, 12)
        @Expect(minute, 30)
        @Expect(second, 30)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_FirstDayOfWeek() {
        let res = calendar.getFirstDayOfWeek()
        @Expect(res, 1)
        calendar.setFirstDayOfWeek(3)
        let result = calendar.getFirstDayOfWeek()
        @Expect(result, 3)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_MinimalDaysInFirstWeek() {
        let res = calendar.getMinimalDaysInFirstWeek()
        @Expect(res, 1)
        calendar.setMinimalDaysInFirstWeek(3)
        let result = calendar.getMinimalDaysInFirstWeek()
        @Expect(result, 3)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_getDisplayName() {
        let calendar = getCalendar("en-US", calendarType: CalendarType.Buddhist)
        let res = calendar.getDisplayName("zh")
        @Expect(res, "佛历")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_add() {
        let calendar = getCalendar("zh-Hans")
        calendar.set(2021, 11, 11)
        calendar.add("year", 3)
        let res = calendar.get("year")
        @Expect(res, 2024)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Calendar_add_errcode() {
        try {
            let calendar = getCalendar("zh-Hans")
            Hilog.debug(1, "i18n", "add start")
            calendar.add("yearrrr", 3)
            Hilog.debug(1, "i18n", "add end")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 890001)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_System_getAppPreferredLanguage() {
        try {
            let appPreferredLanguage = System.getAppPreferredLanguage() // 获取应用偏好语言
            loggerInfo("appPreferredLanguage is ${appPreferredLanguage}")
            @Expect(appPreferredLanguage, "zh-Hans-CN")
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_getCalendar_by_type() {
        let typeArray: Array<CalendarType> = [
            CalendarType.Buddhist,
            CalendarType.Chinese,
            CalendarType.Coptic,
            CalendarType.Ethiopic,
            CalendarType.Hebrew,
            CalendarType.Gregory,
            CalendarType.Indian,
            CalendarType.IslamicCivil,
            CalendarType.IslamicTbla,
            CalendarType.IslamicUmalqura,
            CalendarType.Japanese,
            CalendarType.Persian
        ]
        for (tp in typeArray) {
            try {
                let calendar = getCalendar("zh-Hans", calendarType: tp)
            } catch (e: Exception) {
                @Expect(false)
            }
        }
    }
}
