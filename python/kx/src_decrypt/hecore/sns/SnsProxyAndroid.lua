require "hecore.sns.SnsCallbackEvent"
require "hecore.luaJavaConvert"
require "zoo.data.MetaManager"

assert(__ANDROID, "must be android platform")

SnsProxy = {profile = {}}

local authorProxy = luajava.bindClass("com.happyelements.hellolua.aps.proxy.APSAuthorizeProxy"):getInstance()
local shareProxy = luajava.bindClass("com.happyelements.hellolua.aps.proxy.APSShareProxy"):getInstance()

local function buildError(errorCode, extra)
    return { errorCode = errorCode, msg = extra }
end

local function buildCallback(callback, resultParser)
    if type(callback) == "table" then
        return convertToInvokeCallback(callback)
    end
  
    local function onError(errorCode, extra)
        if callback then
            callback(SnsCallbackEvent.onError, buildError(errorCode, extra) )
        end
    end

    local function onCancel()
        if callback then
            callback(SnsCallbackEvent.onCancel)
        end
    end
      
    local function onSuccess(result)
        local tResult = nil
        if resultParser ~= nil and result ~= nil then
            tResult = resultParser(result)
        end

        if callback then
            callback(SnsCallbackEvent.onSuccess, tResult)
        end
    end
      
    return luajava.createProxy("com.happyelements.android.InvokeCallback", {
        onSuccess = onSuccess,
        onError = onError,
        onCancel = onCancel
    })
end

function convertToInvokeCallback(callback)
    return luajava.createProxy("com.happyelements.android.InvokeCallback", {
        onSuccess = callback.onSuccess,
        onError = callback.onError,
        onCancel = callback.onCancel
    })
end

function SnsProxy:configQQWallet()
    print("configQQWallet >>>>> ",MaintenanceManager:getInstance():isEnabled("QqWalletFeature"))
    local needRemove = not MaintenanceManager:getInstance():isEnabled("QqWalletFeature")

    local function isSupportQQWalletPay()
       local qqWalletPayment = luajava.bindClass("com.happyelements.android.qq.QQWalletPaymentDelegate")
       return qqWalletPayment:IsMqqInstalled() and qqWalletPayment:IsMqqSupportPay()
    end
    
    local status,result = pcall(isSupportQQWalletPay)

    needRemove = needRemove and result

    local wallet_index = table.indexOf(PlatformConfig.paymentConfig.thirdPartyPayment, Payments.QQ_WALLET)

    if wallet_index and needRemove then
        table.remove(PlatformConfig.paymentConfig.thirdPartyPayment, wallet_index)
    end
end

function SnsProxy:initPlatformConfig()
    print("initPlatformConfig:"..PlatformConfig.name)

    require "hecore.sns.aps.AndroidPayment"
    require "hecore.sns.aps.AndroidAuthorize"
    require "hecore.sns.aps.AndroidShare"

    AndroidAuthorize.getInstance():initAuthorizeConfig(PlatformConfig.authConfig)
    AndroidAuthorize.getInstance():initAuthorizeConfig(PlatformConfig.mergeToAuthConfig)

    if PlatformConfig:isBaiduPlatform() then
        table.insert(PlatformConfig.paymentConfig.thirdPartyPayment, Payments.QQ_WALLET)
    end

    AndroidPayment.getInstance():initPaymentConfig(PlatformConfig.paymentConfig)
    AndroidShare.getInstance():initShareConfig(PlatformConfig.shareConfig)

    if PlatformConfig:isPlatform(PlatformNameEnum.kCMGame) then
        -- 移动"和"游戏基地
        local cmgamePayment = luajava.bindClass("com.happyelements.android.operatorpayment.cmgame.CMGamePayment"):getInstance()
        -- enable or disable music and sound according to CMGame setting
        local isMusicEnabled = cmgamePayment:isMusicEnabled()
        local config = CCUserDefault:sharedUserDefault()
        config:setBoolForKey("game.disable.background.music", not isMusicEnabled)
        config:setBoolForKey("game.disable.sound.effect", not isMusicEnabled)
        config:flush()
    end

    if PlatformConfig:isPlatform(PlatformNameEnum.kHuaWei) then 
        SnsProxy:huaweiAsyncLogin()
    end
    
    if AndroidPayment.getInstance():isPaymentTypeSupported(Payments.QIHOO) then -- 设置支付回调地址，方便修改和测试。默认为线上值
        local qihooConfig = luajava.bindClass("com.happyelements.android.platform.qihoo.QihooConfig")
        qihooConfig:setRefreshPayTokenUrl(NetworkConfig.dynamicHost .. "payment/refreshQihooPayToken")
        qihooConfig:setNotifyUrl(NetworkConfig.dynamicHost .. "payment/qihoo")
    end 

    authorProxy:setAuthorizeType(AndroidAuthorize.getInstance():getDefaultAuthorizeType())
end

function SnsProxy:setAuthorizeType( authorType )
    authorProxy:setAuthorizeType(authorType)
end

function SnsProxy:getAuthorizeType()
    return authorProxy:getAuthorizeType()
end

-- called
-- called
function SnsProxy:isLogin()
    print("SnsProxy:isLogin")
    if PrepackageUtil:isPreNoNetWork() then return false end
    
    local lastLoginUser = Localhost.getInstance():getLastLoginUserConfig()
    print("lastLoginUser. " .. table.tostring(lastLoginUser))
    if not lastLoginUser then
        return false
    end

    local userData = Localhost.getInstance():readUserDataByUserID(lastLoginUser.uid)
    -- print("userData:"..table.tostring(userData))
    if userData and userData.openId then
        print("userData.snsType:"..table.tostring(userData.authorType))
        if not userData.authorType then return false end
        self:setAuthorizeType(userData.authorType) -- 使用上次登陆的平台进行判断

        return authorProxy:isLogin()
    end
    return false
end

function SnsProxy:getAccountInfo()
    local loginCacheTable = {}
    local loginCacheMap = authorProxy:getAccountInfo()
    if loginCacheMap then 
        loginCacheTable = luaJavaConvert.map2Table(loginCacheMap)
    end
    return loginCacheTable
end

-- login
function SnsProxy:login(callback) 
    local authorDelegate = authorProxy:getAuthorizeDelegate()
    print("authorDelegate:")
    print(authorDelegate)
    local resultParser = function(result)
        local tResult = luaJavaConvert.map2Table(result)
        return tResult
    end
    authorProxy:login(buildCallback(callback, resultParser))
end

function SnsProxy:changeAccount( callback )
    local resultParser = function(result)
        local tResult = luaJavaConvert.map2Table(result)
        return tResult
    end
    if authorProxy:getAuthorizeType() == PlatformAuthEnum.k360 then
        local function safe_change_360()
            local delegate = authorProxy:getAuthorizeDelegate()
            delegate:changeAccount(buildCallback(callback, resultParser))
        end
        pcall(safe_change_360)
    else
        authorProxy:login(buildCallback(callback, resultParser))
    end
end

-- called
function SnsProxy:inviteFriends(callback)
    authorProxy:inviteFriends(convertToInvokeCallback(callback))
end

function SnsProxy:getAllFriends(callback)
    authorProxy:getFriends(0, 999, convertToInvokeCallback(callback))
end
-- logout    
function SnsProxy:logout(callback) 
    authorProxy:logout(buildCallback(callback, nil))
end

function SnsProxy:sendInviteMessage(shareType, friendIds, title, text, imageUrl, thumbUrl, callback) 
    local params = {title=title, text=text, image=imageUrl, thumb=thumbUrl}
    shareProxy:setShareType(tonumber(shareType))
    shareProxy:sendInviteMessage(friendIds, luaJavaConvert.table2Map(params), buildCallback(callback, nil))
end

function SnsProxy:shareImage( shareType, title, text, imageUrl, thumbUrl, callback )
    local params = {title=title, text=text, image=imageUrl, thumb=thumbUrl}
    shareProxy:setShareType(tonumber(shareType))
    shareProxy:shareImage(true, luaJavaConvert.table2Map(params), buildCallback(callback, nil))
end

function SnsProxy:shareText( shareType, title, text, callback )
    local params = {title=title, text=text}
    shareProxy:setShareType(tonumber(shareType))
    shareProxy:shareText(true, luaJavaConvert.table2Map(params), buildCallback(callback, nil))
end

--360的全部分享也走这个
function SnsProxy:shareLink( shareType, title, text, linkUrl, thumbUrl, callback )
    local params = {title=title, text=text, link=linkUrl, thumb=thumbUrl}
    print("SnsProxy:shareLink-"..table.tostring(params))
    shareProxy:setShareType(tonumber(shareType))
    shareProxy:shareLink(true, luaJavaConvert.table2Map(params), buildCallback(callback, nil))
end

-- called
function SnsProxy:getOperatorOne()
    return AndroidPayment.getInstance():getOperator()
end
-- called
function SnsProxy:submitScore( leaderBoardId, level )
    if authorProxy:isLogin() then
        authorProxy:submitUserScore(leaderBoardId, level, buildCallback(nil))
    end
end

function SnsProxy:showPlatformLeaderbord( )
    if authorProxy:isLogin() then
        authorProxy:showLeaderBoard()
    else
        local callback = {
            onSuccess=function( result )
                authorProxy:showLeaderBoard()
            end,
            onError=function(errorCode, msg)
            end,
            onCancel=function()
            end
        }
        authorProxy:login(convertToInvokeCallback(callback))
    end
end
-- called
function SnsProxy:purchaseItem(goodsType, itemId, itemAmount, realAmount, callback)
end


-- called
function SnsProxy:syncSnsFriend(sns_token)
    if not sns_token then 
        sns_token = _G.sns_token
    end
    print("SnsProxy:syncSnsFriend")
    if authorProxy:isLogin() then
        local authorType = authorProxy:getAuthorizeType()
        local callback = {
            onSuccess=function( result )
                local userList = luaJavaConvert.list2Table(result)
                local friendOpenIds = {}
                local count = 0
                for i, v in ipairs(userList) do
                    table.insert(friendOpenIds, v.openId)
                    print(tostring(i)..":uid="..tostring(v.openId))
                    count = i
                end
                if count > 0 then
                    local function onRequestError( evt )
                        evt.target:removeAllEventListeners()
                        --GlobalEventDispatcher:getInstance():dispatchEvent(Event.new(SyncSnsFriendEvents.kSyncFailed))
                        
                        print("onPreQzoneError callback")
                    end
                    local function onRequestFinish( evt )
                        evt.target:removeAllEventListeners()
                        --GlobalEventDispatcher:getInstance():dispatchEvent(Event.new(SyncSnsFriendEvents.kSyncSuccess))
                        print("onRequestFinish callback")
                    end 

                    local http = SyncSnsFriendHttp.new()
                    http:addEventListener(Events.kComplete, onRequestFinish)
                    http:addEventListener(Events.kError, onRequestError)

                    http:load(friendOpenIds,nil,nil,authorType)
                else
                    --即使没获取到也得切换好友
                    SyncSnsFriendHttp.new():load({},nil,nil,authorType)           
                end
            end,
            onError = function( err, msg )
                print("err:"..tostring(err)..",msg:"..tostring(msg))
            end,
            onCancel = function()
            end
        }

        local function qqSyncSnsFriend( ... )
            local function onRequestError(evt)
                print("syncSnsFriend onPreQzoneError callback")
                GlobalEventDispatcher:getInstance():dispatchEvent(Event.new(SyncSnsFriendEvents.kSyncFailed))
            end

            local function onRequestFinish(evt)
                FriendManager.getInstance().lastSyncTime = os.time()
                FriendManager.getInstance():setQQFriendsSynced()
                HomeScene:sharedInstance().worldScene:buildFriendPicture()
                GlobalEventDispatcher:getInstance():dispatchEvent(Event.new(SyncSnsFriendEvents.kSyncSuccess))
                print("syncSnsFriend onRequestFinish callback")
            end

            local http = SyncSnsFriendHttp.new()
            http:addEventListener(Events.kComplete, onRequestFinish)
            http:addEventListener(Events.kError, onRequestError)
            if sns_token and sns_token.openId and sns_token.accessToken then
                http:load(nil, sns_token.openId, sns_token.accessToken,authorType)
            end
        end

        if authorProxy:getAuthorizeType() == PlatformAuthEnum.kQQ then --服务端获取QQ关系链
            qqSyncSnsFriend()
        else
            authorProxy:getFriends(0, 999, convertToInvokeCallback(callback))
        end
    end
end
-- called
function SnsProxy:getUserProfile(successCallback,errorCallback,cancelCallback)
    if authorProxy:isLogin() then
        print("SnsProxy:getUserProfile")
        local callback = {
            onSuccess=function(result)
                SnsProxy.profile = luaJavaConvert.map2Table(result)
                print("getUserProfile=", table.tostring(SnsProxy.profile))
                successCallback(result)
            end,
            onError=function(err,msg)
                print("getUserProfile onError=", msg)
                errorCallback(err,msg)
            end,
            onCancel=function()
                cancelCallback()
            end
        }
        authorProxy:getUserProfile(convertToInvokeCallback(callback))
    else
        cancelCallback()
    end
end

function SnsProxy:huaweiAsyncLogin()
    local huaweiProxy = luajava.bindClass("com.happyelements.android.platform.huawei.HuaweiProxy"):getInstance()
    huaweiProxy:asyncLogin()
end

function SnsProxy:huaweiIngameLogin(successCallback, errorCallback, cancelCallback)
    if not PlatformConfig:isPlatform(PlatformNameEnum.kHuaWei) then
        if cancelCallback then cancelCallback() end
        return 
    end
    local callback = {
        onSuccess=function(result)
           local resultTable = luaJavaConvert.map2Table(result)
            print("huawei login accesstoken=", table.tostring(resultTable.accesstoken))
            successCallback(resultTable)
        end,
        onError=function(err,msg)
            print("huawei login onError=", msg)
            errorCallback(err,msg)
        end,
        onCancel=function()
            cancelCallback()
        end
    }
    local huaweiProxy = luajava.bindClass("com.happyelements.android.platform.huawei.HuaweiProxy"):getInstance()
    huaweiProxy:login(convertToInvokeCallback(callback))
end