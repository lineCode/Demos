friends_pop_dialog_view=
{
	name="friends_pop_dialog_view",type=0,typeName="View",time=0,x=0,y=0,width=720,height=1280,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignBottom,
	{
		name="bg",type=1,typeName="Image",time=86925647,x=0,y=1280,width=720,height=1067,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignTopLeft,file="common/background/dialog_bg_1.png",gridLeft=50,gridRight=50,gridTop=50,gridBottom=50,
		{
			name="tittle_view",type=0,typeName="View",time=86927178,x=0,y=0,width=720,height=165,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignTop,
			{
				name="cancel",type=2,typeName="Button",time=86926097,x=10,y=15,width=95,height=50,visible=0,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,file="friends/friends_pop_dialog_cancel_btn.png",file2="friends/friends_pop_dialog_cancel_press_btn.png",
				{
					name="cancel",type=4,typeName="Text",time=86926332,x=0,y=0,width=95,height=50,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,fontSize=28,textAlign=kAlignCenter,colorRed=250,colorGreen=230,colorBlue=180,string=[[取消]]
				}
			},
			{
				name="sure",type=2,typeName="Button",time=86926538,x=10,y=15,width=95,height=50,visible=0,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopRight,file="friends/friends_pop_dialog_sure_btn.png",file2="friends/friends_pop_dialog_sure_press_btn.png",
				{
					name="sure",type=4,typeName="Text",time=86926592,x=0,y=0,width=95,height=50,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,fontSize=28,textAlign=kAlignCenter,colorRed=250,colorGreen=230,colorBlue=180,string=[[确定]]
				}
			},
			{
				name="tittle",type=4,typeName="Text",time=86926670,x=0,y=-8,width=200,height=50,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=44,textAlign=kAlignCenter,colorRed=80,colorGreen=80,colorBlue=80,string=[[选择好友]]
			},
			{
				name="line",type=1,typeName="Image",time=96185739,x=0,y=27,width=640,height=19,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/decoration/line.png"
			}
		},
		{
			name="search_view",type=0,typeName="View",time=88136099,x=0,y=160,width=720,height=80,visible=1,fillParentWidth=1,fillParentHeight=0,nodeAlign=kAlignTopLeft,
			{
				name="search_bg",type=1,typeName="Image",time=86927528,x=-45,y=0,width=551,height=62,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="common/background/input_bg_2.png",gridLeft=25,gridRight=25,gridTop=25,gridBottom=25,
				{
					name="search_content",type=6,typeName="EditText",time=86927854,x=16,y=-2,width=528,height=64,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,fontSize=32,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[]]
				}
			},
			{
				name="search",type=2,typeName="Button",time=110109557,x=283,y=-13,width=91,height=84,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="drawable/blank.png",
				{
					name="Image4",type=1,typeName="Image",time=110109626,x=0,y=2,width=66,height=70,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/button/round_normal.png"
				},
				{
					name="Image1",type=1,typeName="Image",time=96187342,x=0,y=-1,width=36,height=39,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="dialog/search_enable_normal.png"
				}
			}
		},
		{
			name="content_view",type=0,typeName="View",time=86928037,x=0,y=260,width=640,height=635,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,
			{
				name="circle_line",type=1,typeName="Image",time=96187481,x=0,y=0,width=640,height=635,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,file="common/background/line_bg.png",gridLeft=20,gridRight=20,gridTop=20,gridBottom=20
			}
		},
		{
			name="close_btn",type=2,typeName="Button",time=102139074,x=34,y=39,width=60,height=60,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopRight,file="common/button/btn_close.png"
		},
		{
			name="add_friend",type=2,typeName="Button",time=110111566,x=0,y=940,width=571,height=97,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="common/button/dialog_btn_2_normal.png",file2="common/button/dialog_btn_2_press.png",
			{
				name="text",type=4,typeName="Text",time=110111654,x=0,y=0,width=200,height=84,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=40,textAlign=kAlignCenter,colorRed=255,colorGreen=255,colorBlue=255,string=[[添加好友]]
			}
		},
		{
			name="TextView1",type=5,typeName="TextView",time=110448862,x=4,y=450,width=531,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,fontSize=36,textAlign=kAlignCenter,colorRed=135,colorGreen=100,colorBlue=95,string=[[大侠，行走江湖怎能孤身独行？互相关注成为好友结伴而行]]
		}
	}
}