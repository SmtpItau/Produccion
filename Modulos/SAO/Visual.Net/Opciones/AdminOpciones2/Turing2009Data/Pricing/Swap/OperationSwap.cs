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
    public class OperationSwap : InterfaceQuery
    {

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

            _PricingSwapHead += "SET NOCOUNT ON\n\n";
            _PricingSwapHead += "DECLARE @ProcessDate        DATETIME\n\n";

            _PricingSwapHead += "SELECT @ProcessDate = fechaproc\n";
            _PricingSwapHead += "  FROM dbo.SwapGeneral\n\n";

            _PricingSwapHead += "SELECT 'Type'                         = 'CARTERA'\n";
            _PricingSwapHead += "     , 'ID'                           = CA.numero_operacion\n";
            _PricingSwapHead += "     , 'EntryDate'                    = CA.fecha_cierre\n";
            _PricingSwapHead += "     , 'PricingDate'                  = @ProcessDate\n";
            _PricingSwapHead += "     , 'CurrencyPrimary'              = CA.compra_moneda\n";
            _PricingSwapHead += "     , 'CurrencyPrimaryMNemonics'     = PC.mnnemo\n";
            _PricingSwapHead += "     , 'RatePrimary'                  = CA.compra_codigo_tasa\n";
            _PricingSwapHead += "     , 'RatePrimaryMNemonics'         = PTGD.tbglosa\n";
            _PricingSwapHead += "     , 'AmountPrimary'                = CA.compra_capital\n";
            _PricingSwapHead += "     , 'ParityPrimary'                = 1\n";
            _PricingSwapHead += "     , 'ExchangeRatePrimary'          = 1\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryUM'        = CA.vRazActivoAjus_Mo\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryCLP'       = CA.vRazActivoAjus_Mn\n";
            _PricingSwapHead += "     , 'CurrencySecondary'            = CP.venta_moneda\n";
            _PricingSwapHead += "     , 'CurrencySecondaryMNemonics'   = SC.mnnemo\n";
            _PricingSwapHead += "     , 'RateSecondary'                = CP.venta_codigo_tasa\n";
            _PricingSwapHead += "     , 'RateSecondaryMNemonics'       = STGD.tbglosa\n";
            _PricingSwapHead += "     , 'AmountSecundary'              = CP.venta_capital\n";
            _PricingSwapHead += "     , 'ParitySecundary'              = 1\n";
            _PricingSwapHead += "     , 'ExchangeRateSecundary'        = 1\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryUM'      = CP.vRazPasivoAjus_Mo\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryCLP'     = CA.vRazPasivoAjus_Mn\n";
            _PricingSwapHead += "     , 'Parity'                       = CP.venta_capital / CA.compra_capital\n";
            _PricingSwapHead += "     , 'Payment'                      = 0\n";
            _PricingSwapHead += "     , 'MarkToMarketNet'              = CA.vRazActivoAjus_Mn - CA.vRazPasivoAjus_Mn\n";
            _PricingSwapHead += "     , 'BPV'                          = 0.0\n";
            _PricingSwapHead += "     , 'MarkToMarketDistributionNet'  = 0.0\n";
            _PricingSwapHead += "     , 'ExchangeNotionalStarting'     = ' '\n";
            _PricingSwapHead += "     , 'ExchangeNotionalIntermediate' = 'X'\n";
            _PricingSwapHead += "     , 'ExchangeNotionalEnd'          = 'X'\n";
            _PricingSwapHead += "     , 'SetPricing'                   = 1\n";
            _PricingSwapHead += "     , 'Comment'                      = ''\n";
            _PricingSwapHead += "     , 'UserCreator'                  = 0\n";
            _PricingSwapHead += "     , 'UserNick'                     = CA.operador\n";
            _PricingSwapHead += "     , 'UserName'                     = U.nombre\n";
            _PricingSwapHead += "     , 'Status'                       = 0\n";
            _PricingSwapHead += "  FROM dbo.Cartera                                        CA\n";
            _PricingSwapHead += "       INNER JOIN Cartera                                 CP    ON CA.Numero_Operacion   = CP.Numero_Operacion\n";
            _PricingSwapHead += "                                                               AND CP.Tipo_Flujo         = 2\n";
            _PricingSwapHead += "                                                               AND CP.estado_flujo      <> 0 \n";
            _PricingSwapHead += "                                                               AND CP.estado            <> 'C'\n";
            _PricingSwapHead += "                                                               AND\n";
            _PricingSwapHead += "                                                                  (CP.estado_flujo       = 1\n";
            _PricingSwapHead += "                                                                OR CP.estado             = 'N')\n";
            _PricingSwapHead += "        INNER JOIN BacParamSuda.dbo.moneda                PC    ON CA.compra_moneda      = PC.mncodmon\n";
            _PricingSwapHead += "        INNER JOIN BacParamSuda.dbo.moneda                SC    ON CP.venta_moneda       = SC.mncodmon\n";
            _PricingSwapHead += "        INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE PTGD  ON PTGD.tbcateg          = 1042\n";
            _PricingSwapHead += "                                                               AND CA.compra_codigo_tasa = CAST( PTGD.tbcodigo1 AS INTEGER )\n";
            _PricingSwapHead += "        INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE STGD  ON STGD.tbcateg          = 1042\n";
            _PricingSwapHead += "                                                               AND CP.venta_codigo_tasa  = CAST( STGD.tbcodigo1 AS INTEGER )\n";
            _PricingSwapHead += "        INNER JOIN BacParamSuda.dbo.USUARIO               U     ON CP.operador           = U.usuario\n";
            _PricingSwapHead += " WHERE CA.estado                           <> 'C'\n";
            _PricingSwapHead += "   AND CA.Tipo_Flujo                        = 1\n";
            _PricingSwapHead += "   AND\n";
            _PricingSwapHead += "      (CA.estado_flujo                      = 1 \n";
            _PricingSwapHead += "    OR CA.estado                            = 'N' )\n";
            _PricingSwapHead += " ORDER BY CA.Numero_Operacion\n";
            _PricingSwapHead += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACSWAPSUDA", _PricingSwapHead, "OperationSwapHead");
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

        //public DataTable LoadHead(long id)
        //{

        //    #region "Definición de Variables"

        //    Turing2009Connect.Connect _Connect;
        //    DataTable _DTPricingSwapHead;
        //    string _PricingSwapHead;

        //    #endregion

        //    #region "Inicialización de Variables"

        //    _Connect = new Turing2009Connect.Connect();
        //    _Connect.QueryType = enumQueryType.Load;

        //    _DTPricingSwapHead = new DataTable();

        //    _PricingSwapHead = "";

        //    #endregion

        //    #region "Query"

        //    _PricingSwapHead += "SELECT 'ID'                           = PS.id\n";
        //    _PricingSwapHead += "     , 'EntryDate'                    = PS.entrydate\n";
        //    _PricingSwapHead += "     , 'PricingDate'                  = PS.pricingdate\n";
        //    _PricingSwapHead += "     , 'CurrencyPrimary'              = PS.currencyprimary\n";
        //    _PricingSwapHead += "     , 'CurrencyPrimaryMNemonics'     = CP.mnemonic\n";
        //    _PricingSwapHead += "     , 'RatePrimary'                  = PS.rateprimary\n";
        //    _PricingSwapHead += "     , 'RatePrimaryMNemonics'         = RP.mnemonic\n";
        //    _PricingSwapHead += "     , 'AmountPrimary'                = PS.amountprimary\n";
        //    _PricingSwapHead += "     , 'ParityPrimary'                = PS.parityprimary\n";
        //    _PricingSwapHead += "     , 'ExchangeRatePrimary'          = PS.exchangerateprimary\n";
        //    _PricingSwapHead += "     , 'MarkToMarketPrimaryUM'        = PS.marktomarketprimaryum\n";
        //    _PricingSwapHead += "     , 'MarkToMarketPrimaryCLP'       = PS.marktomarketprimaryclp\n";
        //    _PricingSwapHead += "     , 'CurrencySecondary'            = PS.currencysecondary\n";
        //    _PricingSwapHead += "     , 'CurrencySecondaryMNemonics'   = CS.mnemonic\n";
        //    _PricingSwapHead += "     , 'RateSecondary'                = PS.ratesecondary\n";
        //    _PricingSwapHead += "     , 'RateSecondaryMNemonics'       = RS.mnemonic\n";
        //    _PricingSwapHead += "     , 'AmountSecundary'              = PS.amountsecundary\n";
        //    _PricingSwapHead += "     , 'ParitySecundary'              = PS.paritysecundary\n";
        //    _PricingSwapHead += "     , 'ExchangeRateSecundary'        = PS.exchangeratesecundary\n";
        //    _PricingSwapHead += "     , 'MarkToMarketSecundaryUM'      = PS.marktomarketsecundaryum\n";
        //    _PricingSwapHead += "     , 'MarkToMarketSecundaryCLP'     = PS.marktomarketsecundaryclp\n";
        //    _PricingSwapHead += "     , 'Parity'                       = PS.parity\n";
        //    _PricingSwapHead += "     , 'Payment'                      = PS.payment\n";
        //    _PricingSwapHead += "     , 'MarkToMarketNet'              = PS.marktomarketnet\n";
        //    _PricingSwapHead += "     , 'BPV'                          = PS.bpv\n";
        //    _PricingSwapHead += "     , 'MarkToMarketDistributionNet'  = PS.marktomarketdistributionnet\n";
        //    _PricingSwapHead += "     , 'ExchangeNotionalStarting'     = PS.exchangenotionalstarting\n";
        //    _PricingSwapHead += "     , 'ExchangeNotionalIntermediate' = PS.exchangenotionalintermediate\n";
        //    _PricingSwapHead += "     , 'ExchangeNotionalEnd'          = PS.exchangenotionalend\n";
        //    _PricingSwapHead += "     , 'SetPricing'                   = PS.setpricing\n";
        //    _PricingSwapHead += "     , 'Comment'                      = PS.comment\n";
        //    _PricingSwapHead += "     , 'UserCreator'                  = PS.usercreator\n";
        //    _PricingSwapHead += "     , 'UserNick'                     = UT.nick\n";
        //    _PricingSwapHead += "     , 'UserName'                     = UT.name\n";
        //    _PricingSwapHead += "     , 'Status'                       = PS.status\n";
        //    _PricingSwapHead += "  FROM dbo.PricingSwap                PS\n";
        //    _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CP   ON PS.currencyprimary   = CP.ID\n";
        //    _PricingSwapHead += "       INNER JOIN dbo.tblRate         RP   ON PS.rateprimary       = RP.ID\n";
        //    _PricingSwapHead += "       INNER JOIN dbo.tblCurrency     CS   ON PS.currencysecondary = CS.ID\n";
        //    _PricingSwapHead += "       INNER JOIN dbo.tblRate         RS   ON PS.ratesecondary     = RS.ID\n";
        //    _PricingSwapHead += "       INNER JOIN dbo.usertable       UT   ON PS.usercreator       = UT.id\n";
        //    _PricingSwapHead += " WHERE PS.id                          = {0}\n";

        //    _PricingSwapHead = string.Format(_PricingSwapHead, id.ToString());

        //    #endregion

        //    #region "Ejecución del Query"

        //    try
        //    {
        //        _Connect.Execute("TURING", _PricingSwapHead, "PricingSwapHead");
        //        _DTPricingSwapHead = _Connect.Table;
        //    }
        //    catch (Exception _Error)
        //    {
        //        _DTPricingSwapHead = null;
        //        Error = new StructError(_Error);
        //        Status = enumStatus.ErrorExecuting;
        //    }
        //    finally
        //    {
        //        _Connect.Close();
        //        _Connect = null;
        //    }

        //    #endregion

        //    return _DTPricingSwapHead;

        //}

        //public DataTable LoadLeg(long id)
        //{

        //    #region "Definición de Variables"

        //    Turing2009Connect.Connect _Connect;
        //    DataTable _DTPricingSwapLeg;
        //    string _PricingSwapLeg;

        //    #endregion

        //    #region "Inicialización de Variables"

        //    _Connect = new Turing2009Connect.Connect();
        //    _Connect.QueryType = enumQueryType.Load;

        //    _DTPricingSwapLeg = new DataTable();

        //    _PricingSwapLeg = "";

        //    #endregion

        //    #region "Query"

        //    _PricingSwapLeg += "SELECT 'ID'                          = id\n";
        //    _PricingSwapLeg += "     , 'DataID'                      = dataid\n";
        //    _PricingSwapLeg += "     , 'LegID'                       = legid\n";
        //    _PricingSwapLeg += "     , 'CurrencyID'                  = currencyid\n";
        //    _PricingSwapLeg += "     , 'Amount'                      = amount\n";
        //    _PricingSwapLeg += "     , 'Parity'                      = parity\n";
        //    _PricingSwapLeg += "     , 'ExchangeRate'                = exchangerate\n";
        //    _PricingSwapLeg += "     , 'StartinDdate'                = startingdate\n";
        //    _PricingSwapLeg += "     , 'ExpiryDate'                  = expirydate\n";
        //    _PricingSwapLeg += "     , 'Convention'                  = convention\n";
        //    _PricingSwapLeg += "     , 'RateID'                      = rateid\n";
        //    _PricingSwapLeg += "     , 'Factor'                      = factor\n";
        //    _PricingSwapLeg += "     , 'Rate'                        = rate\n";
        //    _PricingSwapLeg += "     , 'Spread'                      = spread\n";
        //    _PricingSwapLeg += "     , 'DevelopmentTable'            = developmenttable\n";
        //    _PricingSwapLeg += "     , 'IntervaleType'               = intervaletype\n";
        //    _PricingSwapLeg += "     , 'BrokenPeriod'                = brokenperiod\n";
        //    _PricingSwapLeg += "     , 'PaymentCurrency'             = paymentcurrency\n";
        //    _PricingSwapLeg += "     , 'MarkToMarketUM'              = marktomarketum\n";
        //    _PricingSwapLeg += "     , 'MarkToMarketCLP'             = marktomarketclp\n";
        //    _PricingSwapLeg += "     , 'SpreadDistribution'          = spreaddistribution\n";
        //    _PricingSwapLeg += "     , 'MarkToMarketDistributionUM'  = marktomarketdistributionum\n";
        //    _PricingSwapLeg += "     , 'MarkToMarketDistributionCLP' = marktomarketdistributionclp\n";
        //    _PricingSwapLeg += "     , 'BackwardnessStartNumber'     = backwardnessstartnumber\n";
        //    _PricingSwapLeg += "     , 'BackwardnessStartType'       = backwardnessstarttype\n";
        //    _PricingSwapLeg += "     , 'IntervalCalendarSantiago'    = intervalcalendarsantiago\n";
        //    _PricingSwapLeg += "     , 'IntervalCalendarNewYork'     = intervalcalendarnewyork\n";
        //    _PricingSwapLeg += "     , 'IntervalCalendarLondres'     = intervalcalendarlondres\n";
        //    _PricingSwapLeg += "     , 'PaymentNumber'               = paymentnumber\n";
        //    _PricingSwapLeg += "     , 'PaymentType'                 = paymenttype\n";
        //    _PricingSwapLeg += "     , 'PaymentDate'                 = paymentdate\n";
        //    _PricingSwapLeg += "     , 'PaymentCalendarSantiago'     = paymentcalendarsantiago\n";
        //    _PricingSwapLeg += "     , 'PaymentCalendarNewYork'      = paymentcalendarnewyork\n";
        //    _PricingSwapLeg += "     , 'PaymentCalendarLondres'      = paymentcalendarlondres\n";
        //    _PricingSwapLeg += "     , 'FixingNumber'                = fixingnumber\n";
        //    _PricingSwapLeg += "     , 'FixingType'                  = fixingtype\n";
        //    _PricingSwapLeg += "     , 'FixingDate'                  = fixingdate\n";
        //    _PricingSwapLeg += "     , 'FixingCalendarSantiago'      = fixingcalendarsantiago\n";
        //    _PricingSwapLeg += "     , 'FixingCalendarNewYork'       = fixingcalendarnewyork\n";
        //    _PricingSwapLeg += "     , 'FixingCalendarLondres'       = fixingcalendarlondres\n";
        //    _PricingSwapLeg += "     , 'ConventionCalendar'          = conventioncalendar\n";
        //    _PricingSwapLeg += "     , 'YieldProject'                = yieldproject\n";
        //    _PricingSwapLeg += "     , 'YieldDiscount'               = yielddiscount\n";
        //    _PricingSwapLeg += "  FROM dbo.PricingSwapLeg\n";
        //    _PricingSwapLeg += " WHERE dataid                        = {0}\n";

        //    _PricingSwapLeg = string.Format(_PricingSwapLeg, id);

        //    #endregion

        //    #region "Ejecución del Query"

        //    try
        //    {
        //        _Connect.Execute("TURING", _PricingSwapLeg, "PricingSwapLeg");
        //        _DTPricingSwapLeg = _Connect.Table;
        //    }
        //    catch (Exception _Error)
        //    {
        //        _DTPricingSwapLeg = null;
        //        Error = new StructError(_Error);
        //        Status = enumStatus.ErrorExecuting;
        //    }
        //    finally
        //    {
        //        _Connect.Close();
        //        _Connect = null;
        //    }

        //    #endregion

        //    return _DTPricingSwapLeg;

        //}

        //public DataTable LoadFlow(long id)
        //{

        //    #region "Definición de Variables"

        //    Turing2009Connect.Connect _Connect;
        //    DataTable _DTPricingSwapFlow;
        //    string _PricingSwapFlow;

        //    #endregion

        //    #region "Inicialización de Variables"

        //    _Connect = new Turing2009Connect.Connect();
        //    _Connect.QueryType = enumQueryType.Load;

        //    _DTPricingSwapFlow = new DataTable();

        //    _PricingSwapFlow = "";

        //    #endregion

        //    #region "Query"

        //    _PricingSwapFlow += "SELECT 'ID'                        = id\n";
        //    _PricingSwapFlow += "     , 'DataID'                    = dataid\n";
        //    _PricingSwapFlow += "     , 'LegID'                     = legid\n";
        //    _PricingSwapFlow += "     , 'FlowID'                    = flowid\n";
        //    _PricingSwapFlow += "     , 'FixingDate'                = fixingdate\n";
        //    _PricingSwapFlow += "     , 'StartingDate'              = startingdate\n";
        //    _PricingSwapFlow += "     , 'ExpiryDate'                = expirydate\n";
        //    _PricingSwapFlow += "     , 'PaymentDate'               = paymentdate\n";
        //    _PricingSwapFlow += "     , 'Balance'                   = balance\n";
        //    _PricingSwapFlow += "     , 'ExchangePrincipal'         = exchangeprincipal\n";
        //    _PricingSwapFlow += "     , 'PostPounding'              = postpounding\n";
        //    _PricingSwapFlow += "     , 'Rate'                      = rate\n";
        //    _PricingSwapFlow += "     , 'Spread'                    = spread\n";
        //    _PricingSwapFlow += "     , 'AmortizationFlow'          = amortizationflow\n";
        //    _PricingSwapFlow += "     , 'InterestFlow'              = interestflow\n";
        //    _PricingSwapFlow += "     , 'AditionalFlow'             = aditionalflow\n";
        //    _PricingSwapFlow += "     , 'TotalFlow'                 = totalflow\n";
        //    _PricingSwapFlow += "     , 'RateDiscount'              = ratediscount\n";
        //    _PricingSwapFlow += "     , 'WellFactor'                = wellfactor\n";
        //    _PricingSwapFlow += "     , 'AmortizationPresentValue'  = amortizationpresentvalue\n";
        //    _PricingSwapFlow += "     , 'InterestPresentValue'      = interestpresentvalue\n";
        //    _PricingSwapFlow += "     , 'AditionalFlowPresentValue' = aditionalflowpresentvalue\n";
        //    _PricingSwapFlow += "     , 'PresentValue'              = presentvalue\n";
        //    _PricingSwapFlow += "  FROM dbo.PricingSwapFlow\n";
        //    _PricingSwapFlow += " WHERE dataid                      = {0}\n";

        //    _PricingSwapFlow = string.Format(_PricingSwapFlow, id);

        //    #endregion

        //    #region "Ejecución del Query"

        //    try
        //    {
        //        _Connect.Execute("TURING", _PricingSwapFlow, "PricingSwapFlow");
        //        _DTPricingSwapFlow = _Connect.Table;
        //    }
        //    catch (Exception _Error)
        //    {
        //        _DTPricingSwapFlow = null;
        //        Error = new StructError(_Error);
        //        Status = enumStatus.ErrorExecuting;
        //    }
        //    finally
        //    {
        //        _Connect.Close();
        //        _Connect = null;
        //    }

        //    #endregion

        //    return _DTPricingSwapFlow;

        //}

        //public DataTable LoadRealTime(long id)
        //{

        //    #region "Definición de Variables"

        //    Turing2009Connect.Connect _Connect;
        //    DataTable _DTPricingSwapRealTime;
        //    string _PricingSwapRealTime;

        //    #endregion

        //    #region "Inicialización de Variables"

        //    _Connect = new Turing2009Connect.Connect();
        //    _Connect.QueryType = enumQueryType.Load;

        //    _DTPricingSwapRealTime = new DataTable();

        //    _PricingSwapRealTime = "";

        //    #endregion

        //    #region "Query"

        //    _PricingSwapRealTime += "SELECT 'ID'          = PSER.exchangerateid\n";
        //    _PricingSwapRealTime += "     , 'Description' = ER.description\n";
        //    _PricingSwapRealTime += "     , 'ValueBid'    = PSER.bid\n";
        //    _PricingSwapRealTime += "     , 'ValueOffer'  = PSER.offer\n";
        //    _PricingSwapRealTime += "     , 'ValueMid'    = PSER.middle\n";
        //    _PricingSwapRealTime += "  FROM dbo.pricingswapexchangerate     PSER\n";
        //    _PricingSwapRealTime += "       INNER JOIN dbo.tblExchangeRate  ER   ON PSER.exchangerateid = ER.id\n";
        //    _PricingSwapRealTime += " WHERE dataID = {0}\n";

        //    _PricingSwapRealTime = string.Format(_PricingSwapRealTime, id);

        //    #endregion

        //    #region "Ejecución del Query"

        //    try
        //    {
        //        _Connect.Execute("TURING", _PricingSwapRealTime, "PricingSwapRealTime");
        //        _DTPricingSwapRealTime = _Connect.Table;
        //    }
        //    catch (Exception _Error)
        //    {
        //        _DTPricingSwapRealTime = null;
        //        Error = new StructError(_Error);
        //        Status = enumStatus.ErrorExecuting;
        //    }
        //    finally
        //    {
        //        _Connect.Close();
        //        _Connect = null;
        //    }

        //    #endregion

        //    return _DTPricingSwapRealTime;


        //}

    }

}
