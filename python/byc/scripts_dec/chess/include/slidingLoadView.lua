require("ui/scrollView");
SlidingLoadView = class(ScrollView,false);

function SlidingLoadView.ctor(self, x, y, w, h)
    ScrollView.ctor(self, x, y, w, h, true);
    self.mNoMoreData = false;
    self.mLoadIng    = false;
    self:setNoDataTip("没有更多数据了");
end

function SlidingLoadView.dtor(self)
    self:stopLoadAnim();
end

function SlidingLoadView.setOnLoad(self,obj,func)
    self.mOnLoadObj     = obj;
    self.mOnLoadFunc    = func;
end

function SlidingLoadView.loadEnd(self,isNoMoreData)
    self:stopLoadAnim();
    if isNoMoreData then
        if next(self:getChildren()) then
            self:noMoveData();
        else
            self.mNoMoreTip:setVisible(true); 
        end
    end
    self:updateScrollView();
end

function SlidingLoadView.reset(self)
    self:stopLoadAnim();
    self:removeAllChildren();
    self.mNoMoreData = false;
end

function SlidingLoadView.loadView(self)
    if self.mNoMoreData then return end
    self:startLoadAnim();
    if self.mOnLoadFunc then
        self.mOnLoadFunc(self.mOnLoadObj,self);
    end
end

function SlidingLoadView.setNoDataTip(self,str)
    delete(self.mNoMoreTip);
    local w,h = self:getSize();
    self.mNoMoreTip = new(RichText,str,w/3*2 , h, kAlignCenter, fontName, 30, 80, 80, 80, true,10);
    self.mNoMoreTip:setVisible(false);
    ScrollableNode.addChild(self,self.mNoMoreTip);
end

function SlidingLoadView.noMoveData(self)
    self.mNoMoreData = true;
    self:stopLoadAnim();
    local w,h = self:getSize();
    self.mNoMoreText = new(Text,"没有更多数据了", w, 100, kAlignCenter, fontName, 30, 80, 80, 80);
	self:addChild(self.mNoMoreText);
end

function SlidingLoadView.startLoadAnim(self)
    self:stopLoadAnim();
    self.mLoadAnim           = AnimFactory.createAnimInt(kAnimLoop, 0, 1, 500, -1);
    self.mLoadAnimIndex      = 0;
    self.mLoadIng            = true;
    self.mNoMoreTip:setVisible(false);
    self.mLoadAnim:setEvent(self,self.loadAnimEvent);
    local w,h = self:getSize();
    self.mLoadText = new(Text,"loading.  ", w, 100, kAlignCenter, fontName, 30, 80, 80, 80)
    self.mLoadText:setAlign(kAlignTop);
	self:addChild(self.mLoadText);
end

function SlidingLoadView.loadAnimEvent(self)
    self.mLoadText:setVisible(true);
    self.mLoadAnimIndex = (self.mLoadAnimIndex + 1)%3;
    if self.mLoadAnimIndex == 0 then 
        self.mLoadText:setText("loading.  ");
    elseif self.mLoadAnimIndex == 1 then 
        self.mLoadText:setText("loading.. ");
    else
        self.mLoadText:setText("loading...");
    end
end

function SlidingLoadView.stopLoadAnim(self)
    self.mLoadIng            = false;
    delete(self.mLoadAnim);
    delete(self.mLoadText);
	self:updateScrollView();
end

function SlidingLoadView.onScroll(self, scroll_status, diffY, totalOffset,isMarginRebounding)
	ScrollView.onScroll(self, scroll_status, diffY, totalOffset,isMarginRebounding);

    local frameLength = self:getFrameLength();  -- 显示区域
    local viewLength = self:getViewLength();    -- 总长度
    if not self.mNoMoreData and not self.mLoadIng and math.abs(totalOffset) >= viewLength - frameLength then
        self:loadView();
    end
end