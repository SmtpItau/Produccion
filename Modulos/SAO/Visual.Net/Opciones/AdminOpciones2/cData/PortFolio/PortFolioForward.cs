using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.PortFolio
{

    public class PortFolioForward
    {

        #region "Atributos privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public PortFolioForward()
        {
            Set(enumSource.System);
        }

        public PortFolioForward(enumSource _ID)
        {
            Set(_ID);
        }

        #endregion

        #region "Atributos publicos"

        public enumStatus Status
        {
            get
            {
                return mStatus;
            }
        }

        public String Message
        {
            get
            {
                return ReadMessage(mStatus);
            }
        }

        public String Error
        {
            get
            {
                return mError;
            }
        }

        public String Stack
        {
            get
            {
                return mStack;
            }
        }
        
        #endregion

        #region "Metodos publicos"

        public String ReadMessage(enumStatus status)
        {
            String _Message;

            switch (status)
            {
                case enumStatus.Already:
                    _Message = "La cartera de Forward se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error en la cargar de la cartera de Forward.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error en la cargar de la cartera de Forward.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la cartera de Forward.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Ya fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "Se esta cargando la cartera de Forward.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la cartera de Forward.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro la cartera de Forward.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataSet LoadPortFolio(DateTime portFolioDate)
        {
            DataSet _ForwardPortFolio = new DataSet();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _ForwardPortFolio = _System.LoadPortFolio(portFolioDate);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _ForwardPortFolio = _Bloomberg.LoadPortFolio(portFolioDate);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _ForwardPortFolio = _Excel.LoadPortFolio(portFolioDate);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _ForwardPortFolio = _XML.LoadPortFolio(portFolioDate);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _ForwardPortFolio;

        }

        public void SavePortFolio(DateTime portFolioDate, DataSet portFolioDataSet, int userID)
        {

            #region "Definición de variables"

            int _ContractID;
            int _SensibilitiesRow;
            double _ID;
            double _SensibilitiesID;
            string _Query;
            string _QueryYield;

            DataTable _Yield;
            DataTable _PortFolioT0;
            DataTable _PortFolioT1;
            DataTable _TimeDecay;
            DataTable _ExchangeRate;
            DataTable _EffectRate;

            DataRow _DataRow;
            DataRow _PortFolioT0Row;
            DataRow _PortFolioT1Row;
            DataRow _TimeDecayRow;
            DataRow _ExchangeRateRow;
            DataRow _EffectRateRow;
            DataRow[] _DataRows;

            DateTime _SensibilitiesDate;
            string _YieldName;
            int _Term;
            double _MarktoMarketValue;
            double _SensibilitiesValue;
            double _Sensibilities;
            double _DeltaRate;
            double _EstimationValue;
            int _UserCreator;
            DateTime _EffectiveDate;

            string _KeyOperation;
            string _KeySensibilities;

            string _OperationType;
            string _SystemID;
            string _BookID;
            string _PortFolioRulesID;
            string _FinancialPortFolioID;
            string _ProductID;
            int _PrimaryCurrencyID;
            double _PrimaryAmount;
            int _SecondCurrencyID;
            double _PriceForwardTheory;
            double _PriceForward;
            double _PricePointForward;
            double _PriceCostForward;
            double _SecondAmount;
            int _PrimaryRateID;
            int _SecondRateID;
            string _FamilyID;
            string _Mnemonics;
            string _MnemonicsMask;
            double _RateForwardTheory;
            int _IssueID;
            string _FlagQuotes;
            DateTime _ExpiryDate;
            int _OperationNumber;
            int _OperationID;
            int _CustomerID;
            int _CustomerCode;
            int _CurrencyIssue;
            double _RateContract;
            double _Nominal;
            double _MarktoMarketValueYesterday;
            double _MarktoMarketValueYesterdayUM;
            double _MarktoMarketValueToday;
            double _MarktoMarketValueTodayUM;
            double _MarktoMarketValueTimeDecay;
            double _MarktoMarketValueExchangeRate;
            double _MarktoMarketValueEffectRate;
            double _CashFlow;
            double _MarktoMarketRateYesterday;
            double _MarktoMarketRateToday;
            double _MarktoMarketRateEndMonth;
            double _MacaulayDuration;
            double _ModifiedDuration;
            double _Convexity;
            double _FairValueAsset;
            double _FairValueAssetUM;
            double _FairValueLiabilities;
            double _FairValueLiabilitiesUM;
            double _FairValueNet;
            double _FairValueAssetYesterday;
            double _FairValueAssetYesterdayUM;
            double _FairValueLiabilitiesYesterday;
            double _FairValueLiabilitiesYesterdayUM;
            double _FairValueNetYesterday;
            double _FairValueAssetSystem;
            double _FairValueLiabilitiesSystem;
            double _FairValueNetSystem;
            double _MacaulayDurationSystem;
            double _ModifiedDurationSystem;
            double _ConvexitySystem;
            double _TermToday;
            double _RateCurrencyPrimaryToday;
            double _RateCurrencySecondToday;
            double _TermYesterday;
            double _RateCurrencyPrimaryYesterday;
            double _RateCurrencySecondYesterday;
            double _AdvancePointCost;
            double _AdvancePointForward;
            double _ResultDistribution;
            double _TransferDistribution;

            double _MarktoMarketEffectRate;
            double _PointForward;
            double _RateUSD;
            double _RateCLP;
            double _TAB30Days;
            double _CarryCostValue;
            double _CarryCostRate;

            string _PaymentType;
            string _UnWind;

            DateTime _ContractDate;
            
            DataTable _DataTable;

            #endregion

            #region "Asignación de Variables"

            _Yield = portFolioDataSet.Tables["SensibilitiesOperationByTerm"];
            _DataTable = new DataTable();
            _PortFolioT0 = portFolioDataSet.Tables["PortFolioToday"];
            _PortFolioT1 = portFolioDataSet.Tables["PortFolioTomorrow"];
            _TimeDecay = portFolioDataSet.Tables["TimeDecay"];
            _ExchangeRate = portFolioDataSet.Tables["ExchangeRate"];
            _EffectRate = portFolioDataSet.Tables["EffectRate"];

            #endregion

            #region "Seteo de la Conneccion a la base de datos"

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");

            #endregion

            #region "Conneccion a la base de datos"

            _Connect.Connection();

            #endregion

            #region "Asignación de valores estandars"

            _SensibilitiesDate = portFolioDate;
            _SystemID = "BFW";

            #endregion

            #region "Limpia Datos Sensibilidad"

            _Query = "";
            _Query += "DELETE dbo.SensibilitiesYield              WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = [@SystemID]\n";
            _Query += "DELETE dbo.SensibilitiesData               WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = [@SystemID]\n";
            _Query += "DELETE dbo.SensibilitiesForwardBondsTrader WHERE sensibilitiesdate = [@SensibilitiesDate]\n";
            _Query += "DELETE dbo.SensibilitiesForward            WHERE sensibilitiesdate = [@SensibilitiesDate]\n";

            _Query = _Query.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
            _Query = _Query.Replace("[@SystemID]", "'" + _SystemID + "'");

            _Connect.DedicatedExecution(_Query);

            #endregion

            #region "Grabar Datos"

            #region "Obtener ID"

            _ID = 0;
            _SensibilitiesID = _ID;

            #endregion

            for (_ContractID = 0; _ContractID < _PortFolioT0.Rows.Count; _ContractID++)
            {

                #region "Seteo de Contratos"

                _PortFolioT0Row = _PortFolioT0.Rows[_ContractID];
                _PortFolioT1Row = _PortFolioT1.Rows[_ContractID];
                _TimeDecayRow = _TimeDecay.Rows[_ContractID];
                _ExchangeRateRow = _ExchangeRate.Rows[_ContractID];
                _EffectRateRow = _EffectRate.Rows[_ContractID];

                #endregion

                #region "Seteo de Variables de Contratos"

                _BookID = _PortFolioT0Row["BookID"].ToString();
                _PortFolioRulesID = _PortFolioT0Row["PortfolioRulesID"].ToString();
                _FinancialPortFolioID = _PortFolioT0Row["FinancialPortFolioID"].ToString();
                _ProductID = _PortFolioT0Row["ProductType"].ToString();
                _PaymentType = _PortFolioT0Row["PaymentType"].ToString();
                _UnWind = _PortFolioT0Row["UnWind"].ToString();
                _PrimaryCurrencyID = int.Parse(_PortFolioT0Row["PrimaryCurrency"].ToString());
                _PrimaryAmount = double.Parse(_PortFolioT0Row["AmountPrimaryCurrency"].ToString());
                _SecondCurrencyID = int.Parse(_PortFolioT0Row["SecondaryCurrency"].ToString());
                _SecondAmount = double.Parse(_PortFolioT0Row["AmountSecondaryCurrency"].ToString());
                _PrimaryRateID = 0;
                _SecondRateID = 0;
                _FamilyID = _PortFolioT0Row["FamilyID"].ToString();
                _MnemonicsMask = _PortFolioT0Row["MNemonicsMask"].ToString();
                _Mnemonics = _PortFolioT0Row["MNemonics"].ToString();
                _IssueID = int.Parse(_PortFolioT0Row["IssueCode"].ToString());
                _Nominal = double.Parse(_PortFolioT0Row["AmountPrimaryCurrency"].ToString());
                _FlagQuotes = "N";
                _OperationType = _PortFolioT0Row["OperationType"].ToString();
                _ExpiryDate = DateTime.Parse(_PortFolioT0Row["ExpiryDate"].ToString());
                _OperationNumber = int.Parse(_PortFolioT0Row["OperationNumber"].ToString());
                _OperationID = 0;
                _CustomerID = int.Parse(_PortFolioT0Row["CustomerID"].ToString());
                _CustomerCode = int.Parse(_PortFolioT0Row["CustomerCode"].ToString());
                _CurrencyIssue = int.Parse(_PortFolioT0Row["PrimaryCurrency"].ToString());
                _MarktoMarketValueYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueNet"].ToString());
                _MarktoMarketValueToday = double.Parse(_PortFolioT0Row["ValuatorFairValueNet"].ToString());
                _MarktoMarketValueTimeDecay = double.Parse(_TimeDecayRow["ValuatorFairValueNet"].ToString());
                _MarktoMarketValueExchangeRate = double.Parse(_ExchangeRateRow["ValuatorFairValueNet"].ToString());
                _MarktoMarketValueEffectRate = double.Parse(_EffectRateRow["ValuatorFairValueNet"].ToString());
                _CashFlow = double.Parse(_PortFolioT0Row["CashFlow"].ToString());
                _MarktoMarketRateYesterday = 0;
                _MarktoMarketRateToday = double.Parse(_PortFolioT0Row["ValuatorPrimaryCurrencyRate"].ToString());
                _MarktoMarketRateEndMonth = 0;
                _MacaulayDuration = double.Parse(_EffectRateRow["MacaulayDuration"].ToString());
                _ModifiedDuration = double.Parse(_EffectRateRow["ModifiedDuration"].ToString());
                _Convexity = double.Parse(_EffectRateRow["Convexity"].ToString());
                _ContractDate = DateTime.Parse(_PortFolioT0Row["PurchaseDate"].ToString());
                _EffectiveDate = DateTime.Parse(_PortFolioT0Row["EffectiveDate"].ToString());
                _AdvancePointCost = double.Parse(_PortFolioT0Row["advancepointcost"].ToString());
                _AdvancePointForward = double.Parse(_PortFolioT0Row["advancepointforward"].ToString());

                _MarktoMarketEffectRate = 0;
                _PointForward = 0;
                _RateUSD = 0;
                _RateCLP = 0;
                _TAB30Days = 0;
                _CarryCostRate = 0;
                _CarryCostValue = 0;

                if (_ProductID.Equals("10"))
                {

                    _RateContract = double.Parse(_PortFolioT0Row["ExchangeRate"].ToString());
                    _RateForwardTheory = double.Parse(_PortFolioT0Row["RateForwardTheory"].ToString());
                    _MarktoMarketValueTodayUM = double.Parse(_PortFolioT0Row["ValuatorFairValueNetUM"].ToString());
                    _MarktoMarketValueYesterdayUM = double.Parse(_PortFolioT0Row["ValuatorFairValueNetUM"].ToString());
                    _PriceForward = 0;
                    _PricePointForward = 0;
                    _PriceCostForward = 0;
                    _PriceForwardTheory = 0;
                    _FairValueAsset = double.Parse(_PortFolioT0Row["ValuatorFairValueAsset"].ToString());
                    _FairValueAssetUM = double.Parse(_PortFolioT0Row["ValuatorFairValueAssetUM"].ToString());
                    _FairValueLiabilities = double.Parse(_PortFolioT0Row["ValuatorFairValueLiabilities"].ToString());
                    _FairValueLiabilitiesUM = double.Parse(_PortFolioT0Row["ValuatorFairValueLiabilitiesUM"].ToString());
                    _FairValueNet = double.Parse(_PortFolioT0Row["ValuatorFairValueNet"].ToString());
                    _FairValueAssetYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueAsset"].ToString());
                    _FairValueAssetYesterdayUM = double.Parse(_PortFolioT1Row["ValuatorFairValueAssetUM"].ToString());
                    _FairValueLiabilitiesYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueLiabilities"].ToString());
                    _FairValueLiabilitiesYesterdayUM = double.Parse(_PortFolioT1Row["ValuatorFairValueLiabilitiesUM"].ToString());
                    _FairValueNetYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueNet"].ToString());
                    _TermToday = 0;
                    _RateCurrencyPrimaryToday = 0;
                    _RateCurrencySecondToday = 0;
                    _TermYesterday = 0;
                    _RateCurrencyPrimaryYesterday = 0;
                    _RateCurrencySecondYesterday = 0;
                    _ResultDistribution = 0;
                    _TransferDistribution = 0;

                    if (_ExpiryDate.Equals(portFolioDate))
                    {
                        _MarktoMarketValueToday = 0;
                        _MarktoMarketValueTodayUM = 0;
                        _FairValueAsset = 0;
                        _FairValueAssetUM = 0;
                        _FairValueLiabilities = 0;
                        _FairValueLiabilitiesUM = 0;
                        _FairValueNet = 0;
                    }

                }
                else
                {
                    _RateContract = 0;
                    _RateForwardTheory = 0;
                    _MarktoMarketValueTodayUM = 0;
                    _MarktoMarketValueYesterdayUM = 0;
                    _PriceForward = double.Parse(_PortFolioT0Row["ExchangeRate"].ToString());
                    _PricePointForward = double.Parse(_EffectRateRow["ExchangeRatePoint"].ToString());
                    _PriceCostForward = double.Parse(_EffectRateRow["ExchangeRateCost"].ToString());
                    _PriceForwardTheory = double.Parse(_PortFolioT0Row["PriceForwardTheory"].ToString());
                    _FairValueAsset = double.Parse(_PortFolioT0Row["ValuatorFairValueAsset"].ToString());
                    _FairValueAssetUM = double.Parse(_PortFolioT0Row["ValuatorFairValueAssetUM"].ToString());
                    _FairValueLiabilities = double.Parse(_PortFolioT0Row["ValuatorFairValueLiabilities"].ToString());
                    _FairValueLiabilitiesUM = double.Parse(_PortFolioT0Row["ValuatorFairValueLiabilitiesUM"].ToString());
                    _FairValueNet = double.Parse(_PortFolioT0Row["ValuatorFairValueNet"].ToString());
                    _FairValueAssetYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueAsset"].ToString());
                    _FairValueAssetYesterdayUM = double.Parse(_PortFolioT1Row["ValuatorFairValueAssetUM"].ToString());
                    _FairValueLiabilitiesYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueLiabilities"].ToString());
                    _FairValueLiabilitiesYesterdayUM = double.Parse(_PortFolioT1Row["ValuatorFairValueLiabilitiesUM"].ToString());
                    _FairValueNetYesterday = double.Parse(_PortFolioT1Row["ValuatorFairValueNet"].ToString());
                    _TermToday = double.Parse(_PortFolioT0Row["ValuatorTerm"].ToString());
                    _RateCurrencyPrimaryToday = double.Parse(_PortFolioT0Row["ValuatorPrimaryCurrencyRate"].ToString());
                    _RateCurrencySecondToday = double.Parse(_PortFolioT0Row["ValuatorSecondaryCurrencyRate"].ToString());
                    _TermYesterday = double.Parse(_PortFolioT1Row["ValuatorTerm"].ToString());
                    _RateCurrencyPrimaryYesterday = double.Parse(_PortFolioT1Row["ValuatorPrimaryCurrencyRate"].ToString());
                    _RateCurrencySecondYesterday = double.Parse(_PortFolioT1Row["ValuatorSecondaryCurrencyRate"].ToString());
                    _ResultDistribution = double.Parse(_PortFolioT0Row["ResultDistribution"].ToString());
                    _TransferDistribution = double.Parse(_PortFolioT0Row["TransferDistribution"].ToString());
                    _MarktoMarketEffectRate = double.Parse(_PortFolioT0Row["MarktoMarketRateAdjustment"].ToString());
                    _PointForward = double.Parse(_PortFolioT0Row["PointForward"].ToString());
                    _RateUSD = double.Parse(_PortFolioT0Row["RateUSD"].ToString());
                    _RateCLP = double.Parse(_PortFolioT0Row["RateCLP"].ToString());
                    _TAB30Days = double.Parse(_PortFolioT0Row["TAB30Days"].ToString());
                    _CarryCostRate = double.Parse(_PortFolioT0Row["CarryRateUSD"].ToString());
                    _CarryCostValue = double.Parse(_PortFolioT0Row["CarryCostValue"].ToString());

                }

                if (!_ProductID.Equals("10") && (_ExpiryDate.Equals(portFolioDate)))
                {
                    _MarktoMarketValueToday = 0;
                    _MarktoMarketValueTimeDecay = _MarktoMarketValueToday - _MarktoMarketValueYesterday;
                    //_MarktoMarketValueExchangeRate = _MarktoMarketValueTimeDecay - _CashFlow;
                }

                if (_ContractDate.Equals(portFolioDate))
                {
                    _MarktoMarketValueTimeDecay = 0;
                    _CashFlow = 0;
                    _MarktoMarketValueEffectRate = double.Parse(_PortFolioT0Row["ValuatorFairValueNetCost"].ToString());
                    _MarktoMarketValueExchangeRate = _MarktoMarketValueToday - _MarktoMarketValueEffectRate;
                    _MarktoMarketValueYesterday = 0;
                }

                _FairValueAssetSystem = double.Parse(_PortFolioT0Row["FairValueAsset"].ToString());
                _FairValueLiabilitiesSystem = double.Parse(_PortFolioT0Row["FairValueLiabilities"].ToString());
                _FairValueNetSystem = _FairValueAssetSystem - _FairValueLiabilitiesSystem;
                _MacaulayDurationSystem = 0;
                _ModifiedDurationSystem = 0;
                _ConvexitySystem = 0;
                _ID++;

                _KeyOperation = portFolioDate.ToString("yyyyMMdd") + "2" + _ID.ToString("0000000");

                #endregion

                #region "Setea Query del contrato"

                _Query = "";

                #region "Save SensibilitiesData"

                _Query += "INSERT INTO dbo.SensibilitiesData ( ";
                _Query += "id";
                _Query += ", sensibilitiesdate";
                _Query += ", system";
                _Query += ", bookid";
                _Query += ", portfoliorulesid";
                _Query += ", financialportfolioid";
                _Query += ", productid";
                _Query += ", primarycurrencyid";
                _Query += ", secondcurrencyid";
                _Query += ", primaryrateid";
                _Query += ", secondrateid";
                _Query += ", familyid";
                _Query += ", mnemonicsmask";
                _Query += ", mnemonics";
                _Query += ", issueid";
                _Query += ", flagquotes";
                _Query += ", expirydate";
                _Query += ", documentnumber";
                _Query += ", operationnumber";
                _Query += ", operationid";
                _Query += ", customerid";
                _Query += ", customercode";
                _Query += " ) ";
                _Query += "VALUES ( ";
                _Query += "[@DataID]";
                _Query += ", [@SensibilitiesDate]";
                _Query += ", [@SystemID]";
                _Query += ", [@BookID]";
                _Query += ", [@PortFolioRulesID]";
                _Query += ", [@FinancialPortFolioID]";
                _Query += ", [@ProductID]";
                _Query += ", [@PrimaryCurrencyID]";
                _Query += ", [@SecondCurrencyID]";
                _Query += ", [@PrimaryRateID]";
                _Query += ", [@SecondRateID]";
                _Query += ", [@FamilyID]";
                _Query += ", [@MnemonicsMask]";
                _Query += ", [@Mnemonics]";
                _Query += ", [@IssueID]";
                _Query += ", [@FlagQuotes]";
                _Query += ", [@ExpiryDate]";
                _Query += ", [@OperationNumber]";
                _Query += ", [@OperationNumber]";
                _Query += ", [@OperationID]";
                _Query += ", [@CustomerID]";
                _Query += ", [@CustomerCode]";
                _Query += " )\n";

                #endregion

                if (_ProductID.Equals("10"))
                {

                    #region "Save SensibilitiesForwardBondsTrader"

                    _Query += "INSERT INTO dbo.SensibilitiesForwardBondsTrader ( ";
                    _Query += "sensibilitiesdate";
                    _Query += ", id";
                    _Query += ", OperationType";
                    _Query += ", currencyissue";
                    _Query += ", nominal";
                    _Query += ", rateforwardtheory";
                    _Query += ", contractdate";
                    _Query += ", marktomarketvalueyesterday";
                    _Query += ", marktomarketvalueyesterdayum";
                    _Query += ", marktomarketvaluetoday";
                    _Query += ", marktomarketvaluetodayum";
                    _Query += ", marktomarketvaluetimedecay";
                    _Query += ", marktomarketvalueexchangerate";
                    _Query += ", marktomarketvalueeffectrate";
                    _Query += ", CashFlow";
                    _Query += ", marktomarketrateyesterday";
                    _Query += ", marktomarketratetoday";
                    _Query += ", marktomarketrateendmonth";
                    _Query += ", fairvalueasset";
                    _Query += ", fairvalueassetum";
                    _Query += ", fairvalueliabilities";
                    _Query += ", fairvalueliabilitiesum";
                    _Query += ", fairvaluenet";
                    _Query += ", macaulayduration";
                    _Query += ", modifiedduration";
                    _Query += ", convexity";
                    _Query += ", ratecontract";
                    _Query += ", fairvalueassetsystem";
                    _Query += ", fairvalueliabilitiessystem";
                    _Query += ", fairvaluenetsystem";
                    _Query += ", macaulaydurationsystem";
                    _Query += ", modifieddurationsystem";
                    _Query += ", convexitysystem";
                    _Query += " )";
                    _Query += "VALUES ( ";
                    _Query += "[@SensibilitiesDate]";
                    _Query += ", [@DataID]";
                    _Query += ", [@OperationType]";
                    _Query += ", [@CurrencyIssue]";
                    _Query += ", [@Nominal]";
                    _Query += ", [@RateForwardTheory]";
                    _Query += ", [@ContractDate]";
                    _Query += ", [@MarktoMarketValueYesterday]";
                    _Query += ", [@MarktoMarketValueYesterdayUM]";
                    _Query += ", [@MarktoMarketValueToday]";
                    _Query += ", [@MarktoMarketValueTodayUM]";
                    _Query += ", [@MarktoMarketValueTimeDecay]";
                    _Query += ", [@MarktoMarketValueExchangeRate]";
                    _Query += ", [@MarktoMarketValueEffectRate]";
                    _Query += ", [@CashFlow]";
                    _Query += ", [@MarktoMarketRateYesterday]";
                    _Query += ", [@MarktoMarketRateToday]";
                    _Query += ", [@MarktoMarketRateEndMonth]";
                    _Query += ", [@FairValueAsset]";
                    _Query += ", [@FairValueAssetUM]";
                    _Query += ", [@FairValueLiabilities]";
                    _Query += ", [@FairValueLiabilitiesUM]";
                    _Query += ", [@FairValuenet]";
                    _Query += ", [@MacaulayDuration]";
                    _Query += ", [@ModifiedDuration]";
                    _Query += ", [@Convexity]";
                    _Query += ", [@RateContract]";
                    _Query += ", [@FairValueAssetSystem]";
                    _Query += ", [@FairValueLiabilitiesSystem]";
                    _Query += ", [@FairValueNetSystem]";
                    _Query += ", [@MacaulayDurationSystem]";
                    _Query += ", [@ModifiedDurationSystem]";
                    _Query += ", [@ConvexitySystem]";
                    _Query += " )\n";

                    #endregion

                }
                else
                {

                    #region "Save SensibilitiesForward"

                    _Query += "INSERT INTO dbo.SensibilitiesForward (";
                    _Query += "sensibilitiesdate";
                    _Query += ", id";
                    _Query += ", Operationtype";
                    _Query += ", paymenttype";
                    _Query += ", unwind";
                    _Query += ", primaryamount";
                    _Query += ", secondaryamount";
                    _Query += ", priceforward";
                    _Query += ", pricepointforward";
                    _Query += ", pricecost";
                    _Query += ", priceforwardtheory";
                    _Query += ", contractdate";
                    _Query += ", effectivedate";
                    _Query += ", advancepointcost";
                    _Query += ", advancepointforward";
                    _Query += ", termtoday";
                    _Query += ", ratecurrencyprimarytoday";
                    _Query += ", ratecurrencysecondtoday";
                    _Query += ", termyesterday";
                    _Query += ", ratecurrencyprimaryyesterday";
                    _Query += ", ratecurrencysecondyesterday";
                    _Query += ", marktomarketvalueyesterday";
                    _Query += ", marktomarketvaluetoday";
                    _Query += ", marktomarketvaluetodayum";
                    _Query += ", marktomarketvaluetimedecay";
                    _Query += ", marktomarketvalueexchangerate";
                    _Query += ", marktomarketvalueeffectrate";
                    _Query += ", CashFlow";
                    _Query += ", resultdistribution";
                    _Query += ", transferdistribution";
                    _Query += ", marktomarketrateyesterday";
                    _Query += ", marktomarketratetoday";
                    _Query += ", marktomarketrateendmonth";
                    _Query += ", fairvalueasset";
                    _Query += ", fairvalueassetum";
                    _Query += ", fairvalueliabilities";
                    _Query += ", fairvalueliabilitiesum";
                    _Query += ", fairvaluenet";
                    _Query += ", fairvalueassetyesterday";
                    _Query += ", fairvalueassetyesterdayum";
                    _Query += ", fairvalueliabilitiesyesterday";
                    _Query += ", fairvalueliabilitiesyesterdayum";
                    _Query += ", fairvaluenetyesterday";
                    _Query += ", fairvalueassetsystem";
                    _Query += ", fairvalueliabilitiessystem";
                    _Query += ", fairvaluenetsystem";
                    _Query += ", marktomarketeffectrate";
                    _Query += ", pointforward";
                    _Query += ", rateusd";
                    _Query += ", rateclp";
                    _Query += ", tab30days";
                    _Query += ", carrycostvalue";
                    _Query += ", carryrateusd";
                    _Query += " )";
                    _Query += "VALUES ( ";
                    _Query += "[@SensibilitiesDate]";
                    _Query += ", [@DataID]";
                    _Query += ", [@OperationType]";
                    _Query += ", [@PaymentType]";
                    _Query += ", [@UnWind]";
                    _Query += ", [@PrimaryAmount]";
                    _Query += ", [@SecondaryAmount]";
                    _Query += ", [@PriceForward]";
                    _Query += ", [@PricePointForward]";
                    _Query += ", [@PriceCostForward]";
                    _Query += ", [@PriceForwardTheory]";
                    _Query += ", [@ContractDate]";
                    _Query += ", [@EffectiveDate]";
                    _Query += ", [@AdvancePointCost]";
                    _Query += ", [@AdvancePointForward]";
                    _Query += ", [@TermToday]";
                    _Query += ", [@RateCurrencyPrimaryToday]";
                    _Query += ", [@RateMarketCurrencySecondToday]";
                    _Query += ", [@TermYesterday]";
                    _Query += ", [@RateCurrencyPrimaryYesterday]";
                    _Query += ", [@RateMarketCurrencySecondYesterday]";
                    _Query += ", [@MarktoMarketValueYesterday]";
                    _Query += ", [@MarktoMarketValueToday]";
                    _Query += ", [@MarktoMarketValueTodayUM]";
                    _Query += ", [@MarktoMarketValueTimeDecay]";
                    _Query += ", [@MarktoMarketValueExchangeRate]";
                    _Query += ", [@MarktoMarketValueEffectRate]";
                    _Query += ", [@CashFlow]";
                    _Query += ", [@ResultDistribution]";
                    _Query += ", [@TransferDistribution]";
                    _Query += ", [@MarktoMarketRateYesterday]";
                    _Query += ", [@MarktoMarketRateToday]";
                    _Query += ", [@MarktoMarketRateEndMonth]";
                    _Query += ", [@FairValueAsset]";
                    _Query += ", [@FairValueAssetUM]";
                    _Query += ", [@FairValueLiabilities]";
                    _Query += ", [@FairValueLiabilitiesUM]";
                    _Query += ", [@FairValuenet]";
                    _Query += ", [@FairValueAssetYesterday]";
                    _Query += ", [@FairValueAssetYesterdayUM]";
                    _Query += ", [@FairValueLiabilitiesYesterday]";
                    _Query += ", [@FairValueLiabilitiesYesterdayUM]";
                    _Query += ", [@FairValuenetYesterday]";
                    _Query += ", [@FairValueAssetSystem]";
                    _Query += ", [@FairValueLiabilitiesSystem]";
                    _Query += ", [@FairValueNetSystem]";
                    _Query += ", [@MarktoMarketEffectRate]";
                    _Query += ", [@PointForward]";
                    _Query += ", [@RateUSD]";
                    _Query += ", [@RateCLP]";
                    _Query += ", [@TAB30Days]";
                    _Query += ", [@CarryCostValue]";
                    _Query += ", [@CarryRateUSD]";
                    _Query += " )\n";

                    #endregion

                }

                #region "Seteo de Variables"

                _Query = _Query.Replace("[@DataID]", _KeyOperation.ToString());
                _Query = _Query.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@SystemID]", "'" + _SystemID + "'");
                _Query = _Query.Replace("[@OperationType]", "'" + _OperationType + "'");
                _Query = _Query.Replace("[@PaymentType]", "'" + _PaymentType + "'");
                _Query = _Query.Replace("[@UnWind]", "'" + _UnWind + "'");
                _Query = _Query.Replace("[@BookID]", "'" + _BookID + "'");
                _Query = _Query.Replace("[@PortFolioRulesID]", "'" + _PortFolioRulesID + "'");
                _Query = _Query.Replace("[@FinancialPortFolioID]", "'" + _FinancialPortFolioID + "'");
                _Query = _Query.Replace("[@ProductID]", "'" + _ProductID + "'");
                _Query = _Query.Replace("[@PrimaryCurrencyID]", _PrimaryCurrencyID.ToString());
                _Query = _Query.Replace("[@PrimaryAmount]", _PrimaryAmount.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PriceForward]", _PriceForward.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PricePointForward]", _PricePointForward.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PriceCostForward]", _PriceCostForward.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PriceForwardTheory]", _PriceForwardTheory.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@SecondCurrencyID]", _SecondCurrencyID.ToString());
                _Query = _Query.Replace("[@SecondaryAmount]", _SecondAmount.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PrimaryRateID]", _PrimaryRateID.ToString());
                _Query = _Query.Replace("[@SecondRateID]", _SecondRateID.ToString());
                _Query = _Query.Replace("[@FamilyID]", "'" + _FamilyID + "'");
                _Query = _Query.Replace("[@MnemonicsMask]", "'" + _MnemonicsMask + "'");
                _Query = _Query.Replace("[@Mnemonics]", "'" + _Mnemonics + "'");
                _Query = _Query.Replace("[@IssueID]", _IssueID.ToString());
                _Query = _Query.Replace("[@FlagQuotes]", "'" + _FlagQuotes + "'");
                _Query = _Query.Replace("[@ExpiryDate]", "'" + _ExpiryDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@EffectiveDate]", "'" + _EffectiveDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@OperationNumber]", _OperationNumber.ToString());
                _Query = _Query.Replace("[@OperationID]", _OperationID.ToString());
                _Query = _Query.Replace("[@CustomerID]", _CustomerID.ToString());
                _Query = _Query.Replace("[@CustomerCode]", _CustomerCode.ToString());
                _Query = _Query.Replace("[@Nominal]", _Nominal.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ContractDate]", "'" + _ContractDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@RateForwardTheory]", _RateForwardTheory.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@RateContract]", _RateContract.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CurrencyIssue]", _CurrencyIssue.ToString());
                _Query = _Query.Replace("[@TermToday]", _TermToday.ToString());
                _Query = _Query.Replace("[@RateCurrencyPrimaryToday]", _RateCurrencyPrimaryToday.ToString().Replace(",", "."));
                _Query = _Query.Replace("[@RateMarketCurrencySecondToday]", _RateCurrencySecondToday.ToString().Replace(",", "."));
                _Query = _Query.Replace("[@TermYesterday]", _TermYesterday.ToString());
                _Query = _Query.Replace("[@RateCurrencyPrimaryYesterday]", _RateCurrencyPrimaryYesterday.ToString().Replace(",", "."));
                _Query = _Query.Replace("[@RateMarketCurrencySecondYesterday]", _RateCurrencySecondYesterday.ToString().Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueYesterday]", _MarktoMarketValueYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueYesterdayUM]", _MarktoMarketValueYesterdayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueToday]", _MarktoMarketValueToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueTodayUM]", _MarktoMarketValueTodayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueTimeDecay]", _MarktoMarketValueTimeDecay.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueExchangeRate]", _MarktoMarketValueExchangeRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueEffectRate]", _MarktoMarketValueEffectRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CashFlow]", _CashFlow.ToString().Replace(",","."));
                _Query = _Query.Replace("[@MarktoMarketRateYesterday]", _MarktoMarketRateYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateToday]", _MarktoMarketRateToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateEndMonth]", _MarktoMarketRateEndMonth.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MacaulayDuration]", _MacaulayDuration.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ModifiedDuration]", _ModifiedDuration.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@Convexity]", _Convexity.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@RateContract]", _RateContract.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAsset]", _FairValueAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetUM]", _FairValueAssetUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilities]", _FairValueLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesUM]", _FairValueLiabilitiesUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValuenet]", _FairValueNet.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetYesterday]", _FairValueAssetYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetYesterdayUM]", _FairValueAssetYesterdayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesYesterday]", _FairValueLiabilitiesYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesYesterdayUM]", _FairValueLiabilitiesYesterdayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValuenetYesterday]", _FairValueNetYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetSystem]", _FairValueAssetSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesSystem]", _FairValueLiabilitiesSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueNetSystem]", _FairValueNetSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MacaulayDurationSystem]", _MacaulayDurationSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ModifiedDurationSystem]", _ModifiedDurationSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ConvexitySystem]", _ConvexitySystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@AdvancePointCost]", _AdvancePointCost.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@AdvancePointForward]", _AdvancePointForward.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ResultDistribution]", _ResultDistribution.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@TransferDistribution]", _TransferDistribution.ToString("0.0000000000").Replace(",", "."));

                _Query = _Query.Replace("[@MarktoMarketEffectRate]", _MarktoMarketEffectRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PointForward]", _PointForward.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@RateUSD]", _RateUSD.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@RateCLP]", _RateCLP.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@TAB30Days]", _TAB30Days.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CarryCostValue]", _CarryCostValue.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CarryRateUSD]", _CarryCostRate.ToString("0.0000000000").Replace(",", "."));
 

                #endregion

                #endregion

                #region "Grabar Registros de Sensibilidad"

                _DataRows = _Yield.Select("OperationNumber = " + _OperationNumber.ToString());

                for (_SensibilitiesRow = 0; _SensibilitiesRow < _DataRows.Length; _SensibilitiesRow++)
                {

                    #region "Seteo Sensibilidad"

                    _DataRow = _DataRows[_SensibilitiesRow];

                    #endregion

                    #region "Seteo de Variables de Sensibilidad"

                    _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());
                    _OperationID = int.Parse(_DataRow["Leg"].ToString());
                    _YieldName = _DataRow["YieldName"].ToString();
                    _Term = int.Parse(_DataRow["Term"].ToString());
                    _MarktoMarketValue = double.Parse(_DataRow["MarktoMarketValue"].ToString());
                    _SensibilitiesValue = double.Parse(_DataRow["SensibilitiesValue"].ToString());
                    _Sensibilities = double.Parse(_DataRow["Sensibilities"].ToString());
                    _DeltaRate = double.Parse(_DataRow["DeltaRate"].ToString());
                    _EstimationValue = double.Parse(_DataRow["Estimation"].ToString());
                    _UserCreator = 1;
                    _SensibilitiesID++;
                    _KeySensibilities = portFolioDate.ToString("yyyyMMdd") + "2" + _SensibilitiesID.ToString("0000000");

                    #endregion

                    #region "Save SensibilitiesYield"

                    _QueryYield = "";
                    _QueryYield += "INSERT INTO dbo.SensibilitiesYield (";
                    _QueryYield += "id";
                    _QueryYield += ", dataid";
                    _QueryYield += ", sensibilitiesdate";
                    _QueryYield += ", [system]";
                    _QueryYield += ", mnemonicsmask";
                    _QueryYield += ", family";
                    _QueryYield += ", operationnumber";
                    _QueryYield += ", operationid";
                    _QueryYield += ", yieldname";
                    _QueryYield += ", term";
                    _QueryYield += ", marktomarketvalue";
                    _QueryYield += ", sensibilitiesvalue";
                    _QueryYield += ", sensibilities";
                    _QueryYield += ", deltarate";
                    _QueryYield += ", estimationvalue";
                    _QueryYield += ", usercreator";
                    _QueryYield += " )";
                    _QueryYield += "VALUES ( ";
                    _QueryYield += "[@SensibilitiesID]";
                    _QueryYield += ", [@DataID]";
                    _QueryYield += ", [@SensibilitiesDate]";
                    _QueryYield += ", [@SystemID]";
                    _QueryYield += ", [@MnemonicsMask]";
                    _QueryYield += ", [@FamilyID]";
                    _QueryYield += ", [@OperationNumber]";
                    _QueryYield += ", [@OperationID]";
                    _QueryYield += ", [@YieldName]";
                    _QueryYield += ", [@Term]";
                    _QueryYield += ", [@MarktoMarketValue]";
                    _QueryYield += ", [@SensibilitiesValue]";
                    _QueryYield += ", [@Sensibilities]";
                    _QueryYield += ", [@BPs]";
                    _QueryYield += ", [@EstimationValue]";
                    _QueryYield += ", [@UserCreator]";
                    _QueryYield += " )\n";

                    #endregion

                    #region "Setea Query Sensibilidad"

                    _QueryYield = _QueryYield.Replace("[@SensibilitiesID]", _KeySensibilities);
                    _QueryYield = _QueryYield.Replace("[@DataID]", _KeyOperation);
                    _QueryYield = _QueryYield.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
                    _QueryYield = _QueryYield.Replace("[@SystemID]", "'" + _SystemID + "'");
                    _QueryYield = _QueryYield.Replace("[@MnemonicsMask]", "'" + _MnemonicsMask + "'");
                    _QueryYield = _QueryYield.Replace("[@FamilyID]", "'" + _FamilyID + "'");
                    _QueryYield = _QueryYield.Replace("[@OperationNumber]", _OperationNumber.ToString());
                    _QueryYield = _QueryYield.Replace("[@OperationID]", _OperationID.ToString());
                    _QueryYield = _QueryYield.Replace("[@YieldName]", "'" + _YieldName + "'");
                    _QueryYield = _QueryYield.Replace("[@Term]", _Term.ToString());
                    _QueryYield = _QueryYield.Replace("[@MarktoMarketValue]", _MarktoMarketValue.ToString("0.0000000000").Replace(",", "."));
                    _QueryYield = _QueryYield.Replace("[@SensibilitiesValue]", _SensibilitiesValue.ToString("0.0000000000").Replace(",", "."));
                    _QueryYield = _QueryYield.Replace("[@Sensibilities]", _Sensibilities.ToString("0.0000000000").Replace(",", "."));
                    _QueryYield = _QueryYield.Replace("[@BPs]", _DeltaRate.ToString("0.0000000000").Replace(",", "."));
                    _QueryYield = _QueryYield.Replace("[@EstimationValue]", _EstimationValue.ToString("0.0000000000").Replace(",", "."));
                    _QueryYield = _QueryYield.Replace("[@UserCreator]", _UserCreator.ToString());

                    _Query += _QueryYield;

                    #endregion

                }

                #endregion

                _Connect.DedicatedExecution(_Query);

            }

            #endregion

            #region "Desconeccion"

            _Connect.Disconnection();

            #endregion

            #region "Eliminación variables en memoria"

            _Connect = null;
            _Yield = null;
            _PortFolioT0 = null;
            _PortFolioT1 = null;
            _TimeDecay = null;
            _ExchangeRate = null;
            _EffectRate = null;
            _DataRow = null;
            _PortFolioT0Row = null;
            _PortFolioT1Row = null;
            _TimeDecayRow = null;
            _ExchangeRateRow = null;
            _EffectRateRow = null;

            #endregion

        }

        #endregion

        #region "Metodos privados"

        protected void Set(enumSource id)
        {
            mStatus = enumStatus.Initialize;
            mSource = id;
        }

        #endregion

        #region "Clases para obtener la información"

        #region "Clase Source"

        private class Source
        {

            private enumStatus mStatus;
            private String mError;
            private String mStack;

            public enumStatus Status
            {
                get
                {
                    return mStatus;
                }
                set
                {
                    mStatus = value;
                }
            }

            public String Error
            {
                get
                {
                    return mError;
                }
                set
                {
                    mError = value;
                }
            }

            public String Stack
            {
                get
                {
                    return mStack;
                }
                set
                {
                    mStack = value;
                }
            }

            public Source()
            {
                mStatus = enumStatus.Initialize;
                mError = "";
                mStack = "";
            }

            public virtual DataSet LoadPortFolio(DateTime portFolioDate)
            {
                DataSet _ForwardPortFolio = new DataSet();

                return _ForwardPortFolio;
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataSet LoadPortFolio(DateTime portFolioDate)
            {

                DataSet _PortFolio = new DataSet();
                DataTable _PortFolioData = new DataTable();
                DataTable _PortFolioFlow = new DataTable();
                DataTable _IndexValueForwardFixingRate = new DataTable();

                _PortFolioData = LoadPortFolioData(portFolioDate);
                _PortFolioFlow = LoadPortFolioFlow(portFolioDate);
                _IndexValueForwardFixingRate = LoadIndexValueForwardFixingRate(portFolioDate);

                _PortFolio.Merge(_PortFolioData);
                _PortFolio.Merge(_PortFolioFlow);
                _PortFolio.Merge(_IndexValueForwardFixingRate);

                return (_PortFolio);

            }

            private DataTable LoadPortFolioData(DateTime portFolioDate)
            {

                String _QueryForward = "";

                #region "Query Load PortFolio Forward"

                _QueryForward = "";
                _QueryForward += "SET NOCOUNT ON\n\n";

                _QueryForward += "DECLARE @ProcessDate                DATETIME\n";
                _QueryForward += "DECLARE @PortFolioDateToday         DATETIME\n\n";

                _QueryForward += "SET @PortFolioDateToday     = [@portFolioDate]\n\n";

                _QueryForward += "CREATE TABLE #tmpCartera\n";
                _QueryForward += "        (\n";
                _QueryForward += "          ProcessDate                DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , OperationNumber            INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , ProductType                INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , CustomerID                 INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , CustomerCode               INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , BookID                     VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QueryForward += "        , PortfolioRulesID           VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QueryForward += "        , FinancialPortFolioID       VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QueryForward += "        , OperationType              CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , PaymentType                CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , PrimaryCurrency            INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , SecondaryCurrency          INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , ExchangeRate               FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , ExchangeRatePoint          FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , ExchangeRateCost           FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , ExchangeRateExpiry         FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , AmountPrimaryCurrency      FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , AmountSecondaryCurrency    FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , ExpiryDate                 DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , EffectiveDate              DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , ContractTerm               INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , MaturityDeadline           INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , AfterDeadline              INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , PrimaryCurrencyRate        FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , SecondaryCurrencyRate      FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , FairValueAsset             FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , FairValueLiabilities       FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , MNemonicsCode              INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , FamilyID                   VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QueryForward += "        , MNemonicsMask              VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QueryForward += "        , MNemonics                  VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QueryForward += "        , IssueCode                  INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "        , PurchaseDate               DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , DevelonmentTable           CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "        , AdvancePointCost           FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , AdvancePointForward        FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , DO                         FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , UF                         FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , RateDistribution           FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "        , UnWind                     CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "        )\n\n";
                                                
                _QueryForward += "SELECT @ProcessDate = acfecproc\n";
                _QueryForward += "   FROM dbo.mfac WITH(NOLOCK)\n\n";

                _QueryForward += "IF @ProcessDate = @PortFolioDateToday\n";
                _QueryForward += "BEGIN\n";
                _QueryForward += "    INSERT INTO #tmpCartera\n";
                _QueryForward += "           (\n";
                _QueryForward += "                  ProcessDate\n";
                _QueryForward += "           ,      OperationNumber\n";
                _QueryForward += "           ,      ProductType\n";
                _QueryForward += "           ,      CustomerID\n";
                _QueryForward += "           ,      CustomerCode\n";
                _QueryForward += "           ,      BookID\n";
                _QueryForward += "           ,      PortfolioRulesID\n";
                _QueryForward += "           ,      FinancialPortFolioID\n";
                _QueryForward += "           ,      OperationType\n";
                _QueryForward += "           ,      PaymentType\n";
                _QueryForward += "           ,      PrimaryCurrency\n";
                _QueryForward += "           ,      SecondaryCurrency\n";
                _QueryForward += "           ,      ExchangeRate\n";
                _QueryForward += "           ,      ExchangeRatePoint\n";
                _QueryForward += "           ,      ExchangeRateCost\n";
                _QueryForward += "           ,      ExchangeRateExpiry\n";
                _QueryForward += "           ,      AmountPrimaryCurrency\n";
                _QueryForward += "           ,      AmountSecondaryCurrency\n";
                _QueryForward += "           ,      ExpiryDate\n";
                _QueryForward += "           ,      EffectiveDate\n";
                _QueryForward += "           ,      ContractTerm\n";
                _QueryForward += "           ,      MaturityDeadline\n";
                _QueryForward += "           ,      AfterDeadline\n";
                _QueryForward += "           ,      PrimaryCurrencyRate\n";
                _QueryForward += "           ,      SecondaryCurrencyRate\n";
                _QueryForward += "           ,      FairValueAsset\n";
                _QueryForward += "           ,      FairValueLiabilities\n";
                _QueryForward += "           ,      MNemonics\n";
                _QueryForward += "           ,      PurchaseDate\n";
                _QueryForward += "           ,      AdvancePointCost\n";
                _QueryForward += "           ,      AdvancePointForward\n";
                _QueryForward += "           ,      RateDistribution\n";
                _QueryForward += "           ,      UnWind\n";
                _QueryForward += "           )\n";
                _QueryForward += "           SELECT @PortFolioDateToday                -- ProcessDate\n";
                _QueryForward += "                , mfca.canumoper                     -- OperationNumber\n";
                _QueryForward += "                , mfca.cacodpos1                     -- ProductType\n";
                _QueryForward += "                , mfca.cacodigo                      -- CustomerID\n";
                _QueryForward += "                , mfca.cacodcli                      -- CustomerCode\n";
                _QueryForward += "                , mfca.calibro                       -- BookID\n";
                _QueryForward += "                , mfca.cacartera_normativa           -- PortfolioRulesID\n";
                _QueryForward += "                , mfca.cacodcart                     -- FinancialPortFolioID\n";
                _QueryForward += "                , mfca.catipoper                     -- OperationType\n";
                _QueryForward += "                , mfca.catipmoda                     -- PaymentType\n";
                _QueryForward += "                , mfca.cacodmon1                     -- PrimaryCurrency\n";
                _QueryForward += "                , mfca.cacodmon2                     -- SecondaryCurrency\n";
                _QueryForward += "                , mfca.catipcam                      -- ExchangeRate\n";
                _QueryForward += "                , mfca.capreciopunta                 -- ExchangeRatePoint\n";
                _QueryForward += "                , mfca.catipcamSpot                  -- ExchangeRateCost\n";
                _QueryForward += "                , mfca.capremon1                     -- ExchangeRateExpiry\n";
                _QueryForward += "                , mfca.camtomon1                     -- AmountPrimaryCurrency\n";
                _QueryForward += "                , mfca.camtomon2                     -- AmountSecondaryCurrency\n";
                _QueryForward += "                , mfca.cafecvcto                     -- ExpiryDate\n";
                _QueryForward += "                , mfca.cafecEfectiva                 -- EffectiveDate\n";
                _QueryForward += "                , mfca.caplazo                       -- ContractTerm\n";
                _QueryForward += "                , mfca.caplazovto                    -- MaturityDeadline\n";
                _QueryForward += "                , mfca.caplazocal                    -- AfterDeadline\n";
                _QueryForward += "                , mfca.catasasinteticam1             -- PrimaryCurrencyRate\n";
                _QueryForward += "                , mfca.catasasinteticam2             -- SecondaryCurrencyRate\n";
                _QueryForward += "                , mfca.ValorRazonableActivo          -- FairValueAsset\n";
                _QueryForward += "                , mfca.ValorRazonablePasivo          -- FairValueLiabilities\n";
                _QueryForward += "                , mfca.caserie                       -- MNemonics\n";
                _QueryForward += "                , mfca.cafecha                       -- PurchaseDate\n";
                _QueryForward += "                , mfca.caAntPtosCos                  -- AdvancePointCost\n";
                _QueryForward += "                , mfca.caAntPtosFwd                  -- AdvancePointForward\n";
                _QueryForward += "                , mfca.capreciopunta                 -- RateDistribution\n";
                _QueryForward += "                , mfca.caantici                      -- UnWind\n";
                _QueryForward += "             FROM Bacfwdsuda.dbo.mfca  MFCA  WITH(NOLOCK)\n";

                _QueryForward += "END ELSE\n";
                _QueryForward += "BEGIN\n";
                _QueryForward += "    INSERT INTO #tmpCartera\n";
                _QueryForward += "           (\n";
                _QueryForward += "                  ProcessDate\n";
                _QueryForward += "           ,      OperationNumber\n";
                _QueryForward += "           ,      ProductType\n";
                _QueryForward += "           ,      CustomerID\n";
                _QueryForward += "           ,      CustomerCode\n";
                _QueryForward += "           ,      BookID\n";
                _QueryForward += "           ,      PortfolioRulesID\n";
                _QueryForward += "           ,      FinancialPortFolioID\n";
                _QueryForward += "           ,      OperationType\n";
                _QueryForward += "           ,      PaymentType\n";
                _QueryForward += "           ,      PrimaryCurrency\n";
                _QueryForward += "           ,      SecondaryCurrency\n";
                _QueryForward += "           ,      ExchangeRate\n";
                _QueryForward += "           ,      ExchangeRatePoint\n";
                _QueryForward += "           ,      ExchangeRateCost\n";
                _QueryForward += "           ,      ExchangeRateExpiry\n";
                _QueryForward += "           ,      AmountPrimaryCurrency\n";
                _QueryForward += "           ,      AmountSecondaryCurrency\n";
                _QueryForward += "           ,      ExpiryDate\n";
                _QueryForward += "           ,      EffectiveDate\n";
                _QueryForward += "           ,      ContractTerm\n";
                _QueryForward += "           ,      MaturityDeadline\n";
                _QueryForward += "           ,      AfterDeadline\n";
                _QueryForward += "           ,      PrimaryCurrencyRate\n";
                _QueryForward += "           ,      SecondaryCurrencyRate\n";
                _QueryForward += "           ,      FairValueAsset\n";
                _QueryForward += "           ,      FairValueLiabilities\n";
                _QueryForward += "           ,      MNemonics\n";
                _QueryForward += "           ,      PurchaseDate\n";
                _QueryForward += "           ,      AdvancePointCost\n";
                _QueryForward += "           ,      AdvancePointForward\n";
                _QueryForward += "           ,      RateDistribution\n";
                _QueryForward += "           ,      UnWind\n";
                _QueryForward += "           )\n";
                _QueryForward += "           SELECT @PortFolioDateToday                -- ProcessDate\n";
                _QueryForward += "                , mfca.canumoper                     -- OperationNumber\n";
                _QueryForward += "                , mfca.cacodpos1                     -- ProductType\n";
                _QueryForward += "                , mfca.cacodigo                      -- CustomerID\n";
                _QueryForward += "                , mfca.cacodcli                      -- CustomerCode\n";
                _QueryForward += "                , mfca.calibro                       -- BookID\n";
                _QueryForward += "                , mfca.cacartera_normativa           -- PortfolioRulesID\n";
                _QueryForward += "                , mfca.cacodcart                     -- FinancialPortFolioID\n";
                _QueryForward += "                , mfca.catipoper                     -- OperationType\n";
                _QueryForward += "                , mfca.catipmoda                     -- PaymentType\n";
                _QueryForward += "                , mfca.cacodmon1                     -- PrimaryCurrency\n";
                _QueryForward += "                , mfca.cacodmon2                     -- SecondaryCurrency\n";
                _QueryForward += "                , mfca.catipcam                      -- ExchangeRate\n";
                _QueryForward += "                , mfca.capreciopunta                 -- ExchangeRatePoint\n";
                _QueryForward += "                , mfca.catipcamSpot                  -- ExchangeRateCost\n";
                _QueryForward += "                , mfca.capremon1                     -- ExchangeRateExpiry\n";
                _QueryForward += "                , mfca.camtomon1                     -- AmountPrimaryCurrency\n";
                _QueryForward += "                , mfca.camtomon2                     -- AmountSecondaryCurrency\n";
                _QueryForward += "                , mfca.cafecvcto                     -- ExpiryDate\n";
                _QueryForward += "                , mfca.cafecEfectiva                 -- EffectiveDate\n";
                _QueryForward += "                , mfca.caplazo                       -- ContractTerm\n";
                _QueryForward += "                , mfca.caplazovto                    -- MaturityDeadline\n";
                _QueryForward += "                , mfca.caplazocal                    -- AfterDeadline\n";
                _QueryForward += "                , mfca.catasasinteticam1             -- PrimaryCurrencyRate\n";
                _QueryForward += "                , mfca.catasasinteticam2             -- SecondaryCurrencyRate\n";
                _QueryForward += "                , mfca.ValorRazonableActivo          -- FairValueAsset\n";
                _QueryForward += "                , mfca.ValorRazonablePasivo          -- FairValueLiabilities\n";
                _QueryForward += "                , mfca.caserie                       -- MNemonics\n";
                _QueryForward += "                , mfca.cafecha                       -- PurchaseDate\n";
                _QueryForward += "                , mfca.caAntPtosCos                  -- AdvancePointCost\n";
                _QueryForward += "                , mfca.caAntPtosFwd                  -- AdvancePointForward\n";
                _QueryForward += "                , mfca.capreciopunta                 -- RateDistribution\n";
                _QueryForward += "                , mfca.caantici                      -- UnWind\n";
                _QueryForward += "             FROM Bacfwdsuda.dbo.mfcares mfca  WITH(NOLOCK)\n";
                _QueryForward += "            WHERE mfca.CaFechaProceso      = @PortFolioDateToday\n";
                _QueryForward += "              AND mfca.cafecvcto          >= @PortFolioDateToday\n";

                _QueryForward += "END\n\n";

                _QueryForward += "UPDATE #tmpCartera\n";
                _QueryForward += "   SET DO                = vmvalor\n";
                _QueryForward += "  FROM bacparamsuda..valor_moneda\n";
                _QueryForward += " WHERE vmfecha           = PurchaseDate\n";
                _QueryForward += "   AND vmcodigo          = 994\n";
                _QueryForward += "   AND ProductType       = 1\n";
                _QueryForward += "   AND SecondaryCurrency = 998\n\n";

                _QueryForward += "UPDATE #tmpCartera\n";
                _QueryForward += "   SET UF                = vmvalor\n";
                _QueryForward += "  FROM bacparamsuda..valor_moneda\n";
                _QueryForward += " WHERE vmfecha           = PurchaseDate\n";
                _QueryForward += "   AND vmcodigo          = 998\n";
                _QueryForward += "   AND ProductType       = 1\n";
                _QueryForward += "   AND SecondaryCurrency = 998\n\n";

                _QueryForward += "UPDATE #tmpCartera\n";
                _QueryForward += "   SET ExchangeRatePoint = (DO / UF) * (1.0 + RateDistribution * 0.01 * CONVERT( FLOAT, DATEDIFF( DAY, PurchaseDate, ExpiryDate ) ) / 360.0 ) * UF\n";
                _QueryForward += " WHERE ProductType       = 1\n";
                _QueryForward += "   AND SecondaryCurrency = 998\n\n";


                _QueryForward += "UPDATE #tmpCartera\n";
                _QueryForward += "   SET MNemonicsCode = secodigo\n";
                _QueryForward += "     , MNemonicsMask = semascara\n";
                _QueryForward += "     , IssueCode     = serutemi\n";
                _QueryForward += "  FROM BacParamSuda.dbo.SERIE\n";
                _QueryForward += " WHERE semascara     = MNemonics\n\n";

                _QueryForward += "UPDATE #tmpCartera\n";
                _QueryForward += "   SET DevelonmentTable = inmdse\n";
                _QueryForward += "     , FamilyID         = inserie\n";
                _QueryForward += "  FROM BacParamSuda.dbo.INSTRUMENTO\n";
                _QueryForward += " WHERE incodigo         = MNemonicsCode\n\n";

                _QueryForward += "SELECT *\n";
                _QueryForward += "  FROM #tmpCartera\n";
                _QueryForward += " WHERE ProductType     <> 2\n"; // se deja bloqueado para procesar los FRF

                //_QueryForward += " WHERE PrimaryCurrency    = 998\n";
                //_QueryForward += " WHERE ProductType      = 10\n"; //13
                //_QueryForward += "   AND OperationNumber  = 19246\n";

                _QueryForward += " ORDER BY\n";
                _QueryForward += "       ProductType\n";
                _QueryForward += "     , OperationNumber\n\n";

                _QueryForward += "DROP TABLE #tmpCartera\n\n";

                _QueryForward += "SET NOCOUNT OFF\n";

                _QueryForward = _QueryForward.Replace("[@portFolioDate]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACFWDSUDA");
                DataTable _ForwardPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryForward);
                    _ForwardPortFolio = _Connect.QueryDataTable();
                    _ForwardPortFolio.TableName = "ForwardPortFolio";

                    if (_ForwardPortFolio.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _ForwardPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _ForwardPortFolio;
            }

            private DataTable LoadPortFolioFlow(DateTime portFolioDate)
            {

                String _QueryForward = "";

                #region "Query Load PortFolio Forward"

                _QueryForward = "";
                _QueryForward += "SET NOCOUNT ON\n\n";

                _QueryForward += "DECLARE @ProcessDate                DATETIME\n";
                _QueryForward += "DECLARE @PortFolioDateToday         DATETIME\n\n";

                _QueryForward += "SET @PortFolioDateToday     = [@portFolioDate]\n\n";

                _QueryForward += "CREATE TABLE #tmpCartera\n";
                _QueryForward += "       (\n";
                _QueryForward += "         OperationNumber            INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "       , OperationID                INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "       , ContractTerm               INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "       , OperationType              CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "       , PaymentType                CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "       , ExpiryDate                 DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "       , EffectiveDate              DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "       , PrimaryCurrency            INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "       , SecondaryCurrency          INT          NOT NULL DEFAULT 0\n";
                _QueryForward += "       , AmountPrimaryCurrency      FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , ExchangeRate               FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , ExchangeRateCost           FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , ExchangeRatePoint          FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , AmountSecondaryCurrency    FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , Spread                     FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , RatePrimary                FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , RateSecondary              FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , PriceProjected             FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , FairValueAsset             FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , FairValueLiabilities       FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , FairValueNet               FLOAT        NOT NULL DEFAULT 0\n";
                _QueryForward += "       , PurchaseDate               DATETIME     NOT NULL DEFAULT ''\n";
                _QueryForward += "       , UnWind                     CHAR(01)     NOT NULL DEFAULT ''\n";
                _QueryForward += "       )\n\n";


                _QueryForward += "SELECT @ProcessDate = acfecproc\n";
                _QueryForward += "  FROM dbo.mfac WITH(NOLOCK)\n\n";

                _QueryForward += "INSERT INTO #tmpCartera\n";
                _QueryForward += "       (\n";
                _QueryForward += "              OperationNumber\n";
                _QueryForward += "       ,      OperationID\n";
                _QueryForward += "       ,      ContractTerm\n";
                _QueryForward += "       ,      ExpiryDate\n";
                _QueryForward += "       ,      EffectiveDate\n";
                _QueryForward += "       ,      AmountPrimaryCurrency\n";
                _QueryForward += "       ,      ExchangeRate\n";
                _QueryForward += "       ,      ExchangeRateCost\n";
                _QueryForward += "       ,      AmountSecondaryCurrency\n";
                _QueryForward += "       ,      Spread\n";
                _QueryForward += "       ,      RatePrimary\n";
                _QueryForward += "       ,      RateSecondary\n";
                _QueryForward += "       ,      PriceProjected\n";
                _QueryForward += "       ,      FairValueAsset\n";
                _QueryForward += "       ,      FairValueLiabilities\n";
                _QueryForward += "       ,      FairValueNet\n";
                _QueryForward += "       )\n";
                _QueryForward += "       SELECT Ctf_Numero_OPeracion       -- OperationNumber\n";
                _QueryForward += "            , Ctf_Correlativo            -- OperationID\n";
                _QueryForward += "            , Ctf_Plazo                  -- ContractTerm\n";
                _QueryForward += "            , Ctf_Fecha_Vencimiento      -- ExpiryDate\n";
                _QueryForward += "            , Ctf_Fecha_Fijacion         -- FixingDate\n";
                _QueryForward += "            , Ctf_Monto_Principal        -- AmountPrimaryCurrency\n";
                _QueryForward += "            , Ctf_Precio_Contrato        -- ExchangeRate\n";
                _QueryForward += "            , Ctf_Precio_Costo           -- ExchangeRateCost\n";
                _QueryForward += "            , Ctf_Monto_Secundario       -- AmountSecondaryCurrency\n";
                _QueryForward += "            , Ctf_Spread                 -- Spread\n";
                _QueryForward += "            , Ctf_Tasa_Moneda_Principal  -- RatePrimary\n";
                _QueryForward += "            , Ctf_Tasa_Moneda_Secundaria -- RateSecondary\n";
                _QueryForward += "            , Ctf_Precio_Proyectado      -- PriceProjected\n";
                _QueryForward += "            , Ctf_Valor_Razonable_Activo -- FairValueAsset\n";
                _QueryForward += "            , Ctf_Valor_Razonable_Pasivo -- FairValueLiabilities\n";
                _QueryForward += "            , Ctf_Valor_Razonable        -- FairValueNet\n";
                _QueryForward += "         FROM dbo.TBL_CARTERA_FLUJOS  WITH(NOLOCK)\n\n";

                _QueryForward += "IF @ProcessDate > @PortFolioDateToday\n";
                _QueryForward += "BEGIN\n";
                _QueryForward += "    INSERT INTO #tmpCartera\n";
                _QueryForward += "           (\n";
                _QueryForward += "                  OperationNumber\n";
                _QueryForward += "           ,      OperationID\n";
                _QueryForward += "           ,      ContractTerm\n";
                _QueryForward += "           ,      ExpiryDate\n";
                _QueryForward += "           ,      EffectiveDate\n";
                _QueryForward += "           ,      AmountPrimaryCurrency\n";
                _QueryForward += "           ,      ExchangeRate\n";
                _QueryForward += "           ,      ExchangeRateCost\n";
                _QueryForward += "           ,      AmountSecondaryCurrency\n";
                _QueryForward += "           ,      Spread\n";
                _QueryForward += "           ,      RatePrimary\n";
                _QueryForward += "           ,      RateSecondary\n";
                _QueryForward += "           ,      PriceProjected\n";
                _QueryForward += "           ,      FairValueAsset\n";
                _QueryForward += "           ,      FairValueLiabilities\n";
                _QueryForward += "           ,      FairValueNet\n";
                _QueryForward += "           )\n";
                _QueryForward += "           SELECT Cfr_Numero_OPeracion       -- OperationNumber\n";
                _QueryForward += "                , Cfr_Correlativo            -- OperationID\n";
                _QueryForward += "                , Cfr_Plazo                  -- ContractTerm\n";
                _QueryForward += "                , Cfr_Fecha_Vencimiento      -- ExpiryDate\n";
                _QueryForward += "                , Cfr_Fecha_Fijacion         -- FixingDate\n";
                _QueryForward += "                , Cfr_Monto_Principal        -- AmountPrimaryCurrency\n";
                _QueryForward += "                , Cfr_Precio_Contrato        -- ExchangeRate\n";
                _QueryForward += "                , Cfr_Precio_Costo           -- ExchangeRateCost\n";
                _QueryForward += "                , Cfr_Monto_Secundario       -- AmountSecondaryCurrency\n";
                _QueryForward += "                , Cfr_Spread                 -- Spread\n";
                _QueryForward += "                , Cfr_Tasa_Moneda_Principal  -- RatePrimary\n";
                _QueryForward += "                , Cfr_Tasa_Moneda_Secundaria -- RateSecondary\n";
                _QueryForward += "                , Cfr_Precio_Proyectado      -- PriceProjected\n";
                _QueryForward += "                , 0                          -- FairValueAsset\n";
                _QueryForward += "                , 0                          -- FairValueLiabilities\n";
                _QueryForward += "                , 0                          -- FairValueNet\n";
                _QueryForward += "             FROM dbo.TBL_CARTERA_FLUJOS_RES  WITH(NOLOCK)\n";
                _QueryForward += "           WHERE Cfr_Fecha_Proceso     >= @PortFolioDateToday\n";
                _QueryForward += "             AND Cfr_Fecha_Vencimiento <= @PortFolioDateToday\n\n";

                _QueryForward += "END\n\n";

                _QueryForward += "IF @ProcessDate = @PortFolioDateToday\n";
                _QueryForward += "BEGIN\n";
                _QueryForward += "    UPDATE #tmpCartera\n";
                _QueryForward += "       SET PurchaseDate   = cafecha\n";
                _QueryForward += "         , PaymentType    = catipmoda\n";
                _QueryForward += "         , UnWind         = caantici\n";
                _QueryForward += "      FROM dbo.mfca WITH(NOLOCK)\n";
                _QueryForward += "     WHERE canumoper = OperationNumber\n\n";

                _QueryForward += "END ELSE\n";
                _QueryForward += "BEGIN\n";
                _QueryForward += "    UPDATE #tmpCartera\n";
                _QueryForward += "       SET PurchaseDate   = cafecha\n";
                _QueryForward += "         , PaymentType    = catipmoda\n";
                _QueryForward += "         , UnWind         = caantici\n";
                _QueryForward += "      FROM dbo.mfcares WITH(NOLOCK)\n";
                _QueryForward += "     WHERE CaFechaProceso = @PortFolioDateToday\n";
                _QueryForward += "       AND canumoper      = OperationNumber\n\n";

                _QueryForward += "END\n\n";

                _QueryForward += "SELECT *\n";
                _QueryForward += "  FROM #tmpCartera\n";
                _QueryForward += " ORDER BY\n";
                _QueryForward += "       OperationNumber\n";
                _QueryForward += "     , OperationID\n\n";

                _QueryForward += "DROP TABLE #tmpCartera\n\n";

                _QueryForward += "SET NOCOUNT OFF\n";

                _QueryForward = _QueryForward.Replace("[@portFolioDate]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACFWDSUDA");
                DataTable _ForwardPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryForward);
                    _ForwardPortFolio = _Connect.QueryDataTable();
                    _ForwardPortFolio.TableName = "ForwardPortFolioFlow";

                    if (_ForwardPortFolio.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _ForwardPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _ForwardPortFolio;
            }

            private DataTable LoadIndexValueForwardFixingRate(DateTime portFolioDate)
            {

                String _QueryIndex = "";

                #region "Query Load Index Forward Rate Fixing"

                _QueryIndex = "";
                _QueryIndex += "SET NOCOUNT ON\n\n";

                _QueryIndex += "DECLARE @DateProcess                    DATETIME\n";
                _QueryIndex += "DECLARE @Date                           DATETIME\n";
                _QueryIndex += "DECLARE @DateIPCCurrent                 DATETIME\n";
                _QueryIndex += "DECLARE @DateIPCPreviousMonth           DATETIME\n";
                _QueryIndex += "DECLARE @DateIPCTwoMonthBefore          DATETIME\n";
                _QueryIndex += "DECLARE @dFechaProximoNueve             DATETIME\n\n";

                _QueryIndex += "SET @DateProcess = [@DateProcess]\n\n";

                _QueryIndex += "IF DAY(@DateProcess) = 9\n";
                _QueryIndex += "BEGIN\n";
                _QueryIndex += "      SET @dFechaProximoNueve  = @DateProcess\n\n";
                _QueryIndex += "END ELSE\n";
                _QueryIndex += "BEGIN\n";
                _QueryIndex += "    SET @dFechaProximoNueve = CASE WHEN DAY( @DateProcess ) > 9 THEN DATEADD( MONTH, 1, dateadd( DAY, - DAY( @DateProcess ) + 9, @DateProcess ) )\n";
                _QueryIndex += "                                                                ELSE DATEADD( DAY, 9 + - DAY( @DateProcess ) ,  @DateProcess )\n";
                _QueryIndex += "                              END\n\n";
                _QueryIndex += "END\n\n";

                _QueryIndex += "SET @DateIPCCurrent        = DATEADD( MONTH, -1, @dFechaProximoNueve )\n";
                _QueryIndex += "SET @DateIPCCurrent        = DATEADD( DAY, 1, DATEADD( DAY, DATEPART( DAY, @DateIPCCurrent ) * -1, @DateIPCCurrent ) )\n";
                _QueryIndex += "SET @DateIPCPreviousMonth  = DATEADD( MONTH, -1, @DateIPCCurrent )\n";
                _QueryIndex += "SET @DateIPCTwoMonthBefore = DATEADD( MONTH, -1, @DateIPCPreviousMonth )\n\n";

                _QueryIndex += "SELECT @Date = MAX( vmfecha )\n";
                _QueryIndex += "  FROM BacParamSuda.dbo.VALOR_MONEDA WITH(NOLOCK)\n";
                _QueryIndex += " WHERE vmcodigo  = 807\n";
                _QueryIndex += "   AND vmvalor  <> 0\n\n";

                _QueryIndex += "CREATE TABLE #tmpTasas\n";
                _QueryIndex += "       (\n";
                _QueryIndex += "         DateValue                      DATETIME\n";
                _QueryIndex += "       , RateCode                       INT\n";
                _QueryIndex += "       , RateValue                      FLOAT\n";
                _QueryIndex += "       )\n\n";

                _QueryIndex += "INSERT INTO #tmpTasas\n";
                _QueryIndex += "       SELECT vmfecha\n";
                _QueryIndex += "            , vmcodigo\n";
                _QueryIndex += "            , vmvalor\n";
                _QueryIndex += "         FROM BacParamSuda.dbo.VALOR_MONEDA WITH(NOLOCK)\n";
                _QueryIndex += "        WHERE vmcodigo       = 502\n";
                _QueryIndex += "          AND vmfecha       in ( @DateIPCCurrent, @DateIPCPreviousMonth, @DateIPCTwoMonthBefore )\n\n";

                _QueryIndex += "INSERT INTO #tmpTasas\n";
                _QueryIndex += "       SELECT vmfecha\n";
                _QueryIndex += "            , vmcodigo\n";
                _QueryIndex += "            , vmvalor\n";
                _QueryIndex += "         FROM BacParamSuda.dbo.VALOR_MONEDA WITH(NOLOCK)\n";
                _QueryIndex += "        WHERE vmcodigo  = 807\n";
                _QueryIndex += "          AND vmfecha   = @Date\n\n";

                _QueryIndex += "SELECT * FROM #tmpTasas\n\n";

                _QueryIndex += "DROP TABLE #tmpTasas\n\n";

                _QueryIndex = _QueryIndex.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACFWDSUDA");
                DataTable _IndexValueForwardFixingRate;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryIndex);
                    _IndexValueForwardFixingRate = _Connect.QueryDataTable();
                    _IndexValueForwardFixingRate.TableName = "IndexValueForwardFixingRate";

                    if (_IndexValueForwardFixingRate.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _IndexValueForwardFixingRate = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _IndexValueForwardFixingRate;
 
            }
        }

        #endregion

        #region "Datos que se obtinen del Bloomberg"

        private class SourceBloomberg : Source
        {
        }

        #endregion

        #region "Datos que se obtinen de Excel"

        private class SourceExcel : Source
        {
        }

        #endregion

        #region "Datos que se obtinen de XML"

        private class SourceXML : Source
        {
        }

        #endregion

        #endregion

    }

}
