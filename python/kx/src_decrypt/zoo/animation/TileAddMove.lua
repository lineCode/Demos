
TileAddMove = class(CocosObject)

local kCharacterAnimationTime = 1/30

function TileAddMove:create(colortype, numAddMove)
	colortype = AnimalTypeConfig.convertColorTypeToIndex(colortype)	
	local node = TileAddMove.new(CCNode:create())
	node.name = "addMove"

	numAddMove = numAddMove or 1

	local mainSprite = CocosObject:create()
	local str_temp = string.format("StaticItem%02d.png", colortype)
	local animal = Sprite:createWithSpriteFrameName(str_temp)
	mainSprite:addChild(animal)

	local stepIcon = Sprite:createWithSpriteFrameName(string.format("add_move%04d", numAddMove - 1))
	stepIcon:setPosition(ccp(25, -25))
	mainSprite:addChild(stepIcon)

	local plusIcon = Sprite:createWithSpriteFrameName("add_move_plus")
	plusIcon:setPosition(ccp(8, -27))
	mainSprite:addChild(plusIcon)

	node.mainSprite = mainSprite
	node:addChild(mainSprite)

	return node
end

function TileAddMove:createAddStepIcon(numAddMove)
	local node = CocosObject:create()
	local stepIcon = Sprite:createWithSpriteFrameName(string.format("add_move%04d", numAddMove - 1))
	stepIcon:setPosition(ccp(25, -25))
	node:addChild(stepIcon)
	
	local plusIcon = Sprite:createWithSpriteFrameName("add_move_plus")
	plusIcon:setPosition(ccp(8, -27))
	node:addChild(plusIcon)

	return node
end