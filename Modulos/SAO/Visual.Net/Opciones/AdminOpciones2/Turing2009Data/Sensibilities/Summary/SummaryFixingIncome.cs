using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;
namespace Turing2009Data.Sensibilities.Summary
{

    public class SummaryFixingIncome : InterfaceQuery
    {

        public DataTable Load(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTFixingIncome;
            string _FixingIncome;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTFixingIncome = new DataTable();

            _FixingIncome = "";

            #endregion

            #region "Query Fixing Rate"

            _FixingIncome += "SET NOCOUNT ON\n\n";

            _FixingIncome += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
            _FixingIncome += "     , 'DocumentNumber'                = SY.documentnumber\n";
            _FixingIncome += "     , 'OperationNumber'               = SY.operationnumber\n";
            _FixingIncome += "     , 'OperationID'                   = SY.operationid\n";
            _FixingIncome += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
            _FixingIncome += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
            _FixingIncome += "  INTO #tmpSensibilities\n";
            _FixingIncome += "  FROM dbo.SensibilitiesYield SY\n";
            _FixingIncome += " WHERE SY.system                       = 'BTR'\n";
            _FixingIncome += " GROUP BY\n";
            _FixingIncome += "       SY.sensibilitiesdate\n";
            _FixingIncome += "     , SY.DocumentNumber\n";
            _FixingIncome += "     , SY.OperationNumber\n";
            _FixingIncome += "     , SY.OperationID\n\n";

            _FixingIncome += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _FixingIncome += "     , 'EffectRate'              = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _FixingIncome += "                                             THEN SFR.marktomarketvalueeffectrate - SFR.marktomarketvalueyesterday\n";
            _FixingIncome += "                                             ELSE 0\n";
            _FixingIncome += "                                        END\n";
            _FixingIncome += "                                      )\n";
            _FixingIncome += "     , 'TimeDecay'               = SUM( CASE WHEN (SFR.ContractDate               <> SD.sensibilitiesdate\n";
            _FixingIncome += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
            _FixingIncome += "                                              AND  SFR.marktomarketvaluetimedecay <> 0\n";
            _FixingIncome += "                                             THEN SFR.marktomarketvaluetimedecay - SFR.marktomarketvalueyesterday\n";
            _FixingIncome += "                                             ELSE 0\n";
            _FixingIncome += "                                        END +\n";
            _FixingIncome += "                                        CASE WHEN SFR.courtdatecoupon        = SD.sensibilitiesdate THEN SFR.cashflow\n";
            _FixingIncome += "                                             ELSE 0\n";
            _FixingIncome += "                                        END\n";
            _FixingIncome += "                                      )\n";
            _FixingIncome += "     , 'ExchangeRate'            = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate  AND  SFR.currencyissue <> 998\n";
            _FixingIncome += "                                              AND SFR.marktomarketvalueexchangerate <> 0 THEN SFR.marktomarketvalueexchangerate - SFR.marktomarketvalueyesterday\n";
            _FixingIncome += "                                             ELSE 0\n";
            _FixingIncome += "                                        END\n";
            _FixingIncome += "                                      )\n";
            _FixingIncome += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate  AND  SFR.currencyissue = 998\n";
            _FixingIncome += "                                              AND SFR.marktomarketvalueexchangerate <> 0 THEN SFR.marktomarketvalueyesterdayum\n";
            _FixingIncome += "                                             ELSE 0\n";
            _FixingIncome += "                                        END\n";
            _FixingIncome += "                                      )\n";
            _FixingIncome += "     , 'ReadjustmentLiabilities' = CAST( 0 AS FLOAT )\n";
            _FixingIncome += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _FixingIncome += "     , 'New'                     = SUM( CASE WHEN SFR.ContractDate = SD.sensibilitiesdate THEN SFR.marktomarketvaluetoday - SFR.marktomarketvalueyesterday\n";
            _FixingIncome += "                                                                                          ELSE 0\n";
            _FixingIncome += "                                        END\n";
            _FixingIncome += "                                      )\n";
            _FixingIncome += "     , 'Expiry'                  = SUM( CASE WHEN SFR.courtdatecoupon        = SD.sensibilitiesdate THEN SFR.cashflow * -1\n";
            _FixingIncome += "                                             ELSE 0\n";
            _FixingIncome += "                                        END\n";
            _FixingIncome += "                                      )\n";
            _FixingIncome += "     , 'CashFlow'                = SUM( cashflow )\n";
            _FixingIncome += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _FixingIncome += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _FixingIncome += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _FixingIncome += "     , 'Total'                   = SUM( SFR.marktomarketvaluetoday - SFR.marktomarketvalueyesterday )\n";
            _FixingIncome += "     , 'Estimation'              = SUM( CASE WHEN SFR.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
            _FixingIncome += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _FixingIncome += "     , 'Accrual'                 = SUM( SFR.dailyinterestsystem + SFR.dailyadjustmentsystem )\n";
            _FixingIncome += "     , 'CarryCost'               = SUM( SFR.CorryCost )\n";
            _FixingIncome += "     , 'AVR'                     = SUM( CASE WHEN SFR.SalesValue <> 0\n";
            _FixingIncome += "                                             THEN 0\n";
            _FixingIncome += "                                             ELSE (SFR.marktomarketvaluetoday - SFR.presentvaluetoday) - (SFR.marktomarketvalueyesterday - SFR.presentvalueyesterday)\n";
            _FixingIncome += "                                        END )\n";
            _FixingIncome += "     , 'PriceDifference'         = SUM( CASE WHEN SFR.SalesValue = 0 THEN 0 ELSE SFR.SalesValue - SFR.presentvaluetoday END )\n";
            _FixingIncome += "  INTO #tmpResultado\n";
            _FixingIncome += "  FROM dbo.SensibilitiesData             SD\n";
            _FixingIncome += "       INNER JOIN dbo.SensibilitiesFixingRate  SFR  ON SD.id                = SFR.id\n";
            _FixingIncome += "       INNER JOIN #tmpSensibilities            SY   ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
            _FixingIncome += "                                                   AND SD.DocumentNumber    = SY.DocumentNumber\n";
            _FixingIncome += "                                                   AND SD.OperationNumber   = SY.OperationNumber\n";
            _FixingIncome += "                                                   AND SD.OperationID       = SY.OperationID\n";
            _FixingIncome += " WHERE SD.system                  = 'BTR'\n";

            if (!conditions.Equals(""))
            {
                _FixingIncome += " AND (" + conditions + ")\n";
            }

            _FixingIncome += " GROUP BY\n";
            _FixingIncome += "       SD.sensibilitiesdate\n\n";

            _FixingIncome += "UPDATE #tmpResultado\n";
            _FixingIncome += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
            _FixingIncome += "  FROM dbo.ExchangeValue\n";
            _FixingIncome += " WHERE currencydate = [Date]\n";
            _FixingIncome += "   AND currencyid   = 998\n\n";

            _FixingIncome += "UPDATE #tmpResultado\n";
            _FixingIncome += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _FixingIncome += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _FixingIncome += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _FixingIncome += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

            _FixingIncome += "SELECT [Date]\n";
            _FixingIncome += "     , EffectRate\n";
            _FixingIncome += "     , TimeDecay\n";
            _FixingIncome += "     , ExchangeRate\n";
            _FixingIncome += "     , Readjustment\n";
            _FixingIncome += "     , New\n";
            _FixingIncome += "     , Expiry\n";
            _FixingIncome += "     , CashFlow\n";
            _FixingIncome += "     , SubTotalNotExchangeRate\n";
            _FixingIncome += "     , SubTotalExchangeRate\n";
            _FixingIncome += "     , SubTotalEffect\n";
            _FixingIncome += "     , Total\n";
            _FixingIncome += "     , Estimation\n";
            _FixingIncome += "     , Ratio\n";
            _FixingIncome += "     , Accrual\n";
            _FixingIncome += "     , CarryCost\n";
            _FixingIncome += "     , AVR\n";
            _FixingIncome += "     , PriceDifference\n";
            _FixingIncome += "  FROM #tmpResultado\n";
            _FixingIncome += " ORDER BY\n";
            _FixingIncome += "       [Date]\n\n";

            _FixingIncome += "DROP TABLE #tmpResultado\n";
            _FixingIncome += "DROP TABLE #tmpSensibilities\n\n";

            _FixingIncome += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _FixingIncome, "ResultsFixingIncome");
                _DTFixingIncome = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTFixingIncome = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTFixingIncome;

        }


    }

}
