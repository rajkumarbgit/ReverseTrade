


#include <Trade\Trade.mqh>
#include <Trade\DealInfo.mqh>
CTrade trade;
CPositionInfo posinfo;
COrderInfo ordinfo;
CDealInfo m_deal;
int OnInit()
  {
   trade.Buy(0.1,_Symbol);
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {

   
  }

void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
   ENUM_TRADE_TRANSACTION_TYPE type=trans.type;
   if(type==TRADE_TRANSACTION_DEAL_ADD)
     {
      if(HistoryDealSelect(trans.deal))
         m_deal.Ticket(trans.deal);
      else
        {
         Print(__FILE__," ",__FUNCTION__,", ERROR: HistoryDealSelect(",trans.deal,")");
         return;
        }
      //---
      long reason=-1;
      if(!m_deal.InfoInteger(DEAL_REASON,reason))
        {
         Print(__FILE__," ",__FUNCTION__,", ERROR: InfoInteger(DEAL_REASON,reason)");
         return;
        }
    

      if((ENUM_DEAL_REASON)reason==DEAL_REASON_SL || (ENUM_DEAL_REASON)reason==DEAL_REASON_CLIENT || (ENUM_DEAL_REASON)reason==DEAL_REASON_MOBILE || (ENUM_DEAL_REASON)reason==DEAL_REASON_WEB){
         if(m_deal.Profit()<0)
           {
            if(trans.deal_type==DEAL_TYPE_BUY)
              {
               trade.SetExpertMagicNumber(m_deal.Magic());

               trade.Sell(trans.volume, m_deal.Symbol());
              }
             if(trans.deal_type==DEAL_TYPE_SELL)
              {
               trade.SetExpertMagicNumber(m_deal.Magic());
               trade.Buy(trans.volume, m_deal.Symbol());
              }
           }

        }

     }

   
  }

