require "zoo.panel.PanelWithRankList"
require "zoo.config.ui.StartGamePanelConfig"
require "zoo.panel.basePanel.panelAnim.PanelWithRankExchangeAnim"
require "zoo.panel.component.startGamePanel.LevelInfoPanel"
require "zoo.mission.panels.MissionBugOnLevelInfoPanel"
-- require "zoo.panel.rabbitWeekly.RabbitWeeklyLevelInfoPanel"
-- require "zoo.panel.weeklyRace.WeeklyRaceLevelInfoPanel"

---------------------------------------------------
-------------- StartGamePanel
---------------------------------------------------

assert(not StartGamePanel)
assert(PanelWithRankList)

StartGamePanel = class(PanelWithRankList)

function StartGamePanel:init(levelId, levelType, ...)
	assert(type(levelId) == "number")
	assert(#{...} == 0)

	self.hiddenRankList = false

	-- 确认是否使用特殊活动UI，为了搜索方便使用完全相同的变量名
	local useSpecialActivityUI = WorldSceneShowManager:getInstance():isInAcitivtyTime() and
		(levelType == GameLevelType.kMainLevel or levelType == GameLevelType.kHiddenLevel)

	-------------------
	-- Get Data About UI
	-- --------------------
	self.levelId 		= levelId
	self.levelType 		= levelType
	self.resourceManager	= ResourceManager:sharedInstance()
	self.hiddenRankList = self:isNeedHideRankList(levelId, levelType)
	self.levelInfoPanel	= self:createLevelInfoPanel(levelId, levelType, useSpecialActivityUI)

	local panelPosYOffset = 0
	if levelType == GameLevelType.kRabbitWeekly then
		panelPosYOffset = 50 -- 兔子周赛开始面板需要向上偏移一定距离
	end

	---------------------------
	-- Data About LevelInfoPanel
	-- ------------------------
	local size = self.levelInfoPanel:getGroupBounds().size

	-- ---------------
	-- Init Base Class
	-- ---------------
	PanelWithRankList.init(self, self.levelId, self.levelType, self.levelInfoPanel, "startGamePanel", useSpecialActivityUI)

	--self.selfWidth = 713.95

	--------------------------------
	-- Create Show / Hide Animation
	-- -------------------------------
	local topPanel	= self:getTopPanel()
	local rankList	= self:getRankList()

	if HomeScene:sharedInstance().worldScene:checkMissionBubbleShow(levelId) then
		--local wave = Sprite:createWithSpriteFrameName("wave_level_1_0001")
		--FrameLoader:loadImageWithPlist("flash/missionAnime.plist")
		--local missionBug = Sprite:createWithSpriteFrameName("mission_bug_on_level_info_panel")

		local missionBug = MissionBugOnLevelInfoPanel:create(self.levelId)

		--local targetDesLabelPosition = self.targetDesLabel:getPosition()
		--self.ui:convertToWorldSpace( ccp( self.itemIcon:getPosition().x , self.itemIcon:getPosition().y) )
		
		--missionBug:setPosition( ccp( rankListInitX + 580 , rankListInitY - 180 ) )
		missionBug:setPosition( ccp( 600 , -600 ) )
		missionBug:setScale(1)
		self.missionBug = missionBug
		topPanel:addChild(missionBug)
	end

	self.exchangeAnim = PanelWithRankExchangeAnim:create(self, topPanel, rankList)
	--self.

	------------------------------------
	-- Get Data About Top Panel  / Rank List
	-- ----------------------------------
	local topPanelHeight = topPanel:getGroupBounds().size.height
	local rankListHeight = rankList:getGroupBounds().size.height

	-------------------------------------------------
	--- Set Top Panel And Rank List Initial Position
	-------------------------------------------------
	-- Get Config From PanelConfig.lua
	local config = StartGamePanelConfig:create(self)
	
	-- Top Panel Init X,Y And Expanded X,Y
	local topPanelInitX = config:topPanelInitX()
	local topPanelInitY = config:topPanelInitY() + panelPosYOffset

	self:setTopPanelInitPos(topPanelInitX, topPanelInitY)			-- This Control Drag Rank List Panel

	local topPanelExpanX	= config:topPanelExpanX()
	local topPanelExpanY	= config:topPanelExpanY() + panelPosYOffset
	self:setTopPanelExpanPos(topPanelExpanX, topPanelExpanY)

	-- Rank List Init X,Y And Expanded X,Y
	local rankListInitX	= config:rankListInitX()
	local rankListInitY	= config:rankListInitY()

	self:setRankListInitPos(rankListInitX, rankListInitY)

	local rankListExpanX	= config:rankListExpanX()
	local rankListExpanY	= config:rankListExpanY()
	self:setRankListExpanPos(rankListExpanX, rankListExpanY)

	------------------------------------
	-- Config Show / Hide Animation
	-- ------------------------------
	self.exchangeAnim:setTopPanelShowPos(topPanelInitX, topPanelInitY)
	self.exchangeAnim:setTopPanelHidePos(topPanelInitX, topPanelHeight)

	self.exchangeAnim:setRankListPopShowPos(rankListInitX, rankListInitY)
	self.exchangeAnim:setRankListPopHidePos(rankListInitX, topPanelInitY - topPanelHeight + rankListHeight + 100)

	--------------------
	-- Event Callback
	-- ----------------
	self.onClosePanelCallback	= false
	self.popoutAnimFinishCallback	= false

	---------------------------------------
	--  Scale According To Screen Resolution
	--  -------------------------------------
	self:scaleAccordingToResolutionConfig()
	--self:setToScreenCenterHorizontal()
end

function StartGamePanel:createLevelInfoPanel(levelId, levelType, useSpecialActivityUI)
	local infoPanel = nil
	if levelType == GameLevelType.kDigWeekly then
		infoPanel = WeeklyRaceLevelInfoPanel:create(self, levelId)
	-- elseif levelType == GameLevelType.kRabbitWeekly then
	-- 	infoPanel = RabbitWeeklyLevelInfoPanel:create(self, levelId)
	else 
		infoPanel = LevelInfoPanel:create(self, levelId, levelType, useSpecialActivityUI)
	end
	return infoPanel
end

function StartGamePanel:isNeedHideRankList( levelId, levelType )
	if levelType == GameLevelType.kTaskForUnlockArea then 
		return true
	else
		return false
	end
end

function StartGamePanel:setOnClosePanelCallback(callback, ...)
	assert(type(callback) == "function")
	assert(#{...} == 0)

	self.onClosePanelCallback = callback
end

function StartGamePanel:setPopoutAnimFinishCallback(animFinish, ...)
	assert(type(animFinish) == "function")
	assert(#{...} == 0)

	self.popoutAnimFinishCallback = animFinish
end

function StartGamePanel:popout(animFinishCallback, ...)
	assert(animFinishCallback == false or type(animFinishCallback) == "function")
	assert(#{...} == 0)

	local function onPopoutAnimFinished()
		self:setRankListPanelTouchEnable()
		if animFinishCallback then
			animFinishCallback()
		end

		self.allowBackKeyTap = true
		if self.levelInfoPanel and self.levelInfoPanel.afterPopout then
			self.levelInfoPanel:afterPopout()
		end

		if self.useSpecialActivityUI then
			local size = self.rankListPanelClipping:getContentSize()
			self.rankListPanelClipping:setContentSize(CCSizeMake(size.width, size.height + 300))
		end

		if self.popoutAnimFinishCallback then
			self.popoutAnimFinishCallback()
		end
		he_log_info("auto_test_tap_level")
	end

	self.exchangeAnim:popout(onPopoutAnimFinished)
end

function StartGamePanel:popoutWithoutBgFadeIn(animFinishCallback, ...)
	assert(false == animFinishCallback or type(animFinishCallback) == "function")
	assert(#{...} == 0)

	local function callback()
		self:setRankListPanelTouchEnable()

		if animFinishCallback then
			animFinishCallback()
		end

		if self.popoutAnimFinishCallback then
			self.popoutAnimFinishCallback()
		end
	end

	self.exchangeAnim:popoutWithoutBgFadeIn(callback)
end

function StartGamePanel:remove(animFinishCallback, ...)
	assert(animFinishCallback == false or type(animFinishCallback) == "function")
	assert(#{...} == 0)

	local function callback()
		if animFinishCallback then
			animFinishCallback()
		end
	end

	self:removeRankListPanelSceneListener()
	self.exchangeAnim:remove(callback)

	if self.missionBug and self.missionBug:getParent() then
		self.missionBug:removeFromParentAndCleanup(true)
	end
end

function StartGamePanel:removeWhileKeepBackground(animFinishCallback, ...)
	assert(false == animFinishCallback or type(animFinishCallback) == "function")
	assert(#{...} == 0)

	local function callback()
		if animFinishCallback then
			animFinishCallback()
		end
	end

	self:removeRankListPanelSceneListener()
	self.exchangeAnim:removeWhileKeepBackground(callback)
end

function StartGamePanel:show(animFinishCallbck, ...)
	assert(animFinishCallbck == false or type(animFinishCallbck) == "function")
	assert(#{...} == 0)

	local function onShowAnimFinish()
		self:setRankListPanelTouchEnable()
		if animFinishCallbck then
			animFinishCallbck()
		end
	end

	self.exchangeAnim:show(onShowAnimFinish)
end

function StartGamePanel:hide(animFinishCallbck, ...)
	assert(animFinishCallbck == false or type(animFinishCallbck) == "function")
	assert(#{...} == 0)
	self:setRankListPanelTouchDisable()
	self.exchangeAnim:hide(animFinishCallbck)
end

function StartGamePanel:changeToEnergyNotEnoughPanel(energyPanelContinuCallback, energyPanelCloseCallback, ...)
	print("StartGamePanel:changeToEnergyNotEnoughPanel", energyPanelCloseCallback)
	assert(energyPanelContinuCallback == false or type(energyPanelContinuCallback) == "function")
	assert(false == energyPanelCloseCallback or type(energyPanelCloseCallback) == "function")
	assert(#{...} == 0)

	print("energyPanelCloseCallback", energyPanelCloseCallback)

	self:removeWhileKeepBackground(false) 

	-- Delay Popout Energy Panel
	local delay = CCDelayTime:create(0.4)

	local function delayCallFunc()

		-- Create Energy Panel
		local energyPanel = EnergyPanel:create(energyPanelContinuCallback)

		-- -- Set On Close Callback
		-- if energyPanelCloseCallback then
		-- 	energyPanel:setOnClosePanelCallback(energyPanelCloseCallback)
		-- end

		-- if self.onClosePanelCallback then
		-- 	energyPanel:setOnClosePanelCallback(self.onClosePanelCallback)
		-- end

		local function onCloseCallback(isCloseBtnClick)
			if energyPanelCloseCallback then energyPanelCloseCallback() end
			if self.onClosePanelCallback then self.onClosePanelCallback() end

			if isCloseBtnClick and Director.sharedDirector():getRunningScene() == HomeScene:sharedInstance() then 
				PushActivity:sharedInstance():onEnergyNotEnough(function( info )
					ActivityData.new(info):start(false)
				end)
			end
		end
		energyPanel:setOnClosePanelCallback(onCloseCallback)

		energyPanel:popoutWithoutBgFadeIn(false)
	end
	local delayCallAction = CCCallFunc:create(delayCallFunc)

	-- Seq
	local seq = CCSequence:createWithTwoActions(delay, delayCallAction)

	local scene = Director:sharedDirector():getRunningScene()
	scene:runAction(seq) 
end

function StartGamePanel:onCloseBtnTapped(...)
	assert(#{...} == 0)
	self.levelInfoPanel:onCloseBtnTapped()
end

function StartGamePanel:setReplayCallback(replayStartGameCallback)
	self.replayStartGameCallback = replayStartGameCallback
end

--override
function StartGamePanel:reBecomeTopPanel()
	PanelWithRankList.reBecomeTopPanel(self)
	print("StartGamePanel:reBecomeTopPanel Called !")

	if self.tipPanelContainer then 
		self:setRankListPanelTouchDisable()
	else
		self:setRankListPanelTouchEnable()
	end
end

--local instance = nil
function StartGamePanel:create(levelId, levelType, ...)
	assert(type(levelId) == "number")
	assert(type(levelType) == "number")
	assert(#{...} == 0)

	--if instance and not instance.isDisposed then return instance end

	local newStartGamePanel = StartGamePanel.new()

	print("StartGamePanel:create", levelId, levelType)
	newStartGamePanel:init(levelId, levelType)

	--instance = newStartGamePanel
	return newStartGamePanel
end

