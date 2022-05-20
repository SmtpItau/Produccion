using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using cConnectionDB;

namespace cData.Turing2009.PortfolioResults
{
    public static  class ResultsPortfolio
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        //public ResultsPortfolio() { }


        public static DataTable LoadReportMonthlyResultFixingRate(string conditions)
        {

            String _QueryFixingRate = "";

            #region "Query Fixing Rate"

            _QueryFixingRate += "SET NOCOUNT ON\n\n";

            _QueryFixingRate += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
            _QueryFixingRate += "     , 'DocumentNumber'                = SY.documentnumber\n";
            _QueryFixingRate += "     , 'OperationNumber'               = SY.operationnumber\n";
            _QueryFixingRate += "     , 'OperationID'                   = SY.operationid\n";
            _QueryFixingRate += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
            _QueryFixingRate += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
            _QueryFixingRate += "  INTO #tmpSensibilities\n";
            _QueryFixingRate += "  FROM dbo.SensibilitiesYield SY\n";
            _QueryFixingRate += " WHERE SY.system                       = 'BTR'\n";
            _QueryFixingRate += " GROUP BY\n";
            _QueryFixingRate += "       SY.sensibilitiesdate\n";
            _QueryFixingRate += "     , SY.DocumentNumber\n";
            _QueryFixingRate += "     , SY.OperationNumber\n";
            _QueryFixingRate += "     , SY.OperationID\n\n";

            _QueryFixingRate += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _QueryFixingRate += "     , 'EffectRate'              = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryFixingRate += "                                             THEN SFR.marktomarketvalueeffectrate - SFR.marktomarketvalueyesterday\n";
            _QueryFixingRate += "                                             ELSE 0\n";
            _QueryFixingRate += "                                        END\n";
            _QueryFixingRate += "                                      )\n";
            _QueryFixingRate += "     , 'TimeDecay'               = SUM( CASE WHEN (SFR.ContractDate               <> SD.sensibilitiesdate\n";
            _QueryFixingRate += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
            _QueryFixingRate += "                                              AND  SFR.marktomarketvaluetimedecay <> 0\n";
            _QueryFixingRate += "                                             THEN SFR.marktomarketvaluetimedecay - SFR.marktomarketvalueyesterday\n";
            _QueryFixingRate += "                                             ELSE 0\n";
            _QueryFixingRate += "                                        END +\n";
            _QueryFixingRate += "                                        CASE WHEN SFR.courtdatecoupon        = SD.sensibilitiesdate THEN SFR.cashflow\n";
            _QueryFixingRate += "                                             ELSE 0\n";
            _QueryFixingRate += "                                        END\n";
            _QueryFixingRate += "                                      )\n";
            _QueryFixingRate += "     , 'ExchangeRate'            = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate  AND  SFR.currencyissue <> 998\n";
            _QueryFixingRate += "                                              AND SFR.marktomarketvalueexchangerate <> 0 THEN SFR.marktomarketvalueexchangerate - SFR.marktomarketvalueyesterday\n";
            _QueryFixingRate += "                                             ELSE 0\n";
            _QueryFixingRate += "                                        END\n";
            _QueryFixingRate += "                                      )\n";
            _QueryFixingRate += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate  AND  SFR.currencyissue = 998\n";
            _QueryFixingRate += "                                              AND SFR.marktomarketvalueexchangerate <> 0 THEN SFR.marktomarketvalueyesterdayum\n";
            _QueryFixingRate += "                                             ELSE 0\n";
            _QueryFixingRate += "                                        END\n";
            _QueryFixingRate += "                                      )\n";
            _QueryFixingRate += "     , 'ReadjustmentLiabilities' = CAST( 0 AS FLOAT )\n";
            _QueryFixingRate += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _QueryFixingRate += "     , 'New'                     = SUM( CASE WHEN SFR.ContractDate = SD.sensibilitiesdate THEN SFR.marktomarketvaluetoday - SFR.marktomarketvalueyesterday\n";
            _QueryFixingRate += "                                                                                          ELSE 0\n";
            _QueryFixingRate += "                                        END\n";
            _QueryFixingRate += "                                      )\n";
            _QueryFixingRate += "     , 'Expiry'                  = SUM( CASE WHEN SFR.courtdatecoupon        = SD.sensibilitiesdate THEN SFR.cashflow * -1\n";
            _QueryFixingRate += "                                             ELSE 0\n";
            _QueryFixingRate += "                                        END\n";
            _QueryFixingRate += "                                      )\n";
            _QueryFixingRate += "     , 'CashFlow'                = SUM( cashflow )\n";
            _QueryFixingRate += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _QueryFixingRate += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _QueryFixingRate += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _QueryFixingRate += "     , 'Total'                   = SUM( SFR.marktomarketvaluetoday - SFR.marktomarketvalueyesterday )\n";
            _QueryFixingRate += "     , 'Estimation'              = SUM( CASE WHEN SFR.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
            _QueryFixingRate += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _QueryFixingRate += "     , 'Accrual'                 = SUM( SFR.dailyinterestsystem + SFR.dailyadjustmentsystem )\n";
            _QueryFixingRate += "     , 'CarryCost'               = SUM( SFR.CorryCost )\n";
            _QueryFixingRate += "     , 'AVR'                     = SUM( CASE WHEN SFR.SalesValue <> 0\n";
            _QueryFixingRate += "                                             THEN 0\n";
            _QueryFixingRate += "                                             ELSE (SFR.marktomarketvaluetoday - SFR.presentvaluetoday) - (SFR.marktomarketvalueyesterday - SFR.presentvalueyesterday)\n";
            _QueryFixingRate += "                                        END )\n";
            _QueryFixingRate += "     , 'PriceDifference'         = SUM( CASE WHEN SFR.SalesValue = 0 THEN 0 ELSE SFR.SalesValue - SFR.presentvaluetoday END )\n";
            _QueryFixingRate += "  INTO #tmpResultado\n";
            _QueryFixingRate += "  FROM dbo.SensibilitiesData             SD\n";
            _QueryFixingRate += "       INNER JOIN dbo.SensibilitiesFixingRate  SFR  ON SD.id                = SFR.id\n";
            _QueryFixingRate += "       INNER JOIN #tmpSensibilities            SY   ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
            _QueryFixingRate += "                                                   AND SD.DocumentNumber    = SY.DocumentNumber\n";
            _QueryFixingRate += "                                                   AND SD.OperationNumber   = SY.OperationNumber\n";
            _QueryFixingRate += "                                                   AND SD.OperationID       = SY.OperationID\n";
            _QueryFixingRate += " WHERE SD.system                  = 'BTR'\n";

            if (!conditions.Equals(""))
            {
                _QueryFixingRate += " AND (" + conditions + ")\n";
            }

            _QueryFixingRate += " GROUP BY\n";
            _QueryFixingRate += "       SD.sensibilitiesdate\n\n";

            _QueryFixingRate += "UPDATE #tmpResultado\n";
            _QueryFixingRate += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
            _QueryFixingRate += "  FROM dbo.ExchangeValue\n";
            _QueryFixingRate += " WHERE currencydate = [Date]\n";
            _QueryFixingRate += "   AND currencyid   = 998\n\n";

            _QueryFixingRate += "UPDATE #tmpResultado\n";
            _QueryFixingRate += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _QueryFixingRate += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _QueryFixingRate += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _QueryFixingRate += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

            _QueryFixingRate += "SELECT [Date]\n";
            _QueryFixingRate += "     , EffectRate\n";
            _QueryFixingRate += "     , TimeDecay\n";
            _QueryFixingRate += "     , ExchangeRate\n";
            _QueryFixingRate += "     , Readjustment\n";
            _QueryFixingRate += "     , New\n";
            _QueryFixingRate += "     , Expiry\n";
            _QueryFixingRate += "     , CashFlow\n";
            _QueryFixingRate += "     , SubTotalNotExchangeRate\n";
            _QueryFixingRate += "     , SubTotalExchangeRate\n";
            _QueryFixingRate += "     , SubTotalEffect\n";
            _QueryFixingRate += "     , Total\n";
            _QueryFixingRate += "     , Estimation\n";
            _QueryFixingRate += "     , Ratio\n";
            _QueryFixingRate += "     , Accrual\n";
            _QueryFixingRate += "     , CarryCost\n";
            _QueryFixingRate += "     , AVR\n";
            _QueryFixingRate += "     , PriceDifference\n";
            _QueryFixingRate += "  FROM #tmpResultado\n";
            _QueryFixingRate += " ORDER BY\n";
            _QueryFixingRate += "       [Date]\n\n";

            _QueryFixingRate += "DROP TABLE #tmpResultado\n";
            _QueryFixingRate += "DROP TABLE #tmpSensibilities\n\n";

            _QueryFixingRate += "SET NOCOUNT OFF\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryFixingRate);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "ResultFixingRate";

                if (_PortFolioData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _PortFolioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _PortFolioData;

        }

        public static DataTable LoadReportMonthlyResultForward(string conditions)
        {

            String _QueryForward = "";

            #region "Query Forward"

            _QueryForward += "SET NOCOUNT ON\n\n";

            _QueryForward += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
            _QueryForward += "     , 'OperationNumber'               = SY.operationnumber\n";
            _QueryForward += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
            _QueryForward += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
            _QueryForward += "  INTO #tmpSensibilities\n";
            _QueryForward += "  FROM dbo.SensibilitiesYield SY\n";
            _QueryForward += " WHERE SY.system                       = 'BFW'\n";
            _QueryForward += " GROUP BY\n";
            _QueryForward += "       SY.sensibilitiesdate\n";
            _QueryForward += "     , SY.OperationNumber\n\n";

            _QueryForward += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _QueryForward += "     , 'EffectRate'              = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                             THEN SF.marktomarketvalueeffectrate - SF.marktomarketvalueyesterday\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'TimeDecay'               = SUM( CASE WHEN SD.expirydate                  = SD.sensibilitiesdate THEN 0\n";
            _QueryForward += "                                             WHEN SF.ContractDate                = SD.sensibilitiesdate THEN 0\n";
            _QueryForward += "                                             WHEN SF.marktomarketvaluetimedecay <> 0                    THEN SF.marktomarketvaluetimedecay - SF.marktomarketvalueyesterday\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'ExchangeRate'            = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 THEN SF.marktomarketvalueexchangerate - SF.marktomarketvalueyesterday\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND OperationType = 'C'\n";
            _QueryForward += "                                                  THEN SF.fairvalueassetyesterdayum\n";
            _QueryForward += "                                             WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND OperationType = 'V'\n";
            _QueryForward += "                                                  THEN SF.fairvalueliabilitiesyesterdayum\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND OperationType = 'V'\n";
            _QueryForward += "                                                  THEN -SF.fairvalueliabilitiesyesterdayum\n";
            _QueryForward += "                                             WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND OperationType = 'C'\n";
            _QueryForward += "                                                  THEN -SF.fairvalueliabilitiesyesterdayum\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _QueryForward += "     , 'New'                     = SUM( CASE WHEN SF.ContractDate = SD.sensibilitiesdate THEN SF.marktomarketvaluetoday - SF.marktomarketvalueyesterday\n";
            _QueryForward += "                                                                                          ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'Expiry'                  = SUM( CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SF.cashflow * -1\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'CashFlowByDistribution'  = SUM( CASE WHEN SD.ExpiryDate = SD.sensibilitiesdate\n";
            _QueryForward += "                                             THEN SF.primaryamount * (CASE WHEN SF.operationtype = 'C' THEN 1 ELSE -1 END) * \n";
            _QueryForward += "                                                 (SF.pricepointforward - (SF.priceforward * CASE secondcurrencyid WHEN 998 THEN currencyvaluetoday ELSE 1 END))\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'CashFlowByPoint'         = SUM( CASE WHEN SD.ExpiryDate = SD.sensibilitiesdate\n";
            _QueryForward += "                                             THEN SF.primaryamount * (CASE WHEN SF.operationtype = 'C' THEN 1 ELSE -1 END) * (SF.pricecost - SF.pricepointforward + SF.advancepointcost)\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'CashFlowByExchange'      = CAST( 0 AS FLOAT )\n";
            _QueryForward += "     , 'CashFlow'                = SUM( cashflow )\n";
            _QueryForward += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _QueryForward += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _QueryForward += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _QueryForward += "     , 'Total'                   = SUM( SF.marktomarketvaluetoday - SF.marktomarketvalueyesterday )\n";
            _QueryForward += "     , 'Estimation'              = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
            _QueryForward += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _QueryForward += "     , 'Distribution'            = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate and SF.UnWind <> 'A'\n";
            _QueryForward += "                                             THEN SF.transferdistribution\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'RateNew'                 = SUM( CASE WHEN SF.ContractDate = SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForward += "                                             THEN SF.marktomarketvalueeffectrate - SF.marktomarketvalueyesterday - SF.transferdistribution\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'ExchangerateNew'         = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate and SF.UnWind <> 'A'\n";
            _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 THEN SF.marktomarketvalueexchangerate - SF.marktomarketvalueyesterday\n";
            _QueryForward += "                                             ELSE 0\n";
            _QueryForward += "                                        END\n";
            _QueryForward += "                                      )\n";
            _QueryForward += "     , 'MarktoMarketSpot'        = SUM( 0 ) -- marktomarketeffectrate - SF.marktomarketvaluetoday )\n";
            _QueryForward += "     , 'CostCarry'               = SUM( carrycostvalue )\n";
            _QueryForward += "  INTO #tmpResultado\n";
            _QueryForward += "  FROM dbo.SensibilitiesData                SD\n";
            _QueryForward += "       INNER JOIN dbo.SensibilitiesForward  SF  ON SD.id                = SF.id\n";
            _QueryForward += "       INNER JOIN #tmpSensibilities         SY  ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
            _QueryForward += "                                               AND SD.OperationNumber   = SY.OperationNumber\n";
            _QueryForward += "       INNER JOIN dbo.ExchangeValue         EV  ON EV.currencydate      = SD.sensibilitiesdate\n";
            _QueryForward += "                                               AND EV.currencyid        = 998\n";
            _QueryForward += " WHERE SD.system                  = 'BFW'\n";
            _QueryForward += "   AND SD.productid              <> '10'\n";

            //if (!conditions.Equals(""))
            //{
            //    _QueryForward += " AND (" + conditions + ")\n";
            //}

            _QueryForward += " GROUP BY\n";
            _QueryForward += "       SD.sensibilitiesdate\n\n";

            _QueryForward += "UPDATE #tmpResultado\n";
            _QueryForward += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
            _QueryForward += "  FROM dbo.ExchangeValue\n";
            _QueryForward += " WHERE currencydate = [Date]\n";
            _QueryForward += "   AND currencyid   = 998\n\n";

            _QueryForward += "UPDATE #tmpResultado\n";
            _QueryForward += "   SET ExchangeRate = ExchangeRate - Readjustment\n\n";

            _QueryForward += "UPDATE #tmpResultado\n";
            _QueryForward += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _QueryForward += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _QueryForward += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _QueryForward += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n";
            _QueryForward += "     , CashFlowByExchange      = CashFlow - (CashFlowByPoint + CashFlowByDistribution)\n\n";

            _QueryForward += "SELECT [Date]\n";
            _QueryForward += "     , EffectRate\n";
            _QueryForward += "     , TimeDecay\n";
            _QueryForward += "     , ExchangeRate\n";
            _QueryForward += "     , Readjustment\n";
            _QueryForward += "     , New\n";
            _QueryForward += "     , Expiry\n";
            _QueryForward += "     , CashFlowByPoint\n";
            _QueryForward += "     , CashFlowByDistribution\n";
            _QueryForward += "     , CashFlowByExchange\n";
            _QueryForward += "     , CashFlow\n";
            _QueryForward += "     , SubTotalNotExchangeRate\n";
            _QueryForward += "     , SubTotalExchangeRate\n";
            _QueryForward += "     , SubTotalEffect\n";
            _QueryForward += "     , Total\n";
            _QueryForward += "     , Estimation\n";
            _QueryForward += "     , Ratio\n";
            _QueryForward += "     , Distribution\n";
            _QueryForward += "     , RateNew\n";
            _QueryForward += "     , ExchangerateNew\n";
            _QueryForward += "     , MarktoMarketSpot\n";
            _QueryForward += "     , CostCarry\n";
            _QueryForward += "  FROM #tmpResultado\n";
            _QueryForward += " ORDER BY\n";
            _QueryForward += "       [Date]\n\n";

            _QueryForward += "DROP TABLE #tmpResultado\n";
            _QueryForward += "DROP TABLE #tmpSensibilities\n\n";

            _QueryForward += "SET NOCOUNT OFF\n\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryForward);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "ResultForward";

                if (_PortFolioData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _PortFolioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _PortFolioData;

        }

        public static DataTable LoadReportMonthlyResultForwardBondsTrader(string conditions)
        {

            String _QueryForwardBondsTrader = "";

            #region "Query Forward Bonds Traders"

            _QueryForwardBondsTrader += "SET NOCOUNT ON\n\n";

            _QueryForwardBondsTrader += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "     , 'OperationNumber'               = SY.operationnumber\n";
            _QueryForwardBondsTrader += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
            _QueryForwardBondsTrader += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
            _QueryForwardBondsTrader += "  INTO #tmpSensibilities\n";
            _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesYield SY\n";
            _QueryForwardBondsTrader += " WHERE SY.system                       = 'BFW'\n";
            _QueryForwardBondsTrader += " GROUP BY\n";
            _QueryForwardBondsTrader += "       SY.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "     , SY.OperationNumber\n\n";

            _QueryForwardBondsTrader += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "     , 'EffectRate'              = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "                                             THEN SFBT.marktomarketvalueeffectrate - SFBT.marktomarketvalueyesterday\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'TimeDecay'               = SUM( CASE WHEN (SFBT.ContractDate               <> SD.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
            _QueryForwardBondsTrader += "                                              AND  SFBT.marktomarketvaluetimedecay <> 0\n";
            _QueryForwardBondsTrader += "                                             THEN SFBT.marktomarketvaluetimedecay - SFBT.marktomarketvalueyesterday\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END +\n";
            _QueryForwardBondsTrader += "                                        CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SFBT.cashflow\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'ExchangeRate'            = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "                                              AND SFBT.marktomarketvalueexchangerate <> 0 THEN SFBT.marktomarketvalueexchangerate - SFBT.marktomarketvalueyesterday\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QueryForwardBondsTrader += "                                              AND SFBT.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 THEN SFBT.marktomarketvalueyesterdayum\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SFBT.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 THEN -SFBT.marktomarketvalueyesterdayum\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _QueryForwardBondsTrader += "     , 'New'                     = SUM( CASE WHEN SFBT.ContractDate = SD.sensibilitiesdate THEN SFBT.marktomarketvaluetoday - SFBT.marktomarketvalueyesterday\n";
            _QueryForwardBondsTrader += "                                                                                           ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'Expiry'                  = SUM( CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SFBT.cashflow * -1\n";
            _QueryForwardBondsTrader += "                                             ELSE 0\n";
            _QueryForwardBondsTrader += "                                        END\n";
            _QueryForwardBondsTrader += "                                      )\n";
            _QueryForwardBondsTrader += "     , 'CashFlow'                = SUM( cashflow )\n";
            _QueryForwardBondsTrader += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _QueryForwardBondsTrader += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _QueryForwardBondsTrader += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _QueryForwardBondsTrader += "     , 'Total'                   = SUM( SFBT.marktomarketvaluetoday - SFBT.marktomarketvalueyesterday )\n";
            _QueryForwardBondsTrader += "     , 'Estimation'              = SUM( CASE WHEN SFBT.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
            _QueryForwardBondsTrader += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _QueryForwardBondsTrader += "  INTO #tmpResultado\n";
            _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesData                           SD\n";
            _QueryForwardBondsTrader += "       INNER JOIN dbo.SensibilitiesForwardBondsTrader  SFBT  ON SD.id                = SFBT.id\n";
            _QueryForwardBondsTrader += "       INNER JOIN #tmpSensibilities                    SY    ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
            _QueryForwardBondsTrader += "                                                            AND SD.OperationNumber   = SY.OperationNumber\n";
            _QueryForwardBondsTrader += " WHERE SD.system                  = 'BFW'\n";
            _QueryForwardBondsTrader += "   AND SD.productid               = '10'\n";

            if (!conditions.Equals(""))
            {
                _QueryForwardBondsTrader += " AND (" + conditions + ")\n";
            }

            _QueryForwardBondsTrader += " GROUP BY\n";
            _QueryForwardBondsTrader += "       SD.sensibilitiesdate\n\n";

            _QueryForwardBondsTrader += "UPDATE #tmpResultado\n";
            _QueryForwardBondsTrader += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
            _QueryForwardBondsTrader += "  FROM dbo.ExchangeValue\n";
            _QueryForwardBondsTrader += " WHERE currencydate = [Date]\n";
            _QueryForwardBondsTrader += "   AND currencyid   = 998\n\n";

            _QueryForwardBondsTrader += "UPDATE #tmpResultado\n";
            _QueryForwardBondsTrader += "   SET ExchangeRate = ExchangeRate - Readjustment\n\n";

            _QueryForwardBondsTrader += "UPDATE #tmpResultado\n";
            _QueryForwardBondsTrader += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _QueryForwardBondsTrader += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _QueryForwardBondsTrader += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _QueryForwardBondsTrader += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

            _QueryForwardBondsTrader += "SELECT [Date]\n";
            _QueryForwardBondsTrader += "     , EffectRate\n";
            _QueryForwardBondsTrader += "     , TimeDecay\n";
            _QueryForwardBondsTrader += "     , ExchangeRate\n";
            _QueryForwardBondsTrader += "     , Readjustment\n";
            _QueryForwardBondsTrader += "     , New\n";
            _QueryForwardBondsTrader += "     , Expiry\n";
            _QueryForwardBondsTrader += "     , CashFlow\n";
            _QueryForwardBondsTrader += "     , SubTotalNotExchangeRate\n";
            _QueryForwardBondsTrader += "     , SubTotalExchangeRate\n";
            _QueryForwardBondsTrader += "     , SubTotalEffect\n";
            _QueryForwardBondsTrader += "     , Total\n";
            _QueryForwardBondsTrader += "     , Estimation\n";
            _QueryForwardBondsTrader += "     , Ratio\n";
            _QueryForwardBondsTrader += "  FROM #tmpResultado\n";
            _QueryForwardBondsTrader += " ORDER BY\n";
            _QueryForwardBondsTrader += "       [Date]\n\n";

            _QueryForwardBondsTrader += "DROP TABLE #tmpResultado\n";
            _QueryForwardBondsTrader += "DROP TABLE #tmpSensibilities\n\n";

            _QueryForwardBondsTrader += "SET NOCOUNT OFF\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryForwardBondsTrader);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "ResultForwardBondsTrader";

                if (_PortFolioData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _PortFolioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _PortFolioData;

        }

        public static DataTable LoadReportMonthlyResultSwap(string conditions)
        {

            String _QuerySwap = "";

            #region "Query Swap"

            _QuerySwap += "SET NOCOUNT ON\n\n";

            _QuerySwap += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
            _QuerySwap += "     , 'OperationNumber'               = SY.operationnumber\n";
            _QuerySwap += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
            _QuerySwap += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
            _QuerySwap += "  INTO #tmpSensibilities\n";
            _QuerySwap += "  FROM dbo.SensibilitiesYield SY\n";
            _QuerySwap += " WHERE SY.system                       = 'PCS'\n";
            _QuerySwap += " GROUP BY\n";
            _QuerySwap += "       SY.sensibilitiesdate\n";
            _QuerySwap += "     , SY.OperationNumber\n\n";

            _QuerySwap += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _QuerySwap += "     , 'EffectRate'              = SUM( CASE WHEN SW.status = 'N' THEN 0\n";
            _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QuerySwap += "                                             THEN SW.marktomarketvalueeffectrate - SW.marktomarketvalueyesterday\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'TimeDecay'               = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN 0\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN 0\n";
            _QuerySwap += "                                             WHEN (SW.ContractDate               <> SD.sensibilitiesdate\n";
            _QuerySwap += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
            _QuerySwap += "                                              AND  SW.marktomarketvaluetimedecay <> 0\n";
            _QuerySwap += "                                                  THEN SW.marktomarketvaluetimedecay - SW.marktomarketvalueyesterday\n";
            _QuerySwap += "                                                  ELSE 0\n";
            _QuerySwap += "                                        END +\n";
            _QuerySwap += "                                        CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN 0\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN 0\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN SW.cashflow\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN SW.cashflow\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'ExchangeRateAsset'       = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid <> 998 AND SD.primarycurrencyid <> 999 THEN SW.exchangerateasset - SW.fairvalueassetyesterday\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'ExchangeRateLiabilities' = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid <> 998 AND SD.secondcurrencyid <> 999 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'ExchangeRate'            = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND SD.primaryrateid <> 13\n";
            _QuerySwap += "                                             THEN SW.exchangerateasset - SW.fairvalueassetyesterday\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
            _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND SD.secondrateid <> 13\n";
            _QuerySwap += "                                             THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'New'                     = SUM( CASE WHEN SW.ContractDate = SD.sensibilitiesdate THEN SW.marktomarketvaluetoday - SW.marktomarketvalueyesterday\n";
            _QuerySwap += "                                                                                         ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'Expiry'                  = SUM( CASE WHEN SW.status                      = 'N'                  THEN -SW.marktomarketvalueyesterday\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN SW.cashflow * -1\n";
            _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN SW.cashflow * -1\n";
            _QuerySwap += "                                             ELSE 0\n";
            _QuerySwap += "                                        END\n";
            _QuerySwap += "                                      )\n";
            _QuerySwap += "     , 'CashFlow'                = SUM( cashflow )\n";
            _QuerySwap += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'Total'                   = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'MarktoMarketToday'       = SUM( SW.marktomarketvaluetoday )\n";
            _QuerySwap += "     , 'MarktoMarketYesterday'   = SUM( SW.marktomarketvalueyesterday )\n";
            _QuerySwap += "     , 'Estimation'              = SUM( CASE WHEN SW.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
            _QuerySwap += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'SubTotal'                = CAST( 0 AS FLOAT )\n";
            _QuerySwap += "     , 'DeltaMTMYesterday'       = SUM( CASE WHEN SW.contractdate <> SD.sensibilitiesdate THEN SW.fairvaluenetportfolioyesterday - SW.fairvaluenetyesterday ELSE 0 END )\n";
            _QuerySwap += "  INTO #tmpResultado\n";
            _QuerySwap += "  FROM dbo.SensibilitiesData             SD\n";
            _QuerySwap += "       INNER JOIN dbo.SensibilitiesSwap  SW  ON SD.id                = SW.id\n";
            _QuerySwap += "       INNER JOIN #tmpSensibilities      SY  ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
            _QuerySwap += "                                            AND SD.OperationNumber   = SY.OperationNumber\n";
            _QuerySwap += " WHERE SD.system                  = 'PCS'\n";

            //if (!conditions.Equals(""))
            //{
            //    _QuerySwap += " AND (" + conditions + ")\n";
            //}

            _QuerySwap += " GROUP BY\n";
            _QuerySwap += "       SD.sensibilitiesdate\n\n";

            _QuerySwap += "SELECT 'DateProcessToday'     = SS.portfoliotoday\n";
            _QuerySwap += "     , 'DatePorcessYesterday' = SS.portfolioyesterday\n";
            _QuerySwap += "     , 'DatePorcessTomorrow'  = SS.portfoliotomorrow\n";
            _QuerySwap += "     , 'MarktoMarket'         = R.MarktoMarketToday\n";
            _QuerySwap += "  INTO #tmpDate\n";
            _QuerySwap += "  FROM #tmpResultado R\n";
            _QuerySwap += "       INNER JOIN dbo.StatusSystem SS ON R.Date = SS.datestatus\n\n";

            _QuerySwap += "UPDATE #tmpResultado\n";
            _QuerySwap += "   SET MarktoMarketYesterday  = D.MarktoMarket\n";
            _QuerySwap += "     , Total                  = MarktoMarketToday - D.MarktoMarket\n";
            _QuerySwap += "  FROM #tmpDate D\n";
            _QuerySwap += " WHERE D.DatePorcessTomorrow  = Date\n\n";


            _QuerySwap += "UPDATE #tmpResultado\n";
            _QuerySwap += "   SET Readjustment = ReadjustmentAsset + ReadjustmentLiabilities\n";
            _QuerySwap += "     , ExchangeRate = ExchangeRateAsset + ExchangeRateLiabilities\n";
            _QuerySwap += "  FROM dbo.ExchangeValue\n";
            _QuerySwap += " WHERE currencydate = [Date]\n";
            _QuerySwap += "   AND currencyid   = 998\n\n";

            _QuerySwap += "UPDATE #tmpResultado\n";
            _QuerySwap += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _QuerySwap += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _QuerySwap += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _QuerySwap += "     , SubTotal                = Total + CashFlow + New + Expiry - ExchangeRate\n";
            _QuerySwap += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

            _QuerySwap += "SELECT [Date]\n";
            _QuerySwap += "     , EffectRate\n";
            _QuerySwap += "     , TimeDecay\n";
            _QuerySwap += "     , ExchangeRate\n";
            _QuerySwap += "     , Readjustment\n";
            _QuerySwap += "     , New\n";
            _QuerySwap += "     , Expiry\n";
            _QuerySwap += "     , CashFlow\n";
            _QuerySwap += "     , SubTotalNotExchangeRate\n";
            _QuerySwap += "     , SubTotalExchangeRate\n";
            _QuerySwap += "     , SubTotalEffect\n";
            _QuerySwap += "     , Total\n";
            _QuerySwap += "     , MarktoMarketToday\n";
            _QuerySwap += "     , MarktoMarketYesterday\n";
            _QuerySwap += "     , SubTotal\n";
            _QuerySwap += "     , Estimation\n";
            _QuerySwap += "     , Ratio\n";
            _QuerySwap += "     , DeltaMTMYesterday\n";
            _QuerySwap += "  FROM #tmpResultado\n";
            _QuerySwap += " ORDER BY\n";
            _QuerySwap += "       [Date]\n\n";

            _QuerySwap += "DROP TABLE #tmpResultado\n";
            _QuerySwap += "DROP TABLE #tmpSensibilities\n";
            _QuerySwap += "DROP TABLE #tmpDate\n\n";

            _QuerySwap += "SET NOCOUNT OFF\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySwap);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "ResultSWAP";

                if (_PortFolioData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _PortFolioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _PortFolioData;

        }             


    }
}