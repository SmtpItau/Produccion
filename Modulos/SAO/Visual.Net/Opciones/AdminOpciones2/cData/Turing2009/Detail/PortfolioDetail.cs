using System;
using System.Collections.Generic;
using System.Text;
using System.Data;


namespace cData.Turing2009.Detail
{
    public static class  PortfolioDetail
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        public static DataTable LoadSensibilitiesFixingRate(DateTime portFolioDate, string conditions)
        {

            String _QueryRateFixing = "";

            #region "Query Fixing Rate"

            _QueryRateFixing += "DECLARE @DateProcess                   DATETIME\n\n";

            _QueryRateFixing += "SET @DateProcess = [@DateProcess]\n\n";

            _QueryRateFixing += "SELECT 'DocumentNumber'              = SY.documentnumber\n";
            _QueryRateFixing += "     , 'OperationNumber'             = SY.operationnumber\n";
            _QueryRateFixing += "     , 'OperationID'                 = SY.operationid\n";
            _QueryRateFixing += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
            _QueryRateFixing += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
            _QueryRateFixing += "  INTO #tmpSensibilities\n";
            _QueryRateFixing += "  FROM dbo.SensibilitiesYield SY\n";
            _QueryRateFixing += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
            _QueryRateFixing += "   AND SY.system                     = 'BTR'\n";
            _QueryRateFixing += " GROUP BY\n";
            _QueryRateFixing += "       SY.DocumentNumber\n";
            _QueryRateFixing += "     , SY.OperationNumber\n";
            _QueryRateFixing += "     , SY.OperationID\n\n";

            _QueryRateFixing += "SELECT 'Status'                       = CASE WHEN SD.expirydate   = @DateProcess  THEN 2 -- vencidas\n"; 
            _QueryRateFixing += "  WHEN SFR.contractdate = @DateProcess THEN 3 -- Nuevas  \n";
            _QueryRateFixing += "  ELSE 1 -- Vigente\n";  
            _QueryRateFixing += "  END\n";
            _QueryRateFixing += "     , 'System'                      = SD.system\n";
            _QueryRateFixing += "     , 'DSystem'                     = 'RENTA FIJA'\n";
            _QueryRateFixing += "     , 'Book'                        = SD.bookid\n";
            _QueryRateFixing += "     , 'PortFolioRules'              = SD.portfoliorulesid\n";
            _QueryRateFixing += "     , 'FinancialPortFolio'          = SD.financialportfolioid\n";
            _QueryRateFixing += "     , 'Product'                     = SD.productid\n";
            _QueryRateFixing += "     , 'IssueID'                     = SD.issueid\n";
            _QueryRateFixing += "     , 'ExpiryDate'                  = SD.expirydate\n";
            _QueryRateFixing += "     , 'DocumentNumber'              = SD.documentnumber\n";
            _QueryRateFixing += "     , 'OperationNumber'             = SD.operationnumber\n";
            _QueryRateFixing += "     , 'OperationID'                 = SD.operationid\n";
            _QueryRateFixing += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
            _QueryRateFixing += "     , 'MNemonics'                   = SD.mnemonics\n";
            _QueryRateFixing += "     , 'CustomerID'                  = SD.customerid\n";
            _QueryRateFixing += "     , 'CustomerCode'                = SD.customercode\n";
            _QueryRateFixing += "     , 'CustomerName'                = CAST( '' AS VARCHAR(40) )\n";
            _QueryRateFixing += "     , 'Nominal'                     = SFR.nominal\n";
            _QueryRateFixing += "     , 'CurrencyIssue'               = SFR.currencyissue\n";
            _QueryRateFixing += "     , 'MarktoMarketValueYesterday'  = SFR.marktomarketvalueyesterday\n";
            _QueryRateFixing += "     , 'MarktoMarketValueToday'      = SFR.marktomarketvaluetoday\n";
            _QueryRateFixing += "     , 'MarktoMarketValueTodayUM'    = SFR.MarktoMarketValueTodayUM\n";
            _QueryRateFixing += "     , 'TimeDecayValue'              = SFR.marktomarketvaluetimedecay\n";
            _QueryRateFixing += "     , 'ExchangeRateValue'           = SFR.marktomarketvalueexchangerate\n";
            _QueryRateFixing += "     , 'EffectRateValue'             = SFR.marktomarketvalueeffectrate\n";
            _QueryRateFixing += "     , 'CashFlow'                    = SFR.CashFlow\n";
            _QueryRateFixing += "     , 'MarktoMarketRateYesterday'   = SFR.marktomarketrateyesterday\n";
            _QueryRateFixing += "     , 'MarktoMarketRateToday'       = SFR.marktomarketratetoday\n";
            _QueryRateFixing += "     , 'MarktoMarketRateEndMonth'    = SFR.marktomarketrateendmonth\n";
            _QueryRateFixing += "     , 'MacaulayDuration'            = SFR.macaulayduration\n";
            _QueryRateFixing += "     , 'ModifiedDuration'            = SFR.modifiedduration\n";
            _QueryRateFixing += "     , 'Convexity'                   = SFR.convexity\n";
            _QueryRateFixing += "     , 'ContractDate'                = SFR.contractdate\n";
            _QueryRateFixing += "     , 'PurchaseRate'                = SFR.purchaserate\n";
            _QueryRateFixing += "     , 'PurchaseValue'               = SFR.purchasevalue\n";
            _QueryRateFixing += "     , 'PurchaseValueUM'             = SFR.purchasevalueum\n";
            _QueryRateFixing += "     , 'PresentValueOriginSystem'    = SFR.presentvalueoriginsystem\n";
            _QueryRateFixing += "     , 'FairValueAssetSystem'        = SFR.fairvalueassetsystem\n";
            _QueryRateFixing += "     , 'FairValueLiabilitiesSystem'  = SFR.fairvalueliabilitiessystem\n";
            _QueryRateFixing += "     , 'FairValueNetSystem'          = SFR.fairvaluenetsystem\n";
            _QueryRateFixing += "     , 'AccruedInterestSystem'       = SFR.accruedinterestsystem\n";
            _QueryRateFixing += "     , 'DailyInterestSystem'         = SFR.dailyinterestsystem\n";
            _QueryRateFixing += "     , 'MonthlyInterestSystem'       = SFR.monthlyinterestsystem\n";
            _QueryRateFixing += "     , 'AccruedAdjustmentSystem'     = SFR.accruedadjustmentsystem\n";
            _QueryRateFixing += "     , 'DailyAdjustmentSystem'       = SFR.dailyadjustmentsystem\n";
            _QueryRateFixing += "     , 'MonthlyAdjustmentSystem'     = SFR.monthlyadjustmentsystem\n";
            _QueryRateFixing += "     , 'MacaulayDurationSystem'      = SFR.macaulaydurationsystem\n";
            _QueryRateFixing += "     , 'ModifiedDurationSystem'      = SFR.modifieddurationsystem\n";
            _QueryRateFixing += "     , 'ConvexitySystem'             = SFR.convexitysystem\n";
            _QueryRateFixing += "     , 'CourtDateCoupon'             = SFR.courtdatecoupon\n";
            _QueryRateFixing += "     , 'Sensibilities'               = CASE WHEN SFR.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
            _QueryRateFixing += "     , 'Estimation'                  = CASE WHEN SFR.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
            _QueryRateFixing += "     , 'Accrual'                     = SFR.dailyinterestsystem + SFR.dailyadjustmentsystem\n";
            _QueryRateFixing += "     , 'CarryCost'                   = SFR.CorryCost\n";
            _QueryRateFixing += "     , 'AVR'                         = CASE WHEN SFR.SalesValue <> 0\n";
            _QueryRateFixing += "                                            THEN 0\n";
            _QueryRateFixing += "                                            ELSE (SFR.marktomarketvaluetoday - SFR.presentvaluetoday) - (SFR.marktomarketvalueyesterday - SFR.presentvalueyesterday)\n";
            _QueryRateFixing += "                                       END\n";
            _QueryRateFixing += "     , 'PriceDifference'             = CASE WHEN SFR.SalesValue = 0 THEN 0 ELSE SFR.SalesValue - SFR.presentvaluetoday END\n";
            _QueryRateFixing += "  FROM dbo.SensibilitiesData                    SD\n";
            _QueryRateFixing += "       INNER JOIN dbo.SensibilitiesFixingRate   SFR    ON SD.ID       = SFR.ID\n";
            _QueryRateFixing += "       INNER JOIN #tmpSensibilities             SY     ON SD.documentnumber    = SY.documentnumber\n";
            _QueryRateFixing += "                                                      AND SD.operationnumber   = SY.operationnumber\n";
            _QueryRateFixing += "                                                      AND SD.operationid       = SY.operationid\n";
            _QueryRateFixing += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
            _QueryRateFixing += "   AND SD.system                     = 'BTR'\n";

            if (!conditions.Equals(""))
            {
                _QueryRateFixing += " AND (" + conditions + ")\n";
            }

            _QueryRateFixing += " ORDER BY\n";
            _QueryRateFixing += "       DocumentNumber\n";
            _QueryRateFixing += "     , OperationNumber\n";
            _QueryRateFixing += "     , OperationID\n\n";

            _QueryRateFixing += "DROP TABLE #tmpSensibilities\n";

            _QueryRateFixing = _QueryRateFixing.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFixing);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "OperationFixingRate";

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

        public static DataTable LoadSensibilitiesForward(DateTime portFolioDate, string conditions)
        {

            String _QueryForward = "";

            #region "Query Forward"

            _QueryForward += "SET NOCOUNT ON\n\n";

            _QueryForward += "DECLARE @DateProcess                   DATETIME\n";
            _QueryForward += "DECLARE @UFValue                       FLOAT\n\n";

            _QueryForward += "SET @DateProcess = [@DateProcess]\n";

            _QueryForward += "SELECT @UFValue     = currencyvaluetoday\n";
            _QueryForward += "  FROM dbo.ExchangeValue\n";
            _QueryForward += " WHERE currencydate = @DateProcess\n";
            _QueryForward += "   AND currencyid   = 998\n\n";
            
            _QueryForward += "SELECT 'OperationNumber'             = SY.operationnumber\n";
            _QueryForward += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
            _QueryForward += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
            _QueryForward += "  INTO #tmpSensibilities\n";
            _QueryForward += "  FROM dbo.SensibilitiesYield SY\n";
            _QueryForward += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
            _QueryForward += "   AND SY.system                     = 'BFW'\n";
            _QueryForward += " GROUP BY\n";
            _QueryForward += "       SY.OperationNumber\n\n";

            _QueryForward += "SELECT 'Status'                       = CASE WHEN SD.expirydate   = @DateProcess  THEN 2 -- vencidas\n";
            _QueryForward += "  WHEN SF.contractdate = @DateProcess THEN 3 -- Nuevas  \n";
            _QueryForward += "  ELSE 1 -- Vigente\n";
            _QueryForward += "  END\n";
            _QueryForward += "     , 'System'                       = SD.system\n";
            _QueryForward += "     , 'DSystem'                      = 'FORWARD'\n";
            _QueryForward += "     , 'Book'                         = SD.bookid\n";
            _QueryForward += "     , 'PortFolioRules'               = SD.portfoliorulesid\n";
            _QueryForward += "     , 'FinancialPortFolio'           = SD.financialportfolioid\n";
            _QueryForward += "     , 'Product'                      = SD.productid\n";
            _QueryForward += "     , 'IssueID'                      = SD.issueid\n";
            _QueryForward += "     , 'IssueName'                    = CAST( '' AS VARCHAR(30) )\n";
            _QueryForward += "     , 'ExpiryDate'                   = SD.expirydate\n";
            _QueryForward += "     , 'OperationNumber'              = SD.operationnumber\n";
            _QueryForward += "     , 'OperationID'                  = SD.operationid\n";
            _QueryForward += "     , 'CustomerID'                   = SD.customerid\n";
            _QueryForward += "     , 'MNemonicsMask'                = SD.mnemonicsmask\n";
            _QueryForward += "     , 'CustomerCode'                 = SD.customercode\n";
            _QueryForward += "     , 'CustomerName'                 = CAST( '' AS VARCHAR(30) )\n";
            _QueryForward += "     , 'EffectiveDate'                = SF.effectivedate\n";
            _QueryForward += "     , 'TermToday'                    = SF.termtoday\n";
            _QueryForward += "     , 'RateCurrencyPrimaryToday'     = SF.ratecurrencyprimarytoday\n";
            _QueryForward += "     , 'RateCurrencySecondToday'      = ratecurrencysecondtoday\n";
            _QueryForward += "     , 'TermYesterday'                = SF.termyesterday\n";
            _QueryForward += "     , 'RateCurrencyPrimaryYesterday' = SF.ratecurrencyprimaryyesterday\n";
            _QueryForward += "     , 'RateCurrencySecondYesterday'  = ratecurrencysecondyesterday\n";
            _QueryForward += "     , 'PrimaryCurrency'              = SD.primarycurrencyid\n";
            _QueryForward += "     , 'OperationType'                = SF.operationtype\n";
            _QueryForward += "     , 'PaymentType'                  = SF.paymenttype\n";
            _QueryForward += "     , 'UnWind'                       = SF.unwind\n";
            _QueryForward += "     , 'AdvancePointCost'             = SF.advancepointcost\n";
            _QueryForward += "     , 'AdvancePointForward'          = SF.advancepointforward\n";
            _QueryForward += "     , 'PrimaryAmount'                = SF.primaryamount\n";
            _QueryForward += "     , 'SecondaryCurrency'            = SD.secondcurrencyid\n";
            _QueryForward += "     , 'SecondaryAmount'              = SF.secondaryamount\n";
            _QueryForward += "     , 'PriceForward'                 = SF.priceforward\n";
            _QueryForward += "     , 'PricePointForward'            = SF.pricepointforward\n";
            _QueryForward += "     , 'UF'                           = CASE WHEN SD.secondcurrencyid = 998 THEN @UFValue ELSE 0.0 END\n";
            _QueryForward += "     , 'PriceCost'                    = SF.pricecost\n";
            _QueryForward += "     , 'PriceForwardTheory'           = SF.priceforwardtheory\n";
            _QueryForward += "     , 'ContractDate'                 = SF.contractdate\n";
            _QueryForward += "     , 'MarktoMarketValueYesterday'   = SF.marktomarketvalueyesterday\n";
            _QueryForward += "     , 'MarktoMarketValueToday'       = SF.marktomarketvaluetoday\n";
            _QueryForward += "     , 'MarktoMarketValueTodayUM'     = SF.marktomarketvaluetodayum\n";
            _QueryForward += "     , 'TimeDecayValue'               = SF.marktomarketvaluetimedecay\n";
            _QueryForward += "     , 'ExchangeRateValue'            = SF.marktomarketvalueexchangerate\n";
            _QueryForward += "     , 'EffectRateValue'              = SF.marktomarketvalueeffectrate\n";
            _QueryForward += "     , 'CashFlow'                     = SF.cashflow\n";
            _QueryForward += "     , 'ResultDistribution'           = SF.resultdistribution\n";
            _QueryForward += "     , 'MarktoMarketRateYesterday'    = SF.marktomarketrateyesterday\n";
            _QueryForward += "     , 'MarktoMarketRateToday'        = SF.marktomarketratetoday\n";
            _QueryForward += "     , 'MarktoMarketRateEndMonth'     = SF.marktomarketrateendmonth\n";
            _QueryForward += "     , 'FairValueAssetSystem'         = SF.fairvalueassetsystem\n";
            _QueryForward += "     , 'FairValueLiabilitiesSystem'   = SF.fairvalueliabilitiessystem\n";
            _QueryForward += "     , 'FairValueNetSystem'           = SF.fairvaluenetsystem\n";
            _QueryForward += "     , 'Sensibilities'                = CASE WHEN SF.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
            _QueryForward += "     , 'Estimation'                   = CASE WHEN SF.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
            _QueryForward += "     , 'TransferDistribution'         = CASE WHEN SF.contractdate = SD.sensibilitiesdate THEN SF.transferdistribution ELSE 0 END\n";
            _QueryForward += "     , 'MarktoMarketSpot'             = SF.marktomarketeffectrate\n";
            _QueryForward += "     , 'PointForward'                 = SF.pointforward\n";
            _QueryForward += "     , 'CarryRateUSD'                 = SF.carryrateusd\n";
            _QueryForward += "     , 'CostCarry'                    = SF.carrycostvalue\n";
            _QueryForward += "  FROM dbo.SensibilitiesData                    SD\n";
            _QueryForward += "       INNER JOIN dbo.SensibilitiesForward      SF     ON SD.ID                = SF.ID\n";
            _QueryForward += "       INNER JOIN #tmpSensibilities             SY     ON SD.operationnumber   = SY.operationnumber\n";
            _QueryForward += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
            _QueryForward += "   AND SD.system                     = 'BFW'\n";
            _QueryForward += "   AND SD.productid                 <> '10'\n";

            if (!conditions.Equals(""))
            {
                _QueryForward += " AND (" + conditions + ")\n";
            }

            _QueryForward += " ORDER BY OperationNumber, OperationID\n\n";

            _QueryForward += "DROP TABLE #tmpSensibilities\n\n";

            _QueryForward += "SET NOCOUNT OFF\n\n";

            _QueryForward = _QueryForward.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryForward);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "OperationForward";

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

        public static DataTable LoadSensibilitiesForwardBondsTrader(DateTime portFolioDate, string conditions)
        {

            String _QueryForwardBondsTrader = "";

            #region "Query Forward Bonds Trader"

            _QueryForwardBondsTrader += "DECLARE @DateProcess                   DATETIME\n";

            _QueryForwardBondsTrader += "SET @DateProcess = [@DateProcess]\n";

            _QueryForwardBondsTrader += "SELECT 'DocumentNumber'              = SY.documentnumber\n";
            _QueryForwardBondsTrader += "     , 'OperationNumber'             = SY.operationnumber\n";
            _QueryForwardBondsTrader += "     , 'OperationID'                 = SY.operationid\n";
            _QueryForwardBondsTrader += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
            _QueryForwardBondsTrader += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
            _QueryForwardBondsTrader += "  INTO #tmpSensibilities\n";
            _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesYield SY\n";
            _QueryForwardBondsTrader += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
            _QueryForwardBondsTrader += "   AND SY.system                     = 'BFW'\n";
            _QueryForwardBondsTrader += " GROUP BY\n";
            _QueryForwardBondsTrader += "       SY.DocumentNumber\n";
            _QueryForwardBondsTrader += "     , SY.OperationNumber\n";
            _QueryForwardBondsTrader += "     , SY.OperationID\n\n";

            _QueryForwardBondsTrader += "SELECT 'Status'                       = CASE WHEN SD.expirydate   = @DateProcess  THEN 2 -- vencidas\n";
            _QueryForwardBondsTrader += "  WHEN SFBT.contractdate = @DateProcess THEN 3 -- Nuevas  \n";
            _QueryForwardBondsTrader += "  ELSE 1 -- Vigente\n";
            _QueryForwardBondsTrader += "  END\n";       
            _QueryForwardBondsTrader += "     ,'System'                      = SD.system\n";
            _QueryForwardBondsTrader += "     , 'DSystem'                     = 'FORWARD RENTA FIJA'\n";
            _QueryForwardBondsTrader += "     , 'Book'                        = SD.bookid\n";
            _QueryForwardBondsTrader += "     , 'PortFolioRules'              = SD.portfoliorulesid\n";
            _QueryForwardBondsTrader += "     , 'FinancialPortFolio'          = SD.financialportfolioid\n";
            _QueryForwardBondsTrader += "     , 'Product'                     = SD.productid\n";
            _QueryForwardBondsTrader += "     , 'IssueID'                     = SD.issueid\n";
            _QueryForwardBondsTrader += "     , 'IssueName'                   = CAST( '' AS VARCHAR(40) )\n";
            _QueryForwardBondsTrader += "     , 'ExpiryDate'                  = SD.expirydate\n";
            _QueryForwardBondsTrader += "     , 'OperationNumber'             = SD.operationnumber\n";
            _QueryForwardBondsTrader += "     , 'OperationID'                 = SD.operationid\n";
            _QueryForwardBondsTrader += "     , 'CustomerID'                  = SD.customerid\n";
            _QueryForwardBondsTrader += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
            _QueryForwardBondsTrader += "     , 'MNemonics'                   = SD.mnemonics\n";
            _QueryForwardBondsTrader += "     , 'CustomerCode'                = SD.customercode\n";
            _QueryForwardBondsTrader += "     , 'CustomerName'                = CAST( '' AS VARCHAR(40) )\n";
            _QueryForwardBondsTrader += "     , 'OperationType'               = SFBT.operationtype\n";
            _QueryForwardBondsTrader += "     , 'Nominal'                     = SFBT.nominal\n";
            _QueryForwardBondsTrader += "     , 'CurrencyIssue'               = SFBT.currencyissue\n";
            _QueryForwardBondsTrader += "     , 'RateForwardTheory'           = SFBT.rateforwardtheory\n";
            _QueryForwardBondsTrader += "     , 'ContractDate'                = SFBT.contractdate\n";
            _QueryForwardBondsTrader += "     , 'MarktoMarketValueYesterday'  = SFBT.marktomarketvalueyesterday\n";
            _QueryForwardBondsTrader += "     , 'MarktoMarketValueToday'      = SFBT.marktomarketvaluetoday\n";
            _QueryForwardBondsTrader += "     , 'MarktoMarketValueTodayUM'    = SFBT.marktomarketvaluetodayum\n";
            _QueryForwardBondsTrader += "     , 'TimeDecayValue'              = SFBT.marktomarketvaluetimedecay\n";
            _QueryForwardBondsTrader += "     , 'ExchangeRateValue'           = SFBT.marktomarketvalueexchangerate\n";
            _QueryForwardBondsTrader += "     , 'EffectRateValue'             = SFBT.marktomarketvalueeffectrate\n";
            _QueryForwardBondsTrader += "     , 'CashFlow'                    = SFBT.CashFlow\n";
            _QueryForwardBondsTrader += "     , 'MarktoMarketRateYesterday'   = SFBT.marktomarketrateyesterday\n";
            _QueryForwardBondsTrader += "     , 'MarktoMarketRateToday'       = SFBT.marktomarketratetoday\n";
            _QueryForwardBondsTrader += "     , 'MarktoMarketRateEndMonth'    = SFBT.marktomarketrateendmonth\n";
            _QueryForwardBondsTrader += "     , 'MacaulayDuration'            = SFBT.macaulayduration\n";
            _QueryForwardBondsTrader += "     , 'ModifiedDuration'            = SFBT.modifiedduration\n";
            _QueryForwardBondsTrader += "     , 'Convexity'                   = SFBT.convexity\n";
            _QueryForwardBondsTrader += "     , 'RateContract'                = SFBT.ratecontract\n";
            _QueryForwardBondsTrader += "     , 'FairValueAssetSystem'        = SFBT.fairvalueassetsystem\n";
            _QueryForwardBondsTrader += "     , 'FairValueLiabilitiesSystem'  = SFBT.fairvalueliabilitiessystem\n";
            _QueryForwardBondsTrader += "     , 'FairValueNetSystem'          = SFBT.fairvaluenetsystem\n";
            _QueryForwardBondsTrader += "     , 'MacaulayDurationSystem'      = SFBT.macaulaydurationsystem\n";
            _QueryForwardBondsTrader += "     , 'ModifiedDurationSystem'      = SFBT.modifieddurationsystem\n";
            _QueryForwardBondsTrader += "     , 'ConvexitySystem'             = SFBT.convexitysystem\n";
            _QueryForwardBondsTrader += "     , 'Sensibilities'               = CASE WHEN SFBT.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
            _QueryForwardBondsTrader += "     , 'Estimation'                  = CASE WHEN SFBT.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
            _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesData                            SD\n";
            _QueryForwardBondsTrader += "       INNER JOIN dbo.SensibilitiesForwardBondsTrader   SFBT   ON SD.ID       = SFBT.ID\n";
            _QueryForwardBondsTrader += "       INNER JOIN #tmpSensibilities             SY     ON SD.operationnumber   = SY.operationnumber\n";
            _QueryForwardBondsTrader += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
            _QueryForwardBondsTrader += "   AND SD.system                     = 'BFW'\n";
            _QueryForwardBondsTrader += "   AND SD.productid                  = '10'\n";

            if (!conditions.Equals(""))
            {
                _QueryForwardBondsTrader += " AND (" + conditions + ")\n";
            }

            _QueryForwardBondsTrader += " ORDER BY OperationNumber, OperationID\n\n";

            _QueryForwardBondsTrader += "DROP TABLE #tmpSensibilities\n\n";

            _QueryForwardBondsTrader = _QueryForwardBondsTrader.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryForwardBondsTrader);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "OperationForwardBondsTrader";

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

        public static DataTable LoadSensibilitiesSwap(DateTime portFolioDate, string conditions)
        {

            String _QuerySwap = "";

            #region "Query Swap"

            _QuerySwap += "DECLARE @DateProcess                   DATETIME\n\n";

            _QuerySwap += "SET @DateProcess = [@DateProcess]\n\n";

            _QuerySwap += "SELECT 'OperationNumber'             = SY.operationnumber\n";
            _QuerySwap += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
            _QuerySwap += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
            _QuerySwap += "  INTO #tmpSensibilities\n";
            _QuerySwap += "  FROM dbo.SensibilitiesYield SY\n";
            _QuerySwap += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
            _QuerySwap += "   AND SY.system                     = 'PCS'\n";
            _QuerySwap += " GROUP BY\n";
            _QuerySwap += "       SY.OperationNumber\n";




            _QuerySwap += "SELECT 'Status'                       = CASE WHEN SD.expirydate   = @DateProcess AND SW.status <> 'A' THEN 2 -- vencidas\n";
            _QuerySwap += "WHEN SW.contractdate = @DateProcess                      THEN 3 -- Nuevas \n";
            _QuerySwap += "WHEN SD.expirydate   = @DateProcess AND SW.status = 'A'  THEN 4 -- Anticipadas \n";
            _QuerySwap += "ELSE 1 -- Vigente \n";
            _QuerySwap += "END \n";
            _QuerySwap += "     ,    'System'                       = SD.system\n";
            _QuerySwap += "     , 'DSystem'                      = 'SWAP'\n";
            _QuerySwap += "     , 'Book'                         = SD.bookid\n";
            _QuerySwap += "     , 'PortFolioRules'               = SD.portfoliorulesid\n";
            _QuerySwap += "     , 'FinancialPortFolio'           = SD.financialportfolioid\n";
            _QuerySwap += "     , 'Product'                      = SD.productid\n";
            _QuerySwap += "     , 'IssueID'                      = SD.issueid\n";
            _QuerySwap += "     , 'IssueName'                    = CAST( '' AS VARCHAR(40) )\n";
            _QuerySwap += "     , 'ExpiryDate'                   = SD.expirydate\n";
            _QuerySwap += "     , 'OperationNumber'              = SD.operationnumber\n";
            _QuerySwap += "     , 'OperationID'                  = SD.operationid\n";
            _QuerySwap += "     , 'CustomerID'                   = SD.customerid\n";
            _QuerySwap += "     , 'MNemonicsMask'                = SD.mnemonicsmask\n";
            _QuerySwap += "     , 'CustomerCode'                 = SD.customercode\n";
            _QuerySwap += "     , 'CustomerName'                 = CAST( '' AS VARCHAR(40) )\n";
            _QuerySwap += "     , 'PrimaryCurrency'              = SD.primarycurrencyid\n";
            _QuerySwap += "     , 'PrimaryRateID'                = SD.primaryrateid\n";
            _QuerySwap += "     , 'ContractDate'                 = SW.contractdate\n";
            _QuerySwap += "     , 'AmountAsset'                  = SW.amountasset\n";
            _QuerySwap += "     , 'SecondaryCurrency'            = SD.secondcurrencyid\n";
            _QuerySwap += "     , 'SecondRateID'                 = SD.secondrateid\n";
            _QuerySwap += "     , 'AmountLiabilities'            = SW.amountliabilities\n";
            _QuerySwap += "     , 'FairValueAsset'               = SW.fairvalueasset\n";
            _QuerySwap += "     , 'FairValueAssetUM'             = SW.fairvalueassetum\n";
            _QuerySwap += "     , 'FairValueLiabilities'         = SW.fairvalueliabilities\n";
            _QuerySwap += "     , 'FairValueLiabilitiesUM'       = SW.fairvalueliabilitiesum\n";
            _QuerySwap += "     , 'MarktoMarketValueYesterday'   = SW.marktomarketvalueyesterday\n";
            _QuerySwap += "     , 'MarktoMarketValueToday'       = SW.marktomarketvaluetoday\n";
            _QuerySwap += "     , 'MarktoMarketValueTodayUM'     = SW.marktomarketvaluetodayum\n";
            _QuerySwap += "     , 'TimeDecayValue'               = SW.marktomarketvaluetimedecay\n";
            _QuerySwap += "     , 'ExchangeRateValue'            = CASE WHEN SD.primarycurrencyid <> 998 AND SD.primarycurrencyid <> 999 THEN SW.exchangerateasset - SW.fairvalueassetyesterday       ELSE 0 END +\n";
            _QuerySwap += "                                        CASE WHEN SD.secondcurrencyid  <> 998 AND SD.secondcurrencyid  <> 999 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities ELSE 0 END\n";
            _QuerySwap += "     , 'Readjustment'                 = CASE WHEN SD.primarycurrencyid = 998 THEN SW.exchangerateasset - SW.fairvalueassetyesterday       ELSE 0 END +\n";
            _QuerySwap += "                                        CASE WHEN SD.secondcurrencyid  = 998 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities ELSE 0 END\n";
            _QuerySwap += "     , 'EffectRateValue'              = SW.marktomarketvalueeffectrate\n";
            _QuerySwap += "     , 'CashFlow'                     = SW.cashflow\n";
            _QuerySwap += "     , 'MarktoMarketRateYesterday'    = SW.marktomarketrateyesterday\n";
            _QuerySwap += "     , 'MarktoMarketRateToday'        = SW.marktomarketratetoday\n";
            _QuerySwap += "     , 'MarktoMarketRateEndMonth'     = SW.marktomarketrateendmonth\n";
            _QuerySwap += "     , 'FairValueAssetSystem'         = SW.fairvalueassetsystem\n";
            _QuerySwap += "     , 'FairValueAssetUMSystem'       = SW.fairvalueassetumsystem\n";
            _QuerySwap += "     , 'FairValueLiabilitiesSystem'   = SW.fairvalueliabilitiessystem\n";
            _QuerySwap += "     , 'FairValueLiabilitiesUMSystem' = SW.fairvalueliabilitiesumsystem\n";
            _QuerySwap += "     , 'FairValueNetSystem'           = SW.fairvaluenetsystem\n";
            _QuerySwap += "     , 'CourtDateCouponAsset'         = SW.courtdatecouponasset\n";
            _QuerySwap += "     , 'CourtDateCouponLiabilities'   = SW.courtdatecouponliabilities\n";
            _QuerySwap += "     , 'Sensibilities'                = CASE WHEN SW.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
            _QuerySwap += "     , 'Estimation'                   = CASE WHEN SW.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";            
            _QuerySwap += "     , 'DeltaMTMYesterday'            = CASE WHEN SW.contractdate <> SD.sensibilitiesdate THEN SW.fairvaluenetportfolioyesterday - SW.fairvaluenetyesterday ELSE 0 END\n";
            _QuerySwap += "  FROM dbo.SensibilitiesData                    SD\n";
            _QuerySwap += "       INNER JOIN dbo.SensibilitiesSwap         SW     ON SD.ID              = SW.ID\n";
            _QuerySwap += "       INNER JOIN #tmpSensibilities             SY     ON SD.OperationNumber = SY.OperationNumber\n";

            _QuerySwap += " WHERE SD.sensibilitiesdate           = @DateProcess\n";
            _QuerySwap += "   AND SD.system                      = 'PCS'\n";

            if (!conditions.Equals(""))
            {
                _QuerySwap += " AND (" + conditions + ")\n";
            }

            _QuerySwap += " ORDER BY OperationNumber, OperationID\n\n";

            _QuerySwap += "DROP TABLE #tmpSensibilities\n";

            _QuerySwap = _QuerySwap.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _PortFolioData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySwap);
                _PortFolioData = _Connect.QueryDataTable();
                _PortFolioData.TableName = "OperationSWAP";

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
