-- Filename: DB_Item_exclusive_fragment.lua
-- Author: auto-created by XmlToScript tool.
-- Function: it`s auto-created by XmlToScript tool.

module("DB_Item_exclusive_fragment", package.seeall)

keys = {
	"id", "name", "info", "icon_small", "icon_big", "item_type", "quality", "sellable", "sellType", "sellNum", "maxStacking", "canDestroy", "need_part_num", "treasureId", "dropexplore", "masterkey", "item_getway", 
}

Item_exclusive_fragment = {
	id_7000011 = {7000011, "白胡子长刀", "锋利又霸道的长刀，看着就会让人心生敬畏。", "small_exclusive_1.png", "big_exclusive_1.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700001, nil, "7200011|1", "12", },
	id_7000021 = {7000021, "战国海鸥帽", "帽子上有一只海鸥，是海军的标志。", "small_exclusive_2.png", "big_exclusive_2.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700002, nil, "7200011|1", "12", },
	id_7000031 = {7000031, "雷利长剑", "威力极强的长剑。", "small_exclusive_3.png", "big_exclusive_3.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700003, nil, "7200011|1", "12", },
	id_7000041 = {7000041, "黑胡子樱桃派　", "黑胡子喜欢的樱桃派，却不被路飞所喜爱。", "small_exclusive_4.png", "big_exclusive_4.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700004, nil, "7200011|1", "12", },
	id_7000051 = {7000051, "黄猿天丛云剑", "融合了光的威力的长剑，极为耀眼。", "small_exclusive_5.png", "big_exclusive_5.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700005, nil, "7200011|1", "12", },
	id_7000061 = {7000061, "青雉自行车", "青雉的专属交通工具。", "small_exclusive_6.png", "big_exclusive_6.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700006, nil, "7200011|1", "12", },
	id_7000071 = {7000071, "希流之刀", "希流的长刀。", "small_exclusive_7.png", "big_exclusive_7.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700007, nil, "7200011|1", "12", },
	id_7000081 = {7000081, "杰克斯长刀", "杰克斯的长刀。", "small_exclusive_8.png", "big_exclusive_8.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700008, nil, "7200011|1", "12", },
	id_7000091 = {7000091, "赤犬蔷薇胸花", "总被赤犬佩戴在胸前的蔷薇花。", "small_exclusive_9.png", "big_exclusive_9.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700009, nil, "7200011|1", "12", },
	id_7000101 = {7000101, "麦哲伦宝座", "麦哲伦常用署長椅子。", "small_exclusive_10.png", "big_exclusive_10.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700010, nil, "7200011|1", "12", },
	id_7000111 = {7000111, "米霍克黑刀", "世界上仅有的宝刀之一，刀刃为乱刃。", "small_exclusive_11.png", "big_exclusive_11.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700011, nil, "7200011|1", "12", },
	id_7000121 = {7000121, "戈普狗头帽", "戈普的狗头帽。", "small_exclusive_12.png", "big_exclusive_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700012, nil, "7200011|1", "12", },
	id_7000131 = {7000131, "火鸟大衣", "多弗拉门戈的火鸟大衣。", "small_5_huo_13.png", "big_5_huo_13.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700013, nil, "7200011|1", "12", },
	id_7000141 = {7000141, "狙击王面具", "这个面具给予撒谎布勇气，变身狙击之王，拯救伙伴。", "small_5_feng_10.png", "big_5_feng_10.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700014, "21", "7200011|1", "12", },
	id_7000151 = {7000151, "天候棒", "撒谎布为奈美制作的武器，可以改变天气。", "small_5_lei_11.png", "big_5_lei_11.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700015, "13", "7200011|1", "12", },
	id_7000161 = {7000161, "乔巴医疗包", "立志制成“万能药”的乔巴会在医疗包里放置许多医疗必备品。", "small_5_huo_8.png", "big_5_huo_8.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700016, nil, "7200011|1", "12", },
	id_7000171 = {7000171, "战桃丸巨斧", "战桃丸随身携带的巨斧，和本人一样巨大。", "small_5_lei_7.png", "big_5_lei_7.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700017, "23", "7200011|1", "12", },
	id_7000181 = {7000181, "海楼石十手", "添加了海楼石的特殊武器，对战恶魔果实能力者时可以发挥最大威力。", "small_5_lei_8.png", "big_5_lei_8.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700018, "19", "7200011|1", "12", },
	id_7000191 = {7000191, "大熊的书", "大熊随身携带的一本书。", "small_5_lei_9.png", "big_5_lei_9.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700019, nil, "7200011|1", "12", },
	id_7000201 = {7000201, "罗宾牛仔帽", "罗宾的牛仔帽，是在沙漠中生活旅行的必备用具。", "small_5_feng_7.png", "big_5_feng_7.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700020, "23", "7200011|1", "12", },
	id_7000211 = {7000211, "能量可乐", "弗兰奇最喜欢的饮料，饮用之后迅速补充能量。", "small_5_shui_5.png", "big_5_shui_5.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700021, "26", "7200011|1", "12", },
	id_7000221 = {7000221, "布鲁克提琴", "布鲁克的灵魂乐器。", "small_5_shui_12.png", "big_5_shui_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700022, "17", "7200011|1", "12", },
	id_7000231 = {7000231, "剧毒金钩", "鳄鱼左手上的金钩，涂有剧毒。", "small_5_lei_5.png", "big_5_lei_5.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700023, "26", "7200011|1", "12", },
	id_7000241 = {7000241, "神之勾玉鼓", "艾尼路的勾玉鼓。", "small_5_huo_5.png", "big_5_huo_5.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700024, nil, "7200011|1", "12", },
	id_7000251 = {7000251, "女帝耳环", "九蛇女帝的蛇形金耳环。", "small_5_feng_5.png", "big_5_feng_5.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700025, nil, "7200011|1", "12", },
	id_7000261 = {7000261, "甚平斗篷", "甚平的斗篷。", "small_5_huo_6.png", "big_5_huo_6.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700026, nil, "7200011|1", "12", },
	id_7000271 = {7000271, "基德金属臂", "将各种不同类型金属不规律地聚集在一起做成的金属臂。", "small_5_lei_13.png", "big_5_lei_13.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700027, nil, "7200011|1", "12", },
	id_7000281 = {7000281, "毒Q", "毒Q", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700028, nil, "7200011|1", "12", },
	id_7000291 = {7000291, "佩罗娜伞", "和佩罗娜一样可爱的伞。", "small_5_huo_10.png", "big_5_huo_10.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700029, nil, "7200011|1", "12", },
	id_7000301 = {7000301, "莫利亚影剪刀", "莫利亚的武器。", "small_5_lei_6.png", "big_5_lei_6.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700030, nil, "7200011|1", "12", },
	id_7000311 = {7000311, "路飞草帽", "杰克斯从罗杰手中接过并传承的路飞的草帽，路飞视其为珍宝。", "small_5_feng_12.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700031, "11", "7200011|1", "12|21", },
	id_7000321 = {7000321, "佐罗佩刀", "佐罗的三刀流武器。", "small_5_lei_10.png", "big_5_lei_10.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700032, "19", "7200011|1", "12", },
	id_7000331 = {7000331, "厨师香烟", "山智离不开的香烟。", "small_5_feng_9.png", "big_5_feng_9.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700033, "15", "7200011|1", "12", },
	id_7000341 = {7000341, "罗之鬼哭", "罗的爱刀。", "small_5_lei_12.png", "big_5_lei_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700034, nil, "7200011|1", "12", },
	id_7000351 = {7000351, "艾斯牛仔帽", "帽子上有奸笑和难过这两种表情图案，并且绑着一个骷髅头的牌子。", "small_5_feng_8.png", "big_5_feng_8.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700035, nil, "7200011|1", "12", },
	id_7000361 = {7000361, "马尔科", "马尔科", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700036, nil, "7200011|1", "12", },
	id_7000371 = {7000371, "塔系米眼镜", "塔系米的近视眼镜。", "small_5_feng_11.png", "big_5_feng_11.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700037, "17", "7200011|1", "12", },
	id_7000381 = {7000381, "德雷克眼罩", "德雷克专属眼罩。", "small_5_feng_6.png", "big_5_feng_6.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700038, nil, "7200011|1", "12", },
	id_7000391 = {7000391, "人妖王麦克风", "可以将人妖王伊万科夫所演讲的内容，清晰地传递出去的麦克风。", "small_5_shui_10.png", "big_5_shui_10.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700039, nil, "7200011|1", "12", },
	id_7000401 = {7000401, "公主项链", "薇薇的项链。", "small_5_shui_6.png", "big_5_shui_6.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700040, nil, "7200011|1", "12", },
	id_7000411 = {7000411, "拉克约", "拉克约", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700041, nil, "7200011|1", "12", },
	id_7000421 = {7000421, "那谬尔", "那谬尔", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700042, nil, "7200011|1", "12", },
	id_7000431 = {7000431, "布伦海姆", "布伦海姆", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700043, nil, "7200011|1", "12", },
	id_7000441 = {7000441, "库利艾尔", "库利艾尔", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700044, nil, "7200011|1", "12", },
	id_7000451 = {7000451, "蒂波", "蒂波", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700045, nil, "7200011|1", "12", },
	id_7000461 = {7000461, "鲁兹领带", "鲁兹的领带。", "small_5_shui_11.png", "big_5_shui_11.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700046, nil, "7200011|1", "12", },
	id_7000471 = {7000471, "钻石乔兹", "钻石乔兹", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700047, nil, "7200011|1", "12", },
	id_7000481 = {7000481, "萨奇", "萨奇", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700048, nil, "7200011|1", "12", },
	id_7000491 = {7000491, "花剑比斯塔", "花剑比斯塔", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700049, nil, "7200011|1", "12", },
	id_7000501 = {7000501, "布拉曼克", "布拉曼克", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700050, nil, "7200011|1", "12", },
	id_7000511 = {7000511, "拉非特", "拉非特", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700051, nil, "7200011|1", "12", },
	id_7000521 = {7000521, "范.奥卡", "范.奥卡", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700052, nil, "7200011|1", "12", },
	id_7000531 = {7000531, "巴加斯", "巴加斯", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700053, nil, "7200011|1", "12", },
	id_7000541 = {7000541, "稻草人", "代替霍金斯承受攻击的稻草人。", "small_5_huo_9.png", "big_5_huo_9.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700054, nil, "7200011|1", "12", },
	id_7000551 = {7000551, "阿保耳麦", "阿保的耳麦。", "small_5_shui_8.png", "big_5_shui_8.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700055, nil, "7200011|1", "12", },
	id_7000561 = {7000561, "骷髅腰带", "奥兹用骷髅做成的腰带。", "small_5_huo_12.png", "big_5_huo_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700056, nil, "7200011|1", "12", },
	id_7000571 = {7000571, "贝宝连体服", "贝宝橙色的工作服。", "small_5_shui_7.png", "big_5_shui_7.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700057, "21", "7200011|1", "12", },
	id_7000581 = {7000581, "金古多", "金古多", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700058, nil, "7200011|1", "12", },
	id_7000591 = {7000591, "哈尔塔", "哈尔塔", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700059, nil, "7200011|1", "12", },
	id_7000601 = {7000601, "水牛阿特摩斯", "水牛阿特摩斯", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700060, nil, "7200011|1", "12", },
	id_7000611 = {7000611, "天鹅舞鞋", "本萨姆美丽的天鹅舞鞋。", "small_5_huo_7.png", "big_5_huo_7.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700061, "15", "7200011|1", "12", },
	id_7000621 = {7000621, "斯比多.基尔", "斯比多.基尔", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700062, nil, "7200011|1", "12", },
	id_7000631 = {7000631, "佛萨", "佛萨", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700063, nil, "7200011|1", "12", },
	id_7000641 = {7000641, "以藏", "以藏", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700064, nil, "7200011|1", "12", },
	id_7000651 = {7000651, "恶狼", "恶狼", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700065, nil, "7200011|1", "12", },
	id_7000661 = {7000661, "乔特", "乔特", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700066, nil, "7200011|1", "12", },
	id_7000671 = {7000671, "皮萨罗", "皮萨罗", "small_5_feng_4.png", "big_5_feng_12.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700067, nil, "7200011|1", "12", },
	id_7000681 = {7000681, "巴奇斗篷", "巴奇船长的专用斗篷。", "small_5_huo_11.png", "big_5_huo_11.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700068, "11", "7200011|1", "12", },
	id_7000691 = {7000691, "Mr.1武僧袍", "Mr.1的宽松武僧袍。", "small_5_shui_9.png", "big_5_shui_9.png", 4, 5, 0, 1, 200, 9999, nil, 20, 700069, "13", "7200011|1", "12", },
	id_7000701 = {7000701, "日奈手套", "日奈的手套，真皮制成，十分结实。", "small_exclusive_37.png", "big_exclusive_37.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700070, nil, "7200011|1", "12", },
	id_7000711 = {7000711, "乌鲁吉铁杵", "乌鲁吉的巨型铁杵，异常沉重。", "small_exclusive_40.png", "big_exclusive_40.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700071, nil, "7200011|1", "12", },
	id_7000721 = {7000721, "卡古船工锤", "卡古作为船工时修船用的锤子。", "small_exclusive_42.png", "big_exclusive_42.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700072, nil, "7200011|1", "12", },
	id_7000731 = {7000731, "龙马木屐", "龙马的木屐简洁轻便。", "small_exclusive_60.png", "big_exclusive_60.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700073, nil, "7200011|1", "12", },
	id_7000741 = {7000741, "基拉刀", "基拉的外形奇特的武器。", "small_exclusive_63.png", "big_exclusive_63.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700074, nil, "7200011|1", "12", },
	id_7000751 = {7000751, "佳妮法香皂", "充满了泡泡的香皂。", "small_exclusive_64.png", "big_exclusive_64.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700075, nil, "7200011|1", "12", },
	id_7000761 = {7000761, "等等再填", nil, "small_exclusive_70.png", "big_exclusive_70.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700076, nil, "7200011|1", "12", },
	id_7000771 = {7000771, "等等再填", nil, "small_exclusive_71.png", "big_exclusive_71.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700077, nil, "7200011|1", "12", },
	id_7000781 = {7000781, "邦妮之帽", "邦妮的蓝色帽子，设计非常简洁。", "small_exclusive_72.png", "big_exclusive_72.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700078, nil, "7200011|1", "12", },
	id_7000791 = {7000791, "嘉雅医学书", "嘉雅经常拿在手里的医学书。", "small_exclusive_73.png", "big_exclusive_73.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700079, nil, "7200011|1", "12", },
	id_7000801 = {7000801, "班吉雪茄", "班吉专属的雪茄。", "small_exclusive_74.png", "big_exclusive_74.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700080, nil, "7200011|1", "12", },
	id_7000811 = {7000811, "萨迪小姐皮鞭", "令人兴奋的皮鞭。", "small_exclusive_75.png", "big_exclusive_75.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700081, nil, "7200011|1", "12", },
	id_7000821 = {7000821, "汉拔尼的刀", "汉拔尼心爱的刀。", "small_exclusive_77.png", "big_exclusive_77.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700082, nil, "7200011|1", "12", },
	id_7000831 = {7000831, "布鲁诺清洁布", "布鲁诺擦桌子时使用的清洁布。", "small_exclusive_89.png", "big_exclusive_89.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700083, nil, "7200011|1", "12", },
	id_7000841 = {7000841, "闪电领结", "充满时尚感的双色领结。", "small_exclusive_92.png", "big_exclusive_92.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700084, nil, "7200011|1", "12", },
	id_7000851 = {7000851, "丽娜医生饮料", "丽娜医生的饮料。", "small_exclusive_101.png", "big_exclusive_101.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700085, nil, "7200011|1", "12", },
	id_7000861 = {7000861, "加尔迪诺蛋糕", "加尔迪诺制作的的蜡烛蛋糕。", "small_exclusive_104.png", "big_exclusive_104.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700086, nil, "7200011|1", "12", },
	id_7000871 = {7000871, "爱比达狼牙棒", "长满尖刺的狼牙棒。异常沉重。", "small_exclusive_115.png", "big_exclusive_115.png", 4, 5, 0, 1, 100, 9999, nil, 20, 700087, nil, "7200011|1", "12", },
	id_7200011 = {7200011, "万能宝物", "可以在宝物进阶界面转化成任何宝物，用作宝物进阶的材料。", "small_5_wanneng_1.png", "big_5_wanneng_1.png", 4, 5, 0, 1, 200, 9999, nil, 20, 720001, nil, nil, "12", },
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
	local id_data = Item_exclusive_fragment["id_" .. key_id]
	assert(id_data, "Item_exclusive_fragment not found " ..  key_id)
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
	for k, v in pairs(Item_exclusive_fragment) do
		if v[fieldNo] == fieldValue then
			setmetatable (v, mt)
			arrData[#arrData+1] = v
		end
	end

	return arrData
end

function release()
	_G["DB_Item_exclusive_fragment"] = nil
	package.loaded["DB_Item_exclusive_fragment"] = nil
	package.loaded["db/DB_Item_exclusive_fragment"] = nil
end

