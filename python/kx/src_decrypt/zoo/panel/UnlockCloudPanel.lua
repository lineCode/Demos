
-- Copyright C2009-2013 www.happyelements.com, all rights reserved.
-- Create Date:	2013年12月 3日 13:53:56
-- Author:	ZhangWan(diff)
-- Email:	wanwan.zhang@happyelements.com

require "zoo.panel.basePanel.panelAnim.PanelPopRemoveAnim"
require "zoo.panel.component.unlockCloudPanel.FriendItem"
require "zoo.baseUI.BuyAndContinueButton"
require 'zoo.panel.MoreStarPanel'

---------------------------------------------------
-------------- UnlockCloudPanel
---------------------------------------------------

assert(not UnlockCloudPanel)
UnlockCloudPanel = class(BasePanel)

function UnlockCloudPanel:init(lockedCloudId, totalStar, neededStar, cloudCanOpenCallback, ...)
	assert(type(lockedCloudId) == "number")
	assert(type(totalStar) == "number")
	assert(type(neededStar) == "number")
	assert(type(cloudCanOpenCallback) == "function")
	assert(#{...} == 0)

	-----------------
	-- Get UI Resource
	-- ------------------
	-- self.ui	= self:buildInterfaceGroup('unlockCloudPanelNew') --ResourceManager:sharedInstance():buildGroup("unlockCloudPanelNew")

	------------------
	-- Init Base Class
	-- ----------------
	BasePanel.init(self, self.ui)

	-- test
	self.ui:getChildByName('_friendYellowBg'):setVisible(false)

	---------
	-- Data
	-- ------
	self.lockedCloudId		= lockedCloudId
	self.totalStar			= totalStar
	self.neededStar			= neededStar
	self.cloudCanOpenCallback	= cloudCanOpenCallback

	self.curAreaFriendIds	= {}

	----------------
	-- Get Agreed Friend Ids
	-- --------------------
	self:getAgreedFriendIds()

	self.BTN_TAPPED_STATE_CLOSE_BTN_TAPPED			= 1
	self.BTN_TAPPED_STATE_ASK_FRIEND_BTN_TAPPED	= 2
	self.BTN_TAPPED_STATE_NONE				= 3
	self.btnTappedState					= self.BTN_TAPPED_STATE_NONE

	----------------------
	-- Get UI Resource
	-- ---------------------
	self.closeBtnRes		= self.ui:getChildByName("closeBtn")
	-- self.panelTitle			= self.ui:getChildByName("panelTitle")
	self.panelTitle = TextField:createWithUIAdjustment(self.ui:getChildByName("panelTitleSize"), self.ui:getChildByName("panelTitle"))
	self.ui:addChild(self.panelTitle)
	self.starNumDesLabel		= self.ui:getChildByName("starNumDesLabel")
	
	self.friendItem1Res		= self.ui:getChildByName("friendItem1")
	self.friendItem2Res		= self.ui:getChildByName("friendItem2")
	self.friendItem3Res		= self.ui:getChildByName("friendItem3")
	self.desLabel1			= self.ui:getChildByName("desLabel1")
	self.desLabel2			= self.ui:getChildByName("desLabel2")
	self.askFriendBtnRes		= self.ui:getChildByName("askFriendBtn")
	self.useWindmillBtnRes		= self.ui:getChildByName("useWindmillBtn")
	-- self.starNumLabel		= self.ui:getChildByName("starNumLabel")
	self.starNumLabel = TextField:createWithUIAdjustment(self.ui:getChildByName("starNumLabelSize"), self.ui:getChildByName("starNumLabel"))
	self.ui:addChild(self.starNumLabel)
	self.starNumProgressBarRes	= self.ui:getChildByName("starNumProgressBar")

	assert(self.closeBtnRes)
	assert(self.panelTitle)
	assert(self.starNumDesLabel)
	assert(self.friendItem1Res)
	assert(self.friendItem2Res)
	assert(self.friendItem3Res)
	assert(self.desLabel1)
	assert(self.desLabel2)
	assert(self.askFriendBtnRes)
	assert(self.useWindmillBtnRes)
	assert(self.starNumLabel)
	assert(self.starNumProgressBarRes)



	 -- interface improvements
	self.ui:getChildByName('_topGreenBg'):setOpacity(125)
	self.ui:getChildByName('_belowGreenBg'):setOpacity(125)

	
	---------------------
	-- Get Data About UI
	-- ----------------
	self.panelTitlePhPos = self.panelTitle:getPosition()

	---------------------
	-- Create UI Componenet
	-- ----------------------
	self.starNumProgressBar		= HomeSceneItemProgressBar:create(self.starNumProgressBarRes, self.totalStar, neededStar)

	self.friendItem1	= FriendItem:create(self.friendItem1Res)
	self.friendItem2	= FriendItem:create(self.friendItem2Res)
	self.friendItem3	= FriendItem:create(self.friendItem3Res)

	self.friendItems = {self.friendItem1, self.friendItem2, self.friendItem3}

	-- self.askFriendBtn	= ButtonWithShadow:create(self.askFriendBtnRes)
	-- self.useWindmillBtn	= BuyAndContinueButton:create(self.useWindmillBtnRes)
	self.askFriendBtn	= GroupButtonBase:create(self.askFriendBtnRes)
	self.useWindmillBtn	= ButtonIconNumberBase:create(self.useWindmillBtnRes)
	self.useWindmillBtn:setColorMode(kGroupButtonColorMode.blue)
	self.moreStarBtn = GroupButtonBase:create(self.ui:getChildByName('moreStarBtn'))
	self.moreStarBtn:setString(Localization:getInstance():getText('more.star.btn.txt'))
	self.moreStarBtn:ad(DisplayEvents.kTouchTap, function () self:onMoreStarBtnTapped() end)

	----------------
	-- Update View
	-- --------------
	
	-- Star Number Label String
	-- self.starNumLabel:setString(self.totalStar .. "/" .. self.neededStar)
	self.starNumLabel:setString(self.totalStar .. "/" .. self.neededStar)

	-- Set self.needStarDes Label
	local starNumDesLabelKey	= "unlock.cloud.panel.star.number.description"
	local starNumDesLabelValue	= Localization:getInstance():getText(starNumDesLabelKey, {need_star_number = self.neededStar - self.totalStar})

	self.starNumDesLabel:setString(starNumDesLabelValue)
	
	local desLabel1Key	= "unlock.cloud.panel.you.can"
	local desLabel1Value	= Localization:getInstance():getText(desLabel1Key, {})
	self.desLabel1:setString(desLabel1Value)

	local desLabel2Key	= "unlock.cloud.panel.you.or"
	local desLabel2Value	= Localization:getInstance():getText(desLabel2Key, {})
	self.desLabel2:setString(desLabel2Value)

	--he_log_warning("hard coded 9 windmill to unlock cloud !")
	local goodsMeta = MetaManager.getInstance():getGoodMetaByItemID(self.lockedCloudId)
	if __ANDROID and not PaymentManager.getInstance():checkCanWindMillPay(goodsMeta.id)then -- ANDROID
		self.useWindmillBtn:setIcon(nil)
		local text = string.format("%s%0.2f", Localization:getInstance():getText("buy.gold.panel.money.mark"), goodsMeta.rmb / 100)
		self.useWindmillBtn:setNumber(text)

		local numberLabel = self.useWindmillBtn.numberLabel
		if numberLabel then
			numberLabel:setPositionX(numberLabel:getPositionX() - 10)
		end
	else -- else, on IOS and PC we use gold!
		self.useWindmillBtn:setIconByFrameName('ui_images/ui_image_coin_icon_small0000')
		self.useWindmillBtn:setNumber(goodsMeta.qCash)
	end

	local useWindmillBtnLabelKey	= "unlock.cloud.panel.button.unlock"
	local useWindmillBtnLabelValue	= Localization:getInstance():getText(useWindmillBtnLabelKey, {})
	-- self.useWindmillBtn:setLabel(useWindmillBtnLabelValue)
	self.useWindmillBtn:setString(useWindmillBtnLabelValue)

	local askFriendBtnLabelKey	= "unlock.cloud.panel.button.request.friend"
	local askFriendBtnLabelValue	= Localization:getInstance():getText(askFriendBtnLabelKey, {})
	self.askFriendBtn:setString(askFriendBtnLabelValue)

	---------------------
	-- Add Event Listener
	-- ------------------
	
	local function onCloseBtnTapped()
		if self.btnTappedState == self.BTN_TAPPED_STATE_NONE then
			self.btnTappedState = self.BTN_TAPPED_STATE_CLOSE_BTN_TAPPED
		else
			return
		end

		self:remove(false)
	end
	self.closeBtnRes:setTouchEnabled(true)
	self.closeBtnRes:setButtonMode(true)
	self.closeBtnRes:addEventListener(DisplayEvents.kTouchTap, onCloseBtnTapped)

	
	local function onAskFriendBtnTapped()
		if PrepackageUtil:isPreNoNetWork() then
			PrepackageUtil:showInGameDialog()
		else
			self:onAskFriendBtnTapped()
		end
	end
	-- self.askFriendBtn.ui:addEventListener(DisplayEvents.kTouchTap, onAskFriendBtnTapped)
	self.askFriendBtn:addEventListener(DisplayEvents.kTouchTap, onAskFriendBtnTapped)



	local function onUseWindmillBtnTapped()
		self:onUseWindmillBtnTapped()
	end
	-- self.useWindmillBtn.ui:addEventListener(DisplayEvents.kTouchTap, onUseWindmillBtnTapped)
	self.useWindmillBtn:addEventListener(DisplayEvents.kTouchTap, onUseWindmillBtnTapped)


	-- -------------------
	-- Create Panel Title
	-- -------------------
	-- local charWidth		= 58
	-- local charHeight	= 58
	-- local charInterval	= 46
	-- local fntFile		= "fnt/titles.fnt"
	-- self.panelTitle		= LabelBMMonospaceFont:create(charWidth, charHeight, charInterval, fntFile)
	-- self.panelTitle:setAnchorPoint(ccp(0, 1))
	-- self.panelTitle:setPosition(ccp(self.panelTitlePhPos.x, self.panelTitlePhPos.y))
	-- self.ui:addChild(self.panelTitle)

	-- Set Panel Title
	local titleKey			= "unlock.cloud.panel.title"
	local titleValue		= Localization:getInstance():getText(titleKey)
	self.panelTitle:setString(titleValue)
	-- self.panelTitle:setToParentCenterHorizontal()
end

function UnlockCloudPanel:onUseWindmillBtnTapped(...)
	assert(#{...} == 0)

	-- Send Message Unlock The Cloud
	local price = nil

	local function onSendUnlockMsgSuccess()

		local function animateFinish()
			-- Remove Self 
			self.onEnterForeGroundCallback  = nil
			local function onRemoveSelfFinish()
				self.cloudCanOpenCallback()
			end

			self:remove(onRemoveSelfFinish)
		end

		local array = CCArray:create()
		if price ~= nil then
			array:addObject(CCDelayTime:create(0.8))

			local bounds = self.useWindmillBtn:getGroupBounds()
			local pos = ccp(bounds:getMidX(), bounds:getMidY())
			self.useWindmillBtn:playFloatAnimation('-'..price)

		end
		array:addObject(CCCallFunc:create(animateFinish))
		self:runAction(CCSequence:create(array))
	end

	local function onSendUnlockMsgFailed()
		--print("use gold unlock cloud failed !")
		self.onEnterForeGroundCallback  = nil
		local failTxtKey
		local goodMeta	= MetaManager.getInstance():getGoodMetaByItemID(self.lockedCloudId)
		if __ANDROID and not PaymentManager.getInstance():checkCanWindMillPay(goodMeta.id) then 
			failTxtKey = "unlock.cloud.panel.use.rmb.unlock.failed" -- ANDROID
		else 
			failTxtKey = "unlock.cloud.panel.use.gold.unlock.failed" 
		end -- IOS and PC
		local failTxtValue	= Localization:getInstance():getText(failTxtKey, {})
		CommonTip:showTip(failTxtValue)
		-- self.useWindmillBtn.ui:setTouchEnabled(true)
		self.useWindmillBtn:setEnabled(true)
	end

	local function onSendUnlockMsgCanceled()
		-- self.useWindmillBtn.ui:setTouchEnabled(true)
		
		self.onEnterForeGroundCallback  = nil
		if not self or self.isDisposed then return end
		self.useWindmillBtn:setEnabled(true)
	end

	-- self.useWindmillBtn.ui:setTouchEnabled(false)
	self.useWindmillBtn:setEnabled(false)

 	if __ANDROID then -- ANDROID
 		local logic = UnlockLevelAreaLogic:create(self.lockedCloudId)
		logic:setOnSuccessCallback(onSendUnlockMsgSuccess)
		logic:setOnFailCallback(onSendUnlockMsgFailed)
		logic:setOnCancelCallback(onSendUnlockMsgCanceled)
		logic:start(UnlockLevelAreaLogicUnlockType.USE_WINDMILL_COIN, {})
		self.onEnterForeGroundCallback = onSendUnlockMsgCanceled
	else -- else, on IOS and PC we use gold!
		-- Get Current Cash
		-- Check If Has Enough QCash
		local curCash	= UserManager:getInstance().user.cash
		local goodMeta	= MetaManager.getInstance():getGoodMetaByItemID(self.lockedCloudId)

		--self.useWindmillBtn.ui:setTouchEnabled(false)

		if curCash < goodMeta.qCash then
			-- Not Has Enough Gold
			local function createGoldPanel()
				local index = MarketManager:sharedInstance():getHappyCoinPageIndex()
				if index ~= 0 then
					local panel = createMarketPanel(index)
					panel:addEventListener(kPanelEvents.kClose, onSendUnlockMsgCanceled)
					panel:popout()
				else onSendUnlockMsgCanceled() end
			end
			GoldlNotEnoughPanel:create(createGoldPanel, onSendUnlockMsgCanceled):popout()
		else
			price = goodMeta.qCash
			local logic = UnlockLevelAreaLogic:create(self.lockedCloudId)
			logic:setOnSuccessCallback(onSendUnlockMsgSuccess)
			logic:setOnFailCallback(onSendUnlockMsgFailed)
			logic:setOnCancelCallback(onSendUnlockMsgCanceled)
			logic:start(UnlockLevelAreaLogicUnlockType.USE_WINDMILL_COIN, {})
		end
	end
end

function UnlockCloudPanel:sendUnlockMsg()
	local function onSendUnlockMsgSuccess(event)
		-- Remove Self 
		print("onSendUnlockMsgSuccess Called !")

		local function onRemoveSelfFinish()
			self.cloudCanOpenCallback()
			print("onRemoveSelfFinish Called !")
		end
		self.isUnlockSuccess = true
		self:remove(onRemoveSelfFinish)
	end

	local function onSendUnlockMsgFailed(errorCode)
		self.btnTappedState = self.BTN_TAPPED_STATE_NONE
		CommonTip:showTip(Localization:getInstance():getText("error.tip."..errorCode), "negative")
	end

	local function onSendUnlockMsgCanceled(event)
		self.btnTappedState = self.BTN_TAPPED_STATE_NONE
	end

	local logic = UnlockLevelAreaLogic:create(self.lockedCloudId)
	logic:setOnSuccessCallback(onSendUnlockMsgSuccess)
	logic:setOnFailCallback(onSendUnlockMsgFailed)
	logic:setOnCancelCallback(onSendUnlockMsgCanceled)
	logic:start(UnlockLevelAreaLogicUnlockType.USE_FRIEND, {})
end

function UnlockCloudPanel:onAskFriendBtnTapped(...)
	assert(#{...} == 0)
	if __IOS_FB and not SnsProxy:isShareAvailable() then 
		CommonTip:showTip(Localization:getInstance():getText("error.tip.facebook.login"), "negative",nil,2)
		return
	end

	self:tryRemoveGuide()
	if #self.curAreaFriendIds >= 3 then

		if self.btnTappedState == self.BTN_TAPPED_STATE_NONE then
			self.btnTappedState = self.BTN_TAPPED_STATE_ASK_FRIEND_BTN_TAPPED
		else
			return
		end

		self:sendUnlockMsg()
	else
		self:chooseUnlockFriend()
	end
end

function UnlockCloudPanel:chooseUnlockFriend()
	local function onSuccess(friendIds)
		if not self.friendIdsSent then
			self.friendIdsSent = {}
		end
		if friendIds then
			for k, v in pairs(friendIds) do
				table.insert(self.friendIdsSent, v)
			end
		end
	end
	local function onFail(evt)

	end
	ChooseFriendPanel:popoutPanel(self.lockedCloudId, self.curAreaFriendIds, onSuccess, onFail)
end

function UnlockCloudPanel:onCloseBtnTapped(...)
	assert(#{...} == 0)

	if self.btnTappedState == self.BTN_TAPPED_STATE_NONE then
		self.btnTappedState = self.BTN_TAPPED_STATE_CLOSE_BTN_TAPPED
	else
		return
	end

	self:remove(false)
	if self.closeCallback then
		self.closeCallback(self.isUnlockSuccess, self.friendIdsSent)
	end
end

function UnlockCloudPanel:updateView(...)
	assert(#{...} == 0)

	if self.isDisposed then return end
	for index,friendId in ipairs(self.curAreaFriendIds) do
		if self.friendItems[index] then
			self.friendItems[index]:setFriend(friendId)
		end
	end

	-- --------------------------------
	-- Update BuyAndContinueButton State
	-- -------------------------------
	if #self.curAreaFriendIds >= 3 then

		local askFriendBtnLabelKey	= "unlock.cloud.panel.use.friend.unlock"
		local askFriendBtnLabelValue	= Localization:getInstance():getText(askFriendBtnLabelKey, {})
		self.askFriendBtn:setString(askFriendBtnLabelValue)
		self.askFriendBtn:setColorMode(kGroupButtonColorMode.green)
	end
end

function UnlockCloudPanel:getAgreedFriendIds(...)
	assert(#{...} == 0)

	local function onHttpFinished()

		local unlockFriendInfos = UserManager:getInstance().unlockFriendInfos
		assert(unlockFriendInfos)

		-- Get Current Area 's Friend Ids
		for k,v in pairs(unlockFriendInfos) do
			if v.id == self.lockedCloudId then
				self.curAreaFriendIds = v.friendUids
				self:updateView()
				break
			else

			end
		end
	end

	local http = GetUnlockFriendHttp.new()
	http:addEventListener(Events.kComplete, onHttpFinished)
	http:load()
end

function UnlockCloudPanel:popout(animFinishCallback, ...)
	assert(animFinishCallback == false or type(animFinishCallback) == "function")
	assert(#{...} == 0)

	self.allowBackKeyTap = true

	PopoutManager:sharedInstance():addWithBgFadeIn(self, true, false, false)
	self:setToScreenCenterVertical()
	self:setToScreenCenterHorizontal()
	self:tryShowGuide()
end

function UnlockCloudPanel:setToScreenCenterHorizontal(...)
	assert(#{...} == 0)

	local visibleSize	= CCDirector:sharedDirector():getVisibleSize()
	local visibleOrigin	= CCDirector:sharedDirector():getVisibleOrigin()
	local selfWidth		= 631.6

	local deltaWidth	= visibleSize.width - selfWidth
	local halfDeltaWidth	= deltaWidth / 2
	local hCenterXInScreen = visibleOrigin.x + halfDeltaWidth

	local parent		= self:getParent()
	assert(parent)

	local posXInParent	= parent:convertToNodeSpace(ccp(hCenterXInScreen, 0))
	self:setPositionX(posXInParent.x)
end

function UnlockCloudPanel:remove(animFinishCallback, ...)
	assert(animFinishCallback == false or type(animFinishCallback) == "function")
	assert(#{...} == 0)

	if not self.isDisposed then 
		PopoutManager:sharedInstance():removeWithBgFadeOut(self, animFinishCallback, true)
		self:tryRemoveGuide()
	end
	if self.closeCallback then
		self.closeCallback()
	end
end

function UnlockCloudPanel:create(lockedCloudId, totalStar, neededStar, cloudCanOpenCallback, ...)
	assert(type(lockedCloudId) == "number")
	assert(type(totalStar) == "number")
	assert(type(neededStar) == "number")
	assert(type(cloudCanOpenCallback) == "function")
	assert(#{...} == 0)

	local newUnlockCloudPanel = UnlockCloudPanel.new()
	newUnlockCloudPanel:loadRequiredResource(PanelConfigFiles.unlock_cloud_panel_new)
	newUnlockCloudPanel.ui = newUnlockCloudPanel:buildInterfaceGroup('unlockCloudPanelNew')
	newUnlockCloudPanel:init(lockedCloudId, totalStar, neededStar, cloudCanOpenCallback)
	return newUnlockCloudPanel
end

function UnlockCloudPanel:onMoreStarBtnTapped()
	self:onCloseBtnTapped()
	local panel = MoreStarPanel:create()
	panel:popout()
end

function UnlockCloudPanel:tryShowGuide()
	local hasFirstPopout = CCUserDefault:sharedUserDefault():getBoolForKey('panel.unlockCloud.hasRunGuide')
	if hasFirstPopout then
		return
	end

	local armature = CommonSkeletonAnimation:createTutorialMoveIn2()

	local function animationCallback()
		if self.isDisposed then return end
		self:tryRemoveGuide()
	end
	armature:removeAllEventListeners()
	armature:addEventListener(ArmatureEvents.COMPLETE, animationCallback)

	local askFriend = (FriendManager.getInstance():getFriendCount() >= 3)

	local starBtnWorldPos = self.moreStarBtn:getParent():convertToWorldSpace(self.moreStarBtn:getPosition())
	local friendBtnWorldPos = self.askFriendBtn:getParent():convertToWorldSpace(self.askFriendBtn:getPosition())

	local scene = Director:sharedDirector():getRunningScene()
	if not scene then return end

	scene:addChild(armature)
	self.armature = armature
	if askFriend then
		local pos = ccp(friendBtnWorldPos.x + 140, friendBtnWorldPos.y + 110)
		armature:setPosition(pos)
	else
		local pos = ccp(starBtnWorldPos.x + 140, starBtnWorldPos.y + 110)
		armature:setPosition(pos)
	end


	CCUserDefault:sharedUserDefault():setBoolForKey('panel.unlockCloud.hasRunGuide', true)

end

function UnlockCloudPanel:tryRemoveGuide()
	if self.armature and not self.armature.isDisposed then
		self.armature:removeFromParentAndCleanup(true)
		self.armature = nil
	end
end

function UnlockCloudPanel:onEnterForeGround()
	if self.isDisposed then return end
	if self.onEnterForeGroundCallback and type(self.onEnterForeGroundCallback) == "function" then 
		self.onEnterForeGroundCallback()
	end
end
