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

import ohos.labels.APILevel

foreign {
    func FfiI18nSystemGetAppPreferredLanguage(): CString

    func FfiI18nSystemGetSystemLanguage(): CString

    func FfiI18nSystemGetSystemRegion(): CString
}

/**
 * Provides system functions.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.I18n"
]
public class System {
    init() {}

    /**
     * Obtains the preferred language of an application.
     *
     * @returns { String } Returns the preferred language of the application.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.I18n"
    ]
    public static func getAppPreferredLanguage(): String {
        let clanguage = unsafe { FfiI18nSystemGetAppPreferredLanguage() }
        try {
            let language = clanguage.toString()
            return language
        } finally {
            unsafe { LibC.free(clanguage) }
        }
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
        let cStr = unsafe { FfiI18nSystemGetSystemLanguage() }
        try {
            let str = cStr.toString()
            return str
        } finally {
            unsafe { LibC.free(cStr) }
        }
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
        let cStr = unsafe { FfiI18nSystemGetSystemRegion() }
        try {
            let str = cStr.toString()
            return str
        } finally {
            unsafe { LibC.free(cStr) }
        }
    }
}
