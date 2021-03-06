-- Filename: DB_Game_tip.lua
-- Author: auto-created by XmlToScript tool.
-- Function: it`s auto-created by XmlToScript tool.

module("DB_Game_tip", package.seeall)

keys = {
	"id", "game_tip", 
}

Game_tip = {
	id_1 = {1, "0xff,0xff,0xff|在副本中战斗将会消耗体力，体力|0x00,0xFF,0x18|每6分钟增长一点|0xff,0xff,0xff|！", },
	id_2 = {2, "0xff,0xff,0xff|在副本中战斗满足获胜条件时会获得奖励星数，奖励星数越高，对应的|0x00,0xFF,0x18|宝箱奖励|0xff,0xff,0xff|也越诱人！", },
	id_3 = {3, "0xff,0xff,0xff|副本中的奖励宝箱有丰厚的奖励，通关副本后请|0x00,0xFF,0x18|及时领取|0xff,0xff,0xff|！", },
	id_4 = {4, "0xff,0xff,0xff|耐力|0x00,0xFF,0x18|每30分钟|0xff,0xff,0xff|回复1点！", },
	id_5 = {5, "0xff,0xff,0xff|攻打深海监狱能够获得|0x00,0xFF,0x18|装备结晶|0xff,0xff,0xff|，装备结晶可以在装备商店中兑换|0x00,0xFF,0x18|装备|0xff,0xff,0xff|！", },
	id_6 = {6, "0xff,0xff,0xff|参加竞技场可获得|0x00,0xFF,0x18|声望|0xff,0xff,0xff|！使用声望可以在竞技场中兑换奖励！", },
	id_7 = {7, "0xff,0xff,0xff|竞技场将在每天晚上22：00|0x00,0xFF,0x18|准时发奖|0xff,0xff,0xff|！", },
	id_8 = {8, "0xff,0xff,0xff|在酒馆中可以|0x00,0xFF,0x18|招募伙伴|0xff,0xff,0xff|，快招募伙伴来组建自己的强大海盗团！", },
	id_9 = {9, "0xff,0xff,0xff|伙伴|0x00,0xFF,0x18|进阶|0xff,0xff,0xff|后将会大幅提升战斗能力！", },
	id_10 = {10, "0xff,0xff,0xff|伙伴|0x00,0xFF,0x18|无法出售|0xff,0xff,0xff|！", },
	id_11 = {11, "0xff,0xff,0xff|伙伴的强化等级无法超过|0x00,0xFF,0x18|船长等级|0xff,0xff,0xff|！", },
	id_12 = {12, "0xff,0xff,0xff|激活伙伴|0x00,0xFF,0x18|属性加成|0xff,0xff,0xff|将会大幅提升战斗力！", },
	id_13 = {13, "0xff,0xff,0xff|有些装备拥有|0x00,0xFF,0x18|套装属性|0xff,0xff,0xff|，快去收集这些装备吧！", },
	id_14 = {14, "0xff,0xff,0xff|强化装备可大幅提升伙伴|0x00,0xFF,0x18|战斗力|0xff,0xff,0xff|，快去强化装备吧！", },
	id_15 = {15, "0xff,0xff,0xff|在探索中能够获得|0x00,0xFF,0x18|属性强大的宝物|0xff,0xff,0xff|！", },
	id_16 = {16, "0xff,0xff,0xff|在百宝箱中可以购买|0x00,0xFF,0x18|宝箱钥匙|0xff,0xff,0xff|！", },
	id_17 = {17, "0xff,0xff,0xff|在攻打副本的过程中有可能获得|0x00,0xFF,0x18|影子、装备|0xff,0xff,0xff|！", },
	id_18 = {18, "0xff,0xff,0xff|伙伴|0x00,0xFF,0x18|突破|0xff,0xff,0xff|后将会大幅提升战斗能力！", },
}

local mt = {}
mt.__index = function (table, key)
	for i = 1, #keys do
		if (keys[i] == key) then
			return table[i]
		end
	end
end

function getDataById(key_id)
	local id_data = Game_tip["id_" .. key_id]
	assert(id_data, "Game_tip not found " ..  key_id)
	if id_data == nil then
		return nil
	end
	if getmetatable(id_data) ~= nil then
		return id_data
	end
	setmetatable(id_data, mt)

	return id_data
end

function getArrDataByField(fieldName, fieldValue)
	local arrData = {}
	local fieldNo = 1
	for i=1, #keys do
		if keys[i] == fieldName then
			fieldNo = i
			break
		end
	end
	for k, v in pairs(Game_tip) do
		if v[fieldNo] == fieldValue then
			setmetatable (v, mt)
			arrData[#arrData+1] = v
		end
	end

	return arrData
end

function release()
	_G["DB_Game_tip"] = nil
	package.loaded["DB_Game_tip"] = nil
	package.loaded["db/DB_Game_tip"] = nil
end

