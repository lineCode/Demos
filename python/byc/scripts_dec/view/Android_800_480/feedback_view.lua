feedback_view=
{
	name="feedback_view",type=0,typeName="View",time=0,x=0,y=0,width=480,height=800,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,
	{
		name="feedback_view_bg",type=1,typeName="Image",time=6142162,x=0,y=0,width=720,height=1280,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,file="common/background/model_bg.png"
	},
	{
		name="title_view",type=0,typeName="View",time=96714086,x=0,y=0,width=650,height=208,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,
		{
			name="Image2",type=1,typeName="Image",time=96714121,x=0,y=97,width=292,height=56,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="hall/logo.png"
		},
		{
			name="version_text",type=4,typeName="Text",time=96714221,x=0,y=7,width=200,height=28,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,fontSize=28,textAlign=kAlignCenter,colorRed=135,colorGreen=100,colorBlue=95,string=[[版本号: 2.0.1]]
		}
	},
	{
		name="bamboo_left",type=1,typeName="Image",time=97152287,x=0,y=0,width=78,height=163,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,file="common/decoration/bamboo_left.png"
	},
	{
		name="bamboo_right",type=1,typeName="Image",time=97152301,x=0,y=0,width=77,height=137,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopRight,file="common/decoration/bamboo_right.png"
	},
	{
		name="teapot_dec",type=1,typeName="Image",time=97152314,x=0,y=320,width=85,height=252,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,file="common/decoration/teapot_dec.png"
	},
	{
		name="stone_dec",type=1,typeName="Image",time=97152330,x=0,y=210,width=26,height=32,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopRight,file="common/decoration/stone_dec.png"
	},
	{
		name="back_btn",type=2,typeName="Button",time=96714043,x=20,y=20,width=86,height=91,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopLeft,file="common/button/back_btn.png",file2="common/button/back_btn_press.png"
	},
	{
		name="input_content_view",type=0,typeName="View",time=96715117,x=0,y=238,width=640,height=676,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,
		{
			name="Image3",type=1,typeName="Image",time=96715153,x=0,y=0,width=640,height=19,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="common/decoration/line.png"
		},
		{
			name="qq_group_text",type=4,typeName="Text",time=96715183,x=0,y=56,width=238,height=28,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,fontSize=28,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[QQ沟通群:46062819]]
		},
		{
			name="input_message_bg",type=1,typeName="Image",time=96715266,x=21,y=-100,width=440,height=265,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,file="common/background/input_bg_2.png",gridLeft=33,gridRight=33,gridTop=31,gridBottom=31,
			{
				name="message_edit",type=7,typeName="EditTextView",time=96715529,x=11,y=0,width=417,height=218,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,fontSize=32,textAlign=kAlignTopLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[请填写您宝贵的意见（必填）]]
			}
		},
		{
			name="feedback_img",type=2,typeName="Button",time=99568940,x=21,y=-101,width=150,height=265,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,file="common/icon/upload_feedback.png",gridLeft=30,gridRight=30,gridTop=30,gridBottom=30
		},
		{
			name="input_phone_bg",type=1,typeName="Image",time=96715632,x=0,y=391,width=600,height=70,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="common/background/input_bg_2.png",gridLeft=33,gridRight=33,gridTop=32,gridBottom=32,
			{
				name="phone_edit",type=6,typeName="EditText",time=96715743,x=15,y=0,width=584,height=78,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,fontSize=32,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[]]
			}
		},
		{
			name="Text3",type=4,typeName="Text",time=96715792,x=0,y=481,width=540,height=24,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,fontSize=24,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[提供有效的信息,有助于更快的解决诉求。感谢支持!]]
		},
		{
			name="send_btn",type=2,typeName="Button",time=96715889,x=0,y=525,width=571,height=97,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop,file="common/button/dialog_btn_2_normal.png",file2="common/button/dialog_btn_2_press.png",gridLeft=64,gridRight=64,gridTop=29,gridBottom=29,
			{
				name="Text4",type=4,typeName="Text",time=96715952,x=0,y=0,width=0,height=0,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=40,textAlign=kAlignLeft,colorRed=240,colorGreen=230,colorBlue=210,string=[[提交反馈]]
			}
		},
		{
			name="Image4",type=1,typeName="Image",time=96716179,x=0,y=0,width=640,height=19,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignBottom,file="common/decoration/line.png"
		}
	},
	{
		name="feedback_record_placeholder",type=0,typeName="View",time=96716101,x=0,y=905,width=614,height=374,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTop
	},
	{
		name="title_icon",type=1,typeName="Image",time=98511325,x=0,y=0,width=110,height=290,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignTopRight,file="common/decoration/bookmark_bg.png",
		{
			name="Text2",type=4,typeName="Text",time=98511326,x=20,y=-67,width=40,height=40,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,fontSize=40,textAlign=kAlignLeft,colorRed=240,colorGreen=230,colorBlue=210,string=[[反]]
		},
		{
			name="Text1",type=4,typeName="Text",time=98511327,x=20,y=3,width=40,height=40,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignRight,fontSize=40,textAlign=kAlignLeft,colorRed=240,colorGreen=230,colorBlue=210,string=[[馈]]
		}
	}
}