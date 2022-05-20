using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Sensibilities.Detail
{

    public class PortfolioDetailForwardFixingIncome : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate, string conditions)
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

            #region "Query Forward Fixing Income"

            _ForwardFixingIncome += "DECLARE @DateProcess                   DATETIME\n";

            _ForwardFixingIncome += "SET @DateProcess = [@DateProcess]\n";

            _ForwardFixingIncome += "SELECT 'Status'                      = CASE WHEN SD.expirydate    = @DateProcess  THEN 2 -- vencidas\n";
            _ForwardFixingIncome += "                                            WHEN SFBT.contractdate = @DateProcess THEN 3 -- Nuevas\n";
            _ForwardFixingIncome += "                                                                                  ELSE 1 -- Vigente\n";
            _ForwardFixingIncome += "                                       END\n";
            _ForwardFixingIncome += "     , 'System'                      = SD.system\n";
            _ForwardFixingIncome += "     , 'DSystem'                     = 'FORWARD RENTA FIJA'\n";
            _ForwardFixingIncome += "     , 'Book'                        = SD.bookid\n";
            _ForwardFixingIncome += "     , 'PortFolioRules'              = SD.portfoliorulesid\n";
            _ForwardFixingIncome += "     , 'FinancialPortFolio'          = SD.financialportfolioid\n";
            _ForwardFixingIncome += "     , 'Product'                     = SD.productid\n";
            _ForwardFixingIncome += "     , 'IssueID'                     = SD.issueid\n";
            _ForwardFixingIncome += "     , 'IssueName'                   = CAST( '' AS VARCHAR(40) )\n";
            _ForwardFixingIncome += "     , 'ExpiryDate'                  = SD.expirydate\n";
            _ForwardFixingIncome += "     , 'OperationNumber'             = SD.operationnumber\n";
            _ForwardFixingIncome += "     , 'OperationID'                 = SD.operationid\n";
            _ForwardFixingIncome += "     , 'CustomerID'                  = SD.customerid\n";
            _ForwardFixingIncome += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
            _ForwardFixingIncome += "     , 'MNemonics'                   = SD.mnemonics\n";
            _ForwardFixingIncome += "     , 'CustomerCode'                = SD.customercode\n";
            _ForwardFixingIncome += "     , 'CustomerName'                = CAST( '' AS VARCHAR(40) )\n";
            _ForwardFixingIncome += "     , 'OperationType'               = SFBT.operationtype\n";
            _ForwardFixingIncome += "     , 'Nominal'                     = SFBT.nominal\n";
            _ForwardFixingIncome += "     , 'CurrencyIssue'               = SFBT.currencyissue\n";
            _ForwardFixingIncome += "     , 'RateForwardTheory'           = SFBT.rateforwardtheory\n";
            _ForwardFixingIncome += "     , 'ContractDate'                = SFBT.contractdate\n";
            _ForwardFixingIncome += "     , 'MarktoMarketValueYesterday'  = SFBT.marktomarketvalueyesterday\n";
            _ForwardFixingIncome += "     , 'MarktoMarketValueToday'      = SFBT.marktomarketvaluetoday\n";
            _ForwardFixingIncome += "     , 'MarktoMarketValueTodayUM'    = SFBT.marktomarketvaluetodayum\n";
            _ForwardFixingIncome += "     , 'TimeDecayValue'              = SFBT.marktomarketvaluetimedecay\n";
            _ForwardFixingIncome += "     , 'ExchangeRateValue'           = SFBT.marktomarketvalueexchangerate\n";
            _ForwardFixingIncome += "     , 'EffectRateValue'             = SFBT.marktomarketvalueeffectrate\n";
            _ForwardFixingIncome += "     , 'CashFlow'                    = SFBT.CashFlow\n";
            _ForwardFixingIncome += "     , 'MarktoMarketRateYesterday'   = SFBT.marktomarketrateyesterday\n";
            _ForwardFixingIncome += "     , 'MarktoMarketRateToday'       = SFBT.marktomarketratetoday\n";
            _ForwardFixingIncome += "     , 'MarktoMarketRateEndMonth'    = SFBT.marktomarketrateendmonth\n";
            _ForwardFixingIncome += "     , 'MacaulayDuration'            = SFBT.macaulayduration\n";
            _ForwardFixingIncome += "     , 'ModifiedDuration'            = SFBT.modifiedduration\n";
            _ForwardFixingIncome += "     , 'Convexity'                   = SFBT.convexity\n";
            _ForwardFixingIncome += "     , 'RateContract'                = SFBT.ratecontract\n";
            _ForwardFixingIncome += "     , 'FairValueAssetSystem'        = SFBT.fairvalueassetsystem\n";
            _ForwardFixingIncome += "     , 'FairValueLiabilitiesSystem'  = SFBT.fairvalueliabilitiessystem\n";
            _ForwardFixingIncome += "     , 'FairValueNetSystem'          = SFBT.fairvaluenetsystem\n";
            _ForwardFixingIncome += "     , 'MacaulayDurationSystem'      = SFBT.macaulaydurationsystem\n";
            _ForwardFixingIncome += "     , 'ModifiedDurationSystem'      = SFBT.modifieddurationsystem\n";
            _ForwardFixingIncome += "     , 'ConvexitySystem'             = SFBT.convexitysystem\n";
            _ForwardFixingIncome += "     , 'Sensibilities'               = CASE WHEN SFBT.contractdate = @DateProcess THEN 0.0 ELSE SD.sensibilitiesvalue END\n";
            _ForwardFixingIncome += "     , 'Estimation'                  = CASE WHEN SFBT.contractdate = @DateProcess THEN 0.0 ELSE SD.estimationvalue    END\n";
            _ForwardFixingIncome += "  FROM dbo.SensibilitiesData                            SD\n";
            _ForwardFixingIncome += "       INNER JOIN dbo.SensibilitiesForwardBondsTrader   SFBT   ON SD.ID       = SFBT.ID\n";
            _ForwardFixingIncome += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
            _ForwardFixingIncome += "   AND SD.system                     = 'BFW'\n";
            _ForwardFixingIncome += "   AND SD.productid                  = '10'\n";

            if (!conditions.Equals(""))
            {
                _ForwardFixingIncome += " AND (" + conditions + ")\n";
            }

            _ForwardFixingIncome += " ORDER BY OperationNumber, OperationID\n\n";


            _ForwardFixingIncome = _ForwardFixingIncome.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _ForwardFixingIncome, "DetailForwardFixingIncome");
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
