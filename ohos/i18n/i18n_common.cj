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

import std.time.DateTime
import ohos.business_exception.getUniversalErrorMsg
import std.collection.HashMap
import ohos.labels.APILevel
import ohos.business_exception.BusinessException

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [(890001, "Invalid parameter. Possible causes: Parameter verification failed.")])

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Unknown error code ${code}"
    }
}

/**
 * Calendar type.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.I18n"
]
public enum CalendarType {
    /**
     * buddhist calendar type
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Buddhist
    /**
     * chinese calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Chinese
    /**
     * coptic calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Coptic
    /**
     * ethiopic calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Ethiopic
    /**
     * hebrew calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Hebrew
    /**
     * gregory calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Gregory
    /**
     * indian calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Indian
    /**
     * islamic_civil calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    IslamicCivil
    /**
     * islamic_tbla calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    IslamicTbla
    /**
     * islamic_umalqura calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    IslamicUmalqura
    /**
     * japanese calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Japanese
    /**
     * persian calendar type
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    Persian
    | ...

    func toString(): String {
        match (this) {
            case Buddhist => "buddhist"
            case Chinese => "chinese"
            case Coptic => "coptic"
            case Ethiopic => "ethiopic"
            case Hebrew => "hebrew"
            case Gregory => "gregory"
            case Indian => "indian"
            case IslamicCivil => "islamic_civil"
            case IslamicTbla => "islamic_tbla"
            case IslamicUmalqura => "islamic_umalqura"
            case Japanese => "japanese"
            case Persian => "persian"
            case _ => throw BusinessException(890001, "Invalid parameter. Possible causes: Parameter verification failed.")
        }
    }
}

@C
struct CDate {
    CDate(
        let year: Int64,
        let month: Int64,
        let day: Int64,
        let icuUdate: Float64,
        let isNull: Bool
    ) {}

    init(date: DateTime) {
        this.year = date.year
        this.month = date.month.toInteger()
        this.day = date.dayOfMonth
        this.icuUdate = Float64(date.toUnixTimeStamp().toMilliseconds())
        this.isNull = false
    }

    init() {
        this.year = 0
        this.month = 0
        this.day = 0
        this.icuUdate = 0.0
        this.isNull = true
    }
}