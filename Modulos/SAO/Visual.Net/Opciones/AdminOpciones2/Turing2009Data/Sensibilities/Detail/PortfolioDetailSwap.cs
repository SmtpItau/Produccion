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

    public class PortfolioDetailSwap : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate, string conditions)
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

            _Swap += "DECLARE @DateProcess                   DATETIME\n\n";

            _Swap += "SET @DateProcess = [@DateProcess]\n\n";

            _Swap += "SELECT 'Status'                       = CASE WHEN SD.expirydate   = @DateProcess AND SW.status <> 'A' THEN 2 -- vencidas\n";
            _Swap += "                                             WHEN SW.contractdate = @DateProcess                      THEN 3 -- Nuevas \n";
            _Swap += "                                             WHEN SD.expirydate   = @DateProcess AND SW.status = 'A'  THEN 4 -- Anticipadas \n";
            _Swap += "                                                                                                      ELSE 1 -- Vigente \n";
            _Swap += "                                        END\n";
            _Swap += "     , 'ID'                           = SD.ID\n";
            _Swap += "     , 'System'                       = SD.system\n";
            _Swap += "     , 'DSystem'                      = 'SWAP'\n";
            _Swap += "     , 'Book'                         = SD.bookid\n";
            _Swap += "     , 'PortFolioRules'               = SD.portfoliorulesid\n";
            _Swap += "     , 'FinancialPortFolio'           = SD.financialportfolioid\n";
            _Swap += "     , 'Product'                      = SD.productid\n";
            _Swap += "     , 'IssueID'                      = SD.issueid\n";
            _Swap += "     , 'IssueName'                    = CAST( '' AS VARCHAR(40) )\n";
            _Swap += "     , 'ExpiryDate'                   = SD.expirydate\n";
            _Swap += "     , 'OperationNumber'              = SD.operationnumber\n";
            _Swap += "     , 'OperationID'                  = SD.operationid\n";
            _Swap += "     , 'CustomerID'                   = SD.customerid\n";
            _Swap += "     , 'MNemonicsMask'                = SD.mnemonicsmask\n";
            _Swap += "     , 'CustomerCode'                 = SD.customercode\n";
            _Swap += "     , 'CustomerName'                 = CAST( '' AS VARCHAR(40) )\n";
            _Swap += "     , 'PrimaryCurrency'              = SD.primarycurrencyid\n";
            _Swap += "     , 'PrimaryRateID'                = SD.primaryrateid\n";
            _Swap += "     , 'ContractDate'                 = SW.contractdate\n";
            _Swap += "     , 'AmountAsset'                  = SW.amountasset\n";
            _Swap += "     , 'SecondaryCurrency'            = SD.secondcurrencyid\n";
            _Swap += "     , 'SecondRateID'                 = SD.secondrateid\n";
            _Swap += "     , 'AmountLiabilities'            = SW.amountliabilities\n";
            _Swap += "     , 'FairValueAsset'               = SW.fairvalueasset\n";
            _Swap += "     , 'FairValueAssetUM'             = SW.fairvalueassetum\n";
            _Swap += "     , 'FairValueLiabilities'         = SW.fairvalueliabilities\n";
            _Swap += "     , 'FairValueLiabilitiesUM'       = SW.fairvalueliabilitiesum\n";
            _Swap += "     , 'MarktoMarketValueYesterday'   = SW.marktomarketvalueyesterday\n";
            _Swap += "     , 'MarktoMarketValueToday'       = SW.marktomarketvaluetoday\n";
            _Swap += "     , 'MarktoMarketValueTodayUM'     = SW.marktomarketvaluetodayum\n";
            _Swap += "     , 'TimeDecayValue'               = SW.marktomarketvaluetimedecay\n";
            _Swap += "     , 'ExchangeRateValue'            = CASE WHEN SD.primarycurrencyid <> 998 AND SD.primarycurrencyid <> 999 THEN SW.exchangerateasset - SW.fairvalueassetyesterday       ELSE 0 END +\n";
            _Swap += "                                        CASE WHEN SD.secondcurrencyid  <> 998 AND SD.secondcurrencyid  <> 999 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities ELSE 0 END\n";
            _Swap += "     , 'Readjustment'                 = CASE WHEN SD.primarycurrencyid = 998 THEN SW.exchangerateasset - SW.fairvalueassetyesterday       ELSE 0 END +\n";
            _Swap += "                                        CASE WHEN SD.secondcurrencyid  = 998 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities ELSE 0 END\n";
            _Swap += "     , 'EffectRateValue'              = SW.marktomarketvalueeffectrate\n";
            _Swap += "     , 'CashFlow'                     = SW.cashflow\n";
            _Swap += "     , 'ExpiryOperation'              = CASE WHEN SW.contractdate               = @DateProcess THEN -SW.marktomarketvalueyesterday\n";
            _Swap += "                                             WHEN SW.courtdatecouponasset       = @DateProcess THEN -SW.cashflow\n";
            _Swap += "                                             WHEN SW.courtdatecouponliabilities = @DateProcess THEN -SW.cashflow\n";
            _Swap += "                                             ELSE 0\n";
            _Swap += "                                        END\n";
            _Swap += "     , 'MarktoMarketRateYesterday'    = SW.marktomarketrateyesterday\n";
            _Swap += "     , 'MarktoMarketRateToday'        = SW.marktomarketratetoday\n";
            _Swap += "     , 'MarktoMarketRateEndMonth'     = SW.marktomarketrateendmonth\n";
            _Swap += "     , 'FairValueAssetSystem'         = SW.fairvalueassetsystem\n";
            _Swap += "     , 'FairValueAssetUMSystem'       = SW.fairvalueassetumsystem\n";
            _Swap += "     , 'FairValueLiabilitiesSystem'   = SW.fairvalueliabilitiessystem\n";
            _Swap += "     , 'FairValueLiabilitiesUMSystem' = SW.fairvalueliabilitiesumsystem\n";
            _Swap += "     , 'FairValueNetSystem'           = SW.fairvaluenetsystem\n";
            _Swap += "     , 'CourtDateCouponAsset'         = SW.courtdatecouponasset\n";
            _Swap += "     , 'CourtDateCouponLiabilities'   = SW.courtdatecouponliabilities\n";
            _Swap += "     , 'Sensibilities'                = CASE WHEN SW.contractdate = @DateProcess THEN 0.0 ELSE SD.sensibilitiesvalue END\n";
            _Swap += "     , 'Estimation'                   = CASE WHEN SW.contractdate = @DateProcess THEN 0.0 ELSE SD.estimationvalue    END\n";
            _Swap += "     , 'DeltaMTMYesterday'            = CASE WHEN SW.contractdate <> SD.sensibilitiesdate THEN SW.fairvaluenetportfolioyesterday - SW.fairvaluenetyesterday ELSE 0 END\n";
            _Swap += "  FROM dbo.SensibilitiesData                    SD\n";
            _Swap += "       INNER JOIN dbo.SensibilitiesSwap         SW     ON SD.ID              = SW.ID\n";
            _Swap += " WHERE SD.sensibilitiesdate           = @DateProcess\n";
            _Swap += "   AND SD.system                      = 'PCS'\n";

            if (!conditions.Equals(""))
            {
                _Swap += " AND (" + conditions + ")\n";
            }

            _Swap += " ORDER BY OperationNumber, OperationID\n\n";

            _Swap += "SET NOCOUNT OFF\n\n";

            _Swap = _Swap.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Swap, "DetailSwap");
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
