require "zoo.util.IosPaymentCallback"
require 'zoo.gameGuide.IosPayGuide'
require "zoo.payment.PaymentEventDispatcher"
require "zoo.payment.paymentDC.PaymentIosDCUtil"
require "zoo.payment.paymentDC.DCIosRmbObject"

IosPayment = {}

local instance = nil

function IosPayment:getInstance()
	if not instance then
		instance = ShowPayment:instance();
	end
	return instance;
end

function IosPayment:showPayment(filterSkuIds, getFunc, errorFunc)
	local callback = IosPaymentCallback:init_getFunc_completeFunc_errorFunc(getFunc, nil, errorFunc)
	return IosPayment:getInstance():showPayment_callback(filterSkuIds, callback)
end

function IosPayment:buy(productId, price, currency, extend, completeFunc, errorFunc, dcEventDispatcher)
	local function complete( ... )
		if dcEventDispatcher then 
			dcEventDispatcher:dispatchIosBuySuccess()
		end
		UserManager:getInstance():getUserExtendRef().payUser = true
		UserService:getInstance():getUserExtendRef().payUser = true
		UserManager:getInstance():getUserExtendRef():setLastPayTime(Localhost:time())
		UserService:getInstance():getUserExtendRef():setLastPayTime(Localhost:time())
		completeFunc( ... )
	end
	local function error( ... )
		if dcEventDispatcher then 
			dcEventDispatcher:dispatchIosBuyFailed()
		end
		if IosPayGuide:tryPopFailGuidePanel(errorFunc) then
			return 
		else
			errorFunc( ... )
		end
	end

	local callback = IosPaymentCallback:init_getFunc_completeFunc_errorFunc(nil, complete, error)
	return IosPayment:getInstance():buy_price_currency_extend_callback(productId, price, currency, extend, callback)
end

local function playGoldAnimation(cash, isIAPCode)
	local props = Localization:getInstance():getText("consume.history.panel.gold.text",{n=scash})
	local goldTip = ConsumeTipPanel:create(props)

	local key = 'game.iap.code.addedCash';
	if not isIAPCode then
		key = 'game.last.restored.payment';
	end
	local str = Localization:getInstance():getText(key, {addedCash = cash, n="\n"});
	goldTip:setText(str)
	goldTip:popout()
end

--userinfo is the productId;
--if errorInfo is nil, then the payment is from outside, or else it is from the restored trasaction.
local function outsidePayComplete(orderId, errorInfo, userInfo)
		print("outsidePayComplete callback!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		IosPayment:getInstance().orderId = orderId
		IosPayment:getInstance().errorInfo = errorInfo
		IosPayment:getInstance().userInfo = userInfo
		IosPayment:getInstance().needDisplay = true
		
end

local function outsidePayError(errorInfo)

end

function IosPayment:testAddGold()
	outsidePayComplete(nil, nil, "com.happyelements.animal.gold.cn.1");
end

local outsidePayCallback = IosPaymentCallback:init_getFunc_completeFunc_errorFunc(nil, outsidePayComplete, outsidePayError);
function IosPayment:registerCallback()
	IosPayment:getInstance():registerCallback(outsidePayCallback);
	print("ios payment callback registered!");
end

--only for display
function IosPayment:showOutSideComplete( ... )
	-- body
	-- IosPayment:testAddGold()
	local payment = IosPayment:getInstance()
	if payment and payment.needDisplay then
		orderId = payment.orderId 
		errorInfo = payment.errorInfo
		userInfo = payment.userInfo
		payment.needDisplay = nil
		local buyLogic = BuyGoldLogic:create()
		local productMeta = buyLogic:getMeta();
		
		for i,v in ipairs(productMeta) do
			if v.productId == userInfo then
				local user = UserManager:getInstance().user
				local serv = UserService:getInstance().user
				local oldCash = user:getCash()
				local newCash = oldCash + v.cash
				user:setCash(newCash);
				serv:setCash(newCash);

				print("cash added!!!!!!!!!!!!!!!!!!!!");
				if errorInfo then
					playGoldAnimation(v.cash, false);
					--todo: show tips for the restored trasaction;
				else
					playGoldAnimation(v.cash, true);
					--todo: show tips for the outsidepayment transaction;
				end

				return;
			end
		end
	end
end