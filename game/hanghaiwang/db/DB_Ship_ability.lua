-- Filename: DB_Ship_ability.lua
-- Author: auto-created by XmlToScript tool.
-- Function: it`s auto-created by XmlToScript tool.

module("DB_Ship_ability", package.seeall)

keys = {
	"id", "name", "attr", "desc", "attr_add", 
}

Ship_ability = {
	id_1 = {1, "生命1", "1|100", "增加生命100", nil, },
	id_2 = {2, "物攻1", "2|10", "增加物攻10", nil, },
	id_3 = {3, "魔攻1", "3|10", "增加魔攻10", nil, },
	id_4 = {4, "物防1", "4|10", "增加物防10", nil, },
	id_5 = {5, "魔防1", "5|10", "增加魔防10", nil, },
	id_6 = {6, "生命百分比1", nil, "增加生命10%", "1|1000", },
	id_7 = {7, "物攻百分比1", nil, "增加物攻10%", "2|1000", },
	id_8 = {8, "魔攻百分比1", nil, "增加魔攻10%", "3|1000", },
	id_9 = {9, "物防百分比1", nil, "增加物防10%", "4|1000", },
	id_10 = {10, "魔防百分比1", nil, "增加魔防10%", "5|1000", },
	id_101 = {101, "生命1", "1|100", "生命+100", nil, },
	id_201 = {201, "攻击1", "2|20,3|20", "攻击+20", nil, },
	id_301 = {301, "防御1", "4|20,5|20", "防御+20", nil, },
	id_401 = {401, "生命百分比1", nil, "生命百分比+4%", "1|400", },
	id_501 = {501, "攻击百分比1", nil, "攻击百分比+4%", "2|400,3|400", },
	id_601 = {601, "防御百分比1", nil, "防御百分比+4%", "4|400,5|400", },
	id_701 = {701, "最终伤害1", "29|70", "最终伤害+70", nil, },
	id_801 = {801, "最终免伤1", "30|70", "最终免伤+70", nil, },
	id_901 = {901, "1", nil, "+", nil, },
	id_1001 = {1001, "1", nil, "+", nil, },
	id_1101 = {1101, "1", nil, "+", nil, },
	id_1201 = {1201, "1", nil, "+", nil, },
	id_1301 = {1301, "1", nil, "+", nil, },
	id_1401 = {1401, "1", nil, "+", nil, },
	id_1501 = {1501, "1", nil, "+", nil, },
	id_1601 = {1601, "1", nil, "+", nil, },
	id_1701 = {1701, "1", nil, "+", nil, },
	id_1801 = {1801, "1", nil, "+", nil, },
	id_1901 = {1901, "1", nil, "+", nil, },
	id_2001 = {2001, "1", nil, "+", nil, },
	id_102 = {102, "生命2", "1|200", "生命+200", nil, },
	id_202 = {202, "攻击2", "2|40,3|40", "攻击+40", nil, },
	id_302 = {302, "防御2", "4|40,5|40", "防御+40", nil, },
	id_402 = {402, "生命百分比2", nil, "生命百分比+8%", "1|800", },
	id_502 = {502, "攻击百分比2", nil, "攻击百分比+8%", "2|800,3|800", },
	id_602 = {602, "防御百分比2", nil, "防御百分比+8%", "4|800,5|800", },
	id_702 = {702, "最终伤害2", "29|140", "最终伤害+140", nil, },
	id_802 = {802, "最终免伤2", "30|140", "最终免伤+140", nil, },
	id_902 = {902, "02", nil, "0+0", nil, },
	id_1002 = {1002, "02", nil, "0+0", nil, },
	id_1102 = {1102, "02", nil, "0+0", nil, },
	id_1202 = {1202, "02", nil, "0+0", nil, },
	id_1302 = {1302, "02", nil, "0+0", nil, },
	id_1402 = {1402, "02", nil, "0+0", nil, },
	id_1502 = {1502, "02", nil, "0+0", nil, },
	id_1602 = {1602, "02", nil, "0+0", nil, },
	id_1702 = {1702, "02", nil, "0+0", nil, },
	id_1802 = {1802, "02", nil, "0+0", nil, },
	id_1902 = {1902, "02", nil, "0+0", nil, },
	id_2002 = {2002, "02", nil, "0+0", nil, },
	id_103 = {103, "生命3", "1|300", "生命+300", nil, },
	id_203 = {203, "攻击3", "2|60,3|60", "攻击+60", nil, },
	id_303 = {303, "防御3", "4|60,5|60", "防御+60", nil, },
	id_403 = {403, "生命百分比3", nil, "生命百分比+12%", "1|1200", },
	id_503 = {503, "攻击百分比3", nil, "攻击百分比+12%", "2|1200,3|1200", },
	id_603 = {603, "防御百分比3", nil, "防御百分比+12%", "4|1200,5|1200", },
	id_703 = {703, "最终伤害3", "29|210", "最终伤害+210", nil, },
	id_803 = {803, "最终免伤3", "30|210", "最终免伤+210", nil, },
	id_903 = {903, "03", nil, "0+0", nil, },
	id_1003 = {1003, "03", nil, "0+0", nil, },
	id_1103 = {1103, "03", nil, "0+0", nil, },
	id_1203 = {1203, "03", nil, "0+0", nil, },
	id_1303 = {1303, "03", nil, "0+0", nil, },
	id_1403 = {1403, "03", nil, "0+0", nil, },
	id_1503 = {1503, "03", nil, "0+0", nil, },
	id_1603 = {1603, "03", nil, "0+0", nil, },
	id_1703 = {1703, "03", nil, "0+0", nil, },
	id_1803 = {1803, "03", nil, "0+0", nil, },
	id_1903 = {1903, "03", nil, "0+0", nil, },
	id_2003 = {2003, "03", nil, "0+0", nil, },
	id_104 = {104, "生命4", "1|400", "生命+400", nil, },
	id_204 = {204, "攻击4", "2|80,3|80", "攻击+80", nil, },
	id_304 = {304, "防御4", "4|80,5|80", "防御+80", nil, },
	id_404 = {404, "生命百分比4", nil, "生命百分比+16%", "1|1600", },
	id_504 = {504, "攻击百分比4", nil, "攻击百分比+16%", "2|1600,3|1600", },
	id_604 = {604, "防御百分比4", nil, "防御百分比+16%", "4|1600,5|1600", },
	id_704 = {704, "最终伤害4", "29|280", "最终伤害+280", nil, },
	id_804 = {804, "最终免伤4", "30|280", "最终免伤+280", nil, },
	id_904 = {904, "04", nil, "0+0", nil, },
	id_1004 = {1004, "04", nil, "0+0", nil, },
	id_1104 = {1104, "04", nil, "0+0", nil, },
	id_1204 = {1204, "04", nil, "0+0", nil, },
	id_1304 = {1304, "04", nil, "0+0", nil, },
	id_1404 = {1404, "04", nil, "0+0", nil, },
	id_1504 = {1504, "04", nil, "0+0", nil, },
	id_1604 = {1604, "04", nil, "0+0", nil, },
	id_1704 = {1704, "04", nil, "0+0", nil, },
	id_1804 = {1804, "04", nil, "0+0", nil, },
	id_1904 = {1904, "04", nil, "0+0", nil, },
	id_2004 = {2004, "04", nil, "0+0", nil, },
	id_105 = {105, "生命5", "1|500", "生命+500", nil, },
	id_205 = {205, "攻击5", "2|100,3|100", "攻击+100", nil, },
	id_305 = {305, "防御5", "4|100,5|100", "防御+100", nil, },
	id_405 = {405, "生命百分比5", nil, "生命百分比+20%", "1|2000", },
	id_505 = {505, "攻击百分比5", nil, "攻击百分比+20%", "2|2000,3|2000", },
	id_605 = {605, "防御百分比5", nil, "防御百分比+20%", "4|2000,5|2000", },
	id_705 = {705, "最终伤害5", "29|350", "最终伤害+350", nil, },
	id_805 = {805, "最终免伤5", "30|350", "最终免伤+350", nil, },
	id_905 = {905, "05", nil, "0+0", nil, },
	id_1005 = {1005, "05", nil, "0+0", nil, },
	id_1105 = {1105, "05", nil, "0+0", nil, },
	id_1205 = {1205, "05", nil, "0+0", nil, },
	id_1305 = {1305, "05", nil, "0+0", nil, },
	id_1405 = {1405, "05", nil, "0+0", nil, },
	id_1505 = {1505, "05", nil, "0+0", nil, },
	id_1605 = {1605, "05", nil, "0+0", nil, },
	id_1705 = {1705, "05", nil, "0+0", nil, },
	id_1805 = {1805, "05", nil, "0+0", nil, },
	id_1905 = {1905, "05", nil, "0+0", nil, },
	id_2005 = {2005, "05", nil, "0+0", nil, },
	id_106 = {106, "生命6", "1|600", "生命+600", nil, },
	id_206 = {206, "攻击6", "2|120,3|120", "攻击+120", nil, },
	id_306 = {306, "防御6", "4|120,5|120", "防御+120", nil, },
	id_406 = {406, "生命百分比6", nil, "生命百分比+24%", "1|2400", },
	id_506 = {506, "攻击百分比6", nil, "攻击百分比+24%", "2|2400,3|2400", },
	id_606 = {606, "防御百分比6", nil, "防御百分比+24%", "4|2400,5|2400", },
	id_706 = {706, "最终伤害6", "29|420", "最终伤害+420", nil, },
	id_806 = {806, "最终免伤6", "30|420", "最终免伤+420", nil, },
	id_906 = {906, "06", nil, "0+0", nil, },
	id_1006 = {1006, "06", nil, "0+0", nil, },
	id_1106 = {1106, "06", nil, "0+0", nil, },
	id_1206 = {1206, "06", nil, "0+0", nil, },
	id_1306 = {1306, "06", nil, "0+0", nil, },
	id_1406 = {1406, "06", nil, "0+0", nil, },
	id_1506 = {1506, "06", nil, "0+0", nil, },
	id_1606 = {1606, "06", nil, "0+0", nil, },
	id_1706 = {1706, "06", nil, "0+0", nil, },
	id_1806 = {1806, "06", nil, "0+0", nil, },
	id_1906 = {1906, "06", nil, "0+0", nil, },
	id_2006 = {2006, "06", nil, "0+0", nil, },
	id_107 = {107, "生命7", "1|700", "生命+700", nil, },
	id_207 = {207, "攻击7", "2|140,3|140", "攻击+140", nil, },
	id_307 = {307, "防御7", "4|140,5|140", "防御+140", nil, },
	id_407 = {407, "生命百分比7", nil, "生命百分比+28%", "1|2800", },
	id_507 = {507, "攻击百分比7", nil, "攻击百分比+28%", "2|2800,3|2800", },
	id_607 = {607, "防御百分比7", nil, "防御百分比+28%", "4|2800,5|2800", },
	id_707 = {707, "最终伤害7", "29|490", "最终伤害+490", nil, },
	id_807 = {807, "最终免伤7", "30|490", "最终免伤+490", nil, },
	id_907 = {907, "07", nil, "0+0", nil, },
	id_1007 = {1007, "07", nil, "0+0", nil, },
	id_1107 = {1107, "07", nil, "0+0", nil, },
	id_1207 = {1207, "07", nil, "0+0", nil, },
	id_1307 = {1307, "07", nil, "0+0", nil, },
	id_1407 = {1407, "07", nil, "0+0", nil, },
	id_1507 = {1507, "07", nil, "0+0", nil, },
	id_1607 = {1607, "07", nil, "0+0", nil, },
	id_1707 = {1707, "07", nil, "0+0", nil, },
	id_1807 = {1807, "07", nil, "0+0", nil, },
	id_1907 = {1907, "07", nil, "0+0", nil, },
	id_2007 = {2007, "07", nil, "0+0", nil, },
	id_108 = {108, "生命8", "1|800", "生命+800", nil, },
	id_208 = {208, "攻击8", "2|160,3|160", "攻击+160", nil, },
	id_308 = {308, "防御8", "4|160,5|160", "防御+160", nil, },
	id_408 = {408, "生命百分比8", nil, "生命百分比+32%", "1|3200", },
	id_508 = {508, "攻击百分比8", nil, "攻击百分比+32%", "2|3200,3|3200", },
	id_608 = {608, "防御百分比8", nil, "防御百分比+32%", "4|3200,5|3200", },
	id_708 = {708, "最终伤害8", "29|560", "最终伤害+560", nil, },
	id_808 = {808, "最终免伤8", "30|560", "最终免伤+560", nil, },
	id_908 = {908, "08", nil, "0+0", nil, },
	id_1008 = {1008, "08", nil, "0+0", nil, },
	id_1108 = {1108, "08", nil, "0+0", nil, },
	id_1208 = {1208, "08", nil, "0+0", nil, },
	id_1308 = {1308, "08", nil, "0+0", nil, },
	id_1408 = {1408, "08", nil, "0+0", nil, },
	id_1508 = {1508, "08", nil, "0+0", nil, },
	id_1608 = {1608, "08", nil, "0+0", nil, },
	id_1708 = {1708, "08", nil, "0+0", nil, },
	id_1808 = {1808, "08", nil, "0+0", nil, },
	id_1908 = {1908, "08", nil, "0+0", nil, },
	id_2008 = {2008, "08", nil, "0+0", nil, },
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
	local id_data = Ship_ability["id_" .. key_id]
	assert(id_data, "Ship_ability not found " ..  key_id)
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
	for k, v in pairs(Ship_ability) do
		if v[fieldNo] == fieldValue then
			setmetatable (v, mt)
			arrData[#arrData+1] = v
		end
	end

	return arrData
end

function release()
	_G["DB_Ship_ability"] = nil
	package.loaded["DB_Ship_ability"] = nil
	package.loaded["db/DB_Ship_ability"] = nil
end
