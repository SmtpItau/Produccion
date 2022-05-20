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

    public class PortfolioResultsForwardFixingIncome : InterfaceQuery
    {

        public DataTable Load(string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTForwardFixingIncome;
            string _ForwardFixingIncome;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTForwardFixingIncome = new DataTable();

            _ForwardFixingIncome = "";

            #endregion

            #region "Query Fixing Rate"

            _ForwardFixingIncome += "SET NOCOUNT ON\n\n";

            _ForwardFixingIncome += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
            _ForwardFixingIncome += "     , 'EffectRate'              = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _ForwardFixingIncome += "                                             THEN SFBT.marktomarketvalueeffectrate - SFBT.marktomarketvalueyesterday\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'TimeDecay'               = SUM( CASE WHEN (SFBT.ContractDate               <> SD.sensibilitiesdate\n";
            _ForwardFixingIncome += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
            _ForwardFixingIncome += "                                              AND  SFBT.marktomarketvaluetimedecay <> 0\n";
            _ForwardFixingIncome += "                                             THEN SFBT.marktomarketvaluetimedecay - SFBT.marktomarketvalueyesterday\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END +\n";
            _ForwardFixingIncome += "                                        CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SFBT.cashflow\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'ExchangeRate'            = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _ForwardFixingIncome += "                                              AND SFBT.marktomarketvalueexchangerate <> 0 THEN SFBT.marktomarketvalueexchangerate - SFBT.marktomarketvalueyesterday\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
            _ForwardFixingIncome += "                                              AND SFBT.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 THEN SFBT.marktomarketvalueyesterdayum\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SFBT.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 THEN -SFBT.marktomarketvalueyesterdayum\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
            _ForwardFixingIncome += "     , 'New'                     = SUM( CASE WHEN SFBT.ContractDate = SD.sensibilitiesdate THEN SFBT.marktomarketvaluetoday - SFBT.marktomarketvalueyesterday\n";
            _ForwardFixingIncome += "                                                                                           ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'Expiry'                  = SUM( CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SFBT.cashflow * -1\n";
            _ForwardFixingIncome += "                                             ELSE 0\n";
            _ForwardFixingIncome += "                                        END\n";
            _ForwardFixingIncome += "                                      )\n";
            _ForwardFixingIncome += "     , 'CashFlow'                = SUM( cashflow )\n";
            _ForwardFixingIncome += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
            _ForwardFixingIncome += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
            _ForwardFixingIncome += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
            _ForwardFixingIncome += "     , 'Total'                   = SUM( SFBT.marktomarketvaluetoday - SFBT.marktomarketvalueyesterday )\n";
            _ForwardFixingIncome += "     , 'Estimation'              = SUM( CASE WHEN SFBT.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SD.estimationvalue END )\n";
            _ForwardFixingIncome += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
            _ForwardFixingIncome += "  INTO #tmpResultado\n";
            _ForwardFixingIncome += "  FROM dbo.SensibilitiesData                           SD\n";
            _ForwardFixingIncome += "       INNER JOIN dbo.SensibilitiesForwardBondsTrader  SFBT  ON SD.id                = SFBT.id\n";
            _ForwardFixingIncome += " WHERE SD.system                  = 'BFW'\n";
            _ForwardFixingIncome += "   AND SD.productid               = '10'\n";

            if (!conditions.Equals(""))
            {
                _ForwardFixingIncome += " AND (" + conditions + ")\n";
            }

            _ForwardFixingIncome += " GROUP BY\n";
            _ForwardFixingIncome += "       SD.sensibilitiesdate\n\n";

            _ForwardFixingIncome += "UPDATE #tmpResultado\n";
            _ForwardFixingIncome += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
            _ForwardFixingIncome += "  FROM dbo.ExchangeValue\n";
            _ForwardFixingIncome += " WHERE currencydate = [Date]\n";
            _ForwardFixingIncome += "   AND currencyid   = 998\n\n";

            _ForwardFixingIncome += "UPDATE #tmpResultado\n";
            _ForwardFixingIncome += "   SET ExchangeRate = ExchangeRate - Readjustment\n\n";

            _ForwardFixingIncome += "UPDATE #tmpResultado\n";
            _ForwardFixingIncome += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
            _ForwardFixingIncome += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
            _ForwardFixingIncome += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
            _ForwardFixingIncome += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

            _ForwardFixingIncome += "SELECT [Date]\n";
            _ForwardFixingIncome += "     , EffectRate\n";
            _ForwardFixingIncome += "     , TimeDecay\n";
            _ForwardFixingIncome += "     , ExchangeRate\n";
            _ForwardFixingIncome += "     , Readjustment\n";
            _ForwardFixingIncome += "     , New\n";
            _ForwardFixingIncome += "     , Expiry\n";
            _ForwardFixingIncome += "     , CashFlow\n";
            _ForwardFixingIncome += "     , SubTotalNotExchangeRate\n";
            _ForwardFixingIncome += "     , SubTotalExchangeRate\n";
            _ForwardFixingIncome += "     , SubTotalEffect\n";
            _ForwardFixingIncome += "     , Total\n";
            _ForwardFixingIncome += "     , Estimation\n";
            _ForwardFixingIncome += "     , Ratio\n";
            _ForwardFixingIncome += "  FROM #tmpResultado\n";
            _ForwardFixingIncome += " ORDER BY\n";
            _ForwardFixingIncome += "       [Date]\n\n";

            _ForwardFixingIncome += "DROP TABLE #tmpResultado\n";

            _ForwardFixingIncome += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _ForwardFixingIncome, "ResultsForwardFixingIncome");
                _DTForwardFixingIncome = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTForwardFixingIncome = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTForwardFixingIncome;

        }


    }

}
