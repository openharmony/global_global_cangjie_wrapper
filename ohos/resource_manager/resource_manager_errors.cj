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

import std.collection.{HashMap, ArrayList}
import ohos.ffi.{INVALID_CODE, SUCCESS_CODE}
import ohos.business_exception.{BusinessException, getUniversalErrorMsg}

const ERROR_CODE_RES_ID_FORMAT_ERROR: Int32 = 9001007

func throwIfNotSuccess(code: Int32, errorMsg: String): Unit {
    if (code != SUCCESS_CODE) {
        if (code == INVALID_CODE) {
            throw BusinessException(9001002, "Invalid instance")
        }
        throw BusinessException(code, errorMsg)
    }
}

func throwIfNull(ptr: CString): Unit {
    if (ptr.isNull()) {
        throw BusinessException(401, "Parameter error.")
    }
}

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (9001001, "Invalid resource ID."),
        (9001002, "No matching resource is found based on the resource ID."),
        (9001003, "Invalid resource name."),
        (9001004, "No matching resource is found based on the resource name."),
        (9001005, "Invalid relative path."),
        (9001006, "The resource is referenced cyclically."),
        (9001007, "Failed to format the resource obtained based on the resource ID."),
        (9001008, "Failed to format the resource obtained based on the resource Name."),
        (9001009, "Failed to access the system resource."),
        (9001010, "Invalid overlay path.")
    ]
)
func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Unknown error code ${code}."
    }
}