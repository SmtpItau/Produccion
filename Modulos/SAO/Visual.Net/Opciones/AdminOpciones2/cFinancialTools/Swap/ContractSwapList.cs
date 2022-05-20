using System;
using System.Collections;
using System.Text;
using System.Data;
using cFinancialTools.Swap;
using cFinancialTools.Valuation;
using cFinancialTools.Struct;
using cFinancialTools.Yield;
using cFinancialTools.Currency;
using cFinancialTools.Rate;
using cData.PortFolio;


namespace cFinancialTools.Swap
{

    public class ContractSwapList
    {

        #region "Atributos Protegidos"

        private DateTime mPortFolioDate;
        private Hashtable mList;
        private cFinancialTools.BussineDate.Calendars mCalendars;

        #endregion

        #region "Constructor"

        public ContractSwapList()
        {
            mList = new Hashtable();
            mCalendars = new cFinancialTools.BussineDate.Calendars();
            mCalendars.Load();
        }

        #endregion

        #region "Propiedades"

        public DateTime PortFolioDate
        {
            get
            {
                return mPortFolioDate;
            }
            set
            {
                mPortFolioDate = value;
            }
        }

        public int Count
        {
            get
            {
                return mList.Count;
            }
        }

        #endregion

        #region "Metodos publicas"

        #region "Status (Falta Revisar esta seccion)"

        public enumStatus Status(String id)
        {
            return enumStatus.Already;
        }

        public enumStatus Status(String id, enumSource sourceID)
        {
            return enumStatus.Already;
        }

        public enumStatus Status(String id, enumSource sourceID, DateTime date)
        {
            return enumStatus.Already;
        }

        public String Message(String id)
        {
            return "";
        }

        public String Message(String id, enumSource sourceID)
        {
            return "";
        }

        public String Message(String id, enumSource sourceID, DateTime date)
        {
            return "";
        }

        #endregion

        #region "LOAD"

        public bool Load(int operationNumber)
        {

            bool _Status = false;

            //Yield _Yield = new Yield();
            //YieldSource _YieldSource = new YieldSource();
            //bool _CheckDate = false;
            //DateTime _Date = dateRateFrom;

            //try
            //{
            //    if (!Find(id))
            //    {
            //        _Yield = LoadYield(id);
            //    }
            //    else
            //    {
            //        _Yield = Read(id);
            //    }

            //    if (!_Yield.Find(sourceID))
            //    {
            //        _Yield.Generate = generate;
            //        _Yield.Add(sourceID);
            //    }

            //    _YieldSource = (YieldSource)_Yield.Read(sourceID);

            //    while (_Date <= dateRateTo)
            //    {
            //        if (!_YieldSource.Find(_Date))
            //        {
            //            _CheckDate = true;
            //            break;
            //        }
            //        _Date = _Date.AddDays(1);
            //    }

            //    if (_CheckDate == true)
            //    {
            //        LoadYieldValue(id, generate, interpolateType, sourceID, dateRateFrom, dateRateTo);
            //    }
            //}
            //catch (Exception Error)
            //{
            //    mMessage = Error.Message;
            //    mStack = Error.StackTrace;
            //    _Status = false;
            //}

            return _Status;

        }

        #endregion

        #region "Find"

        public bool Find(int operationNumber)
        {
            String _ID = operationNumber.ToString();
            ContractSwap _ContractSwap = new ContractSwap(mCalendars);
            bool _Status = true;

            _ContractSwap = (ContractSwap)mList[_ID];

            if (_ContractSwap == null)
            {
                _Status = false;
            }

            return _Status;
        }

        #endregion

        #region "READ"

        public ContractSwap Read(int operationNumber)
        {
            String _ID = operationNumber.ToString();
            ContractSwap _ContractSwap = new ContractSwap(mCalendars);

            if (Find(operationNumber))
            {
                _ContractSwap = (ContractSwap)mList[_ID];
            }

            return _ContractSwap;
        }

        #endregion

        #region "READALL"

        public Hashtable ReadAll()
        {
            return mList;
        }

        #endregion

        #endregion

        #region "Metodos Publicos"

        public void Load(
                          DateTime portFolioDate, 
                          DataRow portFolioRow,
                          DataTable portFolioFlow,
                          YieldList yieldList,
                          CurrencyList currencyList,
                          RateList rateList
                        )
        {

            #region "Definición de Variables"

            ContractSwap _ContractSwap;
            int _OperationNumber;
            String _ID;
            cData.PortFolio.PortFolioSwap _PortFolio;
            DateTime _StartingDate;
            DateTime _ExpiryDate;
            double _AssetPresentValue;
            double _LiabilitiesPresentValue;
            int _ResetDays;

            int _RateID;
            int _CurrencyID;
            int _TermBenchmark;
            int _HolidayChile;
            int _HolidayEEUU;
            int _HolidayEnglan;
            string _YieldNameProjected;
            string _YieldnameDiscount;

            #endregion

            #region "Inicialización de Variables"

            _ContractSwap = new ContractSwap(mCalendars);
            _OperationNumber = int.Parse(portFolioRow["OperationNumber"].ToString());
            _ID = _OperationNumber.ToString();
            _PortFolio = new cData.PortFolio.PortFolioSwap();

            _RateID = 0;
            _CurrencyID = 0;
            _TermBenchmark = 0;

            #endregion

            mPortFolioDate = portFolioDate;

            _ContractSwap.OperationNumber = _OperationNumber;
            _StartingDate = (DateTime)portFolioRow["StartingDate"];
            _ExpiryDate = (DateTime)portFolioRow["ExpiryDate"];
            _AssetPresentValue = double.Parse(portFolioRow["AssetMarketAmountUM"].ToString());
            _LiabilitiesPresentValue = double.Parse(portFolioRow["LiabilitiesMarketAmountUM"].ToString());

            // Pierna Activa
            DataRow[] _AssetFlowData;
            SwapValuation _AssetFlowSwapLeg = new SwapValuation(mCalendars);

            _RateID = int.Parse(portFolioRow["AssetRateID"].ToString());
            _CurrencyID = int.Parse(portFolioRow["AssetCurrency"].ToString());
            _ResetDays = int.Parse(portFolioRow["AssetResetDays"].ToString());
            _YieldNameProjected = portFolioRow["SwapYieldAssetProject"].ToString();
            _YieldnameDiscount = portFolioRow["SwapYieldAssetDiscount"].ToString();
            _TermBenchmark = int.Parse(portFolioRow["TermBenchmarkP1"].ToString());

            _HolidayChile = int.Parse(portFolioRow["AssetHolidayFlowChile"].ToString());
            _HolidayEEUU = int.Parse(portFolioRow["AssetHolidayFlowEEUU"].ToString());
            _HolidayEnglan = int.Parse(portFolioRow["AssetHolidayFlowEnglan"].ToString());

            _AssetFlowData = portFolioFlow.Select("OperationNumber = " + _OperationNumber.ToString() + " AND FlowType = 1");
            _AssetFlowSwapLeg = SettingFlowSwap(
                                                  portFolioDate,
                                                  _AssetFlowData,
                                                  _RateID,
                                                  _CurrencyID,
                                                  _YieldNameProjected,
                                                  _YieldnameDiscount,
                                                  _TermBenchmark,
                                                  _ResetDays,
                                                  yieldList,
                                                  currencyList,
                                                  rateList,
                                                  _StartingDate,
                                                  _ExpiryDate,
                                                  _HolidayChile,
                                                  _HolidayEEUU,
                                                  _HolidayEnglan
                                                );

            _ContractSwap.AssetLeg = _AssetFlowSwapLeg;
            _ContractSwap.AssetPresentValue = _AssetPresentValue;


            // Pierna Pasiva
            DataRow[] _LiabilitiesFlowData;
            SwapValuation _LiabilitiesFlowSwapLeg = new SwapValuation(mCalendars);

            _RateID = int.Parse(portFolioRow["LiabilitiesRateID"].ToString());
            _CurrencyID = int.Parse(portFolioRow["LiabilitiesCurrency"].ToString());
            _ResetDays = int.Parse(portFolioRow["LiabilitiesResetDays"].ToString());
            _YieldNameProjected = portFolioRow["SwapYieldLiabilitiesProject"].ToString();
            _YieldnameDiscount = portFolioRow["SwapYieldLiabilitiesDiscount"].ToString();
            _TermBenchmark = int.Parse(portFolioRow["TermBenchmarkP2"].ToString());
            _HolidayChile = int.Parse(portFolioRow["LiabilitiesHolidayFlowChile"].ToString());
            _HolidayEEUU = int.Parse(portFolioRow["LiabilitiesHolidayFlowEEUU"].ToString());
            _HolidayEnglan = int.Parse(portFolioRow["LiabilitiesHolidayFlowEnglan"].ToString());
            
            _LiabilitiesFlowData = portFolioFlow.Select("OperationNumber = " + _OperationNumber.ToString() + " AND FlowType = 2");
            _LiabilitiesFlowSwapLeg = SettingFlowSwap(
                                                       portFolioDate,
                                                       _LiabilitiesFlowData,
                                                       _RateID,
                                                       _CurrencyID,
                                                       _YieldNameProjected,
                                                       _YieldnameDiscount,
                                                       _TermBenchmark,
                                                       _ResetDays,
                                                       yieldList,
                                                       currencyList,
                                                       rateList,
                                                       _StartingDate,
                                                       _ExpiryDate,
                                                       _HolidayChile,
                                                       _HolidayEEUU,
                                                       _HolidayEnglan
                                                     );

            _ContractSwap.LiabilitiesLeg = _LiabilitiesFlowSwapLeg;
            _ContractSwap.LiabilitiesPresentValue = _LiabilitiesPresentValue;

            mList.Add(_ID, _ContractSwap);

        }

        #endregion

        #region "Metodos Protegidos"

        protected SwapValuation SettingFlowSwap(
                                                  DateTime portFolioDate,
                                                  DataRow[] flowSwapData,
                                                  int rateID,
                                                  int currencyID,
                                                  string yieldProjectedID,
                                                  string yieldDiscountID,
                                                  int termBenchmark,
                                                  int resetDays,
                                                  YieldList yieldList,
                                                  CurrencyList currencyList,
                                                  RateList rateList,
                                                  DateTime startingDate,
                                                  DateTime expiryDate,
                                                  int holidayChile,
                                                  int holidayEEUU,
                                                  int holidayEnglan
                                               )
        {

            #region "Definición de Variables"

            SwapValuation _SwapValuation;
            SwapLeg _SwapLeg;
            StructDevelopmentTable _Flow;
            int _Row;
            cFinancialTools.DayCounters.Basis _Basis;
            enumBasis _ConventionBasis;
            DataRow _FlowDataRow;
            int _BasisID;
            double _Spread;

            #endregion

            #region "Inicialización de Variables"

            _SwapValuation = new SwapValuation(mCalendars);
            _SwapLeg = new SwapLeg();
            _Flow = new StructDevelopmentTable();
            _Basis = new cFinancialTools.DayCounters.Basis();
            _BasisID = 0;
            _Spread = 0;

            #endregion

            #region "Definición de los Flujos"

            _FlowDataRow = flowSwapData[0];

            _BasisID = int.Parse(_FlowDataRow["BaseID"].ToString());
            _Spread = double.Parse(_FlowDataRow["Spread"].ToString());

            _SwapLeg.CreatingCalendar = mCalendars;
            _SwapLeg.PaymentCalendar = mCalendars;
            _SwapLeg.FixingCalendar = mCalendars;

            _SwapLeg.TransactionsDate = portFolioDate;

            _SwapLeg.StartingDate = startingDate;
            _SwapLeg.ExpiryDate = expiryDate;

            if (rateID.Equals(0))
            {
                _SwapLeg.FlagFixedFloating = enumFlagFixedFloating.Fixed;
            }
            else
            {
                _SwapLeg.FlagFixedFloating = enumFlagFixedFloating.Floating;
            }

            _SwapLeg.InitialExchangeNotional = enumExchangeNotional.Yes;
            _SwapLeg.IntermediateExchangeNotional = enumExchangeNotional.Yes;
            _SwapLeg.ExchangeNotionalEnd = enumExchangeNotional.Yes;

            _SwapLeg.FixedRateEnd = double.Parse(_FlowDataRow["RateValueToday"].ToString());
            _SwapLeg.TransferFixedRate = 0;

            switch (_BasisID)
            {
                case 1:
                    _SwapLeg.BasisFixedRate = enumBasis.Basis_Act_Act;
                    break;
                case 2:
                    _SwapLeg.BasisFixedRate = enumBasis.Basis_Act_360;
                    break;
                case 3:
                    _SwapLeg.BasisFixedRate = enumBasis.Basis_30E_365;
                    break;
                case 4:
                    _SwapLeg.BasisFixedRate = enumBasis.Basis_30E_360;
                    break;
                case 5:
                    _SwapLeg.BasisFixedRate = enumBasis.Basis_30E_365;
                    break;
                default:
                    _SwapLeg.BasisFixedRate = enumBasis.Basis_Act_360;
                    break;
            }

            _SwapLeg.SpreadFlotanteEnd = _Spread; ;
            _SwapLeg.TransferSpreadFlotante = 0;
            _SwapLeg.BasisSpreadFlotante = _SwapLeg.BasisFixedRate;
            _SwapLeg.AditionalsFlowValue = 0;
            _SwapLeg.AditionalsFlowDate = portFolioDate;
            _SwapLeg.FlagValuator = enumFlagMartTOMarketFixingRate.RateToday;

            _ConventionBasis = _SwapLeg.BasisFixedRate;

            for (_Row = 0; _Row < flowSwapData.Length; _Row++)
            {

                _FlowDataRow = flowSwapData[_Row];

                _Flow = new StructDevelopmentTable();

                _Flow.NumberFlow = int.Parse(_FlowDataRow["FlowID"].ToString());
                _Flow.StartingDate = (DateTime)(_FlowDataRow["StartingDate"]);
                _Flow.ExpiryDate = (DateTime)(_FlowDataRow["ExpiryDate"]);
                _Flow.PaymentDate = (DateTime)(_FlowDataRow["PaymentDate"]);
                _Flow.FixingDate = (DateTime)(_FlowDataRow["FixingDate"]);
                _Flow.Amortization = double.Parse(_FlowDataRow["Amortization"].ToString());
                _Flow.Interest = double.Parse(_FlowDataRow["Interest"].ToString());
                _Flow.Flow = _Flow.Amortization + _Flow.Interest;

                _Basis = new cFinancialTools.DayCounters.Basis(_ConventionBasis, _Flow.StartingDate, _Flow.ExpiryDate);
                _Flow.Term = _Basis.Term;
                _Flow.TermBasis = _Basis.TermBasis;

                _Flow.BalanceResidual = double.Parse(_FlowDataRow["Balance"].ToString());
                _Flow.ExchangeNotional = 0;
                _Flow.FixedRateEnd = double.Parse(_FlowDataRow["RateValueToday"].ToString());
                _Flow.FixedRateEndYesterday = double.Parse(_FlowDataRow["RateValueYesterday"].ToString());

                _Flow.TransferFixedRate = 0;
                _Flow.SpreadFlotanteEnd = double.Parse(_FlowDataRow["Spread"].ToString());
                _Flow.TransferSpreadFlotante = 0;
                _Flow.InterestTransfer = 0;

                if (int.Parse(_FlowDataRow["ExchangePrincipal"].ToString()).Equals(1))
                {
                    _Flow.ExchangeNotionalType = enumExchangeNotional.Yes;
                }
                else
                {
                    _Flow.ExchangeNotionalType = enumExchangeNotional.Not;
                }

                _Flow.ExchangeInterestType = enumExchangeNotional.Yes;
                _Flow.AditionalsFlowValue = double.Parse(_FlowDataRow["AditionalFlow"].ToString()); ;
                _Flow.AditionalsFlow = 0;
                _Flow.AditionalsFlowConvertion = 0;
                _Flow.AditionalsFlowDate = portFolioDate;

                _SwapLeg.add(_Flow);

            }

            #endregion

            #region "Definición de los Datos de Cabecera de la pierna"

            _SwapValuation = new SwapValuation(mCalendars);

            _SwapValuation.Flow = _SwapLeg;
            _SwapValuation.RateID = rateID;
            _SwapValuation.SourceID = enumSource.System;
            _SwapValuation.PeriodID = enumPeriod.Anual;
            _SwapValuation.CurrencyID = currencyID;
            _SwapValuation.CurrencyOriginal = currencyID;
            _SwapValuation.CurrencyPayment = currencyID;
            _SwapValuation.CurrencyAssets = currencyID;
            _SwapValuation.TermBenchmark = termBenchmark;
            _SwapValuation.ResetDays = resetDays;
            _SwapValuation.YieldDiscountID = yieldDiscountID;
            _SwapValuation.YieldProjectedID = yieldProjectedID;
            _SwapValuation.YieldList = yieldList;
            _SwapValuation.CurrencyList = currencyList;
            _SwapValuation.RateList = rateList;

            _SwapValuation.IndexIntervalType = enumIntervalType.DayHoliday;
            _SwapValuation.IndexIntervalNumber = 1;
            _SwapValuation.IndexBrokenPeriod = 0;
            _SwapValuation.IndexConvention = enumConvention.Next;
            _SwapValuation.IndexCalendarType = 6;
            _SwapValuation.IndexAddressGenerationFixing = enumAddressGenerationFixing.Backwards;
            _SwapValuation.IndexStartingIntervalType = enumIntervalType.DayHoliday;
            _SwapValuation.IndexStartingIntervalNumber = 0;
            _SwapValuation.IndexExpiryIntervalType = enumIntervalType.DayHoliday;
            _SwapValuation.IndexExpiryIntervalNumber = 0;
            _SwapValuation.IndexConventionAccrual = enumConvention.Next;
            _SwapValuation.IndexCalendarAccrualType = 6;
            _SwapValuation.IndexMicroCalendarIntervalType = enumIntervalType.DayHoliday;
            _SwapValuation.IndexMicroCalendarIntervalNumber = 0;
            _SwapValuation.IndexMicroCalendarConvention = enumConvention.Next;
            _SwapValuation.IndexMicroCalendarType = 6;
            _SwapValuation.IndexFormulaIndexCalculation = enumFormulaIndexCalculation.AverageGeometriFactorsCapitalization;

            _SwapValuation.HolidayChile = holidayChile;
            _SwapValuation.HolidayEEUU = holidayEEUU;
            _SwapValuation.HolidayEnglan = holidayEnglan;

            if (_SwapLeg.FlagFixedFloating == enumFlagFixedFloating.Fixed)
            {
                _SwapValuation.YieldBasis = enumBasisCurve.YieldAct360;
                _SwapValuation.IndexType = enumIndexType.Vanilla;
                _SwapValuation.IndexBasis = _SwapLeg.BasisFixedRate;
                _SwapValuation.IndexPartialBasis = _SwapLeg.BasisFixedRate;
                _SwapValuation.IndexEndBasis = _SwapLeg.BasisFixedRate;
            }
            else
            {
                _SwapValuation.YieldBasis = enumBasisCurve.YieldAct360;
                _SwapValuation.IndexBasis = _SwapLeg.BasisSpreadFlotante;
                _SwapValuation.IndexPartialBasis = _SwapLeg.BasisSpreadFlotante;
                _SwapValuation.IndexEndBasis = _SwapLeg.BasisSpreadFlotante;

                if (_SwapValuation.RateID.Equals(13))
                {
                    _SwapValuation.IndexType = enumIndexType.ICP;
                    _SwapValuation.IndexMicroCalendarIntervalNumber = 1;
                }
                else
                {
                    _SwapValuation.IndexType = enumIndexType.Vanilla;
                }
            }

            #endregion

            return _SwapValuation;
        }

        #endregion
    }

}
