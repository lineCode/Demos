#ifndef MOF_HELPERUI_H
#define MOF_HELPERUI_H

class HelperUI{
public:
	void goNatrualCpy(int);
	void goSynStuff(int);
	void ccTouchEnded(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void onAssignCCBMemberVariable(cocos2d::CCObject	*,char const*,cocos2d::CCNode *);
	void goMythBman(int);
	void goSkillUp(int);
	void ccTouchBegan(cocos2d::CCTouch	*,cocos2d::CCEvent *);
	void ccTouchCancelled(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void create(void);
	void goBuddyDt(int);
	void initControl(void);
	void goAnswer(int);
	void goPetPractise(int);
	void goArena(int);
	void getContentCfg(int);
	void recvContentClicked(int);
	void ccTouchMoved(cocos2d::CCTouch	*, cocos2d::CCEvent *);
	void onAssignCCBMemberVariable(cocos2d::CCObject	*, char	const*,	cocos2d::CCNode	*);
	void goPetMonster(int);
	void onResolveCCBCCMenuItemSelector(cocos2d::CCObject *,char const*);
	void initContent(int);
	void goFamousHall(int);
	void goUpEq(int);
	void onMenuItemPreClicked(cocos2d::CCObject *);
	void goDailyTask(int);
	void ccTouchBegan(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void wakeUpContent(void);
	void ccTouchBegan(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void goDoubleWeek(int);
	void onAssignCCBMemberVariable(cocos2d::CCObject *, char const*, cocos2d::CCNode *);
	void initGotoFunc(void);
	void onResolveCCBCCMenuItemSelector(cocos2d::CCObject *,	char const*);
	void goArenaAward(int);
	void goAdAward(int);
	void ccTouchEnded(cocos2d::CCTouch	*,cocos2d::CCEvent *);
	void ~HelperUI();
	void wakeUpSysNews(void);
	void setMenuTableToIndex(bool);
	void registerWithTouchDispatcher(void);
	void onResolveCCBCCMenuItemSelector(cocos2d::CCObject *, char const*);
	void goBuddyCpy(int);
	void ccTouchMoved(cocos2d::CCTouch *, cocos2d::CCEvent *);
	void ccTouchBegan(cocos2d::CCTouch	*, cocos2d::CCEvent *);
	void goNatrualTask(int);
	void ccTouchMoved(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void goAberance(int);
	void goBingo(int);
	void onEnter(void);
	void ccTouchMoved(cocos2d::CCTouch	*,cocos2d::CCEvent *);
	void goSynEq(int);
	void HelperUI(void);
	void onMenuItemCloseClicked(cocos2d::CCObject *);
	void ccTouchEnded(cocos2d::CCTouch	*, cocos2d::CCEvent *);
	void initSystemNews(void);
	void recvMenuClicked(int);
	void goPetMatch(int);
	void goPetBase(int);
	void goProtectIdol(int);
	void goSwalowPet(int);
	void goEliteCpy(int);
	void onAssignCCBMemberVariable(cocos2d::CCObject *,char const*,cocos2d::CCNode *);
	void goTicketActivity(int);
	void goLightStar(int);
	void ccTouchCancelled(cocos2d::CCTouch *,cocos2d::CCEvent *);
	void ccTouchCancelled(cocos2d::CCTouch *, cocos2d::CCEvent	*);
	void goDiceGame(int);
	void goPetArena(int);
	void goDt(int);
	void onMenuItemNextClicked(cocos2d::CCObject *);
	void onExit(void);
	void goWorldBoss(int);
	void goStrongEq(int);
	void init(void);
	void goFriendCopy(int);
	void ccTouchEnded(cocos2d::CCTouch *, cocos2d::CCEvent *);
}
#endif