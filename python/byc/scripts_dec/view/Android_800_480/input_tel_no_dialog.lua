input_tel_no_dialog=
{
	name="input_tel_no_dialog",type=0,typeName="View",time=0,x=0,y=0,width=0,height=0,visible=1,fillParentWidth=1,fillParentHeight=1,nodeAlign=kAlignTopLeft,
	{
		name="bg",type=1,typeName="Image",time=98001422,x=0,y=-54,width=646,height=372,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/background/dialog_bg_2.png",gridLeft=64,gridRight=64,gridTop=64,gridBottom=64,
		{
			name="num_input_text_bg",type=1,typeName="Image",time=98001574,x=-1,y=-63,width=514,height=62,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/background/input_bg_2.png",gridLeft=33,gridRight=33,gridTop=31,gridBottom=31,
			{
				name="num_input_edit",type=6,typeName="EditText",time=98001797,x=6,y=0,width=505,height=76,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=32,textAlign=kAlignLeft,colorRed=80,colorGreen=80,colorBlue=80,string=[[]]
			}
		},
		{
			name="tips",type=4,typeName="Text",time=98001710,x=64,y=-8,width=338,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignLeft,fontSize=26,textAlign=kAlignLeft,colorRed=200,colorGreen=40,colorBlue=40,string=[[话费将直接充到该手机号码上]]
		},
		{
			name="cancel_btn",type=2,typeName="Button",time=98001889,x=-139,y=88,width=244,height=85,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/button/dialog_btn_8_normal.png",file2="common/button/dialog_btn_8_press.png",
			{
				name="text",type=4,typeName="Text",time=98002018,x=0,y=0,width=200,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=32,textAlign=kAlignCenter,colorRed=240,colorGreen=230,colorBlue=210,string=[[取消]]
			}
		},
		{
			name="ok_btn",type=2,typeName="Button",time=98001955,x=139,y=88,width=244,height=85,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,file="common/button/dialog_btn_4_normal.png",file2="common/button/dialog_btn_4_press.png",
			{
				name="text",type=4,typeName="Text",time=98001989,x=0,y=0,width=200,height=150,visible=1,fillParentWidth=0,fillParentHeight=0,nodeAlign=kAlignCenter,fontSize=32,textAlign=kAlignCenter,colorRed=240,colorGreen=230,colorBlue=210,string=[[确定]]
			}
		}
	}
}