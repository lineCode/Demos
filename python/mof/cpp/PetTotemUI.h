#ifndef MOF_PETTOTEMUI_H
#define MOF_PETTOTEMUI_H

class PetTotemUI{
public:
	void setTotemSelIdx(int);
	void create(void);
	void ccTouchEnded(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void setPetSelList(PetList &);
	void onAssignCCBMemberVariable(cocos2d::CCObject	*,char const*,cocos2d::CCNode *);
	void deleteAllPetSeled(void);
	void getIsPause(void);
	void progressAction(float);
	void ccTouchCancelled(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void onDescAwardTouchUpOutsideClicked(cocos2d::CCObject *);
	void ~PetTotemUI();
	void getTotemTouchData(int);
	void ccTouchEnded(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void onEventTouched(int, bool);
	void onMenuItemHelperClosed(cocos2d::CCObject *);
	void onMenuItemHelpClicked(cocos2d::CCObject *);
	void getIsPause(void)const;
	void onAssignCCBMemberVariable(cocos2d::CCObject *,char const*,cocos2d::CCNode	*);
	void ccTouchCancelled(cocos2d::CCTouch	*,cocos2d::CCEvent *);
	void onMenuItemOfferClicked(cocos2d::CCObject *);
	void onResolveCCBCCMenuItemSelector(cocos2d::CCObject *,char const*);
	void changeToArrayUI(void);
	void setIsPause(int);
	void ccTouchCancelled(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void changeToOfferUI(void);
	void resetProgress(void);
	void ccTouchBegan(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void ccTouchBegan(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void onExit(void);
	void createDesc(void);
	void getArrayToShow(void)const;
	void registerWithTouchDispatcher(void);
	void ccTouchEnded(cocos2d::CCTouch *, cocos2d::CCEvent	*);
	void onAssignCCBMemberVariable(cocos2d::CCObject *, char const*, cocos2d::CCNode *);
	void showPetSeled(void);
	void onResolveCCBCCMenuItemSelector(cocos2d::CCObject *,	char const*);
	void onDescAwardDragInsideClicked(cocos2d::CCObject *);
	void createScrollArray(void);
	void ccTouchCancelled(cocos2d::CCTouch	*, cocos2d::CCEvent *);
	void setPetSelTag(int);
	void setTotemData(int,TotemData);
	void refreshCurGroup(void);
	void isAlreadyHave(PetMonster *);
	void getTotemSelIdx(void);
	void onAssignCCBMemberVariable(cocos2d::CCObject	*, char	const*,	cocos2d::CCNode	*);
	void onResolveCCBCCMenuItemSelector(cocos2d::CCObject *, char const*);
	void setTotemData(int,	TotemData);
	void ccTouchMoved(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void getTotemSelItem(void);
	void ccTouchMoved(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void createPetList(void);
	void onEnter(void);
	void onMenuItemTotemClicked(cocos2d::CCObject *);
	void onDescAwardTouchUpInsideClicked(cocos2d::CCObject *);
	void onMenuItemCloseClicked(cocos2d::CCObject *);
	void getArrayToShow(void);
	void onDescAwardTouchUpOutsideClicked(cocos2d::CCObject	*);
	void onMenuItemCloseOfferClicked(cocos2d::CCObject *);
	void onMenuItemSelPetClicked(cocos2d::CCObject	*);
	void getTotemSelItem(void)const;
	void onMenuItemNextPageClicked(cocos2d::CCObject *);
	void setTotemSelItem(int);
	void onDescAwardTouchUpInsideClicked(cocos2d::CCObject	*);
	void onMenuItemSelPetClicked(cocos2d::CCObject *);
	void createTotem(int);
	void onEventTouched(int,bool);
	void ccTouchBegan(cocos2d::CCTouch *, cocos2d::CCEvent	*);
	void createProgress(void);
	void createTotemDesc(void);
	void getTotemSelIdx(void)const;
	void PetTotemUI(void);
	void setArrayToShow(int);
	void ccTouchMoved(cocos2d::CCTouch *, cocos2d::CCEvent	*);
	void createItemButtonForLook(void);
	void init(void);
	void onDescAwardTouchDownClicked(cocos2d::CCObject *);
}
#endif