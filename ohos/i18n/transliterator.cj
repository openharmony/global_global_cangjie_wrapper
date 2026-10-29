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

import ohos.ffi.{RemoteDataLite, releaseFFIData}
import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.labels.APILevel

foreign {
    func FfiI18nTransliteratorConstructor(id: CString): Int64

    func FfiI18nTransliteratorTransform(remoteDataId: Int64, text: CString): CString
}

/**
 * Provides text transliteration capabilities, such as creating a transliterator and transliterating text.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Global.I18n"
]
public class Transliterator {
    private let transliteratorImpl: TransliteratorImpl

    private init(transliteratorImpl: TransliteratorImpl) {
        this.transliteratorImpl = transliteratorImpl
    }

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
        return Transliterator(TransliteratorImpl(id))
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
        unsafe {
            var result = ""
            try (cText = LibC.mallocCString(text).asResource()) {
                let cStr = FfiI18nTransliteratorTransform(transliteratorImpl.getId(), cText.value)
                try {
                    result = cStr.toString()
                } finally {
                    LibC.free(cStr)
                }
            }
            return result
        }
    }
}

class TransliteratorImpl <: RemoteDataLite {
    init(id: String) {
        super(unsafe {
            let cId = LibC.mallocCString(id)
            let instanceId = FfiI18nTransliteratorConstructor(cId)
            LibC.free(cId)
            if (instanceId == -1) {
                throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
            }
            instanceId
        })
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    func getId(): Int64 {
        getID()
    }
}
