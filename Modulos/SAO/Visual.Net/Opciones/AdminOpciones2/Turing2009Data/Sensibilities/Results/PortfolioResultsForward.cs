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

    public class PortfolioResultsForward : InterfaceQuery
    {

        public DataTable Load(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTForward;
            string _Forward;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTForward = new DataTable();

            _Forward = "";

            #endregion

            #region "Query Forward"

            _Forward += "SET NOCOUNT ON\n\n";

            _Forward += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _Forward += "     , 'EffectRate'              = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                             THEN SF.marktomarketvalueeffectrate - SF.marktomarketvalueyesterday\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'TimeDecay'               = SUM( CASE WHEN SD.expirydate                  = SD.sensibilitiesdate THEN 0\n";
            _Forward += "                                             WHEN SF.ContractDate                = SD.sensibilitiesdate THEN 0\n";
            _Forward += "                                             WHEN SF.marktomarketvaluetimedecay <> 0                    THEN SF.marktomarketvaluetimedecay - SF.marktomarketvalueyesterday\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'ExchangeRate'            = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                              AND SF.marktomarketvalueexchangerate <> 0 THEN SF.marktomarketvalueexchangerate - SF.marktomarketvalueyesterday\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND OperationType = 'C'\n";
            _Forward += "                                                  THEN SF.fairvalueassetyesterdayum\n";
            _Forward += "                                             WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND OperationType = 'V'\n";
            _Forward += "                                                  THEN SF.fairvalueliabilitiesyesterdayum\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND OperationType = 'V'\n";
            _Forward += "                                                  THEN -SF.fairvalueliabilitiesyesterdayum\n";
            _Forward += "                                             WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND OperationType = 'C'\n";
            _Forward += "                                                  THEN -SF.fairvalueliabilitiesyesterdayum\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _Forward += "     , 'New'                     = SUM( CASE WHEN SF.ContractDate = SD.sensibilitiesdate THEN SF.marktomarketvaluetoday - SF.marktomarketvalueyesterday\n";
            _Forward += "                                                                                          ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'Expiry'                  = SUM( CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SF.cashflow * -1\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'CashFlowByDistribution'  = SUM( CASE WHEN SD.ExpiryDate = SD.sensibilitiesdate\n";
            _Forward += "                                             THEN SF.primaryamount * (CASE WHEN SF.operationtype = 'C' THEN 1 ELSE -1 END) * \n";
            _Forward += "                                                 (SF.pricepointforward - (SF.priceforward * CASE secondcurrencyid WHEN 998 THEN currencyvaluetoday ELSE 1 END))\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'CashFlowByPoint'         = SUM( CASE WHEN SD.ExpiryDate = SD.sensibilitiesdate\n";
            _Forward += "                                             THEN SF.primaryamount * (CASE WHEN SF.operationtype = 'C' THEN 1 ELSE -1 END) * (SF.pricecost - SF.pricepointforward + SF.advancepointcost)\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'CashFlowByExchange'      = CAST( 0 AS FLOAT )\n";
            _Forward += "     , 'CashFlow'                = SUM( cashflow )\n";
            _Forward += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _Forward += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _Forward += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _Forward += "     , 'Total'                   = SUM( SF.marktomarketvaluetoday - SF.marktomarketvalueyesterday )\n";
            _Forward += "     , 'Estimation'              = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SD.estimationvalue END )\n";
            _Forward += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _Forward += "     , 'Distribution'            = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate and SF.UnWind <> 'A'\n";
            _Forward += "                                             THEN SF.transferdistribution\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'RateNew'                 = SUM( CASE WHEN SF.ContractDate = SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _Forward += "                                             THEN SF.marktomarketvalueeffectrate - SF.marktomarketvalueyesterday - SF.transferdistribution\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'ExchangerateNew'         = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate and SF.UnWind <> 'A'\n";
            _Forward += "                                              AND SF.marktomarketvalueexchangerate <> 0 THEN SF.marktomarketvalueexchangerate - SF.marktomarketvalueyesterday\n";
            _Forward += "                                             ELSE 0\n";
            _Forward += "                                        END\n";
            _Forward += "                                      )\n";
            _Forward += "     , 'MarktoMarketSpot'        = SUM( 0 ) -- marktomarketeffectrate - SF.marktomarketvaluetoday )\n";
            _Forward += "     , 'CostCarry'               = SUM( carrycostvalue )\n";
            _Forward += "  INTO #tmpResultado\n";
            _Forward += "  FROM dbo.SensibilitiesData                SD\n";
            _Forward += "       INNER JOIN dbo.SensibilitiesForward  SF  ON SD.id                = SF.id\n";
            _Forward += "       INNER JOIN dbo.ExchangeValue         EV  ON EV.currencydate      = SD.sensibilitiesdate\n";
            _Forward += "                                               AND EV.currencyid        = 998\n";
            _Forward += " WHERE SD.system                  = 'BFW'\n";
            _Forward += "   AND SD.productid              <> '10'\n";

            if (!conditions.Equals(""))
            {
                _Forward += " AND (" + conditions + ")\n";
            }

            _Forward += " GROUP BY\n";
            _Forward += "       SD.sensibilitiesdate\n\n";

            _Forward += "UPDATE #tmpResultado\n";
            _Forward += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
            _Forward += "  FROM dbo.ExchangeValue\n";
            _Forward += " WHERE currencydate = [Date]\n";
            _Forward += "   AND currencyid   = 998\n\n";

            _Forward += "UPDATE #tmpResultado\n";
            _Forward += "   SET ExchangeRate = ExchangeRate - Readjustment\n\n";

            _Forward += "UPDATE #tmpResultado\n";
            _Forward += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _Forward += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _Forward += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _Forward += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n";
            _Forward += "     , CashFlowByExchange      = CashFlow - (CashFlowByPoint + CashFlowByDistribution)\n\n";

            _Forward += "SELECT [Date]\n";
            _Forward += "     , EffectRate\n";
            _Forward += "     , TimeDecay\n";
            _Forward += "     , ExchangeRate\n";
            _Forward += "     , Readjustment\n";
            _Forward += "     , New\n";
            _Forward += "     , Expiry\n";
            _Forward += "     , CashFlowByPoint\n";
            _Forward += "     , CashFlowByDistribution\n";
            _Forward += "     , CashFlowByExchange\n";
            _Forward += "     , CashFlow\n";
            _Forward += "     , SubTotalNotExchangeRate\n";
            _Forward += "     , SubTotalExchangeRate\n";
            _Forward += "     , SubTotalEffect\n";
            _Forward += "     , Total\n";
            _Forward += "     , Estimation\n";
            _Forward += "     , Ratio\n";
            _Forward += "     , Distribution\n";
            _Forward += "     , RateNew\n";
            _Forward += "     , ExchangerateNew\n";
            _Forward += "     , MarktoMarketSpot\n";
            _Forward += "     , CostCarry\n";
            _Forward += "  FROM #tmpResultado\n";
            _Forward += " ORDER BY\n";
            _Forward += "       [Date]\n\n";

            _Forward += "DROP TABLE #tmpResultado\n";

            _Forward += "SET NOCOUNT OFF\n\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Forward, "ResultsForward");
                _DTForward = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTForward = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTForward;

        }

    }

}
