LevelConstans = table.const{
	MAIN_LEVEL_ID_START = 0,
	MAIN_LEVEL_ID_END = 9999,
	HIDE_LEVEL_ID_START = 10000,
	HIDE_LEVEL_ID_END = 19999,
	DIGGER_MATCH_LEVEL_ID_START = 20000,
	DIGGER_MATCH_LEVEL_ID_END = 29999,
	-- RABBIT_MATCH_LEVEL_ID_START = 30000,
	-- RABBIT_MATCH_LEVEL_ID_END = 39999,
	RABBIT_MATCH_LEVEL_ID_START = 160000,
	RABBIT_MATCH_LEVEL_ID_END = 169999,
	MAYDAY_ENDLESS_LEVEL_ID_START = 150000,
	MAYDAY_ENDLESS_LEVEL_ID_END = 151000,
	RECALL_TASK_LEVEL_ID_START = 170000,
	RECALL_TASK_LEVEL_ID_END = 179999,
	TASK_FOR_UNLOCK_AREA_START = 200000,
	TASK_FOR_UNLOCK_AREA_END = 209999,
	SUMMER_MATCH_LEVEL_ID_START = 230000,
	SUMMER_MATCH_LEVEL_ID_END = 239999,
	QIXI2015_LEVEL_ID_START = 250000,
	QIXI2015_LEVEL_ID_END = 259999,
	NATIONAL_DAY_LEVEL_ID_START = 260000,
	NATIONAL_DAY_LEVEL_ID_END = 269999,
	WUKONG_LEVEL_ID_START = 270000,
	WUKONG_LEVEL_ID_END = 279999,
}

StageModeConstans = table.const{
	STAGE_MODE_NORMAL = 0,
	STAGE_MODE_PVP = 1,
	STAGE_MODE_HIDE_AREA = 2,
	STAGE_MODE_DIGGER_MATCH = 3,
	STAGE_MODE_RABBIT_MATCH = 4
}

GameLevelType = {
	kQixi 			= 1,
	kMainLevel 		= 2,
	kHiddenLevel 	= 3,
	kDigWeekly		= 4,
	kMayDay			= 5,
	kRabbitWeekly	= 6,
	kTaskForRecall  = 8,
	kTaskForUnlockArea = 9,
	kSummerWeekly 	= 10,
	kWukong 	= 11,
}

LevelType = class()

function LevelType:isMainLevel( levelId )
	if levelId > LevelConstans.MAIN_LEVEL_ID_START and levelId <= LevelConstans.MAIN_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isHideLevel( levelId )
	if levelId > LevelConstans.HIDE_LEVEL_ID_START and levelId <= LevelConstans.HIDE_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isDiggerMatchLevel( levelId )
	if levelId > LevelConstans.DIGGER_MATCH_LEVEL_ID_START and levelId <= LevelConstans.DIGGER_MATCH_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isRabbtiMatchLevel( levelId )
	if levelId > LevelConstans.RABBIT_MATCH_LEVEL_ID_START and levelId <= LevelConstans.RABBIT_MATCH_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isMaydayEndlessLevel( levelId )
	if levelId > LevelConstans.MAYDAY_ENDLESS_LEVEL_ID_START and levelId <= LevelConstans.MAYDAY_ENDLESS_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isRecallTaskLevel( levelId )
	if levelId > LevelConstans.RECALL_TASK_LEVEL_ID_START and levelId <= LevelConstans.RECALL_TASK_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isQixi2015Level( levelId )
	if levelId > LevelConstans.QIXI2015_LEVEL_ID_START and levelId <= LevelConstans.QIXI2015_LEVEL_ID_END then return true
	else return false end
end

function LevelType:isNationalDayLevel(levelId)
	if levelId > LevelConstans.NATIONAL_DAY_LEVEL_ID_START and levelId <= LevelConstans.NATIONAL_DAY_LEVEL_ID_END then
		return true
	end
	return false
end

function LevelType:isUnlockAreaTaskLevel( levelId )
	-- body
	if levelId > LevelConstans.TASK_FOR_UNLOCK_AREA_START and levelId <= LevelConstans.TASK_FOR_UNLOCK_AREA_END then
		return true
	else
		return false
	end
end



function LevelType:isSummerMatchLevel( levelId )
	return levelId > LevelConstans.SUMMER_MATCH_LEVEL_ID_START and levelId <= LevelConstans.SUMMER_MATCH_LEVEL_ID_END 
end

function LevelType:isWukongLevel( levelId )
	return levelId > LevelConstans.WUKONG_LEVEL_ID_START and levelId <= LevelConstans.WUKONG_LEVEL_ID_END 
end

function LevelType:getLevelTypeByLevelId( levelId )
	if LevelType:isMainLevel(levelId) then
		return GameLevelType.kMainLevel
	elseif LevelType:isHideLevel(levelId) then
		return GameLevelType.kHiddenLevel
	elseif LevelType:isDiggerMatchLevel(levelId) then
		return GameLevelType.kDigWeekly
	elseif LevelType:isMaydayEndlessLevel(levelId) then 
		return GameLevelType.kMayDay
	elseif LevelType:isRabbtiMatchLevel(levelId) then
		return GameLevelType.kRabbitWeekly
	elseif LevelType:isRecallTaskLevel(levelId) then
		return GameLevelType.kTaskForRecall
	elseif LevelType:isUnlockAreaTaskLevel(levelId) then
		return GameLevelType.kTaskForUnlockArea
	elseif LevelType:isSummerMatchLevel(levelId) then
		return GameLevelType.kSummerWeekly
	elseif LevelType:isQixi2015Level(levelId) then
		return GameLevelType.kMayDay
	elseif LevelType:isNationalDayLevel(levelId) then
		return GameLevelType.kMayDay
	elseif LevelType:isWukongLevel(levelId) then
		return GameLevelType.kWukong
	else
		assert(false, 'unknown level type:levelId='..tostring(levelId))
	end
end

function LevelType.isShowRankList( levelType )
	if _isQixiLevel then return false end
	if levelType == GameLevelType.kMayDay 
		or levelType == GameLevelType.kTaskForRecall
		or levelType == GameLevelType.kTaskForUnlockArea 
		or levelType == GameLevelType.kWukong then
		return false
	end
	return true
end

function LevelType.isShareEnable( levelType )
	return levelType == GameLevelType.kMainLevel
		or levelType == GameLevelType.kHiddenLevel
end

function LevelType.isNeedUploadOpLog( levelType )
	return levelType == GameLevelType.kMainLevel
		or levelType == GameLevelType.kHiddenLevel
end
