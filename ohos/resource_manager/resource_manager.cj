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

public import ohos.raw_file_descriptor.RawFileDescriptor
public import ohos.resource.AppResource
import ohos.ffi.{RemoteDataLite, releaseFFIData, RetDataCArrUI8}
import ohos.labels.APILevel
import std.collection.{HashMap, ArrayList}
import std.sync.Mutex
import ohos.raw_file_descriptor.RetDataRawFileDescriptor
import ohos.resource.CResource
import ohos.business_exception.BusinessException

/**
 * Provides the capability of accessing application resources.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Global.ResourceManager"
]
public class ResourceManager <: RemoteDataLite {
    private static let RES_MGR_MAP = HashMap<UIntNative, ResourceManager>()
    private static let APP_MUTEX = Mutex()
    private static let SYS_MUTEX = Mutex()
    private static var sysResMgr = Option<ResourceManager>.None

    init(id: Int64) {
        super(id)
        RES_LOG.info("ResourceManager construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    protected static func getResourceManager(context: StageContext): ResourceManager {
        let ptrAddr = context.toUIntNative()
        match (RES_MGR_MAP.get(ptrAddr)) {
            case Some(v) => v
            case None => synchronized(APP_MUTEX) {
                match (RES_MGR_MAP.get(ptrAddr)) {
                    case Some(v) => v
                    case None =>
                        let mgrId = unsafe { CJ_GetResourceManagerStageMode(context) }
                        let mgr = ResourceManager(mgrId)
                        RES_MGR_MAP.add(ptrAddr, mgr)
                        mgr
                }
            }
        }
    }

    /**
     * Obtains the raw file resource descriptor corresponding to the specified resource path.
     *
     * @param { String } path - Indicates the resource relative path.
     * @returns { RawFileDescriptor } The raw file resource descriptor.
     * @throws { BusinessException } 9001005 - Invalid relative path.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getRawFd(path: String): RawFileDescriptor {
        unsafe {
            let cPath = LibC.mallocCString(path)
            var retRawFd = RetDataRawFileDescriptor(0, 0, 0)
            let retCode = CJ_GetRawFd(getID(), cPath, inout retRawFd)
            LibC.free(cPath)
            let rawFd = RawFileDescriptor(retRawFd)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
            rawFd
        }
    }

    /**
     * Close the raw file resource descriptor corresponding to the specified resource path.
     *
     * @param { String } path - Indicates the resource relative path.
     * @throws { BusinessException } 9001005 - Invalid relative path.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func closeRawFd(path: String): Unit {
        unsafe {
            let cPath = LibC.mallocCString(path)
            let retCode = CJ_CloseRawFd(getID(), cPath)
            LibC.free(cPath)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
        }
    }

    /**
     * Obtains the raw file resource corresponding to the specified resource path.
     *
     * @param { String } path - Indicates the resource relative path.
     * @returns { Array<UInt8> } the raw file resource corresponding to the specified resource path.
     * @throws { BusinessException } 9001005 - Invalid relative path.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getRawFileContent(path: String): Array<UInt8> {
        unsafe {
            let cPath = LibC.mallocCString(path)
            let ret = CJ_GetRawFileContent(getID(), cPath)
            LibC.free(cPath)
            throwIfNotSuccess(ret.code, getErrorMsg(ret.code))
            let size = ret.data.size
            let data = Array<UInt8>(ret.data.size, repeat: 0)
            for (i in 0..size) {
                data[i] = ret.data.head.read(i)
            }
            LibC.free<UInt8>(ret.data.head)
            data
        }
    }

    /**
     * Obtains the rawfile resource list corresponding to the specified resource path.
     *
     * @param { String } path - Indicates the resource relative path.
     * @returns { Array<String> } The rawfile resource list.
     * @throws { BusinessException } 9001005 - Invalid relative path.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getRawFileList(path: String): Array<String> {
        unsafe {
            let cPath = LibC.mallocCString(path)
            let ret = CJ_GetRawFileList(getID(), cPath)
            LibC.free(cPath)
            throwIfNotSuccess(ret.code, getErrorMsg(ret.code))
            let size = ret.data.size
            let arrPtr = ret.data.head
            let arr = Array<String>(size, repeat: "")
            for (i in 0..size) {
                var temp = arrPtr.read(i)
                arr[i] = temp.toString()
                LibC.free(temp)
            }
            LibC.free<CString>(ret.data.head)
            arr
        }
    }

    /**
     * Obtains the color resource corresponding to the specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @returns { UInt32 } Indicates the integer reference value representing the color data.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getColorByName(resName: String): UInt32 {
        unsafe {
            let cName = LibC.mallocCString(resName)
            var data: UInt32 = 0
            let retCode = CJ_GetColorByName(getID(), cName, inout data)
            LibC.free(cName)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
            data
        }
    }

    /**
     * Obtains the color resource corresponding to the specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @returns { UInt32 } Indicates the integer reference value representing the color data.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getColor(resId: UInt32): UInt32 {
        var data: UInt32 = 0
        let retCode = unsafe { CJ_GetColor(getID(), resId, inout data) }
        throwIfNotSuccess(retCode, getErrorMsg(retCode))
        data
    }

    /**
     * Obtains the boolean result with a specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @returns { Bool } The boolean resource corresponding to the resource ID.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getBoolean(resId: UInt32): Bool {
        var data = true
        let retCode = unsafe { CJ_GetBoolean(getID(), resId, inout data) }
        throwIfNotSuccess(retCode, getErrorMsg(retCode))
        data
    }

    /**
     * Obtains the boolean result with a specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @returns { Bool } The boolean resource corresponding to the resource name.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getBooleanByName(resName: String): Bool {
        unsafe {
            let cName = LibC.mallocCString(resName)
            var data = true
            let retCode = CJ_GetBooleanByName(getID(), cName, inout data)
            LibC.free(cName)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
            data
        }
    }

    /**
     * Obtains the number result with a specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @returns { NumberValueType } The number resource corresponding to the resource ID.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getNumber(resId: UInt32): NumberValueType {
        unsafe {
            var data = RetGetNumber(true, 0, 0.0)
            let retCode = CJ_GetNumber(getID(), resId, inout data)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
            data.toNumber()
        }
    }

    /**
     * Obtains the number result with a specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @returns { NumberValueType } The number resource corresponding to the resource name.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getNumberByName(resName: String): NumberValueType {
        unsafe {
            let cName = LibC.mallocCString(resName)
            var data = RetGetNumber(true, 0, 0.0)
            let retCode = CJ_GetNumberByName(getID(), cName, inout data)
            LibC.free(cName)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
            data.toNumber()
        }
    }

    /**
     * Obtains the content of the specified screen density media file corresponding to a specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @param { ?ScreenDensity } [density] - The parameter ScreenDensity, A value of None means
     *                 to use the density of current system dpi.
     * @returns { Array<UInt8> } The content of the specified screen density media file corresponding to the specified resource name.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getMediaByName(resName: String, density!: ?ScreenDensity = None): Array<UInt8> {
        unsafe {
            let cDensity: UInt32 = if (let Some(v) <- density) {
                v.getValue()
            } else {
                0
            }
            let cName = LibC.mallocCString(resName)
            let ret = CJ_GetMediaByName(getID(), cName, cDensity)
            LibC.free(cName)
            throwIfNotSuccess(ret.code, getErrorMsg(ret.code))
            let size = ret.data.size
            let result = Array<UInt8>(size, repeat: 0)
            for (i in 0..size) {
                result[i] = ret.data.head.read(i)
            }
            LibC.free<UInt8>(ret.data.head)
            result
        }
    }

    /**
     * Obtains the content of the specified screen density media file corresponding to a specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @param { ?ScreenDensity } [density] - The optional parameter ScreenDensity, A value of None means
     *                to use the density of current system dpi.
     * @returns { Array<UInt8> } The content of the specified screen density media file corresponding to the specified resource ID.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getMediaContent(resId: UInt32, density!: ?ScreenDensity = None): Array<UInt8> {
        let cDensity: UInt32 = if (let Some(v) <- density) {
            v.getValue()
        } else {
            0
        }
        let ret = unsafe { CJ_GetMediaContent(getID(), resId, cDensity) }
        getMediaContentResult(ret)
    }

    func getMediaContentResult(ret: RetDataCArrUI8): Array<UInt8> {
        throwIfNotSuccess(ret.code, getErrorMsg(ret.code))
        let size = ret.data.size
        let result = Array<UInt8>(size, repeat: 0)
        for (i in 0..size) {
            result[i] = unsafe { ret.data.head.read(i) }
        }
        unsafe { LibC.free<UInt8>(ret.data.head) }
        return result
    }

    /**
     * Obtains the Base64 code of the specified screen density media file corresponding to the specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @param { ?ScreenDensity } [density] - The optional parameter ScreenDensity, A value of None means
     *                to use the density of current system dpi.
     * @returns { String } Indicates the obtained Base64 code of the media file.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getMediaContentBase64(resId: UInt32, density!: ?ScreenDensity = None): String {
        let cDensity: UInt32 = if (let Some(v) <- density) {
            v.getValue()
        } else {
            0
        }
        let retData = unsafe { CJ_GetMediaContentBase64(getID(), resId, cDensity) }
        throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
        throwIfNull(retData.data)
        let ret = retData.data.toString()
        unsafe { LibC.free(retData.data) }
        return ret
    }

    /**
     * Obtains the Base64 code of the specified screen density media file corresponding to the specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @param { ?ScreenDensity } [density] - The parameter ScreenDensity, A value of None means
     *                 to use the density of current system dpi.
     * @returns { String } The obtained Base64 code of the specified screen density media file.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getMediaBase64ByName(resName: String, density!: ?ScreenDensity = None): String {
        let cDensity: UInt32 = if (let Some(v) <- density) {
            v.getValue()
        } else {
            0
        }
        let cName = unsafe { LibC.mallocCString(resName) }
        let retData = unsafe { CJ_GetMediaContentBase64ByName(getID(), cName, cDensity) }
        unsafe { LibC.free(cName) }
        throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
        throwIfNull(retData.data)
        let ret = retData.data.toString()
        unsafe { LibC.free(retData.data) }
        return ret
    }

    /**
     * Obtains the singular-plural character string represented by the ID string corresponding to
     * the specified number.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @param { Int64 } num - Indicates the number.
     * @returns { String } The singular-plural character string represented by the ID string
     *         corresponding to the specified number.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getPluralStringValue(resId: UInt32, num: Int64): String {
        let retData = unsafe { CJ_GetPluralStringValue(getID(), resId, num) }
        throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
        throwIfNull(retData.data)
        let ret = retData.data.toString()
        unsafe { LibC.free(retData.data) }
        return ret
    }

    /**
     * Obtains the singular-plural character string represented by the name string corresponding to
     * the specified number.
     *
     * @param { String } resName - Indicates the resource name.
     * @param { Int64 } num - Indicates the number.
     * @returns { String } The singular-plural character string represented by the name string
     *         corresponding to the specified number.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true,
        workerthread: true
    ]
    public func getPluralStringByName(resName: String, num: Int64): String {
        unsafe {
            let cName = LibC.mallocCString(resName)
            let retData = CJ_GetPluralStringByName(getID(), cName, num)
            LibC.free(cName)
            throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
            throwIfNull(retData.data)
            let ret = retData.data.toString()
            LibC.free(retData.data)
            return ret
        }
    }

    /**
     * Obtains the array of character strings corresponding to a specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @returns { Array<String> } The array of character strings corresponding to the specified resource ID.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getStringArrayValue(resId: UInt32): Array<String> {
        let retData = unsafe { CJ_GetStringArrayValue(getID(), resId) }
        throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
        return retData.getDataAndFree()
    }

    /**
     * Obtains the array of character strings corresponding to a specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @returns { Array<String> } the array of character strings corresponding to the specified resource name.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getStringArrayByName(resName: String): Array<String> {
        unsafe {
            let cName = LibC.mallocCString(resName)
            let retData = CJ_GetStringArrayByName(getID(), cName)
            LibC.free(cName)
            throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
            return retData.getDataAndFree()
        }
    }

    /**
     * Obtains string resources associated with a specified resource ID.
     *
     * @param { UInt32 } resId - Indicates the resource ID.
     * @param { Array<ArgsValueType> } args - Indicates the formatting string resource parameters.
     * @returns { String } The character string corresponding to the resource ID.
     * @throws { BusinessException } 9001001 - Invalid resource ID.
     * @throws { BusinessException } 9001002 - No matching resource is found based on the resource ID.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     * @throws { BusinessException } 9001007 - Failed to format the resource obtained based on the resource ID.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getString(resId: UInt32, args: Array<ArgsValueType>): String {
        let retData = unsafe { CJ_GetString(getID(), resId) }
        throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
        throwIfNull(retData.data)
        let ret = retData.data.toString()
        unsafe { LibC.free(retData.data) }
        return formatString(ret, args)
    }

    /**
     * Obtains string resources associated with a specified resource name.
     *
     * @param { String } resName - Indicates the resource name.
     * @param { Array<ArgsValueType> } args - Indicates the formatting string resource parameters.
     * @returns { String } The character string corresponding to the resource name.
     * @throws { BusinessException } 9001003 - Invalid resource name.
     * @throws { BusinessException } 9001004 - No matching resource is found based on the resource name.
     * @throws { BusinessException } 9001006 - The resource is referenced cyclically.
     * @throws { BusinessException } 9001008 - Failed to format the resource obtained based on the resource Name.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func getStringByName(resName: String, args: Array<ArgsValueType>): String {
        unsafe {
            let cName = LibC.mallocCString(resName)
            let retData = CJ_GetStringByName(getID(), cName)
            LibC.free(cName)
            throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
            let ret = retData.data.toString()
            LibC.free(retData.data)
            return formatString(ret, args)
        }
    }

    /**
     * Obtains the device configuration.
     *
     * @returns { Configuration } the device configuration.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public func getConfiguration(): Configuration {
        unsafe {
            var cfg = RetConfigurationEx(0, 0, 0, 0, 0, 0, CString(CPointer<UInt8>()))
            let retCode = FfiResMgrGetConfiguration(getID(), inout cfg)
            let configuration = cfg.toConfiguration()
            LibC.free(cfg.locale)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
            return configuration
        }
    }

    /**
     * Obtains the device capability.
     *
     * @returns { DeviceCapability } the device capability.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public func getDeviceCapability(): DeviceCapability {
        var deviceCapability = RetDeviceCapability(0, 0)
        let retCode = unsafe { CJ_GetDeviceCapability(getID(), inout deviceCapability) }
        let result = deviceCapability.toDeviceCapability()
        throwIfNotSuccess(retCode, getErrorMsg(retCode))
        return result
    }

    /**
     * Add overlay resources during application runtime.
     *
     * @param { String } path - Indicates the application overlay path.
     * @throws { BusinessException } 9001010 - Invalid overlay path.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func addResource(path: String): Unit {
        unsafe {
            let cPath = LibC.mallocCString(path)
            let retCode = CJ_AddResource(getID(), cPath)
            LibC.free(cPath)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
        }
    }

    /**
     * Remove overlay resources during application runtime.
     *
     * @param { String } path - Indicates the application overlay path.
     * @throws { BusinessException } 9001010 - Invalid overlay path.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager",
        throwexception: true
    ]
    public func removeResource(path: String): Unit {
        unsafe {
            let cPath = LibC.mallocCString(path)
            let retCode = CJ_RemoveResource(getID(), cPath)
            LibC.free(cPath)
            throwIfNotSuccess(retCode, getErrorMsg(retCode))
        }
    }

    /**
     * Obtains locales list.
     *
     * @param { Bool } [includeSystem] - the parameter controls whether to include system resources,
     *     the default value is false, it has no effect when only system resources query the locales list.
     * @returns { Array<String> } the list of strings for the locales.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Global.ResourceManager"
    ]
    public func getLocales(includeSystem!: Bool = false): Array<String> {
        let retData = unsafe { CJ_GetLocales(getID(), includeSystem) }
        throwIfNotSuccess(retData.code, getErrorMsg(retData.code))
        return retData.getDataAndFree()
    }
}