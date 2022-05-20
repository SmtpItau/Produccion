using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Xml.Linq;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Pricing.Swap
{

    public class PricingSwap : InterfaceQuery
    {

        public DataTable Save(string toXML)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTID;
            XDocument _ToXML = XDocument.Parse(toXML);
            XElement _xmlItem;
            string _Head;
            string _Leg;
            string _Flow;
            string _Insert;
            DateTime _EntryDate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Connect();
            _Connect.QueryType = enumQueryType.CustomerLoad;

            _Head = "INSERT INTO dbo.PricingSwap ( id, entrydate, pricingdate, currencyprimary, rateprimary, amountprimary, parityprimary, " +
                    "exchangerateprimary, marktomarketprimaryum, marktomarketprimaryclp, currencysecondary, ratesecondary, amountsecundary, " +
                    "paritysecundary, exchangeratesecundary, marktomarketsecundaryum, marktomarketsecundaryclp, parity, payment, " +
                    "marktomarketnet, bpv, marktomarketdistributionnet, exchangenotionalstarting, exchangenotionalintermediate, " +
                    "exchangenotionalend, setpricing, comment, usercreator, status ) " +
                    "VALUES ( @DataID, '{0}', '{1}', {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11}, {12}, {13}, {14}, {15}, {16}, {17}, " +
                    "{18}, {19}, {20}, '{21}', '{22}', '{23}', {24}, '{25}', {26}, '{27}' )\n\n";

            _Leg = "INSERT INTO dbo.PricingSwapLeg ( id, dataid, legid, currencyid, amount, parity, exchangerate, startingdate, expirydate, " +
                   "convention, rateid, factor, rate, spread, developmenttable, intervaletype, BrokenPeriod, paymentcurrency, marktomarketum, " +
                   "marktomarketclp, spreaddistribution, marktomarketdistributionum, marktomarketdistributionclp, BackwardnessStartNumber, " +
                   "BackwardnessStartType, intervalcalendarsantiago, intervalcalendarnewyork, intervalcalendarlondres, paymentnumber,  " +
                   "paymenttype, paymentdate, paymentcalendarsantiago, paymentcalendarnewyork, paymentcalendarlondres, fixingnumber, fixingtype, " +
                   "fixingdate, fixingcalendarsantiago, fixingcalendarnewyork, fixingcalendarlondres, conventioncalendar, yieldproject, " +
                   "yielddiscount, termbenchmark, resetday ) " +
                   "VALUES ( {0}, @DataID, {1}, {2}, {3}, {4}, {5}, '{6}', '{7}', {8}, {9}, {10}, {11}, {12}, {13}, {14}, {15}, {16}, {17}, {18}, {19}, " +
                   "{20}, {21}, {22}, {23}, '{24}', '{25}', '{26}', {27}, {28}, {29}, '{30}', '{31}', '{32}', {33}, {34}, {35}, '{36}', '{37}', '{38}', " +
                   "{39}, '{40}', '{41}', {42}, {43} )\n\n";

            _Flow = "INSERT INTO dbo.PricingSwapFlow ( id, dataid, legid, flowid, fixingdate, startingdate, expirydate, paymentdate, balance, " +
                    "exchangeprincipal, postpounding, rate, spread, amortizationflow, interestflow, aditionalflow, totalflow, ratediscount, " +
                    "wellfactor, amortizationpresentvalue, interestpresentvalue, aditionalflowpresentvalue, presentvalue ) " +
                    "VALUES ( @ID, @DataID, {0}, {1}, '{2}', '{3}', '{4}', '{5}', {6}, '{7}', '{8}', {9}, {10}, {11}, {12}, {13}, {14}, {15}, " +
                    "{16}, {17}, {18}, {19}, {20} )\n";

            #endregion

            #region "Query"

            _Insert = "SET NOCOUNT ON\n\n";
            _Insert += "DECLARE @DataID             NUMERIC(18)\n";
            _Insert += "DECLARE @LegAssetID         NUMERIC(18)\n";
            _Insert += "DECLARE @LegLiabilitiesID   NUMERIC(18)\n";
            _Insert += "DECLARE @ID                 NUMERIC(18)\n";
            _Insert += "DECLARE @ExcxhangeRate      NUMERIC(18)\n\n";

            #region "Head"

            _xmlItem = (XElement)_ToXML.Element("SaveData").Element("Head");
            _EntryDate = DateTime.Parse(_xmlItem.Attribute("EntryDate").Value.ToString());

            if (int.Parse(_xmlItem.Attribute("ID").Value).Equals(0))
            {

                _Insert += string.Format(
                                          "SELECT @DataID = ISNULL( MAX(id), {0} ) + 1 FROM dbo.PricingSwap\n",
                                          double.Parse(_EntryDate.ToString("yyyyMMdd")) * Math.Pow(10, 6)
                                        );
            }
            else
            {

                _Insert += string.Format("SELECT @DataID = {0}\n\n", _xmlItem.Attribute("ID").Value.ToString());
                _Insert += "DELETE dbo.PricingSwap     WHERE id     = @DataID\n";
                _Insert += "DELETE dbo.PricingSwapLeg  WHERE dataid = @DataID\n";
                _Insert += "DELETE dbo.PricingSwapFlow WHERE dataid = @DataID\n\n";

            }

            _Insert += string.Format(
                                      _Head,
                                      _xmlItem.Attribute("EntryDate").Value,                    //  0 entrydate
                                      _xmlItem.Attribute("PricingDate").Value,                  //  1 pricingdate
                                      _xmlItem.Attribute("CurrencyPrimary").Value,              //  2 currencyprimary
                                      _xmlItem.Attribute("RatePrimary").Value,                  //  3 rateprimary
                                      _xmlItem.Attribute("AmountPrimary").Value,                //  4 amountprimary
                                      _xmlItem.Attribute("ParityPrimary").Value,                //  5 parityprimary
                                      _xmlItem.Attribute("ExchangeRatePrimary").Value,          //  6 exchangerateprimary
                                      _xmlItem.Attribute("MarkToMarketPrimaryUM").Value,        //  7 marktomarketprimaryum
                                      _xmlItem.Attribute("MarkToMarketPrimaryCLP").Value,       //  8 marktomarketprimaryclp
                                      _xmlItem.Attribute("CurrencySecondary").Value,            //  9 currencysecondary
                                      _xmlItem.Attribute("RateSecondary").Value,                // 10 ratesecondary
                                      _xmlItem.Attribute("AmountSecundary").Value,              // 11 amountsecundary
                                      _xmlItem.Attribute("ParitySecundary").Value,              // 12 paritysecundary
                                      _xmlItem.Attribute("ExchangeRateSecundary").Value,        // 13 exchangeratesecundary
                                      _xmlItem.Attribute("MarkToMarketSecundaryUM").Value,      // 14 marktomarketsecundaryum
                                      _xmlItem.Attribute("MarkToMarketSecundaryCLP").Value,     // 15 marktomarketsecundaryclp
                                      _xmlItem.Attribute("Parity").Value,                       // 16 parity
                                      _xmlItem.Attribute("Payment").Value,                      // 17 payment
                                      _xmlItem.Attribute("MarkToMarketNet").Value,              // 18 marktomarketnet
                                      _xmlItem.Attribute("BPV").Value,                          // 19 BPV
                                      _xmlItem.Attribute("MarkToMarketDistributionNet").Value,  // 20 marktomarketdistributionnet
                                      _xmlItem.Attribute("ExchangeNotionalStarting").Value,     // 21 exchangenotionalstarting
                                      _xmlItem.Attribute("ExchangeNotionalIntermediate").Value, // 22 exchangenotionalintermediate
                                      _xmlItem.Attribute("ExchangeNotionalEnd").Value,          // 23 exchangenotionalend
                                      _xmlItem.Attribute("SetPricing").Value,                   // 24 setpricing
                                      _xmlItem.Attribute("Comment").Value,                      // 25 comment
                                      _xmlItem.Attribute("UserCreator").Value,                  // 26 usercreator
                                      _xmlItem.Attribute("Status").Value                        // 27 status
                                    );

            #endregion

            #region "Leg Asset"

            _xmlItem = (XElement)_ToXML.Element("SaveData").Element("Asset");

            if (int.Parse(_xmlItem.Attribute("ID").Value).Equals(0))
            {

                _Insert += string.Format(
                                          "SELECT @LegAssetID = ISNULL( MAX(id), {0} ) + 1 FROM dbo.PricingSwapLeg\n",
                                          double.Parse(_EntryDate.ToString("yyyyMMdd")) * Math.Pow(10, 6)
                                        );
            }
            else
            {

                _Insert += string.Format("SELECT @LegAssetID = {0}\n\n", _xmlItem.Attribute("LegID").Value.ToString());

            }

            _Insert += string.Format(
                                      _Leg, 
                                      "@LegAssetID",                                            //  0 id
                                      _xmlItem.Attribute("LegID").Value,                        //  1 legid
                                      _xmlItem.Attribute("CurrencyID").Value,                   //  2 currencyid
                                      _xmlItem.Attribute("Amount").Value,                       //  3 amount
                                      _xmlItem.Attribute("Parity").Value,                       //  4 parity
                                      _xmlItem.Attribute("ExchangeRate").Value,                 //  5 exchangerate
                                      _xmlItem.Attribute("StartingDate").Value,                 //  6 startingdate
                                      _xmlItem.Attribute("ExpiryDate").Value,                   //  7 expirydate
                                      _xmlItem.Attribute("Convention").Value,                   //  8 convention
                                      _xmlItem.Attribute("RateID").Value,                       //  9 rateid
                                      _xmlItem.Attribute("Factor").Value,                       // 10 factor
                                      _xmlItem.Attribute("Rate").Value,                         // 11 rate
                                      _xmlItem.Attribute("Spread").Value,                       // 12 spread
                                      _xmlItem.Attribute("DevelopmentTable").Value,             // 13 developmenttable
                                      _xmlItem.Attribute("IntervaleType").Value,                // 14 intervaletype
                                      _xmlItem.Attribute("BrokenPeriod").Value,                 // 15 BrokenPeriod
                                      _xmlItem.Attribute("PaymentCurrency").Value,              // 16 paymentcurrency
                                      _xmlItem.Attribute("MarkToMarketUM").Value,               // 17 marktomarketum
                                      _xmlItem.Attribute("MarkToMarketCLP").Value,              // 18 marktomarketclp
                                      _xmlItem.Attribute("SpreadDistribution").Value,           // 19 spreaddistribution
                                      _xmlItem.Attribute("MarkToMarketDistributionUM").Value,   // 20 marktomarketdistributionum
                                      _xmlItem.Attribute("MarkToMarketDistributionCLP").Value,  // 21 marktomarketdistributionclp
                                      _xmlItem.Attribute("BackwardnessStartNumber").Value,      // 22 BackwardnessStartNumber
                                      _xmlItem.Attribute("BackwardnessStartType").Value,        // 23 BackwardnessStartType
                                      _xmlItem.Attribute("IntervalCalendarSantiago").Value,     // 24 intervalcalendarsantiago
                                      _xmlItem.Attribute("IntervalCalendarNewYork").Value,      // 25 intervalcalendarnewyork
                                      _xmlItem.Attribute("IntervalCalendarLondres").Value,      // 26 intervalcalendarlondres
                                      _xmlItem.Attribute("PaymentNumber").Value,                // 27 paymentnumber
                                      _xmlItem.Attribute("PaymentType").Value,                  // 28 paymenttype
                                      _xmlItem.Attribute("PaymentDate").Value,                  // 29 paymentdate
                                      _xmlItem.Attribute("PaymentCalendarSantiago").Value,      // 30 paymentcalendarsantiago
                                      _xmlItem.Attribute("PaymentCalendarNewYork").Value,       // 31 paymentcalendarnewyork
                                      _xmlItem.Attribute("PaymentCalendarLondres").Value,       // 32 paymentcalendarlondres
                                      _xmlItem.Attribute("FixingNumber").Value,                 // 33 fixingnumber
                                      _xmlItem.Attribute("FixingType").Value,                   // 34 fixingtype
                                      _xmlItem.Attribute("FixingDate").Value,                   // 35 fixingdate
                                      _xmlItem.Attribute("FixingCalendarSantiago").Value,       // 36 fixingcalendarsantiago
                                      _xmlItem.Attribute("FixingCalendarNewYork").Value,        // 37 fixingcalendarnewyork
                                      _xmlItem.Attribute("FixingCalendarLondres").Value,        // 38 fixingcalendarlondres
                                      _xmlItem.Attribute("ConventionCalendar").Value,           // 39 conventioncalendar
                                      _xmlItem.Attribute("YieldProject").Value,                 // 40 yieldproject
                                      _xmlItem.Attribute("YieldDiscount").Value,                // 41 yielddiscount
                                      _xmlItem.Attribute("TermBenchMark").Value,                // 42 termbenchmark
                                      _xmlItem.Attribute("ResetDay").Value                      // 43 resetday
                                    );

            #endregion

            #region "Leg Liabilities"

            _xmlItem = (XElement)_ToXML.Element("SaveData").Element("Liabilitie");

            if (int.Parse(_xmlItem.Attribute("ID").Value).Equals(0))
            {

                _Insert += string.Format(
                                          "SELECT @LegLiabilitiesID = ISNULL( MAX(id), {0} ) + 1 FROM dbo.PricingSwapLeg\n",
                                          double.Parse(_EntryDate.ToString("yyyyMMdd")) * Math.Pow(10, 6)
                                        );
            }
            else
            {

                _Insert += string.Format("SELECT @LegLiabilitiesID = {0}\n\n", _xmlItem.Attribute("LegID").Value.ToString());

            }

            _Insert += string.Format(
                                      _Leg,
                                      "@LegLiabilitiesID",                                      //  0 id
                                      _xmlItem.Attribute("LegID").Value,                        //  1 legid
                                      _xmlItem.Attribute("CurrencyID").Value,                   //  2 currencyid
                                      _xmlItem.Attribute("Amount").Value,                       //  3 amount
                                      _xmlItem.Attribute("Parity").Value,                       //  4 parity
                                      _xmlItem.Attribute("ExchangeRate").Value,                 //  5 exchangerate
                                      _xmlItem.Attribute("StartingDate").Value,                 //  6 startingdate
                                      _xmlItem.Attribute("ExpiryDate").Value,                   //  7 expirydate
                                      _xmlItem.Attribute("Convention").Value,                   //  8 convention
                                      _xmlItem.Attribute("RateID").Value,                       //  9 rateid
                                      _xmlItem.Attribute("Factor").Value,                       // 10 factor
                                      _xmlItem.Attribute("Rate").Value,                         // 11 rate
                                      _xmlItem.Attribute("Spread").Value,                       // 12 spread
                                      _xmlItem.Attribute("DevelopmentTable").Value,             // 13 developmenttable
                                      _xmlItem.Attribute("IntervaleType").Value,                // 14 intervaletype
                                      _xmlItem.Attribute("BrokenPeriod").Value,                 // 15 BrokenPeriod
                                      _xmlItem.Attribute("PaymentCurrency").Value,              // 16 paymentcurrency
                                      _xmlItem.Attribute("MarkToMarketUM").Value,               // 17 marktomarketum
                                      _xmlItem.Attribute("MarkToMarketCLP").Value,              // 18 marktomarketclp
                                      _xmlItem.Attribute("SpreadDistribution").Value,           // 19 spreaddistribution
                                      _xmlItem.Attribute("MarkToMarketDistributionUM").Value,   // 20 marktomarketdistributionum
                                      _xmlItem.Attribute("MarkToMarketDistributionCLP").Value,  // 21 marktomarketdistributionclp
                                      _xmlItem.Attribute("BackwardnessStartNumber").Value,      // 22 BackwardnessStartNumber
                                      _xmlItem.Attribute("BackwardnessStartType").Value,        // 23 BackwardnessStartType
                                      _xmlItem.Attribute("IntervalCalendarSantiago").Value,     // 24 intervalcalendarsantiago
                                      _xmlItem.Attribute("IntervalCalendarNewYork").Value,      // 25 intervalcalendarnewyork
                                      _xmlItem.Attribute("IntervalCalendarLondres").Value,      // 26 intervalcalendarlondres
                                      _xmlItem.Attribute("PaymentNumber").Value,                // 27 paymentnumber
                                      _xmlItem.Attribute("PaymentType").Value,                  // 28 paymenttype
                                      _xmlItem.Attribute("PaymentDate").Value,                  // 29 paymentdate
                                      _xmlItem.Attribute("PaymentCalendarSantiago").Value,      // 30 paymentcalendarsantiago
                                      _xmlItem.Attribute("PaymentCalendarNewYork").Value,       // 31 paymentcalendarnewyork
                                      _xmlItem.Attribute("PaymentCalendarLondres").Value,       // 32 paymentcalendarlondres
                                      _xmlItem.Attribute("FixingNumber").Value,                 // 33 fixingnumber
                                      _xmlItem.Attribute("FixingType").Value,                   // 34 fixingtype
                                      _xmlItem.Attribute("FixingDate").Value,                   // 35 fixingdate
                                      _xmlItem.Attribute("FixingCalendarSantiago").Value,       // 36 fixingcalendarsantiago
                                      _xmlItem.Attribute("FixingCalendarNewYork").Value,        // 37 fixingcalendarnewyork
                                      _xmlItem.Attribute("FixingCalendarLondres").Value,        // 38 fixingcalendarlondres
                                      _xmlItem.Attribute("ConventionCalendar").Value,           // 39 conventioncalendar
                                      _xmlItem.Attribute("YieldProject").Value,                 // 40 yieldproject
                                      _xmlItem.Attribute("YieldDiscount").Value,                // 41 yielddiscount
                                      _xmlItem.Attribute("TermBenchMark").Value,                // 42 termbenchmark
                                      _xmlItem.Attribute("ResetDay").Value                      // 43 resetday
                                   );

            #endregion

            #region "Flow Asset"

            _xmlItem = (XElement)_ToXML.Element("SaveData").Element("FlowsAssets");

            _xmlItem = (XElement)_xmlItem.FirstNode;

            while (!(_xmlItem == null))
            {

                _Insert += string.Format(
                                          "SELECT @ID = ISNULL( MAX(id), {0} ) + 1 FROM dbo.PricingSwapFlow\n",
                                          double.Parse(_EntryDate.ToString("yyyyMMdd")) * Math.Pow(10, 6) + 1.0 * Math.Pow(10, 5)
                                        );

                _Insert += string.Format(
                                          _Flow,
                                          "@LegAssetID",                                        //  0 legid
                                          _xmlItem.Attribute("FlowID").Value,                   //  1 flowid
                                          _xmlItem.Attribute("FixingDate").Value,               //  2 fixingdate
                                          _xmlItem.Attribute("StartingDate").Value,             //  3 startingdate
                                          _xmlItem.Attribute("ExpiryDate").Value,               //  4 expirydate
                                          _xmlItem.Attribute("PaymentDate").Value,              //  5 paymentdate
                                          _xmlItem.Attribute("Balance").Value,                  //  6 balance
                                          _xmlItem.Attribute("ExchangePrincipal").Value,        //  7 exchangeprincipal
                                          _xmlItem.Attribute("PostPounding").Value,             //  8 postpounding
                                          _xmlItem.Attribute("Rate").Value,                     //  9 rate
                                          _xmlItem.Attribute("Spread").Value,                   // 10 spread
                                          _xmlItem.Attribute("AmortizationFlow").Value,         // 11 amortizationflow
                                          _xmlItem.Attribute("InterestFlow").Value,             // 12 interestflow
                                          _xmlItem.Attribute("AditionalFlow").Value,            // 13 aditionalflow
                                          _xmlItem.Attribute("TotalFlow").Value,                // 14 totalflow
                                          _xmlItem.Attribute("RateDiscount").Value,             // 15 ratediscount
                                          _xmlItem.Attribute("WellFactor").Value,               // 16 wellfactor
                                          _xmlItem.Attribute("AmortizationPresentValue").Value, // 17 amortizationpresentvalue
                                          _xmlItem.Attribute("InterestPresentValue").Value,     // 18 interestpresentvalue
                                          _xmlItem.Attribute("AditionalPresentValue").Value,    // 19 aditionalpresentvalue
                                          _xmlItem.Attribute("PresentValue").Value              // 20 presentvalue
                                        );

                _xmlItem = (XElement)_xmlItem.NextNode;

            }

            _Insert += "\n";

            #endregion

            #region "Flow Liabilities"

            _xmlItem = (XElement)_ToXML.Element("SaveData").Element("FlowsLiabilities");

            _xmlItem = (XElement)_xmlItem.FirstNode;
            
            while (!(_xmlItem == null))
            {

                _Insert += string.Format(
                                          "SELECT @ID = ISNULL( MAX(id), {0} ) + 1 FROM dbo.PricingSwapFlow\n",
                                          double.Parse(_EntryDate.ToString("yyyyMMdd")) * Math.Pow(10, 6) + 2.0 * Math.Pow(10, 5)
                                        );

                _Insert += string.Format(
                                          _Flow,
                                          "@LegLiabilitiesID",                                  //  0 legid
                                          _xmlItem.Attribute("FlowID").Value,                   //  1 flowid
                                          _xmlItem.Attribute("FixingDate").Value,               //  2 fixingdate
                                          _xmlItem.Attribute("StartingDate").Value,             //  3 startingdate
                                          _xmlItem.Attribute("ExpiryDate").Value,               //  4 expirydate
                                          _xmlItem.Attribute("PaymentDate").Value,              //  5 paymentdate
                                          _xmlItem.Attribute("Balance").Value,                  //  6 balance
                                          _xmlItem.Attribute("ExchangePrincipal").Value,        //  7 exchangeprincipal
                                          _xmlItem.Attribute("PostPounding").Value,             //  8 postpounding
                                          _xmlItem.Attribute("Rate").Value,                     //  9 rate
                                          _xmlItem.Attribute("Spread").Value,                   // 10 spread
                                          _xmlItem.Attribute("AmortizationFlow").Value,         // 11 amortizationflow
                                          _xmlItem.Attribute("InterestFlow").Value,             // 12 interestflow
                                          _xmlItem.Attribute("AditionalFlow").Value,            // 13 aditionalflow
                                          _xmlItem.Attribute("TotalFlow").Value,                // 14 totalflow
                                          _xmlItem.Attribute("RateDiscount").Value,             // 15 ratediscount
                                          _xmlItem.Attribute("WellFactor").Value,               // 16 wellfactor
                                          _xmlItem.Attribute("AmortizationPresentValue").Value, // 17 amortizationpresentvalue
                                          _xmlItem.Attribute("InterestPresentValue").Value,     // 18 interestpresentvalue
                                          _xmlItem.Attribute("AditionalPresentValue").Value,    // 19 aditionalpresentvalue
                                          _xmlItem.Attribute("PresentValue").Value              // 20 presentvalue
                                        );

                _xmlItem = (XElement)_xmlItem.NextNode;


            }

            _Insert += "\n";

            #endregion

            #region "Grabar Set Precios"
            
            _xmlItem = (XElement)_ToXML.Element("SaveData").Element("ExchangeRate");

            _xmlItem = (XElement)_xmlItem.FirstNode;
            
            while (!(_xmlItem == null))
            {

                _Insert += string.Format(
                                          "SELECT @ExcxhangeRate = ISNULL( MAX(id), {0} ) + 1 FROM dbo.PricingSwapExchangeRate\n",
                                          double.Parse(_EntryDate.ToString("yyyyMMdd")) * Math.Pow(10, 6) + 2.0 * Math.Pow(10, 5)
                                        );

                _Insert += string.Format(
                                          "INSERT INTO dbo.PricingSwapExchangeRate ( id, dataid, exchangerateid, bid, offer, middle, usercreator )" +
                                          "VALUES ( @ExcxhangeRate, @DataID, {0}, {1}, {2}, {3}, {4} )",
                                          _xmlItem.Attribute("ID").Value.Replace(",", "."),                       //  0 ID
                                          _xmlItem.Attribute("ValueBid").Value.Replace(",", "."),                 //  1 fixingdate
                                          _xmlItem.Attribute("ValueOffer").Value.Replace(",", "."),               //  2 startingdate
                                          _xmlItem.Attribute("ValueMiddle").Value.Replace(",", "."),              //  3 expirydate
                                          2
                                        );

                _xmlItem = (XElement)_xmlItem.NextNode;


            }

            _Insert += "\n";


            #endregion


            _Insert += "SELECT 'ID' = @DataID\n\n";
            _Insert += "SET NOCOUNT ON\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Insert, "ID");
                _DTID = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTID = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTID;

        }

        public DataTable LoadHead()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapHead;
            string _PricingSwapHead;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapHead = new DataTable();

            _PricingSwapHead = "";

            #endregion

            #region "Query"

            _PricingSwapHead += "SELECT 'Type'                         = 'TURING'\n";
            _PricingSwapHead += "     , 'ID'                           = PS.id\n";
            _PricingSwapHead += "     , 'EntryDate'                    = PS.entrydate\n";
            _PricingSwapHead += "     , 'PricingDate'                  = PS.pricingdate\n";
            _PricingSwapHead += "     , 'CurrencyPrimary'              = PS.currencyprimary\n";
            _PricingSwapHead += "     , 'CurrencyPrimaryMNemonics'     = CP.mnemonic\n";
            _PricingSwapHead += "     , 'RatePrimary'                  = PS.rateprimary\n";
            _PricingSwapHead += "     , 'RatePrimaryMNemonics'         = RP.mnemonic\n";
            _PricingSwapHead += "     , 'AmountPrimary'                = PS.amountprimary\n";
            _PricingSwapHead += "     , 'ParityPrimary'                = PS.parityprimary\n";
            _PricingSwapHead += "     , 'ExchangeRatePrimary'          = PS.exchangerateprimary\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryUM'        = PS.marktomarketprimaryum\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryCLP'       = PS.marktomarketprimaryclp\n";
            _PricingSwapHead += "     , 'CurrencySecondary'            = PS.currencysecondary\n";
            _PricingSwapHead += "     , 'CurrencySecondaryMNemonics'   = CS.mnemonic\n";
            _PricingSwapHead += "     , 'RateSecondary'                = PS.ratesecondary\n";
            _PricingSwapHead += "     , 'RateSecondaryMNemonics'       = RS.mnemonic\n";
            _PricingSwapHead += "     , 'AmountSecundary'              = PS.amountsecundary\n";
            _PricingSwapHead += "     , 'ParitySecundary'              = PS.paritysecundary\n";
            _PricingSwapHead += "     , 'ExchangeRateSecundary'        = PS.exchangeratesecundary\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryUM'      = PS.marktomarketsecundaryum\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryCLP'     = PS.marktomarketsecundaryclp\n";
            _PricingSwapHead += "     , 'Parity'                       = PS.parity\n";
            _PricingSwapHead += "     , 'Payment'                      = PS.payment\n";
            _PricingSwapHead += "     , 'MarkToMarketNet'              = PS.marktomarketnet\n";
            _PricingSwapHead += "     , 'BPV'                          = PS.bpv\n";
            _PricingSwapHead += "     , 'MarkToMarketDistributionNet'  = PS.marktomarketdistributionnet\n";
            _PricingSwapHead += "     , 'ExchangeNotionalStarting'     = PS.exchangenotionalstarting\n";
            _PricingSwapHead += "     , 'ExchangeNotionalIntermediate' = PS.exchangenotionalintermediate\n";
            _PricingSwapHead += "     , 'ExchangeNotionalEnd'          = PS.exchangenotionalend\n";
            _PricingSwapHead += "     , 'SetPricing'                   = PS.setpricing\n";
            _PricingSwapHead += "     , 'Comment'                      = PS.comment\n";
            _PricingSwapHead += "     , 'UserCreator'                  = PS.usercreator\n";
            _PricingSwapHead += "     , 'UserNick'                     = UT.nick\n";
            _PricingSwapHead += "     , 'UserName'                     = UT.name\n";
            _PricingSwapHead += "     , 'Status'                       = PS.status\n";
            _PricingSwapHead += "  FROM dbo.PricingSwap                PS\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CP   ON PS.currencyprimary   = CP.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblRate         RP   ON PS.rateprimary       = RP.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CS   ON PS.currencysecondary = CS.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblRate         RS   ON PS.ratesecondary     = RS.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.usertable       UT   ON PS.usercreator       = UT.id\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapHead, "PricingSwapHead");
                _DTPricingSwapHead = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapHead = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapHead;

        }

        public DataTable LoadLeg()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapLeg;
            string _PricingSwapLeg;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapLeg = new DataTable();

            _PricingSwapLeg = "";

            #endregion

            #region "Query"

            _PricingSwapLeg += "SELECT 'ID'                          = id\n";
            _PricingSwapLeg += "     , 'DataID'                      = dataid\n";
            _PricingSwapLeg += "     , 'LegID'                       = legid\n";
            _PricingSwapLeg += "     , 'CurrencyID'                  = currencyid\n";
            _PricingSwapLeg += "     , 'Amount'                      = amount\n";
            _PricingSwapLeg += "     , 'Parity'                      = parity\n";
            _PricingSwapLeg += "     , 'ExchangeRate'                = exchangerate\n";
            _PricingSwapLeg += "     , 'StartinDdate'                = startingdate\n";
            _PricingSwapLeg += "     , 'ExpiryDate'                  = expirydate\n";
            _PricingSwapLeg += "     , 'Convention'                  = convention\n";
            _PricingSwapLeg += "     , 'RateID'                      = rateid\n";
            _PricingSwapLeg += "     , 'Factor'                      = factor\n";
            _PricingSwapLeg += "     , 'Rate'                        = rate\n";
            _PricingSwapLeg += "     , 'Spread'                      = spread\n";
            _PricingSwapLeg += "     , 'DevelopmentTable'            = developmenttable\n";
            _PricingSwapLeg += "     , 'IntervaleType'               = intervaletype\n";
            _PricingSwapLeg += "     , 'BrokenPeriod'                = brokenperiod\n";
            _PricingSwapLeg += "     , 'PaymentCurrency'             = paymentcurrency\n";
            _PricingSwapLeg += "     , 'MarkToMarketUM'              = marktomarketum\n";
            _PricingSwapLeg += "     , 'MarkToMarketCLP'             = marktomarketclp\n";
            _PricingSwapLeg += "     , 'SpreadDistribution'          = spreaddistribution\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionUM'  = marktomarketdistributionum\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionCLP' = marktomarketdistributionclp\n";
            _PricingSwapLeg += "     , 'BackwardnessStartNumber'     = backwardnessstartnumber\n";
            _PricingSwapLeg += "     , 'BackwardnessStartType'       = backwardnessstarttype\n";
            _PricingSwapLeg += "     , 'IntervalCalendarSantiago'    = intervalcalendarsantiago\n";
            _PricingSwapLeg += "     , 'IntervalCalendarNewYork'     = intervalcalendarnewyork\n";
            _PricingSwapLeg += "     , 'IntervalCalendarLondres'     = intervalcalendarlondres\n";
            _PricingSwapLeg += "     , 'PaymentNumber'               = paymentnumber\n";
            _PricingSwapLeg += "     , 'PaymentType'                 = paymenttype\n";
            _PricingSwapLeg += "     , 'PaymentDate'                 = paymentdate\n";
            _PricingSwapLeg += "     , 'PaymentCalendarSantiago'     = paymentcalendarsantiago\n";
            _PricingSwapLeg += "     , 'PaymentCalendarNewYork'      = paymentcalendarnewyork\n";
            _PricingSwapLeg += "     , 'PaymentCalendarLondres'      = paymentcalendarlondres\n";
            _PricingSwapLeg += "     , 'FixingNumber'                = fixingnumber\n";
            _PricingSwapLeg += "     , 'FixingType'                  = fixingtype\n";
            _PricingSwapLeg += "     , 'FixingDate'                  = fixingdate\n";
            _PricingSwapLeg += "     , 'FixingCalendarSantiago'      = fixingcalendarsantiago\n";
            _PricingSwapLeg += "     , 'FixingCalendarNewYork'       = fixingcalendarnewyork\n";
            _PricingSwapLeg += "     , 'FixingCalendarLondres'       = fixingcalendarlondres\n";
            _PricingSwapLeg += "     , 'ConventionCalendar'          = conventioncalendar\n";
            _PricingSwapLeg += "     , 'YieldProject'                = yieldproject\n";
            _PricingSwapLeg += "     , 'YieldDiscount'               = yielddiscount\n";
            _PricingSwapLeg += "     , 'TermBenchMark'               = termbenchmark\n";
            _PricingSwapLeg += "  FROM dbo.PricingSwapLeg\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapLeg, "PricingSwapLeg");
                _DTPricingSwapLeg = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapLeg = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapLeg;

        }

        public DataTable LoadFlow()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapFlow;
            string _PricingSwapFlow;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapFlow = new DataTable();

            _PricingSwapFlow = "";

            #endregion

            #region "Query"

            _PricingSwapFlow += "SELECT 'ID'                        = id\n";
            _PricingSwapFlow += "     , 'DataID'                    = dataid\n";
            _PricingSwapFlow += "     , 'LegID'                     = legid\n";
            _PricingSwapFlow += "     , 'FlowID'                    = flowid\n";
            _PricingSwapFlow += "     , 'FixingDate'                = fixingdate\n";
            _PricingSwapFlow += "     , 'StartingDate'              = startingdate\n";
            _PricingSwapFlow += "     , 'ExpiryDate'                = expirydate\n";
            _PricingSwapFlow += "     , 'PaymentDate'               = paymentdate\n";
            _PricingSwapFlow += "     , 'Balance'                   = balance\n";
            _PricingSwapFlow += "     , 'ExchangePrincipal'         = exchangeprincipal\n";
            _PricingSwapFlow += "     , 'PostPounding'              = postpounding\n";
            _PricingSwapFlow += "     , 'Rate'                      = rate\n";
            _PricingSwapFlow += "     , 'Spread'                    = spread\n";
            _PricingSwapFlow += "     , 'AmortizationFlow'          = amortizationflow\n";
            _PricingSwapFlow += "     , 'InterestFlow'              = interestflow\n";
            _PricingSwapFlow += "     , 'AditionalFlow'             = aditionalflow\n";
            _PricingSwapFlow += "     , 'TotalFlow'                 = totalflow\n";
            _PricingSwapFlow += "     , 'RateDiscount'              = ratediscount\n";
            _PricingSwapFlow += "     , 'WellFactor'                = wellfactor\n";
            _PricingSwapFlow += "     , 'AmortizationPresentValue'  = amortizationpresentvalue\n";
            _PricingSwapFlow += "     , 'InterestPresentValue'      = interestpresentvalue\n";
            _PricingSwapFlow += "     , 'AditionalFlowPresentValue' = aditionalflowpresentvalue\n";
            _PricingSwapFlow += "     , 'PresentValue'              = presentvalue\n";
            _PricingSwapFlow += "  FROM dbo.PricingSwapFlow\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapFlow, "PricingSwapFlow");
                _DTPricingSwapFlow = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapFlow = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapFlow;

        }

        public DataTable LoadHead(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapHead;
            string _PricingSwapHead;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapHead = new DataTable();

            _PricingSwapHead = "";

            #endregion

            #region "Query"

            _PricingSwapHead += "SELECT 'ID'                           = PS.id\n";
            _PricingSwapHead += "     , 'EntryDate'                    = PS.entrydate\n";
            _PricingSwapHead += "     , 'PricingDate'                  = PS.pricingdate\n";
            _PricingSwapHead += "     , 'CurrencyPrimary'              = PS.currencyprimary\n";
            _PricingSwapHead += "     , 'CurrencyPrimaryMNemonics'     = CP.mnemonic\n";
            _PricingSwapHead += "     , 'RatePrimary'                  = PS.rateprimary\n";
            _PricingSwapHead += "     , 'RatePrimaryMNemonics'         = RP.mnemonic\n";
            _PricingSwapHead += "     , 'AmountPrimary'                = PS.amountprimary\n";
            _PricingSwapHead += "     , 'ParityPrimary'                = PS.parityprimary\n";
            _PricingSwapHead += "     , 'ExchangeRatePrimary'          = PS.exchangerateprimary\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryUM'        = PS.marktomarketprimaryum\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryCLP'       = PS.marktomarketprimaryclp\n";
            _PricingSwapHead += "     , 'CurrencySecondary'            = PS.currencysecondary\n";
            _PricingSwapHead += "     , 'CurrencySecondaryMNemonics'   = CS.mnemonic\n";
            _PricingSwapHead += "     , 'RateSecondary'                = PS.ratesecondary\n";
            _PricingSwapHead += "     , 'RateSecondaryMNemonics'       = RS.mnemonic\n";
            _PricingSwapHead += "     , 'AmountSecundary'              = PS.amountsecundary\n";
            _PricingSwapHead += "     , 'ParitySecundary'              = PS.paritysecundary\n";
            _PricingSwapHead += "     , 'ExchangeRateSecundary'        = PS.exchangeratesecundary\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryUM'      = PS.marktomarketsecundaryum\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryCLP'     = PS.marktomarketsecundaryclp\n";
            _PricingSwapHead += "     , 'Parity'                       = PS.parity\n";
            _PricingSwapHead += "     , 'Payment'                      = PS.payment\n";
            _PricingSwapHead += "     , 'MarkToMarketNet'              = PS.marktomarketnet\n";
            _PricingSwapHead += "     , 'BPV'                          = PS.bpv\n";
            _PricingSwapHead += "     , 'MarkToMarketDistributionNet'  = PS.marktomarketdistributionnet\n";
            _PricingSwapHead += "     , 'ExchangeNotionalStarting'     = PS.exchangenotionalstarting\n";
            _PricingSwapHead += "     , 'ExchangeNotionalIntermediate' = PS.exchangenotionalintermediate\n";
            _PricingSwapHead += "     , 'ExchangeNotionalEnd'          = PS.exchangenotionalend\n";
            _PricingSwapHead += "     , 'SetPricing'                   = PS.setpricing\n";
            _PricingSwapHead += "     , 'Comment'                      = PS.comment\n";
            _PricingSwapHead += "     , 'UserCreator'                  = PS.usercreator\n";
            _PricingSwapHead += "     , 'UserNick'                     = UT.nick\n";
            _PricingSwapHead += "     , 'UserName'                     = UT.name\n";
            _PricingSwapHead += "     , 'Status'                       = PS.status\n";
            _PricingSwapHead += "  FROM dbo.PricingSwap                PS\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CP   ON PS.currencyprimary   = CP.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblRate         RP   ON PS.rateprimary       = RP.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CS   ON PS.currencysecondary = CS.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblRate         RS   ON PS.ratesecondary     = RS.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.usertable       UT   ON PS.usercreator       = UT.id\n";
            _PricingSwapHead += " WHERE PS.id                          = {0}\n";

            _PricingSwapHead = string.Format(_PricingSwapHead, id.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapHead, "PricingSwapHead");
                _DTPricingSwapHead = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapHead = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapHead;

        }

        public DataTable LoadLeg(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapLeg;
            string _PricingSwapLeg;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapLeg = new DataTable();

            _PricingSwapLeg = "";

            #endregion

            #region "Query"

            _PricingSwapLeg += "SELECT 'ID'                          = id\n";
            _PricingSwapLeg += "     , 'DataID'                      = dataid\n";
            _PricingSwapLeg += "     , 'LegID'                       = legid\n";
            _PricingSwapLeg += "     , 'CurrencyID'                  = currencyid\n";
            _PricingSwapLeg += "     , 'Amount'                      = amount\n";
            _PricingSwapLeg += "     , 'Parity'                      = parity\n";
            _PricingSwapLeg += "     , 'ExchangeRate'                = exchangerate\n";
            _PricingSwapLeg += "     , 'StartinDdate'                = startingdate\n";
            _PricingSwapLeg += "     , 'ExpiryDate'                  = expirydate\n";
            _PricingSwapLeg += "     , 'Convention'                  = convention\n";
            _PricingSwapLeg += "     , 'RateID'                      = rateid\n";
            _PricingSwapLeg += "     , 'Factor'                      = factor\n";
            _PricingSwapLeg += "     , 'Rate'                        = rate\n";
            _PricingSwapLeg += "     , 'Spread'                      = spread\n";
            _PricingSwapLeg += "     , 'DevelopmentTable'            = developmenttable\n";
            _PricingSwapLeg += "     , 'IntervaleType'               = intervaletype\n";
            _PricingSwapLeg += "     , 'BrokenPeriod'                = brokenperiod\n";
            _PricingSwapLeg += "     , 'PaymentCurrency'             = paymentcurrency\n";
            _PricingSwapLeg += "     , 'MarkToMarketUM'              = marktomarketum\n";
            _PricingSwapLeg += "     , 'MarkToMarketCLP'             = marktomarketclp\n";
            _PricingSwapLeg += "     , 'SpreadDistribution'          = spreaddistribution\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionUM'  = marktomarketdistributionum\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionCLP' = marktomarketdistributionclp\n";
            _PricingSwapLeg += "     , 'BackwardnessStartNumber'     = backwardnessstartnumber\n";
            _PricingSwapLeg += "     , 'BackwardnessStartType'       = backwardnessstarttype\n";
            _PricingSwapLeg += "     , 'IntervalCalendarSantiago'    = intervalcalendarsantiago\n";
            _PricingSwapLeg += "     , 'IntervalCalendarNewYork'     = intervalcalendarnewyork\n";
            _PricingSwapLeg += "     , 'IntervalCalendarLondres'     = intervalcalendarlondres\n";
            _PricingSwapLeg += "     , 'PaymentNumber'               = paymentnumber\n";
            _PricingSwapLeg += "     , 'PaymentType'                 = paymenttype\n";
            _PricingSwapLeg += "     , 'PaymentDate'                 = paymentdate\n";
            _PricingSwapLeg += "     , 'PaymentCalendarSantiago'     = paymentcalendarsantiago\n";
            _PricingSwapLeg += "     , 'PaymentCalendarNewYork'      = paymentcalendarnewyork\n";
            _PricingSwapLeg += "     , 'PaymentCalendarLondres'      = paymentcalendarlondres\n";
            _PricingSwapLeg += "     , 'FixingNumber'                = fixingnumber\n";
            _PricingSwapLeg += "     , 'FixingType'                  = fixingtype\n";
            _PricingSwapLeg += "     , 'FixingDate'                  = fixingdate\n";
            _PricingSwapLeg += "     , 'FixingCalendarSantiago'      = fixingcalendarsantiago\n";
            _PricingSwapLeg += "     , 'FixingCalendarNewYork'       = fixingcalendarnewyork\n";
            _PricingSwapLeg += "     , 'FixingCalendarLondres'       = fixingcalendarlondres\n";
            _PricingSwapLeg += "     , 'ConventionCalendar'          = conventioncalendar\n";
            _PricingSwapLeg += "     , 'YieldProject'                = yieldproject\n";
            _PricingSwapLeg += "     , 'YieldDiscount'               = yielddiscount\n";
            _PricingSwapLeg += "     , 'TermBenchMark'               = termbenchmark\n";
            _PricingSwapLeg += "     , 'ResetDay'                    = resetday\n";
            _PricingSwapLeg += "  FROM dbo.PricingSwapLeg\n";
            _PricingSwapLeg += " WHERE dataid                        = {0}\n";

            _PricingSwapLeg = string.Format(_PricingSwapLeg, id);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapLeg, "PricingSwapLeg");
                _DTPricingSwapLeg = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapLeg = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapLeg;

        }

        public DataTable LoadFlow(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapFlow;
            string _PricingSwapFlow;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapFlow = new DataTable();

            _PricingSwapFlow = "";

            #endregion

            #region "Query"

            _PricingSwapFlow += "SELECT 'ID'                        = id\n";
            _PricingSwapFlow += "     , 'DataID'                    = dataid\n";
            _PricingSwapFlow += "     , 'LegID'                     = legid\n";
            _PricingSwapFlow += "     , 'FlowID'                    = flowid\n";
            _PricingSwapFlow += "     , 'FixingDate'                = fixingdate\n";
            _PricingSwapFlow += "     , 'StartingDate'              = startingdate\n";
            _PricingSwapFlow += "     , 'ExpiryDate'                = expirydate\n";
            _PricingSwapFlow += "     , 'PaymentDate'               = paymentdate\n";
            _PricingSwapFlow += "     , 'Balance'                   = balance\n";
            _PricingSwapFlow += "     , 'ExchangePrincipal'         = exchangeprincipal\n";
            _PricingSwapFlow += "     , 'PostPounding'              = postpounding\n";
            _PricingSwapFlow += "     , 'Rate'                      = rate\n";
            _PricingSwapFlow += "     , 'Spread'                    = spread\n";
            _PricingSwapFlow += "     , 'AmortizationFlow'          = amortizationflow\n";
            _PricingSwapFlow += "     , 'InterestFlow'              = interestflow\n";
            _PricingSwapFlow += "     , 'AditionalFlow'             = aditionalflow\n";
            _PricingSwapFlow += "     , 'TotalFlow'                 = totalflow\n";
            _PricingSwapFlow += "     , 'RateDiscount'              = ratediscount\n";
            _PricingSwapFlow += "     , 'WellFactor'                = wellfactor\n";
            _PricingSwapFlow += "     , 'AmortizationPresentValue'  = amortizationpresentvalue\n";
            _PricingSwapFlow += "     , 'InterestPresentValue'      = interestpresentvalue\n";
            _PricingSwapFlow += "     , 'AditionalFlowPresentValue' = aditionalflowpresentvalue\n";
            _PricingSwapFlow += "     , 'PresentValue'              = presentvalue\n";
            _PricingSwapFlow += "  FROM dbo.PricingSwapFlow\n";
            _PricingSwapFlow += " WHERE dataid                      = {0}\n";

            _PricingSwapFlow = string.Format(_PricingSwapFlow, id);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapFlow, "PricingSwapFlow");
                _DTPricingSwapFlow = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapFlow = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapFlow;

        }

        public DataTable LoadRealTime(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapRealTime;
            string _PricingSwapRealTime;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapRealTime = new DataTable();

            _PricingSwapRealTime = "";

            #endregion

            #region "Query"

            _PricingSwapRealTime += "SELECT 'ID'          = PSER.exchangerateid\n";
            _PricingSwapRealTime += "     , 'Description' = ER.description\n";
            _PricingSwapRealTime += "     , 'ValueBid'    = PSER.bid\n";
            _PricingSwapRealTime += "     , 'ValueOffer'  = PSER.offer\n";
            _PricingSwapRealTime += "     , 'ValueMid'    = PSER.middle\n";
            _PricingSwapRealTime += "  FROM dbo.pricingswapexchangerate     PSER\n";
            _PricingSwapRealTime += "       INNER JOIN dbo.tblExchangeRate  ER   ON PSER.exchangerateid = ER.id\n";
            _PricingSwapRealTime += " WHERE dataID = {0}\n";

            _PricingSwapRealTime = string.Format(_PricingSwapRealTime, id);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapRealTime, "PricingSwapRealTime");
                _DTPricingSwapRealTime = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapRealTime = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapRealTime;


        }

        public DataSet LoadCotization(string conditions)
        {

            DataSet _DataSet = new DataSet();

            _DataSet.Merge(LoadHead(conditions));
            _DataSet.Merge(LoadLeg(conditions));
            _DataSet.Merge(LoadFlow(conditions));

            return _DataSet;

        }

        private DataTable LoadHead(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapHead;
            string _PricingSwapHead;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapHead = new DataTable();

            _PricingSwapHead = "";

            #endregion

            #region "Query"

            _PricingSwapHead += "SELECT 'Type'                         = 'TURING'\n";
            _PricingSwapHead += "     , 'ID'                           = PS.id\n";
            _PricingSwapHead += "     , 'EntryDate'                    = PS.entrydate\n";
            _PricingSwapHead += "     , 'PricingDate'                  = PS.pricingdate\n";
            _PricingSwapHead += "     , 'CurrencyPrimary'              = PS.currencyprimary\n";
            _PricingSwapHead += "     , 'CurrencyPrimarySystem'        = CP.systemid\n";
            _PricingSwapHead += "     , 'CurrencyPrimaryMNemonics'     = CP.mnemonic\n";
            _PricingSwapHead += "     , 'RatePrimary'                  = PS.rateprimary\n";
            _PricingSwapHead += "     , 'RatePrimarySystem'            = RP.systemid\n";
            _PricingSwapHead += "     , 'RatePrimaryMNemonics'         = RP.mnemonic\n";
            _PricingSwapHead += "     , 'AmountPrimary'                = PS.amountprimary\n";
            _PricingSwapHead += "     , 'ParityPrimary'                = PS.parityprimary\n";
            _PricingSwapHead += "     , 'ExchangeRatePrimary'          = PS.exchangerateprimary\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryUM'        = PS.marktomarketprimaryum\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryCLP'       = PS.marktomarketprimaryclp\n";
            _PricingSwapHead += "     , 'CurrencySecondary'            = PS.currencysecondary\n";
            _PricingSwapHead += "     , 'CurrencySecondarySystem'      = CS.systemid\n";
            _PricingSwapHead += "     , 'CurrencySecondaryMNemonics'   = CS.mnemonic\n";
            _PricingSwapHead += "     , 'RateSecondary'                = PS.ratesecondary\n";
            _PricingSwapHead += "     , 'RateSecondarySystem'          = RS.systemid\n";
            _PricingSwapHead += "     , 'RateSecondaryMNemonics'       = RS.mnemonic\n";
            _PricingSwapHead += "     , 'AmountSecundary'              = PS.amountsecundary\n";
            _PricingSwapHead += "     , 'ParitySecundary'              = PS.paritysecundary\n";
            _PricingSwapHead += "     , 'ExchangeRateSecundary'        = PS.exchangeratesecundary\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryUM'      = PS.marktomarketsecundaryum\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryCLP'     = PS.marktomarketsecundaryclp\n";
            _PricingSwapHead += "     , 'Parity'                       = PS.parity\n";
            _PricingSwapHead += "     , 'Payment'                      = PS.payment\n";
            _PricingSwapHead += "     , 'MarkToMarketNet'              = PS.marktomarketnet\n";
            _PricingSwapHead += "     , 'BPV'                          = PS.bpv\n";
            _PricingSwapHead += "     , 'MarkToMarketDistributionNet'  = PS.marktomarketdistributionnet\n";
            _PricingSwapHead += "     , 'ExchangeNotionalStarting'     = PS.exchangenotionalstarting\n";
            _PricingSwapHead += "     , 'ExchangeNotionalIntermediate' = PS.exchangenotionalintermediate\n";
            _PricingSwapHead += "     , 'ExchangeNotionalEnd'          = PS.exchangenotionalend\n";
            _PricingSwapHead += "     , 'SetPricing'                   = PS.setpricing\n";
            _PricingSwapHead += "     , 'Comment'                      = PS.comment\n";
            _PricingSwapHead += "     , 'UserCreator'                  = PS.usercreator\n";
            _PricingSwapHead += "     , 'UserNick'                     = UT.nick\n";
            _PricingSwapHead += "     , 'UserName'                     = UT.name\n";
            _PricingSwapHead += "     , 'Status'                       = PS.status\n";
            _PricingSwapHead += "  FROM dbo.PricingSwap                PS\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CP   ON PS.currencyprimary   = CP.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblRate         RP   ON PS.rateprimary       = RP.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CS   ON PS.currencysecondary = CS.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.tblRate         RS   ON PS.ratesecondary     = RS.ID\n";
            _PricingSwapHead += "       INNER JOIN dbo.usertable       UT   ON PS.usercreator       = UT.id\n";

            if (!conditions.Equals(""))
            {
                _PricingSwapHead += " WHERE PS.ID in ( " + conditions + ")\n"; 
            }

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapHead, "PricingSwapHead");
                _DTPricingSwapHead = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapHead = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapHead;

        }

        private DataTable LoadLeg(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapLeg;
            string _PricingSwapLeg;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapLeg = new DataTable();

            _PricingSwapLeg = "";

            #endregion

            #region "Query"

            _PricingSwapLeg += "SELECT 'ID'                          = id\n";
            _PricingSwapLeg += "     , 'DataID'                      = dataid\n";
            _PricingSwapLeg += "     , 'LegID'                       = legid\n";
            _PricingSwapLeg += "     , 'CurrencyID'                  = currencyid\n";
            _PricingSwapLeg += "     , 'Amount'                      = amount\n";
            _PricingSwapLeg += "     , 'Parity'                      = parity\n";
            _PricingSwapLeg += "     , 'ExchangeRate'                = exchangerate\n";
            _PricingSwapLeg += "     , 'StartinDdate'                = startingdate\n";
            _PricingSwapLeg += "     , 'ExpiryDate'                  = expirydate\n";
            _PricingSwapLeg += "     , 'Convention'                  = convention\n";
            _PricingSwapLeg += "     , 'RateID'                      = rateid\n";
            _PricingSwapLeg += "     , 'Factor'                      = factor\n";
            _PricingSwapLeg += "     , 'Rate'                        = rate\n";
            _PricingSwapLeg += "     , 'Spread'                      = spread\n";
            _PricingSwapLeg += "     , 'DevelopmentTable'            = developmenttable\n";
            _PricingSwapLeg += "     , 'IntervaleType'               = intervaletype\n";
            _PricingSwapLeg += "     , 'BrokenPeriod'                = brokenperiod\n";
            _PricingSwapLeg += "     , 'PaymentCurrency'             = paymentcurrency\n";
            _PricingSwapLeg += "     , 'MarkToMarketUM'              = marktomarketum\n";
            _PricingSwapLeg += "     , 'MarkToMarketCLP'             = marktomarketclp\n";
            _PricingSwapLeg += "     , 'SpreadDistribution'          = spreaddistribution\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionUM'  = marktomarketdistributionum\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionCLP' = marktomarketdistributionclp\n";
            _PricingSwapLeg += "     , 'BackwardnessStartNumber'     = backwardnessstartnumber\n";
            _PricingSwapLeg += "     , 'BackwardnessStartType'       = backwardnessstarttype\n";
            _PricingSwapLeg += "     , 'IntervalCalendarSantiago'    = intervalcalendarsantiago\n";
            _PricingSwapLeg += "     , 'IntervalCalendarNewYork'     = intervalcalendarnewyork\n";
            _PricingSwapLeg += "     , 'IntervalCalendarLondres'     = intervalcalendarlondres\n";
            _PricingSwapLeg += "     , 'PaymentNumber'               = paymentnumber\n";
            _PricingSwapLeg += "     , 'PaymentType'                 = paymenttype\n";
            _PricingSwapLeg += "     , 'PaymentDate'                 = paymentdate\n";
            _PricingSwapLeg += "     , 'PaymentCalendarSantiago'     = paymentcalendarsantiago\n";
            _PricingSwapLeg += "     , 'PaymentCalendarNewYork'      = paymentcalendarnewyork\n";
            _PricingSwapLeg += "     , 'PaymentCalendarLondres'      = paymentcalendarlondres\n";
            _PricingSwapLeg += "     , 'FixingNumber'                = fixingnumber\n";
            _PricingSwapLeg += "     , 'FixingType'                  = fixingtype\n";
            _PricingSwapLeg += "     , 'FixingDate'                  = fixingdate\n";
            _PricingSwapLeg += "     , 'FixingCalendarSantiago'      = fixingcalendarsantiago\n";
            _PricingSwapLeg += "     , 'FixingCalendarNewYork'       = fixingcalendarnewyork\n";
            _PricingSwapLeg += "     , 'FixingCalendarLondres'       = fixingcalendarlondres\n";
            _PricingSwapLeg += "     , 'ConventionCalendar'          = conventioncalendar\n";
            _PricingSwapLeg += "     , 'YieldProject'                = yieldproject\n";
            _PricingSwapLeg += "     , 'YieldDiscount'               = yielddiscount\n";
            _PricingSwapLeg += "     , 'TermBenchMark'               = termbenchmark\n";
            _PricingSwapLeg += "     , 'ResetDay'                    = resetday\n";
            _PricingSwapLeg += "  FROM dbo.PricingSwapLeg\n";

            if (!conditions.Equals(""))
            {
                _PricingSwapLeg += " WHERE DataID in ( " + conditions + ")\n";
            }


            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapLeg, "PricingSwapLeg");
                _DTPricingSwapLeg = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapLeg = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapLeg;

        }

        private DataTable LoadFlow(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapFlow;
            string _PricingSwapFlow;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapFlow = new DataTable();

            _PricingSwapFlow = "";

            #endregion

            #region "Query"

            _PricingSwapFlow += "SELECT 'ID'                        = id\n";
            _PricingSwapFlow += "     , 'DataID'                    = dataid\n";
            _PricingSwapFlow += "     , 'LegID'                     = legid\n";
            _PricingSwapFlow += "     , 'FlowID'                    = flowid\n";
            _PricingSwapFlow += "     , 'FixingDate'                = fixingdate\n";
            _PricingSwapFlow += "     , 'StartingDate'              = startingdate\n";
            _PricingSwapFlow += "     , 'ExpiryDate'                = expirydate\n";
            _PricingSwapFlow += "     , 'PaymentDate'               = paymentdate\n";
            _PricingSwapFlow += "     , 'Balance'                   = balance\n";
            _PricingSwapFlow += "     , 'ExchangePrincipal'         = exchangeprincipal\n";
            _PricingSwapFlow += "     , 'PostPounding'              = postpounding\n";
            _PricingSwapFlow += "     , 'Rate'                      = rate\n";
            _PricingSwapFlow += "     , 'Spread'                    = spread\n";
            _PricingSwapFlow += "     , 'AmortizationFlow'          = amortizationflow\n";
            _PricingSwapFlow += "     , 'InterestFlow'              = interestflow\n";
            _PricingSwapFlow += "     , 'AditionalFlow'             = aditionalflow\n";
            _PricingSwapFlow += "     , 'TotalFlow'                 = totalflow\n";
            _PricingSwapFlow += "     , 'RateDiscount'              = ratediscount\n";
            _PricingSwapFlow += "     , 'WellFactor'                = wellfactor\n";
            _PricingSwapFlow += "     , 'AmortizationPresentValue'  = amortizationpresentvalue\n";
            _PricingSwapFlow += "     , 'InterestPresentValue'      = interestpresentvalue\n";
            _PricingSwapFlow += "     , 'AditionalFlowPresentValue' = aditionalflowpresentvalue\n";
            _PricingSwapFlow += "     , 'PresentValue'              = presentvalue\n";
            _PricingSwapFlow += "  FROM dbo.PricingSwapFlow\n";

            if (!conditions.Equals(""))
            {
                _PricingSwapFlow += " WHERE DataID in ( " + conditions + ")\n";
            }

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _PricingSwapFlow, "PricingSwapFlow");
                _DTPricingSwapFlow = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapFlow = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapFlow;

        }

    }

}
