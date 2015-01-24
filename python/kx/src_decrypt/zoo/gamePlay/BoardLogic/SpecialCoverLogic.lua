--------特效覆盖引起的各种逻辑----------

SpecialCoverLogic = class{}

-----在某个位置引起了特效消除-----减除冰层，减除牢笼，减除雪花等等效果
-- covertype : 1: 上下影响  2：左右影响  3：四周影响
function SpecialCoverLogic:SpecialCoverAtPos(mainLogic, r, c, covertype, scoreScale, actId)
	-----成功消除时候会影响周围的东西
	if SpecialCoverLogic:canEffectAround(mainLogic, r, c) then
		if covertype == 1 then
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r - 1, c)		--上下
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r + 1, c)
		elseif covertype == 2 then
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r , c - 1)		--左右
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r , c + 1)
		elseif covertype == 3 then
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r - 1, c)		--四方
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r + 1, c)
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r , c - 1)
			SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r , c + 1)
		end
	end

	if SpecialCoverLogic:canBeEffectBySpecialAt(mainLogic, r, c) then
		SpecialCoverLogic:effectBlockerAt(mainLogic, r, c, scoreScale, actId)
	end
end

function SpecialCoverLogic:SpecialCoverLightUpAtPos(mainLogic, r, c, scoreScale, canEffectCoin)
	if SpecialCoverLogic:canEffectLightUpAt(mainLogic, r, c, canEffectCoin) then
		SpecialCoverLogic:doEffectLightUpAtPos(mainLogic, r, c, scoreScale)
	end
end

function SpecialCoverLogic:canEffectLightUpAt(mainLogic, r, c, canEffectCoin)
	if not mainLogic:isPosValid(r, c) then
		return false
	end
	local board = mainLogic.boardmap[r][c];
	local item = mainLogic.gameItemMap[r][c]
	if board.iceLevel > 0 then
		if item and item.isUsed and not item.isBlock and not item:hasFurball() and not item:hasLock() and not item.isEmpty then
			if item.ItemType == GameItemType.kCoin and not canEffectCoin then 
				return false
			else
				return true
			end
		end
	end 
	return false
end


----可以被此处的Special影响到---
function SpecialCoverLogic:canBeEffectBySpecialAt(mainLogic, r, c)
	if not mainLogic:isPosValid(r, c) then return false end

	local item = mainLogic.gameItemMap[r][c];
	if item.isReverseSide then return false end
	if item:hasLock()
		or item.snowLevel > 0
		or item.venomLevel > 0
		or item.ItemType == GameItemType.kRoost
		or item:hasFurball()
		or item.digGroundLevel > 0
		or item.digJewelLevel > 0 
		or item.bigMonsterFrostingStrength > 0
		or item.ItemType == GameItemType.kBlackCuteBall
		or item.ItemType == GameItemType.kMimosa 
		or item.beEffectByMimosa
		or item.ItemType == GameItemType.kBoss
		or item.ItemType == GameItemType.kHoneyBottle
		then
		return true;
	end

	return false;
end

----是否可以引起周围的消除----
function SpecialCoverLogic:canEffectAround(mainLogic, r, c)
	if mainLogic.gameItemMap[r] and mainLogic.gameItemMap[r][c] then
		if mainLogic.gameItemMap[r][c]:isColorful() 
			and not mainLogic.gameItemMap[r][c]:hasLock()
			and not mainLogic.gameItemMap[r][c]:hasFurball()
			and mainLogic.gameItemMap[r][c]:isAvailable()
			then 
			return true
		end
	end
	return false
end

function SpecialCoverLogic:tryEffectSpecialAround(mainLogic, r, c)
	if not mainLogic:isPosValid(r, c) then return end

	if SpecialCoverLogic:canBeEffectBySpecialCoverAnimalAround(mainLogic, r, c) then
		SpecialCoverLogic:effectBlockerAt(mainLogic, r, c, 1)
	end
end

----可以被周围的SpecialCoverAnimal<特效消除小动物>影响到----
function SpecialCoverLogic:canBeEffectBySpecialCoverAnimalAround(mainLogic, r, c)
	if not mainLogic:isPosValid(r, c) then return false end

	local item = mainLogic.gameItemMap[r][c]
	local board = mainLogic.boardmap[r][c]

	if not item:isAvailable() then return false end

	if item 
		and (item.ItemType == GameItemType.kVenom 
		or item.ItemType == GameItemType.kDigGround
		or item.ItemType == GameItemType.kDigJewel)
		or item.honeyLevel > 0 
		-- or item.ItemType == GameItemType.kBlackCuteBall
		then
		return true
	end
	return false
end



function SpecialCoverLogic:doEffectLightUpAtPos(mainLogic, r, c, scoreScale)
	if mainLogic.theGamePlayType ~= GamePlayType.kLightUp
	and mainLogic.theGamePlayType ~= GamePlayType.kSeaOrder then 
		return 
	end

	if not mainLogic:isPosValid(r, c) then 
		return false 
	end

	local item = mainLogic.gameItemMap[r][c]
	local board = mainLogic.boardmap[r][c]

	scoreScale = scoreScale or 1
	if board.iceLevel > 0 then
		----1-1.数据变化
		board.iceLevel = board.iceLevel - 1

		----1-2.分数统计
		local addScore = scoreScale * GamePlayConfig_Score_MatchAt_Ice
		ScoreCountLogic:addScoreToTotal(mainLogic, addScore)

		local ScoreAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemScore_Get,
			IntCoord:create(r,c),				
			nil,				
			1)
		ScoreAction.addInt = addScore
		ScoreAction.addInt2 = 2
		mainLogic:addGameAction(ScoreAction)

		----1-3.播放特效
		local IceAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemMatchAt_IceDec,
			IntCoord:create(r,c),	
			nil,	
			1)
		mainLogic:addGameAction(IceAction)
		item.isNeedUpdate = true
		board.isNeedUpdate = true

		if mainLogic.PlayUIDelegate and mainLogic.gameMode:is(LightUpMode) then
			local pos_t = mainLogic:getGameItemPosInView(r,c);
			local ice_left_count = mainLogic.gameMode:checkAllLightCount(mainLogic)
			mainLogic.PlayUIDelegate:setTargetNumber(0, 0, ice_left_count, pos_t)
		end
	end
end

function SpecialCoverLogic:effectBlockerAt(mainLogic, r, c, scoreScale, actId)
	if r<=0 or r>#mainLogic.boardmap or c<=0 or c>#mainLogic.boardmap[r] then return false end;

	local item = mainLogic.gameItemMap[r][c];
	local board = mainLogic.boardmap[r][c];

	scoreScale = scoreScale or 1
	------1.牢笼变化------
	if item.cageLevel > 0 then
		----1-1.数据变化
		item.cageLevel = item.cageLevel - 1

		-----1-2.分数变化
		local addScore = GamePlayConfig_Score_MatchAt_Lock * scoreScale
		ScoreCountLogic:addScoreToTotal(mainLogic, addScore)
		local ScoreAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemScore_Get,
			IntCoord:create(r,c),				
			nil,				
			1)
		ScoreAction.addInt = addScore
		mainLogic:addGameAction(ScoreAction)

		----1-3.播放特效
		local LockAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemMatchAt_LockDec,
			IntCoord:create(r,c),				
			nil,				
			GamePlayConfig_GameItemSnowDeleteAction_CD)
		mainLogic:addDestroyAction(LockAction)
		item.isNeedUpdate = true
		board.isNeedUpdate = true
	elseif item.honeyLevel > 0 then
		GameExtandPlayLogic:honeyDestroy( mainLogic, r, c, scoreScale )
	end

	----2.检测雪花/毒液消除----
	if item.snowLevel > 0 then
		----1-1.数据变化
		item.snowLevel = item.snowLevel - 1
		if item.snowLevel == 0 then
			item:AddItemStatus(GameItemStatusType.kDestroy)
			SnailLogic:SpecialCoverSnailRoadAtPos( mainLogic, r, c )
			mainLogic:tryDoOrderList(r, c, GameItemOrderType.kSpecialTarget, GameItemOrderType_ST.kSnowFlower, 1) -------记录消除
		end

		----1-2.分数统计
		local addScore = scoreScale * GamePlayConfig_Score_MatchBy_Snow
		ScoreCountLogic:addScoreToTotal(mainLogic, addScore)
		local ScoreAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemScore_Get,
			IntCoord:create(r,c),				
			nil,				
			1)
		ScoreAction.addInt = addScore
		mainLogic:addGameAction(ScoreAction)

		----1-3.播放特效
		local SnowAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemMatchAt_SnowDec,
			IntCoord:create(r,c),				
			nil,				
			GamePlayConfig_GameItemSnowDeleteAction_CD)
		SnowAction.addInt = item.snowLevel + 1
		mainLogic:addDestroyAction(SnowAction)
	elseif item.venomLevel > 0 then
		item.venomLevel = item.venomLevel - 1
		SnailLogic:SpecialCoverSnailRoadAtPos( mainLogic, r, c )
		mainLogic:tryDoOrderList(r, c, GameItemOrderType.kSpecialTarget, GameItemOrderType_ST.kVenom, 1) -------记录消除
		local addScore = scoreScale * GamePlayConfig_Score_MatchBy_Snow
		ScoreCountLogic:addScoreToTotal(mainLogic, addScore)

		local ScoreAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemScore_Get,
			IntCoord:create(r, c),
			nil,
			1)
		ScoreAction.addInt = addScore
		mainLogic:addGameAction(ScoreAction)

		local VenomAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemMatchAt_VenowDec,
			IntCoord:create(r, c),
			nil,
			GamePlayConfig_GameItemBlockerDeleteAction_CD)
		mainLogic:addDestroyAction(VenomAction)
		mainLogic.gameItemMap[r][c]:AddItemStatus(GameItemStatusType.kDestroy)
	elseif item.ItemType == GameItemType.kRoost then
		local roostLevel = item.roostLevel
		item:roostUpgrade()
		local times = item.roostLevel - roostLevel
		if times > 0 then
			local scoreTotal = times * GamePlayConfig_Score_Roost
			ScoreCountLogic:addScoreToTotal(mainLogic, scoreTotal)

			local ScoreAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItemScore_Get,
				IntCoord:create(r, c),
				nil,
				1)
			ScoreAction.addInt = scoreTotal
			mainLogic:addGameAction(ScoreAction)
			
			local UpgradeAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItem_Roost_Upgrade,
				IntCoord:create(r, c),
				nil,
				1)
			UpgradeAction.addInt = times
			mainLogic:addDestroyAction(UpgradeAction)
		end
	elseif item.digGroundLevel > 0 then
		if item.digBlockCanbeDelete then
			item.digBlockCanbeDelete = false
			GameExtandPlayLogic:decreaseDigGround(mainLogic, r, c,scoreScale)
		end
	elseif item.digJewelLevel > 0 then
		if item.digBlockCanbeDelete then
			item.digBlockCanbeDelete = false
			GameExtandPlayLogic:decreaseDigJewel(mainLogic, r, c, scoreScale)
		end
	elseif item.bigMonsterFrostingType > 0 then 
		local addScore = scoreScale * GamePlayConfig_Score_MatchBy_Snow
		ScoreCountLogic:addScoreToTotal(mainLogic, addScore)

		local ScoreAction = GameBoardActionDataSet:createAs(
			GameActionTargetType.kGameItemAction,
			GameItemActionType.kItemScore_Get,
			IntCoord:create(r, c),
			nil,
			1)
		ScoreAction.addInt = addScore
		mainLogic:addGameAction(ScoreAction)

		if item.bigMonsterFrostingStrength > 0 then 
			item.bigMonsterFrostingStrength = item.bigMonsterFrostingStrength - 1
			local decAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItem_Monster_frosting_dec,
				IntCoord:create(r, c),
				nil,
				GamePlayConfig_MaxAction_time)
			mainLogic:addDestroyAction(decAction)
		end
	elseif item.ItemType == GameItemType.kBlackCuteBall then
		if item.blackCuteStrength > 0 then 

			item.blackCuteStrength = item.blackCuteStrength - 1
			if item.blackCuteStrength == 0 then 
				item:AddItemStatus(GameItemStatusType.kDestroy)
				SnailLogic:SpecialCoverSnailRoadAtPos( mainLogic, r, c )
			end
			
			ScoreCountLogic:addScoreToTotal(mainLogic, GamePlayConfig_Score_MatchAt_BlackCuteBall)
			local ScoreAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItemScore_Get,
				IntCoord:create(r, c),
				nil,
				1)
			ScoreAction.addInt = GamePlayConfig_Score_MatchAt_BlackCuteBall
			mainLogic:addGameAction(ScoreAction)
			--add todo
			local blackCuteAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItem_Black_Cute_Ball_Dec,
				IntCoord:create(r, c),
				nil,
				GamePlayConfig_MaxAction_time)
			blackCuteAction.blackCuteStrength = item.blackCuteStrength
			mainLogic:addDestroyAction(blackCuteAction)
		end
	elseif item.ItemType == GameItemType.kMimosa or item.beEffectByMimosa then
		GameExtandPlayLogic:backMimosa(mainLogic, r, c )
	elseif item.ItemType == GameItemType.kBoss  then
		GameExtandPlayLogic:MaydayBossLoseBlood(mainLogic, r, c, false, actId)
	elseif item.honeyBottleLevel > 0 and item.honeyBottleLevel <= 3 then
		GameExtandPlayLogic:increaseHoneyBottle(mainLogic, r, c,1, scoreScale)
	end

	--毛球
	if item:hasFurball() then
		if item.furballType == GameItemFurballType.kGrey then
			item.furballLevel = 0
			item.furballType = GameItemFurballType.kNone

			local scoreAdd = GamePlayConfig_Score_Furball * scoreScale

			ScoreCountLogic:addScoreToTotal(mainLogic, scoreAdd)

			local ScoreAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItemScore_Get,
				IntCoord:create(r, c),
				nil,
				1)
			ScoreAction.addInt = scoreAdd
			mainLogic:addGameAction(ScoreAction)

			local FurballAction = GameBoardActionDataSet:createAs(
				GameActionTargetType.kGameItemAction,
				GameItemActionType.kItem_Furball_Grey_Destroy,
				IntCoord:create(r, c),
				nil,
				GamePlayConfig_GameItemGreyFurballDeleteAction_CD)
			mainLogic:addDestroyAction(FurballAction)
			mainLogic:tryDoOrderList(r, c, GameItemOrderType.kSpecialTarget, GameItemOrderType_ST.kGreyCuteBall, 1)
		elseif item.furballType == GameItemFurballType.kBrown then
			if not item.isBrownFurballUnstable then
				item.isBrownFurballUnstable = true
				local FurballAction = GameBoardActionDataSet:createAs(
					GameActionTargetType.kGameItemAction,
					GameItemActionType.kItem_Furball_Brown_Unstable,
					IntCoord:create(r, c),
					nil,
					1)
				mainLogic:addGameAction(FurballAction)	

				local scoreAdd = GamePlayConfig_Score_Furball * scoreScale
				ScoreCountLogic:addScoreToTotal(mainLogic, scoreAdd)
				local ScoreAction = GameBoardActionDataSet:createAs(
					GameActionTargetType.kGameItemAction,
					GameItemActionType.kItemScore_Get,
					IntCoord:create(r, c),
					nil,
					1)
				ScoreAction.addInt = scoreAdd
				mainLogic:addGameAction(ScoreAction)
				mainLogic:tryDoOrderList(r, c, GameItemOrderType.kSpecialTarget, GameItemOrderType_ST.kBrownCuteBall, 1)
			end
		end
	end

	if item.ItemType == GameItemType.kMagicLamp and item.lampLevel > 0 and item:isAvailable() then
		local action = GameBoardActionDataSet:createAs(
                        GameActionTargetType.kGameItemAction,
                        GameItemActionType.kItem_Magic_Lamp_Charging,
                        IntCoord:create(r, c),
                        nil,
                        GamePlayConfig_MaxAction_time
                    )
		action.count = 1
	    mainLogic:addDestroyAction(action)
	end
end