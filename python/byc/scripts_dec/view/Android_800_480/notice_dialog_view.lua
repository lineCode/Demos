notice_dialog_view=
{
	name="notice_dialog_view",type=0,typeName="View",time=0,x=0,y=0,width=720,height=1280,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,
	{
		name="blank",type=1,typeName="Image",time=103195823,x=0,y=0,width=0,height=0,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTop,file="drawable/blank_black.png"
	},
	{
		name="bg",type=1,typeName="Image",time=103118357,x=0,y=50,width=642,height=1134,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="common/background/notice_bg.png",gridLeft=128,gridRight=128,gridTop=128,gridBottom=128,
		{
			name="title_bg",type=1,typeName="Image",time=103118709,x=0,y=0,width=680,height=68,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="dialog/scroll.png",
			{
				name="title",type=4,typeName="Text",time=103119606,x=0,y=0,width=200,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=40,textAlign=kAlignCenter,colorRed=80,colorGreen=80,colorBlue=80,string=[[系统公告]]
			},
			{
				name="left_rope",type=1,typeName="Image",time=103120507,x=10,y=-50,width=11,height=101,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,file="common/decoration/left_red_rope.png"
			},
			{
				name="right_rope",type=1,typeName="Image",time=103120418,x=10,y=-50,width=11,height=101,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopRight,file="common/decoration/right_ren_rope.png"
			}
		},
		{
			name="title_shadow",type=1,typeName="Image",time=103118781,x=0,y=68,width=618,height=35,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="dialog/scroll_shadow.png",gridLeft=2,gridRight=2,gridTop=17,gridBottom=17
		},
		{
			name="content_view",type=0,typeName="ScrollView",time=103119754,x=0,y=105,width=561,height=842,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop
		},
		{
			name="btn_cloud",type=1,typeName="Image",time=103119040,x=0,y=161,width=558,height=21,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/decoration/line.png"
		},
		{
			name="btn1",type=2,typeName="Button",time=103119149,x=-140,y=46,width=244,height=85,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/button/dialog_btn_8_normal.png",file2="common/button/dialog_btn_8_press.png",
			{
				name="text",type=4,typeName="Text",time=103119352,x=-1,y=-1,width=200,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=35,textAlign=kAlignCenter,colorRed=240,colorGreen=230,colorBlue=210,string=[[查看]]
			}
		},
		{
			name="btn2",type=2,typeName="Button",time=103119216,x=139,y=46,width=244,height=85,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/button/dialog_btn_4_normal.png",file2="common/button/dialog_btn_4_press.png",
			{
				name="text",type=4,typeName="Text",time=103119528,x=-1,y=-1,width=200,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=35,textAlign=kAlignCenter,colorRed=240,colorGreen=230,colorBlue=210,string=[[确定]]
			}
		}
	}
}