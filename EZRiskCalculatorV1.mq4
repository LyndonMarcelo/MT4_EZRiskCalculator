
#define BID_LINE "BidLine"
#define ASK_LINE "AskLine"

#define LONG_BUTTON "LongBtn"
#define SHORT_BUTTON "ShortBtn"
#define CLEAR_BUTTON "ClearBtn"
#define ORDER_BUTTON "OrderBtn"

#define CAPITAL_INPUT "CapitalInput"
#define RISK_INPUT "RiskInput"
#define REWARD_INPUT "RewardInput"

double PipDiff;
double PPP;
double Units;
double TP;

double initialSL;
double priceSL;
double priceTP;

bool longOrShort;
bool clearLock = true;

int OnInit()
  {
  
   //LABELS
   ObjectCreate("Title", OBJ_LABEL,0,0,0);
   ObjectSetText("Title", "EZFXRiskCalculator",20,"Arial",Red);
   ObjectSetInteger(0,"Title", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"Title", OBJPROP_YDISTANCE, 30);
   
   ObjectCreate("CapitalLbl", OBJ_LABEL,0,0,0);
   ObjectSetText("CapitalLbl", "Capital:",12,"Arial",Red);
   ObjectSetInteger(0,"CapitalLbl", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"CapitalLbl", OBJPROP_YDISTANCE, 60);
   ObjectSetInteger(0,"CapitalLbl", OBJPROP_SELECTABLE, false);
   
   
   ObjectCreate("RiskLbl", OBJ_LABEL,0,0,0);
   ObjectSetText("RiskLbl", "Risk %:",12,"Arial",Red);
   ObjectSetInteger(0,"RiskLbl", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"RiskLbl", OBJPROP_YDISTANCE, 80);
   ObjectSetInteger(0,"RiskLbl", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("RewardLbl", OBJ_LABEL,0,0,0);
   ObjectSetText("RewardLbl", "Reward:",12,"Arial",Red);
   ObjectSetInteger(0,"RewardLbl", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"RewardLbl", OBJPROP_YDISTANCE, 100);
   ObjectSetInteger(0,"RewardLbl", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("LotSizeLbl", OBJ_LABEL,0,0,0);
   ObjectSetText("LotSizeLbl", "Lot Size:",12,"Arial",Red);
   ObjectSetInteger(0,"LotSizeLbl", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"LotSizeLbl", OBJPROP_YDISTANCE, 120);
   ObjectSetInteger(0,"LotSizeLbl", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("TPLbl", OBJ_LABEL,0,0,0);
   ObjectSetText("TPLbl", "TP Price:",12,"Arial",Red);
   ObjectSetInteger(0,"TPLbl", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"TPLbl", OBJPROP_YDISTANCE, 140);
   ObjectSetInteger(0,"TPLbl", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("SLLbl", OBJ_LABEL,0,0,0);
   ObjectSetText("SLLbl", "SL Price:",12,"Arial",Red);
   ObjectSetInteger(0,"SLLbl", OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,"SLLbl", OBJPROP_YDISTANCE, 160);
   ObjectSetInteger(0,"SLLbl", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("LotSizeVal", OBJ_LABEL,0,0,0);
   ObjectSetText("LotSizeVal", "0.00",12,"Arial",Green);
   ObjectSetInteger(0,"LotSizeVal", OBJPROP_XDISTANCE, 120);
   ObjectSetInteger(0,"LotSizeVal", OBJPROP_YDISTANCE, 120);
   ObjectSetInteger(0,"LotSizeVal", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("TPVal", OBJ_LABEL,0,0,0);
   ObjectSetText("TPVal", "0.00",12,"Arial",Green);
   ObjectSetInteger(0,"TPVal", OBJPROP_XDISTANCE, 120);
   ObjectSetInteger(0,"TPVal", OBJPROP_YDISTANCE, 140);
   ObjectSetInteger(0,"TPVal", OBJPROP_SELECTABLE, false);
   
   ObjectCreate("SLVal", OBJ_LABEL,0,0,0);
   ObjectSetText("SLVal", "0.00",12,"Arial",Green);
   ObjectSetInteger(0,"SLVal", OBJPROP_XDISTANCE, 120);
   ObjectSetInteger(0,"SLVal", OBJPROP_YDISTANCE, 160);
   ObjectSetInteger(0,"SLVal", OBJPROP_SELECTABLE, false);
   
   
   
   //INPUTBOXES
   ObjectCreate(CAPITAL_INPUT, OBJ_EDIT,0,0,0);
   ObjectSetInteger(0,CAPITAL_INPUT, OBJPROP_XDISTANCE, 110);
   ObjectSetInteger(0,CAPITAL_INPUT, OBJPROP_YDISTANCE, 60);
   ObjectSetInteger(0,CAPITAL_INPUT, OBJPROP_XSIZE, 150);
   ObjectSetText(CAPITAL_INPUT, "100");
   
   ObjectCreate(RISK_INPUT, OBJ_EDIT,0,0,0);
   ObjectSetInteger(0,RISK_INPUT, OBJPROP_XDISTANCE, 110);
   ObjectSetInteger(0,RISK_INPUT, OBJPROP_YDISTANCE, 80);
   ObjectSetInteger(0,RISK_INPUT, OBJPROP_XSIZE, 150);
   ObjectSetText(RISK_INPUT, "1");
   
   ObjectCreate(REWARD_INPUT, OBJ_EDIT,0,0,0);
   ObjectSetInteger(0,REWARD_INPUT, OBJPROP_XDISTANCE, 110);
   ObjectSetInteger(0,REWARD_INPUT, OBJPROP_YDISTANCE, 100);
   ObjectSetInteger(0,REWARD_INPUT, OBJPROP_XSIZE, 150);
   ObjectSetText(REWARD_INPUT, "2");
   
   
   
   
        
   //ObjectCreate("Bid", OBJ_LABEL,0,0,0);
   
   
   
   
   //HLINES        
     
   
   //BUTTONS
   ObjectCreate(LONG_BUTTON, OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,LONG_BUTTON, OBJPROP_XSIZE, 70);
   ObjectSetInteger(0,LONG_BUTTON, OBJPROP_YSIZE, 30);
   ObjectSetInteger(0,LONG_BUTTON, OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,LONG_BUTTON, OBJPROP_YDISTANCE, 190);
   ObjectSetString(0,LONG_BUTTON, OBJPROP_TEXT, "LONG");
   
   ObjectCreate(SHORT_BUTTON, OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,SHORT_BUTTON, OBJPROP_XSIZE, 70);
   ObjectSetInteger(0,SHORT_BUTTON, OBJPROP_YSIZE, 30);
   ObjectSetInteger(0,SHORT_BUTTON, OBJPROP_XDISTANCE, 125);
   ObjectSetInteger(0,SHORT_BUTTON, OBJPROP_YDISTANCE, 190);
   ObjectSetString(0,SHORT_BUTTON, OBJPROP_TEXT, "SHORT");
   
   ObjectCreate(CLEAR_BUTTON, OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,CLEAR_BUTTON, OBJPROP_XSIZE, 70);
   ObjectSetInteger(0,CLEAR_BUTTON, OBJPROP_YSIZE, 30);
   ObjectSetInteger(0,CLEAR_BUTTON, OBJPROP_XDISTANCE, 200);
   ObjectSetInteger(0,CLEAR_BUTTON, OBJPROP_YDISTANCE, 190);
   ObjectSetString(0,CLEAR_BUTTON, OBJPROP_TEXT, "CLEAR");
   
   ObjectCreate(ORDER_BUTTON, OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,ORDER_BUTTON, OBJPROP_XSIZE, 220);
   ObjectSetInteger(0,ORDER_BUTTON, OBJPROP_YSIZE, 30);
   ObjectSetInteger(0,ORDER_BUTTON, OBJPROP_XDISTANCE, 50);
   ObjectSetInteger(0,ORDER_BUTTON, OBJPROP_YDISTANCE, 230);
   ObjectSetString(0,ORDER_BUTTON, OBJPROP_TEXT, "PLACE ORDER");
   
   
   

   EventSetTimer(1);
   
   
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
  
   ObjectsDeleteAll();
   EventKillTimer(); 
  }

void OnTick()
  {
  
   //ObjectSet("Bid", OBJPROP_CORNER,CORNER_LEFT_UPPER);
   //ObjectSetText("Bid", "Bid Price: "+DoubleToStr(Bid,Digits),20,"Arial",Red);
   
     
   ObjectMove(BID_LINE, 0, Time[0], Bid);  
   ObjectMove(ASK_LINE, 0, Time[0], Ask);
   
   if(longOrShort == true)
   {
     ObjectMove("CandleTimer",0,Time[0],Ask);
     
     if(StringCompare(StringSubstr(Symbol(),3,3),AccountCurrency())==0)
      {    
         //Print("ungas");
         PipDiff = (ObjectGetDouble(0,ASK_LINE, OBJPROP_PRICE,0)-ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0))*pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
      
         if(PipDiff == 0)
           {
            PipDiff = 1;
           }
         
         PPP = (StrToDouble(ObjectGetString(0,CAPITAL_INPUT, OBJPROP_TEXT))*(0.01*StrToDouble(ObjectGetString(0,RISK_INPUT, OBJPROP_TEXT))))/PipDiff;
         
         //Print("Pip Diff: "+PipDiff);
         //Print("PPP: "+PPP);
         
         Units = PPP/((1/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1))/1);
         
         //Print(MarketInfo(Symbol(), MODE_ASK));
         //Print(Units);
         //Print("Account currency is ", AccountCurrency());
         //Print(StringSubstr(Symbol(),3,3));
         
         //=====================================
         
         TP = (ObjectGetDouble(0,ASK_LINE, OBJPROP_PRICE,0))+(StrToDouble(ObjectGetString(0,REWARD_INPUT,OBJPROP_TEXT))*PipDiff)/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
         //Print("TP: "+TP);
         
         ObjectSetText("LotSizeVal", DoubleToStr(Units/100000),12,"Arial",Green);
         ObjectSetText("TPVal", DoubleToStr(TP),12,"Arial",Green);
         ObjectSetText("SLVal", DoubleToStr(ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0)),12,"Arial",Green);
         
         
         ObjectMove("LineTP",0,Time[0],TP);          
      }
      
      else
      {
         //Print("not ungas");
         PipDiff = (ObjectGetDouble(0,ASK_LINE, OBJPROP_PRICE,0)-ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0))*pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
      
         if(PipDiff == 0)
           {
            PipDiff = 1;
           }
         
         PPP = (StrToDouble(ObjectGetString(0,CAPITAL_INPUT, OBJPROP_TEXT))*(0.01*StrToDouble(ObjectGetString(0,RISK_INPUT, OBJPROP_TEXT))))/PipDiff;
         
         //Print("Pip Diff: "+PipDiff);
         //Print("PPP: "+PPP);
         
         Units = PPP/((1/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1))/MarketInfo(Symbol(), MODE_ASK));
         
         //Print(MarketInfo(Symbol(), MODE_ASK));
         //Print(Units);
         //Print("Account currency is ", AccountCurrency());
         //Print(StringSubstr(Symbol(),3,3));
         
         //=====================================
         
         TP = (ObjectGetDouble(0,ASK_LINE, OBJPROP_PRICE,0))+(StrToDouble(ObjectGetString(0,REWARD_INPUT,OBJPROP_TEXT))*PipDiff)/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
         //Print("TP: "+TP);
         
         ObjectSetText("LotSizeVal", DoubleToStr(Units/100000),12,"Arial",Green);
         ObjectSetText("TPVal", DoubleToStr(TP),12,"Arial",Green);
         ObjectSetText("SLVal", DoubleToStr(ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0)),12,"Arial",Green);
         
         
         ObjectMove("LineTP",0,Time[0],TP);  
         
         
      }    
   }
   
   
   else if(longOrShort == false)
   {
     ObjectMove("CandleTimer",0,Time[0],Bid);
     
     if(StringCompare(StringSubstr(Symbol(),3,3),AccountCurrency())==0)
      {    
         //Print("ungas");
         PipDiff = -(ObjectGetDouble(0,BID_LINE, OBJPROP_PRICE,0)-ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0))*pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
      
         if(PipDiff == 0)
           {
            PipDiff = 1;
           }
         
         PPP = (StrToDouble(ObjectGetString(0,CAPITAL_INPUT, OBJPROP_TEXT))*(0.01*StrToDouble(ObjectGetString(0,RISK_INPUT, OBJPROP_TEXT))))/PipDiff;
         
         //Print("Pip Diff: "+PipDiff);
         //Print("PPP: "+PPP);
         
         Units = PPP/((1/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1))/1);
         
         //Print(MarketInfo(Symbol(), MODE_ASK));
         //Print(Units);
         //Print("Account currency is ", AccountCurrency());
         //Print(StringSubstr(Symbol(),3,3));
         
         //=====================================
         
         TP = (ObjectGetDouble(0,BID_LINE, OBJPROP_PRICE,0))-(StrToDouble(ObjectGetString(0,REWARD_INPUT,OBJPROP_TEXT))*PipDiff)/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
         //Print("TP: "+TP);
         
         ObjectSetText("LotSizeVal", DoubleToStr(Units/100000),12,"Arial",Green);
         ObjectSetText("TPVal", DoubleToStr(TP),12,"Arial",Green);
         ObjectSetText("SLVal", DoubleToStr(ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0)),12,"Arial",Green);
         
         
         ObjectMove("LineTP",0,Time[0],TP);          
      }
      
      else
      {
         //Print("not ungas");
         PipDiff = -(ObjectGetDouble(0,BID_LINE, OBJPROP_PRICE,0)-ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0))*pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
      
         if(PipDiff == 0)
           {
            PipDiff = 1;
           }
         
         PPP = (StrToDouble(ObjectGetString(0,CAPITAL_INPUT, OBJPROP_TEXT))*(0.01*StrToDouble(ObjectGetString(0,RISK_INPUT, OBJPROP_TEXT))))/PipDiff;
         
         //Print("Pip Diff: "+PipDiff);
         //Print("PPP: "+PPP);
         
         Units = PPP/((1/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1))/MarketInfo(Symbol(), MODE_ASK));
         
         //Print(MarketInfo(Symbol(), MODE_ASK));
         //Print(Units);
         //Print("Account currency is ", AccountCurrency());
         //Print(StringSubstr(Symbol(),3,3));
         
         //=====================================
         
         TP = (ObjectGetDouble(0,BID_LINE, OBJPROP_PRICE,0))-(StrToDouble(ObjectGetString(0,REWARD_INPUT,OBJPROP_TEXT))*PipDiff)/pow(10,MarketInfo(Symbol(), MODE_DIGITS)-1);
         //Print("TP: "+TP);
         
         ObjectSetText("LotSizeVal", DoubleToStr(Units/100000),12,"Arial",Green);
         ObjectSetText("TPVal", DoubleToStr(TP),12,"Arial",Green);
         ObjectSetText("SLVal", DoubleToStr(ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0)),12,"Arial",Green);
         
         
         ObjectMove("LineTP",0,Time[0],TP);  
         
         
      }    
   }
      
   
   

  }

void OnTimer()
  {
     int sec=60;
     int m=TimeSeconds(TimeCurrent());
     ObjectSetText("CandleTimer","         "+IntegerToString(sec-m),8,"Arial",Blue);
     
           
   
  }
  
void OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam)
  {
      if(sparam == LONG_BUTTON)
      {
         longOrShort = true;
         clearLock = false;
         ObjectSetInteger(0,LONG_BUTTON,OBJPROP_STATE,false);
         ObjectDelete(0, BID_LINE);
         ObjectDelete(0, "LineTP");
         ObjectDelete(0, "LineSL");
         
         ObjectCreate("CandleTimer",OBJ_TEXT,0,0,0);
         int sec=60;
         int m=TimeSeconds(TimeCurrent());
         ObjectSetText("CandleTimer","         "+IntegerToString(sec-m),8,"Arial",Blue);
         ObjectSetDouble(0,"CandleTimer",OBJPROP_ANGLE,0);
         ObjectMove("CandleTimer",0,Time[0],Ask);
         
         Print("Long Test");
         
         //Print(ObjectGetString(0,CAPITAL_INPUT, OBJPROP_TEXT)); 
         //Print(MarketInfo(Symbol(), MODE_SPREAD)); 
         //Print(MarketInfo(Symbol(), MODE_DIGITS));
         
         
              
         initialSL = ((3*MarketInfo(Symbol(), MODE_SPREAD))/pow(10,MarketInfo(Symbol(), MODE_DIGITS)));
         //Print(initialSL);
         
         priceSL = Ask-initialSL;
         //Print(priceSL);
         
         ObjectCreate("LineSL", OBJ_HLINE, 0, Time[0], priceSL);
         
         priceTP = Ask+(initialSL*StrToDouble(ObjectGetString(0,REWARD_INPUT,OBJPROP_TEXT)));
         //Print(priceTP);
         
         ObjectCreate("LineTP", OBJ_HLINE, 0, Time[0], priceTP);
         ObjectSet("LineTP", OBJPROP_COLOR, Green);
              
                           
         
         ObjectCreate(ASK_LINE, OBJ_HLINE, 0, Time[0], Ask);
         ObjectSet(ASK_LINE, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet(ASK_LINE, OBJPROP_COLOR, Blue);
         ObjectSet(ASK_LINE, OBJPROP_WIDTH, 0);
         
         
                        
       
      } 
      
      if(sparam == SHORT_BUTTON)
      {
         longOrShort = false;
         clearLock = false;
         ObjectSetInteger(0,SHORT_BUTTON,OBJPROP_STATE,false);
         ObjectDelete(0, ASK_LINE);
         ObjectDelete(0, "LineTP");
         ObjectDelete(0, "LineSL");
         
         ObjectCreate("CandleTimer",OBJ_TEXT,0,0,0);
         sec=60;
         m=TimeSeconds(TimeCurrent());
         ObjectSetText("CandleTimer","         "+IntegerToString(sec-m),8,"Arial",Blue);
         ObjectSetDouble(0,"CandleTimer",OBJPROP_ANGLE,0);
         ObjectMove("CandleTimer",0,Time[0],Bid);
         
         Print("Short Test");
         
         
         initialSL = ((3*MarketInfo(Symbol(), MODE_SPREAD))/pow(10,MarketInfo(Symbol(), MODE_DIGITS)));
         //Print(initialSL);
         
         priceSL = Bid+initialSL;
         //Print(priceSL);
         
         ObjectCreate("LineSL", OBJ_HLINE, 0, Time[0], priceSL);
         
         priceTP = Bid-(initialSL*StrToDouble(ObjectGetString(0,REWARD_INPUT,OBJPROP_TEXT)));
         //Print(priceTP);
         
         ObjectCreate("LineTP", OBJ_HLINE, 0, Time[0], priceTP);
         ObjectSet("LineTP", OBJPROP_COLOR, Green);

    
         ObjectCreate(BID_LINE, OBJ_HLINE, 0, Time[0], Bid);
         ObjectSet(BID_LINE, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet(BID_LINE, OBJPROP_COLOR, Blue);
         ObjectSet(BID_LINE, OBJPROP_WIDTH, 0);
               
       
      }
      
      if(sparam == CLEAR_BUTTON)
      {
         clearLock = true;
         ObjectDelete(0, ASK_LINE);
         ObjectDelete(0, BID_LINE);
         ObjectDelete(0, "LineTP");
         ObjectDelete(0, "LineSL");
         ObjectDelete(0, "CandleTimer");
         ObjectSetInteger(0,CLEAR_BUTTON,OBJPROP_STATE,false);
      }
      
      if(sparam == ORDER_BUTTON)
      {
         //Print("Order Here");
         int ticket;
         
         if(longOrShort == true && clearLock == false)
         {
            ticket=OrderSend(Symbol(),OP_BUY,NormalizeDouble((Units/100000),Digits),Ask,5,NormalizeDouble(ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0),Digits),NormalizeDouble(TP,Digits),"My order",16384,0,clrGreen);
         
            if(ticket<0)
            {
               Print("OrderSend failed with error #",GetLastError());
            }
            else
            {
               Print("OrderSend placed successfully");
            }
            
            ObjectSetInteger(0,ORDER_BUTTON,OBJPROP_STATE,false);
         }
         
         else if(longOrShort == false && clearLock == false)
         {
            ticket=OrderSend(Symbol(),OP_SELL,NormalizeDouble((Units/100000),Digits),Ask,5,NormalizeDouble(ObjectGetDouble(0,"LineSL", OBJPROP_PRICE,0),Digits),NormalizeDouble(TP,Digits),"My order",16384,0,clrGreen);
         
            if(ticket<0)
            {
               Print("OrderSend failed with error #",GetLastError());
            }
            else
            {
               Print("OrderSend placed successfully");
            }
            
            ObjectSetInteger(0,ORDER_BUTTON,OBJPROP_STATE,false);
                 
         }
         
         
      }
      
   
  }
