require "zoo.gamePlay.GameBoardData"
require "zoo.gamePlay.GameItemData"
require "zoo.animation.LinkedItemAnimation"
require "zoo.animation.TileCuteBall"
require "zoo.itemView.ItemViewUtils"
require "zoo.gamePlay.GamePlayConfig"
require "zoo.animation.TileCharacter"
require "zoo.animation.TileBird"
require "zoo.animation.TileVenom"
require "zoo.animation.TileCoin"
require "zoo.animation.TileRoost"
require "zoo.animation.TileBalloon"
require "zoo.animation.TileDigJewel"
require "zoo.animation.TileGoldZongZi"
require "zoo.animation.TileDigGround"
require "zoo.animation.TileAddMove"
require "zoo.animation.TilePoisonBottle"
require "zoo.animation.TileBlocker"
require "zoo.animation.TileMonster"
require "zoo.animation.TileMonsterFrosting"
require "zoo.animation.TileBlackCuteBall"
require "zoo.animation.TileMimosa"
require "zoo.animation.TileSnailRoad"
require "zoo.animation.TileSnail"
require "zoo.animation.TileBoss"
require "zoo.animation.TileRabbit"
require "zoo.animation.TileTransDoor"
require "zoo.animation.TileMagicLamp"
require "zoo.animation.TileWukong"
require "zoo.animation.TileWukongTarget"
require "zoo.animation.TileWukongEff"
require "zoo.animation.TileSuperBlocker"
require "zoo.animation.TileHoneyBottle"
require "zoo.animation.TileHoney"
require "zoo.animation.TileAddTime"
require "zoo.animation.TileMagicTile"
require "zoo.animation.TileSand"
require "zoo.animation.TileQuestionMark"
require "zoo.animation.TileChain"
require "zoo.animation.TileMagicStone"
require "zoo.animation.TileMove"
require "zoo.animation.TileBottleBlocker"
require "zoo.animation.Halloween2015.TileHalloweenNewBoss"
require "zoo.animation.TileHedgehogRoad"
require "zoo.animation.TileHedgehog"
require "zoo.animation.TileHedgehogBox"
require "zoo.animation.TileRocket"
require "zoo.animation.TileBeanpod"
require "zoo.animation.TileCrystalStone"
require "zoo.animation.TileTotems"
require "zoo.animation.TileLotus"
require "zoo.animation.TileDrip"
require "zoo.animation.TileSuperCuteBall"

ItemView = class{}

--用来显示地图上物品的基础
--包括地格--包括动物

ItemSpriteTypeNames = table.const
{
	"kNone",
	"kBackground",		-- 地格--------添加层次时请保持这个在最后
	"kMoveTileBackground", -- 移动地格背景
	"kTileBlocker",       -- 翻转地格, 传送带
	"kSuperCuteLowLevel", -- 超级毛球静默
	"kSeaAnimal",         -- 海洋生物
	"kSnailRoad",         --蜗牛轨迹
	"kHedgehogRoad",      --刺猬轨迹
	"kTileHighlightEffect", -- 小金刚爆炸区域地格特效
	"kHedgehogRoadEffect", --刺猬轨迹播放动画
	"kRabbitCaveDown",    --兔子洞穴, 问号爆炸背景光
	"kSand",			    -- 流沙动画
	"kSandMove",			-- 流沙动画
	"kLight",				-- 冰层, 流沙
	"kQuestionMarkDestoryBg", --问号消除背景光 
	"kItemBack",			-- 鸟的特效
	"kLotus_bottom",		-- 草地底层（荷叶）
	"kItemLowLevel",		-- 物品&物品特效--专门用来放置需要出现在顶层的物品及物品特效（例如草地）
	"kItem",				-- 物品--动物
	"kItemShow",			-- 物品特效--某个动物的动画，或者是消除特效qq
	"kMagicTileWater",
	"kDigBlocker",		-- 地块和宝石
	"kItemDestroy",		-- 物品消除特效层---一个雪花	
	"kClipping",			-- 生成口、传送门出口遮罩
	"kEnterClipping",	    -- 传送门入口遮罩
	"kRabbitCaveUp",    --兔子洞穴上层
	"kRope",				-- 绳子
	"kChain",			-- 冰柱
	"kLock",				-- 笼子
	"kFurBall",			-- 毛球
	"kSnail",               --蜗牛，刺猬
	"kHoney",			-- 蜂蜜
	"kBigMonster",       -- 雪怪
	"kLockShow",			-- 笼子消除
	"kSnowShow",			-- 雪花消除
	"kBigMonsterIce",			-- 雪花消除
	"kNormalEffect",     -- 毛球消除，毒液扩散, 雪怪的冰层等
	"kTransClipping",    -- 传送带遮罩
	"kPass",	            -- 通道
	"kTransmissionDoor",  -- 传送带出入口
	"kItemHighLevel",	  -- 物品&物品特效--专门用来放置需要出现在顶层的物品及物品特效（例如猴子,草地）
	"kLotus_top",		-- 草地顶层（荷叶）
	"kSuperCuteHighLevel",	-- 超级毛球活跃
	"kSpecial",			-- 鸟飞行,刷新飞行
	"kRoostFly",			-- 鸡窝飞行,与刷新飞行冲突
	"kSnailMove",       	-- 蜗牛移动，问号爆炸前景光
	"kQuestionMarkDestoryFg", --问号消除前景光 
	"kMagicStoneFire", --魔法石发动动画
	"kDigBlockerBomb",
	"kTileMoveEffect",
	"kBigMonsterFoot",  --雪怪作用时的脚印
	"kCrystalStoneEffect", -- 染色宝宝特效层 for batch
	"kSuperTotemsLight",
	"kSuperTotemsEffect",
	"kLast",			-- 最上层--------添加层次时请保持这个在最前
}

TileHighlightType = table.const {
	kTotems = 1,
}

ItemSpriteType = {}
local itemSpriteIndex = 0
for _,v in ipairs(ItemSpriteTypeNames) do
	ItemSpriteType[v] = itemSpriteIndex
	itemSpriteIndex = itemSpriteIndex + 1
end

-- ItemSpriteType = table.const
-- {
-- 	kNone = 0,
-- 	kBackground = 1,		-- 地格--------添加层次时请保持这个在最后
-- 	kMoveTileBackground = 2, -- 移动地格背景
-- 	kTileBlocker = 3,       -- 翻转地格, 传送带, 海洋生物
-- 	kSnailRoad = 4,         --蜗牛轨迹
-- 	kRabbitCaveDown = 5,    --兔子洞穴, 问号爆炸背景光
-- 	kSand = 6,			    -- 流沙动画
-- 	kSandMove = 7,			-- 流沙动画
-- 	kLight = 8,				-- 冰层, 流沙
-- 	kQuestionMarkDestoryBg = 9, --问号消除背景光 
-- 	kItemBack = 10,			-- 鸟的特效
-- 	kItem = 11,				-- 物品--动物
-- 	kItemShow = 12,			-- 物品特效--某个动物的动画，或者是消除特效qq
-- 	kDigBlocker = 13,		-- 地块和宝石
-- 	kItemDestroy = 14,		-- 物品消除特效层---一个雪花	
-- 	kClipping = 15,			-- 生成口、传送门出口遮罩
-- 	kEnterClipping = 16,	    -- 传送门入口遮罩
-- 	kRabbitCaveUp = 17,    --兔子洞穴上层
-- 	kRope = 18,				-- 绳子
-- 	kChain = 19,			-- 冰柱
-- 	kLock = 20,				-- 笼子
-- 	kFurBall = 21,			-- 毛球, 蜂蜜
-- 	kBigMonster = 22,       -- 雪怪
-- 	kLockShow = 23,			-- 笼子消除
-- 	kSnowShow = 24,			-- 雪花消除
-- 	kNormalEffect = 25,     -- 毛球消除，毒液扩散, 雪怪的冰层等
-- 	kTransClipping = 26,    -- 传送带遮罩
-- 	kPass = 27,	            -- 通道
-- 	kTransmissionDoor = 28,  -- 传送带出入口
-- 	kSpecial = 29,			-- 鸟飞行,刷新飞行
-- 	kRoostFly = 30,			-- 鸡窝飞行,与刷新飞行冲突
-- 	kSnailMove = 31,       	-- 蜗牛移动，问号爆炸前景光
-- 	kQuestionMarkDestoryFg = 32, --问号消除前景光 
-- 	kMagicStoneFire = 33, --魔法石发动动画
-- 	kDigBlockerBomb = 34,
-- 	kTileMoveEffect	= 35,
-- 	kLast = 36,			-- 最上层--------添加层次时请保持这个在最前
-- }

local Max_Item_Y = GamePlayConfig_Max_Item_Y

ItemSpriteItemShowType = table.const
{
	kNone = 0,
	kCharacter = 1,			-- 普通，有颜色
	kBird = 2,				-- 魔力鸟
	kCoin = 3,				-- 银币
	kRabbit = 4,            -- 兔子
}

local boardViewLayers = {
	ItemSpriteType.kMoveTileBackground, 
	ItemSpriteType.kTileBlocker, 
	ItemSpriteType.kSeaAnimal,
	ItemSpriteType.kMagicTileWater,
	ItemSpriteType.kSnailRoad,
	ItemSpriteType.kHedgehogRoad, 
	ItemSpriteType.kHedgehogRoadEffect,
	ItemSpriteType.kRabbitCaveDown, 
	ItemSpriteType.kClipping, 
	ItemSpriteType.kEnterClipping, 
	ItemSpriteType.kRope, 
	ItemSpriteType.kChain, 
	ItemSpriteType.kBigMonster, 
	ItemSpriteType.kBigMonsterIce,
	ItemSpriteType.kSand,
	ItemSpriteType.kLight,
	ItemSpriteType.kLotus_bottom,
	ItemSpriteType.kItemLowLevel,
	ItemSpriteType.kItem, 
	ItemSpriteType.kItemShow,
	ItemSpriteType.kDigBlocker,
	ItemSpriteType.kLock,
	ItemSpriteType.kFurBall,
	ItemSpriteType.kSnail,
	ItemSpriteType.kHoney,
	ItemSpriteType.kPass,
	ItemSpriteType.kItemHighLevel,
	ItemSpriteType.kLotus_top,
	ItemSpriteType.kSuperCuteLowLevel,
	ItemSpriteType.kSuperCuteHighLevel,
	
	-- ItemSpriteType.kNormalEffect,
}

local itemsName = { 
	[AnimalTypeConfig.kBlue] = "horse", 
	[AnimalTypeConfig.kGreen] = "frog", 
	[AnimalTypeConfig.kOrange] = "bear", 
	[AnimalTypeConfig.kPurple] = "cat", 
	[AnimalTypeConfig.kRed] = "fox", 
	[AnimalTypeConfig.kYellow] = "chicken"
}
local kCharacterAnimationTime = 1/30

function ItemView:ctor()
	self.itemSprite = nil		-- 真正的显示对象
	self.itemPosAdd = nil		-- 普通物品的偏移量存储
	self.RopePosAdd = nil		-- 绳子的偏移量存储
	self.x = 0
	self.y = 0
	self.w = 0
	self.h = 0

	self.clippingnode = nil						-- 
	self.enterClippingNode = nil
	self.cl_hoff = 0;
	self.cl_h = 0;

	self.pos_x = 0;		--实际位置
	self.pos_y = 0;

	self.oldData = nil;
	self.oldBoard = nil;
	self.itemShowType = 0;
	self.isNeedUpdate = false;

	self.flyingfromtype = ItemSpriteType.kNone;
end

function ItemView:cleanAllViews( ... )
	self.RopePosAdd = nil		-- 绳子的偏移量存储

	self.clippingnode = nil						-- 
	self.enterClippingNode = nil
	self.cl_hoff = 0;
	self.cl_h = 0;

	self.oldData = nil;
	self.oldBoard = nil;
	self.itemShowType = 0;
	self.isNeedUpdate = false;

	self.flyingfromtype = ItemSpriteType.kNone;

	for k, v in pairs(self.itemSprite) do
		if k ~= ItemSpriteType.kMoveTile and v and v:getParent() then
			v:removeFromParentAndCleanup(true)
		end
	end
	self.itemSprite = {}
	self.itemPosAdd = {}		-- 普通物品的偏移量存储
end

function ItemView.copyDatasFrom(toData, fromData)
	if type(fromData) ~= "table" then return end
	
	toData.w = fromData.w
	toData.h = fromData.h

	toData.itemShowType = fromData.itemShowType
	toData.cl_hoff = fromData.cl_hoff
	toData.cl_h = fromData.cl_h
	toData.flyingfromtype = fromData.flyingfromtype
	toData.itemPosAdd = {}
	for k, v in pairs(fromData.itemPosAdd) do
		toData.itemPosAdd[k] = ccp(v.x, v.y)
	end
	if fromData.oldData then toData.oldData = fromData.oldData:copy() end
	if fromData.oldBoard then toData.oldBoard = fromData.oldBoard:copy() end
end

function ItemView:dispose()
	self.itemSprite = nil
	self.itemPosAdd = nil
	self.RopePosAdd = nil

	self.clippingnode = nil
	self.enterClippingNode = nil
	self.oldData = nil;
	self.oldBoard = nil;
end

function ItemView:create(context)
	local s = ItemView.new()
	s:initView(context)
	return s
end

function ItemView:initView(context)
	self.itemSprite = {}
	self.itemPosAdd = {}
	self.context = context
end

function ItemView:initByBoardData(data)
	if data.isUsed == false then return end -- 不可用，跳过，什么都不显示

	self.oldBoard = data:copy();

	self.x = data.x;
	self.y = data.y;
	self.w = data.w;
	self.h = data.h;

	if data.isProducer then needClipping = true self.cl_hoff = 0 self.cl_h = self.h - 6  end				--生成口，需要裁减
	if data:hasPortal() then needClipping = true self.cl_hoff = 0 self.cl_h = self.h end						--通道，需要裁减

	-- if needClipping then
		--将ClippingNode添加为界面的子节点，当某个物体掉落将要进（出）范围时，添加至ClippingNode，静止时添加至节点
		-- self:buildClippingNode()
	-- end
	if data:isRotationTileBlock() then 
		self.itemSprite[ItemSpriteType.kTileBlocker] = ItemViewUtils:buildTileBlocker(data.reverseCount, data.isReverseSide)
	end

	if data.isRabbitProducer then 
		self:buildRabbitCave()
	end

	if data.sandLevel > 0 then
		self.itemSprite[ItemSpriteType.kSand] = ItemViewUtils:buildSand(data.sandLevel)
	end
	
	if data.iceLevel > 0 then		 --冰
		self.itemSprite[ItemSpriteType.kLight] = ItemViewUtils:buildLight(data.iceLevel, data.gameModeId)
	end

	if data.transType > 0 then
		self:buildTransmisson(data)
	end

	if data.seaAnimalType then
		self.itemSprite[ItemSpriteType.kSeaAnimal] = {}
		self:buildSeaAnimal(data.seaAnimalType)
	end

	if data.isMagicTileAnchor then
		self:buildMagicTile(data)
	end

	if data.isWukongTarget then
		self:buildWukongTarget(data)
	end

	if data.isHalloweenBottle then
		self:buildHalloweenBoss()
	end

	if data.lotusLevel > 0 then
		self:buildLotus(data.lotusLevel)
	end

	if data:hasSuperCuteBall() then
		self:addSuperCuteBall(data.superCuteState)
	end

	if data:hasPortal() then		--通道
		local possImage = nil;
		if data.passType == 1 then
			possImage = LinkedItemAnimation:buildPortalExit();
			self.itemPosAdd[ItemSpriteType.kPass] = ccp(0, self.h * 0.32)
		elseif data.passType == 2 then
			possImage = LinkedItemAnimation:buildPortalEnter();
			self.itemPosAdd[ItemSpriteType.kPass] = ccp(0, -self.h * 0.48)
	    elseif data.passType == 3 then
			possImage = LinkedItemAnimation:buildPortalBoth();
			self.itemPosAdd[ItemSpriteType.kPass] = ccp(0, self.h * 0.51)
		end
		if possImage~=nil then
			self.itemSprite[ItemSpriteType.kPass] = possImage
		end
	end

	if data:hasRope() then		
		local str_H = "WallH.png"
		local str_V = "WallV.png"
		local st_sprite = Sprite:createWithSpriteFrameName(str_H);
		st_sprite:setOpacity(0)
		if data:hasTopRopeProperty() then --上
			local RopeUP = Sprite:createWithSpriteFrameName(str_H);
			RopeUP:setPositionXY(self.w / 2.0 + 5, self.h / 2.0 + 5)
			st_sprite:addChild(RopeUP)
		end
		if data:hasBottomRopeProperty() then --下
			local RopeDown = Sprite:createWithSpriteFrameName(str_H);
			RopeDown:setPositionXY(self.w / 2.0 + 5, -self.h / 2.0 + 7)
			st_sprite:addChild(RopeDown)
		end
		if data:hasLeftRopeProperty() then --左
			local RopeLeft = Sprite:createWithSpriteFrameName(str_V);
			RopeLeft:setPositionXY(5, 5)
			st_sprite:addChild(RopeLeft)
		end
		if data:hasRightRopeProperty() then --右
			local RopeRight = Sprite:createWithSpriteFrameName(str_V);
			RopeRight:setPositionXY(self.w + 4, 5)
			st_sprite:addChild(RopeRight)
		end

		if st_sprite then self.itemSprite[ItemSpriteType.kRope] = st_sprite end
	end

	if data.isMoveTile then
		local bgTexture = nil
		if self.getContainer(ItemSpriteType.kMoveTileBackground) then 
			bgTexture = self.getContainer(ItemSpriteType.kMoveTileBackground).refCocosObj:getTexture()
		end
		self.itemSprite[ItemSpriteType.kMoveTileBackground] =TileMove:createTile(bgTexture, data.isCollector)
	end

	-- chain todo
	if data.y >= self.context.startRowIndex then 
	-- 挖地滚动到地格外面后冰柱不再显示，绳子是做了遮罩，但冰柱为了做batch无法再做遮罩
	-- 由于魔法地格的存在导致上一行的数据可能仍然存在
		self:addChainsView(data)
	end

	self:initSnailRoad(data)
end

function ItemView:buildLotus(lotusLevel)
	self:playLotusAnimation(lotusLevel , "in")
end

function ItemView:createLotusAnimation(currLotusLevel , animationType , layer , noAnimation)

	local resName = ""
	local animeName = ""
	local animeLength = 10

	local spr = nil
	local spr_frames = nil
	local spr_animate = nil

	

	if layer == "bottom" then
		--构建荷叶底层
		if currLotusLevel == 1 then
			if noAnimation then
				resName = "state_1_in_0010"
				spr = Sprite:createWithSpriteFrameName(resName)
			else
				resName = "state_1_".. tostring(animationType) .. "_0001"
				animeName = "state_1_" .. tostring(animationType) .. "_%04d"
				animeLength = 10

				spr = Sprite:createWithSpriteFrameName(resName)
				spr_frames = SpriteUtil:buildFrames(animeName, 1, animeLength)
				spr_animate = SpriteUtil:buildAnimate(spr_frames, 1/24)
				spr:play(spr_animate, 0, 1, nil, false)
			end
		else
			resName = "state_1_in_0010"
			spr = Sprite:createWithSpriteFrameName(resName)
		end
	elseif layer == "top" then
		--构建荷叶顶层
		if currLotusLevel == 2 then
			resName = "state_2_" .. tostring(animationType) .. "_0001"
			animeName = "state_2_" .. tostring(animationType) .. "_%04d"
			if animationType == "in" then 
				animeLength = 16
			elseif animationType == "out" then
				animeLength = 13
			end
		elseif currLotusLevel == 3 then
			resName = "state_3_" .. tostring(animationType) .. "_0001"
			animeName = "state_3_" .. tostring(animationType) .. "_%04d"
			if animationType == "in" then 
				animeLength = 22
			elseif animationType == "out" then
				animeLength = 17
			end
		end
		
		if currLotusLevel > 1 then
			if noAnimation then
				resName = "state_" .. tostring(currLotusLevel) .. "_" .. tostring(animationType) .. "_00" .. tostring(animeLength)
				spr = Sprite:createWithSpriteFrameName(resName)
			else
				spr = Sprite:createWithSpriteFrameName(resName)
				local spr_frames = SpriteUtil:buildFrames(animeName, 1, animeLength)
				local spr_animate = SpriteUtil:buildAnimate(spr_frames, 1/24)
				spr:play(spr_animate, 0, 1, nil, false)
			end
		end
	end

	return spr
end

function ItemView:playLotusAnimation(currLotusLevel , animationType)
	print("RRR    ItemView:playLotusAnimation   " , currLotusLevel , animationType )
	if currLotusLevel < 0 or currLotusLevel > 3 then return end

	local function clearLotus()
		if self.itemSprite[ItemSpriteType.kLotus_bottom] then
			self.itemSprite[ItemSpriteType.kLotus_bottom]:removeFromParentAndCleanup(false)
			self.itemSprite[ItemSpriteType.kLotus_bottom] = nil
		end

		if self.itemSprite[ItemSpriteType.kLotus_top] then
			self.itemSprite[ItemSpriteType.kLotus_top]:removeFromParentAndCleanup(false)
			self.itemSprite[ItemSpriteType.kLotus_top] = nil
		end
	end
	--clearLotus()

	--构建荷叶底层
	--self.itemSprite[ItemSpriteType.kLotus_bottom] = self:createLotusAnimation(currLotusLevel , animationType , "bottom" )
	
	if not self.itemSprite[ItemSpriteType.kLotus_bottom] then
		self.itemSprite[ItemSpriteType.kLotus_bottom] = TileLotus:create(currLotusLevel , animationType , "bottom")
		self.itemSprite[ItemSpriteType.kLotus_bottom]:setPosition( ccp( (self.x - 0.5 ) * self.w , (Max_Item_Y - self.y - 0.5 ) * self.h ) )
	else
		self.itemSprite[ItemSpriteType.kLotus_bottom]:playAnimation(currLotusLevel , animationType , "bottom")
	end
	


	--构建荷叶顶层
	--self.itemSprite[ItemSpriteType.kLotus_top] = self:createLotusAnimation(currLotusLevel , animationType , "top" )
	if not self.itemSprite[ItemSpriteType.kLotus_top] then
		self.itemSprite[ItemSpriteType.kLotus_top] = TileLotus:create(currLotusLevel , animationType , "top")
		self.itemSprite[ItemSpriteType.kLotus_top]:setPosition( ccp( (self.x - 0.5 ) * self.w , (Max_Item_Y - self.y - 0.5 ) * self.h ) )
	else
		self.itemSprite[ItemSpriteType.kLotus_top]:playAnimation(currLotusLevel , animationType , "top")
	end

	local function setItemVisible(isvisible)

		if self.itemSprite[ItemSpriteType.kItem] then
			self.itemSprite[ItemSpriteType.kItem]:setVisible(isvisible)
		end

		if self.itemSprite[ItemSpriteType.kItemShow] then
			self.itemSprite[ItemSpriteType.kItemShow]:setVisible(isvisible)
		end

	end

	if currLotusLevel == 3 and animationType == "in" then
		
		setTimeOut( function () 
				setItemVisible(false)
			end , 22 / 24 )

	elseif currLotusLevel == 3 and animationType == "out" then
		setItemVisible(true)
	end

	if currLotusLevel == 1 and animationType == "out" then
		setTimeOut( function () 
				clearLotus()
			end , 10 / 24 )
	end
	self.isNeedUpdate = true
end

--处理蜗牛轨迹
function ItemView:initSnailRoad( data )
	-- body
	if data:getSnailRoadViewType() then
		local snailRoad
		if data.roadType == TileRoadShowType.kSnail then
			snailRoad = TileSnailRoad:create(data:getSnailRoadViewType(), data:getSnailRoadRotation())
			self.itemSprite[ItemSpriteType.kSnailRoad] = snailRoad
		else
			snailRoad = TileHedgehogRoad:create(data:getSnailRoadViewType(), data:getSnailRoadRotation(), data.hedgeRoadState)
			self.itemSprite[ItemSpriteType.kHedgehogRoad] = snailRoad
		end
		-- snailRoad:setPosition(self:getBasePosition())
	end
end

function ItemView:getBasePosition(x, y)
	local tempX = (x - 0.5 ) * self.w 
	local tempY = (Max_Item_Y - y - 0.5 ) * self.h
	return ccp(tempX, tempY)
end

local needUpdateLayers = {
	ItemSpriteType.kLotus_bottom,
	ItemSpriteType.kItemLowLevel,
	ItemSpriteType.kItem, 
	ItemSpriteType.kLight,
	ItemSpriteType.kItemShow,
	ItemSpriteType.kDigBlocker,
	ItemSpriteType.kFurBall, 
	ItemSpriteType.kHoney,
	ItemSpriteType.kClipping, 
	ItemSpriteType.kEnterClipping,
	ItemSpriteType.kTransClipping,
	ItemSpriteType.kBigMonster,
	ItemSpriteType.kBigMonsterIce,
	ItemSpriteType.kItemHighLevel,
	ItemSpriteType.kLotus_top,
}

function ItemView:getBoardViewTransContainer()
	if not self.boardViewTransContainer then
		self.boardViewTransContainer = self:copyBoardTransData()
	end
	return self.boardViewTransContainer
end

function ItemView:removeBoardViewTranscontainer()
	if self.boardViewTransContainer and not self.boardViewTransContainer.isDisposed then
		self.boardViewTransContainer:removeFromParentAndCleanup(true)
	end
	self.boardViewTransContainer = nil
end

function ItemView:copyBoardTransData()
	local container = Sprite:createEmpty()
	container.items = {}
	container.datas = {}
	ItemView.copyDatasFrom(container.datas, self)
	for v = ItemSpriteType.kNone, ItemSpriteType.kLast do
		if table.exist(boardViewLayers, v) then
			local item = self.itemSprite[v]
			if item then
				container.items[v] = item
				item:removeFromParentAndCleanup(false)
				self.itemSprite[v] = nil
				container:addChild(item)
			end 
		end
	end

	for index, i in ipairs(needUpdateLayers) do
		if container.items[i] ~= nil then
			if self.itemPosAdd[i] ~= nil then	--itemPosAdd，是某些特殊原件的显示偏移量
				if i == ItemSpriteType.kClipping 
					or i == ItemSpriteType.kEnterClipping 
					then
					container.items[i]:setPositionXY(self.itemPosAdd[i].x + self.w / 2, self.h / 2 + self.itemPosAdd[i].y)
				else
					container.items[i]:setPositionXY(self.itemPosAdd[i].x, self.itemPosAdd[i].y)
				end
			else
				if i == ItemSpriteType.kClipping 
					or i == ItemSpriteType.kEnterClipping 
					then
					container.items[i]:setPositionXY(self.w / 2, self.h / 2)
				elseif i == ItemSpriteType.kBigMonster then
					container.items[i]:setPositionXY(0.5 * self.w, - 0.5 * self.h)
				end
			end
		end
	end
	return container
end

--通过面板数据更新Item的位置信息
--forcePos 强制刷新
function ItemView:upDatePosBoardDataPos(data, forcePos)
	if data.isUsed == false then return end -- 不可用，跳过，什么都不显示
	self.x = data.x;
	self.y = data.y;
	self.w = data.w;
	self.h = data.h;


	local tempX = (self.x - 0.5 ) * self.w 
	local tempY = (Max_Item_Y - self.y - 0.5 ) * self.h
	if self.pos_x ~= tempX or self.pos_y ~=tempY or forcePos then
		self.pos_x = tempX;
		self.pos_y = tempY;
		for index, i in ipairs(needUpdateLayers) do
			if self.itemSprite[i] ~= nil then
				if i == ItemSpriteType.kBigMonster then 
					print(tempX + 0.5 * self.w, tempY - 0.5 * self.h)
					print(data.x, data.y, data.w, data.h)
					-- debug.debug()
				end

				if self.itemPosAdd[i] ~= nil then	--itemPosAdd，是某些特殊原件的显示偏移量
					if i == ItemSpriteType.kClipping 
						or i == ItemSpriteType.kEnterClipping 
						then
						self.itemSprite[i]:setPositionXY(self.itemPosAdd[i].x + self.w / 2, self.h / 2 + self.itemPosAdd[i].y)
					else
						self.itemSprite[i]:setPositionXY(tempX + self.itemPosAdd[i].x, tempY + self.itemPosAdd[i].y)
					end
				else
					if i == ItemSpriteType.kClipping 
						or i == ItemSpriteType.kEnterClipping 
						then
						self.itemSprite[i]:setPositionXY(self.w / 2, self.h / 2)
					elseif i == ItemSpriteType.kBigMonster then
						
						self.itemSprite[i]:setPositionXY(tempX + 0.5 * self.w, tempY - 0.5 * self.h)
					elseif i == ItemSpriteType.kLotus_bottom then
						self.itemSprite[i]:setPositionXY(tempX, tempY)
					else
						self.itemSprite[i]:setPositionXY(tempX, tempY)
					end
				end
			end
		end
	end
end

function ItemView:initPosBoardDataPos(data, forcePos)
	if data.isUsed == false then return end -- 不可用，跳过，什么都不显示
	self.x = data.x;
	self.y = data.y;
	self.w = data.w;
	self.h = data.h;

	local tempX = (self.x - 0.5 ) * self.w 
	local tempY = (Max_Item_Y - self.y - 0.5 ) * self.h
	if self.pos_x ~= tempX or self.pos_y ~=tempY or forcePos then
		self.pos_x = tempX;
		self.pos_y = tempY;
		for i = ItemSpriteType.kBackground, ItemSpriteType.kLast do
			if self.itemSprite[i] ~= nil then
				if self.itemPosAdd[i] ~= nil then	--itemPosAdd，是某些特殊原件的显示偏移量
					if i == ItemSpriteType.kClipping 
						or i == ItemSpriteType.kEnterClipping 
						then
						self.itemSprite[i]:setPositionXY(self.itemPosAdd[i].x + self.w / 2, self.h / 2 + self.itemPosAdd[i].y)
					else
						self.itemSprite[i]:setPositionXY(tempX + self.itemPosAdd[i].x, tempY + self.itemPosAdd[i].y)
					end
				else
					if i == ItemSpriteType.kClipping 
						or i == ItemSpriteType.kEnterClipping 
						then
						self.itemSprite[i]:setPositionXY(self.w / 2, self.h / 2)
					elseif i == ItemSpriteType.kBigMonster then 
						self.itemSprite[i]:setPositionXY(tempX + 0.5 * self.w, tempY - 0.5 * self.h)
					else
						self.itemSprite[i]:setPositionXY(tempX, tempY)
					end
				end
			end
		end
	end
end

function ItemView:initByItemData(data)	--通过GameItem的数据进行初始化
	if data.isUsed == false then return end -- 不可用，跳过，什么都不显示
	self:cleanGameItemView()
	self.oldData = data:copy()

	self.x = data.x;
	self.y = data.y;
	self.w = data.w;
	self.h = data.h;

	--基本属性
	if data.ItemType == GameItemType.kAnimal then
		self:buildNewAnimalItem(data.ItemColorType, data.ItemSpecialType, true, true)
	elseif data.ItemType == GameItemType.kSnow then	--雪
		local snowsprite = ItemViewUtils:buildSnow(data.snowLevel)
		self.itemSprite[ItemSpriteType.kItem] = snowsprite
	elseif data.ItemType == GameItemType.kCrystal then	--由系统统一计算
		self.itemShowType = ItemSpriteItemShowType.kCharacter
		self.itemSprite[ItemSpriteType.kItem] = ItemViewUtils:buildCrystal(data.ItemColorType)               ------水晶
	elseif data.ItemType == GameItemType.kGift then		--由系统统一计算
		self.itemShowType = ItemSpriteItemShowType.kCharacter
		self.itemSprite[ItemSpriteType.kItem] = ItemViewUtils:buildGift(data.ItemColorType)
	elseif data.ItemType == GameItemType.kIngredient then
		local beanpod = ItemViewUtils:buildBeanpod(data.showType)
		self.itemSprite[ItemSpriteType.kItem] = beanpod
	elseif data.ItemType == GameItemType.kVenom then
		self:buildVenom()
	elseif data.ItemType == GameItemType.kCoin then
		self:buildCoin()
	elseif data.ItemType == GameItemType.kRoost then
		self:buildRoost(data.roostLevel)
	elseif data.ItemType == GameItemType.kBalloon then
		self:buildBalloon(data)
	elseif data.ItemType == GameItemType.kDigGround then        ----------挖地障碍 地块 宝石块
		self:buildDigGround(data.digGroundLevel)
	elseif data.ItemType == GameItemType.kDigJewel then 
		self:buildDigJewel(data.digJewelLevel, self.context.levelType)
	elseif data.ItemType == GameItemType.kGoldZongZi then
		self:buildGoldZongZi(data.digGoldZongZiLevel)
	elseif data.ItemType == GameItemType.kAddMove then
		self:buildAddMove(data.ItemColorType, data.numAddMove)
	elseif data.ItemType == GameItemType.kPoisonBottle then 
		self:buildPoisonBottle(data.forbiddenLevel)
	elseif data.ItemType == GameItemType.kBigMonster then 
		self:buildMonster()
	elseif data.ItemType == GameItemType.kBlackCuteBall then 
		self:buildBlackCuteBall(data.blackCuteStrength)
	elseif data.ItemType == GameItemType.kMimosa or data.ItemType == GameItemType.kKindMimosa then
		self:buildMimosa(data)
	elseif data.isSnail then
		self:buildSnail(data.snailRoadType)
	elseif data.bossLevel and data.bossLevel > 0 then 
		self:buildBoss(data)
	elseif data.ItemType == GameItemType.kRabbit then
		self:buildRabbit(data.ItemColorType, data.rabbitLevel, GameItemRabbitState.kSpawn == data.rabbitState)
	elseif data.ItemType == GameItemType.kMagicLamp then
		self:buildMagicLamp(data.ItemColorType, data.lampLevel)
	elseif data.ItemType == GameItemType.kWukong then
		self:buildWukong(data)
	elseif data.ItemType == GameItemType.kSuperBlocker then
		self:buildSuperBlocker()
	elseif data.ItemType == GameItemType.kHoneyBottle then
		self:buildHoneyBottle(data.honeyBottleLevel)
	elseif data.ItemType == GameItemType.kAddTime then
		self:buildAddTime(data.ItemColorType, data.addTime)
	elseif data.ItemType == GameItemType.kQuestionMark then
		self:buildQuestionMark(data.ItemColorType)
	elseif data.ItemType == GameItemType.kMagicStone then
		self:buildMagicStone(data.magicStoneDir, data.magicStoneLevel)
	elseif data.ItemType == GameItemType.kBottleBlocker then
		self:buildBottleBlocker(data.bottleLevel , data.ItemColorType)
	elseif data:isHedgehog() then
		self:buildHedgehog(data.snailRoadType, data.hedgehogLevel, data.hedge_before)
	elseif data.ItemType == GameItemType.kHedgehogBox then
		self:buildHedgehogBox()
	elseif data.ItemType == GameItemType.kRocket then
		self:buildRocket(data.ItemColorType)	
	elseif data.ItemType == GameItemType.kCrystalStone then
		self:buildCrystalStone(data.ItemColorType, data.crystalStoneEnergy, data.crystalStoneBombType)
	elseif data.ItemType == GameItemType.kTotems then
		self:buildTotems(data.ItemColorType, data:isActiveTotems())
	elseif data.ItemType == GameItemType.kDrip then
		self:buildDrip()
	end

	if data.isHalloweenBottle then
		self:buildHalloweenBoss()
	end

	-- if self.oldBoard and self.oldBoard.magicTileId ~= nil then
	-- 	self:addMagicTileWater(data)
	-- end

	--附加属性
	if data:hasFurball() then
		self:cleanFurballView()
		self.itemSprite[ItemSpriteType.kFurBall] = ItemViewUtils:buildFurball(data.furballType)
		if data.furballType == GameItemFurballType.kBrown and data.isBrownFurballUnstable then
			self:playFurballUnstableEffect()
		end
	end

	if data.cageLevel > 0 then
		self.itemSprite[ItemSpriteType.kLock] = ItemViewUtils:buildLocker(data.cageLevel)	
	end

	if data.honeyLevel > 0 then
		self:buildHoney(data.honeyLevel)
	end

	if data.isReverseSide then 
		self:setTileBlockCoverSpriteVisible(false)
	end

	if data.bigMonsterFrostingType> 0 and data.bigMonsterFrostingStrength > 0 then --雪怪的冰块
		self.itemSprite[ItemSpriteType.kBigMonsterIce] = ItemViewUtils:buildMonsterFrosting(data.bigMonsterFrostingType)
	end

	if data.beEffectByMimosa > 0 then
		self:addMimosaEffect(data.beEffectByMimosa ,data.mimosaDirection)
	end
end


function ItemView:buildDrip(isOnlyGetSprite)
	local sprite = TileDrip:create(self)
	if not isOnlyGetSprite then
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
	end
	return sprite
end

function ItemView:changeDripState(newData)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	local newState = newData.dripState
	local newMovePos = self:getBasePosition( newData.dripLeaderPos.x , newData.dripLeaderPos.y )

	if sprite then
		sprite:changeDripState(newState , newMovePos)

		if newState == DripState.kCasting then
			self.itemSprite[ItemSpriteType.kItemShow] = nil
			self.itemSprite[ItemSpriteType.kItemHighLevel] = sprite
			self.isNeedUpdate = true
		elseif newState == DripState.kMove then
			--self.itemSprite[ItemSpriteType.kItemShow] = nil
			--self.itemSprite[ItemSpriteType.kItemHighLevel] = sprite
			--self.isNeedUpdate = true
		end
	end
end

function ItemView:buildCrystalStone(colortype, energy, bombType, isOnlyGetSprite)
	local sprite = TileCrystalStone:create(colortype, energy/GamePlayConfig_CrystalStone_Energy, bombType)
	if not isOnlyGetSprite then
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
	end
	return sprite
end

function ItemView:buildRocket(colortype, isOnlyGetSprite)
	local rocket = TileRocket:create(colortype)
	if not isOnlyGetSprite then
		self.itemSprite[ItemSpriteType.kItemShow] = rocket
		self.itemShowType = ItemSpriteItemShowType.kCharacter
	end
	return rocket
end

function ItemView:buildBottleBlocker( bottleLevel , itemColorType , texture , isOnlyGetSprite )
	local sprite = TileBottleBlocker:create(bottleLevel, itemColorType)
	if not isOnlyGetSprite then
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
	end
	return sprite
end

function ItemView:buildMagicStone(magicStoneDir, magicStoneLevel)
	local sprite = TileMagicStone:create(magicStoneLevel, magicStoneDir)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
	return sprite
end

function ItemView:buildDigGround( digLevel, isOnlyGetSprite )
	-- body
	local texture
	if self.getContainer(ItemSpriteType.kDigBlocker) then 
		texture = self.getContainer(ItemSpriteType.kDigBlocker).refCocosObj:getTexture()
	end

	local view = TileDigGround:create(digLevel, texture)
	if isOnlyGetSprite then
		return view
	else
		self.itemSprite[ItemSpriteType.kDigBlocker] = view
	end
end

function ItemView:buildDigJewel( digLevel, levelType, isOnlyGetSprite)
	-- body
	local texture
	if self.getContainer(ItemSpriteType.kDigBlocker) then 
		texture = self.getContainer(ItemSpriteType.kDigBlocker).refCocosObj:getTexture()
	end
	local view = nil

	view = TileDigJewel:create(digLevel, texture, levelType)

	if isOnlyGetSprite then
		return view
	else
		self.itemSprite[ItemSpriteType.kDigBlocker] = view
	end
end

function ItemView:buildGoldZongZi( digLevel , isOnlyGetSprite)
	local texture = nil
	if self.getContainer(ItemSpriteType.kDigBlocker) then 
		texture = self.getContainer(ItemSpriteType.kDigBlocker).refCocosObj:getTexture()
	end
	local view = nil

	view = TileGoldZongZi:create(digLevel, texture)

	if isOnlyGetSprite then
		return view
	else
		self.itemSprite[ItemSpriteType.kDigBlocker] = view
	end
end

function ItemView:getItemSprite(theType)
	if theType == ItemSpriteType.kClipping then
		return self.clippingnode
	end 		----裁减节点特殊处理

	if theType == ItemSpriteType.kEnterClipping then
		return self.enterClippingNode
	end

	return self.itemSprite[theType];
end

function ItemView:cleanGameItemView()
	if self.itemSprite[ItemSpriteType.kItem] then self.itemSprite[ItemSpriteType.kItem]:removeFromParentAndCleanup(true); self.itemSprite[ItemSpriteType.kItem] = nil; end;
	if self.itemSprite[ItemSpriteType.kItemShow] then self.itemSprite[ItemSpriteType.kItemShow]:removeFromParentAndCleanup(true); self.itemSprite[ItemSpriteType.kItemShow] = nil; end;
	if self.itemSprite[ItemSpriteType.kItemHighLevel] then self.itemSprite[ItemSpriteType.kItemHighLevel]:removeFromParentAndCleanup(true); self.itemSprite[ItemSpriteType.kItemHighLevel] = nil; end;
	if self.itemSprite[ItemSpriteType.kItemLowLevel] then self.itemSprite[ItemSpriteType.kItemLowLevel]:removeFromParentAndCleanup(true); self.itemSprite[ItemSpriteType.kItemLowLevel] = nil; end;
	if self.itemSprite[ItemSpriteType.kFurBall] then self.itemSprite[ItemSpriteType.kFurBall]:removeFromParentAndCleanup(true); self.itemSprite[ItemSpriteType.kFurBall] = nil; end;
	if self.itemSprite[ItemSpriteType.kHoney] then self.itemSprite[ItemSpriteType.kHoney]:removeFromParentAndCleanup(true); self.itemSprite[ItemSpriteType.kHoney] = nil; end;
end

function ItemView:cleanFurballView()
	if self.itemSprite[ItemSpriteType.kNormalEffect] then
		self.itemSprite[ItemSpriteType.kNormalEffect]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kNormalEffect] = nil
	end
end

function ItemView:getGameItemSprite()
	local t1 = self.itemSprite[ItemSpriteType.kItemShow]
	local t2 = self.itemSprite[ItemSpriteType.kItem]
	local t3 = self.itemSprite[ItemSpriteType.kItemHighLevel]
	if t1 then 
		return t1 
	elseif t2 then
		return t2 
	else
		return t3
	end
end

------小动物和鸟的消除动画--------
function ItemView:playAnimationAnimalDestroy()
	local t1 = self.itemSprite[ItemSpriteType.kItemShow]
	local t2 = self.itemSprite[ItemSpriteType.kItem]

	self.isNeedUpdate = true 		----提示界面进行更新
	----1.选择消失动画类型
	if self.itemShowType == ItemSpriteItemShowType.kBird then
		if t1 then t1:play(kTileBirdAnimation.kDestroy) end
	elseif self.itemShowType == ItemSpriteItemShowType.kCharacter then 		----清除动物，然后删除效果
		local destroySprite = nil;
		local thingToRemove = nil;
		if t1 ~= nil then 			----动物特效
			destroySprite = self.itemSprite[ItemSpriteType.kItemShow].mainSprite;
			thingToRemove = self.itemSprite[ItemSpriteType.kItemShow];
		else 					 	----普通动物
			destroySprite = self.itemSprite[ItemSpriteType.kItem];
			thingToRemove = self.itemSprite[ItemSpriteType.kItem];
		end

		local actionarray = CCArray:create()
		actionarray:addObject(CCScaleTo:create(BoardViewAction:getActionTime(GamePlayConfig_GameItemAnimalDeleteAction_CD_View), 0.3));
		actionarray:addObject(CCFadeTo:create(BoardViewAction:getActionTime(GamePlayConfig_GameItemAnimalDeleteAction_CD_View), 168));
		actionarray:addObject(CCTintTo:create(BoardViewAction:getActionTime(GamePlayConfig_GameItemAnimalDeleteAction_CD_View), 0, 170, 229));
		local spawnAction = CCSpawn:create(actionarray);
		local function removeCharacterAction()
			thingToRemove:removeFromParentAndCleanup(true);
		end 
		local callAction = CCCallFunc:create(removeCharacterAction)
		local sequenceAction = CCSequence:createWithTwoActions(spawnAction, callAction)
		if destroySprite and destroySprite.refCocosObj then 	
			destroySprite:runAction(sequenceAction);
			self:playAnimationAnimalDestroy_DestroyEffect();		----播放动物删除的雪花爆炸特效	
		end
	elseif self.itemShowType == ItemSpriteItemShowType.kCoin then
		if t1 then t1:playDestroyAnimation() end
	elseif self.itemShowType == ItemSpriteItemShowType.kRabbit then
		self:playRabbitDestroyAnimation()
	else
		print("don't konw what kind destroy animation to show!!!", self.y, self.x);
	end

	local t3 = self.itemSprite[ItemSpriteType.kClipping]
	if t3 then
		if t3:getParent() then t3:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kClipping] = nil
	end

	local t4 = self.itemSprite[ItemSpriteType.kEnterClipping]
	if t4 then
		if t4:getParent() then t4:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kEnterClipping] = nil
	end
end

local function createElasticEffect(viewSprite)
	local array = CCArray:create()
	array:addObject(CCEaseSineOut:create(CCMoveBy:create(0.05, ccp(0, -4))))
	array:addObject(CCEaseSineInOut:create(CCMoveBy:create(0.08, ccp(0, 6))))
	array:addObject(CCEaseSineIn:create(CCMoveBy:create(0.025, ccp(0, -2))))

	local targetAction = CCSequence:create(array)
	if viewSprite then viewSprite:runAction(targetAction) end
end

function ItemView:playElasticEffect()
	local viewSprite, animSprite = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemShow]
	if viewSprite and viewSprite.refCocosObj then
		createElasticEffect(viewSprite)
	end
	if animSprite and animSprite.refCocosObj then
		createElasticEffect(animSprite)
	end
end

----播放动物删除的雪花爆炸特效
function ItemView:playAnimationAnimalDestroy_DestroyEffect()
	--self.isNeedUpdate = true;
	local destroySprite = Sprite:createWithSpriteFrameName("destroy_effect_0.png")
	local frames = SpriteUtil:buildFrames("destroy_effect_%d.png", 0, 20)
	local animate = SpriteUtil:buildAnimate(frames, kCharacterAnimationTime)	
	local destroyItem = self;
	local function onRepeatFinishCallback_DestroyEffect()
		destroyItem.itemSprite[ItemSpriteType.kItemDestroy] = nil;
		destroySprite:removeFromParentAndCleanup(true);
	end 
	destroySprite:play(animate, 0, 1, onRepeatFinishCallback_DestroyEffect)
	self.itemSprite[ItemSpriteType.kItemDestroy] = destroySprite;
	local pos = self:getBasePosition(self.x,self.y);
	destroySprite:setPosition(pos);
	if self.getContainer(ItemSpriteType.kItemDestroy) ~= nil then 
		self.getContainer(ItemSpriteType.kItemDestroy):addChild(destroySprite);
	else
		self.isNeedUpdate = true;
	end
end

function ItemView:playBridBackEffect(isShow, scaleTo)
	if (isShow) then
		if self.itemSprite[ItemSpriteType.kItemBack] ~= nil then
			self.itemSprite[ItemSpriteType.kItemBack]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kItemBack] = nil
		end
		self.itemSprite[ItemSpriteType.kItemBack] = TileBird:createBirdDestroyEffectForever(scaleTo)
		local pos = self:getBasePosition(self.x, self.y)
		self.itemSprite[ItemSpriteType.kItemBack]:setPosition(pos)
	else
		if (self.itemSprite[ItemSpriteType.kItemBack]~= nil) then
			TileBird:deleteBirdDestroyEffect(self.itemSprite[ItemSpriteType.kItemBack])
			self.itemSprite[ItemSpriteType.kItemBack] = nil
		end
	end
end

function ItemView:playBirdBirdBackEffect(isShow)
	if isShow then
		local bird = TileBird:create()
		bird:play2BirdDestroyAnimation()

		local pos = self:getBasePosition(self.x, self.y)
		self.itemSprite[ItemSpriteType.kItemBack] = bird
		self.itemSprite[ItemSpriteType.kItemBack]:setPosition(pos)
	else
		if self.itemSprite[ItemSpriteType.kItemBack] ~= nil then
			local bird = self.itemSprite[ItemSpriteType.kItemBack]
			bird:stop2BirdDestroyAnimation()
			self.itemSprite[ItemSpriteType.kItemBack] = nil
		end
	end
end

function ItemView:playBirdBirdExplodeEffect(isShow, specialPosList)
	local pos = self:getBasePosition(self.x, self.y)
	local birdExplode = TileBird:play2BirdExplodeAnimation(specialPosList)
	self.itemSprite[ItemSpriteType.kSpecial] = birdExplode
	self.itemSprite[ItemSpriteType.kSpecial]:setPosition(pos)
	self.isNeedUpdate = true
end

function ItemView:playFlyingBirdEffect(r, c, delaytime, flyingtime)
	local item = self
	local function onAnimComplete()
		if item then
			item.itemSprite[ItemSpriteType.kSpecial] = nil
		end
	end

	local selfPos = self:getBasePosition(self.x, self.y)
	local fromPos = self:getBasePosition(c, r)
	local animation = Firebolt:createLightOnly(fromPos, selfPos, flyingtime, onAnimComplete)
	self.itemSprite[ItemSpriteType.kSpecial] = animation 

	self.isNeedUpdate = true
end

----播放冰层消除特效----
function ItemView:playIceDecEffect(callback)
	local pos = self:getBasePosition(self.x,self.y);
	pos.x = pos.x + GamePlayConfig_IceDeleted_Pos_Add_X;
	pos.y = pos.y + GamePlayConfig_IceDeleted_Pos_Add_Y;
	local sprite = ItemViewUtils:buildLighttAction(callback);
	sprite:setPosition(pos);

	----播放消除特效----
	if self.itemSprite[ItemSpriteType.kLight] ~= nil then
		if self.itemSprite[ItemSpriteType.kLight]:getParent() ~= nil then
			self.itemSprite[ItemSpriteType.kLight]:getParent():addChild(sprite);
		else
			if callback then callback() end
		end
	elseif self.getContainer(ItemSpriteType.kLight) ~= nil then ----最后一层冰被干掉了，要靠辅助记录的Panel来添加特效
		self.getContainer(ItemSpriteType.kLight):addChild(sprite);
	end
end                                                                                                                                                                                                                                                                                                                                                                             

function ItemView:playLockDecEffect()
	local context = self
	local function onAnimComplete(evt)
		if context.itemSprite[kLockShow] then
			context.itemSprite[kLockShow] = nil
		end
	end

	local pos = self:getBasePosition(self.x,self.y)
	local sprite = ItemViewUtils:buildLockAction()
	sprite:ad(Events.kComplete, onAnimComplete)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kLockShow] = sprite
	if self.itemSprite[ItemSpriteType.kLock] then
		self.itemSprite[ItemSpriteType.kLock]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kLock] = nil
	end
	
	self.isNeedUpdate = true
end

function ItemView:playSnowDecEffect(snowLevel)
	local pos = self:getBasePosition(self.x,self.y);
	local sprite = ItemViewUtils:buildSnowAction(snowLevel)
	local offsetX = {0, 0, 3, 4.5, 2.8}
	local offsetY = {0, -22, -10.5, -17.5, -14.4}
	pos.x = pos.x + offsetX[snowLevel]
	pos.y = pos.y + offsetY[snowLevel]
	sprite:setPosition(pos)

	self.itemSprite[ItemSpriteType.kSnowShow] = sprite;
	if snowLevel <= 1 then 
		self.itemSprite[ItemSpriteType.kItem]:removeFromParentAndCleanup(true) 
		self.itemSprite[ItemSpriteType.kItem] = nil
	end
	self.isNeedUpdate = true;
end

function ItemView:playVenomDestroyEffect()
	local s = self.itemSprite[ItemSpriteType.kItemShow]
	self.itemSprite[ItemSpriteType.kItemShow] = nil
	local function onAnimComplete(evt)
		if s then
			s:removeFromParentAndCleanup(true)
		end
	end
	s.isNeedUpdate = true
	s:ad(Events.kComplete, onAnimComplete)
	s:playDestroyAnimation()
end

function ItemView:playForbiddenLevelAnimation(level, playAnim, callback)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	sprite:playForbiddenLevelAnimation(level, playAnim, callback)
end

function ItemView:playRabbitUpstarirsAnimation(r, c, boardView, isShowDangerous ,callback )
	local time = 1
	local scale_fix = boardView:getScale()
	
	local s = self.itemSprite[ItemSpriteType.kItemShow]
	s:stopAllActions()
	s:setPosition(self:getBasePosition(c,r)) 
	local sprite = s
	s:removeFromParentAndCleanup(false)
	self.itemSprite[ItemSpriteType.kItemShow] = nil
	sprite:setScale(scale_fix)
	s:playUpAnimation()
	local function completeCallback( ... )
		-- body
		if s then
			s:removeFromParentAndCleanup(false)
			self.getContainer(ItemSpriteType.kItemShow):addChild(s)
			self.itemSprite[ItemSpriteType.kItemShow] = s
			s:setScale(1)
			s:setPosition(self:getBasePosition(c, r))
			-- if isShowDangerous then 
			-- 	s:playHappyAnimation(true)
			-- end
		end
		if callback then callback() end
	end
	
	s:setPosition(boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x) )
	local position =  boardView.gameBoardLogic:getGameItemPosInView(r, c)
	local array_action_list = CCArray:create()
	array_action_list:addObject(CCRotateTo:create(0.1, 0))
	array_action_list:addObject(CCEaseExponentialInOut:create(CCMoveTo:create(4 * time/5, position)))
	array_action_list:addObject(CCCallFunc:create(completeCallback))
	s:runAction(CCSequence:create(array_action_list))

	if boardView and boardView.PlayUIDelegate then 
		boardView.PlayUIDelegate.effectLayer:addChild(s)
	end
end

function ItemView:updateDangerousStatus(isDangerous)
	if self.itemShowType == ItemSpriteItemShowType.kRabbit then
		local s = self.itemSprite[ItemSpriteType.kItemShow]
		if s then
			if isDangerous then 
				s:playInDangerAnimation()
			else
				s:stopInDangerAnimation()
			end
		end
	else
		local s = self.itemSprite[ItemSpriteType.kItem]
		if s then
			if isDangerous then 
				if s.playInDangerAnimation then
					s:playInDangerAnimation()
				end
			else
				if s.stopInDangerAnimation then
					s:stopInDangerAnimation()
				end
			end
		end
	end
end

function ItemView:playUpstairsAnimation(r, c, boardView, isShowDangerous ,callback )
	-- body
	if self.itemShowType == ItemSpriteItemShowType.kRabbit then 
		self:playRabbitUpstarirsAnimation(r, c, boardView, isShowDangerous ,callback)
		return 
	end

	local time = 1
	local scale_fix = boardView:getScale()
	local sprite = ItemViewUtils:buildBeanpod()
	sprite:setScale(scale_fix)
	local sprite_fg = Sprite:createWithSpriteFrameName("light_bg")
	local anchorPointY = self.y - r == 1 and 1/4 or 1/6
	sprite_fg:setAnchorPoint(ccp(0.5, anchorPointY))
	sprite_fg:setScaleY((1+ self.y - r)/3)
	sprite_fg:setScale(scale_fix)
	local s = self.itemSprite[ItemSpriteType.kItem]
	s:stopAllActions()
	s:setVisible(false)
	s:setPosition(self:getBasePosition(c,r)) 

	local function completeCallback( ... )
		-- body
		if s then
			s:setVisible(true)
			-- if isShowDangerous then 
			-- 	local action_zoom = CCScaleTo:create(0.4, 1.1)
			-- 	local action_narrow = CCScaleTo:create(0.2, 0.9)
			-- 	s:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(action_zoom, action_narrow)))
			-- end
		end
		if sprite then sprite:removeFromParentAndCleanup(true) end
		if sprite_fg then sprite_fg:removeFromParentAndCleanup(true) end
		if callback then callback() end
	end
	
	sprite:setPosition(boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x) )
	sprite_fg:setPosition(boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x))
	local position =  boardView.gameBoardLogic:getGameItemPosInView(r, c)
	local array_action_list = CCArray:create()
	-- array_action_list:addObject(CCDelayTime:create(0.1))
	array_action_list:addObject(CCRotateTo:create(0.1, -10))
	array_action_list:addObject(CCEaseExponentialInOut:create(CCMoveTo:create(4 * time/5, position)))
	array_action_list:addObject(CCCallFunc:create(completeCallback))
	sprite:runAction(CCSequence:create(array_action_list))

	local fg_action_list = CCArray:create()
	fg_action_list:addObject(CCDelayTime:create(0.1))
	fg_action_list:addObject(CCFadeIn:create(time/4))
	fg_action_list:addObject(CCFadeOut:create(time/4))
	local action_fg = CCSequence:create(fg_action_list )
	sprite_fg:runAction(action_fg)
	if boardView and boardView.PlayUIDelegate then 
		boardView.PlayUIDelegate.effectLayer:addChild(sprite)
		boardView.PlayUIDelegate.effectLayer:addChild(sprite_fg)
	end
end

function ItemView:playChangeToIngredientAnimation( boardView, fromPosition , callback )
	-- body
	if boardView.PlayUIDelegate and boardView.PlayUIDelegate.effectLayer then
		local sprite = ItemViewUtils:buildBeanpod()
		local function completeCallback( ... )
			-- body
			if sprite then sprite:removeFromParentAndCleanup(true) end
			if callback then callback() end
		end

		boardView.PlayUIDelegate.effectLayer:addChild(sprite, 0)
		local fromPosition = fromPosition or ccp(0,0)
		local toPosition = boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x)
		sprite:setPosition(fromPosition)
		sprite:runAction(CCSequence:createWithTwoActions(CCEaseSineIn:create(CCMoveTo:create(0.6,toPosition)) , CCCallFunc:create(completeCallback)))
	else
		if callback() then callback() end
	end
end

function ItemView:playChangeToDigGround( boardView, callback )
	-- body
	local preItemView = self:getGameItemSprite()
	local animation
	
	local function animationCallback( ... )
		-- body
		self.isNeedUpdate = true
		if callback then callback() end
	end

	local function midCallback( ... )
		-- body
		if preItemView then preItemView:setVisible(false) end
	end
	self.isNeedUpdate = true
	animation = TileDigGround:createDigGroundAnimation(midCallback, animationCallback)
	self.itemSprite[ItemSpriteType.kNormalEffect] = animation
	animation:setPosition(self:getBasePosition(self.x, self.y))
end

function ItemView:playVenomSpreadEffect(direction, callback, itemType)
	local s = self.itemSprite[ItemSpriteType.kItemShow]
	if not s then
		return
	end

	s.isNeedUpdate = true
	s:playTempInvisibleAnimation()

	local function completeHandler(evt)
		s:playRevertVisibleAnimation()
		if callback and type(callback) == "function" then callback() end
	end

	local sprite
	if itemType == GameItemType.kVenom then 
		sprite = TileVenom:create()
	elseif itemType == GameItemType.kPoisonBottle then
		sprite = TilePoisonBottle:create()
	end
	
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	sprite:ad(Events.kComplete, completeHandler)
	sprite:playDirectionAnimation(direction)
	self.itemSprite[ItemSpriteType.kNormalEffect] = sprite
	self.isNeedUpdate = true
end

function ItemView:playFurballTransferEffect(direction, callback)
	local s = self.itemSprite[ItemSpriteType.kFurBall]
	local furballName = nil
	if s then
		furballName = s.name
		s:stopAllActions()
		self.itemSprite[ItemSpriteType.kFurBall]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kFurBall] = nil
	else
		local boardLogic = GameBoardLogic:getCurrentLogic()
		local replayData = boardLogic and boardLogic:getReplayRecordsData() or {}
		
		assert(false, "furball origin view not exist. replayData="..table.serialize(replayData))

		self.isNeedUpdate = true
		if callback and type(callback) == "function" then callback() end
		return
	end

	local newSprite = TileCuteBall:create(furballName)
	newSprite:setPosition(self:getBasePosition(self.x, self.y))

	self.itemSprite[ItemSpriteType.kSpecial] = newSprite
	self.isNeedUpdate = true

	local animationType = nil
	if direction.x > 0 then
		animationType = kTileCuteBallAnimation.kRight
	elseif direction.x < 0 then
		animationType = kTileCuteBallAnimation.kLeft
	else
		if direction.y > 0 then
			animationType = kTileCuteBallAnimation.kDown
		else
			animationType = kTileCuteBallAnimation.kUp
		end
	end

	local context = self
	local function onAnimComplete(evt)
		if callback and type(callback) == "function" then callback() end
	end

	if animationType then
		newSprite:playDirectionAnimation(animationType)
		newSprite:ad(Events.kComplete, onAnimComplete)
	end
end

function ItemView:playFurballUnstableEffect()
	local s = self.itemSprite[ItemSpriteType.kFurBall]
	if s then
		s:playFurballUnstableAnimation()
	end
end

function ItemView:playFurballShieldEffect()
	local s = self.itemSprite[ItemSpriteType.kFurBall]
	if s then
		s:playFurballShieldAnimation()
	end
end

function ItemView:playFurballSplitEffect(dir, callback)
	local s = self.itemSprite[ItemSpriteType.kFurBall]
	self.itemSprite[ItemSpriteType.kNormalEffect] = s
	self.itemSprite[ItemSpriteType.kFurBall] = nil
	if s then
		s:playFurballSplitAnimation(dir, callback)
	end
end

function ItemView:playGreyFurballDestroyEffect()
	local s = self.itemSprite[ItemSpriteType.kFurBall]
	if not s then
		print("item view no furball play destroy " .. self.x .. ", " ..self.y)
		return
	end
	s.isNeedUpdate = true
	self.itemSprite[ItemSpriteType.kNormalEffect] = s
	self.itemSprite[ItemSpriteType.kFurBall] = nil

	local context = self	
	local function onAnimComplete(evt)
		if s and s:getParent() then
			s:removeFromParentAndCleanup(true)
		end
	end

	s:ad(Events.kComplete, onAnimComplete)
	s:playDestroyAnimation()
end

function ItemView:addFurballView(furballType)
	local sprite = ItemViewUtils:buildFurball(furballType)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kFurBall] = sprite
	self.isNeedUpdate = true
end

----依据地图地面信息更新数据
function ItemView:updateByNewBoardData(data)
	-----1.修改冰层状态------
	if (self.oldBoard == nil or self.oldBoard.iceLevel ~= data.iceLevel) then
		if (self.itemSprite[ItemSpriteType.kLight] ~= nil) then
			if self.itemSprite[ItemSpriteType.kLight]:getParent() then
				self.itemSprite[ItemSpriteType.kLight]:removeFromParentAndCleanup(true);
				self.itemSprite[ItemSpriteType.kLight] = nil;
			end
		end
		self.itemSprite[ItemSpriteType.kLight] = ItemViewUtils:buildLight(data.iceLevel, data.gameModeId)
	end

	if not self.oldBoard or self.oldBoard.superCuteState ~= data.superCuteState then
		self:cleanSuperCuteBallView()
		if data:hasSuperCuteBall() then
			self:addSuperCuteBall(data.superCuteState)
		end
	end

	data.isNeedUpdate = false;
	self.oldBoard = data:copy();
end
----依据地图信息更新数据
function ItemView:updateByNewItemData(data)
	----==========1.修改动物状态--------------
	------全空--------
	if data.ItemType == GameItemType.kNone and not (data.isSnail or data:isHedgehog()) then 				----空了---进行更新，并且修改标志
		data.isNeedUpdate = false
		self:cleanGameItemView()
	end

	--------豆荚------
	if data.ItemType == GameItemType.kIngredient then
		if self.oldData and self.oldData.ItemType ~= data.ItemType then
			self:removeItemSpriteGameItem();
			self.itemSprite[ItemSpriteType.kItem] = ItemViewUtils:buildBeanpod(data.showType);
		end
	end

	--------银币------
	if data.ItemType == GameItemType.kCoin then
		self.itemShowType = ItemSpriteItemShowType.kCoin
		if self.oldData and self.oldData.ItemType ~= data.ItemType then
			self:removeItemSpriteGameItem()
			self:buildCoin()
		end
	end

	------水晶-------
	if data.ItemType == GameItemType.kCrystal then
		if self.oldData then
			if self.oldData.ItemType ~= data.ItemType
				or self.oldData.ItemColorType ~= data.ItemColorType
				then
				self:removeItemSpriteGameItem();
				self.itemShowType = ItemSpriteItemShowType.kCharacter
				self.itemSprite[ItemSpriteType.kItem] = ItemViewUtils:buildCrystal(data.ItemColorType)               ------水晶
			end
		end
	end

	---------------礼物-----------
	if data.ItemType == GameItemType.kGift then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem();
			self.itemShowType = ItemSpriteItemShowType.kCharacter
			self.itemSprite[ItemSpriteType.kItem] = ItemViewUtils:buildGift(data.ItemColorType)
		end
	end

	---------------气球----------------
	if data.ItemType == GameItemType.kBalloon then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem();
			self:buildBalloon(data)
		end
	end 

	if data.ItemType == GameItemType.kMagicLamp then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem();
			self:buildMagicLamp(data.ItemColorType, data.lampLevel)
		end
	end 

	if data.ItemType == GameItemType.kWukong then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem();
			self:buildWukong(data)
		end
	end 

	if data.ItemType == GameItemType.kDrip then
		if self.oldData then
			if self.oldData.ItemType ~= data.ItemType then
				self:removeItemSpriteGameItem();
				self:buildDrip()
			elseif self.oldData.ItemType == data.ItemType and self.oldData.dripState ~= data.dripState then
				self:changeDripState(data)
			end
		end
	end

	if data.ItemType == GameItemType.kAddMove then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem()
			self:buildAddMove(data.ItemColorType, data.numAddMove)
		end
	end

	if data.ItemType == GameItemType.kAddTime then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem()
			self:buildAddTime(data.ItemColorType, data.addTime)
		end
	end

	----------------------修改黑色毛球状态------------------------
	if data.ItemType == GameItemType.kBlackCuteBall then 
		if self.oldData and (self.oldData.ItemType ~= data.ItemType) then
			self:removeItemSpriteGameItem();
			self:buildBlackCuteBall(data.blackCuteStrength)
		end
	end

	----------------------修改兔子状态------------------------
	if data.ItemType == GameItemType.kRabbit then 
		self.itemShowType = ItemSpriteItemShowType.kRabbit
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem();
			self:buildRabbit(data.ItemColorType, data.rabbitLevel)
		end
	end

	------------------蜂蜜罐状态----------------------
	if data.ItemType == GameItemType.kHoneyBottle then 
		if ( self.oldData and self.oldData.ItemType ~= data.ItemType) then
			self:removeItemSpriteGameItem()
			self:buildHoneyBottle(data.honeyBottleLevel)
		end
	end
	
	--------------------动物--变化----------------
	if data.ItemType == GameItemType.kAnimal then 				----动物类型
		if self.oldData then
			if data.ItemType ~= self.oldData.ItemType 
				or data.ItemColorType ~= self.oldData.ItemColorType 	----检测是否需要更新
				or data.ItemSpecialType ~= self.oldData.ItemSpecialType
				then 
				----显示上有一些不一样
				----1.删除原来的
				self:removeItemSpriteGameItem()

				----2.创建新的Item
				self:buildNewAnimalItem(data.ItemColorType, data.ItemSpecialType, true, true)
			end

			if data.ItemColorType == 0 and (data.ItemSpecialType == nil or data.ItemSpecialType == 0) then ----被消除之后，数据啥都不剩了
				data.isNeedUpdate = false
			end
		end
	end

	if data.ItemType == GameItemType.kQuestionMark then
		if self.oldData
		and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem()
			self:buildQuestionMark(data.ItemColorType)
		end
	end
	
	if data.ItemType == GameItemType.kRocket then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType or self.oldData.ItemColorType ~= data.ItemColorType) then
			self:removeItemSpriteGameItem()
			self:buildRocket(data.ItemColorType)
		end
	end

	if data.ItemType == GameItemType.kTotems then
		if self.oldData and self.oldData.ItemType ~= data.ItemType then
			self:removeItemSpriteGameItem()
			self:buildTotems(data.ItemColorType, data:isActiveTotems())
		end
	end

	------掉落-------
	if data.ItemStatus == GameItemStatusType.kIsFalling 
		or data.ItemStatus == GameItemStatusType.kNone
		or data.ItemStatus == GameItemStatusType.kJustStop
		or data.ItemStatus == GameItemStatusType.kItemHalfStable then
		if data.ItemType == GameItemType.kNone 
			or data.ItemType == GameItemType.kAnimal
			or data.ItemType == GameItemType.kCoin
			or data.ItemType == GameItemType.kCrystal
			or data.ItemType == GameItemType.kGift
			or data.ItemType == GameItemType.kIngredient
			or data.ItemType == GameItemType.kBalloon
			or data.ItemType == GameItemType.kAddMove
			or data.ItemType == GameItemType.kBlackCuteBall
			or data.ItemType == GameItemType.kRabbit
			or data.ItemType == GameItemType.kHoneyBottle
			or data.ItemType == GameItemType.kAddTime
			or data.ItemType == GameItemType.kQuestionMark
			or data.ItemType == GameItemType.kRocket
			or data.ItemType == GameItemType.kCrystalStone
			or data.ItemType == GameItemType.kTotems
			or data.ItemType == GameItemType.kDrip
			then
			self.itemPosAdd[ItemSpriteType.kItem] = data.itemPosAdd 			----掉落一个物品
			self.itemPosAdd[ItemSpriteType.kItemShow] = data.itemPosAdd 		----掉落一个特效
			self.itemPosAdd[ItemSpriteType.kItemHighLevel] = data.itemPosAdd 		----掉落一个特效
			self.itemPosAdd[ItemSpriteType.kItemLowLevel] = data.itemPosAdd 		----掉落一个特效
			self.itemPosAdd[ItemSpriteType.kFurBall] = data.itemPosAdd
			self.itemPosAdd[ItemSpriteType.kClipping] = data.ClippingPosAdd 	----生成口的某些掉落物品
			self.itemPosAdd[ItemSpriteType.kEnterClipping] = data.EnterClippingPosAdd
			data.isNeedUpdate = false
		end
	end

	----------------------------------蜗牛------------------------------
	if data.isSnail then 
		if self.oldData and (self.oldData.isSnail ~= data.isSnail) then
			self:removeItemSpriteGameItem();
			if self.itemSprite[ItemSpriteType.kSnailMove] ~= nil then
				self.itemSprite[ItemSpriteType.kSnailMove]:removeFromParentAndCleanup(true)
				self.itemSprite[ItemSpriteType.kSnailMove] = nil
			end
			self:buildSnail(data.snailRoadType)
		end
	end

	if data:isHedgehog() then 
		if self.oldData and (self.oldData.hedgehogLevel ~= data.hedgehogLevel) then
			self:removeItemSpriteGameItem();
			if self.itemSprite[ItemSpriteType.kSnailMove] ~= nil then
				self.itemSprite[ItemSpriteType.kSnailMove]:removeFromParentAndCleanup(true)
				self.itemSprite[ItemSpriteType.kSnailMove] = nil
			end
			self:buildHedgehog(data.snailRoadType, data.hedgehogLevel)
		end
	end

	-----================2.修改牢笼状态------
	if (self.oldData) then
		if (self.oldData.cageLevel ~= data.cageLevel) then
			if self.itemSprite[ItemSpriteType.kLock] ~= nil then
				if self.itemSprite[ItemSpriteType.kLock]:getParent() then
					self.itemSprite[ItemSpriteType.kLock]:removeFromParentAndCleanup(true);
					self.itemSprite[ItemSpriteType.kLock] = nil
				end
			end
			if data.cageLevel > 0 then
				self.itemSprite[ItemSpriteType.kLock] = ItemViewUtils:buildLocker(data.cageLevel)
			end
		end
	end

	-----================3.修改雪花状态------
	if (self.oldData) then
		if (self.oldData.snowLevel ~= data.snowLevel and data.snowLevel > 0) then
			if (self.itemSprite[ItemSpriteType.kItem] ~= nil) then
				if self.itemSprite[ItemSpriteType.kItem]:getParent() then
					self.itemSprite[ItemSpriteType.kItem]:removeFromParentAndCleanup(true);
				end
			end
			self.itemSprite[ItemSpriteType.kItem] = ItemViewUtils:buildSnow(data.snowLevel)
		end
	end

	-----================4.修改毒液状态------
	if self.oldData then
		if self.oldData.venomLevel ~= data.venomLevel and data.venomLevel > 0 then
			self:removeItemSpriteGameItem()
			self:buildVenom()
		end
	end

	--------------------5.修改地块状态-----------------
	if self.oldData then 
		if self.oldData.digGroundLevel ~= data.digGroundLevel and data.digGroundLevel > 0 then
			self:removeItemSpriteGameItem()
			self:buildDigGround(data.digGroundLevel)
		end
	end


	if self.oldData then 
		if self.oldData.digJewelLevel ~= data.digJewelLevel and data.digJewelLevel > 0 then
			self:removeItemSpriteGameItem()
			self:buildDigJewel(data.digJewelLevel, self.context.levelType)
		end
	end

	if self.oldData then 
		if data.ItemType == GameItemType.kGoldZongZi and self.oldData.ItemType ~= GameItemType.kGoldZongZi then
			self:removeItemSpriteGameItem()
			self:buildGoldZongZi(data.digGoldZongZiLevel)
		end
		if self.oldData.ItemType == GameItemType.kGoldZongZi then
			if data.ItemType == GameItemType.kGoldZongZi then
				if self.oldData.digGoldZongZiLevel ~= data.digGoldZongZiLevel then
					self:removeItemSpriteGameItem()
					self:buildGoldZongZi(data.digGoldZongZiLevel)
				end
			elseif data.ItemType == GameItemType.kDigGround then
				self:removeItemSpriteGameItem()
				self:buildDigGround(data.digGroundLevel)
			end
		end
	end


	-------------------------妖精瓶子-------------------------

	if self.oldData then 
		if self.oldData.ItemType == GameItemType.kBottleBlocker then
			if data.ItemType == GameItemType.kBottleBlocker then
				if data.bottleLevel > 0 and (self.oldData.bottleLevel ~= data.bottleLevel or self.oldData.ItemColorType ~= data.ItemColorType)
					then
					self:removeItemSpriteGameItem()
					self:buildBottleBlocker(data.bottleLevel , data.ItemColorType)
				end
			end
			
		end
	end

	--------------------6.修改boss状态-------------------
	if self.oldData then 
		if self.oldData.ItemType ~= data.ItemType and data.ItemType == GameItemType.kBoss then
			self:removeItemSpriteGameItem()
			if data.bossLevel > 0 then 
				self:buildBoss(data)
			end
		end
	end
	--------------------7.修改蜂蜜状态-------------------
	if (self.oldData) then
		if (self.oldData.honeyLevel ~= data.honeyLevel) then
			if self.itemSprite[ItemSpriteType.kHoney] ~= nil then
				if self.itemSprite[ItemSpriteType.kHoney]:getParent() then
					self.itemSprite[ItemSpriteType.kHoney]:removeFromParentAndCleanup(true);
					self.itemSprite[ItemSpriteType.kHoney] = nil
				end
			end
			if data.honeyLevel > 0 then
				self:buildHoney()
			end
		end
	end

	if data.ItemType == GameItemType.kCrystalStone then
		if self.oldData and (self.oldData.ItemType ~= data.ItemType
			or self.oldData.ItemColorType ~= data.ItemColorType or self.oldData.crystalStoneEnergy ~= data.crystalStoneEnergy) then
			self:removeItemSpriteGameItem()
			self:buildCrystalStone(data.ItemColorType, data.crystalStoneEnergy, data.crystalStoneBombType)
		end
	end

	if data.isReverseSide then -- 更新翻转地格上的视图状态
		self:setTileBlockCoverSpriteVisible(false)
	end

	----不论如何都赋值data
	self.oldData = data:copy()
	data.isNeedUpdate = false
end

-----删除gameItem的sprite
function ItemView:removeItemSpriteGameItem()
	if self.itemSprite then
		if self.itemSprite[ItemSpriteType.kItem] ~= nil then
			self.itemSprite[ItemSpriteType.kItem]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kItem] = nil
		end
		if self.itemSprite[ItemSpriteType.kItemShow] ~= nil then
			self.itemSprite[ItemSpriteType.kItemShow]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kItemShow] = nil
		end

		if self.itemSprite[ItemSpriteType.kSnail] ~= nil then
			self.itemSprite[ItemSpriteType.kSnail]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kSnail] = nil
		end

		if self.itemSprite[ItemSpriteType.kDigBlocker] ~= nil then
			self.itemSprite[ItemSpriteType.kDigBlocker]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kDigBlocker] = nil
		end

		if self.itemSprite[ItemSpriteType.kBigMonster] ~= nil then
			self.itemSprite[ItemSpriteType.kBigMonster]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kBigMonster] = nil
		end

		if self.itemSprite[ItemSpriteType.kItemHighLevel] ~= nil then
			self.itemSprite[ItemSpriteType.kItemHighLevel]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kItemHighLevel] = nil
		end

		if self.itemSprite[ItemSpriteType.kItemLowLevel] ~= nil then
			self.itemSprite[ItemSpriteType.kItemLowLevel]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kItemLowLevel] = nil
		end
		
	end
end

----创建AnimalItem
----autoset 自动设置为物品， autotype 自动设置创建类型
----返回1，物品对象，返回2，物品对象的类型
function ItemView:buildNewAnimalItem(colortype, specialtype, autoset, autotype)
	if AnimalTypeConfig.isSpecialTypeValid(specialtype)
		and specialtype ~= AnimalTypeConfig.kColor
		then
		if AnimalTypeConfig.isColorTypeValid(colortype) and colortype ~= AnimalTypeConfig.kDrip then 
			---特殊动画
			local sprite = TileCharacter:create(table.getMapValue(itemsName, colortype))
			if specialtype == AnimalTypeConfig.kLine then
	  			sprite:play(kTileCharacterAnimation.kLineRow)
	  		elseif specialtype == AnimalTypeConfig.kColumn then
	  			sprite:play(kTileCharacterAnimation.kLineColumn)
	  		elseif specialtype == AnimalTypeConfig.kWrap then
	  			sprite:play(kTileCharacterAnimation.kWrap)
	  		end
			local pos = self:getBasePosition(self.x, self.y)
			sprite:setPosition(pos)
	  		if (autoset) then 
	  			self.itemSprite[ItemSpriteType.kItemShow] = sprite 
	  		end
	  		if (autotype) then self.itemShowType = ItemSpriteItemShowType.kCharacter end;
	  		return sprite
		end
  	elseif specialtype == AnimalTypeConfig.kColor then 		----颜色鸟
		local bird = TileBird:create()
		bird:play(1)
		local pos = self:getBasePosition(self.x, self.y)
		bird:setPosition(pos)
		if (autoset) then self.itemSprite[ItemSpriteType.kItemShow] = bird end;
		if (autotype) then self.itemShowType = ItemSpriteItemShowType.kBird end;
		return bird
	elseif AnimalTypeConfig.isColorTypeValid(colortype) and colortype ~= AnimalTypeConfig.kDrip then
		--------静态图片
		local sprite = ItemViewUtils:buildAnimalStatic(colortype);
		local pos = self:getBasePosition(self.x, self.y)
		sprite:setPosition(pos)
		if (autoset) then
			if (self.itemSprite[ItemSpriteType.kItem]) then
				if (self.itemSprite[ItemSpriteType.kItem]:getParent()) then
					self.itemSprite[ItemSpriteType.kItem]:removeFromParentAndCleanup(true);
				end;
				self.itemSprite[ItemSpriteType.kItem] = nil;
			end
			self.itemSprite[ItemSpriteType.kItem] = sprite 
		end; 
		if (autotype) then self.itemShowType = ItemSpriteItemShowType.kCharacter end;
		return sprite
	end
end

function ItemView:buildQuestionMark( colortype )
	-- body
	local sprite = ItemViewUtils:createQuestionMark(colortype)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
	self.itemShowType = ItemSpriteItemShowType.kCharacter
end

function ItemView:buildAddTime(colortype, addTime, isOnlyGetSprite)
	local sprite = TileAddTime:create(colortype, addTime)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	if isOnlyGetSprite then 
		return sprite
	else
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
		self.itemShowType = ItemSpriteItemShowType.kCharacter
	end
end

function ItemView:buildAddMove(colortype, numAddMove, isOnlyGetSprite)
	local sprite = TileAddMove:create(colortype, numAddMove)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	if isOnlyGetSprite then 
		return sprite
	else
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
		self.itemShowType = ItemSpriteItemShowType.kCharacter
	end
end

function ItemView:buildVenom()
	local sprite = TileVenom:create()
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	sprite:playNormalAnimation()
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:buildPoisonBottle(forbiddenLevel, isOnlyGetSprite)
	if not forbiddenLevel then forbiddenLevel = 0 end
	local sprite = TilePoisonBottle:create()
	if forbiddenLevel == 0 then
		sprite:playNormalAnimation()
	else
		sprite:playForbiddenLevelAnimation(forbiddenLevel, false, nil)
	end
	if isOnlyGetSprite then 
		return sprite
	else
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
	end

end

function ItemView:buildCoin()
	local sprite = TileCoin:create()
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemShowType = ItemSpriteItemShowType.kCoin
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:buildMagicLamp(color, level)
	local sprite = TileMagicLamp:create(color, level)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:buildWukong(data)
	local sprite = TileWukong:create(data)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:changeWukongState(state , callback)
	local sprite = self:getWukongSprite()
	if sprite then
		
		if sprite.state ~= state then
			if state == TileWukongState.kReadyToJump then
				self.itemSprite[ItemSpriteType.kItemShow] = nil
				sprite:getParent():removeChild(sprite , false)
				self.itemSprite[ItemSpriteType.kSnailMove] = sprite
				self.isNeedUpdate = true
			elseif sprite.state == TileWukongState.kReadyToJump and state == TileWukongState.kOnActive then
				self.itemSprite[ItemSpriteType.kSnailMove] = nil
				sprite:getParent():removeChild(sprite , false)

				self.itemSprite[ItemSpriteType.kItemShow] = sprite
				self.isNeedUpdate = true
			end
		end

		sprite:changeState(state , callback)
	end
end

function ItemView:changeWukongColor(color , callback)
	local sprite = self:getWukongSprite()
	if sprite then
		sprite:setColor(color , callback)
	end
end

function ItemView:getWukongSprite()
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if not sprite then
		sprite = self.itemSprite[ItemSpriteType.kSnailMove]
	end
	return sprite
end

function ItemView:onWukongJumpFin()
	local sprite = self.itemSprite[ItemSpriteType.kSnailMove]
	
	if sprite then
		sprite:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kSnailMove] = nil
	end

	--[[
	sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite then
		sprite:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kItemShow] = nil
	end
	]]

	sprite = self.itemSprite[ItemSpriteType.kRoostFly]
	
	if sprite then
		sprite:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kRoostFly] = nil
	end
end

function ItemView:playWukongJumpAnimation(toPos, completeCallback , nojump)
	local sprite = nil
	local context = self
	local function onAnimComplete()
		--[[
		if sprite and sprite:getParent() then
			sprite:removeFromParentAndCleanup(true)
			context.itemSprite[ItemSpriteType.kRoostFly] = nil
			context.isNeedUpdate = true
		end
		--]]
	end

	if nojump then
		setTimeOut( function ()

			local locksprite = self.itemSprite[ItemSpriteType.kRoostFly]
	
			if locksprite then
				locksprite:removeFromParentAndCleanup(false)
				self.itemSprite[ItemSpriteType.kRoostFly] = nil
			end

			local sprite = self.itemSprite[ItemSpriteType.kSnailMove]
	
			if sprite then
				sprite:removeFromParentAndCleanup(false)
				self.itemSprite[ItemSpriteType.kSnailMove] = nil
			end

			self.itemSprite[ItemSpriteType.kItemShow] = sprite
			self.isNeedUpdate = true

		end , 1.8 )

		setTimeOut( function ()
			if completeCallback then completeCallback() end
		end , 2 )

		local monkey = self.itemSprite[ItemSpriteType.kItemShow]
		self.itemSprite[ItemSpriteType.kItemShow] = nil
		monkey:getParent():removeChild(monkey , false)
		

		sprite = monkey

		local lockrect = TileWukongEff:create()
		--local pos = self:getBasePosition(self.x, self.y)
		local pos = self:getBasePosition( 1,1 )
		lockrect:setPosition(pos)
		self.itemSprite[ItemSpriteType.kRoostFly] = lockrect

		self.itemSprite[ItemSpriteType.kSnailMove] = sprite
		self.isNeedUpdate = true

	else
		--[[
		local monkey = self.itemSprite[ItemSpriteType.kItemShow]
		if monkey then
			self.itemSprite[ItemSpriteType.kItemShow] = nil
			monkey:getParent():removeChild(monkey , false)
		end
		]]
		
		sprite = self:getWukongSprite()

		local fromCCP = self:getBasePosition(self.x, self.y)
		local toCCP = self:getBasePosition(toPos.x, toPos.y)

		local controlPoint = nil
		if fromCCP.y < toCCP.y then
			controlPoint = ccp(toCCP.x - (toCCP.x - fromCCP.x) / 5, toCCP.y + 350)
		elseif fromCCP.y > toCCP.y then
			if fromCCP.x == toCCP.x then
				controlPoint = ccp(fromCCP.x, fromCCP.y)
			else
				controlPoint = ccp(fromCCP.x - (fromCCP.x - toCCP.x) / 5, fromCCP.y + 240)
			end
		elseif fromCCP.y == toCCP.y then
			controlPoint = ccp(fromCCP.x - (fromCCP.x - toCCP.x) / 2, fromCCP.y + 360)
		end

		local bezierConfig = ccBezierConfig:new()
		bezierConfig.controlPoint_1 = fromCCP
		bezierConfig.controlPoint_2 = controlPoint
		bezierConfig.endPosition = toCCP
		local bezierAction = CCBezierTo:create(2, bezierConfig)
		local callbackAction = CCCallFunc:create(completeCallback)
		local delayAction = CCDelayTime:create(0.3)

		local actionList = CCArray:create()
		actionList:addObject(bezierAction)
		actionList:addObject(callbackAction)
		actionList:addObject(delayAction)
		actionList:addObject(CCCallFunc:create(onAnimComplete))
		-- local sequenceAction = CCSequence:createWithTwoActions(bezierAction, callbackAction)
		local sequenceAction = CCSequence:create(actionList)

		
		--sprite = TileWukong:createByAnimation()

		sprite:setPosition(fromCCP)

		sprite:runAction(sequenceAction)

		local scaleArr = CCArray:create()
		scaleArr:addObject( CCEaseSineIn:create( CCScaleTo:create( 1.3 , 1.8 , 1.8) ) )
		scaleArr:addObject( CCEaseSineOut:create( CCScaleTo:create( 0.7 , 1 , 1) ) )
		sprite:runAction(CCSequence:create(scaleArr))

		----[[
		self.itemSprite[ItemSpriteType.kSnailMove] = sprite
		self.isNeedUpdate = true
		--]]

		local lockrect = TileWukongEff:create()
		--local pos = self:getBasePosition(self.x, self.y)
		local pos = self:getBasePosition( 1,1 )
		lockrect:setPosition(pos)
		self.itemSprite[ItemSpriteType.kRoostFly] = lockrect
	end
	

end

function ItemView:buildRabbitCave()
	local bg = Sprite:createWithSpriteFrameName("rabbit_cave_0000")
	self.itemSprite[ItemSpriteType.kRabbitCaveDown] = bg

	local fg = Sprite:createWithSpriteFrameName("rabbit_cave_0001")
	self.itemSprite[ItemSpriteType.kRabbitCaveUp] = fg

end

function ItemView:buildRabbit(color, level, isPlayAnimation, isOnlyGetSprite)
	local sprite = TileRabbit:create(color, level)
	if isOnlyGetSprite then
		return sprite
	else
		local pos = self:getBasePosition(self.x, self.y)
		self.itemShowType = ItemSpriteItemShowType.kRabbit
		sprite:setPosition(pos)
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
		if isPlayAnimation then 
			sprite:playUpAnimation(nil, true)
		end
	end
end

function ItemView:buildRoost(roostLevel)
	local sprite = TileRoost:create(roostLevel)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:playRoostUpgradeAnimation(times)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	sprite:playUpgradeAnimation(times)
end

function ItemView:playRoostReplaceAnimation(completeCallback)
	local function onAnimComplete(evt)
		if completeCallback ~= nil and type(completeCallback) == "function" then
			completeCallback()
		end
	end
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	sprite:ad(Events.kComplete, onAnimComplete)
	sprite:playReplaceAnimation()
end

function ItemView:playRoostReplaceFlyAnimation(fromPos, completeCallback)
	local sprite = nil
	local context = self
	local function onAnimComplete()
		if sprite and sprite:getParent() then
			sprite:removeFromParentAndCleanup(true)
			context.itemSprite[ItemSpriteType.kRoostFly] = nil
			context.isNeedUpdate = true
		end
	end

	local fromCCP = self:getBasePosition(fromPos.y, fromPos.x)
	local toCCP = self:getBasePosition(self.x, self.y)

	local controlPoint = nil
	if fromCCP.y < toCCP.y then
		controlPoint = ccp(toCCP.x - (toCCP.x - fromCCP.x) / 5, toCCP.y + 350)
	elseif fromCCP.y > toCCP.y then
		if fromCCP.x == toCCP.x then
			controlPoint = ccp(fromCCP.x, fromCCP.y)
		else
			controlPoint = ccp(fromCCP.x - (fromCCP.x - toCCP.x) / 5, fromCCP.y + 240)
		end
	elseif fromCCP.y == toCCP.y then
		controlPoint = ccp(fromCCP.x - (fromCCP.x - toCCP.x) / 2, fromCCP.y + 360)
	end

	local bezierConfig = ccBezierConfig:new()
	bezierConfig.controlPoint_1 = fromCCP
	bezierConfig.controlPoint_2 = controlPoint
	bezierConfig.endPosition = toCCP
	local bezierAction = CCBezierTo:create(0.6, bezierConfig)
	local callbackAction = CCCallFunc:create(completeCallback)
	local delayAction = CCDelayTime:create(0.3)

	local actionList = CCArray:create()
	actionList:addObject(bezierAction)
	actionList:addObject(callbackAction)
	actionList:addObject(delayAction)
	actionList:addObject(CCCallFunc:create(onAnimComplete))
	-- local sequenceAction = CCSequence:createWithTwoActions(bezierAction, callbackAction)
	local sequenceAction = CCSequence:create(actionList)

	sprite = TileRoost:createFlyEffect()
	sprite:setPosition(fromCCP)
	-- sprite:ad(Events.kComplete, onAnimComplete)
	sprite:runAction(sequenceAction)
	self.itemSprite[ItemSpriteType.kRoostFly] = sprite
	self.isNeedUpdate = true
end

function ItemView:playDigGroundDecAnimation( boardView )
	-- body
	local sprite = self.itemSprite[ItemSpriteType.kDigBlocker]
	
	local function callback( ... )
		-- body
		sprite:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kDigBlockerBomb] = nil
	end

	if sprite then 
		if sprite.level == 1 then
			self.itemSprite[ItemSpriteType.kDigBlocker] = nil
			if boardView and container then
				sprite:removeFromParentAndCleanup(false)
				self.itemSprite[ItemSpriteType.kDigBlockerBomb] = sprite
			end
			sprite:changeLevel(sprite.level -1, callback)
		else 
			sprite:changeLevel(sprite.level - 1)
		end
	end
end

function ItemView:playDigJewelDecAnimation( boardView )
	-- body
	local sprite = self.itemSprite[ItemSpriteType.kDigBlocker]
	local function callback( ... )
		-- body
		sprite:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kDigBlockerBomb] = nil
		
	end

	if sprite then 
		if sprite.level == 1 then
			self.itemSprite[ItemSpriteType.kDigBlocker] = nil
			if boardView and container then 
				sprite:removeFromParentAndCleanup(false)
				self.itemSprite[ItemSpriteType.kDigBlockerBomb] = sprite
			end
			sprite:changeLevel(sprite.level -1, callback)
		else
			sprite:changeLevel(sprite.level - 1, true)
		end
		
	end
end

function ItemView:playDigGoldZongZiDecAnimation( boardView )
	-- body
	local sprite = self.itemSprite[ItemSpriteType.kDigBlocker]
	local function callback( ... )
		-- body
		--sprite:removeFromParentAndCleanup(true)
		--self.itemSprite[ItemSpriteType.kDigBlockerBomb] = nil
		
	end

	if sprite then 
		if sprite.level == 1 then
			sprite:changeLevel(sprite.level - 1, true)
		else
			sprite:changeLevel(sprite.level - 1, true)
		end
		
	end
end

function ItemView:playBottleBlockerHitAnimation(boardView , newLevel , newColor)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite then

		local onAnimationDone = function()

		end

		sprite:playBottleHitAnimation(newLevel + 1 , newColor , onAnimationDone)
		if newLevel == 0 then
			local anime = sprite:buildTotalBreakEffect(nil , nil)
			local pos = sprite:getPosition()
			anime:setPosition(ccp(pos.x , pos.y))
			self.itemSprite[ItemSpriteType.kTileMoveEffect] = anime
			self.isNeedUpdate = true
		end
	end
end

function ItemView:buildMonster()
	-- body
	local monster = TileMonster:create()
	self.itemSprite[ItemSpriteType.kBigMonster] = monster
	
end

function ItemView:buildBoss(data)
	local boss = TileBoss:create(BossType.kDeer)
	self.itemSprite[ItemSpriteType.kBigMonster] = boss
	self:updateBossBlood(data.blood/data.maxBlood, false, tostring(data.blood)..'/'..tostring(data.maxBlood))
	self:upDatePosBoardDataPos(data)
end

function ItemView:updateBossBlood(value, playAnim, debug_string)
	local s = self.itemSprite[ItemSpriteType.kBigMonster]
	if s then
		s:setBloodPercent(value, playAnim, debug_string)
	end
end

function ItemView:buildBlackCuteBall( strength, isOnlyGetSprite )
	-- body
	local blackcute = TileBlackCuteBall:create(strength)
	if isOnlyGetSprite then 
		return blackcute
	else
		self.itemSprite[ItemSpriteType.kItemShow] = blackcute
	end
end

function ItemView:playBlackCuteBallDecAnimation( strength , callback)
	-- body
	local item = self:getGameItemSprite()
	if item then 
		if strength == 2 then 
			item:playLife2(callback)
		elseif strength == 1 then 
			item:playLife1(callback)
		elseif strength == 0 then
			item:playLife0(callback)
		end
	end
end

function ItemView:playBlackCuteBallJumpToAnimation( r, c, midcallback, callback )
	-- body
	local sprite = self:getGameItemSprite()
	local toPos = self:getBasePosition(c, r)
	local function animationCallback( ... )
		-- body
		if callback then callback() end
	end
	if sprite then 
		sprite:playJumpToAnimation(toPos, midcallback, animationCallback)
	else
	end
end

function ItemView:buildMimosa(data, isOnlyGetSprite)
	-- body
	local mimosa = TileMimosa:create(data.mimosaDirection)
	if isOnlyGetSprite then
		return mimosa
	else
		mimosa:playIdleAnimation()
		self.itemSprite[ItemSpriteType.kItemShow] = mimosa
	end
end

function ItemView:addMimosaEffect( itemType, direction )
	-- body
	local container = Sprite:createEmpty()
	local mask = Sprite:createWithSpriteFrameName("mimosa_mask")
	container:addChild(mask)
	if itemType == GameItemType.kKindMimosa then
		mask:setAlpha(0)
	else
		mask:setAlpha(0.8)
	end
	container.mask = mask

	local sprite = Sprite:createWithSpriteFrameName("mimosa.grow.up_0026")
	container:addChild(sprite)
	container.mimosaLefa = sprite

	if direction == 1 then
		container:setRotation(-90)
	elseif direction == 2 then
		container:setRotation(90)
	elseif direction == 3 then
		container:setRotation(0)
	else
		container:setRotation(180)
	end
	container:setPosition(self:getBasePosition(self.x, self.y))
	self.itemSprite[ItemSpriteType.kNormalEffect] = container
end

function ItemView:playMimosaBackAnimation(delaytime,callback)
	-- body
	if self.isPlayBackAnimation then 
		if callback then callback() end
		return
	end

	local sprite = self:getGameItemSprite()
	self.isPlayBackAnimation = true
	if sprite then
		local function play( ... )
			-- body
			sprite:playBackAnimation(callback)
			self.isPlayBackAnimation = nil
		end 
		sprite:runAction(CCSequence:createWithTwoActions(CCDelayTime:create(delaytime), CCCallFunc:create(play)))
	end
end

function ItemView:playMimosaGrowAnimation( callback )
	-- body
	local sprite = self:getGameItemSprite()
	if sprite then
		sprite:playGrowAnimation(callback)
	end
end

function ItemView:playMimosaEffectGrow( itemType, direction, delay, callback)
	-- body
	local container = Sprite:createEmpty()
	local mask = Sprite:createWithSpriteFrameName("mimosa_mask")
	container:addChild(mask)
	mask:setAlpha(0)
	container.mask = mask
	if not self.itemSprite[ItemSpriteType.kNormalEffect] and itemType == GameItemType.kMimosa then 
		mask:runAction(CCSequence:createWithTwoActions(CCDelayTime:create(delay + 0.4), CCFadeTo:create(0.3, 255 * 0.8)))
	end

	self.isNeedUpdate = true
	local sprite = Sprite:createWithSpriteFrameName("mimosa.grow.up_0000")
	delay = delay or 0
	local frames = SpriteUtil:buildFrames("mimosa.grow.up_%04d", 0, 27)
	local animate = SpriteUtil:buildAnimate(frames, 1/30)
	local function animationCallback( ... )
		-- body
		if self.itemSprite[ItemSpriteType.kNormalEffect] then
			container:removeFromParentAndCleanup(true)
		else
			if itemType == GameItemType.kMimosa then
				mask:setAlpha(0.8)
			else
				mask:setAlpha(0)
			end
			self.itemSprite[ItemSpriteType.kNormalEffect] = container
			self.itemSprite[ItemSpriteType.kSpecial]:removeFromParentAndCleanup(false)
			self.getContainer(ItemSpriteType.kNormalEffect):addChild(container)
		end
		self.itemSprite[ItemSpriteType.kSpecial] = nil
		self.isNeedUpdate = true
		if callback then callback() end
	end
	sprite:play(animate, delay, 1, animationCallback )

	container:addChild(sprite)
	container.mimosaLefa = sprite

	if direction == 1 then
		container:setRotation(-90)
	elseif direction == 2 then
		container:setRotation(90)
	elseif direction == 3 then
		container:setRotation(0)
	else
		container:setRotation(180)
	end
	self.itemSprite[ItemSpriteType.kSpecial] = container
	container:setPosition(self:getBasePosition(self.x, self.y))
end

function ItemView:playMimosaEffectBack( itemType, direction, delay, callback )
	-- body
	delay = delay or 0
	-- delay = 0
	local sprite = self.itemSprite[ItemSpriteType.kNormalEffect]
	if sprite then
		local mimosaLefa = sprite.mimosaLefa
		local mask = sprite.mask
		if mask and itemType == GameItemType.kMimosa then 
			mask:runAction(CCSequence:createWithTwoActions(CCDelayTime:create(delay), CCFadeOut:create(0.3)) )
		end

		local function animationCallback( ... )
		-- body
			sprite:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kNormalEffect] = nil	
			if callback then callback() end
		end
		local function startAnimation( ... )
			-- body
			local frames = SpriteUtil:buildFrames("mimosa.grow.up_%04d", 0, 27, true)
			local animate = SpriteUtil:buildAnimate(frames, 1/30)
			mimosaLefa:play(animate, 0, 1, animationCallback )
		end
		mimosaLefa:runAction(CCSequence:createWithTwoActions(CCDelayTime:create(delay), CCCallFunc:create(startAnimation) ))
	end

end

function ItemView:playMimosaEffectAnimation( itemType, direction, delay, callback, isGrow )
	-- body
	if isGrow then
		self:playMimosaEffectGrow( itemType, direction, delay, callback)
	else
		self:playMimosaEffectBack( itemType, direction, delay, callback )
	end
end

function ItemView:playMimosaReadyAnimation( ... )
	-- body
	local sprite = self:getGameItemSprite()
	if sprite then
		sprite:playActivieAnimation()
	end
end


function ItemView:buildSnail( snailRoadType )
	-- body
	local sprite = TileSnail:create()
	sprite:setPosition(self:getBasePosition(self.x, self.y))
	self.itemSprite[ItemSpriteType.kSnail] = sprite
	if snailRoadType == RouteConst.kLeft then 
		sprite:setScaleX(-1)
	end
	sprite:updateArrow(snailRoadType)
end

function ItemView:playHedgehogOut( callback )
	-- body
	local function _callback( ... )
		-- body
		if callback then callback() end
	end
	local sp = self.itemSprite[ItemSpriteType.kSnail]
	if sp then
		sp:playHedgehogOutAnimation(_callback)
	else
		_callback()
	end

end
function ItemView:buildHedgehog( roadType, hedgehogLevel, isbefore )
	-- body
	local sprite = TileHedgehog:create(hedgehogLevel,isbefore)
	sprite:setPosition(self:getBasePosition(self.x, self.y))
	self.itemSprite[ItemSpriteType.kSnail] = sprite
	if roadType == RouteConst.kLeft then 
		sprite:setScaleX(-1)
	end
	sprite:updateArrow(roadType)
end

-----创建掉落中被裁减的物品的sprite
function ItemView:CreateFallingClippingSprite(data, autotype)
	local tempsprite = nil;
	-------毒液，雪花不参与裁减掉落的计算-----
	if data.ItemType == GameItemType.kAnimal then 				----动物
		tempsprite = self:buildNewAnimalItem(data.ItemColorType, data.ItemSpecialType, false, autotype)
	elseif data.ItemType == GameItemType.kCrystal then  		--由系统统一计算
		tempsprite = ItemViewUtils:buildCrystal(data.ItemColorType)
	elseif data.ItemType == GameItemType.kGift then				--由系统统一计算
		tempsprite = ItemViewUtils:buildGift(data.ItemColorType)
	elseif data.ItemType == GameItemType.kIngredient then 		--添加一个豆荚
		local beanpod = ItemViewUtils:buildBeanpod(data.showType) 			--创建豆荚
		tempsprite = beanpod; 		--添加
	elseif data.ItemType == GameItemType.kCoin then
		tempsprite = TileCoin:create()
	elseif data.ItemType == GameItemType.kBalloon then
		tempsprite = TileBalloon:create(data.ItemColorType, data.balloonFrom)
	elseif data.ItemType == GameItemType.kBlackCuteBall then
		tempsprite = TileBlackCuteBall:create(data.blackCuteStrength)
	elseif data.ItemType == GameItemType.kRabbit then
		tempsprite = TileRabbit:create(data.ItemColorType)
	elseif data.ItemType == GameItemType.kHoneyBottle then
		tempsprite = TileHoneyBottle:create(data.honeyBottleLevel)
	elseif data.ItemType == GameItemType.kAddTime then
		tempsprite = TileAddTime:create(data.ItemColorType, data.addTime)
	elseif data.ItemType == GameItemType.kQuestionMark then
		tempsprite = ItemViewUtils:createQuestionMark(data.ItemColorType)
	elseif data.ItemType == GameItemType.kAddMove then
		tempsprite = self:buildAddMove(data.ItemColorType, data.numAddMove, true)
	elseif data.ItemType == GameItemType.kRocket then
		tempsprite = self:buildRocket(data.ItemColorType, true)
	elseif data.ItemType == GameItemType.kCrystalStone then
		tempsprite = self:buildCrystalStone(data.ItemColorType, data.crystalStoneEnergy, data.crystalStoneBombType, true)
	elseif data.ItemType == GameItemType.kTotems then
		tempsprite = self:buildTotems(data.ItemColorType, data:isActiveTotems(), true)
	elseif data.ItemType == GameItemType.kDrip then
		tempsprite = self:buildDrip(true)
	else
		he_log_error("unexcepted item type:"..tostring(data.ItemType))
	end 

	if not tempsprite then
		local logMsg = string.format("failed to create item.ItemType=%s,ColorType=%s,SpecialType=%s", 
			tostring(data.ItemType), 
			tostring(AnimalTypeConfig.convertColorTypeToIndex(data.ItemColorType)), 
			tostring(AnimalTypeConfig.convertSpecialTypeToIndex(data.ItemSpecialType)))
		he_log_error(logMsg)
	end
	
	local container = Sprite:createEmpty()
	tempsprite:setPosition(ccp(0, 0))
	container:addChild(tempsprite)

	--附加属性
	if data.furballLevel > 0 then
		local furballsprite = ItemViewUtils:buildFurball(data.furballType)
		container:addChild(furballsprite)
	end

	return container
end

----为裁减区域添加一个节点
function ItemView:buildClippingNode()
	if self.clippingnode == nil then
		local pos = self:getBasePosition(self.x,self.y)-------回头还得加上从外面传来的偏移量
		--self.clippingnode = ClippingNode:create(CCRectMake(0, 0, self.w, self.cl_h))
		local clippingnode = SimpleClippingNode:create()
		clippingnode:setContentSize(CCSizeMake(self.w, self.cl_h))
		clippingnode:setPosition(ccp(pos.x - self.w / 2, pos.y - self.h / 2))
		self.clippingnode = clippingnode
	end
end

function ItemView:buildEnterClippingNode()
	if self.enterClippingNode == nil then
		local pos = self:getBasePosition(self.x, self.y)
		--self.enterClippingNode = ClippingNode:create(CCRectMake(0, 0, self.w, self.cl_h))
		local clippingnode = SimpleClippingNode:create()
		clippingnode:setContentSize(CCSizeMake(self.w, self.cl_h))
		clippingnode:setPosition(ccp(pos.x - self.w / 2, pos.y - self.h / 2))
		self.enterClippingNode = clippingnode
	end
end



----删除裁减节点的所有子节点
function ItemView:removeAllChildOfClippingNode()
	if self.clippingnode == nil then return false end
	if self.itemSprite[ItemSpriteType.kClipping] then
		self.itemSprite[ItemSpriteType.kClipping]:removeFromParentAndCleanup(true)
	end
	self.clippingnode:removeChildren() 			----删除所有子节点
	return true
end

function ItemView:removeAllChildOfEnterClippingNode()
	if self.enterClippingNode == nil then return false end
	if self.itemSprite[ItemSpriteType.kEnterClipping] then
		self.itemSprite[ItemSpriteType.kEnterClipping]:removeFromParentAndCleanup(true)
	end
	self.enterClippingNode:removeChildren()
	return true
end

function ItemView:addSpriteToClippingNode(theSprite)
	self:buildClippingNode()
	self.itemSprite[ItemSpriteType.kClipping] = theSprite
	if theSprite ~= nil then
		if theSprite:getParent() then theSprite:removeFromParentAndCleanup(false) end
		self.clippingnode:addChild(theSprite)
	end
end

function ItemView:addSpriteToEnterClippingNode(theSprite)
	self:buildEnterClippingNode()
	self.itemSprite[ItemSpriteType.kEnterClipping] = theSprite
	if theSprite ~= nil then
		if theSprite:getParent() then theSprite:removeFromParentAndCleanup(false) end
		self.enterClippingNode:addChild(theSprite)
	end
end

----将一个数据里面的东西添加到ClippingNode
function ItemView:FallingDataIntoClipping(data)
	local tempsprite = nil
	tempsprite = self:CreateFallingClippingSprite(data, true)
	tempsprite:setPositionXY(self.w / 2, self.h * 1.5)

	self:removeAllChildOfClippingNode() 			----删除原有Clipping的子节点
	self:addSpriteToClippingNode(tempsprite)		----将新的进行添加

	self:cleanGameItemView()
	self.isNeedUpdate = true
end

-----将裁减点里面的东西放入正常的Sprite
function ItemView:takeClippingNodeToSprite(data)
	self:cleanClippingSpriteOfItem()
	self:initByItemData(data)
end

----将一个东西通过Clipping掉出格子
function ItemView:FallingDataOutOfClipping(data)
	local tempsprite = nil
	tempsprite = self:CreateFallingClippingSprite(data, false)
	tempsprite:setPositionXY(self.w / 2, self.h / 2)

	self:removeAllChildOfEnterClippingNode()
	self:addSpriteToEnterClippingNode(tempsprite)
	self:cleanGameItemView()
	self.isNeedUpdate = true
end

----
function ItemView:cleanClippingSpriteOfItem()
	if self.itemSprite[ItemSpriteType.kClipping] then 
		self.itemSprite[ItemSpriteType.kClipping]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kClipping] = nil
		self.isNeedUpdate = true
	end
end

function ItemView:cleanEnterClippingSpriteOfItem()
	if self.itemSprite[ItemSpriteType.kEnterClipping] then 
		self.itemSprite[ItemSpriteType.kEnterClipping]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kEnterClipping] = nil
		self.isNeedUpdate = true
	end
end

----播放获取分数的特效动作
----num为分数
----posEnd为最后消失的位置
----posType用来设置不同的位置类型,以便在屏幕上错开位置
function ItemView:playGetScoreAction(boardView, num, posEnd, posType, labelBatch)
	local str = string.format("%d", num);
	local ScoreLabel = labelBatch:createLabel(str);

	local pos = self:getBasePosition(self.x, self.y);
	-- local pos = boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x)

	local pos_start = ccp(pos.x - self.w / 2, pos.y - self.h /2+50)
	local pos_2 = ccp(pos.x - self.w / 2, pos.y + self.h /2)
	if posEnd == nil then
		posEnd = ccp(0, 800)
	end

	ScoreLabel:setPosition(pos_start);
	local startMoveAction = CCMoveTo:create(BoardViewAction:getActionTime(GamePlayConfig_Score_MatchDeleted_UP_Time), pos_2);
	local stopMoveAction = CCDelayTime:create(BoardViewAction:getActionTime(GamePlayConfig_Score_MatchDeleted_Stop_Time));
	local flyOutAction = CCFadeOut:create(BoardViewAction:getActionTime(GamePlayConfig_Score_MatchDeleted_Fly_Time))			----渐隐效果
	ScoreLabel:setScale(GamePlayConfig_Score_MatchDeleted_Scale)

	local function onRepeatFinishCallback_GetScore()
		if ScoreLabel and ScoreLabel:getParent() then
			ScoreLabel:removeFromParentAndCleanup(true);
		end
	end

	local callAction = CCCallFunc:create(onRepeatFinishCallback_GetScore);
	local array = CCArray:create()
    array:addObject(startMoveAction)
    array:addObject(stopMoveAction)
    array:addObject(flyOutAction)
    array:addObject(callAction)
	local sequenceAction = CCSequence:create(array)

	ScoreLabel:runAction(sequenceAction);
	return ScoreLabel;
end

----刷新特效，某个sprite放入kSpecial层，飞向目标位置
----item2为飞向的目标
function ItemView:flyingSpriteIntoItem(item2)
	if self.x == item2.x and self.y == item2.y then return end;		----自己和自己不交换

	if item2.itemSprite[ItemSpriteType.kItem] ~= nil then
		self.flyingfromtype = ItemSpriteType.kItem 												----记录来源
		self.itemSprite[ItemSpriteType.kSpecial] = item2.itemSprite[ItemSpriteType.kItem]; 		----传输
		self.itemSprite[ItemSpriteType.kSpecial]:removeFromParentAndCleanup(false);				----离开原有面板
		item2.itemSprite[ItemSpriteType.kItem] = nil;											----删除值
	elseif item2.itemSprite[ItemSpriteType.kItemShow] ~= nil then
		self.flyingfromtype = ItemSpriteType.kItemShow 											----记录来源
		self.itemSprite[ItemSpriteType.kSpecial] = item2.itemSprite[ItemSpriteType.kItemShow]; 	----传输
		self.itemSprite[ItemSpriteType.kSpecial]:removeFromParentAndCleanup(false);				----离开原有面板
		item2.itemSprite[ItemSpriteType.kItemShow] = nil;										----删除值
	end
end

----刷新特效结束，kSpecial层的物品进入普通层
function ItemView:flyingSpriteIntoItemEnd()
	if self.itemSprite[ItemSpriteType.kSpecial] then
		if (self.itemSprite[self.flyingfromtype] ~= nil ) then
			self.itemSprite[self.flyingfromtype]:removeFromParentAndCleanup(true)
			self.itemSprite[self.flyingfromtype] = nil
		end
		self.itemSprite[self.flyingfromtype] = self.itemSprite[ItemSpriteType.kSpecial]
		self.itemSprite[self.flyingfromtype]:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kSpecial] = nil
		self.isNeedUpdate = true
	end
end

----播放收集豆荚的动画
function ItemView:playCollectIngredientAction(itemShowType, boardView, posEnd)
	if self.itemSprite[ItemSpriteType.kItem] then
		local item = self.itemSprite[ItemSpriteType.kItem]
		local sprite = ItemViewUtils:buildBeanpod(itemShowType)
		if boardView.PlayUIDelegate and boardView.PlayUIDelegate.effectLayer then
			boardView.PlayUIDelegate.effectLayer:addChild(sprite, 0)
			sprite:setPosition(boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x))
		end
		item:runAction(CCScaleTo:create(BoardViewAction:getActionTime(GamePlayConfig_DropDown_Ingredient_ScaleTime), 0))
		local position = boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x)
		if itemShowType and itemShowType == IngredientShowType.kAcorn then 
			position.y = position.y - GamePlayConfig_DropDown_Acorn_CollectPos * GamePlayConfig_Tile_Height
		else
			position.y = position.y - GamePlayConfig_DropDown_Ingredient_CollectPos * GamePlayConfig_Tile_Height
		end

		local function onRepeatFinishCallback_MoveIngredient()
			sprite:removeFromParentAndCleanup(true)
			if boardView.PlayUIDelegate then
				local ingred_Left = boardView.gameBoardLogic.ingredientsTotal - boardView.gameBoardLogic.ingredientsCount
				boardView.PlayUIDelegate:setTargetNumber(0, 0, ingred_Left, position)
			end
		end

		local collect = CCSpawn:createWithTwoActions(CCMoveTo:create(BoardViewAction:getActionTime(GamePlayConfig_DropDown_Ingredient_CollectTime),
			position), CCScaleTo:create(BoardViewAction:getActionTime(GamePlayConfig_DropDown_Ingredient_CollectTime), GamePlayConfig_DropDown_Ingredient_CollectScale))
		sprite:runAction(CCSequence:createWithTwoActions(collect, CCCallFunc:create(onRepeatFinishCallback_MoveIngredient)))
	end
end

function ItemView:playChangeCrystalColor(color)
	local spritenew = ItemViewUtils:buildCrystal(color);
	local spriteold = self.itemSprite[ItemSpriteType.kItem];
	local changeLight = Sprite:createWithSpriteFrameName("crystal_anim0000")
	local changeFrame = SpriteUtil:buildFrames("crystal_anim%04d", 0, 20)
	local changeAnim = SpriteUtil:buildAnimate(changeFrame, kCharacterAnimationTime)
	if spriteold then
		if spriteold:getParent() then
			spriteold:getParent():addChild(spritenew)
			spritenew:setPosition(self:getBasePosition(self.x,self.y));
			spritenew:setAlpha(0)
		end

		self.itemSprite[ItemSpriteType.kSpecial] = changeLight
		changeLight:setPosition(self:getBasePosition(self.x, self.y))
		self.isNeedUpdate = true
		changeLight:play(changeAnim)

		local Fade_Action1 = CCFadeOut:create(BoardViewAction:getActionTime(GamePlayConfig_CrystalChange_time));
		local Fade_Action2 = CCFadeIn:create(BoardViewAction:getActionTime(GamePlayConfig_CrystalChange_time));

		local context = self
		local function onCrystalColorChangeFinish()
			if spriteold then
				if spriteold:getParent() then
					spriteold:removeFromParentAndCleanup(true)
				end
				if changeLight:getParent() then
					changeLight:removeFromParentAndCleanup(true)
					context.itemSprite[ItemSpriteType.kSpecial] = nil
				end
			end
		end 
		local ccCallbackAction = CCCallFunc:create(onCrystalColorChangeFinish);
		local ccs1 = CCSequence:createWithTwoActions(Fade_Action1,ccCallbackAction);

		self.itemSprite[ItemSpriteType.kItem] = spritenew;

		spriteold:runAction(ccs1);
		spritenew:runAction(Fade_Action2);
	end
end

function ItemView:playAnimationAnimalDestroyByBird(itemPosition, birdPosition)
	local sprite1 = self.itemSprite[ItemSpriteType.kItem]------如果是kItemShow，肯定被直接炸掉了

	local item = self
	local function onAnimationFinished()
		if (sprite1) then
			sprite1:removeFromParentAndCleanup(true)
		end
		if item then
			item.itemSprite[ItemSpriteType.kSpecial] = nil 
		end
	end

	if sprite1 == nil then 			----如果是未能完全穿越通道的，则直接将其取出
		self:takeClippingNodeToSprite(self.oldData)
		sprite1 = self.itemSprite[ItemSpriteType.kItem];
	end
	self.itemSprite[ItemSpriteType.kItem] = nil;
	self.itemSprite[ItemSpriteType.kSpecial] = sprite1;

	local length = math.sqrt(math.pow(birdPosition.y - itemPosition.y, 2) + math.pow(birdPosition.x - itemPosition.x, 2))
	local thetime = 0.25 + 0.45 * length / (11 * GamePlayConfig_Tile_Width)
	local delayTime = 0.1
	local moveToAction = HeBezierTo:create(thetime, birdPosition, true, length * 0.618)
	local delayMoveAction = CCEaseSineIn:create(moveToAction)
	local scaleAction = CCEaseSineIn:create(CCScaleTo:create(thetime, 0.4))
	-- local delayScaleAction = CCSequence:createWithTwoActions(CCDelayTime:create(0.01), scaleAction)
	local rotateAction = CCRotateBy:create(thetime + delayTime, 90 + 270 * length / (11 * GamePlayConfig_Tile_Width))
	local callAction = CCCallFunc:create(onAnimationFinished)
	local deleteAction = CCSequence:createWithTwoActions(CCDelayTime:create(thetime + delayTime), callAction)
	local alphaAction = CCSequence:createWithTwoActions(CCDelayTime:create(thetime - 0.1), CCFadeOut:create(delayTime+0.1))

	local actionList = CCArray:create()
	actionList:addObject(delayMoveAction)
	actionList:addObject(scaleAction)
	actionList:addObject(rotateAction)
	actionList:addObject(deleteAction)
	actionList:addObject(alphaAction)
  	local spawnAction = CCSpawn:create(actionList)
  	local sequenceAction = CCSequence:createWithTwoActions(CCDelayTime:create(0.4 * math.random()), spawnAction)

  	if sprite1 == nil or not sprite1.refCocosObj then
  		print("sprite1 == nil", r1,c1)
  	else
  		sprite1:runAction(sequenceAction)
  	end
end

function ItemView:playShakeBySpecialColorEffect()
	local itemView, itemBackView, itemShowView = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemBack], self.itemSprite[ItemSpriteType.kItemShow]
	--动画效果，不使用随机种子
	local firstDir = 0
	if math.random() > 0.5 then 
		firstDir = 1
	else
		firstDir = -1
	end
	local rotateAngel = 6 + 3 * math.random()
	local rotateAction1 = CCRotateTo:create(0.08, firstDir * rotateAngel)
	local rotateAction2 = CCRotateTo:create(0.08, -firstDir * rotateAngel * 2)
	local actionList = CCArray:create()
	actionList:addObject(rotateAction1)
	actionList:addObject(rotateAction2)
	local sequenceAction = CCSequence:create(actionList)
	if itemView and itemView.refCocosObj then
		itemView:runAction(CCRepeatForever:create(sequenceAction))
	end
end

function ItemView:stopShakeBySpecialColorEffect()
	local itemView, itemBackView, itemShowView = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemBack], self.itemSprite[ItemSpriteType.kItemShow]
	if itemView and itemView.refCocosObj then
		itemView:stopAllActions()
		itemView:setRotation(0)
	end
end

function ItemView:showMoveTileEffect(dir)
	local effect = TileMove:createArrowAnimation(dir)
	effect:setPosition(self:getBasePosition(self.x, self.y))
	self.itemSprite[ItemSpriteType.kTileMoveEffect] = effect
	self.isNeedUpdate = true
end

function ItemView:hideMoveTileEffect()
	local effect = self.itemSprite[ItemSpriteType.kTileMoveEffect]
	if effect and not effect.isDisposed then
		effect:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kTileMoveEffect] = nil
	end
end

function ItemView:showAdviseEffect(dir)
	local itemView, itemBackView, itemShowView = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemBack], self.itemSprite[ItemSpriteType.kItemShow]
	local toX = 0
	local toY = 0
	if dir.r < 0 then 
		toY = 1
	elseif dir.r > 0 then
		toY = -1
	elseif dir.c > 0 then
		toX = 1
	elseif dir.c < 0 then
		toX = -1
	end

	local moveDistance = 2 
	local moveDistance2 = 4
	local moveAction1 = CCMoveBy:create(0.15, ccp(-toX * moveDistance, -toY * moveDistance))
	local moveAction2 = CCMoveBy:create(0.03, ccp(toX * moveDistance, toY * moveDistance))
	local moveAction3 = CCMoveBy:create(0.01, ccp(toX * moveDistance2, toY * moveDistance2))
	local moveAction4 = CCMoveBy:create(0.30, ccp(-toX * moveDistance2, -toY * moveDistance2))
	local actionList = CCArray:create()
	actionList:addObject(moveAction1)
	actionList:addObject(moveAction2)
	actionList:addObject(moveAction3)
	actionList:addObject(moveAction4)
	local sequenceAction = CCSequence:create(actionList)
	local repeatTimes = 3
	if itemView then
		itemView:runAction(CCRepeat:create(sequenceAction, repeatTimes))
	end
	if itemBackView then
		itemBackView:runAction(CCRepeat:create(sequenceAction, repeatTimes))
	end
	if itemShowView then
		itemShowView:runAction(CCRepeat:create(sequenceAction, repeatTimes))
	end
end

function ItemView:stopAdviseEffect()
	local itemView, itemBackView, itemShowView = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemBack], self.itemSprite[ItemSpriteType.kItemShow]
	if itemView then
		itemView:stopAllActions()
	end
	if itemBackView then
		itemBackView:stopAllActions()
	end
	if itemShowView then
		itemShowView:stopAllActions()
	end
end

function ItemView:playSelectEffect(data)
	if data.ItemType == GameItemType.kAnimal then
		if not AnimalTypeConfig.isSpecialTypeValid(data.ItemSpecialType) then
			local itemView = self.itemSprite[ItemSpriteType.kItem]
			if itemView and itemView.refCocosObj then
				itemView:setVisible(false)

				local sprite = TileCharacter:create(table.getMapValue(itemsName, data.ItemColorType))
				sprite:playSelectAnimation()
				local pos = self:getBasePosition(self.x, self.y)
				sprite:setPosition(pos)
				self.itemSprite[ItemSpriteType.kItemShow] = sprite
				self.isNeedUpdate = true
			end
		elseif data.ItemSpecialType == AnimalTypeConfig.kColor then
			local itemView = self.itemSprite[ItemSpriteType.kItemShow]
			if itemView then
				itemView:playSelectedAnimation()
			end

		end
	elseif data.ItemType == GameItemType.kRabbit then
		local itemView = self.itemSprite[ItemSpriteType.kItemShow]
		if itemView and itemView.refCocosObj then 
			itemView:playHappyAnimation()
		end
	elseif data.ItemType == GameItemType.kCrystalStone then
		local itemView = self.itemSprite[ItemSpriteType.kItemShow]
		if itemView and itemView.refCocosObj then 
			itemView:playSelectedAnimate()
		end
	elseif data.ItemType == GameItemType.kTotems then
		local itemView = self.itemSprite[ItemSpriteType.kItemShow]
		if itemView and itemView.refCocosObj then 
			itemView:playSelectedAnimate()
		end
	end

	if self.itemSprite[ItemSpriteType.kSpecial] == nil then
		local selectBorderEffect = ItemViewUtils:buildSelectBorder()
		local pos = self:getBasePosition(self.x,self.y);
		selectBorderEffect:setPosition(pos)
		self.itemSprite[ItemSpriteType.kSpecial] = selectBorderEffect
		self.isNeedUpdate = true
	end
end

function ItemView:stopSelectEffect(data)
	if data.ItemType == GameItemType.kAnimal then
		if not AnimalTypeConfig.isSpecialTypeValid(data.ItemSpecialType) then
			local itemView, itemShowView = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemShow]
			if itemView then
				itemView:setVisible(true)
			end
			if itemShowView then
				itemShowView:stopSelectAnimation()
				itemShowView:removeFromParentAndCleanup(true)
				self.itemSprite[ItemSpriteType.kItemShow] = nil
				self.isNeedUpdate = true
			end
		elseif data.ItemSpecialType == AnimalTypeConfig.kColor then
			local itemView = self.itemSprite[ItemSpriteType.kItemShow]
			if itemView then
				itemView:playNormalAnimation()
			end
		end
	elseif data.ItemType == GameItemType.kCrystalStone then
		local itemView = self.itemSprite[ItemSpriteType.kItemShow]
		if itemView then
			itemView:stopSelectedAnimate()
		end
	elseif data.ItemType == GameItemType.kTotems then
		local itemView = self.itemSprite[ItemSpriteType.kItemShow]
		if itemView then
			itemView:stopSelectedAnimate()
		end
	end

	local borderEffect = self.itemSprite[ItemSpriteType.kSpecial]
	if borderEffect then
		borderEffect:stopAllActions()
		borderEffect:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kSpecial] = nil
		self.isNeedUpdate = true
	end
end

------------------------balloon------------------
function ItemView:buildBalloon( data )
	local balloon =  TileBalloon:create(data.ItemColorType, data.balloonFrom)
	local pos = self:getBasePosition(self.x, self.y)
	balloon:setPosition(pos)
	self.itemShowType = ItemSpriteItemShowType.kCharacter
	self.itemSprite[ItemSpriteType.kItemShow] = balloon
end

function ItemView:updateBalloonStep( value )
	-- body
	local balloon = self:getItemSprite(ItemSpriteType.kItemShow)
	if balloon then balloon:updateShowNumber(value) end
end

function ItemView:playBalloonActionRunaway( boardView )


	local balloon = self:getItemSprite(ItemSpriteType.kItemShow)
	self.itemSprite[ItemSpriteType.kItemShow] = nil
	-- body
	local function callback( ... )
		-- body
		if balloon then
			balloon:removeFromParentAndCleanup(true)
		end
	end
	local scale = 1;
	if boardView and boardView.PlayUIDelegate and boardView.PlayUIDelegate.effectLayer then
		balloon:removeFromParentAndCleanup(false)
		boardView.PlayUIDelegate.effectLayer:addChild(balloon)
		scale = boardView.PlayUIDelegate.effectLayer:getScale();
		balloon:setPosition(boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x))
		
	end
	if balloon then balloon:playRunawayAnimation(scale, callback) end
end

function ItemView:playBalloonBombEffect( ... )
	-- body
	local s = self.itemSprite[ItemSpriteType.kItemShow]
	-- s:removeFromParentAndCleanup(true)
	if s then 
		self.itemSprite[ItemSpriteType.kItemShow] = nil
		GamePlayMusicPlayer:playEffect(GameMusicType.kBalloonBreak)
		local function onAnimComplete( evt )
			-- body
			if s then 
				s:removeFromParentAndCleanup(true)
			end
		end
		s.isNeedUpdate = true
		s:ad(Events.kComplete, onAnimComplete)
		s:playDestroyAnimation()

		local t3 = self.itemSprite[ItemSpriteType.kClipping];----正在穿越通道的物品，直接移除，因为已经有特效在播放了
		if (t3) then
			if t3:getParent() then t3:removeFromParentAndCleanup(true) end;
			self.itemSprite[ItemSpriteType.kClipping] = nil;
		end
	end
end

function ItemView:playRabbitDestroyAnimation()
	local s = self.itemSprite[ItemSpriteType.kItemShow]
	if s then
		s:removeFromParentAndCleanup(false)
		
		self.itemSprite[ItemSpriteType.kItemShow] = nil

		local function onAnimComplete()
			if s then s:removeFromParentAndCleanup(true) end
			self.itemSprite[ItemSpriteType.kNormalEffect] = nil
		end

		s:playDestroyAnimation(onAnimComplete)

		if self.getContainer(ItemSpriteType.kNormalEffect) and self.itemSprite[ItemSpriteType.kNormalEffect] == nil then
			self.getContainer(ItemSpriteType.kNormalEffect):addChild(s);
		else
			self.isNeedUpdate = true
		end
		self.itemSprite[ItemSpriteType.kNormalEffect] = s
	end
end


function ItemView:setTileBlockCoverSpriteVisible( value )
	-- body
	for i = ItemSpriteType.kSeaAnimal, ItemSpriteType.kLast do
		if self.itemSprite[i] ~= nil then
			if i == ItemSpriteType.kRope or i == ItemSpriteType.kPass or i == ItemSpriteType.kChain then 
			else
				self.itemSprite[i]:setVisible(value)
			end
		end
	end
end


function ItemView:playTileBoardUpdate( countDown, isReverseSide, callback, boardView)
	-- body
	local s = self.itemSprite[ItemSpriteType.kTileBlocker]
	if s then
		s:updateState(countDown)
	end

	local function animateCallback( ... )
		-- body
		if isReverseSide then 
			self:setTileBlockCoverSpriteVisible(true)
			if boardView.PlayUIDelegate and boardView.PlayUIDelegate.effectLayer then 
				stars = s:createStarSprite()
				stars:setPosition(boardView.gameBoardLogic:getGameItemPosInView(self.y, self.x))
				boardView.PlayUIDelegate.effectLayer:addChild(stars)
			end
		end

		if s then
			s:updateState(3)
		end
		if callback then callback() end
	end

	if countDown == 0 then 
		self.isNeedUpdate = true
		self:setTileBlockCoverSpriteVisible(false)
		s:playTurnAnimation(isReverseSide, animateCallback)
		
	else
		if callback then  callback() end
	end
end

function ItemView:playMonsterFrostingDec( callback )
	-- body
	local monster_frosting = self.itemSprite[ItemSpriteType.kBigMonsterIce]
	local function animationCallback( ... )
		-- body
		if monster_frosting then monster_frosting:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kBigMonsterIce] = nil
		if callback and type(callback) == "function" then callback() end
	end
	
	if monster_frosting then
		monster_frosting:playDestroyAnimation(animationCallback)
	end
end

function ItemView:playMonsterEncourageAnimation( ... )
	-- body
	local monster = self.itemSprite[ItemSpriteType.kBigMonster]
	if monster then monster:playEncourageAnimation() end
end

function ItemView:playMonsterJumpAnimation( jumpCallback, finishCallback )
	-- body
	local monster = self.itemSprite[ItemSpriteType.kBigMonster]
	local function animationCallback( ... )
		-- body
		if monster then monster:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kBigMonster] = nil
		self.isNeedUpdate = true
		if finishCallback then finishCallback() end
	end
	
	if monster then 
		monster:playJumpAnimation(jumpCallback, animationCallback)
	else
		if finishCallback then finishCallback() end
	end
end

function ItemView:playMaydayBossChangeToAddMove(boardView, fromItem, callback, isHalloween)
	local animation = nil
	local function onAnimComplete()
		if self.itemSprite[ItemSpriteType.kSpecial] then
			self.itemSprite[ItemSpriteType.kSpecial]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kSpecial] = nil
		end

		callback()
	end

	local fromPos = self:getBasePosition(fromItem.x, fromItem.y)
	local toPos = self:getBasePosition(self.x, self.y)
	animation = FallingStar:create(fromPos, toPos, flyingtime, onAnimComplete, nil, isHalloween)
	self.itemSprite[ItemSpriteType.kSpecial] = animation 
	self.isNeedUpdate = true

end

function ItemView:playChangeToLineSpecial(boardView, fromItem, direction, callback)
	local animation = nil
	local function onAnimComplete()
		if self.itemSprite[ItemSpriteType.kSpecial] then
			self.itemSprite[ItemSpriteType.kSpecial]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kSpecial] = nil
		end

		callback()
	end

	local fromPos = self:getBasePosition(fromItem.x, fromItem.y)
	local toPos = self:getBasePosition(self.x, self.y)
	animation = FallingStar:create(fromPos, toPos, flyingtime, onAnimComplete)
	self.itemSprite[ItemSpriteType.kSpecial] = animation 
	self.isNeedUpdate = true	
end

function ItemView:playMaydayBossDie(boardView, callback)

	local boss = self.itemSprite[ItemSpriteType.kBigMonster]
	local function animationCallback( ... )
		if boss then 
			boss:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kBigMonster] = nil
		end
		if callback then callback() end
		
	end
	if boss then
		boss:destroy(animationCallback)
	else
		if callback then callback() end
	end
end

function ItemView:playMaydayBossDisappear(boardView, callback)
	local boss = self.itemSprite[ItemSpriteType.kBigMonster]
	local function animationCallback( ... )
		if boss and not boss.isDisposed then 
			boss:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kBigMonster] = nil
		end
		if callback then callback() end

	end
	boss:disappear(animationCallback)
end

function ItemView:playMaydayBossCast(boardView, callback)
	local boss = self.itemSprite[ItemSpriteType.kBigMonster]
	local function animationCallback( ... )
		if callback then callback() end
	end
	boss:cast(animationCallback)
end

function ItemView:buildBossAnim(data)
	local boss = TileBoss:create(BossType.kDeer)
	self.itemSprite[ItemSpriteType.kBigMonster] = boss
	self:updateBossBlood(data.blood/data.maxBlood, false)
	self:upDatePosBoardDataPos(data)
end

function ItemView:playMaydayBossComeout(boardView, data, callback)
	self:buildBossAnim(data)
	local boss = self.itemSprite[ItemSpriteType.kBigMonster]
	local tempX = (self.x - 0.5 ) * self.w 
	local tempY = (Max_Item_Y - self.y - 0.5 ) * self.h
	boss:setPositionXY(tempX + 0.5 * self.w, tempY - 0.5 * self.h)

	local function animationCallback()
		if callback then callback() end
	end

	boss:comeout(animationCallback)
	self.isNeedUpdate = true
end

function ItemView:playBossHit(boardView, callback)
	local boss = self.itemSprite[ItemSpriteType.kBigMonster]

	local function animCallback()
		if callback then callback() end
	end
	boss:hit(animationCallback)
end

function ItemView:playMonsterDestroyItem(r_min, r_max, c_min, c_max, delayIndex, animationCallback )
	-- body
	local sprite
	local function localCallback( ... )
		-- body

		if sprite then sprite:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kBigMonsterFoot] = nil

	end

	local function getItemPosition( x,y )
		-- body
		local tempX = (x - 0.5 ) * GamePlayConfig_Tile_Width
		local tempY = (Max_Item_Y - y - 0.5 ) * GamePlayConfig_Tile_Width
		return ccp(tempX, tempY)

	end

	if r_max - r_min > 5 then 
		sprite = BigMonsterFoot:create( localCallback, animationCallback )
		local basePos = getItemPosition(5, 5)
		sprite:setPosition(ccp(basePos.x, basePos.y))
		sprite:setScale(1.2)
	else
		sprite = MonsterFoot:create( localCallback,animationCallback, delayIndex )
		local basePos = getItemPosition(c_min, r_min)
		sprite:setPosition(ccp(basePos.x + GamePlayConfig_Tile_Width, basePos.y - GamePlayConfig_Tile_Height/2))
	end
	self.itemSprite[ItemSpriteType.kBigMonsterFoot] = sprite
	self.isNeedUpdate = true
	
end

function ItemView:playSnailRoadChangeState( changeToBright )
	-- body
	local snailRoad = self.itemSprite[ItemSpriteType.kSnailRoad]
	if snailRoad then
		snailRoad:changeState(changeToBright)
	end
end

function ItemView:playHedgehogRoadChangeState( state )
	-- body
	local road = self.itemSprite[ItemSpriteType.kHedgehogRoad]
	local function callback( ... )
		-- body
		road:setVisible(true)
		local s = self.itemSprite[ItemSpriteType.kHedgehogRoadEffect]
		if s then
			s:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kHedgehogRoadEffect] = nil
		end
	end

	if road then 
		road:changeState(state)
		--[[
		if state == HedgeRoadState.kPass then
			road:setVisible(false)
			local tmpRoad = road:copy()
			local size = tmpRoad:getGroupBounds().size
			local pos = self:getBasePosition(self.x, self.y)
			local roadAni = TileHedgehogRoad:createChangeBrightAnimation(tmpRoad, pos, callback)
			self.itemSprite[ItemSpriteType.kHedgehogRoadEffect] = roadAni
			-- roadAni:setPosition(ccp(pos.x - size.width/2, pos.y - size.height/2))
			self.isNeedUpdate = true
		end
		]]
		
	end
end

function ItemView:playSnailInShellAnimation(direction,callback )
	-- body
	local item = self.itemSprite[ItemSpriteType.kSnail]
	if item then
		if item then item:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kSnail] = nil
	end
	local tempSnail = TileSnail:create()
	local function animationCallback( ... )
		-- body
		self.isNeedUpdate = true
		if callback then callback() end
		tempSnail:playMoveAnimation()
	end

	
	tempSnail:setPosition(self:getBasePosition(self.x, self.y))
	tempSnail:playToShellAnimation(animationCallback)
	self.itemSprite[ItemSpriteType.kSnailMove] = tempSnail
	if direction == RouteConst.kLeft then
		tempSnail:setScaleX(-1)
	end

	self.isNeedUpdate = true
end

function ItemView:playHedgehogInShellAnimation(direction,callback, hedgehogLevel, isCrazy )
	-- body
	local item = self.itemSprite[ItemSpriteType.kSnail]
	if item then
		if item then item:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kSnail] = nil
	end
	local tempSnail = TileHedgehog:create(hedgehogLevel)
	local function animationCallback( ... )
		-- body
		self.isNeedUpdate = true
		if callback then callback() end
		tempSnail:playMoveAnimation(nil, isCrazy)
	end

	
	tempSnail:setPosition(self:getBasePosition(self.x, self.y))
	tempSnail:playToShellAnimation(animationCallback)
	self.itemSprite[ItemSpriteType.kSnailMove] = tempSnail
	if direction == RouteConst.kLeft then
		tempSnail:setScaleX(-1)
	end

	self.isNeedUpdate = true
end

function ItemView:playSnailOutShellAnimation(direction, callback)
	local item = self.itemSprite[ItemSpriteType.kSnailMove]
	local function animationCallback( ... )
		-- body
		item:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kSnailMove] = nil
		self:cleanGameItemView()
		self:buildSnail(direction)
		if self.getContainer(ItemSpriteType.kSnail) ~= nil then 
			self.getContainer(ItemSpriteType.kSnail):addChild(self.itemSprite[ItemSpriteType.kSnail]);
		else
			self.isNeedUpdate = true;
		end

		-- self.isNeedUpdate = true
		if callback then callback() end
	end
	if item then
		item:setRotation(0)
		if direction == RouteConst.kLeft then
			item:setScaleX(-1)
		else
			item:setScaleX(1)
		end
		item:updateArrow(direction)
		item:playOutShellAnimation(animationCallback) 
	end
end

function ItemView:playHedgehogOutShellAnimation(direction, callback, hedgehogLevel)
	local item = self.itemSprite[ItemSpriteType.kSnailMove]
	local function animationCallback( ... )
		-- body
		item:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kSnailMove] = nil
		self:cleanGameItemView()
		self:buildHedgehog(direction, hedgehogLevel)
		if self.getContainer(ItemSpriteType.kSnail) ~= nil then 
			self.getContainer(ItemSpriteType.kSnail):addChild(self.itemSprite[ItemSpriteType.kSnail]);
		else
			self.isNeedUpdate = true;
		end
		if callback then callback() end
	end
	if item then
		item:setRotation(0)
		if direction == RouteConst.kLeft then
			item:setScaleX(-1)
		else
			item:setScaleX(1)
		end
		item:updateArrow(direction)
		item:playOutShellAnimation(animationCallback) 
	end
end

function ItemView:playHedgehogChangeAnimation( level, callback )
	-- body
	local item = self.itemSprite[ItemSpriteType.kSnail]
	local function animationCallback( ... )
		-- body
		if callback then callback() end
	end 
	item:playChangeAnimation(level, animationCallback)
end



function ItemView:playSnailMovingAnimation(rotation , callback)
	-- body
	-- debug.debug()
	local item = self.itemSprite[ItemSpriteType.kSnailMove]
	local function animationCallback( ... )
		-- body
		if callback then callback() end
		self.isNeedUpdate = true
	end
	--[[
	item:setScaleX(1)
	item:setRotation(0)
	item:setMainSpriteRotation(0)
	if rotation == 180 then 
		item:setScaleX(-1)
	else
		item:setRotation(rotation)
		item:setMainSpriteRotation(rotation)
	end
	]]

	if rotation == 180 then 
		item:setScaleX(-1)
		item:setRotation(0)
		item:setMainSpriteRotation(0)
	else
		item:setScaleX(1)
		item:setRotation(rotation)
		item:setMainSpriteRotation(rotation)
	end

	
	local action_move = CCMoveTo:create(0.3, self:getBasePosition(self.x, self.y))
	local action_callback = CCCallFunc:create(animationCallback)
	item:runAction(CCSequence:createWithTwoActions(action_move, action_callback))
end

function ItemView:playSnailDisappearAnimation( callback )
	-- body
	local item = self.itemSprite[ItemSpriteType.kSnailMove]
	self.itemSprite[ItemSpriteType.kSnailMove] = nil
	local function animationCallback( ... )
		-- body
		if item then item:removeFromParentAndCleanup(true) end
		if callback then callback() end
	end
	if item then 
		item:playDestroyAnimation(animationCallback)
		item:setScaleX(1)
		item:setRotation(0)
	else
		if callback then callback() end
	end
end

function ItemView:changToSnail( direction, callback )
	-- body
	self:cleanGameItemView()
	self:buildSnail(direction)
	local item = self.itemSprite[ItemSpriteType.kSnail]
	self.isNeedUpdate = true
	if item then item:playOutShellAnimation(callback) end
end

function ItemView:changeToRabbit(color,level,callback)
	
	self:cleanGameItemView()
	self:buildRabbit(color, level)
	local item = self.itemSprite[ItemSpriteType.kItemShow]
		self.isNeedUpdate = true
	local function localCallback()
		callback()
	end
	if item then print('***** changeToRabbit') item:playUpAnimation(localCallback, true) end
end

function ItemView:playBirdShiftToAnim(destPos, callback)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	local toPos = self:getBasePosition(destPos.c, destPos.r)
	local moveTo = CCSequence:createWithTwoActions(CCMoveTo:create(0.1, ccp(toPos.x, toPos.y)), CCCallFunc:create(callback))
	sprite:runAction(moveTo)
end

local needTransLayer = table.const{
	-- ItemSpriteType.kTileBlocker,
	ItemSpriteType.kMoveTileBackground,
	ItemSpriteType.kSuperCuteLowLevel,
	ItemSpriteType.kLotus_bottom,
	ItemSpriteType.kItemLowLevel,
	ItemSpriteType.kSand,
	ItemSpriteType.kLight,
	ItemSpriteType.kItem, 
	ItemSpriteType.kItemShow,
	ItemSpriteType.kDigBlocker,
	ItemSpriteType.kLock,
	ItemSpriteType.kFurBall,
	ItemSpriteType.kHoney,
	ItemSpriteType.kItemHighLevel,
	ItemSpriteType.kLotus_top,
	ItemSpriteType.kSuperCuteHighLevel,
}

function ItemView:getTransItemCopy()
	local container = Sprite:createEmpty()
	container.items = {}
	for k, v in pairs(needTransLayer) do
		local item = self.itemSprite[v]
		if item then
			container.items[v] = item
			item:removeFromParentAndCleanup(false)
			self.itemSprite[v] = nil
			item:setPosition(ccp(0,0))
			container:addChild(item)
		end 
	end
	return container
end

function ItemView:getTransContainer()
	if self.transContainer:getParent() then
		self.transContainer:removeFromParentAndCleanup(false)
	end
	return self.transContainer
end

--头部直接从自己的transClipping里面去取sprite
function ItemView:reinitTransHeadByLogic(gameItemData, boardData)
	-- transContainer留给下一个Item用。。。
	if self.itemSprite[ItemSpriteType.kItemShow] then
		self.transContainer:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kItemShow] = nil -- 删除引用
	end
	-- 留下container，其他的删除
	self.transClippingContainer:removeFromParentAndCleanup(false)
	self.itemSprite[ItemSpriteType.kTransClipping]:removeFromParentAndCleanup(true)
	self.itemSprite[ItemSpriteType.kTransClipping] = nil
	self.transClippingNode = nil
	-- 重建sprite
	for k, v in pairs(self.transClippingContainer.items) do
		v:removeFromParentAndCleanup(false)
		print("RRR      ItemView:reinitTransHeadByLogic    ----------------->  " , k)
		self.itemSprite[k] = v
	end
	self.transClippingContainer:dispose()
	self.transClippingContainer = nil

	self:initPosBoardDataPos(gameItemData, true)
	self.isNeedUpdate = true
end

-- function ItemView:addTileMoveAnimation(animation)
-- 	self.getContainer(ItemSpriteType.kTileMove):addChild(animation)
-- end

function ItemView:playTileMoveAnimation(transContainer, moveDataList, onMoveFinishCallback)
	if not self.boardViewTransContainer then
		-- 保存已有的视图
		self.boardViewTransContainer = self:copyBoardTransData()
	end

	if transContainer then
		if transContainer and transContainer.datas then
			self:copyDatasFrom(transContainer.datas)
		end
		if moveDataList and #moveDataList > 0 then
			local startPos = moveDataList[1].pos

			local actionsCount = 0
			for k, v in pairs(transContainer.items) do
				v:removeFromParentAndCleanup(false)
				local container = self.getContainer(k)
				if container then
					local offsetX, offsetY = 0, 0
					if k == ItemSpriteType.kPass or table.exist(needUpdateLayers, k) then
						local itemPosOffset = self.itemPosAdd[k]
						if itemPosOffset then
							offsetX = itemPosOffset.x
							offsetY = itemPosOffset.y
						else
							if k == ItemSpriteType.kBigMonster then
								offsetX = 0.5 * self.w
								offsetY = -0.5 * self.h
							end
						end
					end
					v:setPosition(ccp(startPos.x + offsetX, startPos.y + offsetY))
					container:addChild(v)
				end
				self.itemSprite[k] = v
				-- 移动
				local seq = CCArray:create()
				local prePos = nil
				for _, move in ipairs(moveDataList) do
					if prePos then 
						seq:addObject(CCMoveBy:create(move.time, ccp(move.pos.x - prePos.x, move.pos.y - prePos.y)))
					end
					prePos = move.pos
				end
				local function onMoveEnd()
					actionsCount = actionsCount - 1
					if actionsCount == 0 then
						if onMoveFinishCallback then onMoveFinishCallback() end
					end
				end
				seq:addObject(CCCallFunc:create(onMoveEnd))

				actionsCount = actionsCount + 1
				v:runAction(CCSequence:create(seq))
			end
		end
	else
		if onMoveFinishCallback then onMoveFinishCallback() end
	end
end

function ItemView:reinitBoardViews(gameItemData, boardData, transContainer)
	if not self.boardViewTransContainer then
		-- 保存已有的视图
		self.boardViewTransContainer = self:copyBoardTransData()
	end

	for k, v in pairs(transContainer.items) do
		v:removeFromParentAndCleanup(false)
		local container = self.getContainer(k)
		if container then
			v:setPosition(self:getBasePosition(self.x, self.y))
			container:addChild(v)
		end
		self.itemSprite[k] = v
	end

	self:initPosBoardDataPos(gameItemData, true)

	self.isNeedUpdate = true
end

-- 其他的item要从上一个itemView的transContainer去拿sprite
function ItemView:reinitTransRoadByLogic(gameItemData, boardData, transContainer)
	-- transContainer原本是放在ItemShow的，摘下来保留
	if self.itemSprite[ItemSpriteType.kItemShow] then
		self.transContainer:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kItemShow] = nil
	end

	-- 在这个函数中，只有kEnd才会有transClippingContainer
	if self.transClippingContainer then
		self.transClippingNode:removeFromParentAndCleanup(true)
		self.transClippingContainer = nil
		self.transClippingNode = nil
		self.itemSprite[ItemSpriteType.kTransClipping] = nil
	end

	-- 重建sprite

	for k, v in pairs(transContainer.items) do
		v:removeFromParentAndCleanup(false)
		self.itemSprite[k] = v
	end

	transContainer:dispose()

	self:initPosBoardDataPos(gameItemData, true)
	self.isNeedUpdate = true
end

function ItemView:buildTransmisson(boardData)
	local image, rotation, scale
	local transType = boardData.transType
	if transType == TransmissionType.kRoad
	or transType == TransmissionType.kStart
	or transType == TransmissionType.kEnd then
		image = 'trans_road_0000'
		rotation = (boardData.transDirect - 1) * 90
		scale = 1
	else
		image = 'trans_corner_0000'
		if transType == TransmissionType.kCorner_UR then
			rotation = 0
			scale = 1
		elseif transType == TransmissionType.kCorner_RD then
			rotation = 90
			scale = 1
		elseif transType == TransmissionType.kCorner_DL then
			rotation = 180
			scale = 1
		elseif transType == TransmissionType.kCorner_LU then
			rotation = 270
			scale = 1
		elseif transType == TransmissionType.kCorner_LD then
			rotation = 270
			scale = -1
		elseif transType == TransmissionType.kCorner_DR then
			rotation = 180
			scale = -1
		elseif transType == TransmissionType.kCorner_RU then
			rotation = 90
			scale = -1
		elseif transType == TransmissionType.kCorner_UL then
			rotation = 0
			scale = -1
		end
	end


	local board = Sprite:createWithSpriteFrameName(image)
	board:setRotation(rotation)
	board:setScaleX(scale)
	self.itemSprite[ItemSpriteType.kTileBlocker] = board

	if boardData.transType >= TransmissionType.kStart then
		self.itemSprite[ItemSpriteType.kTransmissionDoor] = TileTransDoor:create(boardData.transColor, boardData.transType, boardData.transDirect)
	end

end

function ItemView:createTransClippingSprite(itemData, boardData)
	local container = Sprite:createEmpty()
	container.items = {}

	if boardData.superCuteState == GameItemSuperCuteBallState.kInactive then
		local cuteBall = TileSuperCuteBall:create(boardData.superCuteState)
		container:addChild(cuteBall)
		container.items[ItemSpriteType.kSuperCuteLowLevel] = cuteBall
	end

	if boardData.sandLevel > 0 then
		local sprite = ItemViewUtils:buildSand(boardData.sandLevel)
		container:addChild(sprite)
		container.items[ItemSpriteType.kSand] = sprite
	end

	if boardData.iceLevel > 0 then		 --冰
		local ice = ItemViewUtils:buildLight(boardData.iceLevel, boardData.gameModeId)
		container:addChild(ice)
		container.items[ItemSpriteType.kLight] = ice
	end

	if boardData.lotusLevel > 0 then		 --草地（荷叶）底层
		--local bottom = self:createLotusAnimation(boardData.lotusLevel , "in" , "bottom" , true)
		local bottom = TileLotus:create(boardData.lotusLevel , "in" , "bottom" , true)
		container:addChild(bottom)
		container.items[ItemSpriteType.kLotus_bottom] = bottom
	end

	local itemSprite = nil
	local layer = nil
	local isOnlyGetSprite = true
	if itemData.ItemType == GameItemType.kAnimal then
		itemSprite = self:buildNewAnimalItem(itemData.ItemColorType, itemData.ItemSpecialType, false, false)
		if AnimalTypeConfig.isSpecialTypeValid(itemData.ItemSpecialType) then
			layer = ItemSpriteType.kItemShow
		else			
			layer = ItemSpriteType.kItem
		end
	elseif itemData.ItemType == GameItemType.kSnow then	--雪
		itemSprite = ItemViewUtils:buildSnow(itemData.snowLevel)
		layer = ItemSpriteType.kItem
	elseif itemData.ItemType == GameItemType.kCrystal then	--由系统统一计算
		itemSprite = ItemViewUtils:buildCrystal(itemData.ItemColorType)               ------水晶
		layer = ItemSpriteType.kItem
	elseif itemData.ItemType == GameItemType.kGift then		--由系统统一计算
		itemSprite = ItemViewUtils:buildGift(itemData.ItemColorType)
		layer = ItemSpriteType.kItem
	elseif itemData.ItemType == GameItemType.kIngredient then
		itemSprite = ItemViewUtils:buildBeanpod(itemData.showType)
		layer = ItemSpriteType.kItem
	elseif itemData.ItemType == GameItemType.kVenom then
		itemSprite = TileVenom:create()
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kCoin then
		itemSprite = TileCoin:create()
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kRoost then
		itemSprite =TileRoost:create(itemData.roostLevel)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kBalloon then
		itemSprite = TileBalloon:create(itemData.ItemColorType, itemData.balloonFrom)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kDigGround then        ----------挖地障碍 地块 宝石块
		itemSprite = self:buildDigGround(itemData.digGroundLevel, isOnlyGetSprite)
		layer = ItemSpriteType.kDigBlocker
	elseif itemData.ItemType == GameItemType.kDigJewel then 
		itemSprite = self:buildDigJewel(itemData.digJewelLevel, self.context.levelType, isOnlyGetSprite)
		layer = ItemSpriteType.kDigBlocker
	elseif itemData.ItemType == GameItemType.kGoldZongZi then 
		itemSprite = self:buildGoldZongZi(itemData.digGoldZongZiLevel,isOnlyGetSprite)
		layer = ItemSpriteType.kDigBlocker
	elseif itemData.ItemType == GameItemType.kBottleBlocker then
		itemSprite = self:buildBottleBlocker(itemData.bottleLevel , itemData.ItemColorType , nil , true)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kAddMove then
		itemSprite = self:buildAddMove(itemData.ItemColorType, itemData.numAddMove, isOnlyGetSprite)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kPoisonBottle then 
		itemSprite = self:buildPoisonBottle(itemData.forbiddenLevel, isOnlyGetSprite)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kBigMonster then 
		-- self:buildMonster()                                        --not support
	elseif itemData.ItemType == GameItemType.kBlackCuteBall then 
		itemSprite = self:buildBlackCuteBall(itemData.blackCuteStrength, isOnlyGetSprite)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kMimosa then
		itemSprite = self:buildMimosa(itemData, isOnlyGetSprite)
		layer = ItemSpriteType.kItemShow
	elseif itemData.isSnail then
		-- self:buildSnail(itemData.snailRoadType)                    --not support
	elseif itemData.bossLevel and itemData.bossLevel > 0 then 
		-- self:buildBoss(itemData)                                    --not support
	elseif itemData.ItemType == GameItemType.kRabbit then
		itemSprite = self:buildRabbit(itemData.ItemColorType, itemData.rabbitLevel, false, isOnlyGetSprite)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kHoneyBottle then
		itemSprite = TileHoneyBottle:create(itemData.honeyBottleLevel)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kAddTime then
		itemSprite = self:buildAddTime(itemData.ItemColorType, itemData.addTime, isOnlyGetSprite)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kQuestionMark then
		itemSprite = ItemViewUtils:createQuestionMark(itemData.ItemColorType)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kMagicLamp then
		itemSprite = TileMagicLamp:create(itemData.ItemColorType, itemData.lampLevel)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kWukong then
		itemSprite = TileWukong:create(itemData.ItemColorType, itemData.wukongProgressCurr)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kDrip then
		itemSprite = self:buildDrip(true)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kSuperBlocker then
		itemSprite = TileSuperBlocker:create()
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kMagicStone then
		itemSprite = TileMagicStone:create(itemData.magicStoneLevel, itemData.magicStoneDir)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kRocket then
		itemSprite = self:buildRocket(itemData.ItemColorType, true)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kCrystalStone then
		itemSprite = self:buildCrystalStone(itemData.ItemColorType, itemData.crystalStoneEnergy, itemData.crystalStoneBombType, true)
		layer = ItemSpriteType.kItemShow
	elseif itemData.ItemType == GameItemType.kTotems then
		itemSprite = self:buildTotems(itemData.ItemColorType, itemData:isActiveTotems(), true)
		layer = ItemSpriteType.kItemShow
	end

	if itemSprite then
		itemSprite:setPositionXY(0,0)
		container:addChild(itemSprite)
		container.items[layer] = itemSprite
	end

	--附加属性
	if itemData:hasFurball() then
		local sprite = ItemViewUtils:buildFurball(itemData.furballType)
		container:addChild(sprite)
		container.items[ItemSpriteType.kFurBall] = sprite
	end

	if itemData.cageLevel > 0 then
		local sprite = ItemViewUtils:buildLocker(itemData.cageLevel)
		container:addChild(sprite)	
		container.items[ItemSpriteType.kLock] = sprite
	end

	if itemData.honeyLevel > 0 then
		local honey = TileHoney:create()
		honey:normal()
		container:addChild(honey)
		container.items[ItemSpriteType.kHoney] = honey
	end

	if boardData.lotusLevel > 0 then		 --草地（荷叶）顶层
		--local top = self:createLotusAnimation(boardData.lotusLevel , "in" , "top" , true)
		local top = TileLotus:create(boardData.lotusLevel , "in" , "top" , true)
		if top then
			container:addChild(top)
			container.items[ItemSpriteType.kLotus_top] = top
		else
			print("RRR   createLotusAnimation ERROR !!!!!!!!!!!!!!!!!!!!!!!!!!!!    " , boardData.lotusLevel , "in" , "top")
		end
	end

	if boardData.superCuteState == GameItemSuperCuteBallState.kActive then
		local cuteBall = TileSuperCuteBall:create(boardData.superCuteState)
		container:addChild(cuteBall)
		container.items[ItemSpriteType.kSuperCuteHighLevel] = cuteBall
	end

	return container
end

function ItemView:removeAllChildOfTransClippingSprite()
	if self.itemSprite[ItemSpriteType.kTransClipping] then
		self.itemSprite[ItemSpriteType.kTransClipping]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kTransClipping] = nil
		self.transClippingNode = nil
	end
end

function ItemView:buildTransmissonClippingNode()
	local pos = self:getBasePosition(self.x, self.y)
	local clippingnode = SimpleClippingNode:create()
	clippingnode:setContentSize(CCSizeMake(self.w, self.h))
	clippingnode:setPosition(ccp(pos.x - self.w/2, pos.y - self.h/2))
	self.transClippingNode = clippingnode
end

function ItemView:addSpriteToTransClippingNode(theSprite)
	self:buildTransmissonClippingNode()
	self.itemSprite[ItemSpriteType.kTransClipping] = self.transClippingNode
	if theSprite ~= nil then
		if theSprite:getParent() then theSprite:removeFromParentAndCleanup(false) end
		theSprite:setPositionXY(self.w/2, self.h/2)
		self.transClippingNode:addChild(theSprite)
	end
end

function ItemView:roadTransToNext(dp, isCorner, callback)
	local container = self:getTransItemCopy()
	self.transContainer = container
	local function moveCallback()
		if callback then callback() end
	end
	self.itemSprite[ItemSpriteType.kItemShow] = container
	container:setPosition(self:getBasePosition(self.x, self.y))
	local action = CCSequence:createWithTwoActions(CCMoveBy:create(GamePlayConfig_Transmission_Time, dp), CCCallFunc:create(moveCallback))
	container:runAction(action)
	local bg = self.itemSprite[ItemSpriteType.kTileBlocker]
	if bg then 
		local image
		if isCorner then
			image = 'trans_corner_%04d'
		else
			image = 'trans_road_%04d'
		end
		local anim = SpriteUtil:buildAnimate(SpriteUtil:buildFrames(image, 0, 24), 1/30)
		bg:play(anim, 0, 1)
	end
	self.isNeedUpdate = true
end

function ItemView:tailTransToOut(itemData, boardData, dp, callback)
	local function moveCallback()
		if callback then callback() end
	end
	local tempSprite = self:getTransItemCopy()
	self.transClippingContainer = tempSprite
	self:addSpriteToTransClippingNode(tempSprite)
	tempSprite:runAction(CCSequence:createWithTwoActions(CCMoveBy:create(GamePlayConfig_Transmission_Time,dp), CCCallFunc:create(moveCallback)))
	self.isNeedUpdate = true

	local bg = self.itemSprite[ItemSpriteType.kTileBlocker]
	if bg then 
		local image = 'trans_road_%04d'
		local anim = SpriteUtil:buildAnimate(SpriteUtil:buildFrames(image, 0, 24), 1/30)
		bg:play(anim, 0, 1)
	end

	local transDoor = self.itemSprite[ItemSpriteType.kTransmissionDoor]
	if transDoor then
		transDoor:playTransAnimation()
	end

end

function ItemView:headTransToIn(itemData, boardData, dp, callback)
	local function moveCallback()
		if callback then callback() end
	end

	local tempSprite = self:createTransClippingSprite(itemData, boardData)
	self.transClippingContainer = tempSprite
	self:addSpriteToTransClippingNode(tempSprite)
	local pos = tempSprite:getPosition()

	tempSprite:setPosition(ccp(pos.x - dp.x, pos.y - dp.y))

	tempSprite:runAction(CCSequence:createWithTwoActions(CCMoveBy:create(GamePlayConfig_Transmission_Time,dp), CCCallFunc:create(moveCallback)))
	self.isNeedUpdate = true
end



-- 开局时动物从小放大的时间
local startScaleTime = 0.2
-- 在游戏开局时动物从小到大变化
function ItemView:animalStartTimeScale()
	local item, itemBack, itemShow = self.itemSprite[ItemSpriteType.kItem], self.itemSprite[ItemSpriteType.kItemBack], self.itemSprite[ItemSpriteType.kItemShow]
	if item then
		item:setScale(0)
		item:runAction(CCScaleTo:create(startScaleTime, 1))
	end
	if itemBack then
		itemBack:setScale(0)
		item:runAction(CCScaleTo:create(startScaleTime, 1))
	end
	if itemShow then
		itemShow:setScale(0)
		itemShow:runAction(CCScaleTo:create(startScaleTime, 1))
	end
end

function ItemView:gainFocus()
end

function ItemView:lostFocus()
end

function ItemView:buildSeaAnimal(seaAnimalType)
	local rotation = 0
	local anchorPoint = ccp(0, 0)
	local image = 'sea_animal_penguin_0000'
	local pos = self:getBasePosition(self.x, self.y)
	if seaAnimalType == SeaAnimalType.kPenguin then
		rotation = 0
		anchorPoint = ccp(1/2, 3/4)
		image = 'sea_animal_penguin_0000'
	elseif seaAnimalType == SeaAnimalType.kPenguin_H then
		rotation = -90
		anchorPoint = ccp(1/2, 3/4)
		image = 'sea_animal_penguin_0000'
	elseif seaAnimalType == SeaAnimalType.kSeal then
		rotation = 0
		anchorPoint = ccp(1/6, 3/4)
		image = 'sea_animal_seal_0000'
	elseif seaAnimalType == SeaAnimalType.kSeal_V then
		rotation = 90
		anchorPoint = ccp(1/6, 1/4)
		image = 'sea_animal_seal_0000'
	elseif seaAnimalType == SeaAnimalType.kSeaBear then
		rotation = 0
		anchorPoint = ccp(1/6, 5/6)
		image = 'sea_animal_bear_0000'
	end
	local sprite = Sprite:createWithSpriteFrameName(image)
	sprite:setAnchorPoint(anchorPoint)
	sprite:setRotation(rotation)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kSeaAnimal] = sprite
end

function ItemView:clearSeaAnimal()
	local sprite = self.itemSprite[ItemSpriteType.kSeaAnimal]
	if sprite then
		sprite:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kSeaAnimal] = nil
	end
end

function ItemView:setMagicLampLevel(level, color, callback)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if level == 0 then
		sprite:playReinit(color, callback)
	elseif level >= 1 and level <= 4 then
		sprite:playLevel(level, 0)
	elseif level == 5 then
		sprite:playBeforeCast()
	elseif level == 6 then
		sprite:playCasting()
	end
end

function ItemView:explodeGoldZongZi(callback)
	local sprite = self.itemSprite[ItemSpriteType.kDigBlocker]
	if sprite then
		sprite:explodeGoldZongZi(callback)
	end
end


function ItemView:buildSuperBlocker()
	local sprite = TileSuperBlocker:create()
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:buildHoneyBottle( level )
	-- body
	local sprite = TileHoneyBottle:create(level)
	self.itemSprite[ItemSpriteType.kItemShow] = sprite
end

function ItemView:playHoneyBottleDec( times )
	-- body
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite then
		sprite:playIncreaseAnimation(times)
	end
end

function ItemView:playHoneyBottleBroken( callback )
	-- body
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	local function animationCallback()
		if sprite then sprite:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kItemShow] = nil
		if callback then callback() end
	end

	if sprite then
		sprite:playBrokenAnimation(animationCallback)
	end
end

function ItemView:playBeInfectAnimation( fromPos, callback )
	-- body
	local flyAnimation = nil

	local function finishCallback( ... )
		-- body
		local honey = self.itemSprite[ItemSpriteType.kHoney]
		self.isNeedUpdate = true
		if honey then honey:normal() end
	end

	local function flyCallback( ... )
		-- body
		if flyAnimation then flyAnimation:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kSpecial] = nil
		local honey = TileHoney:create()
		honey:setPosition(self:getBasePosition(self.x, self.y))
		honey:add(finishCallback)
		self.itemSprite[ItemSpriteType.kHoney] = honey
		if callback then callback() end
		self.isNeedUpdate = true
	end
	
	flyAnimation= TileHoney:createFlyAnimation(fromPos, self:getBasePosition(self.x, self.y),  flyCallback)
	self.itemSprite[ItemSpriteType.kSpecial] = flyAnimation
	self.isNeedUpdate = true
end

function ItemView:buildHoney( honeyLevel )
	-- body
	local honey = TileHoney:create()
	honey:normal()
	self.itemSprite[ItemSpriteType.kHoney] = honey
end

function ItemView:playHoneyDec( callback )
	-- body
	local honeyEffect = TileHoney:create()
	local function animationCallback( ... )
		-- body
		if honeyEffect then honeyEffect:removeFromParentAndCleanup(true) end
		self.itemSprite[ItemSpriteType.kNormalEffect] = nil
		if callback then callback() end
	end
	honeyEffect:setPosition(self:getBasePosition(self.x, self.y))
	honeyEffect:disappear(animationCallback)
	self.itemSprite[ItemSpriteType.kNormalEffect] = honeyEffect

	local sprite = self.itemSprite[ItemSpriteType.kHoney]
	if sprite then sprite:removeFromParentAndCleanup(true) end
	self.itemSprite[ItemSpriteType.kHoney] = nil
	self.isNeedUpdate = true
end

function ItemView:buildWukongTarget(data)
	local sprite = TileWukongTarget:create()
	if self.itemSprite[ItemSpriteType.kTileBlocker] and self.itemSprite[ItemSpriteType.kTileBlocker]:getParent() then
		self.itemSprite[ItemSpriteType.kTileBlocker]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kTileBlocker] = nil
	end
	self.itemSprite[ItemSpriteType.kTileBlocker] = sprite
end

function ItemView:setWukongTargetLightVisible(direction , visible)
	local sprite = self.itemSprite[ItemSpriteType.kTileBlocker]
	if sprite then
		sprite:setLightVisible(direction , visible)
	end
end

function ItemView:playWukongTargetLoopAnimation(animationType)
	local sprite = self.itemSprite[ItemSpriteType.kTileBlocker]
	if sprite then
		sprite:playLoopAnimation(animationType)
	end
end



function ItemView:deleteWukongTarget()
	local sprite = self.itemSprite[ItemSpriteType.kTileBlocker]
	if sprite and sprite:getParent() then
		sprite:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kTileBlocker] = nil
	end
end


function ItemView:buildMagicTile(data)
	local level = data.remainingHit or 1
	local sprite = TileMagicTile:create(level)
	if self.itemSprite[ItemSpriteType.kTileBlocker] and self.itemSprite[ItemSpriteType.kTileBlocker]:getParent() then
		self.itemSprite[ItemSpriteType.kTileBlocker]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kTileBlocker] = nil
	end
	self.itemSprite[ItemSpriteType.kTileBlocker] = sprite
end

function ItemView:deleteMagicTile()
	if self.itemSprite[ItemSpriteType.kTileBlocker] and self.itemSprite[ItemSpriteType.kTileBlocker]:getParent() then
		local tile = self.itemSprite[ItemSpriteType.kTileBlocker]
		local function onHide()
			self.itemSprite[ItemSpriteType.kTileBlocker]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kTileBlocker] = nil
		end
		tile:hideBG(onHide)
	end
end

function ItemView:addMagicTileWater(data)
	if self.itemSprite[ItemSpriteType.kMagicTileWater] == nil then
		local waterLayer = TileMagicTile:createWaterAnim()
		self.itemSprite[ItemSpriteType.kMagicTileWater] = waterLayer
		self.itemPosAdd[ItemSpriteType.kMagicTileWater] = ccp(0, -24)
	end
end

function ItemView:removeMagicTileWater()
	if self.itemSprite[ItemSpriteType.kMagicTileWater] and self.itemSprite[ItemSpriteType.kMagicTileWater]:getParent() then
		self.itemSprite[ItemSpriteType.kMagicTileWater]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kMagicTileWater] = nil
	end
end

function ItemView:changeMagicTileColor(color)
	if color == 'red' then
		local sprite = self.itemSprite[ItemSpriteType.kTileBlocker]
		if sprite and sprite.refCocosObj then
			sprite:changeColor('red')
		end
	end
end

function ItemView:buildHalloweenBoss()
	local node = BossBeeArmature:createGeneratorBottleIcon()
	local wrapper = CocosObject:create()
	wrapper:addChild(node)
	node:setPosition(ccp(-35, 35))
	self.itemSprite[ItemSpriteType.kNormalEffect] = wrapper
end

function ItemView:clearHalloweenBoss()
	if self.itemSprite[ItemSpriteType.kNormalEffect] and self.itemSprite[ItemSpriteType.kNormalEffect]:getParent() then
		self.itemSprite[ItemSpriteType.kNormalEffect]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kNormalEffect] = nil
	end
end

function ItemView:addSandView(sandLevel)
	local sprite = ItemViewUtils:buildSand(sandLevel)
	local pos = self:getBasePosition(self.x, self.y)
	sprite:setPosition(pos)
	self.itemSprite[ItemSpriteType.kSand] = sprite
	self.isNeedUpdate = true
end

function ItemView:playSandClean(callback)
	local sprite = self.itemSprite[ItemSpriteType.kSand]
	if sprite then 
		sprite:stopAllActions()
		sprite:removeFromParentAndCleanup(true) 
	end

	local function onAnimationFinished()
		if self.itemSprite[ItemSpriteType.kSand] then
			-- self.itemSprite[ItemSpriteType.kSand]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kSand] = nil
		end
		if callback then callback() end
	end

	local texture
	if self.getContainer(ItemSpriteType.kSand) then 
		texture = self.getContainer(ItemSpriteType.kSand).refCocosObj:getTexture()
	end
	local anim, posOffset = TileSand:buildCleanAnim(onAnimationFinished, texture)
	if not anim then
		print("build sand clean animation failed~")
		return
	end
	posOffset = posOffset or {x=0, y=0}
	local basePos = self:getBasePosition(self.x, self.y)
	anim:setPosition(ccp(basePos.x + posOffset.x, basePos.y + posOffset.y))

	self.itemSprite[ItemSpriteType.kSand] = anim
	self.isNeedUpdate = true
end

function ItemView:playSandMoveAnim(callback, direction)
	assert(direction)
	local function onAnimationFinished()
		if callback and type(callback)=="function" then callback() end
	end

	local sprite = self.itemSprite[ItemSpriteType.kSand]
	if sprite then
		sprite:stopAllActions()
		sprite:removeFromParentAndCleanup(true)

		self.itemSprite[ItemSpriteType.kSand] = nil
	else
		print("itemSprite[ItemSpriteType.kSand] not exist")
		onAnimationFinished()
		return
	end

	local anim, posOffset = TileSand:buildMoveAnim(direction, onAnimationFinished)
	if not anim then
		print("build sand move animation failed~")
		onAnimationFinished()
		return
	end
	posOffset = posOffset or {x=0, y=0}
	local basePos = self:getBasePosition(self.x, self.y)
	anim:setPosition(ccp(basePos.x + posOffset.x, basePos.y + posOffset.y))

	self.itemSprite[ItemSpriteType.kSandMove] = anim
	self.isNeedUpdate = true
end


function ItemView:setQuestionMarkChangeItemVisible( value )
	-- body
	for k, v in pairs(needUpdateLayers) do 
		local s = self.itemSprite[v]
		if s then
			s:setVisible(value)
		end
	end
end

function ItemView:playQuestionMarkDestroy( callback )
	-- body
	local s = self.itemSprite[ItemSpriteType.kItemShow]
	if s then 
		s:removeFromParentAndCleanup(true)
	end

	local isBgCallback = false
	local isFgCallback = false
	local function finishCallback()
		if isBgCallback and isFgCallback then
			if callback then callback() end
		end
	end

	local function bg_callback( ... )
		isBgCallback = true
			-- body
		local s = self.itemSprite[ItemSpriteType.kQuestionMarkDestoryBg]
		if s then 
			s:removeFromParentAndCleanup(true)
		end
		self.itemSprite[ItemSpriteType.kQuestionMarkDestoryBg] = nil
		finishCallback()
	end
	local bg = TileQuestionMark:getBgLight(bg_callback)
	bg:setPosition(self:getBasePosition(self.x, self.y))
	self.itemSprite[ItemSpriteType.kQuestionMarkDestoryBg] = bg

	local function fg_callback( ... )
		isFgCallback = true
		-- body
		local s = self.itemSprite[ItemSpriteType.kQuestionMarkDestoryFg]
		if s then 
			s:removeFromParentAndCleanup(true)
		end
		self.itemSprite[ItemSpriteType.kQuestionMarkDestoryFg] = nil
		finishCallback()
	end 
	local fg = TileQuestionMark:getFgLight(fg_callback)
	fg:setPosition(self:getBasePosition(self.x, self.y))
	self.itemSprite[ItemSpriteType.kQuestionMarkDestoryFg] = fg
	self.isNeedUpdate = true
end

function ItemView:addChainsView(data)
	if data:hasChains() then
		local texture = nil
		if self.getContainer(ItemSpriteType.kChain) then 
			texture = self.getContainer(ItemSpriteType.kChain).refCocosObj:getTexture()
		end
		local chainSprite = TileChain:createWithChains(data.chains, texture)
		self.itemSprite[ItemSpriteType.kChain] = chainSprite
	end
end

-- breakLevels = {dir : level}
function ItemView:playChainBreakAnim(breakLevels, callback)
	if type(breakLevels) == "table" and table.size(breakLevels) > 0 then
		local chainSprite = self.itemSprite[ItemSpriteType.kChain]
		if chainSprite and not chainSprite.isDisposed then
			chainSprite:playBreakAnimation(breakLevels, callback)
		else
			if callback then callback() end
		end
	else
		if callback then callback() end
	end
end

function ItemView:playStoneActiveAnim(stoneLevel, targetPos, callback)
	local stoneSprite = self.itemSprite[ItemSpriteType.kItemShow]
	if stoneSprite then
		-- stoneSprite:active(stoneLevel, targetPos)
		-- remove old anim
		local fireSprite = self.itemSprite[ItemSpriteType.kMagicStoneFire]
		if fireSprite and not fireSprite.isDisposed then
			fireSprite:removeFromParentAndCleanup(true)
			if fireSprite.onAnimFinish then fireSprite.onAnimFinish() end
			self.itemSprite[ItemSpriteType.kMagicStoneFire] = nil
		end
		-- add new anim
		local function onAnimFinish()
			if stoneSprite and not stoneSprite.isDisposed then
				stoneSprite:updateStoneSprite()
				stoneSprite:idle()
			end
			if callback then callback() end
		end

		local texture = nil
		if self.getContainer(ItemSpriteType.kMagicStoneFire)  then 
			texture = self.getContainer(ItemSpriteType.kMagicStoneFire).refCocosObj:getTexture()
		end

		local anim = TileMagicStone:createActiveAnim(texture, stoneLevel, stoneSprite.direction, onAnimFinish, targetPos)
		anim:setPosition(self:getBasePosition(self.x, self.y))
		anim.onAnimFinish = callback
		self.itemSprite[ItemSpriteType.kMagicStoneFire] = anim

		stoneSprite:removeStoneSprite()
		stoneSprite.level = stoneLevel + 1
		if stoneSprite.level > 2 then stoneSprite.level = 2 end

		self.isNeedUpdate = true
	else
		if callback then callback() end
	end
end

function ItemView:buildHedgehogBox( ... )
	-- body
	local sp = TileHedgehogBox:create()
	self.itemSprite[ItemSpriteType.kItemShow] = sp
end

function ItemView:playHedgehogBoxOpen(callback, targetPos)
	-- body
	local sp = self.itemSprite[ItemSpriteType.kItemShow]
	if sp then
		sp:playOpenAnimation(targetPos, callback)
	else
		if callback then callback() end
	end
end

local kRocketSpeed = 500
function ItemView:playRocketFlyAnimation(boardView, colortype, startPos, finalPos, callback)
	local rocket = TileRocket:create(colortype)
	if rocket and startPos and finalPos then
		colortype = colortype or rocket.color
		if rocket:getParent() then
			rocket:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kItemShow] = nil
		end

		local startPosInView, ufoPosInView = boardView:getPositionFromTo(startPos, finalPos)
		local effectLayer = boardView.PlayUIDelegate.effectLayer
		local function onAnimFinish()
			local explode = TileRocket:buildRocketExplodeAnimation()
			local offsetPos = ccp(0, 0)
			if finalPos.y > startPos.y then offsetPos = ccp(-50, 0) -- UFO在导弹右边
			elseif finalPos.y < startPos.y then offsetPos = ccp(50, 0) -- UFO在导弹左边
			end
			explode:setPosition(ccp(ufoPosInView.x + offsetPos.x, ufoPosInView.y + offsetPos.y))
			effectLayer:addChild(explode)

			if callback then callback() end
		end

		local finalPosInView = ccp(ufoPosInView.x, ufoPosInView.y + 15) -- 向上偏移一定距离
		local movePosList = {}
		table.insert(movePosList, startPosInView)
		if finalPos.y ~= startPos.y then -- 转弯点
			table.insert(movePosList, ccp(startPosInView.x, finalPosInView.y))
		end
		table.insert(movePosList, finalPosInView)
		local ani = TileRocket:buildRocketAnimation(colortype, movePosList, onAnimFinish)
		if ani then
			ani:setPosition(startPosInView)
			effectLayer:addChild(ani)
		else
			if callback then callback() end
		end
	else
		if callback then callback() end
	end
end

----------------------
-- 染色宝宝动画
----------------------
-- 染色宝宝外发光动画
function ItemView:playCrystalStoneChargeEffect()
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite and type(sprite.playChargeEffect) == "function" then
		sprite:playChargeEffect()
	end
end

-- 充能动画
function ItemView:playCrystalStoneCharge(fromItemPos, color)
	local function onAnimFinish( ... )
		self:playCrystalStoneChargeEffect()
	end
	local layer = self.getContainer(ItemSpriteType.kCrystalStoneEffect)
	if layer then
		local startPos = self:getBasePosition(fromItemPos.y, fromItemPos.x)
		local endPos = self:getBasePosition(self.x, self.y)
		local finalPos = ccp(endPos.x, endPos.y+28)

		local animate = TileCrystalStoneAnimate:buildAddEnergyAnimate(color, ccp(finalPos.x-startPos.x, finalPos.y-startPos.y), onAnimFinish)
		animate:setPosition(startPos)

		layer:addChild(animate)
	end
end

-- 更新能量进度
function ItemView:updateCrystalStoneEnergy(energyPercent, withAnimate)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite and type(sprite.updateEnergyPercent) == "function" then
		sprite:updateEnergyPercent(energyPercent, withAnimate)
	end
end

-- 激活状态
function ItemView:playCrystalStoneFullAnimate()
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite and type(sprite.updateState) == "function" then
		sprite:updateState(CrystalStongAnimateStates.kFull)
	end
end

-- 消失动画
function ItemView:playCrystalStoneDisappear(isSpecial, callback)
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite and type(sprite.playDisappearAnimate) == "function" then
		sprite:playDisappearAnimate(callback)

		if isSpecial then
			if self.itemSprite[ItemSpriteType.kCrystalStoneEffect] then 
				self.itemSprite[ItemSpriteType.kCrystalStoneEffect]:removeFromParentAndCleanup(true) 
			end

			local effect = TileCrystalStoneAnimate:buildExplodeEffect()
			local pos = self:getBasePosition(self.x, self.y)
			effect:setPosition(ccp(pos.x, pos.y-2))

			self.itemSprite[ItemSpriteType.kCrystalStoneEffect] = effect
			self.isNeedUpdate = true
		end
	else
		if callback then callback() end
	end
end

-- 转换为等待消失
function ItemView:playCrystalStoneChangeToWaiting()
	local sprite = self.itemSprite[ItemSpriteType.kItemShow]
	if sprite and type(sprite.playChangeToWaitingBomb) == "function" then
		sprite:playChangeToWaitingBomb()
	end
end

-- 染色宝宝发出改变颜色的特效
function ItemView:playChangeColorByCrystalStone(fromItem, color, callback)
	local fromPos = self:getBasePosition(fromItem.y, fromItem.x)
	local finalPos = self:getBasePosition(self.x, self.y)
	local function onAnimationFinished()
		if callback then callback() end
	end

	local startPos = ccp(fromPos.x, fromPos.y+28)
	local animate = TileCrystalStoneAnimate:buildChangeColorAnimate(color, ccp(finalPos.x - startPos.x, finalPos.y - startPos.y), onAnimationFinished)
	animate:setPosition(startPos)
	self.itemSprite[ItemSpriteType.kCrystalStoneEffect] = animate
	self.isNeedUpdate = true
end

function ItemView:buildTotems(colortype, isActived, isOnlyGetSprite)
	local sprite = TileTotems:create(colortype, isActived)
	if not isOnlyGetSprite then
		self.itemSprite[ItemSpriteType.kItemShow] = sprite
	end
	return sprite
end

function ItemView:playTotemsChangeToActive(callback)
	local totems = self.itemSprite[ItemSpriteType.kItemShow]
	if totems and type(totems.playChangeAnimate) == "function" then
		totems:playChangeAnimate(callback)
	end
end

function ItemView:playSuperTotemsWaittingExplode(linkToPos)
	local totems = self.itemSprite[ItemSpriteType.kItemShow]
	if totems and type(totems.hideTotems) == "function" then
		totems:hideTotems()
	end

	local selfPos = self:getBasePosition(self.x, self.y)
	local waittingAnimate = TileTotemsAnimation:buildTotemsWattingExplodeAnimate()
	waittingAnimate:setPosition(selfPos)
	self.itemSprite[ItemSpriteType.kSuperTotemsEffect] = waittingAnimate

	if linkToPos then
		local targetPos = self:getBasePosition(linkToPos.y, linkToPos.x)
		local lightningAnimate = TileTotemsAnimation:buildTotemsExplodeLightning(selfPos, targetPos)
		lightningAnimate:setPosition(selfPos)
		self.itemSprite[ItemSpriteType.kSuperTotemsLight] = lightningAnimate
	end
end

function ItemView:playSuperTotemsDestoryAnimate()
	if self.itemSprite[ItemSpriteType.kSuperTotemsLight] then
		self.itemSprite[ItemSpriteType.kSuperTotemsLight]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kSuperTotemsLight] = nil
	end
	if self.itemSprite[ItemSpriteType.kSuperTotemsEffect] then
		self.itemSprite[ItemSpriteType.kSuperTotemsEffect]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kSuperTotemsEffect] = nil
	end
	if self.itemSprite[ItemSpriteType.kItemShow] then
		self.itemSprite[ItemSpriteType.kItemShow]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kItemShow] = nil
	end
end

function ItemView:playTileHighlightEffect(highlightType)
	self:stopTileHighlightEffect()

	if highlightType == TileHighlightType.kTotems then
		local effect = TileTotemsAnimation:createTileLight()
		effect:setPosition(self:getBasePosition(self.x, self.y))

		self.itemSprite[ItemSpriteType.kTileHighlightEffect] = effect
	end
end

function ItemView:stopTileHighlightEffect()
	if self.itemSprite[ItemSpriteType.kTileHighlightEffect] then
		self.itemSprite[ItemSpriteType.kTileHighlightEffect]:removeFromParentAndCleanup(true)
		self.itemSprite[ItemSpriteType.kTileHighlightEffect] = nil
	end
end
function ItemView:addWukongProgress(add)
	if self.oldData and self.oldData.ItemType == GameItemType.kWukong then
		local tileWukong = self:getWukongSprite()
		self.oldData.wukongProgressCurr = self.oldData.wukongProgressCurr + add
		if self.oldData.wukongProgressCurr > self.oldData.wukongProgressTotal then
			self.oldData.wukongProgressCurr = self.oldData.wukongProgressTotal
		end
		if tileWukong then
			tileWukong:setProgress(self.oldData.wukongProgressCurr , self.oldData.wukongProgressTotal)
		end
	end
end

function ItemView:setWukongProgress(curr , total)
	local tileWukong = self:getWukongSprite()
	if tileWukong then

		tileWukong:setProgress(curr , total)
	end
end

function ItemView:cleanSuperCuteBallView()
	if self.itemSprite[ItemSpriteType.kSuperCuteHighLevel] then
		if self.itemSprite[ItemSpriteType.kSuperCuteHighLevel]:getParent() then
			self.itemSprite[ItemSpriteType.kSuperCuteHighLevel]:removeFromParentAndCleanup(true)
		end
		self.itemSprite[ItemSpriteType.kSuperCuteHighLevel] = nil
	end
	if self.itemSprite[ItemSpriteType.kSuperCuteLowLevel] then
		if self.itemSprite[ItemSpriteType.kSuperCuteLowLevel]:getParent() then
			self.itemSprite[ItemSpriteType.kSuperCuteLowLevel]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kSuperCuteLowLevel] = nil
		end
	end
end

function ItemView:addSuperCuteBall(ballState)
	self:cleanSuperCuteBallView()

	local sprite = TileSuperCuteBall:create(ballState)
	sprite:setPosition(self:getBasePosition(self.x, self.y))

	if ballState == GameItemSuperCuteBallState.kInactive then
		self.itemSprite[ItemSpriteType.kSuperCuteLowLevel] = sprite
	else
		self.itemSprite[ItemSpriteType.kSuperCuteHighLevel] = sprite
	end
end

function ItemView:playSuperCuteMove(direction, callback)
	local superCute = self.itemSprite[ItemSpriteType.kSuperCuteHighLevel]

	if superCute then
		local function onAnimFinish()
			if type(callback) == "function" then callback() end 
		end	

		superCute:removeFromParentAndCleanup(false)
		self.itemSprite[ItemSpriteType.kSuperCuteHighLevel] = nil

		if self.itemSprite[ItemSpriteType.kSpecial] then
			self.itemSprite[ItemSpriteType.kSpecial]:removeFromParentAndCleanup(true)
			self.itemSprite[ItemSpriteType.kSpecial] = nil
		end

		self.itemSprite[ItemSpriteType.kSpecial] = superCute
		self.isNeedUpdate = true

		local jumDir = nil
		if direction.x == 0 and direction.y == 1 then
			jumDir = SuperCuteBallJumpDirection.kRight
		elseif direction.x == 0 and direction.y == -1 then
			jumDir = SuperCuteBallJumpDirection.kLeft
		elseif direction.x == 1 and direction.y == 0 then
			jumDir = SuperCuteBallJumpDirection.kDown
		elseif direction.x == -1 and direction.y == 0 then
			jumDir = SuperCuteBallJumpDirection.kUp
		end
		if jumDir then
			superCute:playJump(jumDir, onAnimFinish)
		else
			onAnimFinish()
		end
	else
		if type(callback) == "function" then callback() end 
	end
end

function ItemView:playSuperCuteInactive(callback)
	local superCute = self.itemSprite[ItemSpriteType.kSuperCuteHighLevel]
	if superCute then
		local function onAnimFinish()
			superCute:removeFromParentAndCleanup(false)
			self.itemSprite[ItemSpriteType.kSuperCuteHighLevel] = nil
			superCute:playInactive()
			self.itemSprite[ItemSpriteType.kSuperCuteLowLevel] = superCute
		
			self.isNeedUpdate = true
			if type(callback) == "function" then callback() end 
		end
		superCute:playHide(onAnimFinish)
	else
		if type(callback) == "function" then callback() end 
	end
end

function ItemView:playSuperCuteRecover(callback)
	local superCute = self.itemSprite[ItemSpriteType.kSuperCuteLowLevel]
	if superCute then
		local function jumpToHighLevel()
			superCute:removeFromParentAndCleanup(false)
			self.itemSprite[ItemSpriteType.kSuperCuteLowLevel] = nil

			self.itemSprite[ItemSpriteType.kSuperCuteHighLevel] = superCute
			self.isNeedUpdate = true
		end
		local function onAnimFinish()
			superCute:playIdle(true)
			if type(callback) == "function" then callback() end
		end
		superCute:playShow(onAnimFinish, jumpToHighLevel)
	else
		if type(callback) == "function" then callback() end 
	end
end