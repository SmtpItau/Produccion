using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Sensibilities.Results
{

    public class PortFolioResultsSwap : InterfaceQuery
    {

        public DataTable Load(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTSwap;
            string _Swap;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTSwap = new DataTable();

            _Swap = "";

            #endregion

            #region "Query Swap"

            _Swap += "SET NOCOUNT ON\n\n";

            _Swap += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _Swap += "     , 'EffectRate'              = SUM( CASE WHEN SW.status = 'N' THEN 0\n";
            _Swap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Swap += "                                             THEN SW.marktomarketvalueeffectrate - SW.marktomarketvalueyesterday\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'TimeDecay'               = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _Swap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN 0\n";
            _Swap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN 0\n";
            _Swap += "                                             WHEN (SW.ContractDate               <> SD.sensibilitiesdate\n";
            _Swap += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
            _Swap += "                                              AND  SW.marktomarketvaluetimedecay <> 0\n";
            _Swap += "                                                  THEN SW.marktomarketvaluetimedecay - SW.marktomarketvalueyesterday\n";
            _Swap += "                                                  ELSE 0\n";
            _Swap += "                                        END +\n";
            _Swap += "                                        CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _Swap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN 0\n";
            _Swap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN 0\n";
            _Swap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN SW.cashflow\n";
            _Swap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN SW.cashflow\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'ExchangeRateAsset'       = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _Swap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Swap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid <> 998 AND SD.primarycurrencyid <> 999 THEN SW.exchangerateasset - SW.fairvalueassetyesterday\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'ExchangeRateLiabilities' = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _Swap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Swap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid <> 998 AND SD.secondcurrencyid <> 999 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'ExchangeRate'            = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _Swap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Swap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND SD.primaryrateid <> 13\n";
            _Swap += "                                             THEN SW.exchangerateasset - SW.fairvalueassetyesterday\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _Swap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Swap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND SD.secondrateid <> 13\n";
            _Swap += "                                             THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'New'                     = SUM( CASE WHEN SW.ContractDate = SD.sensibilitiesdate THEN SW.marktomarketvaluetoday - SW.marktomarketvalueyesterday\n";
            _Swap += "                                                                                         ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'Expiry'                  = SUM( CASE WHEN SW.status                      = 'N'                  THEN -SW.marktomarketvalueyesterday\n";
            _Swap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN SW.cashflow * -1\n";
            _Swap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN SW.cashflow * -1\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "                                      )\n";
            _Swap += "     , 'CashFlow'                = SUM( cashflow )\n";
            _Swap += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'Total'                   = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'MarktoMarketToday'       = SUM( SW.marktomarketvaluetoday )\n";
            _Swap += "     , 'MarktoMarketYesterday'   = SUM( SW.marktomarketvalueyesterday )\n";
            _Swap += "     , 'Estimation'              = SUM( CASE WHEN SW.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SD.estimationvalue END )\n";
            _Swap += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'SubTotal'                = CAST( 0 AS FLOAT )\n";
            _Swap += "     , 'DeltaMTMYesterday'       = SUM( CASE WHEN SW.contractdate <> SD.sensibilitiesdate THEN SW.fairvaluenetportfolioyesterday - SW.fairvaluenetyesterday ELSE 0 END )\n";
            _Swap += "  INTO #tmpResultado\n";
            _Swap += "  FROM dbo.SensibilitiesData             SD\n";
            _Swap += "       INNER JOIN dbo.SensibilitiesSwap  SW  ON SD.id                = SW.id\n";
            _Swap += " WHERE SD.system                  = 'PCS'\n";

            if (!conditions.Equals(""))
            {
                _Swap += " AND (" + conditions + ")\n";
            }

            _Swap += " GROUP BY\n";
            _Swap += "       SD.sensibilitiesdate\n\n";

            _Swap += "SELECT 'DateProcessToday'     = SS.portfoliotoday\n";
            _Swap += "     , 'DatePorcessYesterday' = SS.portfolioyesterday\n";
            _Swap += "     , 'DatePorcessTomorrow'  = SS.portfoliotomorrow\n";
            _Swap += "     , 'MarktoMarket'         = R.MarktoMarketToday\n";
            _Swap += "  INTO #tmpDate\n";
            _Swap += "  FROM #tmpResultado R\n";
            _Swap += "       INNER JOIN dbo.StatusSystem SS ON R.Date = SS.datestatus\n\n";

            _Swap += "UPDATE #tmpResultado\n";
            _Swap += "   SET MarktoMarketYesterday  = D.MarktoMarket\n";
            _Swap += "     , Total                  = MarktoMarketToday - D.MarktoMarket\n";
            _Swap += "  FROM #tmpDate D\n";
            _Swap += " WHERE D.DatePorcessTomorrow  = Date\n\n";


            _Swap += "UPDATE #tmpResultado\n";
            _Swap += "   SET Readjustment = ReadjustmentAsset + ReadjustmentLiabilities\n";
            _Swap += "     , ExchangeRate = ExchangeRateAsset + ExchangeRateLiabilities\n";
            _Swap += "  FROM dbo.ExchangeValue\n";
            _Swap += " WHERE currencydate = [Date]\n";
            _Swap += "   AND currencyid   = 998\n\n";

            _Swap += "UPDATE #tmpResultado\n";
            _Swap += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _Swap += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _Swap += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _Swap += "     , SubTotal                = Total + CashFlow + New + Expiry - ExchangeRate\n";
            _Swap += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

            _Swap += "SELECT [Date]\n";
            _Swap += "     , EffectRate\n";
            _Swap += "     , TimeDecay\n";
            _Swap += "     , ExchangeRate\n";
            _Swap += "     , Readjustment\n";
            _Swap += "     , New\n";
            _Swap += "     , Expiry\n";
            _Swap += "     , CashFlow\n";
            _Swap += "     , SubTotalNotExchangeRate\n";
            _Swap += "     , SubTotalExchangeRate\n";
            _Swap += "     , SubTotalEffect\n";
            _Swap += "     , Total\n";
            _Swap += "     , MarktoMarketToday\n";
            _Swap += "     , MarktoMarketYesterday\n";
            _Swap += "     , SubTotal\n";
            _Swap += "     , Estimation\n";
            _Swap += "     , Ratio\n";
            _Swap += "     , DeltaMTMYesterday\n";
            _Swap += "  FROM #tmpResultado\n";
            _Swap += " ORDER BY\n";
            _Swap += "       [Date]\n\n";

            _Swap += "DROP TABLE #tmpResultado\n";
            _Swap += "DROP TABLE #tmpDate\n\n";

            _Swap += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Swap, "ResultsSwap");
                _DTSwap = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTSwap = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTSwap;

        }


    }

}
