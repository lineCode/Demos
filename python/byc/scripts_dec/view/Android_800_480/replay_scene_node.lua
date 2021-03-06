replay_scene_node=
{
	name="replay_scene_node",type=0,typeName="View",time=0,x=0,y=0,width=630,height=400,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,
	{
		name="bg",type=1,typeName="Image",time=111657036,x=0,y=0,width=630,height=390,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignCenter,file="replay/replay_node_bg.png",gridLeft=30,gridRight=30,gridTop=30,gridBottom=30
	},
	{
		name="title",type=0,typeName="View",time=111657453,x=0,y=0,width=630,height=80,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignTopLeft,
		{
			name="native_title",type=0,typeName="View",time=111658222,x=106,y=190,width=630,height=150,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,
			{
				name="left_title",type=0,typeName="View",time=111658292,x=0,y=0,width=315,height=80,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignLeft,
				{
					name="icon",type=1,typeName="Image",time=111658565,x=20,y=0,width=60,height=60,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,file="replay/replay_chess_icon.png"
				},
				{
					name="chess_type",type=4,typeName="Text",time=111658727,x=88,y=12,width=112,height=28,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,fontSize=28,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[联网观战]]
				},
				{
					name="chess_time",type=4,typeName="Text",time=111658732,x=88,y=42,width=120,height=24,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,fontSize=24,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[2016/04/12]]
				}
			},
			{
				name="right_title",type=0,typeName="View",time=111658332,x=0,y=0,width=315,height=80,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignRight,
				{
					name="only_self",type=0,typeName="View",time=111659756,x=-174,y=140,width=200,height=150,visible=0,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,
					{
						name="img",type=1,typeName="Image",time=111659826,x=33,y=0,width=128,height=24,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,file="replay/only_self.png"
					}
				},
				{
					name="open_chess",type=0,typeName="View",time=111659977,x=0,y=0,width=315,height=80,visible=0,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignRight,
					{
						name="line",type=1,typeName="Image",time=111659984,x=39,y=0,width=2,height=27,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/line_4.png"
					},
					{
						name="save_img",type=1,typeName="Image",time=111659979,x=-40,y=0,width=24,height=23,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="replay/save_icon.png"
					},
					{
						name="save_txt",type=4,typeName="Text",time=111659980,x=0,y=0,width=44,height=22,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=22,textAlign=kAlignLeft,colorRed=120,colorGreen=120,colorBlue=120,string=[[0]]
					},
					{
						name="comment_img",type=1,typeName="Image",time=111659982,x=75,y=0,width=26,height=22,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,file="replay/comment_icon.png"
					},
					{
						name="comment_txt",type=4,typeName="Text",time=111659983,x=0,y=0,width=70,height=22,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,fontSize=22,textAlign=kAlignLeft,colorRed=120,colorGreen=120,colorBlue=120,string=[[0]]
					}
				}
			},
			{
				name="line",type=1,typeName="Image",time=111661456,x=0,y=0,width=64,height=2,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/decoration/line_2.png"
			}
		},
		{
			name="online_title",type=0,typeName="View",time=111658468,x=106,y=190,width=630,height=150,visible=0,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,
			{
				name="left_title",type=0,typeName="View",time=111658469,x=0,y=0,width=315,height=80,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignLeft,
				{
					name="icon_mask",type=1,typeName="Image",time=111661047,x=20,y=0,width=70,height=70,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,file="userinfo/icon_7070_frame2.png"
				},
				{
					name="owner_name",type=4,typeName="Text",time=111661139,x=110,y=20,width=120,height=24,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,fontSize=30,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[阿飞首付款]]
				}
			},
			{
				name="right_title",type=0,typeName="View",time=111658470,x=1,y=0,width=315,height=80,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignRight,
				{
					name="share_time",type=4,typeName="Text",time=114149603,x=20,y=0,width=290,height=0,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,fontSize=24,textAlign=kAlignRight,colorRed=80,colorGreen=80,colorBlue=80,string=[[18:30]]
				}
			}
		}
	},
	{
		name="content",type=0,typeName="View",time=111657460,x=0,y=80,width=630,height=250,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignTop,
		{
			name="red_user",type=0,typeName="View",time=111661535,x=0,y=0,width=210,height=250,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignLeft,
			{
				name="icon_frame",type=1,typeName="Image",time=111661881,x=0,y=23,width=70,height=70,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="userinfo/icon_7070_frame2.png",
				{
					name="vip_frame",type=1,typeName="Image",time=111664686,x=0,y=0,width=70,height=70,visible=0,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="vip/vip_70.png"
				}
			},
			{
				name="name",type=4,typeName="Text",time=111662050,x=0,y=0,width=96,height=33,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=32,textAlign=kAlignCenter,colorRed=155,colorGreen=65,colorBlue=45,string=[[]]
			},
			{
				name="score",type=4,typeName="Text",time=111662127,x=0,y=38,width=117,height=26,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=26,textAlign=kAlignCenter,colorRed=80,colorGreen=80,colorBlue=80,string=[[积分:2000]]
			},
			{
				name="level",type=1,typeName="Image",time=111662206,x=0,y=23,width=136,height=36,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/icon/big_level_1.png"
			}
		},
		{
			name="middle",type=0,typeName="View",time=111661594,x=0,y=0,width=210,height=250,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignCenter,
			{
				name="board",type=1,typeName="Image",time=111662395,x=0,y=0,width=200,height=230,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/chess_borad.png"
			},
			{
				name="win_bg",type=1,typeName="Image",time=111662895,x=0,y=0,width=64,height=30,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="replay/win_bg.png",
				{
					name="win",type=4,typeName="Text",time=111663013,x=0,y=0,width=0,height=0,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=24,textAlign=kAlignLeft,colorRed=255,colorGreen=255,colorBlue=255,string=[[红胜]]
				}
			},
			{
				name="entry_btn",type=2,typeName="Button",time=111750776,x=0,y=0,width=210,height=250,visible=0,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignCenter,file="drawable/blank.png"
			}
		},
		{
			name="black_user",type=0,typeName="View",time=111662329,x=0,y=0,width=210,height=250,visible=1,fillParentWidth=0,fillParentHeight=1,nodeAlign=kAlignRight,
			{
				name="icon_frame",type=1,typeName="Image",time=111662330,x=0,y=23,width=70,height=70,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="userinfo/icon_7070_frame2.png",
				{
					name="vip_frame",type=1,typeName="Image",time=111664727,x=0,y=0,width=70,height=70,visible=0,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="vip/vip_70.png"
				}
			},
			{
				name="name",type=4,typeName="Text",time=111662331,x=0,y=0,width=192,height=33,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=32,textAlign=kAlignCenter,colorRed=0,colorGreen=0,colorBlue=0,string=[[]]
			},
			{
				name="score",type=4,typeName="Text",time=111662332,x=0,y=38,width=117,height=26,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=26,textAlign=kAlignCenter,colorRed=80,colorGreen=80,colorBlue=80,string=[[积分:2000]]
			},
			{
				name="level",type=1,typeName="Image",time=111662333,x=0,y=23,width=136,height=36,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/icon/big_level_1.png"
			}
		}
	},
	{
		name="bottom",type=0,typeName="View",time=111657468,x=0,y=0,width=630,height=70,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignBottom,
		{
			name="top_line",type=1,typeName="Image",time=111663193,x=0,y=0,width=64,height=2,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignTop,file="common/decoration/line_2.png"
		},
		{
			name="bottom_line",type=1,typeName="Image",time=111658039,x=0,y=0,width=630,height=2,visible=0,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/decoration/line_2.png"
		},
		{
			name="line1",type=1,typeName="Image",time=111663586,x=-105,y=0,width=2,height=46,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/line_4.png"
		},
		{
			name="line2",type=1,typeName="Image",time=111663649,x=105,y=0,width=2,height=46,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/line_4.png"
		},
		{
			name="delete_btn",type=2,typeName="Button",time=111663327,x=40,y=0,width=140,height=36,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,file="replay/delete.png"
		},
		{
			name="share_btn",type=2,typeName="Button",time=111663389,x=0,y=0,width=140,height=36,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="replay/share.png"
		},
		{
			name="save_btn",type=2,typeName="Button",time=111663410,x=40,y=0,width=140,height=36,visible=0,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,file="replay/save.png"
		},
		{
			name="open_btn",type=2,typeName="Button",time=111664010,x=40,y=0,width=140,height=36,visible=0,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,file="replay/open.png"
		},
		{
			name="comment_btn",type=2,typeName="Button",time=111664122,x=40,y=0,width=140,height=36,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,file="replay/comment.png"
		}
	},
	{
		name="front_bg",type=1,typeName="Image",time=111816888,x=0,y=10,width=630,height=250,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignCenter,file="drawable/blank.png",gridLeft=30,gridRight=30,gridTop=30,gridBottom=30
	}
}