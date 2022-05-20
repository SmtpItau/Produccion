using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.PortFolio
{

    public class PortFolioFixingRate
    {

        #region "Atributos privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public PortFolioFixingRate()
        {
            Set(enumSource.System);
        }

        public PortFolioFixingRate(enumSource _ID)
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
                    _Message = "La cartera de Renta Fija se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error en la cargar de la cartera de Renta Fija.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error en la cargar de la cartera de Renta Fija.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la cartera de Renta Fija.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Ya fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "Se esta cargando la cartera de Renta Fija.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la cartera de Renta Fija.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro la cartera de Renta Fija.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataSet LoadPortFolio(DateTime portFolioDate, DateTime martkToMarketRateToday, DateTime markToMarketRateYesterday)
        {
            DataSet _FixingRatePortFolio = new DataSet();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _FixingRatePortFolio = _System.LoadPortFolio(portFolioDate, martkToMarketRateToday, markToMarketRateYesterday);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _FixingRatePortFolio = _Bloomberg.LoadPortFolio(portFolioDate, martkToMarketRateToday, markToMarketRateYesterday);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _FixingRatePortFolio = _Excel.LoadPortFolio(portFolioDate, martkToMarketRateToday, markToMarketRateYesterday);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _FixingRatePortFolio = _XML.LoadPortFolio(portFolioDate, martkToMarketRateToday, markToMarketRateYesterday);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _FixingRatePortFolio;

        }

        public void SavePortFolio(DateTime portFolioDate, DataSet portFolioDataSet, int userID)
        {

            #region "Definición de variables"

            int _ContractID;
            int _SensibilitiesRow;
            int _ID;
            double _SensibilitiesID;
            string _Query;
            string _QueryYield;
            string _Key;
            string _KeyOperation;
            string _KeySensibilities;

            DataTable _Yield;
            DataTable _PortFolioT0;
            //DataTable _PortFolioT1;
            //DataTable _TimeDecay;
            //DataTable _ExchangeRate;
            //DataTable _EffectRate;

            DataRow _DataRow;
            DataRow _PortFolioT0Row;
            //DataRow _PortFolioT1Row;
            //DataRow _TimeDecayRow;
            //DataRow _ExchangeRateRow;
            //DataRow _EffectRateRow;
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
            string _MNemonics;
            int _IssueID;
            string _FlagQuotes;
            DateTime _ExpiryDate;
            int _DocumentNumber;
            int _OperationNumber;
            int _OperationID;
            int _CustomerID;
            int _CustomerCode;
            int _CurrencyIssue;
            double _Nominal;
            double _MarktoMarketValueYesterdayUM;
            double _MarktoMarketValueYesterday;
            double _MarktoMarketValueToday;
            double _MarktoMarketValueTodayUM;
            double _MarktoMarketValueTimeDecay;
            double _MarktoMarketValueExchangeRate;
            double _MarktoMarketValueEffectRate;
            double _CorryCost;
            double _CashFlow;
            double _MarktoMarketRateYesterday;
            double _MarktoMarketRateToday;
            double _MarktoMarketRateEndMonth;
            double _PresentValueToday;
            double _PresentValueYesterday;
            double _MacaulayDuration;
            double _ModifiedDuration;
            double _Convexity;
            double _PurchaseRate;
            double _PurchaseValue;
            double _PurchaseValueUM;
            double _SalesValue;
            double _SalesValueUM;
            double _PresentValueOriginSystem;
            double _FairValueAssetSystem;
            double _FairValueLiabilitiesSystem;
            double _FairValueNetSystem;
            double _AccruedInterestSystem;
            double _DailyInterestSystem;
            double _MonthlyInterestSystem;
            double _AccruedAdjustmentSystem;
            double _DailyAdjustmentSystem;
            double _MonthlyAdjustmentSystem;
            double _MacaulayDurationSystem;
            double _ModifiedDurationSystem;
            double _ConvexitySystem;
            DateTime _ContractDate;
            DateTime _CourtDateCoupon;

            #endregion

            #region "Asignación de Variables"

            _Yield = portFolioDataSet.Tables["OperacionesPorPlazo"];
            _PortFolioT0 = portFolioDataSet.Tables["PortFolioT0"];
            //_PortFolioT1 = portFolioDataSet.Tables["PortFolioT1"];
            //_TimeDecay = portFolioDataSet.Tables["TimeDecay"];
            //_ExchangeRate = portFolioDataSet.Tables["ExchangeRate"];
            //_EffectRate = portFolioDataSet.Tables["EffectRate"];

            #endregion

            #region "Seteo de la Conneccion a la base de datos"

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");

            #endregion

            #region "Conneccion a la base de datos"

            _Connect.Connection();

            #endregion

            #region "Asignación de valores estandars"

            _SensibilitiesDate = portFolioDate;
            _SystemID = "BTR";

            #endregion

            #region "Limpia Datos Sensibilidad"

            _Query = "";
            _Query += "DELETE dbo.SensibilitiesYield      WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = [@SystemID]\n";
            _Query += "DELETE dbo.SensibilitiesData       WHERE sensibilitiesdate = [@SensibilitiesDate] AND [System] = [@SystemID]\n";
            _Query += "DELETE dbo.SensibilitiesFixingRate WHERE sensibilitiesdate = [@SensibilitiesDate]\n";

            _Query = _Query.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'" );
            _Query = _Query.Replace("[@SystemID]", "'" + _SystemID + "'" );

            _Connect.DedicatedExecution(_Query);

            #endregion

            #region "Grabar Datos"

            _ID = 0;
            _SensibilitiesID = 0;

            for (_ContractID = 0; _ContractID < _PortFolioT0.Rows.Count; _ContractID++)
            {

                #region "Seteo de Contratos"

                _PortFolioT0Row = _PortFolioT0.Rows[_ContractID];
                //_PortFolioT1Row = _PortFolioT1.Rows[_ContractID];
                //_TimeDecayRow = _TimeDecay.Rows[_ContractID];
                //_ExchangeRateRow = _ExchangeRate.Rows[_ContractID];
                //_EffectRateRow = _EffectRate.Rows[_ContractID];

                #endregion

                #region "Seteo de Variables de Contratos"

                _Query = "";
                _DocumentNumber = int.Parse(_PortFolioT0Row["DocumentNumber"].ToString());
                _OperationNumber = int.Parse(_PortFolioT0Row["OperationNumber"].ToString());
                _OperationID = int.Parse(_PortFolioT0Row["OperationID"].ToString());
                _BookID = _PortFolioT0Row["BookID"].ToString();
                _PortFolioRulesID = _PortFolioT0Row["PortfolioRulesID"].ToString();
                _FinancialPortFolioID = _PortFolioT0Row["FinancialPortFolioID"].ToString();
                _ProductID = _PortFolioT0Row["OperationType"].ToString();
                _PrimaryCurrencyID = 0;
                _SecondCurrencyID = 0;
                _PrimaryRateID = 0;
                _SecondRateID = 0;
                _FamilyID = _PortFolioT0Row["FamilyID"].ToString();
                _MnemonicsMask = _PortFolioT0Row["MNemonicsMask"].ToString();
                _MNemonics = _PortFolioT0Row["MNemonics"].ToString();
                _IssueID = int.Parse(_PortFolioT0Row["IssueCode"].ToString());

                if (_IssueID.Equals(97023000))
                {
                    _FamilyID = "LCHRP";
                }

                _FlagQuotes = "N";
                _ExpiryDate = DateTime.Parse(_PortFolioT0Row["ExpiryDate"].ToString());
                _CustomerID = int.Parse(_PortFolioT0Row["CustomerID"].ToString());
                _CustomerCode = int.Parse(_PortFolioT0Row["CustomerCode"].ToString());
                _Nominal = double.Parse(_PortFolioT0Row["Nominal"].ToString());
                _CurrencyIssue = int.Parse(_PortFolioT0Row["CurrencyIssueID"].ToString());
                _MarktoMarketValueYesterday = double.Parse(_PortFolioT0Row["ValuatorMarkToMarketYesterday"].ToString());
                _MarktoMarketValueYesterdayUM = double.Parse(_PortFolioT0Row["ValuatorMarkToMarketYesterdayUM"].ToString());
                _PresentValueYesterday = double.Parse(_PortFolioT0Row["ValuatorPresentValueYesterday"].ToString());
                _MarktoMarketValueToday = double.Parse(_PortFolioT0Row["MarkToMarketCLP"].ToString());
                _MarktoMarketValueTodayUM = double.Parse(_PortFolioT0Row["MarkToMarketUM"].ToString());
                _MarktoMarketValueTimeDecay = double.Parse(_PortFolioT0Row["ValuatorTimeDecay"].ToString());
                _MarktoMarketValueExchangeRate = double.Parse(_PortFolioT0Row["ValuatorExchangeRate"].ToString());
                _MarktoMarketValueEffectRate = double.Parse(_PortFolioT0Row["ValuatorEffectRate"].ToString());
                _PresentValueToday = double.Parse(_PortFolioT0Row["ValuatorPresentValueCLP"].ToString());
                _CorryCost = double.Parse(_PortFolioT0Row["CorryCost"].ToString());
                _CashFlow = double.Parse(_PortFolioT0Row["CashFlow"].ToString());
                _MarktoMarketRateYesterday = double.Parse(_PortFolioT0Row["MarkToMarketRateYesterday"].ToString());
                _MarktoMarketRateToday = double.Parse(_PortFolioT0Row["MarkToMarketRateToday"].ToString());
                _MarktoMarketRateEndMonth = 0;
                _MacaulayDuration = double.Parse(_PortFolioT0Row["ValuatorMacaulayDuration"].ToString());
                _ModifiedDuration = double.Parse(_PortFolioT0Row["ValuatorModifiedDuration"].ToString());
                _Convexity = double.Parse(_PortFolioT0Row["ValuatorConvexity"].ToString());
                _PurchaseRate = double.Parse(_PortFolioT0Row["PurchaseRate"].ToString());
                _PurchaseValue = double.Parse(_PortFolioT0Row["PurchaseValue"].ToString());
                _PurchaseValueUM = double.Parse(_PortFolioT0Row["PurchaseValueUM"].ToString());
                _SalesValue = double.Parse(_PortFolioT0Row["SalesValue"].ToString());
                _SalesValueUM = double.Parse(_PortFolioT0Row["SalesValueUM"].ToString());
                _PresentValueOriginSystem = double.Parse(_PortFolioT0Row["PresentValue"].ToString());
                _FairValueAssetSystem = 0;
                _FairValueLiabilitiesSystem = 0;
                _FairValueNetSystem = double.Parse(_PortFolioT0Row["MarkToMarketValueToday"].ToString());
                _AccruedInterestSystem = double.Parse(_PortFolioT0Row["AccruedInterest"].ToString());
                _DailyInterestSystem = double.Parse(_PortFolioT0Row["DailyInterest"].ToString());
                _MonthlyInterestSystem = double.Parse(_PortFolioT0Row["MonthlyInterest"].ToString());
                _AccruedAdjustmentSystem = double.Parse(_PortFolioT0Row["AccruedAdjustment"].ToString());
                _DailyAdjustmentSystem = double.Parse(_PortFolioT0Row["DailyAdjustment"].ToString());
                _MonthlyAdjustmentSystem = double.Parse(_PortFolioT0Row["MonthlyAdjustment"].ToString());
                _MacaulayDurationSystem = double.Parse(_PortFolioT0Row["MacaulayDuration"].ToString());
                _ModifiedDurationSystem = double.Parse(_PortFolioT0Row["ModifiedDuration"].ToString());
                _ConvexitySystem = double.Parse(_PortFolioT0Row["Convexidad"].ToString());
                _ContractDate = DateTime.Parse(_PortFolioT0Row["PurchaseDate"].ToString());
                _CourtDateCoupon = DateTime.Parse(_PortFolioT0Row["CourtDateCoupon"].ToString());

                if (_ContractDate.Equals(portFolioDate))
                {
                    _MarktoMarketValueTimeDecay = 0;
                    _MarktoMarketValueExchangeRate = 0;
                    _MarktoMarketValueEffectRate = _MarktoMarketValueToday;
                    _MarktoMarketValueYesterday = 0;
                    _PresentValueYesterday = 0;
                    _CashFlow = _MarktoMarketValueToday - _PresentValueOriginSystem;
                }

                if (_PortFolioT0Row["DataOperationType"].ToString().Equals("V"))
                {
                    //_MarktoMarketValueTimeDecay = 0;
                    //_MarktoMarketValueExchangeRate = 0;
                    //_MarktoMarketValueEffectRate = _MarktoMarketValueToday;
                    //_CashFlow = _SalesValue - _PresentValueOriginSystem;
                    _ProductID = "VP";
                }

                if (_PortFolioT0Row["DataType"].ToString().Equals("IN"))
                {
                    _ProductID = "IN";
                }

                _ID++;

                _KeyOperation = portFolioDate.ToString("yyyyMMdd") + "1" + _ID.ToString("0000000");

                #endregion

                #region "Setea Query del contrato"

                _Query = "";

                #region "SensibilitiesData"

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
                _Query += ", userid";
                _Query += " )\n";
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
                _Query += ", [@DocumentNumber]";
                _Query += ", [@OperationNumber]";
                _Query += ", [@OperationID]";
                _Query += ", [@CustomerID]";
                _Query += ", [@CustomerCode]";
                _Query += ", [@UserID]";
                _Query += " )\n\n";

                #endregion

                #region "SensibilitiesFixingRate"

                _Query += "INSERT INTO dbo.SensibilitiesFixingRate ( ";
                _Query += "sensibilitiesdate";
                _Query += ", id";
                _Query += ", Nominal";
                _Query += ", CurrencyIssue";
                _Query += ", marktomarketvalueyesterdayum";
                _Query += ", marktomarketvalueyesterday";
                _Query += ", marktomarketvaluetoday";
                _Query += ", marktomarketvaluetodayum";
                _Query += ", presentvaluetoday";
                _Query += ", presentvalueyesterday";
                _Query += ", marktomarketvaluetimedecay";
                _Query += ", marktomarketvalueexchangerate";
                _Query += ", marktomarketvalueeffectrate";
                _Query += ", corrycost";
                _Query += ", CashFlow";
                _Query += ", marktomarketrateyesterday";
                _Query += ", marktomarketratetoday";
                _Query += ", marktomarketrateendmonth";
                _Query += ", macaulayduration";
                _Query += ", modifiedduration";
                _Query += ", convexity";
                _Query += ", contractdate";
                _Query += ", purchaserate";
                _Query += ", purchasevalue";
                _Query += ", purchasevalueum";
                _Query += ", salesvalue";
                _Query += ", salesvalueum";
                _Query += ", CourtDateCoupon";
                _Query += ", presentvalueoriginsystem";
                _Query += ", fairvalueassetsystem";
                _Query += ", fairvalueliabilitiessystem";
                _Query += ", fairvaluenetsystem";
                _Query += ", accruedinterestsystem";
                _Query += ", dailyinterestsystem";
                _Query += ", monthlyinterestsystem";
                _Query += ", accruedadjustmentsystem";
                _Query += ", dailyadjustmentsystem";
                _Query += ", monthlyadjustmentsystem";
                _Query += ", macaulaydurationsystem";
                _Query += ", modifieddurationsystem";
                _Query += ", convexitysystem";
                _Query += " )\n";
                _Query += "VALUES ( ";
                _Query += "[@SensibilitiesDate]";
                _Query += ", [@DataID]";
                _Query += ", [@Nominal]";
                _Query += ", [@CurrencyIssue]";
                _Query += ", [@MarktoMarketValueYesterdayUM]";
                _Query += ", [@MarktoMarketValueYesterday]";
                _Query += ", [@MarktoMarketValueToday]";
                _Query += ", [@MarktoMarketValueTodayUM]";
                _Query += ", [@PresentValueToday]";
                _Query += ", [@PresentValueYesterday]";
                _Query += ", [@MarktoMarketValueTimeDecay]";
                _Query += ", [@MarktoMarketValueExchangeRate]";
                _Query += ", [@MarktoMarketValueEffectRate]";
                _Query += ", [@CorryCost]";
                _Query += ", [@CashFlow]";
                _Query += ", [@MarktoMarketRateYesterday]";
                _Query += ", [@MarktoMarketRateToday]";
                _Query += ", [@MarktoMarketRateEndMonth]";
                _Query += ", [@MacaulayDuration]";
                _Query += ", [@ModifiedDuration]";
                _Query += ", [@Convexity]";
                _Query += ", [@ContractDate]";
                _Query += ", [@PurchaseRate]";
                _Query += ", [@PurchaseValue]";
                _Query += ", [@PurchaseValueUM]";
                _Query += ", [@SalesValue]";
                _Query += ", [@SalesValueUM]";
                _Query += ", [@CourtDateCoupon]";
                _Query += ", [@PresentValueOriginSystem]";
                _Query += ", [@FairValueAssetSystem]";
                _Query += ", [@FairValueLiabilitiesSystem]";
                _Query += ", [@FairValueNetSystem]";
                _Query += ", [@AccruedInterestSystem]";
                _Query += ", [@DailyInterestSystem]";
                _Query += ", [@MonthlyInterestSystem]";
                _Query += ", [@AccruedAdjustmentSystem]";
                _Query += ", [@DailyAdjustmentSystem]";
                _Query += ", [@MonthlyAdjustmentSystem]";
                _Query += ", [@MacaulayDurationSystem]";
                _Query += ", [@ModifiedDurationSystem]";
                _Query += ", [@ConvexitySystem]";
                _Query += " )\n\n";

                #endregion

                #region "Assing Value"

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
                _Query = _Query.Replace("[@Mnemonics]", "'" + _MNemonics + "'");
                _Query = _Query.Replace("[@IssueID]", _IssueID.ToString());
                _Query = _Query.Replace("[@FlagQuotes]", "'" + _FlagQuotes + "'");
                _Query = _Query.Replace("[@ExpiryDate]", "'" + _ExpiryDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@DocumentNumber]", _DocumentNumber.ToString());
                _Query = _Query.Replace("[@OperationNumber]", _OperationNumber.ToString());
                _Query = _Query.Replace("[@OperationID]", _OperationID.ToString());
                _Query = _Query.Replace("[@CustomerID]", _CustomerID.ToString());
                _Query = _Query.Replace("[@CustomerCode]", _CustomerCode.ToString());
                _Query = _Query.Replace("[@UserID]", userID.ToString());
                _Query = _Query.Replace("[@CurrencyIssue]", _CurrencyIssue.ToString());
                _Query = _Query.Replace("[@Nominal]", _Nominal.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueYesterdayUM]", _MarktoMarketValueYesterdayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueYesterday]", _MarktoMarketValueYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueToday]", _MarktoMarketValueToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueTodayUM]", _MarktoMarketValueTodayUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PresentValueToday]", _PresentValueToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PresentValueYesterday]", _PresentValueYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueTimeDecay]", _MarktoMarketValueTimeDecay.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueExchangeRate]", _MarktoMarketValueExchangeRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketValueEffectRate]", _MarktoMarketValueEffectRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CorryCost]", _CorryCost.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CashFlow]", _CashFlow.ToString().Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateYesterday]", _MarktoMarketRateYesterday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateToday]", _MarktoMarketRateToday.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MarktoMarketRateEndMonth]", _MarktoMarketRateEndMonth.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MacaulayDuration]", _MacaulayDuration.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ModifiedDuration]", _ModifiedDuration.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@Convexity]", _Convexity.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ContractDate]", "'" + _ContractDate.ToString("yyyyMMdd") + "'");
                _Query = _Query.Replace("[@PurchaseRate]", _PurchaseRate.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PurchaseValue]", _PurchaseValue.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@PurchaseValueUM]", _PurchaseValueUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@SalesValue]", _SalesValue.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@SalesValueUM]", _SalesValueUM.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@CourtDateCoupon]", "'" + _CourtDateCoupon.ToString("yyyMMdd") + "'");
                _Query = _Query.Replace("[@PresentValueOriginSystem]", _PresentValueOriginSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueAssetSystem]", _FairValueAssetSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueLiabilitiesSystem]", _FairValueLiabilitiesSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@FairValueNetSystem]", _FairValueNetSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@AccruedInterestSystem]", _AccruedInterestSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@DailyInterestSystem]", _DailyInterestSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MonthlyInterestSystem]", _MonthlyInterestSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@AccruedAdjustmentSystem]", _AccruedAdjustmentSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@DailyAdjustmentSystem]", _DailyAdjustmentSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MonthlyAdjustmentSystem]", _MonthlyAdjustmentSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@MacaulayDurationSystem]", _MacaulayDurationSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ModifiedDurationSystem]", _ModifiedDurationSystem.ToString("0.0000000000").Replace(",", "."));
                _Query = _Query.Replace("[@ConvexitySystem]", _ConvexitySystem.ToString("0.0000000000").Replace(",", "."));

                #endregion

                #endregion

                #region "Generación Key"

                _Key = "";
                _Key += "OperationNumber = " + _OperationNumber.ToString() + " AND ";
                _Key += "DocumentNumber = " + _DocumentNumber.ToString() + " AND ";
                _Key += "OperationID = " + _OperationID.ToString();

                #endregion

                #region "Selección de Restistros"

                _DataRows = _Yield.Select(_Key);

                #endregion

                #region "Grabar Registros de Sensibilidad"

                for (_SensibilitiesRow = 0; _SensibilitiesRow < _DataRows.Length; _SensibilitiesRow++)
                {

                    #region "Seteo Sensibilidad"

                    _DataRow = _DataRows[_SensibilitiesRow];

                    #endregion

                    #region "Seteo de Variables de Sensibilidad"

                    _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());
                    _OperationID = int.Parse(_DataRow["OperationID"].ToString());
                    _MnemonicsMask = _DataRow["MNemonicsMask"].ToString();
                    _YieldName = _DataRow["YieldName"].ToString();
                    _Term = int.Parse(_DataRow["Term"].ToString());
                    _MarktoMarketValue = double.Parse(_DataRow["MarktoMarketValue"].ToString());
                    _SensibilitiesValue = double.Parse(_DataRow["SensibilitiesValue"].ToString());
                    _Sensibilities = double.Parse(_DataRow["Sensibilities"].ToString());
                    _DeltaRate = double.Parse(_DataRow["DeltaRate"].ToString());
                    _EstimationValue = double.Parse(_DataRow["Estimation"].ToString());
                    _UserCreator = 1;
                    _SensibilitiesID++;
                    _KeySensibilities = portFolioDate.ToString("yyyyMMdd") + "1" + _SensibilitiesID.ToString("0000000");

                    #endregion

                    #region "Setea Query Sensibilidad"

                    #region "SensibilitiesYield"

                    _QueryYield = "";
                    _QueryYield += "INSERT INTO dbo.SensibilitiesYield ( ";
                    _QueryYield += "id";
                    _QueryYield += ", dataid";
                    _QueryYield += ", sensibilitiesdate";
                    _QueryYield += ", [system]";
                    _QueryYield += ", mnemonicsmask";
                    _QueryYield += ", family";
                    _QueryYield += ", documentnumber";
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
                    _QueryYield += " )\n";
                    _QueryYield += "VALUES ( ";
                    _QueryYield += "[@SensibilitiesID]";
                    _QueryYield += ", [@DataID]";
                    _QueryYield += ", [@SensibilitiesDate]";
                    _QueryYield += ", [@SystemID]";
                    _QueryYield += ", [@MnemonicsMask]";
                    _QueryYield += ", [@FamilyID]";
                    _QueryYield += ", [@DocumentNumber]";
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
                    _QueryYield += " )\n\n";

                    #endregion

                    #region "Assign Value"

                    _QueryYield = _QueryYield.Replace("[@SensibilitiesID]", _KeySensibilities);
                    _QueryYield = _QueryYield.Replace("[@DataID]", _KeyOperation);
                    _QueryYield = _QueryYield.Replace("[@SensibilitiesDate]", "'" + _SensibilitiesDate.ToString("yyyyMMdd") + "'");
                    _QueryYield = _QueryYield.Replace("[@SystemID]", "'" + _SystemID + "'");
                    _QueryYield = _QueryYield.Replace("[@MnemonicsMask]", "'" + _MnemonicsMask + "'");
                    _QueryYield = _QueryYield.Replace("[@FamilyID]", "'" + _FamilyID + "'");
                    _QueryYield = _QueryYield.Replace("[@DocumentNumber]", _DocumentNumber.ToString());
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

                    #endregion

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
            //_PortFolioT1 = null;
            //_TimeDecay = null;
            //_ExchangeRate = null;
            //_EffectRate = null;
            _DataRow = null;
            _PortFolioT0Row = null;
            //_PortFolioT1Row = null;
            //_TimeDecayRow = null;
            //_ExchangeRateRow = null;
            //_EffectRateRow = null;

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

            public virtual DataSet LoadPortFolio(DateTime portFolioDate, DateTime martkToMarketRateToday, DateTime markToMarketRateYesterday)
            {
                DataSet _FixingRatePortFolio = new DataSet();

                return _FixingRatePortFolio;
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataSet LoadPortFolio(DateTime portFolioDate, DateTime martkToMarketRateToday, DateTime markToMarketRateYesterday)
            {

                DataSet _PortFolio = new DataSet();
                DataTable _PortFolioData = new DataTable();
                DataTable _TPMRate = new DataTable();

                _PortFolioData = LoadPortFolioData(portFolioDate, martkToMarketRateToday, markToMarketRateYesterday);
                _TPMRate = LoadTPMRate(portFolioDate);

                _PortFolio.Merge(_PortFolioData);
                _PortFolio.Merge(_TPMRate);

                return (_PortFolio);

            }

            private DataTable LoadPortFolioData(DateTime portFolioDate, DateTime martkToMarketRateToday, DateTime markToMarketRateYesterday)
            {

                String _QueryRate = "";
                DateTime _DateProcess;
                DataTable _FixingRatePortFolio;

                _DateProcess = LoadDate();

                if (Status == enumStatus.Already)
                {

                    #region "Query Load PortFolio Fixing Rate"

                    _QueryRate = "";
                    _QueryRate += "SET NOCOUNT ON\n\n";

                    #region "Definición de Variables"

                    _QueryRate += "DECLARE @PortFolioDateToday         DATETIME\n";
                    _QueryRate += "DECLARE @MarkToMarketToday          DATETIME\n";
                    _QueryRate += "DECLARE @MarkToMarketYesterday      DATETIME\n\n";

                    #endregion

                    #region "Seteo de Variables"

                    _QueryRate += "SET @PortFolioDateToday     = [@PortFolioDate]\n";
                    _QueryRate += "SET @MarkToMarketToday      = [@MarkToMarketToday]\n";
                    _QueryRate += "SET @MarkToMarketYesterday  = [@MarkToMarketRateYesterday]\n\n";

                    #endregion

                    #region "Creación de Tabla"

                    _QueryRate += "-- Creación de la tabla temporal\n";
                    _QueryRate += "CREATE TABLE #tmpCartera\n";
                    _QueryRate += "       (\n";
                    _QueryRate += "         OperationNumber            INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , DocumentNumber             INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , OperationID                INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , OperationType              VARCHAR(05)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , CustomerID                 INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , CustomerCode               INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , BookID                     VARCHAR(20)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , PortfolioRulesID           VARCHAR(20)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , FinancialPortFolioID       VARCHAR(20)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , AccrualOperationType       VARCHAR(05)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , AccrualPortFolioID         VARCHAR(03)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , MNemonicsCode              INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , FamilyID                   VARCHAR(20)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , MNemonics                  VARCHAR(20)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , MNemonicsMask              VARCHAR(20)  NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , IssueCode                  INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , CurrencyIssueID            INT          NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , IssueDate                  DATETIME     NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , ExpiryDate                 DATETIME     NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , Nominal                    FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , PurchaseDate               DATETIME     NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , PaymentDate                DATETIME     NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , PurchaseRate               FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , PurchaseValue              FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , PurchaseValueUM            FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , SalesValue                 FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , SalesValueUM               FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , PresentValue               FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , AccruedInterest            FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , DailyInterest              FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MonthlyInterest            FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , AccruedAdjustment          FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , DailyAdjustment            FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MonthlyAdjustment          FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MarkToMarketRateYesterday  FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MarkToMarketValueYesterday FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MarkToMarketRateToday      FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MarkToMarketValueToday     FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , MacaulayDuration           FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , ModifiedDuration           FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , Convexidad                 FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       , CouponExpiryDate           DATETIME     NOT NULL DEFAULT ''\n";
                    _QueryRate += "       , DevelonmentTable           CHAR(01)     NOT NULL DEFAULT 'N'\n";
                    _QueryRate += "       , DataType                   CHAR(02)     NOT NULL DEFAULT '  '\n";
                    _QueryRate += "       , DataOperationType          CHAR(01)     NOT NULL DEFAULT ' '\n";
                    _QueryRate += "       , PaymentType                CHAR(01)     NOT NULL DEFAULT ' '\n";
                    _QueryRate += "       , PaymentCashFlow            FLOAT        NOT NULL DEFAULT 0\n";
                    _QueryRate += "       )\n\n";

                    #endregion

                    #region "Valida si se esta rescatando la cartera del día"

                    if (_DateProcess.Equals(portFolioDate))
                    {

                        #region "Cartera del Dia"

                        _QueryRate += "-- Cartera del Dia\n";

                        #region "Cartera Propia"

                        _QueryRate += "-- Cartera Propia\n";
                        _QueryRate += "INSERT INTO #tmpCartera\n";
                        _QueryRate += "       (\n";
                        _QueryRate += "              OperationNumber\n";
                        _QueryRate += "       ,      DocumentNumber\n";
                        _QueryRate += "       ,      OperationID\n";
                        _QueryRate += "       ,      OperationType\n";
                        _QueryRate += "       ,      CustomerID\n";
                        _QueryRate += "       ,      CustomerCode\n";
                        _QueryRate += "       ,      BookID\n";
                        _QueryRate += "       ,      PortfolioRulesID\n";
                        _QueryRate += "       ,      FinancialPortFolioID\n";
                        _QueryRate += "       ,      AccrualOperationType\n";
                        _QueryRate += "       ,      AccrualPortFolioID\n";
                        _QueryRate += "       ,      MNemonicsCode\n";
                        _QueryRate += "       ,      MNemonics\n";
                        _QueryRate += "       ,      MNemonicsMask\n";
                        _QueryRate += "       ,      Nominal\n";
                        _QueryRate += "       ,      PurchaseDate\n";
                        _QueryRate += "       ,      PaymentDate\n";
                        _QueryRate += "       ,      PurchaseRate\n";
                        _QueryRate += "       ,      PurchaseValue\n";
                        _QueryRate += "       ,      PurchaseValueUM\n";
                        _QueryRate += "       ,      PresentValue\n";
                        _QueryRate += "       ,      DataType\n";
                        _QueryRate += "       ,      DataOperationType\n";
                        _QueryRate += "       )\n";
                        _QueryRate += "       SELECT CP.cpnumdocu                            -- OperationNumber\n";
                        _QueryRate += "            , CP.cpnumdocu                            -- DocumentNumber\n";
                        _QueryRate += "            , CP.cpcorrela                            -- OperationID\n";
                        _QueryRate += "            , 'CP'                                    -- OperationType\n";
                        _QueryRate += "            , CP.cprutcli                             -- CustomerID\n";
                        _QueryRate += "            , CP.cpcodcli                             -- CustomerCode\n";
                        _QueryRate += "            , CP.id_libro                             -- BookID\n";
                        _QueryRate += "            , CP.codigo_carterasuper                  -- PortfolioRulesID\n";
                        _QueryRate += "            , CP.cptipcart                            -- FinancialPortFolioID\n";
                        _QueryRate += "            , 'CP'                                    -- AccrualOperationType\n";
                        _QueryRate += "            , '111'                                   -- AccrualPortFolioID\n";
                        _QueryRate += "            , CP.cpcodigo                             -- MNemonicsCode\n";
                        _QueryRate += "            , CP.cpinstser                            -- MNemonics\n";
                        _QueryRate += "            , CP.cpmascara                            -- MNemonicsMask\n";
                        _QueryRate += "            , CP.cpnominal                            -- Nominal\n";
                        _QueryRate += "            , CP.cpfeccomp                            -- PurchaseDate\n";
                        _QueryRate += "            , CP.fecha_pagomañana                     -- PaymentDate\n";
                        _QueryRate += "            , CP.cptircomp                            -- PurchaseRate\n";
                        _QueryRate += "            , CP.cpvalcomp                            -- PurchaseValue\n";
                        _QueryRate += "            , CP.cpvalcomu                            -- PurchaseValueUM\n";
                        _QueryRate += "            , CP.cpvptirc                             -- PresentValue\n";
                        _QueryRate += "            , 'CP'                                    -- DataType\n";
                        _QueryRate += "            , 'C'                                     -- DataOperationType\n";
                        _QueryRate += "         FROM dbo.mdcp CP\n";
                        _QueryRate += "        WHERE CP.cpnominal  > 0\n";
                        _QueryRate += "          AND CP.cpfeccomp <> @PortFolioDateToday\n\n";

                        #endregion

                        #region "Intermediación"

                        _QueryRate += "-- Cartera Intermediada\n";
                        _QueryRate += "INSERT INTO #tmpCartera\n";
                        _QueryRate += "       (\n";
                        _QueryRate += "              OperationNumber\n";
                        _QueryRate += "       ,      DocumentNumber\n";
                        _QueryRate += "       ,      OperationID\n";
                        _QueryRate += "       ,      OperationType\n";
                        _QueryRate += "       ,      CustomerID\n";
                        _QueryRate += "       ,      CustomerCode\n";
                        _QueryRate += "       ,      BookID\n";
                        _QueryRate += "       ,      PortfolioRulesID\n";
                        _QueryRate += "       ,      FinancialPortFolioID\n";
                        _QueryRate += "       ,      AccrualOperationType\n";
                        _QueryRate += "       ,      AccrualPortFolioID\n";
                        _QueryRate += "       ,      MNemonicsCode\n";
                        _QueryRate += "       ,      MNemonics\n";
                        _QueryRate += "       ,      MNemonicsMask\n";
                        _QueryRate += "       ,      Nominal\n";
                        _QueryRate += "       ,      PurchaseDate\n";
                        _QueryRate += "       ,      PaymentDate\n";
                        _QueryRate += "       ,      PurchaseRate\n";
                        _QueryRate += "       ,      PurchaseValue\n";
                        _QueryRate += "       ,      PurchaseValueUM\n";
                        _QueryRate += "       ,      PresentValue\n";
                        _QueryRate += "       ,      DataType\n";
                        _QueryRate += "       ,      DataOperationType\n";
                        _QueryRate += "       )\n";
                        _QueryRate += "       SELECT VI.vinumoper                            -- OperationNumber\n";
                        _QueryRate += "            , VI.vinumdocu                            -- DocumentNumber\n";
                        _QueryRate += "            , VI.vicorrela                            -- OperationID\n";
                        _QueryRate += "            , 'CP'                                    -- OperationType\n";
                        _QueryRate += "            , VI.virutcli                             -- CustomerID\n";
                        _QueryRate += "            , VI.vicodcli                             -- CustomerCode\n";
                        _QueryRate += "            , VI.id_libro                             -- BookID\n";
                        _QueryRate += "            , VI.codigo_carterasuper                  -- PortfolioRulesID\n";
                        _QueryRate += "            , VI.Tipo_Cartera_Financiera              -- FinancialPortFolioID\n";
                        _QueryRate += "            , 'VI'                                    -- AccrualOperationType\n";
                        _QueryRate += "            , '114'                                   -- AccrualPortFolioID\n";
                        _QueryRate += "            , VI.vicodigo                             -- MNemonicsCode\n";
                        _QueryRate += "            , VI.viinstser                            -- MNemonics\n";
                        _QueryRate += "            , VI.vimascara                            -- MNemonicsMask\n";
                        _QueryRate += "            , VI.vinominal                            -- Nominal\n";
                        _QueryRate += "            , VI.vifeccomp                            -- PurchaseDate\n";
                        _QueryRate += "            , VI.vifeccomp                            -- PaymentDate\n";
                        _QueryRate += "            , VI.vitircomp                            -- PurchaseRate\n";
                        _QueryRate += "            , VI.vivalcomp                            -- PurchaseValue\n";
                        _QueryRate += "            , VI.vivalcomu                            -- PurchaseValueUM\n";
                        _QueryRate += "            , VI.vivptirc                             -- PresentValue\n";
                        _QueryRate += "            , 'IN'                                    -- DataType\n";
                        _QueryRate += "            , 'C'                                     -- DataOperationType\n";
                        _QueryRate += "         FROM dbo.mdvi VI\n";
                        _QueryRate += "        WHERE VI.vitipoper = 'CP'\n\n";

                        #endregion

                        #region "Ventas del Día"

                        _QueryRate += "-- Ventas del Día\n";
                        _QueryRate += "INSERT INTO #tmpCartera\n";
                        _QueryRate += "       (\n";
                        _QueryRate += "              OperationNumber\n";
                        _QueryRate += "       ,      DocumentNumber\n";
                        _QueryRate += "       ,      OperationID\n";
                        _QueryRate += "       ,      OperationType\n";
                        _QueryRate += "       ,      CustomerID\n";
                        _QueryRate += "       ,      CustomerCode\n";
                        _QueryRate += "       ,      BookID\n";
                        _QueryRate += "       ,      PortfolioRulesID\n";
                        _QueryRate += "       ,      FinancialPortFolioID\n";
                        _QueryRate += "       ,      AccrualOperationType\n";
                        _QueryRate += "       ,      AccrualPortFolioID\n";
                        _QueryRate += "       ,      MNemonicsCode\n";
                        _QueryRate += "       ,      MNemonics\n";
                        _QueryRate += "       ,      MNemonicsMask\n";
                        _QueryRate += "       ,      Nominal\n";
                        _QueryRate += "       ,      PurchaseDate\n";
                        _QueryRate += "       ,      PaymentDate\n";
                        _QueryRate += "       ,      PurchaseRate\n";
                        _QueryRate += "       ,      PurchaseValue\n";
                        _QueryRate += "       ,      PurchaseValueUM\n";
                        _QueryRate += "       ,      SalesValue\n";
                        _QueryRate += "       ,      SalesValueUM\n";
                        _QueryRate += "       ,      PresentValue\n";
                        _QueryRate += "       ,      DataType\n";
                        _QueryRate += "       ,      DataOperationType\n";
                        _QueryRate += "       ,      PaymentType\n";
                        _QueryRate += "       ,      PaymentCashFlow\n";
                        _QueryRate += "       )\n";
                        _QueryRate += "       SELECT MO.monumoper                            -- OperationNumber\n";
                        _QueryRate += "            , MO.monumdocu                            -- DocumentNumber\n";
                        _QueryRate += "            , MO.mocorrela                            -- OperationID\n";
                        _QueryRate += "            , 'CP'                                    -- OperationType\n";
                        _QueryRate += "            , MO.morutcli                             -- CustomerID\n";
                        _QueryRate += "            , MO.mocodcli                             -- CustomerCode\n";
                        _QueryRate += "            , MO.id_libro                             -- BookID\n";
                        _QueryRate += "            , MO.codigo_carterasuper                  -- PortfolioRulesID\n";
                        _QueryRate += "            , MO.motipcart                            -- FinancialPortFolioID\n";
                        _QueryRate += "            , 'CP'                                    -- AccrualOperationType\n";
                        _QueryRate += "            , '111'                                   -- AccrualPortFolioID\n";
                        _QueryRate += "            , MO.mocodigo                             -- MNemonicsCode\n";
                        _QueryRate += "            , MO.moinstser                            -- MNemonics\n";
                        _QueryRate += "            , MO.momascara                            -- MNemonicsMask\n";
                        _QueryRate += "            , MO.monominal                            -- Nominal\n";
                        _QueryRate += "            , MO.fecha_compra_original                -- PurchaseDate\n";
                        _QueryRate += "            , MO.fecha_pagomañana                     -- PaymentDate\n";
                        _QueryRate += "            , MO.tir_compra_original                  -- PurchaseRate\n";
                        _QueryRate += "            , MO.movalcomp                            -- PurchaseValue\n";
                        _QueryRate += "            , MO.movalcomu                            -- PurchaseValueUM\n";
                        _QueryRate += "            , MO.movalven                             -- SalesValue\n";
                        _QueryRate += "            , MO.movalven / ISNULL( VM.vmvalor, 1.0 ) -- SalesValueUM\n";
                        _QueryRate += "            , MO.movpresen                            -- PresentValue\n";
                        _QueryRate += "            , 'MO'                                    -- DataType\n";
                        _QueryRate += "            , 'V'                                     -- DataOperationType\n";
                        _QueryRate += "            , MO.pagomañana                           -- PaymentType\n";
                        _QueryRate += "            , MO.movalven - MO.movalcomp              -- PaymentCashFlow\n";
                        _QueryRate += "         FROM dbo.mdmo MO\n";
                        _QueryRate += "              LEFT JOIN bacparamsuda..valor_moneda VM  ON VM.vmfecha  = MO.mofecpro\n";
                        _QueryRate += "                                                      AND VM.vmcodigo = MO.momonemi\n";
                        _QueryRate += "        WHERE MO.motipoper = 'VP'\n";
                        _QueryRate += "          AND MO.mostatreg <> 'A'\n\n";

                        #endregion

                        #endregion

                    }
                    else
                    {

                        #region "Cartera Historica"

                        _QueryRate += "-- Cartera Historica\n";

                        #region "Cartera Propia"

                        _QueryRate += "-- Cartera propia\n";
                        _QueryRate += "INSERT INTO #tmpCartera\n";
                        _QueryRate += "       (\n";
                        _QueryRate += "              OperationNumber\n";
                        _QueryRate += "       ,      DocumentNumber\n";
                        _QueryRate += "       ,      OperationID\n";
                        _QueryRate += "       ,      OperationType\n";
                        _QueryRate += "       ,      AccrualOperationType\n";
                        _QueryRate += "       ,      AccrualPortFolioID\n";
                        _QueryRate += "       ,      MNemonicsCode\n";
                        _QueryRate += "       ,      MNemonics\n";
                        _QueryRate += "       ,      MNemonicsMask\n";
                        _QueryRate += "       ,      Nominal\n";
                        _QueryRate += "       ,      PurchaseDate\n";
                        _QueryRate += "       ,      PaymentDate\n";
                        _QueryRate += "       ,      PurchaseRate\n";
                        _QueryRate += "       ,      PurchaseValue\n";
                        _QueryRate += "       ,      PurchaseValueUM\n";
                        _QueryRate += "       ,      PresentValue\n";
                        _QueryRate += "       ,      DataType\n";
                        _QueryRate += "       ,      DataOperationType\n";
                        _QueryRate += "       )\n";
                        _QueryRate += "       SELECT RM.rmnumoper                            -- OperationNumber\n";
                        _QueryRate += "            , RM.rmnumdocu                            -- DocumentNumber\n";
                        _QueryRate += "            , RM.rmcorrela                            -- OperationID\n";
                        _QueryRate += "            , 'CP'                                    -- OperationType\n";
                        _QueryRate += "            , RM.tipo_operacion                       -- AccrualOperationType\n";
                        _QueryRate += "            , '111'                                   -- AccrualPortFolioID\n";
                        _QueryRate += "            , RM.rmcodigo                             -- MNemonicsCode\n";
                        _QueryRate += "            , RM.rminstser                            -- MNemonics\n";
                        _QueryRate += "            , RM.tmmascara                            -- MNemonicsMask\n";
                        _QueryRate += "            , RM.valor_nominal                        -- Nominal\n";
                        _QueryRate += "            , CP.cpfeccomp                            -- PurchaseDate\n";
                        _QueryRate += "            , CP.fecha_pagomañana                     -- PaymentDate\n";
                        _QueryRate += "            , CP.cptircomp                            -- PurchaseRate\n";
                        _QueryRate += "            , CP.cpvalcomp                            -- PurchaseValue\n";
                        _QueryRate += "            , CP.cpvalcomu                            -- PurchaseValueUM\n";
                        _QueryRate += "            , RM.valor_presente                       -- PresentValue\n";
                        _QueryRate += "            , 'CP'                                    -- DataType\n";
                        _QueryRate += "            , 'C'                                     -- DataOperationType\n";
                        _QueryRate += "         FROM dbo.valorizacion_mercado RM\n";
                        _QueryRate += "              INNER JOIN dbo.mdcp      CP  ON cp.cpnumdocu  = rm.rmnumoper\n";
                        _QueryRate += "                                          AND cp.cpnumdocu  = rm.rmnumdocu\n";
                        _QueryRate += "                                          AND cp.cpcorrela  = rm.rmcorrela\n";
                        _QueryRate += "                                          AND cp.cpfeccomp <> @PortFolioDateToday\n";
                        _QueryRate += "        WHERE RM.fecha_valorizacion  = @PortFolioDateToday\n";
                        _QueryRate += "          AND RM.tipo_operacion      = 'CP'\n";

                        #endregion

                        #region "Cartera intermediada"

                        _QueryRate += "-- Cartera intermediada\n";
                        _QueryRate += "INSERT INTO #tmpCartera\n";
                        _QueryRate += "       (\n";
                        _QueryRate += "              OperationNumber\n";
                        _QueryRate += "       ,      DocumentNumber\n";
                        _QueryRate += "       ,      OperationID\n";
                        _QueryRate += "       ,      OperationType\n";
                        _QueryRate += "       ,      AccrualOperationType\n";
                        _QueryRate += "       ,      AccrualPortFolioID\n";
                        _QueryRate += "       ,      MNemonicsCode\n";
                        _QueryRate += "       ,      MNemonics\n";
                        _QueryRate += "       ,      MNemonicsMask\n";
                        _QueryRate += "       ,      Nominal\n";
                        _QueryRate += "       ,      PurchaseDate\n";
                        _QueryRate += "       ,      PaymentDate\n";
                        _QueryRate += "       ,      PurchaseRate\n";
                        _QueryRate += "       ,      PurchaseValue\n";
                        _QueryRate += "       ,      PurchaseValueUM\n";
                        _QueryRate += "       ,      PresentValue\n";
                        _QueryRate += "       ,      DataType\n";
                        _QueryRate += "       ,      DataOperationType\n";
                        _QueryRate += "       )\n";
                        _QueryRate += "       SELECT RM.rmnumoper                            -- OperationNumber\n";
                        _QueryRate += "            , RM.rmnumdocu                            -- DocumentNumber\n";
                        _QueryRate += "            , RM.rmcorrela                            -- OperationID\n";
                        _QueryRate += "            , 'CP'                                    -- OperationType\n";
                        _QueryRate += "            , RM.tipo_operacion                       -- AccrualOperationType\n";
                        _QueryRate += "            , '114'                                   -- AccrualPortFolioID\n";
                        _QueryRate += "            , RM.rmcodigo                             -- MNemonicsCode\n";
                        _QueryRate += "            , RM.rminstser                            -- MNemonics\n";
                        _QueryRate += "            , RM.tmmascara                            -- MNemonicsMask\n";
                        _QueryRate += "            , RM.valor_nominal                        -- Nominal\n";
                        _QueryRate += "            , CP.cpfeccomp                            -- PurchaseDate\n";
                        _QueryRate += "            , CP.fecha_pagomañana                     -- PaymentDate\n";
                        _QueryRate += "            , CP.cptircomp                            -- PurchaseRate\n";
                        _QueryRate += "            , CP.cpvalcomp                            -- PurchaseValue\n";
                        _QueryRate += "            , CP.cpvalcomu                            -- PurchaseValueUM\n";
                        _QueryRate += "            , RM.valor_presente                       -- PresentValue\n";
                        _QueryRate += "            , 'IN'                                    -- DataType\n";
                        _QueryRate += "            , 'C'                                     -- DataOperationType\n";
                        _QueryRate += "         FROM dbo.valorizacion_mercado RM\n";
                        _QueryRate += "              INNER JOIN dbo.mdcp      CP  ON cp.cpnumdocu = rm.rmnumdocu\n";
                        _QueryRate += "                                          AND cp.cpcorrela = rm.rmcorrela\n";
                        _QueryRate += "        WHERE RM.fecha_valorizacion  = @PortFolioDateToday\n";
                        _QueryRate += "          AND RM.tipo_operacion     <> 'CP'\n\n";

                        #endregion

                        #region "Ventas del Día"

                        _QueryRate += "-- Ventas del Día\n";
                        _QueryRate += "INSERT INTO #tmpCartera\n";
                        _QueryRate += "       (\n";
                        _QueryRate += "              OperationNumber\n";
                        _QueryRate += "       ,      DocumentNumber\n";
                        _QueryRate += "       ,      OperationID\n";
                        _QueryRate += "       ,      OperationType\n";
                        _QueryRate += "       ,      CustomerID\n";
                        _QueryRate += "       ,      CustomerCode\n";
                        _QueryRate += "       ,      BookID\n";
                        _QueryRate += "       ,      PortfolioRulesID\n";
                        _QueryRate += "       ,      FinancialPortFolioID\n";
                        _QueryRate += "       ,      AccrualOperationType\n";
                        _QueryRate += "       ,      AccrualPortFolioID\n";
                        _QueryRate += "       ,      MNemonicsCode\n";
                        _QueryRate += "       ,      MNemonics\n";
                        _QueryRate += "       ,      MNemonicsMask\n";
                        _QueryRate += "       ,      Nominal\n";
                        _QueryRate += "       ,      PurchaseDate\n";
                        _QueryRate += "       ,      PaymentDate\n";
                        _QueryRate += "       ,      PurchaseRate\n";
                        _QueryRate += "       ,      PurchaseValue\n";
                        _QueryRate += "       ,      PurchaseValueUM\n";
                        _QueryRate += "       ,      SalesValue\n";
                        _QueryRate += "       ,      SalesValueUM\n";
                        _QueryRate += "       ,      PresentValue\n";
                        _QueryRate += "       ,      DataType\n";
                        _QueryRate += "       ,      DataOperationType\n";
                        _QueryRate += "       ,      PaymentType\n";
                        _QueryRate += "       ,      PaymentCashFlow\n";
                        _QueryRate += "       )\n";
                        _QueryRate += "       SELECT MH.monumoper                            -- OperationNumber\n";
                        _QueryRate += "            , MH.monumdocu                            -- DocumentNumber\n";
                        _QueryRate += "            , MH.mocorrela                            -- OperationID\n";
                        _QueryRate += "            , 'CP'                                    -- OperationType\n";
                        _QueryRate += "            , MH.morutcli                             -- CustomerID\n";
                        _QueryRate += "            , MH.mocodcli                             -- CustomerCode\n";
                        _QueryRate += "            , MH.moid_libro                           -- BookID\n";
                        _QueryRate += "            , MH.codigo_carterasuper                  -- PortfolioRulesID\n";
                        _QueryRate += "            , MH.motipcart                            -- FinancialPortFolioID\n";
                        _QueryRate += "            , 'CP'                                    -- AccrualOperationType\n";
                        _QueryRate += "            , '111'                                   -- AccrualPortFolioID\n";
                        _QueryRate += "            , MH.mocodigo                             -- MNemonicsCode\n";
                        _QueryRate += "            , MH.moinstser                            -- MNemonics\n";
                        _QueryRate += "            , MH.momascara                            -- MNemonicsMask\n";
                        _QueryRate += "            , MH.monominal                            -- Nominal\n";
                        _QueryRate += "            , MH.fecha_compra_original                -- PurchaseDate\n";
                        _QueryRate += "            , MH.fecha_pagomañana                     -- PaymentDate\n";
                        _QueryRate += "            , MH.tir_compra_original                  -- PurchaseRate\n";
                        _QueryRate += "            , MH.movalcomp                            -- PurchaseValue\n";
                        _QueryRate += "            , MH.movalcomu                            -- PurchaseValueUM\n";
                        _QueryRate += "            , MH.movalven                             -- SalesValue\n";
                        _QueryRate += "            , MH.movalven / ISNULL( VM.vmvalor, 1.0 ) -- SalesValueUM\n";
                        _QueryRate += "            , MH.movpresen                            -- PresentValue\n";
                        _QueryRate += "            , 'MO'                                    -- DataType\n";
                        _QueryRate += "            , 'V'                                     -- DataOperationType\n";
                        _QueryRate += "            , MH.pagomañana                           -- PaymentType\n";
                        _QueryRate += "            , MH.movalven - MH.movalcomp              -- PaymentCashFlow\n";
                        _QueryRate += "         FROM dbo.mdmh MH\n";
                        _QueryRate += "              LEFT JOIN bacparamsuda..valor_moneda VM  ON VM.vmfecha  = MH.mofecpro\n";
                        _QueryRate += "                                                      AND VM.vmcodigo = MH.momonemi\n";
                        _QueryRate += "        WHERE MH.mofecpro   = @PortFolioDateToday\n";
                        _QueryRate += "          AND MH.motipoper  = 'VP'\n";
                        _QueryRate += "          AND MH.mostatreg <> 'A'\n\n";

                        #endregion

                        #endregion

                    }

                    #endregion

                    #region "Actualización de Datos Instrumentos"

                    _QueryRate += "-- Actualización de Datos Instrumentos\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET FamilyID         = inserie\n";
                    _QueryRate += "     , DevelonmentTable = inmdse\n";
                    _QueryRate += "  FROM BACPARAMSUDA.dbo.INSTRUMENTO\n";
                    _QueryRate += " WHERE MNemonicsCode    = incodigo\n\n";

                    #endregion

                    #region "Actualización de Resultado"

                    _QueryRate += "-- Actualización de Resultado\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET CurrencyIssueID      = RS.rsmonemi\n";
                    _QueryRate += "     , IssueCode            = RS.rsrutemis\n";
                    _QueryRate += "     , IssueDate            = RS.rsfecemis\n";
                    _QueryRate += "     , ExpiryDate           = RS.rsfecvcto\n";
                    _QueryRate += "     , AccruedInterest      = ROUND( RS.rsreajuste_acum * (nominal / RS.rsnominal), 0 )\n";
                    _QueryRate += "     , DailyInterest        = ROUND( RS.rsinteres * (nominal / RS.rsnominal), 0 )\n";
                    _QueryRate += "     , MonthlyInterest      = ROUND( RS.rsintermes * (nominal / RS.rsnominal), 0 )\n";
                    _QueryRate += "     , AccruedAdjustment    = ROUND( RS.rsreajuste_acum * (nominal / RS.rsnominal), 0 )\n";
                    _QueryRate += "     , DailyAdjustment      = ROUND( RS.rsreajuste * (nominal / RS.rsnominal), 0 )\n";
                    _QueryRate += "     , MonthlyAdjustment    = ROUND( RS.rsreajumes * (nominal / RS.rsnominal), 0 )\n";
                    _QueryRate += "     , MacaulayDuration     = RS.rsdurat\n";
                    _QueryRate += "     , ModifiedDuration     = RS.rsdurmod\n";
                    _QueryRate += "     , Convexidad           = RS.rsconvex\n";
                    _QueryRate += "     , CouponExpiryDate     = RS.rsfecpcup\n";
                    _QueryRate += "     , CustomerID           = RS.rsrutcli\n";
                    _QueryRate += "     , CustomerCode         = RS.rscodcli\n";
                    _QueryRate += "     , BookID               = RS.rsid_libro\n";
                    _QueryRate += "     , PortfolioRulesID     = RS.codigo_carterasuper\n";
                    _QueryRate += "     , FinancialPortFolioID = RS.rstipcart\n";
                    _QueryRate += "     , PurchaseDate         = RS.rsfeccomp\n";
                    _QueryRate += "     , PurchaseRate         = RS.rstir\n";
                    _QueryRate += "     , PurchaseValue        = RS.rsvalcomp\n";
                    _QueryRate += "     , PurchaseValueUM      = RS.rsvalcomu\n";
                    _QueryRate += "  FROM dbo.MDRS RS\n";
                    _QueryRate += " WHERE RS.rsfecha           = @MarkToMarketToday\n";
                    _QueryRate += "   AND RS.rstipopero        = AccrualOperationType\n";
                    _QueryRate += "   AND RS.rscartera         = AccrualPortFolioID\n";
                    _QueryRate += "   AND RS.rstipoper         = 'DEV'\n";
                    _QueryRate += "   AND RS.rsnumdocu         = DocumentNumber\n";
                    _QueryRate += "   AND RS.rsnumoper         = OperationNumber\n";
                    _QueryRate += "   AND RS.rscorrela         = OperationID\n";
                    _QueryRate += "   AND PaymentDate         <= @MarkToMarketToday\n\n";

                    #endregion

                    #region "Actualización de serie para ventas del día"

                    _QueryRate += "-- Actualización de serie para ventas del día\n";

                    #region "Actualización de Instrumentos Seriados"

                    _QueryRate += "-- Actualización de Instrumentos Seriados\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET CurrencyIssueID      = SE.semonemi\n";
                    _QueryRate += "     , IssueCode            = SE.serutemi\n";
                    _QueryRate += "  FROM bacparamsuda..serie SE\n";
                    _QueryRate += " WHERE semascara            = MNemonicsMask\n";
                    _QueryRate += "   AND DataType             = 'MO'\n";
                    _QueryRate += "   AND DevelonmentTable     = 'S'\n\n";

                    #endregion

                    #region "Actualización de Instrumentos No Serieados"

                    _QueryRate += "-- Actualización de Instrumentos No Seriado\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET CurrencyIssueID      = NS.nsmonemi\n";
                    _QueryRate += "     , IssueCode            = NS.nsrutemi\n";
                    _QueryRate += "  FROM bacparamsuda..noserie NS\n";
                    _QueryRate += " WHERE NS.nsnumdocu         = DocumentNumber\n";
                    _QueryRate += "   AND NS.nscorrela         = OperationID\n";
                    _QueryRate += "   AND DataType             = 'MO'\n";
                    _QueryRate += "   AND DevelonmentTable     = 'N'\n\n";

                    #endregion

                    #endregion

                    #region "Actualización de datos BR"

                    _QueryRate += "-- Actualización de datos BR\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET CurrencyIssueID      = inmonemi\n";
                    _QueryRate += "     , IssueCode            = inrutemi\n";
                    _QueryRate += "  FROM bacparamsuda.dbo.INSTRUMENTO\n";
                    _QueryRate += " WHERE incodigo             = 888\n";
                    _QueryRate += "   AND incodigo             = MNemonicsCode\n\n";

                    #endregion

                    #region "Actualización libro, cartera normativa y cartera financiera"

                    _QueryRate += "-- Actualización libro, cartera normativa y cartera financiera\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET IssueDate            = CP.cpfecemi\n";
                    _QueryRate += "     , ExpiryDate           = CP.cpfecven\n";
                    _QueryRate += "     , BookID               = CP.id_libro\n";
                    _QueryRate += "     , PortfolioRulesID     = CP.codigo_carterasuper\n";
                    _QueryRate += "     , FinancialPortFolioID = CP.cptipcart\n";
                    _QueryRate += "  FROM dbo.MDCP CP\n";
                    _QueryRate += " WHERE CP.cpnumdocu         = DocumentNumber\n";
                    _QueryRate += "   AND CP.cpcorrela         = OperationID\n\n";

                    #endregion

                    #region "Actualización de Fecha de Vencimiento para las operaciones del día"

                    _QueryRate += "-- Actualización de Fecha de Vencimiento para las operaciones del día\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET CouponExpiryDate     = ExpiryDate\n";
                    _QueryRate += " WHERE DataType             = 'MO'\n";

                    #endregion

                    #region "Actualización tasa de mercado"

                    _QueryRate += "-- Actualización tasa de mercado\n";
                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET MarkToMarketRateToday      = PurchaseRate\n";
                    _QueryRate += "     , MarkToMarketValueToday     = PurchaseValue\n";
                    _QueryRate += "     , MarkToMarketRateYesterday  = PurchaseRate\n";
                    _QueryRate += "     , MarkToMarketValueYesterday = PurchaseValue\n\n";

                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET MarkToMarketRateToday      = tasa_mercado\n";
                    _QueryRate += "     , MarkToMarketValueToday     = round( valor_mercado * nominal / valor_nominal, 0 )\n";
                    _QueryRate += "  FROM dbo.VALORIZACION_MERCADO\n";
                    _QueryRate += " WHERE fecha_valorizacion         = @MarkToMarketToday\n";
                    _QueryRate += "   AND rmnumdocu                  = DocumentNumber\n";
                    _QueryRate += "   AND rmnumoper                  = OperationNumber\n";
                    _QueryRate += "   AND rmcorrela                  = OperationID\n\n";

                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET MarkToMarketRateYesterday  = tasa_mercado\n";
                    _QueryRate += "     , MarkToMarketValueYesterday = valor_mercado\n";
                    _QueryRate += "  FROM dbo.VALORIZACION_MERCADO\n";
                    _QueryRate += " WHERE fecha_valorizacion         = @MarkToMarketYesterday\n";
                    _QueryRate += "   AND rmnumdocu                  = DocumentNumber\n";
                    _QueryRate += "   AND rmnumoper                  = OperationNumber\n";
                    _QueryRate += "   AND rmcorrela                  = OperationID\n\n";

                    #endregion

                    #region "Rescate de Tasa Mercado Ayer para las Ventas"

                    _QueryRate += "UPDATE #tmpCartera\n";
                    _QueryRate += "   SET MarkToMarketRateYesterday  = tasa_mercado\n";
                    _QueryRate += "     , MarkToMarketValueYesterday = valor_mercado\n";
                    _QueryRate += "  FROM dbo.VALORIZACION_MERCADO\n";
                    _QueryRate += " WHERE fecha_valorizacion         = @MarkToMarketYesterday\n";
                    _QueryRate += "   AND rmnumdocu                  = DocumentNumber\n";
                    _QueryRate += "   AND rmnumoper                  = DocumentNumber\n";
                    _QueryRate += "   AND rmcorrela                  = OperationID\n";
                    _QueryRate += "   AND DataType                   = 'MO'\n";
                    _QueryRate += "   AND DataOperationType          = 'V'\n\n";

                    #endregion

                    _QueryRate += "SELECT *\n";
                    _QueryRate += "  FROM #tmpCartera\n\n";

                    _QueryRate += "DROP TABLE #tmpCartera\n\n";

                    _QueryRate += "SET NOCOUNT OFF\n\n";

                    _QueryRate = _QueryRate.Replace("[@PortFolioDate]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");
                    _QueryRate = _QueryRate.Replace("[@MarkToMarketToday]", "'" + martkToMarketRateToday.ToString("yyyyMMdd") + "'");
                    _QueryRate = _QueryRate.Replace("[@MarkToMarketRateYesterday]", "'" + markToMarketRateYesterday.ToString("yyyyMMdd") + "'");

                    #endregion

                    cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACTRADERSUDA");

                    try
                    {
                        // Definición de la Curva
                        Status = enumStatus.Loading;
                        _Connect.Execute(_QueryRate);
                        _FixingRatePortFolio = _Connect.QueryDataTable();
                        _FixingRatePortFolio.TableName = "FixingRatePortFolio";

                        if (_FixingRatePortFolio.Rows.Count.Equals(0))
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
                        _FixingRatePortFolio = null;
                        Status = enumStatus.ErrorLoad;
                        Error = _Error.StackTrace;
                        Stack = _Error.Message;
                    }
                }
                else
                {
                    _FixingRatePortFolio = null;
                }

                return _FixingRatePortFolio;
            }

            private DateTime LoadDate()
            {

                String _QueryRate = "SELECT 'Date' = acfecproc FROM dbo.mdac";
                DateTime _Date = new DateTime(1900, 1, 1); ;

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACTRADERSUDA");
                DataTable _FixingRatePortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _FixingRatePortFolio = _Connect.QueryDataTable();
                    _FixingRatePortFolio.TableName = "FixingRatePortFolio";

                    if (_FixingRatePortFolio.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        _Date = DateTime.Parse(_FixingRatePortFolio.Rows[0]["Date"].ToString());
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _FixingRatePortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                _FixingRatePortFolio.Dispose();

                return _Date;

            }

            private DataTable LoadTPMRate(DateTime portFolioDate)
            {

                String _QueryIndex = "";

                #region "Query Load Index Forward Rate Fixing"

                _QueryIndex = "";
                _QueryIndex += "SET NOCOUNT ON\n\n";

                _QueryIndex += "DECLARE @DateProcess                    DATETIME\n";

                _QueryIndex += "SET @DateProcess = [@DateProcess]\n\n";

                _QueryIndex += "SELECT TOP 1\n";
                _QueryIndex += "       'Date'     = vmfecha\n";
                _QueryIndex += "     , 'TPMRate'  = vmvalor\n";
                _QueryIndex += "  FROM BacParamSuda.dbo.VALOR_MONEDA WITH(NOLOCK)\n";
                _QueryIndex += " WHERE vmcodigo   = 807\n";
                _QueryIndex += "   AND vmfecha   <= @DateProcess\n";
                _QueryIndex += "   AND vmvalor   <> 0\n";
                _QueryIndex += " ORDER BY vmfecha DESC\n\n";

                _QueryIndex += "SET NOCOUNT OFF\n";

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
                    _IndexValueForwardFixingRate.TableName = "TPMrate";

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

            // Considerar la carga de flujos e instrumento en segunda fase

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


