require "hecore.class"
require "hecore.utils"
require "zoo.model.LuaXml"
require "zoo.data.DataRef"

local debugDataRef = false
--[[
local allGameMode = 
{
	"Classic moves", 
	"Classic", 
	"Drop down", 
	"Light up", 
	"DigTime", 
	"DigMove", 
	"Order", 
	"DigMoveEndless", 
	"RabbitWeekly",
	"ChristmasEndless",
	"SpringFestivalEndless",
	"MaydayEndless", 
	"WorldCUP",
	"seaOrder", -- attention: 特殊情况 小写字母
    "halloween",
    "Mobile Drop down",
    "Summer_Weekly",
    "HedgehogDigEndless",  --蜗牛无尽挖地
}
]]

--local kGameModeType = {}
--for i,v in ipairs(allGameMode) do kGameModeType[v] = i end
	
--
-- LevelMapManager ---------------------------------------------------------
--
--LevelMapManager = class()

local instance = nil
LevelMapManager = {
}
-- private
local levelMap = nil
local originLevelMap = nil
local kStorageFileName = "levelUpdate.inf"
local kLevelUpdateVersionFileName = "levelUpdateVersion"

function LevelMapManager.getInstance()
	if not instance then instance = LevelMapManager end
	return instance
end

function LevelMapManager:initialize()
	local path = "meta/customize.inf"
	path = CCFileUtils:sharedFileUtils():fullPathForFilename(path)
	local customize = HeFileUtils:decodeFile(path)
	local gameConfigData  = table.deserialize(customize)
	assert(gameConfigData)

	levelMap = {}
	if _G.isCheckPlayModeActive then originLevelMap = {} end
	for i,v in ipairs(gameConfigData) do
		local data = LevelMapMeta.new()
		data:fromLua(v)
		levelMap[data.id] = data

		if _G.isCheckPlayModeActive then 
			local data2 = LevelMapMeta.new()
			data2:fromLua(v)
			originLevelMap[data2.id] = data2
		end
	end

	------------------------
	-- Other Data About Level
	-- ---------------------
	self.hiddenNodeRange = 10000
end


function LevelMapManager:isNormalNode(nodeId, ...)
	assert(type(nodeId) == "number")
	assert(#{...} == 0)

	return tonumber(nodeId) < self.hiddenNodeRange
end

-- 到toLevel的全部主线关最高星级，包含toLevel
function LevelMapManager:getTotalStar(toLevel)
	local ret = 0
	for i=1,toLevel do
		ret = ret + levelMap[i]:getTotalStarNumber()
	end
	return ret
end


function LevelMapManager:getLevelDisplayName(levelId)
	if self:isNormalNode(levelId) then
		return levelId
	else
		return "+" .. (levelId - self.hiddenNodeRange)
	end
end

local function getStorageLevelUpdateConfig()
	local path = HeResPathUtils:getUserDataPath() .. "/" .. kStorageFileName
	local file, err = io.open(path, "r")

	if file and not err then
		local content = file:read("*a")
		io.close(file)
		if content then
			return content
		end
	end
    return nil
end

local function getStorageLevelUpdateConfigVersion()
	local filePath = HeResPathUtils:getUserDataPath() .. "/" .. kLevelUpdateVersionFileName
	local file = io.open(filePath, "rb")
	if file then
		local version = file:read("*a")
		file:close()
		return version
	end
	return nil
end

-- 获取原始关卡信息 类型为LevelMapMeta{id, gameData, score1, score2, score3, score4}
function LevelMapManager:getMeta( levelId )

	if _G.isCheckPlayModeActive then 

		local diffTable = CheckPlay:getCheckPlayDiffTable()
		if diffTable and type(diffTable) == "table" then
			levelMap = {}

			for i, v in pairs(originLevelMap) do
				levelMap[v.id] = v
			end

			for i, v in ipairs(diffTable) do

				local data = LevelMapMeta.new()
				data:fromLua(v)
				levelMap[data.id] = data
			end

			self.levelUpdateVersion = "12345"
		end
	else
		if not self.hasLoadLevelUpdate then
			self.hasLoadLevelUpdate = true
			local storageConfig = getStorageLevelUpdateConfig()
			if storageConfig then
				local path = HeResPathUtils:getUserDataPath() .. "/" .. kStorageFileName
				local decodeContent = HeFileUtils:decodeFile(path)
				if decodeContent and decodeContent ~= "" then
					local jsonContent = table.deserialize(decodeContent)
					if jsonContent and type(jsonContent) == "table" then
						for i, v in ipairs(jsonContent) do
							local data = LevelMapMeta.new()
							data:fromLua(v)
							levelMap[data.id] = data
						end
					end
				end
				self.levelUpdateVersion = getStorageLevelUpdateConfigVersion()
			end
		end
	end

	

	return levelMap[levelId]
end

function LevelMapManager:getLevelUpdateVersion()
	return self.levelUpdateVersion
end

function LevelMapManager:getMaxLevelId( ... )
	-- body
	local result = 1
	for k, v in pairs(levelMap) do 
		if result < k then 
			result = k
		end
	end
	return result
end

function LevelMapManager:addDevMeta( v )
	-- body
	local data = LevelMapMeta.new()
	data:fromLua(v)
	levelMap[data.id] = data

end

function LevelMapManager:getLevelGameMode( levelId )
	if levelId == 0 then return 0 end

	local levelMeta = self:getMeta(levelId)
	if levelMeta then
		local gameData = levelMeta.gameData
		if gameData then
			if LevelType:isSummerMatchLevel( levelId ) then
				return self:getLevelGameModeByName(  GameModeType.SUMMER_WEEKLY )
			else
				return self:getLevelGameModeByName(gameData.gameModeName)
			end
		end
	end
	return nil
end

function LevelMapManager:getLevelGameModeByName( gameModeName )
	local result = getGameModeTypeIdFromModeType(gameModeName)
	if result == nil then
		print("getLevelGameMode", gameModeName, result)
	end
	return result
end

function LevelMapManager:isDigMoveEndlessLevel(levelId)
	return self:getLevelGameMode(levelId) == GamePlayType.kDigMoveEndless
end

function LevelMapManager:isMaydayEndlessLevel(levelId)
	return self:getLevelGameMode(levelId) == GamePlayType.kMaydayEndless
end

function LevelMapManager:isRabbitWeeklyLevel(levelId)
	return self:getLevelGameMode(levelId) == GamePlayType.kRabbitWeekly
end

function LevelMapManager:getAllLevelId()
	local result = {}
	for levelId, __ in pairs(levelMap) do
		table.insert(result, levelId)
	end
	return result
end

function LevelMapManager:getTotalStarNumberByAreaId( areaId )
	-- body
	local result = 0

	for k = (areaId - 1) * 15 + 1, areaId * 15 do 
		result = result + self:getMeta(k):getTotalStarNumber()
	end

	return result
end

--
-- LevelGameData ---------------------------------------------------------
--
LevelGameData = class(DataRef)
function LevelGameData:ctor()
	self.addMoveBase = GamePlayConfig_Add_Move_Base
	self.clearTargetLayers = 0
	self.confidence = 0
	self.digTileMap = {}
	self.digTileSpecialAnimalMap = {}
	self.dropRules = {}
	self.gameModeName = "Order"
	self.moveLimit = 0
	self.numberOfColours = 0
	self.portals = {}
	self.randomSeed = 0
	self.scoreTargets = {0,0,0}
	self.specialAnimalMap = {}
	self.tileMap = {}
	self.seaAnimalMap = {}
	self.seaFlagMap = {}
	self.dropBuff = {}
end

--
-- LevelMapMeta ---------------------------------------------------------
--
LevelMapMeta = class() 
function LevelMapMeta:ctor()
	self.id = 0
	self.score1 = 0
	self.score2 = 0
	self.score3 = 0
	self.score4 = 0

	self.totalLevel = 0
	self.gameData = LevelGameData.new()
end
function LevelMapMeta:getStar( score )
	if self.score4 > self.score3 and score >= self.score4 then return 4
	elseif score >= self.score3 then return 3
	elseif score >= self.score2 then return 2
	elseif score >= self.score1 then return 1
	else return 0 end
end
function LevelMapMeta:fromLua( src )
	if not src then
		print("  [WARNING] lua data is nil")
		return
	end

	for k,v in pairs(src) do
		if k == "gameData" then
			self.gameData:fromLua(v)
		else
			self[k] = v
			if debugDataRef then print(k, v) end
		end		
	end

	assert(self.gameData, "gameData should be non nil")
	self.id = self.totalLevel

	assert(#self.gameData.scoreTargets>2, "scoreTargets should be more then 3")

	self.score1 = self.gameData.scoreTargets[1]
	self.score2 = self.gameData.scoreTargets[2]
	self.score3 = self.gameData.scoreTargets[3]

	if #self.gameData.scoreTargets == 4 then
		self.score4 = self.gameData.scoreTargets[4]
	else
		self.score4 = 0
	end


	if debugDataRef then print(self.id, self.score1, self.score2, self.score3, self.score4) end
end

function LevelMapMeta:getTotalStarNumber( ... )
	-- body
	return #self.gameData.scoreTargets
end
