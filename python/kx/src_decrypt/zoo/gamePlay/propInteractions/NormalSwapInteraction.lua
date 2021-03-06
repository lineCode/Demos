require 'zoo.gamePlay.propInteractions.BaseInteraction'
require 'zoo.itemView.PropsView'

NormalSwapInteraction = class(BaseInteraction)
function NormalSwapInteraction:ctor()
    self.item1Pos = nil
    self.item2Pos = nil
    self.firstWaitingState = BaseInteractionState.new('firstWaitingState')
    self.firstTouchedState = BaseInteractionState.new('firstTouchedState')
    self.secondWaitingState = BaseInteractionState.new('secondWaitingState')
    self.secondTouchedState = BaseInteractionState.new('secondTouchedState')

    self.effectState = BaseInteractionState.new("effectState")
    self:setCurrentState(self.firstWaitingState) -- init
end

function NormalSwapInteraction:handleTouchBegin(x, y)

    local touchPos = self.boardView:TouchAt(x, y)
    if not touchPos then return end

    GameExtandPlayLogic:onItemTouchBegin( self.boardView.gameBoardLogic , touchPos.x , touchPos.y )

    if (self.currentState == self.firstWaitingState or 
         self.currentState == self.secondWaitingState ) and 
        self.boardView.gameBoardLogic:isCanEffectLikeProp(touchPos.x, touchPos.y) then
        self.item1Pos = touchPos
        self:setCurrentState(self.effectState)
        return
    end

    if not self.boardView.gameBoardLogic:isItemInTile(touchPos.x, touchPos.y) then
        return
    end

    if not self.boardView.gameBoardLogic:isItemCanMoved(touchPos.x, touchPos.y) then
        return
    end

    if self.currentState == self.firstWaitingState then
        self.item1Pos = touchPos
        self:setCurrentState(self.firstTouchedState)
        self.boardView:focusOnItem(touchPos)
    elseif self.currentState == self.secondWaitingState then
        if not BaseInteraction.isEqualPos(touchPos, self.item1Pos) then -- 点击不同一个格子
            -- 可以交换
            if 0 < self.boardView.gameBoardLogic:canBeSwaped(self.item1Pos.x, self.item1Pos.y, touchPos.x, touchPos.y) then
                self.item2Pos = touchPos
                self:setCurrentState(self.secondTouchedState)
                self:handleComplete()
            else -- 不能交换
                self.item1Pos = touchPos
                self:setCurrentState(self.firstTouchedState)
                self.boardView:focusOnItem(touchPos)
            end
        else
            self.item1Pos = touchPos
            self:setCurrentState(self.firstTouchedState)
            self.boardView:focusOnItem(touchPos)
        end
    else 
        -- error
        assert(false, 'NormalSwapInteraction state error')
    end
end


-- 用于普通交换 & 强制交换
function NormalSwapInteraction:handleTouchMove(x, y)
    local touchPos = self.boardView:TouchAt(x, y)
    if not touchPos then 
        return  
    end

    if not self.item1Pos then
        return 
    end

    if self.currentState == self.effectState then
        return
    end

    -- 不是棋盘上
    if not self.boardView.gameBoardLogic:isItemInTile(touchPos.x, touchPos.y) then
        return
    end

     -- 仍在同一个格子内
    if BaseInteraction.isEqualPos(touchPos, self.item1Pos) then
        return 
    end

    if self.currentState == self.firstTouchedState then
    
        if 0 < self.boardView.gameBoardLogic:canBeSwaped(self.item1Pos.x, self.item1Pos.y, touchPos.x, touchPos.y) then
            self.item2Pos = touchPos
            self:handleComplete()
        end
    end
end

function NormalSwapInteraction:handleTouchEnd(x, y)
    local touchPos = self.boardView:TouchAt(x, y)
    if not touchPos then 
        return  
    end

    if self.currentState == self.firstTouchedState then
        if BaseInteraction.isEqualPos(self.item1Pos, touchPos) then
            self.item1Pos = touchPos
            print(touchPos.x, touchPos.y)
        end
        self:setCurrentState(self.secondWaitingState)
    elseif self.currentState == self.effectState then
        self.item2Pos = touchPos
        if BaseInteraction.isEqualPos(self.item1Pos, touchPos) then -- 只能在原位置，否则视为取消，重新进入等待状态
            local gameItemMap = self.boardView.gameBoardLogic.gameItemMap
            if gameItemMap and gameItemMap[touchPos.y] and gameItemMap[touchPos.y][touchPos.x] then
                local item = gameItemMap[touchPos.x][touchPos.y]
                if item.hedgehogLevel > 1 then
                    self.controller.boardView.gamePropsType = GamePropsType.kHedgehogCrazy
                elseif item.wukongState == TileWukongState.kReadyToJump then
                   self.controller.boardView.gamePropsType = GamePropsType.kWukongJump
                end
            end
            self:handleComplete()
        else
            self.item1Pos = nil
            self.item2Pos = nil
            self:setCurrentState(self.firstWaitingState)
        end
    end
end

function NormalSwapInteraction:onEnter()
    print('>>> enter NormalSwapInteraction')
    self.item1Pos = nil
    self.item2Pos = nil
    self:setCurrentState(self.firstWaitingState)
end

function NormalSwapInteraction:onExit()
    print('--- exit  NormalSwapInteraction')
end

function NormalSwapInteraction:handleComplete()
    if self.controller then
        self.controller:onInteractionComplete({item1Pos = self.item1Pos, item2Pos = self.item2Pos})
    end
    self:onEnter()
end