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

    public class PortfolioDetailForward : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate, string conditions)
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

            _Forward += "DECLARE @DateProcess                   DATETIME\n";
            _Forward += "DECLARE @UFValue                       FLOAT\n\n";

            _Forward += "SET @DateProcess = [@DateProcess]\n";

            _Forward += "SELECT @UFValue     = currencyvaluetoday\n";
            _Forward += "  FROM dbo.ExchangeValue\n";
            _Forward += " WHERE currencydate = @DateProcess\n";
            _Forward += "   AND currencyid   = 998\n\n";

            _Forward += "SELECT 'Status'                       = CASE WHEN SD.expirydate   = @DateProcess THEN 2 -- vencidas\n";
            _Forward += "                                             WHEN SF.contractdate = @DateProcess THEN 3 -- Nuevas  \n";
            _Forward += "                                                                                 ELSE 1 -- Vigente\n";
            _Forward += "                                        END\n";
            _Forward += "     , 'System'                       = SD.system\n";
            _Forward += "     , 'DSystem'                      = 'FORWARD'\n";
            _Forward += "     , 'Book'                         = SD.bookid\n";
            _Forward += "     , 'PortFolioRules'               = SD.portfoliorulesid\n";
            _Forward += "     , 'FinancialPortFolio'           = SD.financialportfolioid\n";
            _Forward += "     , 'Product'                      = SD.productid\n";
            _Forward += "     , 'IssueID'                      = SD.issueid\n";
            _Forward += "     , 'IssueName'                    = CAST( '' AS VARCHAR(30) )\n";
            _Forward += "     , 'ExpiryDate'                   = SD.expirydate\n";
            _Forward += "     , 'OperationNumber'              = SD.operationnumber\n";
            _Forward += "     , 'OperationID'                  = SD.operationid\n";
            _Forward += "     , 'CustomerID'                   = SD.customerid\n";
            _Forward += "     , 'MNemonicsMask'                = SD.mnemonicsmask\n";
            _Forward += "     , 'CustomerCode'                 = SD.customercode\n";
            _Forward += "     , 'CustomerName'                 = CAST( '' AS VARCHAR(30) )\n";
            _Forward += "     , 'EffectiveDate'                = SF.effectivedate\n";
            _Forward += "     , 'TermToday'                    = SF.termtoday\n";
            _Forward += "     , 'RateCurrencyPrimaryToday'     = SF.ratecurrencyprimarytoday\n";
            _Forward += "     , 'RateCurrencySecondToday'      = ratecurrencysecondtoday\n";
            _Forward += "     , 'TermYesterday'                = SF.termyesterday\n";
            _Forward += "     , 'RateCurrencyPrimaryYesterday' = SF.ratecurrencyprimaryyesterday\n";
            _Forward += "     , 'RateCurrencySecondYesterday'  = ratecurrencysecondyesterday\n";
            _Forward += "     , 'PrimaryCurrency'              = SD.primarycurrencyid\n";
            _Forward += "     , 'OperationType'                = SF.operationtype\n";
            _Forward += "     , 'PaymentType'                  = SF.paymenttype\n";
            _Forward += "     , 'UnWind'                       = SF.unwind\n";
            _Forward += "     , 'AdvancePointCost'             = SF.advancepointcost\n";
            _Forward += "     , 'AdvancePointForward'          = SF.advancepointforward\n";
            _Forward += "     , 'PrimaryAmount'                = SF.primaryamount\n";
            _Forward += "     , 'SecondaryCurrency'            = SD.secondcurrencyid\n";
            _Forward += "     , 'SecondaryAmount'              = SF.secondaryamount\n";
            _Forward += "     , 'PriceForward'                 = SF.priceforward\n";
            _Forward += "     , 'PricePointForward'            = SF.pricepointforward\n";
            _Forward += "     , 'UF'                           = CASE WHEN SD.secondcurrencyid = 998 THEN @UFValue ELSE 0.0 END\n";
            _Forward += "     , 'PriceCost'                    = SF.pricecost\n";
            _Forward += "     , 'PriceForwardTheory'           = SF.priceforwardtheory\n";
            _Forward += "     , 'ContractDate'                 = SF.contractdate\n";
            _Forward += "     , 'MarktoMarketValueYesterday'   = SF.marktomarketvalueyesterday\n";
            _Forward += "     , 'MarktoMarketValueToday'       = SF.marktomarketvaluetoday\n";
            _Forward += "     , 'MarktoMarketValueTodayUM'     = SF.marktomarketvaluetodayum\n";
            _Forward += "     , 'TimeDecayValue'               = SF.marktomarketvaluetimedecay\n";
            _Forward += "     , 'ExchangeRateValue'            = SF.marktomarketvalueexchangerate\n";
            _Forward += "     , 'EffectRateValue'              = SF.marktomarketvalueeffectrate\n";
            _Forward += "     , 'CashFlow'                     = SF.cashflow\n";
            _Forward += "     , 'ResultDistribution'           = SF.resultdistribution\n";
            _Forward += "     , 'MarktoMarketRateYesterday'    = SF.marktomarketrateyesterday\n";
            _Forward += "     , 'MarktoMarketRateToday'        = SF.marktomarketratetoday\n";
            _Forward += "     , 'MarktoMarketRateEndMonth'     = SF.marktomarketrateendmonth\n";
            _Forward += "     , 'FairValueAssetSystem'         = SF.fairvalueassetsystem\n";
            _Forward += "     , 'FairValueLiabilitiesSystem'   = SF.fairvalueliabilitiessystem\n";
            _Forward += "     , 'FairValueNetSystem'           = SF.fairvaluenetsystem\n";
            _Forward += "     , 'Sensibilities'                = CASE WHEN SF.contractdate = @DateProcess THEN 0.0 ELSE SD.sensibilitiesvalue END\n";
            _Forward += "     , 'Estimation'                   = CASE WHEN SF.contractdate = @DateProcess THEN 0.0 ELSE SD.estimationvalue    END\n";
            _Forward += "     , 'TransferDistribution'         = CASE WHEN SF.contractdate = SD.sensibilitiesdate THEN SF.transferdistribution ELSE 0 END\n";
            _Forward += "     , 'MarktoMarketSpot'             = SF.marktomarketeffectrate\n";
            _Forward += "     , 'PointForward'                 = SF.pointforward\n";
            _Forward += "     , 'CarryRateUSD'                 = SF.carryrateusd\n";
            _Forward += "     , 'CostCarry'                    = SF.carrycostvalue\n";
            _Forward += "  FROM dbo.SensibilitiesData                    SD\n";
            _Forward += "       INNER JOIN dbo.SensibilitiesForward      SF     ON SD.ID                = SF.ID\n";
            _Forward += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
            _Forward += "   AND SD.system                     = 'BFW'\n";
            _Forward += "   AND SD.productid                 <> '10'\n";

            if (!conditions.Equals(""))
            {
                _Forward += " AND (" + conditions + ")\n";
            }

            _Forward += " ORDER BY OperationNumber, OperationID\n\n";

            _Forward += "SET NOCOUNT OFF\n\n";

            _Forward = _Forward.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Forward, "DetailForward");
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
