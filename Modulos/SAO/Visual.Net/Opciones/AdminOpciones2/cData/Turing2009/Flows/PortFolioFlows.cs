using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace cData.Turing2009.Flows
{
    public static class PortFolioFlows
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion


        public static DataTable LoadRFlowSwap(DateTime processdate, string id)
        {
            
            String _QuerySwap = "";

            #region "Query Swap"

            _QuerySwap += "SET NOCOUNT ON\n\n";

            _QuerySwap += "SELECT 'ID'                              = SD.id\n";
            _QuerySwap += "     , 'SensibilitiesDate'               = SD.sensibilitiesdate\n";
            _QuerySwap += "     , 'System'                          = SD.System\n";
            _QuerySwap += "     , 'BookID'                          = SD.bookid\n";
            _QuerySwap += "     , 'PortFolioRulesID'                = SD.portfoliorulesid\n";
            _QuerySwap += "     , 'FinancialPortFolioID'            = SD.financialportfolioid\n";
            _QuerySwap += "     , 'Productid'                       = SD.productid\n";
            _QuerySwap += "     , 'PrimaryCurrencyID'               = SD.primarycurrencyid\n";
            _QuerySwap += "     , 'SecondCurrencyID'                = SD.secondcurrencyid\n";
            _QuerySwap += "     , 'PrimaryRateID'                   = SD.primaryrateid\n";
            _QuerySwap += "     , 'SecondRateID'                    = SD.secondrateid\n";
            _QuerySwap += "     , 'FamilyID'                        = SD.familyid\n";
            _QuerySwap += "     , 'MNemonicsMask'                   = SD.mnemonicsmask\n";
            _QuerySwap += "     , 'MNemonics'                       = SD.mnemonics\n";
            _QuerySwap += "     , 'IssueID'                         = SD.issueid\n";
            _QuerySwap += "     , 'FlagQuotes'                      = SD.flagquotes\n";
            _QuerySwap += "     , 'ExpiryDate'                      = SD.expirydate\n";
            _QuerySwap += "     , 'DocumentNumber'                  = SD.documentnumber\n";
            _QuerySwap += "     , 'Operationnumber'                 = SD.operationnumber\n";
            _QuerySwap += "     , 'OperationID'                     = SD.operationid\n";
            _QuerySwap += "     , 'CustomerID'                      = SD.customerid\n";
            _QuerySwap += "     , 'CustomerCode'                    = SD.customercode\n";
            _QuerySwap += "     , 'UserID'                          = SD.userid\n";
            _QuerySwap += "     , 'Sensibilitiesdate'               = SS.sensibilitiesdate\n";
            _QuerySwap += "     , 'Contractdate'                    = SS.contractdate\n";
            _QuerySwap += "     , 'Amountasset'                     = SS.amountasset\n";
            _QuerySwap += "     , 'Amountliabilities'               = SS.amountliabilities\n";
            _QuerySwap += "     , 'MarkToMarketValueYesterday'      = SS.marktomarketvalueyesterday\n";
            _QuerySwap += "     , 'MarkToMarketValueYesterdayUM'    = SS.marktomarketvalueyesterdayum\n";
            _QuerySwap += "     , 'MarkToMarketValueToday'          = SS.marktomarketvaluetoday\n";
            _QuerySwap += "     , 'MarkToMarketValueTodayUM'        = SS.marktomarketvaluetodayum\n";
            _QuerySwap += "     , 'MarkToMarketValueTimeDecay'      = SS.marktomarketvaluetimedecay\n";
            _QuerySwap += "     , 'MarkToMarketValueExchangeRate'   = SS.marktomarketvalueexchangerate\n";
            _QuerySwap += "     , 'MarkToMarketValueRffectTate'     = SS.marktomarketvalueeffectrate\n";
            _QuerySwap += "     , 'MarkToMarketVateYesterday'       = SS.marktomarketrateyesterday\n";
            _QuerySwap += "     , 'MarkToMarketRateToday'           = SS.marktomarketratetoday\n";
            _QuerySwap += "     , 'MarkToMarketRateEndMonth'        = SS.marktomarketrateendmonth\n";
            _QuerySwap += "     , 'CashFlow'                        = SS.cashflow\n";
            _QuerySwap += "     , 'CourtDatecouponasset'            = SS.courtdatecouponasset\n";
            _QuerySwap += "     , 'CourtDatecouponliabilities'      = SS.courtdatecouponliabilities\n";
            _QuerySwap += "     , 'OperationNew'                    = SS.operationnew\n";
            _QuerySwap += "     , 'RateAsset'                       = SS.rateasset\n";
            _QuerySwap += "     , 'SpreadAsset'                     = SS.spreadasset\n";
            _QuerySwap += "     , 'ConventionAsset'                 = SS.conventionasset\n";
            _QuerySwap += "     , 'FairValueAsset'                  = SS.fairvalueasset\n";
            _QuerySwap += "     , 'FairValueAssetUM'                = SS.fairvalueassetum\n";
            _QuerySwap += "     , 'FairValueAssetYesterday'         = SS.fairvalueassetyesterday\n";
            _QuerySwap += "     , 'FairValueAssetYesterdayUM'       = SS.fairvalueassetyesterdayum\n";
            _QuerySwap += "     , 'RateLiabilities'                 = SS.rateliabilities\n";
            _QuerySwap += "     , 'SpreadLiabilities'               = SS.spreadliabilities\n";
            _QuerySwap += "     , 'ConventionLiabilities'           = SS.conventionliabilities\n";
            _QuerySwap += "     , 'FairValueLiabilities'            = SS.fairvalueliabilities\n";
            _QuerySwap += "     , 'FairValueLiabilitiesUM'          = SS.fairvalueliabilitiesum\n";
            _QuerySwap += "     , 'FairValueLiabilitiesYesterday'   = SS.fairvalueliabilitiesyesterday\n";
            _QuerySwap += "     , 'FairValueLiabilitiesYesterdayUM' = SS.fairvalueliabilitiesyesterdayum\n";
            _QuerySwap += "     , 'FairValueNet'                    = SS.fairvaluenet\n";
            _QuerySwap += "     , 'FairValueNetYesterday'           = SS.fairvaluenetyesterday\n";
            _QuerySwap += "     , 'FairValueAssetSystem'            = SS.fairvalueassetsystem\n";
            _QuerySwap += "     , 'FairValueAssetUMSystem'          = SS.fairvalueassetumsystem\n";
            _QuerySwap += "     , 'FairValueLiabilitiesSystem'      = SS.fairvalueliabilitiessystem\n";
            _QuerySwap += "     , 'FairValueLiabilitiesUMSystem'    = SS.fairvalueliabilitiesumsystem\n";
            _QuerySwap += "     , 'FairValueNetSystem'              = SS.fairvaluenetsystem\n";
            _QuerySwap += "     , 'Status'                          = SS.status\n";
            _QuerySwap += "  FROM dbo.SensibilitiesData SD\n";
            _QuerySwap += "       INNER JOIN dbo.SensibilitiesSwap SS  on SS.ID = SD.id\n";
            _QuerySwap += " WHERE SD.sensibilitiesdate      = '" + processdate.ToString("yyyyMMdd") + "'\n";

            if (!id.Equals(""))
            {
                //_QuerySwap += " AND (" + conditions + ")\n";
                _QuerySwap += " AND SD.id ='" + id + "'\n";
            }

            _QuerySwap += "\n";

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
                _PortFolioData.TableName = "FlowSwap";

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

        public static DataTable LoadFlow(DateTime processdate, string systemid, string id)
        {

            String _QueryFlow = "";

            #region "Query Flow"

            _QueryFlow += "SET NOCOUNT ON\n\n";

            _QueryFlow += "SELECT 'ID'                       = SF.id\n";
            _QueryFlow += "     , 'SensibilitiesDate'        = SF.sensibilitiesdate\n";
            _QueryFlow += "     , 'System'                   = SF.system\n";
            _QueryFlow += "     , 'DataID'                   = SF.dataid\n";
            _QueryFlow += "     , 'OperationID'              = SF.operationid\n";
            _QueryFlow += "     , 'LegID'                    = SF.legid\n";
            _QueryFlow += "     , 'FixingDate'               = SF.fixingdate\n";
            _QueryFlow += "     , 'StartingDate'             = SF.startingdate\n";
            _QueryFlow += "     , 'ExpiryDate'               = SF.expirydate\n";
            _QueryFlow += "     , 'PaymentDate'              = SF.paymentdate\n";
            _QueryFlow += "     , 'Balance'                  = SF.balance\n";
            _QueryFlow += "     , 'OutStanding'              = SF.balance + SF.amortizationflow\n";
            _QueryFlow += "     , 'ExchangePrincipal'        = SF.exchangeprincipal\n";
            _QueryFlow += "     , 'PostPounding'             = SF.postpounding\n";
            _QueryFlow += "     , 'Rate'                     = SF.rate\n";
            _QueryFlow += "     , 'Spread'                   = SF.spread\n";
            _QueryFlow += "     , 'AmortizationFlow'         = SF.amortizationflow\n";
            _QueryFlow += "     , 'InterestFlow'             = SF.interestflow\n";
            _QueryFlow += "     , 'AditionalFlow'            = SF.aditionalflow\n";
            _QueryFlow += "     , 'TotalFlow'                = SF.totalflow\n";
            _QueryFlow += "     , 'RateDicount'              = SF.ratediscount\n";
            _QueryFlow += "     , 'WellFactor'               = SF.wellfactor\n";
            _QueryFlow += "     , 'AmortizationPresentValue' = SF.amortizationpresentvalue\n";
            _QueryFlow += "     , 'InterestPresentValue'     = SF.interestpresentvalue\n";
            _QueryFlow += "     , 'AditionalPresentValue'    = SF.aditionalpresentvalue\n";
            _QueryFlow += "     , 'PresentValue'             = SF.presentvalue\n";
            _QueryFlow += "  FROM dbo.SensibilitiesData SD\n";
            _QueryFlow += "       INNER JOIN dbo.SensibilitiesFlow SF ON SF.DataID = SD.id\n";
            _QueryFlow += " WHERE SD.sensibilitiesdate      = '" + processdate.ToString("yyyyMMdd") + "'\n";
            _QueryFlow += "   AND SD.system                 = '" + systemid + "'\n";

            if (!id.Equals(""))
            {
                //_QueryFlow += " AND (" + conditions + ")\n";
                _QueryFlow += " AND  SF.dataid= '" + id + "' \n";
            }

            _QueryFlow += "\n";

            _QueryFlow += "SET NOCOUNT OFF\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryFlow);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "Flow";

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
