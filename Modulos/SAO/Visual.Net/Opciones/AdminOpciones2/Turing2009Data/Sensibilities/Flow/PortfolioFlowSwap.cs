using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Sensibilities.Flow
{

    public class PortfolioFlowSwap : InterfaceQuery
    {

        public DataSet Load(string id)
        {
            DataSet _DataSet = new DataSet();

            _DataSet.Merge(Operation(id));
            _DataSet.Merge(Flow(id));

            return _DataSet;

        }

        private DataTable Operation(string id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTOperation;
            string _Operation;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTOperation = new DataTable();

            _Operation = "";

            #endregion

            #region "Query Swap"

            _Operation  += "SET NOCOUNT ON\n\n";

            _Operation  += "SELECT 'ID'                              = SD.id\n";
            _Operation  += "     , 'SensibilitiesDate'               = SD.sensibilitiesdate\n";
            _Operation  += "     , 'System'                          = SD.System\n";
            _Operation  += "     , 'BookID'                          = SD.bookid\n";
            _Operation  += "     , 'PortFolioRulesID'                = SD.portfoliorulesid\n";
            _Operation  += "     , 'FinancialPortFolioID'            = SD.financialportfolioid\n";
            _Operation  += "     , 'Productid'                       = SD.productid\n";
            _Operation  += "     , 'PrimaryCurrencyID'               = SD.primarycurrencyid\n";
            _Operation  += "     , 'SecondCurrencyID'                = SD.secondcurrencyid\n";
            _Operation  += "     , 'PrimaryRateID'                   = SD.primaryrateid\n";
            _Operation  += "     , 'SecondRateID'                    = SD.secondrateid\n";
            _Operation  += "     , 'FamilyID'                        = SD.familyid\n";
            _Operation  += "     , 'MNemonicsMask'                   = SD.mnemonicsmask\n";
            _Operation  += "     , 'MNemonics'                       = SD.mnemonics\n";
            _Operation  += "     , 'IssueID'                         = SD.issueid\n";
            _Operation  += "     , 'FlagQuotes'                      = SD.flagquotes\n";
            _Operation  += "     , 'ExpiryDate'                      = SD.expirydate\n";
            _Operation  += "     , 'DocumentNumber'                  = SD.documentnumber\n";
            _Operation  += "     , 'Operationnumber'                 = SD.operationnumber\n";
            _Operation  += "     , 'OperationID'                     = SD.operationid\n";
            _Operation  += "     , 'CustomerID'                      = SD.customerid\n";
            _Operation  += "     , 'CustomerCode'                    = SD.customercode\n";
            _Operation  += "     , 'UserID'                          = SD.userid\n";
            _Operation  += "     , 'Sensibilitiesdate'               = SS.sensibilitiesdate\n";
            _Operation  += "     , 'Contractdate'                    = SS.contractdate\n";
            _Operation  += "     , 'Amountasset'                     = SS.amountasset\n";
            _Operation  += "     , 'Amountliabilities'               = SS.amountliabilities\n";
            _Operation  += "     , 'MarkToMarketValueYesterday'      = SS.marktomarketvalueyesterday\n";
            _Operation  += "     , 'MarkToMarketValueYesterdayUM'    = SS.marktomarketvalueyesterdayum\n";
            _Operation  += "     , 'MarkToMarketValueToday'          = SS.marktomarketvaluetoday\n";
            _Operation  += "     , 'MarkToMarketValueTodayUM'        = SS.marktomarketvaluetodayum\n";
            _Operation  += "     , 'MarkToMarketValueTimeDecay'      = SS.marktomarketvaluetimedecay\n";
            _Operation  += "     , 'MarkToMarketValueExchangeRate'   = SS.marktomarketvalueexchangerate\n";
            _Operation  += "     , 'MarkToMarketValueRffectTate'     = SS.marktomarketvalueeffectrate\n";
            _Operation  += "     , 'MarkToMarketVateYesterday'       = SS.marktomarketrateyesterday\n";
            _Operation  += "     , 'MarkToMarketRateToday'           = SS.marktomarketratetoday\n";
            _Operation  += "     , 'MarkToMarketRateEndMonth'        = SS.marktomarketrateendmonth\n";
            _Operation  += "     , 'CashFlow'                        = SS.cashflow\n";
            _Operation  += "     , 'CourtDatecouponasset'            = SS.courtdatecouponasset\n";
            _Operation  += "     , 'CourtDatecouponliabilities'      = SS.courtdatecouponliabilities\n";
            _Operation  += "     , 'OperationNew'                    = SS.operationnew\n";
            _Operation  += "     , 'RateAsset'                       = SS.rateasset\n";
            _Operation  += "     , 'SpreadAsset'                     = SS.spreadasset\n";
            _Operation  += "     , 'ConventionAsset'                 = SS.conventionasset\n";
            _Operation  += "     , 'FairValueAsset'                  = SS.fairvalueasset\n";
            _Operation  += "     , 'FairValueAssetUM'                = SS.fairvalueassetum\n";
            _Operation  += "     , 'FairValueAssetYesterday'         = SS.fairvalueassetyesterday\n";
            _Operation  += "     , 'FairValueAssetYesterdayUM'       = SS.fairvalueassetyesterdayum\n";
            _Operation  += "     , 'RateLiabilities'                 = SS.rateliabilities\n";
            _Operation  += "     , 'SpreadLiabilities'               = SS.spreadliabilities\n";
            _Operation  += "     , 'ConventionLiabilities'           = SS.conventionliabilities\n";
            _Operation  += "     , 'FairValueLiabilities'            = SS.fairvalueliabilities\n";
            _Operation  += "     , 'FairValueLiabilitiesUM'          = SS.fairvalueliabilitiesum\n";
            _Operation  += "     , 'FairValueLiabilitiesYesterday'   = SS.fairvalueliabilitiesyesterday\n";
            _Operation  += "     , 'FairValueLiabilitiesYesterdayUM' = SS.fairvalueliabilitiesyesterdayum\n";
            _Operation  += "     , 'FairValueNet'                    = SS.fairvaluenet\n";
            _Operation  += "     , 'FairValueNetYesterday'           = SS.fairvaluenetyesterday\n";
            _Operation  += "     , 'FairValueAssetSystem'            = SS.fairvalueassetsystem\n";
            _Operation  += "     , 'FairValueAssetUMSystem'          = SS.fairvalueassetumsystem\n";
            _Operation  += "     , 'FairValueLiabilitiesSystem'      = SS.fairvalueliabilitiessystem\n";
            _Operation  += "     , 'FairValueLiabilitiesUMSystem'    = SS.fairvalueliabilitiesumsystem\n";
            _Operation  += "     , 'FairValueNetSystem'              = SS.fairvaluenetsystem\n";
            _Operation  += "     , 'Status'                          = SS.status\n";
            _Operation  += "  FROM dbo.SensibilitiesData SD\n";
            _Operation  += "       INNER JOIN dbo.SensibilitiesSwap SS  on SS.ID = SD.id\n";
            _Operation  += " WHERE SD.id                             = " + id + "\n\n";

            _Operation  += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Operation, "Operation");
                _DTOperation = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTOperation = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTOperation;

        }

        private DataTable Flow(string id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTFlow;
            string _Flow;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTFlow = new DataTable();

            _Flow = "";

            #endregion

            #region "Query Swap"

            _Flow += "SET NOCOUNT ON\n\n";

            _Flow += "SELECT 'ID'                       = SF.id\n";
            _Flow += "     , 'SensibilitiesDate'        = SF.sensibilitiesdate\n";
            _Flow += "     , 'System'                   = SF.system\n";
            _Flow += "     , 'DataID'                   = SF.dataid\n";
            _Flow += "     , 'OperationID'              = SF.operationid\n";
            _Flow += "     , 'LegID'                    = SF.legid\n";
            _Flow += "     , 'FixingDate'               = SF.fixingdate\n";
            _Flow += "     , 'StartingDate'             = SF.startingdate\n";
            _Flow += "     , 'ExpiryDate'               = SF.expirydate\n";
            _Flow += "     , 'PaymentDate'              = SF.paymentdate\n";
            _Flow += "     , 'Balance'                  = SF.balance\n";
            _Flow += "     , 'OutStanding'              = SF.balance + SF.amortizationflow\n";
            _Flow += "     , 'ExchangePrincipal'        = SF.exchangeprincipal\n";
            _Flow += "     , 'PostPounding'             = SF.postpounding\n";
            _Flow += "     , 'Rate'                     = SF.rate\n";
            _Flow += "     , 'Spread'                   = SF.spread\n";
            _Flow += "     , 'AmortizationFlow'         = SF.amortizationflow\n";
            _Flow += "     , 'InterestFlow'             = SF.interestflow\n";
            _Flow += "     , 'AditionalFlow'            = SF.aditionalflow\n";
            _Flow += "     , 'TotalFlow'                = SF.totalflow\n";
            _Flow += "     , 'RateDicount'              = SF.ratediscount\n";
            _Flow += "     , 'WellFactor'               = SF.wellfactor\n";
            _Flow += "     , 'AmortizationPresentValue' = SF.amortizationpresentvalue\n";
            _Flow += "     , 'InterestPresentValue'     = SF.interestpresentvalue\n";
            _Flow += "     , 'AditionalPresentValue'    = SF.aditionalpresentvalue\n";
            _Flow += "     , 'PresentValue'             = SF.presentvalue\n";
            _Flow += "  FROM dbo.SensibilitiesData SD\n";
            _Flow += "       INNER JOIN dbo.SensibilitiesFlow SF ON SF.DataID = SD.id\n";
            _Flow += " WHERE SF.dataid                  = " + id + "\n\n";

            _Flow += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Flow, "Flow");
                _DTFlow = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTFlow = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTFlow;

        }

    }

}
