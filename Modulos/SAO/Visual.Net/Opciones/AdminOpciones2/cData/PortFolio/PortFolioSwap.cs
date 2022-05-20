using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;
using Microsoft.VisualBasic;

namespace cData.PortFolio
{

    public class PortFolioSwap
    {

        #region "Atributos privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public PortFolioSwap()
        {
            Set(enumSource.System);
        }

        public PortFolioSwap(enumSource _ID)
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
                    _Message = "La cartera se encuentra cargada de SWAP.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error en la cargar de la cartera de SWAP.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error en la cargar de la cartera de SWAP.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la cartera de SWAP.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Se fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "Se esta cargando la cartera de SWAP.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la cartera de SWAP.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro la cartera de SWAP.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataSet LoadPortFolio(DateTime portFolioDate)
        {

            DataSet _PortFolioSet;
            DataTable _PortFolioData;
            DataTable _PortFolioFlow;

            _PortFolioSet = new DataSet();
            _PortFolioData = new DataTable();
            _PortFolioFlow = new DataTable();

            _PortFolioData = LoadPortFolioData(portFolioDate);
            _PortFolioFlow = LoadPortFolioFlow(portFolioDate);

            _PortFolioSet.Merge(_PortFolioData);
            _PortFolioSet.Merge(_PortFolioFlow);

            return _PortFolioSet;

        }

        private DataTable LoadPortFolioData(DateTime portFolioDate)
        {
            DataTable _SwapPortFolio = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SwapPortFolio = _System.LoadPortFolio(portFolioDate);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SwapPortFolio = _Bloomberg.LoadPortFolio(portFolioDate);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SwapPortFolio = _Excel.LoadPortFolio(portFolioDate);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SwapPortFolio = _XML.LoadPortFolio(portFolioDate);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SwapPortFolio;

        }

        private DataTable LoadPortFolioFlow(DateTime portFolioDate)
        {
            DataTable _SwapAssetFlow = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SwapAssetFlow = _System.LoadFlow(portFolioDate);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SwapAssetFlow = _Bloomberg.LoadFlow(portFolioDate);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SwapAssetFlow = _Excel.LoadFlow(portFolioDate);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SwapAssetFlow = _XML.LoadFlow(portFolioDate);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SwapAssetFlow;

        }

        public DataTable LoadMTMYesterday(DateTime portFolioYesterday)
        {

            DataTable _SwapMTMYesterday = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SwapMTMYesterday = _System.LoadMTMYesterday(portFolioYesterday);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SwapMTMYesterday = _Bloomberg.LoadMTMYesterday(portFolioYesterday);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SwapMTMYesterday = _Excel.LoadMTMYesterday(portFolioYesterday);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SwapMTMYesterday = _XML.LoadMTMYesterday(portFolioYesterday);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SwapMTMYesterday;

        }

        public void SavePortFolio(DateTime portFolioDate, DataSet portFolioDataSet)
        {

            #region "Definición de variables"

            int _ContractID;
            int _SensibilitiesRow;
            double _SensibilitiesID;
            double _ID;
            string _Query;
            string _QuerySwap;

            DataTable _Yield;
            DataTable _PortFolioT0;
            DataTable _PortFolioT1;
            DataTable _TimeDecay;
            DataTable _ExchangeRate;
            DataTable _EffectRate;
            DataTable _PortFolioFlow;
            DataTable _PortFolioYesterday;

            DataRow _DataRow;
            DataRow _PortFolioT0Row;
            DataRow _PortFolioT1Row;
            DataRow _TimeDecayRow;
            DataRow _ExchangeRateRow;
            DataRow _EffectRateRow;
            DataRow[] _DataRows;
            DataRow[] _DataRowsYesterday;

            DateTime _SensibilitiesDate;
            string _YieldName;
            int _Term;
            double _MarktoMarketValue;
            double _SensibilitiesValue;
            double _Sensibilities;
            double _DeltaRate;
            double _EstimationValue;
            int _UserCreator;

            string _KeyOperation;
            string _KeySensibilities;
            string _KeyFlowID;

            string _SystemID;
            string _BookID;
            string _PortFolioRulesID;
            string _FinancialPortFolioID;
            string _ProductID;
            int _PrimaryCurrencyID;
            int _SecondCurrencyID;
            int _PrimaryRateID;
            int _SecondRateID;
            string _FamilyID;
            string _MnemonicsMask;
            string _Mnemonics;
            int _IssueID;
            string _FlagQuotes;
            DateTime _ExpiryDate;
            int _OperationNumber;
            int _OperationID;
            int _CustomerID;
            int _CustomerCode;
            int _CurrencyIssue;
            double _AmountAsset;
            double _AmountLiabilities;
            double _MarktoMarketValueYesterday;
            double _MarktoMarketValueToday;
            double _MarktoMarketValueTodayUM;
            double _MarktoMarketValueTimeDecay;
            double _MarktoMarketValueExchangeRate;
            double _MarktoMarketValueEffectRate;
            double _CashFlow;
            double _MarktoMarketRateYesterday;
            double _MarktoMarketRateToday;
            double _MarktoMarketRateEndMonth;
            double _PresentValueOriginSystem;
            double _RateAsset;
            double _SpreadAsset;
            double _ConventionAsset;
            double _FairValueAsset;
            double _FairValueAssetUM;
            double _RateLiabilities;
            double _SpreadLiabilities;
            double _ConventionLiabilities;
            double _FairValueLiabilities;
            double _FairValueLiabilitiesUM;
            double _FairValueNet;
            double _FairValueAssetYesterday;
            double _FairValueAssetYesterdayUM;
            double _FairValueLiabilitiesYesterday;
            double _FairValueLiabilitiesYesterdayUM;
            double _FairValueNetYesterday;
            double _FairValueAssetSystem;
            double _FairValueAssetUMSystem;
            double _FairValueLiabilitiesSystem;
            double _FairValueLiabilitiesUMSystem;
            double _FairValueNetSystem;

            double _TimeDecayAsset;
            double _TimeDecayLiabilities;
            double _TimeDecayNet;
            double _ExchangeRateAsset;
            double _ExchangeRateLiabilities;
            double _ExchangeRateNet;
            double _EffectRateAsset;
            double _EffectRateLiabilities;
            double _EffectRateNet;

            double _FlowID;
            int _LegID;
            DateTime _FixingDate;
            DateTime _StartingDate;
            DateTime _PaymentDate;
            double _Balance;
            string _ExchangePrincipal;
            string _PostPounding;
            double _Rate;
            double _Spread;
            double _AmortizationFlow;
            double _InterestFlow;
            double _AditionalFlow;
            double _TotalFlow;
            double _WellFactor;
            double _AmortizationPresentvalue;
            double _InterestPresentValue;
            double _AditionalPresentValue;
            double _PresentValue;
            double _RateDiscount;
            double _FairValueNetPortFolioYesterday;

            string _Status;

            double _ConvexitySystem;
            DateTime _ContractDate;
            DateTime _CourtDateCouponAsset;
            DateTime _CourtDateCouponLiabilities;

            #endregion

            #region "Asignación de Variables"

            _Yield = portFolioDataSet.Tables["OperacionesPorPlazo"];
            _PortFolioT0 = portFolioDataSet.Tables["PortFolioT0"];
            _PortFolioT1 = portFolioDataSet.Tables["PortFolioT1"];
            _TimeDecay = portFolioDataSet.Tables["TimeDecay"];
            _ExchangeRate = portFolioDataSet.Tables["ExchangeRate"];
            _EffectRate = portFolioDataSet.Tables["EffectRate"];
            _PortFolioFlow = portFolioDataSet.Tables["SensibilitiesFlow"];
            _PortFolioYesterday = portFolioDataSet.Tables["PortFolioYesterday"];

            #endregion

            #region "Seteo de la Conneccion a la base de datos"

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");

            #endregion

            #region "Conneccion a la base de datos"

            _Connect.Connection();

            #endregion

            #region "Asignación de valores estandars"

            _SensibilitiesDate = portFolioDate;
            _SystemID = "PCS";

            #endregion

            #region "Limpia Datos Sensibilidad"

            _Query = "";
            _Query += "DELETE dbo.SensibilitiesYield WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = 'PCS'\n";
            _Query += "DELETE dbo.SensibilitiesData  WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = 'PCS'\n";
            _Query += "DELETE dbo.SensibilitiesFlow  WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = 'PCS'\n";
            _Query += "DELETE dbo.SensibilitiesSwap  WHERE sensibilitiesdate = [@SensibilitiesDate]\n";

            _Query = _Query.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");

            _Connect.DedicatedExecution(_Query);

            #endregion

            #region "Grabar Datos"

            #region "Generar ID"

            _ID = 0;
            _SensibilitiesID = _ID;
            _FlowID = _ID;

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
                _ProductID = _PortFolioT0Row["SwapType"].ToString(); //TipoOperacion
                _PrimaryCurrencyID = int.Parse(_PortFolioT0Row["AssetCurrency"].ToString());
                _SecondCurrencyID = int.Parse(_PortFolioT0Row["LiabilitiesCurrency"].ToString());
                _PrimaryRateID = int.Parse(_PortFolioT0Row["AssetRateID"].ToString());
                _SecondRateID = int.Parse(_PortFolioT0Row["LiabilitiesRateID"].ToString());
                _CurrencyIssue = int.Parse(_PortFolioT0Row["AssetRateID"].ToString());
                _FamilyID = "";
                _MnemonicsMask = "";
                _Mnemonics = "";
                _IssueID = 0;
                _ContractDate = DateTime.Parse(_PortFolioT0Row["ContractDate"].ToString());

                if (!_PrimaryCurrencyID.Equals(_SecondCurrencyID))
                {
                    _ProductID = "SM";
                }
                else if (_PrimaryRateID.Equals(13) || _SecondRateID.Equals(13))
                {
                    _ProductID = "SP";
                }
                else
                {
                    _ProductID = "ST";
                }

                _OperationNumber = int.Parse(_PortFolioT0Row["OperationNumber"].ToString());
                _OperationID = 0;

                _DataRowsYesterday = _PortFolioYesterday.Select("OperationNumber = " + _OperationNumber.ToString());

                _FlagQuotes = "N";
                _ExpiryDate = DateTime.Parse(_PortFolioT0Row["ExpiryDate"].ToString());
                _CustomerID = int.Parse(_PortFolioT0Row["CustomerID"].ToString());
                _CustomerCode = int.Parse(_PortFolioT0Row["CustomerCode"].ToString());

                _AmountAsset = double.Parse(_PortFolioT0Row["AssetAmount"].ToString());
                _AmountLiabilities = double.Parse(_PortFolioT0Row["LiabilitiesAmount"].ToString());
                _MarktoMarketValueTodayUM = 0; //double.Parse(_PortFolioT0Row["ValuatorNetCLP"].ToString());

                _RateAsset = double.Parse(_PortFolioT0Row["AssetRate"].ToString());
                _SpreadAsset = double.Parse(_PortFolioT0Row["AssetSpread"].ToString());
                _ConventionAsset = 0;

                _FairValueAsset = double.Parse(_PortFolioT0Row["ValuatorAssetCLP"].ToString());
                _FairValueAssetUM = double.Parse(_PortFolioT0Row["ValuatorAsset"].ToString());

                _RateLiabilities = double.Parse(_PortFolioT0Row["LiabilitiesRate"].ToString());
                _SpreadLiabilities = double.Parse(_PortFolioT0Row["LiabilitiesSpread"].ToString());
                _ConventionLiabilities = 0;

                _FairValueLiabilities = double.Parse(_PortFolioT0Row["ValuatorLiabilitiesCLP"].ToString());
                _FairValueLiabilitiesUM = double.Parse(_PortFolioT0Row["ValuatorLiabilities"].ToString());
                _FairValueNet = double.Parse(_PortFolioT0Row["ValuatorNetCLP"].ToString());

                _MarktoMarketValueToday = double.Parse(_PortFolioT0Row["ValuatorNetCLP"].ToString());

                _MarktoMarketValueTimeDecay = double.Parse(_TimeDecayRow["ValuatorNetCLP"].ToString());
                _MarktoMarketValueExchangeRate = double.Parse(_ExchangeRateRow["ValuatorNetCLP"].ToString());
                _MarktoMarketValueEffectRate = double.Parse(_EffectRateRow["ValuatorNetCLP"].ToString());

                _TimeDecayAsset = double.Parse(_TimeDecayRow["ValuatorAssetCLP"].ToString());
                _TimeDecayLiabilities = double.Parse(_TimeDecayRow["ValuatorLiabilitiesCLP"].ToString());
                _TimeDecayNet = double.Parse(_TimeDecayRow["ValuatorNetCLP"].ToString());

                _ExchangeRateAsset = double.Parse(_ExchangeRateRow["ValuatorAssetCLP"].ToString());
                _ExchangeRateLiabilities = double.Parse(_ExchangeRateRow["ValuatorLiabilitiesCLP"].ToString());
                _ExchangeRateNet = double.Parse(_ExchangeRateRow["ValuatorNetCLP"].ToString());

                _EffectRateAsset = double.Parse(_EffectRateRow["ValuatorAssetCLP"].ToString());
                _EffectRateLiabilities = double.Parse(_EffectRateRow["ValuatorLiabilitiesCLP"].ToString());
                _EffectRateNet = double.Parse(_EffectRateRow["ValuatorNetCLP"].ToString());

                _FairValueNetPortFolioYesterday = double.Parse(_PortFolioT1Row["ValuatorNetCLP"].ToString());

                if (_DataRowsYesterday.Length > 0)
                {
                    _MarktoMarketValueYesterday = double.Parse(_DataRowsYesterday[0]["ValuatorNetCLP"].ToString());
                    _FairValueAssetYesterday = double.Parse(_DataRowsYesterday[0]["ValuatorAssetCLP"].ToString());
                    _FairValueAssetYesterdayUM = double.Parse(_DataRowsYesterday[0]["ValuatorAsset"].ToString());
                    _FairValueLiabilitiesYesterday = double.Parse(_DataRowsYesterday[0]["ValuatorLiabilitiesCLP"].ToString());
                    _FairValueLiabilitiesYesterdayUM = double.Parse(_DataRowsYesterday[0]["ValuatorLiabilities"].ToString());
                    _FairValueNetYesterday = double.Parse(_DataRowsYesterday[0]["ValuatorNetCLP"].ToString());
                }
                else
                {
                    _MarktoMarketValueYesterday = 0;
                    _FairValueAssetYesterday = 0;
                    _FairValueAssetYesterdayUM = 0;
                    _FairValueLiabilitiesYesterday = 0;
                    _FairValueLiabilitiesYesterdayUM = 0;
                    _FairValueNetYesterday = 0;
                }


                if (_ExpiryDate.Equals(portFolioDate))
                {
                    _MarktoMarketValueToday = 0;
                    _MarktoMarketValueTimeDecay = _MarktoMarketValueToday - _MarktoMarketValueYesterday;

                    _TimeDecayAsset = _FairValueAsset - _FairValueAssetYesterday;
                    _TimeDecayLiabilities = _FairValueLiabilities - _FairValueLiabilitiesYesterday;
                    _TimeDecayNet = _FairValueNet - _FairValueNetYesterday;

                }

                if (_ContractDate.Equals(portFolioDate))
                {
                    _MarktoMarketValueYesterday = 0;
                    _MarktoMarketValueTimeDecay = 0;
                    _MarktoMarketValueExchangeRate = 0;

                    _TimeDecayAsset = 0;
                    _TimeDecayLiabilities = 0;
                    _TimeDecayNet = 0;

                    _ExchangeRateAsset = 0;
                    _ExchangeRateLiabilities = 0;
                    _ExchangeRateNet = 0;

                    _EffectRateAsset = _FairValueAsset;
                    _EffectRateLiabilities = _FairValueLiabilities;
                    _EffectRateNet = _FairValueNet;

                    _MarktoMarketValueEffectRate = _MarktoMarketValueToday;
                    _CashFlow = 0;
                }

                _CourtDateCouponAsset = DateTime.Parse(_PortFolioT1Row["CourtDateCouponAsset"].ToString());
                _CourtDateCouponLiabilities = DateTime.Parse(_PortFolioT1Row["CourtDateCouponLiabilities"].ToString());

                _CashFlow = double.Parse(_PortFolioT0Row["CashFlow"].ToString());
                _MarktoMarketRateYesterday = 0;
                _MarktoMarketRateToday = 0;
                _MarktoMarketRateEndMonth = 0;
                _PresentValueOriginSystem = 0;
                _FairValueAssetSystem = double.Parse(_PortFolioT0Row["AssetMarketAmountCLP"].ToString());
                _FairValueAssetUMSystem = double.Parse(_PortFolioT0Row["AssetMarketAmountUM"].ToString());
                _FairValueLiabilitiesSystem = double.Parse(_PortFolioT0Row["LiabilitiesMarketAmountCLP"].ToString());
                _FairValueLiabilitiesUMSystem = double.Parse(_PortFolioT0Row["LiabilitiesMarketAmountUM"].ToString());
                _FairValueNetSystem = double.Parse(_PortFolioT0Row["FairValueCLP"].ToString()); ///_FairValueLiabilitiesSystem - _FairValueAssetSystem;
                _ConvexitySystem = 0;
                _Status = _PortFolioT0Row["StatusOperation"].ToString();

                _ID++;
                _KeyOperation = portFolioDate.ToString("yyyyMMdd") + "3" + _ID.ToString("0000000");


                #endregion

                #region "Setea Query del contrato"

                _Query = "";

                #region "Definición y seteo de Variables"

                _Query += "DECLARE @FairValueAssetYesterday          FLOAT\n";
                _Query += "DECLARE @FairValueAssetYesterdayUM        FLOAT\n";
                _Query += "DECLARE @FairValueLiabilitiesYesterday    FLOAT\n";
                _Query += "DECLARE @FairValueLiabilitiesYesterdayUM  FLOAT\n";
                _Query += "DECLARE @FairValueNetYesterday            FLOAT\n";
                _Query += "DECLARE @MarktoMarketValueYesterday       FLOAT\n\n";

                _Query += "SET @FairValueAssetYesterday         = [@FairValueAssetYesterday]\n";
                _Query += "SET @FairValueAssetYesterdayUM       = [@FairValueAssetYesterdayUM]\n";
                _Query += "SET @FairValueLiabilitiesYesterday   = [@FairValueLiabilitiesYesterday]\n";
                _Query += "SET @FairValueLiabilitiesYesterdayUM = [@FairValueLiabilitiesYesterdayUM]\n";
                _Query += "SET @FairValueNetYesterday           = [@FairValuenetYesterday]\n";
                _Query += "SET @MarktoMarketValueYesterday      = [@MarktoMarketValueYesterday]\n\n";

                #endregion

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
                _Query += " )";
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
                _Query += " )\n\n";

                #endregion

                #region "Unwind"

                if (_Status.Equals("N"))
                {

                    _Query += "DECLARE @DateProcessYesterday        DATETIME\n\n";

                    _Query += "SELECT @DateProcessYesterday = MAX(sensibilitiesdate)\n";
                    _Query += "  FROM dbo.SensibilitiesSwap\n";
                    _Query += " WHERE sensibilitiesdate < [@SensibilitiesDate]\n\n";

                    _Query += "SELECT @FairValueAssetYesterday         = SW.fairvalueasset\n";
                    _Query += "     , @FairValueAssetYesterdayUM       = SW.fairvalueassetum\n";
                    _Query += "     , @FairValueLiabilitiesYesterday   = SW.fairvalueliabilities\n";
                    _Query += "     , @FairValueLiabilitiesYesterdayUM = SW.fairvalueliabilitiesum\n";
                    _Query += "     , @FairValueNetYesterday           = SW.fairvaluenet\n";
                    _Query += "     , @MarktoMarketValueYesterday      = SW.fairvaluenet\n";
                    _Query += "  FROM SensibilitiesData            SD\n";
                    _Query += "       inner join SensibilitiesSwap SW ON SD.id = SW.id\n";
                    _Query += " WHERE SD.sensibilitiesdate = @DateProcessYesterday\n";
                    _Query += "   AND SD.operationnumber   = [@OperationNumber]\n\n";

                }

                #endregion

                #region "Save SensibilitiesSwap"

                _Query += "INSERT INTO dbo.SensibilitiesSwap ( ";
                _Query += "id";
                _Query += ", sensibilitiesdate";
                _Query += ", contractdate";
                _Query += ", amountasset";
                _Query += ", amountliabilities";
                _Query += ", marktomarketvalueyesterday";
                _Query += ", marktomarketvaluetoday";
                _Query += ", marktomarketvaluetodayum";
                _Query += ", marktomarketvaluetimedecay";
                _Query += ", marktomarketvalueexchangerate";
                _Query += ", marktomarketvalueeffectrate";
                _Query += ", marktomarketrateyesterday";
                _Query += ", marktomarketratetoday";
                _Query += ", marktomarketrateendmonth";
                _Query += ", timedecayasset";
                _Query += ", timedecayliabilities";
                _Query += ", timedecaynet";
                _Query += ", exchangerateasset";
                _Query += ", exchangerateliabilities";
                _Query += ", exchangeratenet";
                _Query += ", effectrateasset";
                _Query += ", effectrateliabilities";
                _Query += ", effectratenet";
                _Query += ", cashflow";
                _Query += ", courtdatecouponasset";
                _Query += ", courtdatecouponliabilities";
                _Query += ", rateasset";
                _Query += ", spreadasset";
                _Query += ", conventionasset";
                _Query += ", fairvalueasset";
                _Query += ", fairvalueassetum";
                _Query += ", rateliabilities";
                _Query += ", spreadliabilities";
                _Query += ", conventionliabilities";
                _Query += ", fairvalueliabilities";
                _Query += ", fairvalueliabilitiesum";
                _Query += ", fairvaluenet";
                _Query += ", fairvalueassetyesterday";
                _Query += ", fairvalueassetyesterdayum";
                _Query += ", fairvalueliabilitiesyesterday";
                _Query += ", fairvalueliabilitiesyesterdayum";
                _Query += ", fairvaluenetyesterday";
                _Query += ", fairvalueassetsystem";
                _Query += ", fairvalueassetumsystem";
                _Query += ", fairvalueliabilitiessystem";
                _Query += ", fairvalueliabilitiesumsystem";
                _Query += ", fairvaluenetsystem";
                _Query += ", fairvaluenetportfolioyesterday";
                _Query += ", status";
                _Query += " )";
                _Query += "VALUES ( ";
                _Query += "[@DataID]";
                _Query += ", [@SensibilitiesDate]";
                _Query += ", [@ContractDate]";
                _Query += ", [@AmountAsset]";
                _Query += ", [@AmountLiabilities]";
                _Query += ", @MarktoMarketValueYesterday";
                _Query += ", [@MarktoMarketValueToday]";
                _Query += ", [@MarktoMarketValueTodayUM]";
                _Query += ", [@MarktoMarketValueTimeDecay]";
                _Query += ", [@MarktoMarketValueExchangeRate]";
                _Query += ", [@MarktoMarketValueEffectRate]";
                _Query += ", [@MarktoMarketRateYesterday]";
                _Query += ", [@MarktoMarketRateToday]";
                _Query += ", [@MarktoMarketRateEndMonth]";
                _Query += ", [@TimeDecayAsset]";
                _Query += ", [@TimeDecayLiabilities]";
                _Query += ", [@TimeDecayNet]";
                _Query += ", [@ExchangeRateAsset]";
                _Query += ", [@ExchangeRateLiabilities]";
                _Query += ", [@ExchangeRateNet]";
                _Query += ", [@EffectRateAsset]";
                _Query += ", [@EffectRateLiabilities]";
                _Query += ", [@EffectRateNet]";
                _Query += ", [@CashFlow]";
                _Query += ", [@CourtDateCouponAsset]";
                _Query += ", [@CourtDateCouponLiabilities]";
                _Query += ", [@RateAsset]";
                _Query += ", [@SpreadAsset]";
                _Query += ", [@ConventionAsset]";
                _Query += ", [@FairValueAsset]";
                _Query += ", [@FairValueAssetUM]";
                _Query += ", [@RateLiabilities]";
                _Query += ", [@SpreadLiabilities]";
                _Query += ", [@ConventionLiabilities]";
                _Query += ", [@FairValueLiabilities]";
                _Query += ", [@FairValueLiabilitiesUM]";
                _Query += ", [@FairValueNet]";
                _Query += ", @FairValueAssetYesterday";
                _Query += ", @FairValueAssetYesterdayUM";
                _Query += ", @FairValueLiabilitiesYesterday";
                _Query += ", @FairValueLiabilitiesYesterdayUM";
                _Query += ", @FairValuenetYesterday";
                _Query += ", [@FairValueAssetSystem]";
                _Query += ", [@FairValueAssetUMSystem]";
                _Query += ", [@FairValueLiabilitiesSystem]";
                _Query += ", [@FairValueLiabilitiesUMSystem]";
                _Query += ", [@FairValueNetSystem]";
                _Query += ", [@FairValueNetPortFolioYesterday]";
                _Query += ", [@Status]";
                _Query += " )\n\n";

                #endregion

                #region "Value Assing"

                _Query = _Query.Replace("[@DataID]", _KeyOperation);
                _Query = _Query.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@SystemID]", "'" + _SystemID + "'");
                _Query = _Query.Replace("[@BookID]", "'" + _BookID + "'");
                _Query = _Query.Replace("[@PortFolioRulesID]", "'" + _PortFolioRulesID + "'");
                _Query = _Query.Replace("[@FinancialPortFolioID]", "'" + _FinancialPortFolioID + "'");
                _Query = _Query.Replace("[@ProductID]", "'" + _ProductID + "'");
                _Query = _Query.Replace("[@PrimaryCurrencyID]", _PrimaryCurrencyID.ToString());
                _Query = _Query.Replace("[@SecondCurrencyID]", _SecondCurrencyID.ToString());
                _Query = _Query.Replace("[@PrimaryRateID]", _PrimaryRateID.ToString());
                _Query = _Query.Replace("[@SecondRateID]", _SecondRateID.ToString());
                _Query = _Query.Replace("[@FamilyID]", "'" + _FamilyID + "'");
                _Query = _Query.Replace("[@MnemonicsMask]", "'" + _MnemonicsMask + "'");
                _Query = _Query.Replace("[@Mnemonics]", "'" + _Mnemonics + "'");
                _Query = _Query.Replace("[@IssueID]", _IssueID.ToString());
                _Query = _Query.Replace("[@FlagQuotes]", "'" + _FlagQuotes + "'");
                _Query = _Query.Replace("[@ExpiryDate]", "'" + _ExpiryDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@OperationNumber]", _OperationNumber.ToString());
                _Query = _Query.Replace("[@OperationID]", _OperationID.ToString());
                _Query = _Query.Replace("[@CustomerID]", _CustomerID.ToString());
                _Query = _Query.Replace("[@CustomerCode]", _CustomerCode.ToString());
                _Query = _Query.Replace("[@CurrencyIssue]", _CurrencyIssue.ToString());
                _Query = _Query.Replace("[@ContractDate]", "'" + _ContractDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@AmountAsset]", _AmountAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@AmountLiabilities]", _AmountLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueYesterday]", _MarktoMarketValueYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueToday]", _MarktoMarketValueToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueTodayUM]", _MarktoMarketValueTodayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueTimeDecay]", _MarktoMarketValueTimeDecay.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueExchangeRate]", _MarktoMarketValueExchangeRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueEffectRate]", _MarktoMarketValueEffectRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateYesterday]", _MarktoMarketRateYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateToday]", _MarktoMarketRateToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateEndMonth]", _MarktoMarketRateEndMonth.ToString("0.0000000000").Replace(",", "."));

                _Query = _Query.Replace("[@TimeDecayAsset]", _TimeDecayAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@TimeDecayLiabilities]", _TimeDecayLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@TimeDecayNet]", _TimeDecayNet.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ExchangeRateAsset]", _ExchangeRateAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ExchangeRateLiabilities]", _ExchangeRateLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ExchangeRateNet]", _ExchangeRateNet.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@EffectRateAsset]", _EffectRateAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@EffectRateLiabilities]", _EffectRateLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@EffectRateNet]", _EffectRateNet.ToString("0.0000000000").Replace(",", "."));

                _Query = _Query.Replace("[@CashFlow]", _CashFlow.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CourtDateCouponAsset]", "'" + _CourtDateCouponAsset.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@CourtDateCouponLiabilities]", "'" + _CourtDateCouponLiabilities.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@PresentValueOriginSystem]", _PresentValueOriginSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetSystem]", _FairValueAssetSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetUMSystem]", _FairValueAssetUMSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesSystem]", _FairValueLiabilitiesSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesUMSystem]", _FairValueLiabilitiesUMSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueNetSystem]", _FairValueNetSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ConvexitySystem]", _ConvexitySystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetYesterday]", _FairValueAssetYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetYesterdayUM]", _FairValueAssetYesterdayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesYesterday]", _FairValueLiabilitiesYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesYesterdayUM]", _FairValueLiabilitiesYesterdayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValuenetYesterday]", _FairValueNetYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@RateAsset]", _RateAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@SpreadAsset]", _SpreadAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ConventionAsset]", _ConventionAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAsset]", _FairValueAsset.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetUM]", _FairValueAssetUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@RateLiabilities]", _RateLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@SpreadLiabilities]", _SpreadLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ConventionLiabilities]", _ConventionLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilities]", _FairValueLiabilities.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesUM]", _FairValueLiabilitiesUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueNet]", _FairValueNet.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueNetPortFolioYesterday]", _FairValueNetPortFolioYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@Status]", "'" + _Status + "'");

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
                    _KeySensibilities = portFolioDate.ToString("yyyyMMdd") + "3" + _SensibilitiesID.ToString("0000000");


                    #endregion

                    #region "Setea Query Sensibilidad"

                    _QuerySwap = "-- Row " + _KeySensibilities + "\n";
                    _QuerySwap += "INSERT INTO dbo.SensibilitiesYield ( ";
                    _QuerySwap += "id";
                    _QuerySwap += ", dataid";
                    _QuerySwap += ", sensibilitiesdate";
                    _QuerySwap += ", [system]";
                    _QuerySwap += ", mnemonicsmask";
                    _QuerySwap += ", family";
                    _QuerySwap += ", operationnumber";
                    _QuerySwap += ", operationid";
                    _QuerySwap += ", yieldname";
                    _QuerySwap += ", term";
                    _QuerySwap += ", marktomarketvalue";
                    _QuerySwap += ", sensibilitiesvalue";
                    _QuerySwap += ", sensibilities";
                    _QuerySwap += ", deltarate";
                    _QuerySwap += ", estimationvalue";
                    _QuerySwap += ", usercreator ";
                    _QuerySwap += ")";
                    _QuerySwap += "VALUES ( ";
                    _QuerySwap += "[@SensibilitiesID]";
                    _QuerySwap += ", [@DataID]";
                    _QuerySwap += ", [@SensibilitiesDate]";
                    _QuerySwap += ", [@SystemID]";
                    _QuerySwap += ", [@MnemonicsMask]";
                    _QuerySwap += ", [@FamilyID]";
                    _QuerySwap += ", [@OperationNumber]";
                    _QuerySwap += ", [@OperationID]";
                    _QuerySwap += ", [@YieldName]";
                    _QuerySwap += ", [@Term]";
                    _QuerySwap += ", [@MarktoMarketValue]";
                    _QuerySwap += ", [@SensibilitiesValue]";
                    _QuerySwap += ", [@Sensibilities]";
                    _QuerySwap += ", [@BPs]";
                    _QuerySwap += ", [@EstimationValue]";
                    _QuerySwap += ", [@UserCreator] )\n\n";

                    _QuerySwap = _QuerySwap.Replace("[@SensibilitiesID]", _KeySensibilities);
                    _QuerySwap = _QuerySwap.Replace("[@DataID]", _KeyOperation);
                    _QuerySwap = _QuerySwap.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
                    _QuerySwap = _QuerySwap.Replace("[@SystemID]", "'" + _SystemID + "'");
                    _QuerySwap = _QuerySwap.Replace("[@MnemonicsMask]", "'" + _MnemonicsMask + "'");
                    _QuerySwap = _QuerySwap.Replace("[@FamilyID]", "'" + _FamilyID + "'");
                    _QuerySwap = _QuerySwap.Replace("[@OperationNumber]", _OperationNumber.ToString());
                    _QuerySwap = _QuerySwap.Replace("[@OperationID]", _OperationID.ToString());
                    _QuerySwap = _QuerySwap.Replace("[@YieldName]", "'" + _YieldName + "'");
                    _QuerySwap = _QuerySwap.Replace("[@Term]", _Term.ToString());
                    _QuerySwap = _QuerySwap.Replace("[@MarktoMarketValue]", _MarktoMarketValue.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@SensibilitiesValue]", _SensibilitiesValue.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@Sensibilities]", _Sensibilities.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@BPs]", _DeltaRate.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@EstimationValue]", _EstimationValue.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@UserCreator]", _UserCreator.ToString());

                    _Query += _QuerySwap;

                    #endregion

                }

                #endregion

                #region "Grabar Flujo de Swap"

                _DataRows = _PortFolioFlow.Select("OperationNumber = " + _OperationNumber.ToString());

                for (_SensibilitiesRow = 0; _SensibilitiesRow < _DataRows.Length; _SensibilitiesRow++)
                {

                    #region "Seteo Sensibilidad"

                    _DataRow = _DataRows[_SensibilitiesRow];

                    #endregion

                    #region "Seteo de Variables de Sensibilidad"

                    _FlowID++;
                    _LegID = int.Parse(_DataRow["Leg"].ToString());
                    _FixingDate = DateTime.Parse(_DataRow["Fixingdate"].ToString());
                    _StartingDate = DateTime.Parse(_DataRow["Startingdate"].ToString());
                    _ExpiryDate = DateTime.Parse(_DataRow["Expirydate"].ToString());
                    _PaymentDate = DateTime.Parse(_DataRow["Paymentdate"].ToString());
                    _Balance = double.Parse(_DataRow["Balance"].ToString());
                    _ExchangePrincipal = _DataRow["Exchangeprincipal"].ToString();
                    _PostPounding = _DataRow["Postpounding"].ToString();
                    _Rate = double.Parse(_DataRow["Rate"].ToString());
                    _Spread = double.Parse(_DataRow["Spread"].ToString());
                    _AmortizationFlow = double.Parse(_DataRow["AmortizationFlow"].ToString());
                    _InterestFlow = double.Parse(_DataRow["InterestFlow"].ToString());
                    _AditionalFlow = double.Parse(_DataRow["AditionalFlow"].ToString());
                    _TotalFlow = double.Parse(_DataRow["TotalFlow"].ToString());
                    _RateDiscount = double.Parse(_DataRow["RateDiscount"].ToString());
                    _WellFactor = double.Parse(_DataRow["WellFactor"].ToString());
                    _AmortizationPresentvalue = double.Parse(_DataRow["PresentValueAmortization"].ToString());
                    _InterestPresentValue = double.Parse(_DataRow["PresentValueInterest"].ToString());
                    _AditionalPresentValue = double.Parse(_DataRow["PresentValueAditionalFlow"].ToString());
                    _PresentValue = double.Parse(_DataRow["PresentValue"].ToString());
                    _KeyFlowID = portFolioDate.ToString("yyyyMMdd") + "3" + _FlowID.ToString("0000000");

                    #endregion

                    #region "Setea Query Sensibilidad"

                    _QuerySwap = "-- Row " + _SensibilitiesID.ToString() + "\n";
                    _QuerySwap += "INSERT INTO dbo.SensibilitiesFlow ( ";
                    _QuerySwap += "id";
                    _QuerySwap += ", sensibilitiesdate";
                    _QuerySwap += ", system";
                    _QuerySwap += ", dataid";
                    _QuerySwap += ", operationid";
                    _QuerySwap += ", legid";
                    _QuerySwap += ", fixingdate";
                    _QuerySwap += ", startingdate";
                    _QuerySwap += ", expirydate";
                    _QuerySwap += ", paymentdate";
                    _QuerySwap += ", balance";
                    _QuerySwap += ", exchangeprincipal";
                    _QuerySwap += ", postpounding";
                    _QuerySwap += ", rate";
                    _QuerySwap += ", spread";
                    _QuerySwap += ", amortizationflow";
                    _QuerySwap += ", interestflow";
                    _QuerySwap += ", aditionalflow";
                    _QuerySwap += ", totalflow";
                    _QuerySwap += ", ratediscount";
                    _QuerySwap += ", wellfactor";
                    _QuerySwap += ", amortizationpresentvalue";
                    _QuerySwap += ", interestpresentvalue";
                    _QuerySwap += ", aditionalpresentvalue";
                    _QuerySwap += ", presentvalue";
                    _QuerySwap += ")";
                    _QuerySwap += "VALUES ( ";

                    _QuerySwap += "[@FlowID]";
                    _QuerySwap += ", [@SensibilitiesDate]";
                    _QuerySwap += ", [@SystemID]";
                    _QuerySwap += ", [@DataID]";
                    _QuerySwap += ", [@OperationNumber]";
                    _QuerySwap += ", [@LegID]";
                    _QuerySwap += ", [@FixingDate]";
                    _QuerySwap += ", [@StartingDate]";
                    _QuerySwap += ", [@ExpiryDate]";
                    _QuerySwap += ", [@PaymentDate]";
                    _QuerySwap += ", [@Balance]";
                    _QuerySwap += ", [@ExchangePrincipal]";
                    _QuerySwap += ", [@PostPounding]";
                    _QuerySwap += ", [@Rate]";
                    _QuerySwap += ", [@Spread]";
                    _QuerySwap += ", [@AmortizationFlow]";
                    _QuerySwap += ", [@InterestFlow]";
                    _QuerySwap += ", [@AditionalFlow]";
                    _QuerySwap += ", [@TotalFlow]";
                    _QuerySwap += ", [@RateDiscount]";
                    _QuerySwap += ", [@WellFactor]";
                    _QuerySwap += ", [@AmortizationPresentvalue]";
                    _QuerySwap += ", [@InterestPresentValue]";
                    _QuerySwap += ", [@AditionalPresentValue]";
                    _QuerySwap += ", [@PresentValue]";
                    _QuerySwap += ")";

                    _QuerySwap = _QuerySwap.Replace("[@FlowID]", _KeyFlowID);
                    _QuerySwap = _QuerySwap.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
                    _QuerySwap = _QuerySwap.Replace("[@SystemID]", "'" + _SystemID + "'");
                    _QuerySwap = _QuerySwap.Replace("[@DataID]", _KeyOperation);
                    _QuerySwap = _QuerySwap.Replace("[@OperationNumber]", _OperationNumber.ToString());
                    _QuerySwap = _QuerySwap.Replace("[@LegID]", _LegID.ToString());
                    _QuerySwap = _QuerySwap.Replace("[@FixingDate]", "'" + _FixingDate.ToString("yyyyMMdd") + "'");
                    _QuerySwap = _QuerySwap.Replace("[@StartingDate]", "'" + _StartingDate.ToString("yyyyMMdd") + "'");
                    _QuerySwap = _QuerySwap.Replace("[@ExpiryDate]", "'" + _ExpiryDate.ToString("yyyyMMdd") + "'");
                    _QuerySwap = _QuerySwap.Replace("[@PaymentDate]", "'" + _PaymentDate.ToString("yyyyMMdd") + "'");
                    _QuerySwap = _QuerySwap.Replace("[@Balance]", _Balance.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@ExchangePrincipal]", "'" + _ExchangePrincipal.Substring(0, 1) + "'");
                    _QuerySwap = _QuerySwap.Replace("[@PostPounding]", "'" + _PostPounding.Substring(0, 1) + "'");
                    _QuerySwap = _QuerySwap.Replace("[@Rate]", _Rate.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@Spread]", _Spread.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@AmortizationFlow]", _AmortizationFlow.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@InterestFlow]", _InterestFlow.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@AditionalFlow]", _AditionalFlow.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@TotalFlow]", _TotalFlow.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@RateDiscount]", _RateDiscount.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@WellFactor]", _WellFactor.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@AmortizationPresentvalue]", _AmortizationPresentvalue.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@InterestPresentValue]", _InterestPresentValue.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@AditionalPresentValue]", _AditionalPresentValue.ToString("0.0000000000").Replace(",", "."));
                    _QuerySwap = _QuerySwap.Replace("[@PresentValue]", _PresentValue.ToString("0.0000000000").Replace(",", "."));
                    //[@Balance], [@Exchangeprincipal], [@Postpounding]
                    _Query += _QuerySwap;

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

            public virtual DataTable LoadPortFolio(DateTime portFolioDate)
            {
                DataTable _SwapPortFolio = new DataTable();

                return _SwapPortFolio;
            }

            public virtual DataTable LoadFlow(DateTime portFolioDate)
            {
                DataTable _SwapFlow = new DataTable();

                return _SwapFlow;
            }

            public virtual DataTable LoadMTMYesterday(DateTime portFolioDateYesterday)
            {

                return new DataTable();

            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataTable LoadPortFolio(DateTime portFolioDate)
            {

                String _QuerySwap = "";

                #region "Query Load PortFolio Swap"

                _QuerySwap += "SET NOCOUNT ON\n\n";

                _QuerySwap += "DECLARE @ProcessDate                DATETIME\n";
                _QuerySwap += "DECLARE @PortFolioDateToday         DATETIME\n\n";

                _QuerySwap += "CREATE TABLE #TmpCartera\n";
                _QuerySwap += "       (\n";
                _QuerySwap += "         OperationNumber                                   INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , StatusOperation                                   CHAR(01)     NOT NULL DEFAULT ' '\n";
                _QuerySwap += "       , SwapType                                          INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , BookID                                            VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , PortfolioRulesID                                  VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , FinancialPortFolioID                              VARCHAR(20)  NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , OperationType                                     CHAR(01)     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , CustomerID                                        INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , CustomerCode                                      INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , ContractDate                                      DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , StartingDate                                      DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , ExpiryDate                                        DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , ValuatorDate                                      DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , FairValueUM                                       FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FairValueUSD                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FairValueCLP                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FairValueAdjustedUM                               FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FairValueAdjustedUSD                              FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FairValueAdjustedCLP                              FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetAmount                                       FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetAditionalFlow                                FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetCurrency                                     INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetRateID                                       INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetRate                                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetSpread                                       FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetMarketRate                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetMarketAmountUM                               FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetMarketAmountUSD                              FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetMarketAmountCLP                              FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetFairValueAdjustedUM                          FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetFairValueAdjustedUSD                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetFairValueAdjustedCLP                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetRateAdjusted                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetMacaulayDuration                             FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetModifiedDuration                             FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetConvexity                                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetResetDays                                    INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetHolidayFlowChile                             INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetHolidayFlowEEUU                              INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AssetHolidayFlowEnglan                            INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesAmount                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesAditionalFlow                          FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesCurrency                               INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesRateID                                 INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesRate                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesSpread                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesMarketRate                             FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesMarketAmountUM                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesMarketAmountUSD                        FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesMarketAmountCLP                        FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesFairValueAdjustedUM                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesFairValueAdjustedUSD                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesFairValueAdjustedCLP                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesRateAdjusted                           FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesMacaulayDuration                       FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesModifiedDuration                       FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesConvexity                              FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesResetDays                              INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesHolidayFlowChile                       INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesHolidayFlowEEUU                        INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , LiabilitiesHolidayFlowEnglan                      INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountUM                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountCLP                                  FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountCumulative                           FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountCumulativeYesterday                  FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , CashFlowUnwind                                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       )\n\n";

                _QuerySwap += "SET @PortFolioDateToday     = [@portFolioDate]\n\n";

                _QuerySwap += "SELECT @ProcessDate = fechaproc\n";
                _QuerySwap += "  FROM dbo.SwapGeneral\n\n";

                _QuerySwap += "IF @ProcessDate = @PortFolioDateToday\n";
                _QuerySwap += "BEGIN\n";
                _QuerySwap += "    INSERT INTO #TmpCartera\n";
                _QuerySwap += "           (\n";
                _QuerySwap += "                  OperationNumber\n";
                _QuerySwap += "           ,      StatusOperation\n";
                _QuerySwap += "           ,      SwapType\n";
                _QuerySwap += "           ,      BookID\n";
                _QuerySwap += "           ,      PortfolioRulesID\n";
                _QuerySwap += "           ,      FinancialPortFolioID\n";
                _QuerySwap += "           ,      OperationType\n";
                _QuerySwap += "           ,      CustomerID\n";
                _QuerySwap += "           ,      CustomerCode\n";
                _QuerySwap += "           ,      ContractDate\n";
                _QuerySwap += "           ,      StartingDate\n";
                _QuerySwap += "           ,      ExpiryDate\n";
                _QuerySwap += "           ,      ValuatorDate\n";
                _QuerySwap += "           ,      FairValueUM\n";
                _QuerySwap += "           ,      FairValueUSD\n";
                _QuerySwap += "           ,      FairValueCLP\n";
                _QuerySwap += "           ,      FairValueAdjustedUM\n";
                _QuerySwap += "           ,      FairValueAdjustedUSD\n";
                _QuerySwap += "           ,      FairValueAdjustedCLP\n";
                _QuerySwap += "           ,      AssetAmount\n";
                _QuerySwap += "           ,      AssetAditionalFlow\n";
                _QuerySwap += "           ,      AssetCurrency\n";
                _QuerySwap += "           ,      AssetRateID\n";
                _QuerySwap += "           ,      AssetRate\n";
                _QuerySwap += "           ,      AssetSpread\n";
                _QuerySwap += "           ,      AssetMarketRate\n";
                _QuerySwap += "           ,      AssetMarketAmountUM\n";
                _QuerySwap += "           ,      AssetMarketAmountUSD\n";
                _QuerySwap += "           ,      AssetMarketAmountCLP\n";
                _QuerySwap += "           ,      AssetFairValueAdjustedUM\n";
                _QuerySwap += "           ,      AssetFairValueAdjustedUSD\n";
                _QuerySwap += "           ,      AssetFairValueAdjustedCLP\n";
                _QuerySwap += "           ,      AssetRateAdjusted\n";
                _QuerySwap += "           ,      AssetMacaulayDuration\n";
                _QuerySwap += "           ,      AssetModifiedDuration\n";
                _QuerySwap += "           ,      AssetConvexity\n";
                _QuerySwap += "           ,      AssetResetDays\n";
                _QuerySwap += "           ,      AssetHolidayFlowChile\n";
                _QuerySwap += "           ,      AssetHolidayFlowEEUU\n";
                _QuerySwap += "           ,      AssetHolidayFlowEnglan\n";
                _QuerySwap += "           ,      LiabilitiesAmount\n";
                _QuerySwap += "           ,      LiabilitiesAditionalFlow\n";
                _QuerySwap += "           ,      LiabilitiesCurrency\n";
                _QuerySwap += "           ,      LiabilitiesRateID\n";
                _QuerySwap += "           ,      LiabilitiesRate\n";
                _QuerySwap += "           ,      LiabilitiesSpread\n";
                _QuerySwap += "           ,      LiabilitiesMarketRate\n";
                _QuerySwap += "           ,      LiabilitiesMarketAmountUM\n";
                _QuerySwap += "           ,      LiabilitiesMarketAmountUSD\n";
                _QuerySwap += "           ,      LiabilitiesMarketAmountCLP\n";
                _QuerySwap += "           ,      LiabilitiesFairValueAdjustedUM\n";
                _QuerySwap += "           ,      LiabilitiesFairValueAdjustedUSD\n";
                _QuerySwap += "           ,      LiabilitiesFairValueAdjustedCLP\n";
                _QuerySwap += "           ,      LiabilitiesRateAdjusted\n";
                _QuerySwap += "           ,      LiabilitiesMacaulayDuration\n";
                _QuerySwap += "           ,      LiabilitiesModifiedDuration\n";
                _QuerySwap += "           ,      LiabilitiesConvexity\n";
                _QuerySwap += "           ,      LiabilitiesResetDays\n";
                _QuerySwap += "           ,      LiabilitiesHolidayFlowChile\n";
                _QuerySwap += "           ,      LiabilitiesHolidayFlowEEUU\n";
                _QuerySwap += "           ,      LiabilitiesHolidayFlowEnglan\n";
                _QuerySwap += "           ,      AccrualAmountUM\n";
                _QuerySwap += "           ,      AccrualAmountCLP\n";
                _QuerySwap += "           ,      AccrualAmountCumulative\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeYesterday\n";
                _QuerySwap += "           ,      CashFlowUnwind\n";
                _QuerySwap += "           )\n";
                _QuerySwap += "           SELECT A.numero_operacion                       -- OperationNumber\n";
                _QuerySwap += "                , A.estado                                 -- StatusOperation\n";
                _QuerySwap += "                , A.tipo_swap                              -- SwapType\n";
                _QuerySwap += "                , A.car_libro                              -- BookID\n";
                _QuerySwap += "                , A.car_cartera_normativa                  -- PortfolioRulesID\n";
                _QuerySwap += "                , A.cartera_inversion                      -- FinancialPortFolioID\n";
                _QuerySwap += "                , A.tipo_operacion                         -- OperationType\n";
                _QuerySwap += "                , A.rut_cliente                            -- CustomerID\n";
                _QuerySwap += "                , A.codigo_cliente                         -- CustomerID\n";
                _QuerySwap += "                , A.fecha_cierre                           -- ContractDate\n";
                _QuerySwap += "                , A.fecha_inicio                           -- StartingDate\n";
                _QuerySwap += "                , A.fecha_termino                          -- ExpiryDate\n";
                _QuerySwap += "                , A.fecha_valoriza                         -- ValuatorDate\n";
                _QuerySwap += "                , A.Valor_RazonableMO                      -- FairValueUM\n";
                _QuerySwap += "                , A.Valor_RazonableUSD                     -- FairValueUSD\n";
                _QuerySwap += "                , A.Valor_RazonableCLP                     -- FairValueCLP\n";
                _QuerySwap += "                , A.vRazAjustado_Mo                        -- FairValueAdjustedUM\n";
                _QuerySwap += "                , A.vRazAjustado_Do                        -- FairValueAdjustedUSD\n";
                _QuerySwap += "                , A.vRazAjustado_Mn                        -- FairValueAdjustedCLP\n";
                _QuerySwap += "                , A.compra_capital                         -- AssetAmount\n";
                _QuerySwap += "                , A.compra_flujo_adicional                 -- AssetAditionalFlow\n";
                _QuerySwap += "                , A.compra_moneda                          -- AssetCurrency\n";
                _QuerySwap += "                , A.compra_codigo_tasa                     -- AssetRateID\n";
                _QuerySwap += "                , A.compra_valor_tasa                      -- AssetRate\n";
                _QuerySwap += "                , A.compra_spread                          -- AssetSpread\n";
                _QuerySwap += "                , A.compra_mercado_tasa                    -- AssetMarketRate\n";
                _QuerySwap += "                , A.compra_mercado                         -- AssetMarketAmountUM\n";
                _QuerySwap += "                , A.compra_mercado_usd                     -- AssetMarketAmountUSD\n";
                _QuerySwap += "                , A.compra_mercado_clp                     -- AssetMarketAmountCLP\n";
                _QuerySwap += "                , A.vRazActivoAjus_Mo                      -- AssetFairValueAdjustedUM\n";
                _QuerySwap += "                , A.vRazActivoAjus_Do                      -- AssetFairValueAdjustedUSD\n";
                _QuerySwap += "                , A.vRazActivoAjus_Mn                      -- AssetFairValueAdjustedCLP\n";
                _QuerySwap += "                , A.vTasaActivaAjusta                      -- AssetRateAdjusted\n";
                _QuerySwap += "                , A.vDurMacaulActivo                       -- AssetMacaulayDuration\n";
                _QuerySwap += "                , A.vDurModifiActivo                       -- AssetModifiedDuration\n";
                _QuerySwap += "                , A.vDurConvexActivo                       -- AssetConvexity\n";
                _QuerySwap += "                , A.DiasReset                              -- AssetResetDays\n";
                _QuerySwap += "                , A.FeriadoFlujoChile                      -- AssetHolidayFlowChile\n";
                _QuerySwap += "                , A.FeriadoFlujoEEUU                       -- AssetHolidayFlowEEUU\n";
                _QuerySwap += "                , A.FeriadoFlujoEnglan                     -- AssetHolidayFlowEnglan\n";
                _QuerySwap += "                , B.venta_capital                          -- LiabilitiesAmount\n";
                _QuerySwap += "                , B.venta_flujo_adicional                  -- LiabilitiesAditionalFlow\n";
                _QuerySwap += "                , B.venta_moneda                           -- LiabilitiesCurrency\n";
                _QuerySwap += "                , B.venta_codigo_tasa                      -- LiabilitiesRateID\n";
                _QuerySwap += "                , B.venta_valor_tasa                       -- LiabilitiesRate\n";
                _QuerySwap += "                , B.venta_spread                           -- LiabilitiesSpread\n";
                _QuerySwap += "                , B.venta_mercado_tasa                     -- LiabilitiesMarketRate\n";
                _QuerySwap += "                , B.venta_mercado                          -- LiabilitiesMarketAmountUM\n";
                _QuerySwap += "                , B.venta_mercado_usd                      -- LiabilitiesMarketAmountUSD\n";
                _QuerySwap += "                , B.venta_mercado_clp                      -- LiabilitiesMarketAmountCLP\n";
                _QuerySwap += "                , B.vRazPasivoAjus_Mo                      -- LiabilitiesFairValueAdjustedUM\n";
                _QuerySwap += "                , B.vRazPasivoAjus_Do                      -- LiabilitiesFairValueAdjustedUSD\n";
                _QuerySwap += "                , B.vRazPasivoAjus_Mn                      -- LiabilitiesFairValueAdjustedCLP\n";
                _QuerySwap += "                , B.vTasaPasivaAjusta                      -- LiabilitiesRateAdjusted\n";
                _QuerySwap += "                , B.vDurMacaulPasivo                       -- LiabilitiesMacaulayDuration\n";
                _QuerySwap += "                , B.vDurModifiPasivo                       -- LiabilitiesModifiedDuration\n";
                _QuerySwap += "                , B.vDurConvexPasivo                       -- LiabilitiesConvexity\n";
                _QuerySwap += "                , B.DiasReset                              -- LiabilitiesResetDays\n";
                _QuerySwap += "                , B.FeriadoFlujoChile                      -- LiabilitiesHolidayFlowChile\n";
                _QuerySwap += "                , B.FeriadoFlujoEEUU                       -- LiabilitiesHolidayFlowEEUU\n";
                _QuerySwap += "                , B.FeriadoFlujoEnglan                     -- LiabilitiesHolidayFlowEnglan\n";
                _QuerySwap += "                , A.devengo_monto                          -- AccrualAmountUM\n";
                _QuerySwap += "                , A.devengo_monto_peso                     -- AccrualAmountCLP\n";
                _QuerySwap += "                , A.devengo_monto_acum                     -- AccrualAmountCumulative\n";
                _QuerySwap += "                , A.devengo_monto_ayer                     -- AccrualAmountCumulativeYesterday\n";
                _QuerySwap += "                , A.recibimos_Monto                        -- CashFlowUnwind\n";
                _QuerySwap += "             FROM Cartera    A \n";
                _QuerySwap += "                  INNER JOIN Cartera    B           ON A.Numero_Operacion   = B.Numero_Operacion\n";
                _QuerySwap += "                                                   AND B.Tipo_Flujo         = 2\n";
                _QuerySwap += "                                                   AND B.estado_flujo      <> 0\n"; 
                _QuerySwap += "                                                   AND B.estado            <> 'C'\n";
                _QuerySwap += "                                                   AND\n";
                _QuerySwap += "                                                     ((B.estado_flujo       = 2\n";
                _QuerySwap += "                                                   AND B.fecha_termino      = @PortFolioDateToday)\n";
                _QuerySwap += "                                                    OR(B.estado_flujo       = 1)\n";
                _QuerySwap += "                                                    OR(B.estado             = 'N'))\n";
                _QuerySwap += "            WHERE A.estado                          <> 'C'\n";
                _QuerySwap += "              AND A.Tipo_Flujo                       = 1\n";
                _QuerySwap += "              AND\n";
                _QuerySwap += "                ((A.estado_flujo                      = 2\n";
                _QuerySwap += "              AND A.fecha_termino                     = @PortFolioDateToday)\n";
                _QuerySwap += "               OR(A.estado_flujo                      = 1)\n";
                _QuerySwap += "               OR(A.estado                            = 'N'))\n";
                _QuerySwap += "            ORDER BY A.Numero_Operacion\n\n";

                _QuerySwap += "END ELSE\n";
                _QuerySwap += "BEGIN\n";
                _QuerySwap += "    INSERT INTO #TmpCartera\n";
                _QuerySwap += "           (\n";
                _QuerySwap += "                  OperationNumber\n";
                _QuerySwap += "           ,      StatusOperation\n";
                _QuerySwap += "           ,      SwapType\n";
                _QuerySwap += "           ,      BookID\n";
                _QuerySwap += "           ,      PortfolioRulesID\n";
                _QuerySwap += "           ,      FinancialPortFolioID\n";
                _QuerySwap += "           ,      OperationType\n";
                _QuerySwap += "           ,      CustomerID\n";
                _QuerySwap += "           ,      CustomerCode\n";
                _QuerySwap += "           ,      ContractDate\n";
                _QuerySwap += "           ,      StartingDate\n";
                _QuerySwap += "           ,      ExpiryDate\n";
                _QuerySwap += "           ,      ValuatorDate\n";
                _QuerySwap += "           ,      FairValueUM\n";
                _QuerySwap += "           ,      FairValueUSD\n";
                _QuerySwap += "           ,      FairValueCLP\n";
                _QuerySwap += "           ,      FairValueAdjustedUM\n";
                _QuerySwap += "           ,      FairValueAdjustedUSD\n";
                _QuerySwap += "           ,      FairValueAdjustedCLP\n";
                _QuerySwap += "           ,      AssetAmount\n";
                _QuerySwap += "           ,      AssetAditionalFlow\n";
                _QuerySwap += "           ,      AssetCurrency\n";
                _QuerySwap += "           ,      AssetRateID\n";
                _QuerySwap += "           ,      AssetRate\n";
                _QuerySwap += "           ,      AssetSpread\n";
                _QuerySwap += "           ,      AssetMarketRate\n";
                _QuerySwap += "           ,      AssetMarketAmountUM\n";
                _QuerySwap += "           ,      AssetMarketAmountUSD\n";
                _QuerySwap += "           ,      AssetMarketAmountCLP\n";
                _QuerySwap += "           ,      AssetFairValueAdjustedUM\n";
                _QuerySwap += "           ,      AssetFairValueAdjustedUSD\n";
                _QuerySwap += "           ,      AssetFairValueAdjustedCLP\n";
                _QuerySwap += "           ,      AssetRateAdjusted\n";
                _QuerySwap += "           ,      AssetMacaulayDuration\n";
                _QuerySwap += "           ,      AssetModifiedDuration\n";
                _QuerySwap += "           ,      AssetConvexity\n";
                _QuerySwap += "           ,      AssetResetDays\n";
                _QuerySwap += "           ,      AssetHolidayFlowChile\n";
                _QuerySwap += "           ,      AssetHolidayFlowEEUU\n";
                _QuerySwap += "           ,      AssetHolidayFlowEnglan\n";
                _QuerySwap += "           ,      LiabilitiesAmount\n";
                _QuerySwap += "           ,      LiabilitiesAditionalFlow\n";
                _QuerySwap += "           ,      LiabilitiesCurrency\n";
                _QuerySwap += "           ,      LiabilitiesRateID\n";
                _QuerySwap += "           ,      LiabilitiesRate\n";
                _QuerySwap += "           ,      LiabilitiesSpread\n";
                _QuerySwap += "           ,      LiabilitiesMarketRate\n";
                _QuerySwap += "           ,      LiabilitiesMarketAmountUM\n";
                _QuerySwap += "           ,      LiabilitiesMarketAmountUSD\n";
                _QuerySwap += "           ,      LiabilitiesMarketAmountCLP\n";
                _QuerySwap += "           ,      LiabilitiesFairValueAdjustedUM\n";
                _QuerySwap += "           ,      LiabilitiesFairValueAdjustedUSD\n";
                _QuerySwap += "           ,      LiabilitiesFairValueAdjustedCLP\n";
                _QuerySwap += "           ,      LiabilitiesRateAdjusted\n";
                _QuerySwap += "           ,      LiabilitiesMacaulayDuration\n";
                _QuerySwap += "           ,      LiabilitiesModifiedDuration\n";
                _QuerySwap += "           ,      LiabilitiesConvexity\n";
                _QuerySwap += "           ,      LiabilitiesResetDays\n";
                _QuerySwap += "           ,      LiabilitiesHolidayFlowChile\n";
                _QuerySwap += "           ,      LiabilitiesHolidayFlowEEUU\n";
                _QuerySwap += "           ,      LiabilitiesHolidayFlowEnglan\n";
                _QuerySwap += "           ,      AccrualAmountUM\n";
                _QuerySwap += "           ,      AccrualAmountCLP\n";
                _QuerySwap += "           ,      AccrualAmountCumulative\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeYesterday\n";
                _QuerySwap += "           ,      CashFlowUnwind\n";
                _QuerySwap += "           )\n";
                _QuerySwap += "           SELECT A.numero_operacion                       -- OperationNumber\n";
                _QuerySwap += "                , A.estado                                 -- StatusOperation\n";
                _QuerySwap += "                , A.tipo_swap                              -- SwapType\n";
                _QuerySwap += "                , A.cre_libro                              -- BookID\n";
                _QuerySwap += "                , A.cre_cartera_normativa                  -- PortfolioRulesID\n";
                _QuerySwap += "                , A.cartera_inversion                      -- FinancialPortFolioID\n";
                _QuerySwap += "                , A.tipo_operacion                         -- OperationType\n";
                _QuerySwap += "                , A.rut_cliente                            -- CustomerID\n";
                _QuerySwap += "                , A.codigo_cliente                         -- CustomerID\n";
                _QuerySwap += "                , A.fecha_cierre                           -- ContractDate\n";
                _QuerySwap += "                , A.fecha_inicio                           -- StartingDate\n";
                _QuerySwap += "                , A.fecha_termino                          -- ExpiryDate\n";
                _QuerySwap += "                , A.fecha_valoriza                         -- ValuatorDate\n";
                _QuerySwap += "                , A.Valor_RazonableMO                      -- FairValueUM\n";
                _QuerySwap += "                , A.Valor_RazonableUSD                     -- FairValueUSD\n";
                _QuerySwap += "                , A.Valor_RazonableCLP                     -- FairValueCLP\n";
                _QuerySwap += "                , A.vRazAjustado_Mo                        -- FairValueAdjustedUM\n";
                _QuerySwap += "                , A.vRazAjustado_Do                        -- FairValueAdjustedUSD\n";
                _QuerySwap += "                , A.vRazAjustado_Mn                        -- FairValueAdjustedCLP\n";
                _QuerySwap += "                , A.compra_capital                         -- AssetAmount\n";
                _QuerySwap += "                , A.compra_flujo_adicional                 -- AssetAditionalFlow\n";
                _QuerySwap += "                , A.compra_moneda                          -- AssetCurrency\n";
                _QuerySwap += "                , A.compra_codigo_tasa                     -- AssetRateID\n";
                _QuerySwap += "                , A.compra_valor_tasa                      -- AssetRate\n";
                _QuerySwap += "                , A.compra_spread                          -- AssetSpread\n";
                _QuerySwap += "                , A.compra_mercado_tasa                    -- AssetMarketRate\n";
                _QuerySwap += "                , A.compra_mercado                         -- AssetMarketAmountUM\n";
                _QuerySwap += "                , A.compra_mercado_usd                     -- AssetMarketAmountUSD\n";
                _QuerySwap += "                , A.compra_mercado_clp                     -- AssetMarketAmountCLP\n";
                _QuerySwap += "                , A.vRazActivoAjus_Mo                      -- AssetFairValueAdjustedUM\n";
                _QuerySwap += "                , A.vRazActivoAjus_Do                      -- AssetFairValueAdjustedUSD\n";
                _QuerySwap += "                , A.vRazActivoAjus_Mn                      -- AssetFairValueAdjustedCLP\n";
                _QuerySwap += "                , A.vTasaActivaAjusta                      -- AssetRateAdjusted\n";
                _QuerySwap += "                , A.vDurMacaulActivo                       -- AssetMacaulayDuration\n";
                _QuerySwap += "                , A.vDurModifiActivo                       -- AssetModifiedDuration\n";
                _QuerySwap += "                , A.vDurConvexActivo                       -- AssetConvexity\n";
                _QuerySwap += "                , A.DiasReset                              -- AssetResetDays\n";
                _QuerySwap += "                , A.FeriadoFlujoChile                      -- AssetHolidayFlowChile\n";
                _QuerySwap += "                , A.FeriadoFlujoEEUU                       -- AssetHolidayFlowEEUU\n";
                _QuerySwap += "                , A.FeriadoFlujoEnglan                     -- AssetHolidayFlowEnglan\n";
                _QuerySwap += "                , B.venta_capital                          -- LiabilitiesAmount\n";
                _QuerySwap += "                , B.venta_flujo_adicional                  -- LiabilitiesAditionalFlow\n";
                _QuerySwap += "                , B.venta_moneda                           -- LiabilitiesCurrency\n";
                _QuerySwap += "                , B.venta_codigo_tasa                      -- LiabilitiesRateID\n";
                _QuerySwap += "                , B.venta_valor_tasa                       -- LiabilitiesRate\n";
                _QuerySwap += "                , B.venta_spread                           -- LiabilitiesSpread\n";
                _QuerySwap += "                , B.venta_mercado_tasa                     -- LiabilitiesMarketRate\n";
                _QuerySwap += "                , B.venta_mercado                          -- LiabilitiesMarketAmountUM\n";
                _QuerySwap += "                , B.venta_mercado_usd                      -- LiabilitiesMarketAmountUSD\n";
                _QuerySwap += "                , B.venta_mercado_clp                      -- LiabilitiesMarketAmountCLP\n";
                _QuerySwap += "                , B.vRazPasivoAjus_Mo                      -- LiabilitiesFairValueAdjustedUM\n";
                _QuerySwap += "                , B.vRazPasivoAjus_Do                      -- LiabilitiesFairValueAdjustedUSD\n";
                _QuerySwap += "                , B.vRazPasivoAjus_Mn                      -- LiabilitiesFairValueAdjustedCLP\n";
                _QuerySwap += "                , B.vTasaPasivaAjusta                      -- LiabilitiesRateAdjusted\n";
                _QuerySwap += "                , B.vDurMacaulPasivo                       -- LiabilitiesMacaulayDuration\n";
                _QuerySwap += "                , B.vDurModifiPasivo                       -- LiabilitiesModifiedDuration\n";
                _QuerySwap += "                , B.vDurConvexPasivo                       -- LiabilitiesConvexity\n";
                _QuerySwap += "                , B.DiasReset                              -- LiabilitiesResetDays\n";
                _QuerySwap += "                , B.FeriadoFlujoChile                      -- LiabilitiesHolidayFlowChile\n";
                _QuerySwap += "                , B.FeriadoFlujoEEUU                       -- LiabilitiesHolidayFlowEEUU\n";
                _QuerySwap += "                , B.FeriadoFlujoEnglan                     -- LiabilitiesHolidayFlowEnglan\n";
                _QuerySwap += "                , A.devengo_monto                          -- AccrualAmountUM\n";
                _QuerySwap += "                , A.devengo_monto_peso                     -- AccrualAmountCLP\n";
                _QuerySwap += "                , A.devengo_monto_acum                     -- AccrualAmountCumulative\n";
                _QuerySwap += "                , A.devengo_monto_ayer                     -- AccrualAmountCumulativeYesterday\n";
                _QuerySwap += "                , A.recibimos_Monto                        -- CashFlowUnwind\n";
                _QuerySwap += "             FROM CarteraRes A \n";
                _QuerySwap += "                  INNER JOIN CarteraRes B           ON A.Numero_Operacion   = B.Numero_Operacion\n";
                _QuerySwap += "                                                   AND B.Tipo_Flujo         = 2\n";
                _QuerySwap += "                                                   AND\n";
                _QuerySwap += "                                                     ((B.estado_flujo       = 2\n";
                _QuerySwap += "                                                   AND B.fecha_termino      = @PortFolioDateToday)\n";
                _QuerySwap += "                                                    OR(B.estado_flujo       = 1)\n";
                _QuerySwap += "                                                    OR(B.estado             = 'N'))\n";
                _QuerySwap += "                                                   AND B.Fecha_Proceso      = @PortFolioDateToday\n";
                _QuerySwap += "                                                   AND B.estado            <> 'C'\n";
                _QuerySwap += "            WHERE A.Fecha_Proceso                    = @PortFolioDateToday\n";
                _QuerySwap += "              AND A.estado                          <> 'C'\n";
                _QuerySwap += "              AND A.Tipo_Flujo                       = 1\n";
                _QuerySwap += "              AND\n";
                _QuerySwap += "                ((A.estado_flujo                      = 2\n";
                _QuerySwap += "              AND A.fecha_termino                     = @PortFolioDateToday)\n";
                _QuerySwap += "               OR(A.estado_flujo                      = 1)\n";
                _QuerySwap += "               OR(A.estado                            = 'N'))\n";
                _QuerySwap += "            ORDER BY A.Numero_Operacion\n\n";

                _QuerySwap += "END\n\n";

                _QuerySwap += "SELECT *\n";
                _QuerySwap += "  FROM #TmpCartera\n";
                _QuerySwap += " ORDER BY OperationNumber\n\n";

                _QuerySwap += "DROP TABLE #TmpCartera\n\n";

                _QuerySwap += "SET NOCOUNT OFF\n";

                _QuerySwap = _QuerySwap.Replace("[@portFolioDate]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACSWAPSUDA");
                DataTable _SwapPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySwap);
                    _SwapPortFolio = _Connect.QueryDataTable();
                    _SwapPortFolio.TableName = "SwapPortFolio";

                    if (_SwapPortFolio.Rows.Count.Equals(0))
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
                    _SwapPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SwapPortFolio;
            }

            public override DataTable LoadFlow(DateTime portFolioDate)
            {

                string _QuerySwap;

                #region "Query Load PortFolio Swap Flow"

                _QuerySwap = "";
                _QuerySwap += "SET NOCOUNT ON\n\n";

                _QuerySwap += "DECLARE @ProcessDate                DATETIME\n";
                _QuerySwap += "DECLARE @PortFolioDateToday         DATETIME\n";
                _QuerySwap += "DECLARE @PortFolioDateYesterday     DATETIME\n\n";

                _QuerySwap += "CREATE TABLE #TmpCartera\n";
                _QuerySwap += "       (\n";
                _QuerySwap += "         OperationNumber                                   INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , SwapType                                          INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FlowType                                          INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FlowID                                            INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , StartingDate                                      DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , ExpiryDate                                        DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , FixingDate                                        DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , PaymentDate                                       DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , ResetDate                                         DATETIME     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , Currency                                          INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , Capital                                           FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , Amortization                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , Balance                                           FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , Interest                                          FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AditionalFlow                                     FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , Spread                                            FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , RateID                                            INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , RateValue                                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , RateValueToday                                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , RateValueYesterday                                FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AmortizationID                                    INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AmortizationMonth                                 INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , InterestID                                        INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , InterestMonth                                     INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , BaseID                                            INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FlowStatus                                        INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , PaymentType                                       CHAR(01)     NOT NULL DEFAULT ''\n";
                _QuerySwap += "       , PaymentCurrency                                   INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , PaymentDocument                                   INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , PaymentAmountUM                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , PaymentAmountUSD                                  FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , PaymentAmountCLP                                  FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualTerm                                       INT          NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmount                                     FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountCumulativeUM                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountCumulativeCLP                        FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountYesterdayUM                          FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AccrualAmountYesterdayCLP                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , ZCR                                               FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarketRate                                        FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarketAmountUM                                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarketAmountUSD                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarketAmountCLP                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , DurationRate                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , DurationAmountUM                                  FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , DurationAmountUSD                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , DurationAmountCLP                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , PresentValue                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarkToMarkedUM                                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarkToMarkedUSD                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , MarkToMarkedCLP                                   FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , Variation                                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , ValuatorAmount                                    FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , ValuatorToday                                     FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , CapitalCurrentCLP                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , CapitalYesterdayCLP                               FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , RateYield                                         FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AmountC08UM                                       FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AmountC08USD                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , AmountC08CLP                                      FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , RateYieldFairValue                                FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FlowUM                                            FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FlowUSD                                           FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , FlowCLP                                           FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       , ExchangePrincipal                                 FLOAT        NOT NULL DEFAULT 0\n";
                _QuerySwap += "       )\n\n";

                _QuerySwap += "SET @PortFolioDateToday     = [@portFolioDate]\n\n";

                _QuerySwap += "SELECT @ProcessDate = fechaproc\n";
                _QuerySwap += "  FROM dbo.SwapGeneral\n\n";

                _QuerySwap += "IF @ProcessDate = @PortFolioDateToday\n";
                _QuerySwap += "BEGIN\n";
                _QuerySwap += "    INSERT INTO #TmpCartera\n";
                _QuerySwap += "           (\n";
                _QuerySwap += "                  OperationNumber\n";
                _QuerySwap += "           ,      SwapType\n";
                _QuerySwap += "           ,      FlowType\n";
                _QuerySwap += "           ,      FlowID\n";
                _QuerySwap += "           ,      StartingDate\n";
                _QuerySwap += "           ,      ExpiryDate\n";
                _QuerySwap += "           ,      FixingDate\n";
                _QuerySwap += "           ,      PaymentDate\n";
                _QuerySwap += "           ,      ResetDate\n";
                _QuerySwap += "           ,      Currency\n";
                _QuerySwap += "           ,      Capital\n";
                _QuerySwap += "           ,      Amortization\n";
                _QuerySwap += "           ,      Balance\n";
                _QuerySwap += "           ,      Interest\n";
                _QuerySwap += "           ,      AditionalFlow\n";
                _QuerySwap += "           ,      Spread\n";
                _QuerySwap += "           ,      RateID\n";
                _QuerySwap += "           ,      RateValue\n";
                _QuerySwap += "           ,      RateValueToday\n";
                _QuerySwap += "           ,      AmortizationID\n";
                _QuerySwap += "           ,      AmortizationMonth\n";
                _QuerySwap += "           ,      InterestID\n";
                _QuerySwap += "           ,      InterestMonth\n";
                _QuerySwap += "           ,      BaseID\n";
                _QuerySwap += "           ,      FlowStatus\n";
                _QuerySwap += "           ,      PaymentType\n";
                _QuerySwap += "           ,      PaymentCurrency\n";
                _QuerySwap += "           ,      PaymentDocument\n";
                _QuerySwap += "           ,      PaymentAmountUM\n";
                _QuerySwap += "           ,      PaymentAmountUSD\n";
                _QuerySwap += "           ,      PaymentAmountCLP\n";
                _QuerySwap += "           ,      AccrualTerm\n";
                _QuerySwap += "           ,      AccrualAmount\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeUM\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeCLP\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayUM\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayCLP\n";
                _QuerySwap += "           ,      ZCR\n";
                _QuerySwap += "           ,      MarketRate\n";
                _QuerySwap += "           ,      MarketAmountUM\n";
                _QuerySwap += "           ,      MarketAmountUSD\n";
                _QuerySwap += "           ,      MarketAmountCLP\n";
                _QuerySwap += "           ,      DurationRate\n";
                _QuerySwap += "           ,      DurationAmountUM\n";
                _QuerySwap += "           ,      DurationAmountUSD\n";
                _QuerySwap += "           ,      DurationAmountCLP\n";
                _QuerySwap += "           ,      PresentValue\n";
                _QuerySwap += "           ,      MarkToMarkedUM\n";
                _QuerySwap += "           ,      MarkToMarkedUSD\n";
                _QuerySwap += "           ,      MarkToMarkedCLP\n";
                _QuerySwap += "           ,      Variation\n";
                _QuerySwap += "           ,      ValuatorAmount\n";
                _QuerySwap += "           ,      ValuatorToday\n";
                _QuerySwap += "           ,      CapitalCurrentCLP\n";
                _QuerySwap += "           ,      CapitalYesterdayCLP\n";
                _QuerySwap += "           ,      RateYield\n";
                _QuerySwap += "           ,      AmountC08UM\n";
                _QuerySwap += "           ,      AmountC08USD\n";
                _QuerySwap += "           ,      AmountC08CLP\n";
                _QuerySwap += "           ,      RateYieldFairValue\n";
                _QuerySwap += "           ,      FlowUM\n";
                _QuerySwap += "           ,      FlowUSD\n";
                _QuerySwap += "           ,      FlowCLP\n";
                _QuerySwap += "           ,      ExchangePrincipal\n";
                _QuerySwap += "           )\n";
                _QuerySwap += "           SELECT numero_operacion                         -- OperationNumber\n";
                _QuerySwap += "                , tipo_swap                                -- SwapType\n";
                _QuerySwap += "                , tipo_flujo                               -- FlowType\n";
                _QuerySwap += "                , numero_flujo                             -- FlowID\n";
                _QuerySwap += "                , fecha_inicio_flujo                       -- StartingDate\n";
                _QuerySwap += "                , fecha_vence_flujo                        -- ExpiryDate\n";
                _QuerySwap += "                , fecha_fijacion_tasa                      -- FixingDate\n";
                _QuerySwap += "                , FechaLiquidacion                         -- PaymentDate\n";
                _QuerySwap += "                , FechaReset                               -- ResetDate\n";
                _QuerySwap += "                , compra_moneda                            -- Currency\n";
                _QuerySwap += "                , compra_capital                           -- Capital\n";
                _QuerySwap += "                , compra_amortiza                          -- Amortization\n";
                _QuerySwap += "                , compra_saldo                             -- Balance\n";
                _QuerySwap += "                , compra_interes                           -- Interest\n";
                _QuerySwap += "                , compra_flujo_adicional                   -- AditionalFlow\n";
                _QuerySwap += "                , compra_spread                            -- Spread\n";
                _QuerySwap += "                , compra_codigo_tasa                       -- RateID\n";
                _QuerySwap += "                , compra_valor_tasa                        -- RateValue\n";
                _QuerySwap += "                , compra_valor_tasa_hoy                    -- RateValueToday\n";
                _QuerySwap += "                , compra_codamo_capital                    -- AmortizationID\n";
                _QuerySwap += "                , compra_mesamo_capital                    -- AmortizationMonth\n";
                _QuerySwap += "                , compra_codamo_interes                    -- InterestID\n";
                _QuerySwap += "                , compra_mesamo_interes                    -- InterestMonth\n";
                _QuerySwap += "                , compra_base                              -- BaseID\n";
                _QuerySwap += "                , estado_flujo                             -- FlowStatus\n";
                _QuerySwap += "                , modalidad_pago                           -- PaymentType\n";
                _QuerySwap += "                , recibimos_moneda                         -- PaymentCurrency\n";
                _QuerySwap += "                , recibimos_documento                      -- PaymentDocument\n";
                _QuerySwap += "                , recibimos_monto                          -- PaymentAmountUM\n";
                _QuerySwap += "                , recibimos_monto_USD                      -- PaymentAmountUSD\n";
                _QuerySwap += "                , recibimos_monto_CLP                      -- PaymentAmountCLP\n";
                _QuerySwap += "                , devengo_dias                             -- AccrualTerm\n";
                _QuerySwap += "                , devengo_compra                           -- AccrualAmount\n";
                _QuerySwap += "                , devengo_compra_acum                      -- AccrualAmountCumulativeUM\n";
                _QuerySwap += "                , devengo_compra_acum_peso                 -- AccrualAmountCumulativeCLP\n";
                _QuerySwap += "                , devengo_compra_ayer                      -- AccrualAmountYesterdayUM\n";
                _QuerySwap += "                , devengo_compra_ayer_peso                 -- AccrualAmountYesterdayCLP\n";
                _QuerySwap += "                , compra_zcr                               -- ZCR\n";
                _QuerySwap += "                , compra_mercado_tasa                      -- MarketRate\n";
                _QuerySwap += "                , compra_mercado                           -- MarketAmountUM\n";
                _QuerySwap += "                , compra_mercado_usd                       -- MarketAmountUSD\n";
                _QuerySwap += "                , compra_mercado_clp                       -- MarketAmountCLP\n";
                _QuerySwap += "                , compra_duration_tasa                     -- DurationRate\n";
                _QuerySwap += "                , compra_duration_monto                    -- DurationAmountUM\n";
                _QuerySwap += "                , compra_duration_monto_usd                -- DurationAmountUSD\n";
                _QuerySwap += "                , compra_duration_monto_clp                -- DurationAmountCLP\n";
                _QuerySwap += "                , compra_valor_presente                    -- PresentValue\n";
                _QuerySwap += "                , monto_mtm                                -- MarkToMarkedUM\n";
                _QuerySwap += "                , monto_mtm_usd                            -- MarkToMarkedUSD\n";
                _QuerySwap += "                , monto_mtm_clp                            -- MarkToMarkedCLP\n";
                _QuerySwap += "                , compra_valorizada                        -- Variation\n";
                _QuerySwap += "                , compra_variacion                         -- ValuatorAmount\n";
                _QuerySwap += "                , valorizacion_dia                         -- ValuatorToday\n";
                _QuerySwap += "                , Capital_Pesos_Actual                     -- CapitalCurrentCLP\n";
                _QuerySwap += "                , Capital_Pesos_Ayer                       -- CapitalYesterdayCLP\n";
                _QuerySwap += "                , Tasa_Compra_Curva                        -- RateYield\n";
                _QuerySwap += "                , Activo_MO_C08                            -- AmountC08UM\n";
                _QuerySwap += "                , Activo_USD_C08                           -- AmountC08USD\n";
                _QuerySwap += "                , Activo_CLP_C08                           -- AmountC08CLP\n";
                _QuerySwap += "                , Tasa_Compra_CurvaVR                      -- RateYieldFairValue\n";
                _QuerySwap += "                , Activo_FlujoMO                           -- FlowUM\n";
                _QuerySwap += "                , Activo_FlujoUSD                          -- FlowUSD\n";
                _QuerySwap += "                , Activo_FlujoCLP                          -- FlowCLP\n";
                _QuerySwap += "                , IntercPrinc                              -- ExchangePrincipal\n";
                _QuerySwap += "             FROM dbo.Cartera\n";
                _QuerySwap += "            WHERE estado               <> 'C'\n";
                _QuerySwap += "              AND tipo_flujo            = 1\n\n";

                _QuerySwap += "    INSERT INTO #TmpCartera\n";
                _QuerySwap += "           (\n";
                _QuerySwap += "                  OperationNumber\n";
                _QuerySwap += "           ,      SwapType\n";
                _QuerySwap += "           ,      FlowType\n";
                _QuerySwap += "           ,      FlowID\n";
                _QuerySwap += "           ,      StartingDate\n";
                _QuerySwap += "           ,      ExpiryDate\n";
                _QuerySwap += "           ,      FixingDate\n";
                _QuerySwap += "           ,      PaymentDate\n";
                _QuerySwap += "           ,      ResetDate\n";
                _QuerySwap += "           ,      Currency\n";
                _QuerySwap += "           ,      Capital\n";
                _QuerySwap += "           ,      Amortization\n";
                _QuerySwap += "           ,      Balance\n";
                _QuerySwap += "           ,      Interest\n";
                _QuerySwap += "           ,      AditionalFlow\n";
                _QuerySwap += "           ,      Spread\n";
                _QuerySwap += "           ,      RateID\n";
                _QuerySwap += "           ,      RateValue\n";
                _QuerySwap += "           ,      RateValueToday\n";
                _QuerySwap += "           ,      AmortizationID\n";
                _QuerySwap += "           ,      AmortizationMonth\n";
                _QuerySwap += "           ,      InterestID\n";
                _QuerySwap += "           ,      InterestMonth\n";
                _QuerySwap += "           ,      BaseID\n";
                _QuerySwap += "           ,      FlowStatus\n";
                _QuerySwap += "           ,      PaymentType\n";
                _QuerySwap += "           ,      PaymentCurrency\n";
                _QuerySwap += "           ,      PaymentDocument\n";
                _QuerySwap += "           ,      PaymentAmountUM\n";
                _QuerySwap += "           ,      PaymentAmountUSD\n";
                _QuerySwap += "           ,      PaymentAmountCLP\n";
                _QuerySwap += "           ,      AccrualTerm\n";
                _QuerySwap += "           ,      AccrualAmount\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeUM\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeCLP\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayUM\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayCLP\n";
                _QuerySwap += "           ,      ZCR\n";
                _QuerySwap += "           ,      MarketRate\n";
                _QuerySwap += "           ,      MarketAmountUM\n";
                _QuerySwap += "           ,      MarketAmountUSD\n";
                _QuerySwap += "           ,      MarketAmountCLP\n";
                _QuerySwap += "           ,      DurationRate\n";
                _QuerySwap += "           ,      DurationAmountUM\n";
                _QuerySwap += "           ,      DurationAmountUSD\n";
                _QuerySwap += "           ,      DurationAmountCLP\n";
                _QuerySwap += "           ,      PresentValue\n";
                _QuerySwap += "           ,      MarkToMarkedUM\n";
                _QuerySwap += "           ,      MarkToMarkedUSD\n";
                _QuerySwap += "           ,      MarkToMarkedCLP\n";
                _QuerySwap += "           ,      Variation\n";
                _QuerySwap += "           ,      ValuatorAmount\n";
                _QuerySwap += "           ,      ValuatorToday\n";
                _QuerySwap += "           ,      CapitalCurrentCLP\n";
                _QuerySwap += "           ,      CapitalYesterdayCLP\n";
                _QuerySwap += "           ,      RateYield\n";
                _QuerySwap += "           ,      AmountC08UM\n";
                _QuerySwap += "           ,      AmountC08USD\n";
                _QuerySwap += "           ,      AmountC08CLP\n";
                _QuerySwap += "           ,      RateYieldFairValue\n";
                _QuerySwap += "           ,      FlowUM\n";
                _QuerySwap += "           ,      FlowUSD\n";
                _QuerySwap += "           ,      FlowCLP\n";
                _QuerySwap += "           ,      ExchangePrincipal\n";
                _QuerySwap += "           )\n";
                _QuerySwap += "           SELECT numero_operacion                         -- OperationNumber\n";
                _QuerySwap += "                , tipo_swap                                -- SwapType\n";
                _QuerySwap += "                , tipo_flujo                               -- FlowType\n";
                _QuerySwap += "                , numero_flujo                             -- FlowID\n";
                _QuerySwap += "                , fecha_inicio_flujo                       -- StartingDate\n";
                _QuerySwap += "                , fecha_vence_flujo                        -- ExpiryDate\n";
                _QuerySwap += "                , fecha_fijacion_tasa                      -- FixingDate\n";
                _QuerySwap += "                , FechaLiquidacion                         -- PaymentDate\n";
                _QuerySwap += "                , FechaReset                               -- ResetDate\n";
                _QuerySwap += "                , venta_moneda                             -- Currency\n";
                _QuerySwap += "                , venta_capital                            -- Capital\n";
                _QuerySwap += "                , venta_amortiza                           -- Amortization\n";
                _QuerySwap += "                , venta_saldo                              -- Balance\n";
                _QuerySwap += "                , venta_interes                            -- Interest\n";
                _QuerySwap += "                , venta_flujo_adicional                    -- AditionalFlow\n";
                _QuerySwap += "                , venta_spread                             -- Spread\n";
                _QuerySwap += "                , venta_codigo_tasa                        -- RateID\n";
                _QuerySwap += "                , venta_valor_tasa                         -- RateValue\n";
                _QuerySwap += "                , venta_valor_tasa_hoy                     -- RateValueToday\n";
                _QuerySwap += "                , venta_codamo_capital                     -- AmortizationID\n";
                _QuerySwap += "                , venta_mesamo_capital                     -- AmortizationMonth\n";
                _QuerySwap += "                , venta_codamo_interes                     -- InterestID\n";
                _QuerySwap += "                , venta_mesamo_interes                     -- InterestMonth\n";
                _QuerySwap += "                , venta_base                               -- BaseID\n";
                _QuerySwap += "                , estado_flujo                             -- FlowStatus\n";
                _QuerySwap += "                , modalidad_pago                           -- PaymentType\n";
                _QuerySwap += "                , recibimos_moneda                         -- PaymentCurrency\n";
                _QuerySwap += "                , recibimos_documento                      -- PaymentDocument\n";
                _QuerySwap += "                , recibimos_monto                          -- PaymentAmountUM\n";
                _QuerySwap += "                , recibimos_monto_USD                      -- PaymentAmountUSD\n";
                _QuerySwap += "                , recibimos_monto_CLP                      -- PaymentAmountCLP\n";
                _QuerySwap += "                , devengo_dias                             -- AccrualTerm\n";
                _QuerySwap += "                , devengo_venta                            -- AccrualAmount\n";
                _QuerySwap += "                , devengo_venta_acum                       -- AccrualAmountCumulativeUM\n";
                _QuerySwap += "                , devengo_venta_acum_peso                  -- AccrualAmountCumulativeCLP\n";
                _QuerySwap += "                , devengo_venta_ayer                       -- AccrualAmountYesterdayUM\n";
                _QuerySwap += "                , devengo_venta_ayer_peso                  -- AccrualAmountYesterdayCLP\n";
                _QuerySwap += "                , venta_zcr                                -- ZCR\n";
                _QuerySwap += "                , venta_mercado_tasa                       -- MarketRate\n";
                _QuerySwap += "                , venta_mercado                            -- MarketAmountUM\n";
                _QuerySwap += "                , venta_mercado_usd                        -- MarketAmountUSD\n";
                _QuerySwap += "                , venta_mercado_clp                        -- MarketAmountCLP\n";
                _QuerySwap += "                , venta_duration_tasa                      -- DurationRate\n";
                _QuerySwap += "                , venta_duration_monto                     -- DurationAmountUM\n";
                _QuerySwap += "                , venta_duration_monto_usd                 -- DurationAmountUSD\n";
                _QuerySwap += "                , venta_duration_monto_clp                 -- DurationAmountCLP\n";
                _QuerySwap += "                , venta_valor_presente                     -- PresentValue\n";
                _QuerySwap += "                , monto_mtm                                -- MarkToMarkedUM\n";
                _QuerySwap += "                , monto_mtm_usd                            -- MarkToMarkedUSD\n";
                _QuerySwap += "                , monto_mtm_clp                            -- MarkToMarkedCLP\n";
                _QuerySwap += "                , venta_valorizada                         -- Variation\n";
                _QuerySwap += "                , venta_variacion                          -- ValuatorAmount\n";
                _QuerySwap += "                , valorizacion_dia                         -- ValuatorToday\n";
                _QuerySwap += "                , Capital_Pesos_Actual                     -- CapitalCurrentCLP\n";
                _QuerySwap += "                , Capital_Pesos_Ayer                       -- CapitalYesterdayCLP\n";
                _QuerySwap += "                , Tasa_venta_Curva                         -- RateYield\n";
                _QuerySwap += "                , pasivo_MO_C08                            -- AmountC08UM\n";
                _QuerySwap += "                , pasivo_USD_C08                           -- AmountC08USD\n";
                _QuerySwap += "                , pasivo_CLP_C08                           -- AmountC08CLP\n";
                _QuerySwap += "                , Tasa_venta_CurvaVR                       -- RateYieldFairValue\n";
                _QuerySwap += "                , pasivo_FlujoMO                           -- FlowUM\n";
                _QuerySwap += "                , pasivo_FlujoUSD                          -- FlowUSD\n";
                _QuerySwap += "                , pasivo_FlujoCLP                          -- FlowCLP\n";
                _QuerySwap += "                , IntercPrinc                              -- ExchangePrincipal\n";
                _QuerySwap += "             FROM dbo.Cartera\n";
                _QuerySwap += "            WHERE estado               <> 'C'\n";
                _QuerySwap += "              AND tipo_flujo            = 2\n\n";

                _QuerySwap += "END ELSE\n";
                _QuerySwap += "BEGIN\n";
                _QuerySwap += "    INSERT INTO #TmpCartera\n";
                _QuerySwap += "           (\n";
                _QuerySwap += "                  OperationNumber\n";
                _QuerySwap += "           ,      SwapType\n";
                _QuerySwap += "           ,      FlowType\n";
                _QuerySwap += "           ,      FlowID\n";
                _QuerySwap += "           ,      StartingDate\n";
                _QuerySwap += "           ,      ExpiryDate\n";
                _QuerySwap += "           ,      FixingDate\n";
                _QuerySwap += "           ,      PaymentDate\n";
                _QuerySwap += "           ,      ResetDate\n";
                _QuerySwap += "           ,      Currency\n";
                _QuerySwap += "           ,      Capital\n";
                _QuerySwap += "           ,      Amortization\n";
                _QuerySwap += "           ,      Balance\n";
                _QuerySwap += "           ,      Interest\n";
                _QuerySwap += "           ,      AditionalFlow\n";
                _QuerySwap += "           ,      Spread\n";
                _QuerySwap += "           ,      RateID\n";
                _QuerySwap += "           ,      RateValue\n";
                _QuerySwap += "           ,      RateValueToday\n";
                _QuerySwap += "           ,      AmortizationID\n";
                _QuerySwap += "           ,      AmortizationMonth\n";
                _QuerySwap += "           ,      InterestID\n";
                _QuerySwap += "           ,      InterestMonth\n";
                _QuerySwap += "           ,      BaseID\n";
                _QuerySwap += "           ,      FlowStatus\n";
                _QuerySwap += "           ,      PaymentType\n";
                _QuerySwap += "           ,      PaymentCurrency\n";
                _QuerySwap += "           ,      PaymentDocument\n";
                _QuerySwap += "           ,      PaymentAmountUM\n";
                _QuerySwap += "           ,      PaymentAmountUSD\n";
                _QuerySwap += "           ,      PaymentAmountCLP\n";
                _QuerySwap += "           ,      AccrualTerm\n";
                _QuerySwap += "           ,      AccrualAmount\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeUM\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeCLP\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayUM\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayCLP\n";
                _QuerySwap += "           ,      ZCR\n";
                _QuerySwap += "           ,      MarketRate\n";
                _QuerySwap += "           ,      MarketAmountUM\n";
                _QuerySwap += "           ,      MarketAmountUSD\n";
                _QuerySwap += "           ,      MarketAmountCLP\n";
                _QuerySwap += "           ,      DurationRate\n";
                _QuerySwap += "           ,      DurationAmountUM\n";
                _QuerySwap += "           ,      DurationAmountUSD\n";
                _QuerySwap += "           ,      DurationAmountCLP\n";
                _QuerySwap += "           ,      PresentValue\n";
                _QuerySwap += "           ,      MarkToMarkedUM\n";
                _QuerySwap += "           ,      MarkToMarkedUSD\n";
                _QuerySwap += "           ,      MarkToMarkedCLP\n";
                _QuerySwap += "           ,      Variation\n";
                _QuerySwap += "           ,      ValuatorAmount\n";
                _QuerySwap += "           ,      ValuatorToday\n";
                _QuerySwap += "           ,      CapitalCurrentCLP\n";
                _QuerySwap += "           ,      CapitalYesterdayCLP\n";
                _QuerySwap += "           ,      RateYield\n";
                _QuerySwap += "           ,      AmountC08UM\n";
                _QuerySwap += "           ,      AmountC08USD\n";
                _QuerySwap += "           ,      AmountC08CLP\n";
                _QuerySwap += "           ,      RateYieldFairValue\n";
                _QuerySwap += "           ,      FlowUM\n";
                _QuerySwap += "           ,      FlowUSD\n";
                _QuerySwap += "           ,      FlowCLP\n";
                _QuerySwap += "           ,      ExchangePrincipal\n";
                _QuerySwap += "           )\n";
                _QuerySwap += "           SELECT numero_operacion                         -- OperationNumber\n";
                _QuerySwap += "                , tipo_swap                                -- SwapType\n";
                _QuerySwap += "                , tipo_flujo                               -- FlowType\n";
                _QuerySwap += "                , numero_flujo                             -- FlowID\n";
                _QuerySwap += "                , fecha_inicio_flujo                       -- StartingDate\n";
                _QuerySwap += "                , fecha_vence_flujo                        -- ExpiryDate\n";
                _QuerySwap += "                , fecha_fijacion_tasa                      -- FixingDate\n";
                _QuerySwap += "                , FechaLiquidacion                         -- PaymentDate\n";
                _QuerySwap += "                , FechaReset                               -- ResetDate\n";
                _QuerySwap += "                , compra_moneda                            -- Currency\n";
                _QuerySwap += "                , compra_capital                           -- Capital\n";
                _QuerySwap += "                , compra_amortiza                          -- Amortization\n";
                _QuerySwap += "                , compra_saldo                             -- Balance\n";
                _QuerySwap += "                , compra_interes                           -- Interest\n";
                _QuerySwap += "                , compra_flujo_adicional                   -- AditionalFlow\n";
                _QuerySwap += "                , compra_spread                            -- Spread\n";
                _QuerySwap += "                , compra_codigo_tasa                       -- RateID\n";
                _QuerySwap += "                , compra_valor_tasa                        -- RateValue\n";
                _QuerySwap += "                , compra_valor_tasa_hoy                    -- RateValueToday\n";
                _QuerySwap += "                , compra_codamo_capital                    -- AmortizationID\n";
                _QuerySwap += "                , compra_mesamo_capital                    -- AmortizationMonth\n";
                _QuerySwap += "                , compra_codamo_interes                    -- InterestID\n";
                _QuerySwap += "                , compra_mesamo_interes                    -- InterestMonth\n";
                _QuerySwap += "                , compra_base                              -- BaseID\n";
                _QuerySwap += "                , estado_flujo                             -- FlowStatus\n";
                _QuerySwap += "                , modalidad_pago                           -- PaymentType\n";
                _QuerySwap += "                , recibimos_moneda                         -- PaymentCurrency\n";
                _QuerySwap += "                , recibimos_documento                      -- PaymentDocument\n";
                _QuerySwap += "                , recibimos_monto                          -- PaymentAmountUM\n";
                _QuerySwap += "                , recibimos_monto_USD                      -- PaymentAmountUSD\n";
                _QuerySwap += "                , recibimos_monto_CLP                      -- PaymentAmountCLP\n";
                _QuerySwap += "                , devengo_dias                             -- AccrualTerm\n";
                _QuerySwap += "                , devengo_compra                           -- AccrualAmount\n";
                _QuerySwap += "                , devengo_compra_acum                      -- AccrualAmountCumulativeUM\n";
                _QuerySwap += "                , devengo_compra_acum_peso                 -- AccrualAmountCumulativeCLP\n";
                _QuerySwap += "                , devengo_compra_ayer                      -- AccrualAmountYesterdayUM\n";
                _QuerySwap += "                , devengo_compra_ayer_peso                 -- AccrualAmountYesterdayCLP\n";
                _QuerySwap += "                , compra_zcr                               -- ZCR\n";
                _QuerySwap += "                , compra_mercado_tasa                      -- MarketRate\n";
                _QuerySwap += "                , compra_mercado                           -- MarketAmountUM\n";
                _QuerySwap += "                , compra_mercado_usd                       -- MarketAmountUSD\n";
                _QuerySwap += "                , compra_mercado_clp                       -- MarketAmountCLP\n";
                _QuerySwap += "                , compra_duration_tasa                     -- DurationRate\n";
                _QuerySwap += "                , compra_duration_monto                    -- DurationAmountUM\n";
                _QuerySwap += "                , compra_duration_monto_usd                -- DurationAmountUSD\n";
                _QuerySwap += "                , compra_duration_monto_clp                -- DurationAmountCLP\n";
                _QuerySwap += "                , compra_valor_presente                    -- PresentValue\n";
                _QuerySwap += "                , monto_mtm                                -- MarkToMarkedUM\n";
                _QuerySwap += "                , monto_mtm_usd                            -- MarkToMarkedUSD\n";
                _QuerySwap += "                , monto_mtm_clp                            -- MarkToMarkedCLP\n";
                _QuerySwap += "                , compra_valorizada                        -- Variation\n";
                _QuerySwap += "                , compra_variacion                         -- ValuatorAmount\n";
                _QuerySwap += "                , valorizacion_dia                         -- ValuatorToday\n";
                _QuerySwap += "                , Capital_Pesos_Actual                     -- CapitalCurrentCLP\n";
                _QuerySwap += "                , Capital_Pesos_Ayer                       -- CapitalYesterdayCLP\n";
                _QuerySwap += "                , Tasa_Compra_Curva                        -- RateYield\n";
                _QuerySwap += "                , Activo_MO_C08                            -- AmountC08UM\n";
                _QuerySwap += "                , Activo_USD_C08                           -- AmountC08USD\n";
                _QuerySwap += "                , Activo_CLP_C08                           -- AmountC08CLP\n";
                _QuerySwap += "                , Tasa_Compra_CurvaVR                      -- RateYieldFairValue\n";
                _QuerySwap += "                , Activo_FlujoMO                           -- FlowUM\n";
                _QuerySwap += "                , Activo_FlujoUSD                          -- FlowUSD\n";
                _QuerySwap += "                , Activo_FlujoCLP                          -- FlowCLP\n";
                _QuerySwap += "                , IntercPrinc                              -- ExchangePrincipal\n";
                _QuerySwap += "             FROM dbo.CarteraRes\n";
                _QuerySwap += "            WHERE Fecha_Proceso         = @PortFolioDateToday\n";
                _QuerySwap += "              AND tipo_flujo            = 1\n";
                _QuerySwap += "              AND estado               <> 'C'\n";
                _QuerySwap += "              AND fecha_vence_flujo     > @PortFolioDateToday\n\n";

                _QuerySwap += "    INSERT INTO #TmpCartera\n";
                _QuerySwap += "           (\n";
                _QuerySwap += "                  OperationNumber\n";
                _QuerySwap += "           ,      SwapType\n";
                _QuerySwap += "           ,      FlowType\n";
                _QuerySwap += "           ,      FlowID\n";
                _QuerySwap += "           ,      StartingDate\n";
                _QuerySwap += "           ,      ExpiryDate\n";
                _QuerySwap += "           ,      FixingDate\n";
                _QuerySwap += "           ,      PaymentDate\n";
                _QuerySwap += "           ,      ResetDate\n";
                _QuerySwap += "           ,      Currency\n";
                _QuerySwap += "           ,      Capital\n";
                _QuerySwap += "           ,      Amortization\n";
                _QuerySwap += "           ,      Balance\n";
                _QuerySwap += "           ,      Interest\n";
                _QuerySwap += "           ,      AditionalFlow\n";
                _QuerySwap += "           ,      Spread\n";
                _QuerySwap += "           ,      RateID\n";
                _QuerySwap += "           ,      RateValue\n";
                _QuerySwap += "           ,      RateValueToday\n";
                _QuerySwap += "           ,      AmortizationID\n";
                _QuerySwap += "           ,      AmortizationMonth\n";
                _QuerySwap += "           ,      InterestID\n";
                _QuerySwap += "           ,      InterestMonth\n";
                _QuerySwap += "           ,      BaseID\n";
                _QuerySwap += "           ,      FlowStatus\n";
                _QuerySwap += "           ,      PaymentType\n";
                _QuerySwap += "           ,      PaymentCurrency\n";
                _QuerySwap += "           ,      PaymentDocument\n";
                _QuerySwap += "           ,      PaymentAmountUM\n";
                _QuerySwap += "           ,      PaymentAmountUSD\n";
                _QuerySwap += "           ,      PaymentAmountCLP\n";
                _QuerySwap += "           ,      AccrualTerm\n";
                _QuerySwap += "           ,      AccrualAmount\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeUM\n";
                _QuerySwap += "           ,      AccrualAmountCumulativeCLP\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayUM\n";
                _QuerySwap += "           ,      AccrualAmountYesterdayCLP\n";
                _QuerySwap += "           ,      ZCR\n";
                _QuerySwap += "           ,      MarketRate\n";
                _QuerySwap += "           ,      MarketAmountUM\n";
                _QuerySwap += "           ,      MarketAmountUSD\n";
                _QuerySwap += "           ,      MarketAmountCLP\n";
                _QuerySwap += "           ,      DurationRate\n";
                _QuerySwap += "           ,      DurationAmountUM\n";
                _QuerySwap += "           ,      DurationAmountUSD\n";
                _QuerySwap += "           ,      DurationAmountCLP\n";
                _QuerySwap += "           ,      PresentValue\n";
                _QuerySwap += "           ,      MarkToMarkedUM\n";
                _QuerySwap += "           ,      MarkToMarkedUSD\n";
                _QuerySwap += "           ,      MarkToMarkedCLP\n";
                _QuerySwap += "           ,      Variation\n";
                _QuerySwap += "           ,      ValuatorAmount\n";
                _QuerySwap += "           ,      ValuatorToday\n";
                _QuerySwap += "           ,      CapitalCurrentCLP\n";
                _QuerySwap += "           ,      CapitalYesterdayCLP\n";
                _QuerySwap += "           ,      RateYield\n";
                _QuerySwap += "           ,      AmountC08UM\n";
                _QuerySwap += "           ,      AmountC08USD\n";
                _QuerySwap += "           ,      AmountC08CLP\n";
                _QuerySwap += "           ,      RateYieldFairValue\n";
                _QuerySwap += "           ,      FlowUM\n";
                _QuerySwap += "           ,      FlowUSD\n";
                _QuerySwap += "           ,      FlowCLP\n";
                _QuerySwap += "           ,      ExchangePrincipal\n";
                _QuerySwap += "           )\n";
                _QuerySwap += "           SELECT numero_operacion                         -- OperationNumber\n";
                _QuerySwap += "                , tipo_swap                                -- SwapType\n";
                _QuerySwap += "                , tipo_flujo                               -- FlowType\n";
                _QuerySwap += "                , numero_flujo                             -- FlowID\n";
                _QuerySwap += "                , fecha_inicio_flujo                       -- StartingDate\n";
                _QuerySwap += "                , fecha_vence_flujo                        -- ExpiryDate\n";
                _QuerySwap += "                , fecha_fijacion_tasa                      -- FixingDate\n";
                _QuerySwap += "                , FechaLiquidacion                         -- PaymentDate\n";
                _QuerySwap += "                , FechaReset                               -- ResetDate\n";
                _QuerySwap += "                , venta_moneda                             -- Currency\n";
                _QuerySwap += "                , venta_capital                            -- Capital\n";
                _QuerySwap += "                , venta_amortiza                           -- Amortization\n";
                _QuerySwap += "                , venta_saldo                              -- Balance\n";
                _QuerySwap += "                , venta_interes                            -- Interest\n";
                _QuerySwap += "                , venta_flujo_adicional                    -- AditionalFlow\n";
                _QuerySwap += "                , venta_spread                             -- Spread\n";
                _QuerySwap += "                , venta_codigo_tasa                        -- RateID\n";
                _QuerySwap += "                , venta_valor_tasa                         -- RateValue\n";
                _QuerySwap += "                , venta_valor_tasa_hoy                     -- RateValueToday\n";
                _QuerySwap += "                , venta_codamo_capital                     -- AmortizationID\n";
                _QuerySwap += "                , venta_mesamo_capital                     -- AmortizationMonth\n";
                _QuerySwap += "                , venta_codamo_interes                     -- InterestID\n";
                _QuerySwap += "                , venta_mesamo_interes                     -- InterestMonth\n";
                _QuerySwap += "                , venta_base                               -- BaseID\n";
                _QuerySwap += "                , estado_flujo                             -- FlowStatus\n";
                _QuerySwap += "                , modalidad_pago                           -- PaymentType\n";
                _QuerySwap += "                , recibimos_moneda                         -- PaymentCurrency\n";
                _QuerySwap += "                , recibimos_documento                      -- PaymentDocument\n";
                _QuerySwap += "                , recibimos_monto                          -- PaymentAmountUM\n";
                _QuerySwap += "                , recibimos_monto_USD                      -- PaymentAmountUSD\n";
                _QuerySwap += "                , recibimos_monto_CLP                      -- PaymentAmountCLP\n";
                _QuerySwap += "                , devengo_dias                             -- AccrualTerm\n";
                _QuerySwap += "                , devengo_venta                            -- AccrualAmount\n";
                _QuerySwap += "                , devengo_venta_acum                       -- AccrualAmountCumulativeUM\n";
                _QuerySwap += "                , devengo_venta_acum_peso                  -- AccrualAmountCumulativeCLP\n";
                _QuerySwap += "                , devengo_venta_ayer                       -- AccrualAmountYesterdayUM\n";
                _QuerySwap += "                , devengo_venta_ayer_peso                  -- AccrualAmountYesterdayCLP\n";
                _QuerySwap += "                , venta_zcr                                -- ZCR\n";
                _QuerySwap += "                , venta_mercado_tasa                       -- MarketRate\n";
                _QuerySwap += "                , venta_mercado                            -- MarketAmountUM\n";
                _QuerySwap += "                , venta_mercado_usd                        -- MarketAmountUSD\n";
                _QuerySwap += "                , venta_mercado_clp                        -- MarketAmountCLP\n";
                _QuerySwap += "                , venta_duration_tasa                      -- DurationRate\n";
                _QuerySwap += "                , venta_duration_monto                     -- DurationAmountUM\n";
                _QuerySwap += "                , venta_duration_monto_usd                 -- DurationAmountUSD\n";
                _QuerySwap += "                , venta_duration_monto_clp                 -- DurationAmountCLP\n";
                _QuerySwap += "                , venta_valor_presente                     -- PresentValue\n";
                _QuerySwap += "                , monto_mtm                                -- MarkToMarkedUM\n";
                _QuerySwap += "                , monto_mtm_usd                            -- MarkToMarkedUSD\n";
                _QuerySwap += "                , monto_mtm_clp                            -- MarkToMarkedCLP\n";
                _QuerySwap += "                , venta_valorizada                         -- Variation\n";
                _QuerySwap += "                , venta_variacion                          -- ValuatorAmount\n";
                _QuerySwap += "                , valorizacion_dia                         -- ValuatorToday\n";
                _QuerySwap += "                , Capital_Pesos_Actual                     -- CapitalCurrentCLP\n";
                _QuerySwap += "                , Capital_Pesos_Ayer                       -- CapitalYesterdayCLP\n";
                _QuerySwap += "                , Tasa_venta_Curva                         -- RateYield\n";
                _QuerySwap += "                , pasivo_MO_C08                            -- AmountC08UM\n";
                _QuerySwap += "                , pasivo_USD_C08                           -- AmountC08USD\n";
                _QuerySwap += "                , pasivo_CLP_C08                           -- AmountC08CLP\n";
                _QuerySwap += "                , Tasa_venta_CurvaVR                       -- RateYieldFairValue\n";
                _QuerySwap += "                , pasivo_FlujoMO                           -- FlowUM\n";
                _QuerySwap += "                , pasivo_FlujoUSD                          -- FlowUSD\n";
                _QuerySwap += "                , pasivo_FlujoCLP                          -- FlowCLP\n";
                _QuerySwap += "                , IntercPrinc                              -- ExchangePrincipal\n";
                _QuerySwap += "             FROM dbo.CarteraRes\n";
                _QuerySwap += "            WHERE Fecha_Proceso         =  @PortFolioDateToday\n";
                _QuerySwap += "              AND tipo_flujo            = 2\n";
                _QuerySwap += "              AND estado               <> 'C'\n";
                _QuerySwap += "              AND fecha_vence_flujo     > @PortFolioDateToday\n\n";

                _QuerySwap += "END\n\n";

                _QuerySwap += "INSERT INTO #TmpCartera\n";
                _QuerySwap += "       (\n";
                _QuerySwap += "              OperationNumber\n";
                _QuerySwap += "       ,      SwapType\n";
                _QuerySwap += "       ,      FlowType\n";
                _QuerySwap += "       ,      FlowID\n";
                _QuerySwap += "       ,      StartingDate\n";
                _QuerySwap += "       ,      ExpiryDate\n";
                _QuerySwap += "       ,      FixingDate\n";
                _QuerySwap += "       ,      PaymentDate\n";
                _QuerySwap += "       ,      ResetDate\n";
                _QuerySwap += "       ,      Currency\n";
                _QuerySwap += "       ,      Capital\n";
                _QuerySwap += "       ,      Amortization\n";
                _QuerySwap += "       ,      Balance\n";
                _QuerySwap += "       ,      Interest\n";
                _QuerySwap += "       ,      AditionalFlow\n";
                _QuerySwap += "       ,      Spread\n";
                _QuerySwap += "       ,      RateID\n";
                _QuerySwap += "       ,      RateValue\n";
                _QuerySwap += "       ,      RateValueToday\n";
                _QuerySwap += "       ,      AmortizationID\n";
                _QuerySwap += "       ,      AmortizationMonth\n";
                _QuerySwap += "       ,      InterestID\n";
                _QuerySwap += "       ,      InterestMonth\n";
                _QuerySwap += "       ,      BaseID\n";
                _QuerySwap += "       ,      FlowStatus\n";
                _QuerySwap += "       ,      PaymentType\n";
                _QuerySwap += "       ,      PaymentCurrency\n";
                _QuerySwap += "       ,      PaymentDocument\n";
                _QuerySwap += "       ,      PaymentAmountUM\n";
                _QuerySwap += "       ,      PaymentAmountUSD\n";
                _QuerySwap += "       ,      PaymentAmountCLP\n";
                _QuerySwap += "       ,      AccrualTerm\n";
                _QuerySwap += "       ,      AccrualAmount\n";
                _QuerySwap += "       ,      AccrualAmountCumulativeUM\n";
                _QuerySwap += "       ,      AccrualAmountCumulativeCLP\n";
                _QuerySwap += "       ,      AccrualAmountYesterdayUM\n";
                _QuerySwap += "       ,      AccrualAmountYesterdayCLP\n";
                _QuerySwap += "       ,      ZCR\n";
                _QuerySwap += "       ,      MarketRate\n";
                _QuerySwap += "       ,      MarketAmountUM\n";
                _QuerySwap += "       ,      MarketAmountUSD\n";
                _QuerySwap += "       ,      MarketAmountCLP\n";
                _QuerySwap += "       ,      DurationRate\n";
                _QuerySwap += "       ,      DurationAmountUM\n";
                _QuerySwap += "       ,      DurationAmountUSD\n";
                _QuerySwap += "       ,      DurationAmountCLP\n";
                _QuerySwap += "       ,      PresentValue\n";
                _QuerySwap += "       ,      MarkToMarkedUM\n";
                _QuerySwap += "       ,      MarkToMarkedUSD\n";
                _QuerySwap += "       ,      MarkToMarkedCLP\n";
                _QuerySwap += "       ,      Variation\n";
                _QuerySwap += "       ,      ValuatorAmount\n";
                _QuerySwap += "       ,      ValuatorToday\n";
                _QuerySwap += "       ,      CapitalCurrentCLP\n";
                _QuerySwap += "       ,      CapitalYesterdayCLP\n";
                _QuerySwap += "       ,      RateYield\n";
                _QuerySwap += "       ,      AmountC08UM\n";
                _QuerySwap += "       ,      AmountC08USD\n";
                _QuerySwap += "       ,      AmountC08CLP\n";
                _QuerySwap += "       ,      RateYieldFairValue\n";
                _QuerySwap += "       ,      FlowUM\n";
                _QuerySwap += "       ,      FlowUSD\n";
                _QuerySwap += "       ,      FlowCLP\n";
                _QuerySwap += "       ,      ExchangePrincipal\n";
                _QuerySwap += "       )\n";
                _QuerySwap += "       SELECT numero_operacion                         -- OperationNumber\n";
                _QuerySwap += "            , tipo_swap                                -- SwapType\n";
                _QuerySwap += "            , tipo_flujo                               -- FlowType\n";
                _QuerySwap += "            , numero_flujo                             -- FlowID\n";
                _QuerySwap += "            , fecha_inicio_flujo                       -- StartingDate\n";
                _QuerySwap += "            , fecha_vence_flujo                        -- ExpiryDate\n";
                _QuerySwap += "            , fecha_fijacion_tasa                      -- FixingDate\n";
                _QuerySwap += "            , FechaLiquidacion                         -- PaymentDate\n";
                _QuerySwap += "            , FechaReset                               -- ResetDate\n";
                _QuerySwap += "            , compra_moneda                            -- Currency\n";
                _QuerySwap += "            , compra_capital                           -- Capital\n";
                _QuerySwap += "            , compra_amortiza                          -- Amortization\n";
                _QuerySwap += "            , compra_saldo                             -- Balance\n";
                _QuerySwap += "            , compra_interes                           -- Interest\n";
                _QuerySwap += "            , compra_flujo_adicional                   -- AditionalFlow\n";
                _QuerySwap += "            , compra_spread                            -- Spread\n";
                _QuerySwap += "            , compra_codigo_tasa                       -- RateID\n";
                _QuerySwap += "            , compra_valor_tasa                        -- RateValue\n";
                _QuerySwap += "            , compra_valor_tasa_hoy                    -- RateValueToday\n";
                _QuerySwap += "            , compra_codamo_capital                    -- AmortizationID\n";
                _QuerySwap += "            , compra_mesamo_capital                    -- AmortizationMonth\n";
                _QuerySwap += "            , compra_codamo_interes                    -- InterestID\n";
                _QuerySwap += "            , compra_mesamo_interes                    -- InterestMonth\n";
                _QuerySwap += "            , compra_base                              -- BaseID\n";
                _QuerySwap += "            , estado_flujo                             -- FlowStatus\n";
                _QuerySwap += "            , modalidad_pago                           -- PaymentType\n";
                _QuerySwap += "            , recibimos_moneda                         -- PaymentCurrency\n";
                _QuerySwap += "            , recibimos_documento                      -- PaymentDocument\n";
                _QuerySwap += "            , recibimos_monto                          -- PaymentAmountUM\n";
                _QuerySwap += "            , recibimos_monto_USD                      -- PaymentAmountUSD\n";
                _QuerySwap += "            , recibimos_monto_CLP                      -- PaymentAmountCLP\n";
                _QuerySwap += "            , devengo_dias                             -- AccrualTerm\n";
                _QuerySwap += "            , devengo_compra                           -- AccrualAmount\n";
                _QuerySwap += "            , devengo_compra_acum                      -- AccrualAmountCumulativeUM\n";
                _QuerySwap += "            , devengo_compra_acum_peso                 -- AccrualAmountCumulativeCLP\n";
                _QuerySwap += "            , devengo_compra_ayer                      -- AccrualAmountYesterdayUM\n";
                _QuerySwap += "            , devengo_compra_ayer_peso                 -- AccrualAmountYesterdayCLP\n";
                _QuerySwap += "            , compra_zcr                               -- ZCR\n";
                _QuerySwap += "            , compra_mercado_tasa                      -- MarketRate\n";
                _QuerySwap += "            , compra_mercado                           -- MarketAmountUM\n";
                _QuerySwap += "            , compra_mercado_usd                       -- MarketAmountUSD\n";
                _QuerySwap += "            , compra_mercado_clp                       -- MarketAmountCLP\n";
                _QuerySwap += "            , compra_duration_tasa                     -- DurationRate\n";
                _QuerySwap += "            , compra_duration_monto                    -- DurationAmountUM\n";
                _QuerySwap += "            , compra_duration_monto_usd                -- DurationAmountUSD\n";
                _QuerySwap += "            , compra_duration_monto_clp                -- DurationAmountCLP\n";
                _QuerySwap += "            , compra_valor_presente                    -- PresentValue\n";
                _QuerySwap += "            , monto_mtm                                -- MarkToMarkedUM\n";
                _QuerySwap += "            , monto_mtm_usd                            -- MarkToMarkedUSD\n";
                _QuerySwap += "            , monto_mtm_clp                            -- MarkToMarkedCLP\n";
                _QuerySwap += "            , compra_valorizada                        -- Variation\n";
                _QuerySwap += "            , compra_variacion                         -- ValuatorAmount\n";
                _QuerySwap += "            , valorizacion_dia                         -- ValuatorToday\n";
                _QuerySwap += "            , Capital_Pesos_Actual                     -- CapitalCurrentCLP\n";
                _QuerySwap += "            , Capital_Pesos_Ayer                       -- CapitalYesterdayCLP\n";
                _QuerySwap += "            , Tasa_Compra_Curva                        -- RateYield\n";
                _QuerySwap += "            , Activo_MO_C08                            -- AmountC08UM\n";
                _QuerySwap += "            , Activo_USD_C08                           -- AmountC08USD\n";
                _QuerySwap += "            , Activo_CLP_C08                           -- AmountC08CLP\n";
                _QuerySwap += "            , Tasa_Compra_CurvaVR                      -- RateYieldFairValue\n";
                _QuerySwap += "            , Activo_FlujoMO                           -- FlowUM\n";
                _QuerySwap += "            , Activo_FlujoUSD                          -- FlowUSD\n";
                _QuerySwap += "            , Activo_FlujoCLP                          -- FlowCLP\n";
                _QuerySwap += "            , IntercPrinc                              -- ExchangePrincipal\n";
                _QuerySwap += "         FROM dbo.CarteraHis\n";
                _QuerySwap += "        WHERE FechaLiquidacion      = @PortFolioDateToday\n";
                _QuerySwap += "          AND tipo_flujo            = 1\n";
                _QuerySwap += "          AND estado               <> 'C'\n\n";

                _QuerySwap += "INSERT INTO #TmpCartera\n";
                _QuerySwap += "       (\n";
                _QuerySwap += "              OperationNumber\n";
                _QuerySwap += "       ,      SwapType\n";
                _QuerySwap += "       ,      FlowType\n";
                _QuerySwap += "       ,      FlowID\n";
                _QuerySwap += "       ,      StartingDate\n";
                _QuerySwap += "       ,      ExpiryDate\n";
                _QuerySwap += "       ,      FixingDate\n";
                _QuerySwap += "       ,      PaymentDate\n";
                _QuerySwap += "       ,      ResetDate\n";
                _QuerySwap += "       ,      Currency\n";
                _QuerySwap += "       ,      Capital\n";
                _QuerySwap += "       ,      Amortization\n";
                _QuerySwap += "       ,      Balance\n";
                _QuerySwap += "       ,      Interest\n";
                _QuerySwap += "       ,      AditionalFlow\n";
                _QuerySwap += "       ,      Spread\n";
                _QuerySwap += "       ,      RateID\n";
                _QuerySwap += "       ,      RateValue\n";
                _QuerySwap += "       ,      RateValueToday\n";
                _QuerySwap += "       ,      AmortizationID\n";
                _QuerySwap += "       ,      AmortizationMonth\n";
                _QuerySwap += "       ,      InterestID\n";
                _QuerySwap += "       ,      InterestMonth\n";
                _QuerySwap += "       ,      BaseID\n";
                _QuerySwap += "       ,      FlowStatus\n";
                _QuerySwap += "       ,      PaymentType\n";
                _QuerySwap += "       ,      PaymentCurrency\n";
                _QuerySwap += "       ,      PaymentDocument\n";
                _QuerySwap += "       ,      PaymentAmountUM\n";
                _QuerySwap += "       ,      PaymentAmountUSD\n";
                _QuerySwap += "       ,      PaymentAmountCLP\n";
                _QuerySwap += "       ,      AccrualTerm\n";
                _QuerySwap += "       ,      AccrualAmount\n";
                _QuerySwap += "       ,      AccrualAmountCumulativeUM\n";
                _QuerySwap += "       ,      AccrualAmountCumulativeCLP\n";
                _QuerySwap += "       ,      AccrualAmountYesterdayUM\n";
                _QuerySwap += "       ,      AccrualAmountYesterdayCLP\n";
                _QuerySwap += "       ,      ZCR\n";
                _QuerySwap += "       ,      MarketRate\n";
                _QuerySwap += "       ,      MarketAmountUM\n";
                _QuerySwap += "       ,      MarketAmountUSD\n";
                _QuerySwap += "       ,      MarketAmountCLP\n";
                _QuerySwap += "       ,      DurationRate\n";
                _QuerySwap += "       ,      DurationAmountUM\n";
                _QuerySwap += "       ,      DurationAmountUSD\n";
                _QuerySwap += "       ,      DurationAmountCLP\n";
                _QuerySwap += "       ,      PresentValue\n";
                _QuerySwap += "       ,      MarkToMarkedUM\n";
                _QuerySwap += "       ,      MarkToMarkedUSD\n";
                _QuerySwap += "       ,      MarkToMarkedCLP\n";
                _QuerySwap += "       ,      Variation\n";
                _QuerySwap += "       ,      ValuatorAmount\n";
                _QuerySwap += "       ,      ValuatorToday\n";
                _QuerySwap += "       ,      CapitalCurrentCLP\n";
                _QuerySwap += "       ,      CapitalYesterdayCLP\n";
                _QuerySwap += "       ,      RateYield\n";
                _QuerySwap += "       ,      AmountC08UM\n";
                _QuerySwap += "       ,      AmountC08USD\n";
                _QuerySwap += "       ,      AmountC08CLP\n";
                _QuerySwap += "       ,      RateYieldFairValue\n";
                _QuerySwap += "       ,      FlowUM\n";
                _QuerySwap += "       ,      FlowUSD\n";
                _QuerySwap += "       ,      FlowCLP\n";
                _QuerySwap += "       ,      ExchangePrincipal\n";
                _QuerySwap += "       )\n";
                _QuerySwap += "       SELECT numero_operacion                         -- OperationNumber\n";
                _QuerySwap += "            , tipo_swap                                -- SwapType\n";
                _QuerySwap += "            , tipo_flujo                               -- FlowType\n";
                _QuerySwap += "            , numero_flujo                             -- FlowID\n";
                _QuerySwap += "            , fecha_inicio_flujo                       -- StartingDate\n";
                _QuerySwap += "            , fecha_vence_flujo                        -- ExpiryDate\n";
                _QuerySwap += "            , fecha_fijacion_tasa                      -- FixingDate\n";
                _QuerySwap += "            , FechaLiquidacion                         -- PaymentDate\n";
                _QuerySwap += "            , FechaReset                               -- ResetDate\n";
                _QuerySwap += "            , venta_moneda                             -- Currency\n";
                _QuerySwap += "            , venta_capital                            -- Capital\n";
                _QuerySwap += "            , venta_amortiza                           -- Amortization\n";
                _QuerySwap += "            , venta_saldo                              -- Balance\n";
                _QuerySwap += "            , venta_interes                            -- Interest\n";
                _QuerySwap += "            , venta_flujo_adicional                    -- AditionalFlow\n";
                _QuerySwap += "            , venta_spread                             -- Spread\n";
                _QuerySwap += "            , venta_codigo_tasa                        -- RateID\n";
                _QuerySwap += "            , venta_valor_tasa                         -- RateValue\n";
                _QuerySwap += "            , venta_valor_tasa_hoy                     -- RateValueToday\n";
                _QuerySwap += "            , venta_codamo_capital                     -- AmortizationID\n";
                _QuerySwap += "            , venta_mesamo_capital                     -- AmortizationMonth\n";
                _QuerySwap += "            , venta_codamo_interes                     -- InterestID\n";
                _QuerySwap += "            , venta_mesamo_interes                     -- InterestMonth\n";
                _QuerySwap += "            , venta_base                               -- BaseID\n";
                _QuerySwap += "            , estado_flujo                             -- FlowStatus\n";
                _QuerySwap += "            , modalidad_pago                           -- PaymentType\n";
                _QuerySwap += "            , recibimos_moneda                         -- PaymentCurrency\n";
                _QuerySwap += "            , recibimos_documento                      -- PaymentDocument\n";
                _QuerySwap += "            , recibimos_monto                          -- PaymentAmountUM\n";
                _QuerySwap += "            , recibimos_monto_USD                      -- PaymentAmountUSD\n";
                _QuerySwap += "            , recibimos_monto_CLP                      -- PaymentAmountCLP\n";
                _QuerySwap += "            , devengo_dias                             -- AccrualTerm\n";
                _QuerySwap += "            , devengo_venta                            -- AccrualAmount\n";
                _QuerySwap += "            , devengo_venta_acum                       -- AccrualAmountCumulativeUM\n";
                _QuerySwap += "            , devengo_venta_acum_peso                  -- AccrualAmountCumulativeCLP\n";
                _QuerySwap += "            , devengo_venta_ayer                       -- AccrualAmountYesterdayUM\n";
                _QuerySwap += "            , devengo_venta_ayer_peso                  -- AccrualAmountYesterdayCLP\n";
                _QuerySwap += "            , venta_zcr                                -- ZCR\n";
                _QuerySwap += "            , venta_mercado_tasa                       -- MarketRate\n";
                _QuerySwap += "            , venta_mercado                            -- MarketAmountUM\n";
                _QuerySwap += "            , venta_mercado_usd                        -- MarketAmountUSD\n";
                _QuerySwap += "            , venta_mercado_clp                        -- MarketAmountCLP\n";
                _QuerySwap += "            , venta_duration_tasa                      -- DurationRate\n";
                _QuerySwap += "            , venta_duration_monto                     -- DurationAmountUM\n";
                _QuerySwap += "            , venta_duration_monto_usd                 -- DurationAmountUSD\n";
                _QuerySwap += "            , venta_duration_monto_clp                 -- DurationAmountCLP\n";
                _QuerySwap += "            , venta_valor_presente                     -- PresentValue\n";
                _QuerySwap += "            , monto_mtm                                -- MarkToMarkedUM\n";
                _QuerySwap += "            , monto_mtm_usd                            -- MarkToMarkedUSD\n";
                _QuerySwap += "            , monto_mtm_clp                            -- MarkToMarkedCLP\n";
                _QuerySwap += "            , venta_valorizada                         -- Variation\n";
                _QuerySwap += "            , venta_variacion                          -- ValuatorAmount\n";
                _QuerySwap += "            , valorizacion_dia                         -- ValuatorToday\n";
                _QuerySwap += "            , Capital_Pesos_Actual                     -- CapitalCurrentCLP\n";
                _QuerySwap += "            , Capital_Pesos_Ayer                       -- CapitalYesterdayCLP\n";
                _QuerySwap += "            , Tasa_venta_Curva                         -- RateYield\n";
                _QuerySwap += "            , pasivo_MO_C08                            -- AmountC08UM\n";
                _QuerySwap += "            , pasivo_USD_C08                           -- AmountC08USD\n";
                _QuerySwap += "            , pasivo_CLP_C08                           -- AmountC08CLP\n";
                _QuerySwap += "            , Tasa_venta_CurvaVR                       -- RateYieldFairValue\n";
                _QuerySwap += "            , pasivo_FlujoMO                           -- FlowUM\n";
                _QuerySwap += "            , pasivo_FlujoUSD                          -- FlowUSD\n";
                _QuerySwap += "            , pasivo_FlujoCLP                          -- FlowCLP\n";
                _QuerySwap += "            , IntercPrinc                              -- ExchangePrincipal\n";
                _QuerySwap += "         FROM dbo.CarteraHis\n";
                _QuerySwap += "        WHERE FechaLiquidacion      = @PortFolioDateToday\n";
                _QuerySwap += "          AND tipo_flujo            = 2\n";
                _QuerySwap += "          AND estado               <> 'C'\n\n";

                _QuerySwap += "SELECT @PortFolioDateYesterday = MAX( Fecha_Proceso )\n";
                _QuerySwap += "  FROM dbo.CarteraRes\n";
                _QuerySwap += " WHERE Fecha_Proceso     BETWEEN DATEADD( DAY, -10, @PortFolioDateToday ) AND DATEADD( DAY, -1, @PortFolioDateToday )\n\n";

                _QuerySwap += "UPDATE #TmpCartera\n";
                _QuerySwap += "   SET RateValueYesterday = CASE FlowType WHEN 1 THEN compra_valor_tasa_hoy ELSE venta_valor_tasa_hoy END\n";
                _QuerySwap += "  FROM dbo.CarteraRes\n";
                _QuerySwap += " WHERE Fecha_Proceso      = @PortFolioDateYesterday\n";
                _QuerySwap += "   AND Numero_Operacion   = OperationNumber\n";
                _QuerySwap += "   AND tipo_flujo         = FlowType\n";
                _QuerySwap += "   AND numero_flujo       = FlowID\n\n";

                _QuerySwap += "SELECT * FROM #TmpCartera\n";
                _QuerySwap += "ORDER BY OperationNumber, FlowType, FlowID\n\n";

                _QuerySwap += "DROP TABLE #TmpCartera\n\n";

                _QuerySwap += "SET NOCOUNT OFF\n";

                _QuerySwap = _QuerySwap.Replace("[@portFolioDate]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACSWAPSUDA");
                DataTable _SwapFlow;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySwap);
                    _SwapFlow = _Connect.QueryDataTable();
                    _SwapFlow.TableName = "SwapFlow";

                    if (_SwapFlow.Rows.Count.Equals(0))
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
                    _SwapFlow = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SwapFlow;
            }

            public override DataTable LoadMTMYesterday(DateTime portFolioDateYesterday)
            {

                string _QuerySwap;

                #region "Query Load PortFolio Swap Flow"

                _QuerySwap = "";
                _QuerySwap += "SET NOCOUNT ON\n\n";

                _QuerySwap += "DECLARE @ProcessDate                DATETIME\n";

                _QuerySwap += "SET @ProcessDate     = [@ProcessDate]\n\n";

                _QuerySwap += "SELECT 'ID'                     = SW.id\n";
                _QuerySwap += "     , 'OperationNumber'        = SD.OperationNumber\n";
                _QuerySwap += "     , 'MarktoMarketToday'      = SW.marktomarketvaluetoday\n";
                _QuerySwap += "     , 'MarktoMarketUMToday'    = SW.marktomarketvaluetodayum\n";
                _QuerySwap += "     , 'FairValueAsset'         = SW.fairvalueasset\n";
                _QuerySwap += "     , 'FairValueAssetUM'       = SW.fairvalueassetum\n";
                _QuerySwap += "     , 'FairValueLiabilities'   = SW.fairvalueliabilities\n";
                _QuerySwap += "     , 'FairValueLiabilitiesUM' = SW.fairvalueliabilitiesum\n";
                _QuerySwap += "     , 'FairValueNet'           = SW.fairvaluenet\n";
                _QuerySwap += "  FROM dbo.SensibilitiesSwap SW\n";
                _QuerySwap += "       INNER JOIN dbo.SensibilitiesData SD  ON SD.ID = SW.ID\n";
                _QuerySwap += " WHERE SW.SensibilitiesDate = @ProcessDate\n\n";

                _QuerySwap += "SET NOCOUNT OFF\n";

                _QuerySwap = _QuerySwap.Replace("[@ProcessDate]", "'" + portFolioDateYesterday.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _SwapFlow;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySwap);
                    _SwapFlow = _Connect.QueryDataTable();
                    _SwapFlow.TableName = "SwapMTMYesterday";

                    if (_SwapFlow.Rows.Count.Equals(0))
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
                    _SwapFlow = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SwapFlow;

            }
        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceCurrencyValueAccount : Source
        {
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
