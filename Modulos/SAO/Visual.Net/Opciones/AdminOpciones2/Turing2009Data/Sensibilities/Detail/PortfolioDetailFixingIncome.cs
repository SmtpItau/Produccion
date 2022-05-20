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

    public class PortfolioDetailFixingIncome : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate, string conditions)
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

            _FixingIncome += "DECLARE @DateProcess                   DATETIME\n\n";

            _FixingIncome += "SET @DateProcess = [@DateProcess]\n\n";

            _FixingIncome += "SELECT 'Status'                      = CASE WHEN SD.expirydate   = @DateProcess  THEN 2 -- vencidas\n";
            _FixingIncome += "                                            WHEN SFR.contractdate = @DateProcess THEN 3 -- Nuevas  \n";
            _FixingIncome += "                                            ELSE 1 -- Vigente\n";
            _FixingIncome += "                                       END\n";
            _FixingIncome += "     , 'System'                      = SD.system\n";
            _FixingIncome += "     , 'DSystem'                     = 'RENTA FIJA'\n";
            _FixingIncome += "     , 'Book'                        = SD.bookid\n";
            _FixingIncome += "     , 'PortFolioRules'              = SD.portfoliorulesid\n";
            _FixingIncome += "     , 'FinancialPortFolio'          = SD.financialportfolioid\n";
            _FixingIncome += "     , 'Product'                     = SD.productid\n";
            _FixingIncome += "     , 'IssueID'                     = SD.issueid\n";
            _FixingIncome += "     , 'ExpiryDate'                  = SD.expirydate\n";
            _FixingIncome += "     , 'DocumentNumber'              = SD.documentnumber\n";
            _FixingIncome += "     , 'OperationNumber'             = SD.operationnumber\n";
            _FixingIncome += "     , 'OperationID'                 = SD.operationid\n";
            _FixingIncome += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
            _FixingIncome += "     , 'MNemonics'                   = SD.mnemonics\n";
            _FixingIncome += "     , 'CustomerID'                  = SD.customerid\n";
            _FixingIncome += "     , 'CustomerCode'                = SD.customercode\n";
            _FixingIncome += "     , 'CustomerName'                = CAST( '' AS VARCHAR(40) )\n";
            _FixingIncome += "     , 'Nominal'                     = SFR.nominal\n";
            _FixingIncome += "     , 'CurrencyIssue'               = SFR.currencyissue\n";
            _FixingIncome += "     , 'MarktoMarketValueYesterday'  = SFR.marktomarketvalueyesterday\n";
            _FixingIncome += "     , 'MarktoMarketValueToday'      = SFR.marktomarketvaluetoday\n";
            _FixingIncome += "     , 'MarktoMarketValueTodayUM'    = SFR.MarktoMarketValueTodayUM\n";
            _FixingIncome += "     , 'TimeDecayValue'              = SFR.marktomarketvaluetimedecay\n";
            _FixingIncome += "     , 'ExchangeRateValue'           = SFR.marktomarketvalueexchangerate\n";
            _FixingIncome += "     , 'EffectRateValue'             = SFR.marktomarketvalueeffectrate\n";
            _FixingIncome += "     , 'CashFlow'                    = SFR.CashFlow\n";
            _FixingIncome += "     , 'MarktoMarketRateYesterday'   = SFR.marktomarketrateyesterday\n";
            _FixingIncome += "     , 'MarktoMarketRateToday'       = SFR.marktomarketratetoday\n";
            _FixingIncome += "     , 'MarktoMarketRateEndMonth'    = SFR.marktomarketrateendmonth\n";
            _FixingIncome += "     , 'MacaulayDuration'            = SFR.macaulayduration\n";
            _FixingIncome += "     , 'ModifiedDuration'            = SFR.modifiedduration\n";
            _FixingIncome += "     , 'Convexity'                   = SFR.convexity\n";
            _FixingIncome += "     , 'ContractDate'                = SFR.contractdate\n";
            _FixingIncome += "     , 'PurchaseRate'                = SFR.purchaserate\n";
            _FixingIncome += "     , 'PurchaseValue'               = SFR.purchasevalue\n";
            _FixingIncome += "     , 'PurchaseValueUM'             = SFR.purchasevalueum\n";
            _FixingIncome += "     , 'PresentValueOriginSystem'    = SFR.presentvalueoriginsystem\n";
            _FixingIncome += "     , 'FairValueAssetSystem'        = SFR.fairvalueassetsystem\n";
            _FixingIncome += "     , 'FairValueLiabilitiesSystem'  = SFR.fairvalueliabilitiessystem\n";
            _FixingIncome += "     , 'FairValueNetSystem'          = SFR.fairvaluenetsystem\n";
            _FixingIncome += "     , 'AccruedInterestSystem'       = SFR.accruedinterestsystem\n";
            _FixingIncome += "     , 'DailyInterestSystem'         = SFR.dailyinterestsystem\n";
            _FixingIncome += "     , 'MonthlyInterestSystem'       = SFR.monthlyinterestsystem\n";
            _FixingIncome += "     , 'AccruedAdjustmentSystem'     = SFR.accruedadjustmentsystem\n";
            _FixingIncome += "     , 'DailyAdjustmentSystem'       = SFR.dailyadjustmentsystem\n";
            _FixingIncome += "     , 'MonthlyAdjustmentSystem'     = SFR.monthlyadjustmentsystem\n";
            _FixingIncome += "     , 'MacaulayDurationSystem'      = SFR.macaulaydurationsystem\n";
            _FixingIncome += "     , 'ModifiedDurationSystem'      = SFR.modifieddurationsystem\n";
            _FixingIncome += "     , 'ConvexitySystem'             = SFR.convexitysystem\n";
            _FixingIncome += "     , 'CourtDateCoupon'             = SFR.courtdatecoupon\n";
            _FixingIncome += "     , 'Sensibilities'               = CASE WHEN SFR.contractdate = @DateProcess THEN 0.0 ELSE SD.sensibilitiesvalue END\n";
            _FixingIncome += "     , 'Estimation'                  = CASE WHEN SFR.contractdate = @DateProcess THEN 0.0 ELSE SD.estimationvalue    END\n";
            _FixingIncome += "     , 'Accrual'                     = SFR.dailyinterestsystem + SFR.dailyadjustmentsystem\n";
            _FixingIncome += "     , 'CarryCost'                   = SFR.CorryCost\n";
            _FixingIncome += "     , 'AVR'                         = CASE WHEN SFR.SalesValue <> 0\n";
            _FixingIncome += "                                            THEN 0\n";
            _FixingIncome += "                                            ELSE (SFR.marktomarketvaluetoday - SFR.presentvaluetoday) - (SFR.marktomarketvalueyesterday - SFR.presentvalueyesterday)\n";
            _FixingIncome += "                                       END\n";
            _FixingIncome += "     , 'PriceDifference'             = CASE WHEN SFR.SalesValue = 0 THEN 0 ELSE SFR.SalesValue - SFR.presentvaluetoday END\n";
            _FixingIncome += "  FROM dbo.SensibilitiesData                    SD  (INDEX=IX_SensibilitiesData_02)\n";
            _FixingIncome += "       INNER JOIN dbo.SensibilitiesFixingRate   SFR    ON SD.ID       = SFR.ID\n";
            _FixingIncome += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
            _FixingIncome += "   AND SD.system                     = 'BTR'\n";

            if (!conditions.Equals(""))
            {
                _FixingIncome += " AND (" + conditions + ")\n";
            }

            _FixingIncome += " ORDER BY\n";
            _FixingIncome += "       DocumentNumber\n";
            _FixingIncome += "     , OperationNumber\n";
            _FixingIncome += "     , OperationID\n\n";

            _FixingIncome = _FixingIncome.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _FixingIncome, "DetailForwardFixingIncome");
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
