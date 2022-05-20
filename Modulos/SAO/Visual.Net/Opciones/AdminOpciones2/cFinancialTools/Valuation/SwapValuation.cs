// http://en.wikipedia.org/wiki/Rational_pricing
// http://en.wikipedia.org/wiki/Rational_pricing#Valuation_at_initiation
// http://www.quantnotes.com/fundamentals/
using System;
using System.Collections.Generic;
using System.Text;
using cFinancialTools.Swap;
using cFinancialTools.Currency;
using cFinancialTools.Rate;
using cFinancialTools.Yield;
using cFinancialTools.Indexes;
using cFinancialTools.Struct;
using cFinancialTools.DayCounters;
using cFinancialTools.BussineDate;

namespace cFinancialTools.Valuation
{

    public class SwapValuation
    {

        #region "Definición de Variables"

        private SwapLeg mFlow;

        private DateTime mValuatorDate;
        private DateTime mYieldDate;
        private DateTime mCurrencyDate;

        private int mRateID;
        private enumSource mSourceID;
        private int mCurrencyID;
        private enumPeriod mPeriodID;
        private RateList mRateList;

        private String mYieldProjectedID;
        private String mYieldDiscountID;
        private enumBasisCurve mYieldBasis;
        private YieldList mYieldList;

        private int mCurrencyOriginal;
        private int mCurrencyPayment;
        private int mCurrencyAssets;
        private CurrencyList mCurrencyList;
        private int mTermBenchmark;
        private int mResetDays;

        private enumIndexType mIndexType;
        private enumIntervalType mIndexIntervalType;
        private int mIndexIntervalNumber;
        private int mIndexBrokenPeriod;
        private enumConvention mIndexConvention;
        private enumBasis mIndexBasis;
        private int mIndexCalendarType;
        private Calendars mIndexCalendar;

        private enumBasis mIndexPartialBasis;
        private enumAddressGenerationFixing mIndexAddressGenerationFixing;
        private enumIntervalType mIndexStartingIntervalType;
        private int mIndexStartingIntervalNumber;
        private enumIntervalType mIndexExpiryIntervalType;
        private int mIndexExpiryIntervalNumber;
        private enumConvention mIndexConventionAccrual;
        private int mIndexCalendarAccrualType;
        private Calendars mIndexCalendarAccrual;
        private enumIntervalType mIndexMicroCalendarIntervalType;
        private int mIndexMicroCalendarIntervalNumber;
        private enumConvention mIndexMicroCalendarConvention;
        private int mIndexMicroCalendarType;
        private Calendars mIndexMicroCalendar;
        private enumFormulaIndexCalculation mIndexFormulaIndexCalculation;
        private enumBasis mIndexEndBasis;

        private double mCashFlow;

        private int mHolidayChile;
        private int mHolidayEEUU;
        private int mHolidayEnglan;

        private double mPresentValue;

        #endregion

        #region "Atributos Publicos"

        public SwapLeg Flow
        {
            get
            {
                return mFlow;
            }
            set
            {
                mFlow = value;
            }
        }

        public DateTime ValuatorDate
        {
            get
            {
                return mValuatorDate;
            }
            set
            {
                mValuatorDate = value;
            }
        }

        public DateTime YieldDate
        {
            get
            {
                return mYieldDate;
            }
            set
            {
                mYieldDate = value;
            }
        }

        public DateTime CurrencyDate
        {
            get
            {
                return mCurrencyDate;
            }
            set
            {
                mCurrencyDate = value;
            }
        }

        public int RateID
        {
            get
            {
                return mRateID;
            }
            set
            {
                mRateID = value;
            }
        }

        public enumSource SourceID
        {
            get
            {
                return mSourceID;
            }
            set
            {
                mSourceID = value;
            }
        }

        public int CurrencyID
        {
            get
            {
                return mCurrencyID;
            }
            set
            {
                mCurrencyID = value;
            }
        }

        public enumPeriod PeriodID
        {
            get
            {
                return mPeriodID;
            }
            set
            {
                mPeriodID = value;
            }
        }

        public RateList RateList
        {
            get
            {
                return mRateList;
            }
            set
            {
                mRateList = value;
            }
        }

        public String YieldProjectedID
        {
            get
            {
                return mYieldProjectedID;
            }
            set
            {
                mYieldProjectedID = value;
            }
        }

        public String YieldDiscountID
        {
            get
            {
                return mYieldDiscountID;
            }
            set
            {
                mYieldDiscountID = value;
            }
        }

        public enumBasisCurve YieldBasis
        {
            get
            {
                return mYieldBasis;
            }
            set
            {
                mYieldBasis = value;
            }
        }

        public YieldList YieldList
        {
            get
            {
                return mYieldList;
            }
            set
            {
                mYieldList = value;
            }
        }

        public int CurrencyOriginal
        {
            get
            {
                return mCurrencyOriginal;
            }
            set
            {
                mCurrencyOriginal = value;
            }
        }

        public int CurrencyPayment
        {
            get
            {
                return mCurrencyPayment;
            }
            set
            {
                mCurrencyPayment = value;
            }
        }

        public int CurrencyAssets
        {
            get
            {
                return mCurrencyAssets;
            }
            set
            {
                mCurrencyAssets = value;
            }
        }

        public CurrencyList CurrencyList
        {
            get
            {
                return mCurrencyList;
            }
            set
            {
                mCurrencyList = value;
            }
        }

        public int TermBenchmark
        {
            get
            {
                return mTermBenchmark;
            }
            set
            {
                mTermBenchmark = value;
            }
        }

        public int ResetDays
        {
            get
            {
                return mResetDays;
            }
            set
            {
                mResetDays = value;
            }
        }

        public enumIndexType IndexType
        {
            get
            {
                return mIndexType;
            }
            set
            {
                mIndexType = value;
            }
        }

        public enumIntervalType IndexIntervalType
        {
            get
            {
                return mIndexIntervalType;
            }
            set
            {
                mIndexIntervalType = value;
            }
        }

        public int IndexIntervalNumber
        {
            get
            {
                return mIndexIntervalNumber;
            }
            set
            {
                mIndexIntervalNumber = value;
            }
        }

        public int IndexBrokenPeriod
        {
            get
            {
                return mIndexBrokenPeriod;
            }
            set
            {
                mIndexBrokenPeriod = value;
            }
        }

        public enumConvention IndexConvention
        {
            get
            {
                return mIndexConvention;
            }
            set
            {
                mIndexConvention = value;
            }
        }

        public enumBasis IndexBasis
        {
            get
            {
                return mIndexBasis;
            }
            set
            {
                mIndexBasis = value;
            }
        }

        public int IndexCalendarType
        {
            get
            {
                return mIndexCalendarType;
            }
            set
            {
                mIndexCalendarType = value;
            }
        }

        public Calendars IndexCalendar
        {
            get
            {
                return mIndexCalendar;
            }
            set
            {
                mIndexCalendar = value;
            }
        }

        public enumBasis IndexPartialBasis
        {
            get
            {
                return mIndexPartialBasis;
            }
            set
            {
                mIndexPartialBasis = value;
            }
        }

        public enumAddressGenerationFixing IndexAddressGenerationFixing
        {
            get
            {
                return mIndexAddressGenerationFixing;
            }
            set
            {
                mIndexAddressGenerationFixing = value;
            }
        }

        public enumIntervalType IndexStartingIntervalType
        {
            get
            {
                return mIndexStartingIntervalType;
            }
            set
            {
                mIndexStartingIntervalType = value;
            }
        }

        public int IndexStartingIntervalNumber
        {
            get
            {
                return mIndexStartingIntervalNumber;
            }
            set
            {
                mIndexStartingIntervalNumber = value;
            }
        }

        public enumIntervalType IndexExpiryIntervalType
        {
            get
            {
                return mIndexExpiryIntervalType;
            }
            set
            {
                mIndexExpiryIntervalType = value;
            }
        }

        public int IndexExpiryIntervalNumber
        {
            get
            {
                return mIndexExpiryIntervalNumber;
            }
            set
            {
                mIndexExpiryIntervalNumber = value;
            }
        }

        public enumConvention IndexConventionAccrual
        {
            get
            {
                return mIndexConventionAccrual;
            }
            set
            {
                mIndexConventionAccrual = value;
            }
        }

        public int IndexCalendarAccrualType
        {
            get
            {
                return mIndexCalendarAccrualType;
            }
            set
            {
                mIndexCalendarAccrualType = value;
            }
        }

        public Calendars IndexCalendarAccrual
        {
            get
            {
                return mIndexCalendarAccrual;
            }
            set
            {
                mIndexCalendarAccrual = value;
            }
        }

        public enumIntervalType IndexMicroCalendarIntervalType
        {
            get
            {
                return mIndexMicroCalendarIntervalType;
            }
            set
            {
                mIndexMicroCalendarIntervalType = value;
            }
        }

        public int IndexMicroCalendarIntervalNumber
        {
            get
            {
                return mIndexMicroCalendarIntervalNumber;
            }
            set
            {
                mIndexMicroCalendarIntervalNumber = value;
            }
        }

        public enumConvention IndexMicroCalendarConvention
        {
            get
            {
                return mIndexMicroCalendarConvention;
            }
            set
            {
                mIndexMicroCalendarConvention = value;
            }
        }

        public int IndexMicroCalendarType
        {
            get
            {
                return mIndexMicroCalendarType;
            }
            set
            {
                mIndexMicroCalendarType = value;
            }
        }

        public Calendars IndexMicroCalendar
        {
            get
            {
                return mIndexMicroCalendar;
            }
            set
            {
                mIndexMicroCalendar = value;
            }
        }

        public enumFormulaIndexCalculation IndexFormulaIndexCalculation
        {
            get
            {
                return mIndexFormulaIndexCalculation;
            }
            set
            {
                mIndexFormulaIndexCalculation = value;
            }
        }

        public enumBasis IndexEndBasis
        {
            get
            {
                return mIndexEndBasis;
            }
            set
            {
                mIndexEndBasis = value;
            }
        }

        public double PresentValue
        {
            get
            {
                return mPresentValue;
            }
        }

        public int HolidayChile
        {
            get
            {
                return mHolidayChile;
            }
            set
            {
                mHolidayChile = value;
            }
        }

        public int HolidayEEUU
        {
            get
            {
                return mHolidayEEUU;
            }
            set
            {
                mHolidayEEUU = value;
            }
        }

        public int HolidayEnglan
        {
            get
            {
                return mHolidayEnglan;
            }
            set
            {
                mHolidayEnglan = value;
            }
        }

        public double CashFlow
        {
            get
            {
                return mCashFlow;
            }
        }

        #endregion

        #region "Constructores"

        public SwapValuation(Calendars calendars)
        {
            SwapLeg _Flow = new SwapLeg();
            RateList _RateList = new RateList();
            YieldList _YieldList = new YieldList();
            CurrencyList _CurrencyList = new CurrencyList();

            Set(
                 _Flow,
                 0,
                 enumSource.System,
                 enumPeriod.Anual,
                 0,
                 _RateList,
                 "",
                 "",
                 enumBasisCurve.YieldAct360,
                 _YieldList,
                 0,
                 0,
                 0,
                 _CurrencyList,
                 0,
                 0,
                 enumIndexType.Vanilla,
                 enumIntervalType.DayHoliday,
                 0, 
                 0,
                 enumConvention.NotAdjustedMonthEnd,
                 enumBasis.Basis_Act_360,
                 6,
                 calendars,
                 enumBasis.Basis_Act_360,
                 enumAddressGenerationFixing.Forward,
                 enumIntervalType.DayHoliday,
                 0,
                 enumIntervalType.DayHoliday,
                 0,
                 enumConvention.NotAdjustedMonthEnd,
                 6,
                 calendars,
                 enumIntervalType.DayHoliday,
                 0,
                 enumConvention.NotAdjustedMonthEnd,
                 6,
                 calendars,
                 enumFormulaIndexCalculation.AverageGeometriFactorsCapitalization,
                 enumBasis.Basis_Act_360,
                 0,
                 0,
                 0
               );
        }

        public SwapValuation(
                              SwapLeg flow,
                              int rateID,
                              enumSource sourceID,
                              enumPeriod periodID,
                              int currencyID,
                              RateList rateList,
                              String yieldProjectedID,
                              String yieldDiscountID,
                              enumBasisCurve yieldBasis,
                              YieldList yieldList,
                              int currencyOriginal,
                              int currencyPayment,
                              int currencyAssets,
                              CurrencyList currencyList,
                              int termBenchmark,
                              int resetDays,
                              enumIndexType indexType,
                              enumIntervalType indexIntervalType,
                              int indexIntervalNumber,
                              int indexBrokenPeriod,
                              enumConvention indexConvention,
                              enumBasis indexBasis,
                              int indexCalendarType,
                              Calendars indexCalendar,
                              enumBasis indexPartialBasis,
                              enumAddressGenerationFixing indexAddressGenerationFixing,
                              enumIntervalType indexStartingIntervalType,
                              int indexStartingIntervalNumber,
                              enumIntervalType indexExpiryIntervalType,
                              int indexExpiryIntervalNumber,
                              enumConvention indexConventionAccrual,
                              int indexCalendarAccrualType,
                              Calendars indexCalendarAccrual,
                              enumIntervalType indexMicroCalendarIntervalType,
                              int indexMicroCalendarIntervalNumber,
                              enumConvention indexMicroCalendarConvention,
                              int indexMicroCalendarType,
                              Calendars indexMicroCalendar,
                              enumFormulaIndexCalculation indexFormulaIndexCalculation,
                              enumBasis indexEndBasis,
                              int holidayChile,
                              int holidayEEUU,
                              int holidayEnglan
                            )
        {
            Set(
                 flow,
                 rateID,
                 sourceID,
                 periodID,
                 currencyID,
                 rateList,
                 yieldProjectedID,
                 yieldDiscountID,
                 yieldBasis,
                 yieldList,
                 currencyOriginal,
                 currencyPayment,
                 currencyAssets,
                 currencyList,
                 termBenchmark,
                 resetDays,
                 indexType,
                 indexIntervalType,
                 indexIntervalNumber,
                 indexBrokenPeriod,
                 indexConvention,
                 indexBasis,
                 indexCalendarType,
                 indexCalendar,
                 indexPartialBasis,
                 indexAddressGenerationFixing,
                 indexStartingIntervalType,
                 indexStartingIntervalNumber,
                 indexExpiryIntervalType,
                 indexExpiryIntervalNumber,
                 indexConventionAccrual,
                 indexCalendarAccrualType,
                 indexCalendarAccrual,
                 indexMicroCalendarIntervalType,
                 indexMicroCalendarIntervalNumber,
                 indexMicroCalendarConvention,
                 indexMicroCalendarType,
                 indexMicroCalendar,
                 indexFormulaIndexCalculation,
                 indexEndBasis,
                 holidayChile,
                 holidayEEUU,
                 holidayEnglan
               );
        }



        #endregion

        #region "Valuator"

        public bool Valuation()
        {
            return Valuation(mValuatorDate, mYieldDate, mCurrencyDate);
        }

        public bool Valuation(DateTime valuatorDate, DateTime yieldDate, DateTime currencyDate)
        {

            #region "Variable Definition"

            int _Row;
            int _CouponCurrent;
            double _InterestProposed;
            double _Accrual;
            StructDevelopmentTable _Coupon;
            Basis _BasisStating;
            Basis _BasisDiscount;
            double _RateProject;
            double _RateProjectTransfer;
            Indexes.Vanilla _IndexVanilla;
            Indexes.Indexes _Index;
            Indexes.ICP _IndexICP;
            double _RateIndex;
            string _YieldDiscountID;
            Yield.Yield _YieldDiscount;
            double _RateDiscount;
            double _Parity;
            double _FactorDiscount;
            double _ParityPayment;
            double _FactorDiscountPayment;
            double _RatePayment;
            string _YieldPaymentID;

            #endregion

            #region "Assing Variable"

            _Row = 0;
            _CouponCurrent = 0;
            _InterestProposed = 0;
            _Accrual = 0;
            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mCurrencyDate = currencyDate;

            #endregion

            #region "Valuator"

            if (mFlow.Count() > 0) // contempla el caso de que los flujos puede provenir de flujos adicionales o amortizaciones
            {

                #region "Set Coupon Current"

                while (mFlow.getFlow(_CouponCurrent).ExpiryDate <= mValuatorDate)
                {

                    mFlow.CourtDateCoupon = mFlow.getFlow(_CouponCurrent).ExpiryDate;
                    _CouponCurrent++;

                    if (_CouponCurrent == mFlow.Count())
                    {
                        break;
                    }

                }

                #endregion

                #region "Flow Valuator"

                for (_Row = 0; _Row < mFlow.Count(); _Row++) ///_CouponCurrent
                {

                    #region "Assing Flow"

                    _Coupon = mFlow.getFlow(_Row);

                    #endregion

                    #region "Calculate Basis"

                    // Calcula Basis desde la emisión al Vencimiento
                    _BasisStating = new Basis(mFlow.BasisFixedRate, _Coupon.StartingDate, _Coupon.ExpiryDate);

                    #endregion

                    #region "Calculate Project Rate"

                    if (mFlow.FlagFixedFloating == enumFlagFixedFloating.Fixed)
                    {

                        #region "Rate Fixing"

                        _RateProject = _Coupon.FixedRateEnd + _Coupon.SpreadFlotanteEnd;
                        _RateProjectTransfer = _Coupon.TransferFixedRate + _Coupon.SpreadFlotanteEnd;

                        #endregion

                    }
                    else if (_Coupon.ExchangeInterestType == enumExchangeNotional.Yes)
                    {

                        #region "Assign Rate depending of Flag Valuator"

                        if (mFlow.FlagValuator == enumFlagMartTOMarketFixingRate.RateToday)
                        {
                            _RateProject = _Coupon.FixedRateEnd;
                            _RateIndex = 0;
                        }
                        else
                        {
                            _RateProject = _Coupon.FixedRateEndYesterday;
                            _RateIndex = 0;
                        }

                        #endregion

                        #region "Calculate Rate Flotating"

                        if (mIndexType == enumIndexType.Vanilla)
                        {

                            #region "Method Vanilla"

                            _IndexVanilla = new Indexes.Vanilla(
                                                                 mValuatorDate,
                                                                 mYieldDate,
                                                                 _Coupon.StartingDate,
                                                                 _Coupon.ExpiryDate,
                                                                 _Coupon.FixingDate,
                                                                 mTermBenchmark,
                                                                 mResetDays,
                                                                 mRateID,
                                                                 _RateProject,
                                                                 mSourceID,
                                                                 mPeriodID,
                                                                 mCurrencyID,
                                                                 mRateList,
                                                                 mYieldProjectedID,
                                                                 mYieldList,
                                                                 mYieldBasis,
                                                                 mIndexIntervalType,
                                                                 mIndexIntervalNumber,
                                                                 mIndexBrokenPeriod,
                                                                 mIndexConvention,
                                                                 mIndexBasis,
                                                                 mIndexCalendar,
                                                                 mHolidayChile,
                                                                 mHolidayEEUU,
                                                                 mHolidayEnglan
                                                              );

                            _RateIndex = _IndexVanilla.Calculate();

                            _Coupon.RateStarting = _IndexVanilla.RateStarting;
                            _Coupon.FactorRateStarting = _IndexVanilla.FactorRateStarting;
                            _Coupon.RateExpiry = _IndexVanilla.RateExpiry;
                            _Coupon.FactorRateExpiry = _IndexVanilla.FactorRateExpiry;
                            _Coupon.RateFra = _IndexVanilla.RateFra;
                            _Coupon.FactorRateFra = _IndexVanilla.FactorRateFra;

                            #endregion

                        }
                        else if (mIndexType == enumIndexType.Exotic)
                        {

                            #region "Method Index Exotic"

                            _Index = new Indexes.Indexes(
                                                          mValuatorDate,
                                                          mYieldDate,
                                                          mRateID,
                                                          mSourceID,
                                                          mPeriodID,
                                                          mCurrencyID,
                                                          mRateList,
                                                          mYieldProjectedID,
                                                          mYieldList,
                                                          mYieldBasis,
                                                          mIndexIntervalType,
                                                          mIndexIntervalNumber,
                                                          mIndexBrokenPeriod,
                                                          mIndexConvention,
                                                          mIndexBasis,
                                                          mIndexCalendar,
                                                          mTermBenchmark,
                                                          mResetDays,
                                                          mIndexAddressGenerationFixing,
                                                          _Coupon.StartingDate,
                                                          mIndexStartingIntervalType,
                                                          mIndexStartingIntervalNumber,
                                                          _Coupon.ExpiryDate,
                                                          mIndexExpiryIntervalType,
                                                          mIndexExpiryIntervalNumber,
                                                          mIndexConventionAccrual,
                                                          mIndexCalendarAccrual,
                                                          mIndexMicroCalendarIntervalType,
                                                          mIndexMicroCalendarIntervalNumber,
                                                          mIndexMicroCalendarConvention,
                                                          mIndexMicroCalendar,
                                                          mIndexFormulaIndexCalculation,
                                                          mIndexBasis,
                                                          mHolidayChile,
                                                          mHolidayEEUU,
                                                          mHolidayEnglan
                                                       );

                            _RateIndex = _Index.Calculate();

                            _Coupon.RateStarting = 0;
                            _Coupon.FactorRateStarting = 0;
                            _Coupon.RateExpiry = 0;
                            _Coupon.FactorRateExpiry = 0;
                            _Coupon.RateFra = _RateIndex;
                            _Coupon.FactorRateFra = 0;

                            #endregion

                        }
                        else if (mIndexType == enumIndexType.ICP)
                        {

                            #region "Method ICP"

                            _IndexICP = new Indexes.ICP(
                                                         mValuatorDate,
                                                         YieldDate,
                                                         _Coupon.StartingDate,
                                                         _Coupon.ExpiryDate,
                                                         mTermBenchmark,
                                                         mResetDays,
                                                         mRateID,
                                                         _RateProject,
                                                         mSourceID,
                                                         mPeriodID,
                                                         mCurrencyID,
                                                         mCurrencyList,
                                                         mRateList,
                                                         mYieldProjectedID,
                                                         mYieldList,
                                                         mYieldBasis,
                                                         mIndexIntervalType,
                                                         mIndexIntervalNumber,
                                                         mIndexBrokenPeriod,
                                                         mIndexConvention,
                                                         mIndexBasis,
                                                         mIndexCalendar
                                                      );

                            _RateIndex = _IndexICP.Calculate();

                            _Coupon.RateStarting = _IndexICP.RateStarting;
                            _Coupon.FactorRateStarting = _IndexICP.FactorRateStarting;
                            _Coupon.RateExpiry = _IndexICP.RateExpiry;
                            _Coupon.FactorRateExpiry = _IndexICP.FactorRateExpiry;
                            _Coupon.RateFra = _IndexICP.RateFra;
                            _Coupon.FactorRateFra = _IndexICP.FactorRateFra;

                            #endregion

                        }

                        #endregion

                        _RateProject = _RateIndex + _Coupon.SpreadFlotanteEnd;
                        _RateProjectTransfer = _RateIndex + _Coupon.TransferSpreadFlotante;

                    }
                    else
                    {

                        _RateProject = 0;
                        _RateProjectTransfer = 0;

                    }

                    _Coupon.RateProject = _RateProject;
                    _Coupon.RateProjectTransfer = _RateProjectTransfer;

                    #endregion

                    #region "Calculate Interest Flow"

                    /*
                     * Significa que paga normalmente el interes del periodo más eventuales intereses pasados postposicion 
                     * financiados a la misma tasa con la que se generó el devengo del periodo
                    */
                    if (_Coupon.ExchangeInterestType == enumExchangeNotional.Yes)
                    {

                        _Coupon.InterestFlow = _RateProject * 0.01 * _BasisStating.TermBasis * 
                                               (_Coupon.BalanceResidual + _Coupon.Amortization);

                        _Coupon.InterestTransferFlow = (_RateProjectTransfer * 0.01) * _BasisStating.TermBasis * 
                                                       (_Coupon.BalanceResidual + _Coupon.Amortization);

                        /*
                         * Notar que la postposicion de interesesse realiza en las mismas condiciones que el interes corriente del periodo
                         * correpondiente
                        */
                        if (_Row > 0)
                        {

                            _Coupon.InterestFlow += (1.0 + _RateProject * 0.01 * _BasisStating.TermBasis) * 
                                                     mFlow.getFlow(_Row - 1).InterestProposed;

                            _Coupon.InterestTransferFlow += (1.0 + _RateProjectTransfer * 0.01 * _BasisStating.TermBasis) *
                                                            mFlow.getFlow(_Row - 1).InterestTransferProposed;

                        }

                        _Coupon.InterestProposed = 0;
                        _Coupon.InterestTransferProposed = 0;

                    }
                    else if (_Coupon.ExchangeInterestType == enumExchangeNotional.Not)
                    {

                        _Coupon.InterestProposed = _RateProject * 0.01 * _BasisStating.TermBasis * 
                                                   (_Coupon.BalanceResidual + _Coupon.Amortization);

                        _Coupon.InterestTransferProposed = _RateProjectTransfer * 0.01 * _BasisStating.TermBasis * 
                                                           (_Coupon.BalanceResidual + _Coupon.Amortization);

                        /*
                         * Notar que la postposicion de interesesse realiza en las mismas condiciones que el interes corriente del periodo
                         * correpondiente
                        */
                        if (_Row > 0)
                        {
                            _Coupon.InterestProposed += (1.0 + _RateProject * 0.01 * _BasisStating.TermBasis) *
                                                        mFlow.getFlow(_Row - 1).InterestProposed;
                            _Coupon.InterestTransferProposed += (1.0 + _RateProjectTransfer * 0.01 * _BasisStating.TermBasis) *
                                                                mFlow.getFlow(_Row - 1).InterestTransferProposed;
                        }

                        _Coupon.InterestFlow = 0;
                        _Coupon.InterestTransferFlow = 0;

                    }
                    else
                    {

                        // display('Flag Pago de intereses ingresado no coresponde a un tipo valido')
                        _Coupon.InterestFlow = 0;
                        _Coupon.InterestTransferFlow = 0;
                        _Coupon.InterestProposed = 0;
                        _Coupon.InterestTransferProposed = 0;

                    }

                    #endregion

                    #region "Assing Rate Project, Rate Project Transfer y Amortization"

                    //mFlow.FixedRateEnd = _RateProject;

                    //_Coupon.FixedRateEnd = _RateProject;
                    //_Coupon.TransferFixedRate = _RateProjectTransfer;
                    _Coupon.AmortizationFlow = _Coupon.Amortization;

                    #endregion

                    #region "Calculate Present Value"

                    if (_Row >= _CouponCurrent)
                    {

                        #region "Rescata el nombre de la curva de descuento"

                        _YieldDiscountID = mYieldDiscountID;

                        if (_YieldDiscountID.Equals(""))
                        {
                            _YieldDiscountID = mYieldProjectedID;
                        }

                        _YieldDiscount = mYieldList.Read(_YieldDiscountID);

                        #endregion


                        #region "Calcula Basis desde la fecha de valorización al vencimiento"

                        _BasisDiscount = new Basis(_YieldDiscount.Basis, mValuatorDate, _Coupon.PaymentDate);

                        #endregion

                        #region "Recupera el valor de la moneda."

                        _Parity = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mCurrencyDate).Parity;

                        #endregion

                        #region "Obtiene el tasa de descuento"

                        _RateDiscount = _YieldDiscount.Read(mSourceID).Read(mYieldDate).Read((int)_BasisDiscount.Term).Rate;
                        _Coupon.RateDiscount = _RateDiscount;

                        #endregion

                        #region "Calculo Factor de Descuento"

                        _FactorDiscount = Math.Pow((1 + _RateDiscount * 0.01), -_BasisDiscount.TermBasis);
                        _Coupon.FactorDiscount = _FactorDiscount;

                        #endregion

                        #region "Rescata el valor de la moneda de pago"

                        _ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mCurrencyDate).Parity;

                        #endregion

                        #region "Valida si la moneda de pago es distinta a la moneda original"

                        _RatePayment = 0;
                        _FactorDiscountPayment = 0;
                        _ParityPayment = 0;

                        if (!mCurrencyOriginal.Equals(mCurrencyPayment))
                        {

                            _YieldPaymentID = mCurrencyList.Read(mCurrencyPayment).CurveID;
                            _RatePayment = mYieldList.Read(_YieldPaymentID, mSourceID, mYieldDate, (int)_BasisDiscount.Term).Rate;
                            _FactorDiscountPayment = Math.Pow((1 + _RatePayment / 100.0), -_BasisDiscount.TermBasis);
                            _ParityPayment = (_ParityPayment / _Parity) * (_FactorDiscount / _FactorDiscountPayment);

                        }

                        #endregion

                        #region "Calculo de Amortización, Interes y Flujo Adicional Presente"

                        if (_Coupon.InterestProposed.Equals(0))
                        {

                            _Coupon.InterestEndConvertion = 0;
                            _Coupon.InterestTransferEndConvertion = 0;

                            if (!mCurrencyOriginal.Equals(mCurrencyPayment))
                            {

                                _Coupon.InterestEndConvertion = _Coupon.InterestFlow * _ParityPayment;
                                _Coupon.InterestTransferEndConvertion = _Coupon.InterestTransferFlow * _ParityPayment;
                                _Coupon.AditionalsFlowConvertion = _Coupon.AditionalsFlowValue * _ParityPayment;

                                if (_Coupon.ExchangeNotionalType == enumExchangeNotional.Yes)
                                {
                                    _Coupon.AmortizationFlow = _Coupon.AmortizationEndConvertion * _ParityPayment;
                                }


                            }

                            _Coupon.InterestEnd = _Coupon.InterestFlow * _FactorDiscount;
                            _Coupon.InterestTransferFlow = _Coupon.InterestTransferFlow * _FactorDiscount;
                            _Coupon.AditionalsFlow = _Coupon.AditionalsFlowValue * _FactorDiscount;

                            if (_Coupon.ExchangeNotionalType == enumExchangeNotional.Yes)
                            {
                                _Coupon.AmortizationEnd = _Coupon.AmortizationFlow * _FactorDiscount;
                            }


                        }

                        #endregion

                    }
                    else
                    {

                        //_Coupon.InterestTransferProposed = 0;
                        //_Coupon.InterestEnd = 0;
                        //_Coupon.InterestTransferFlow = 0;
                        //_Coupon.AmortizationFlow = 0;
                        //_Coupon.AmortizationEnd = 0;
                        //_Coupon.AditionalsFlow = 0;
                        //_Coupon.FactorDiscount = 0;

                    }

                    #endregion

                    #region "Calculo de Flujo Total"

                    _Coupon.FlowEnd = _Coupon.AmortizationEnd + _Coupon.InterestEnd + _Coupon.AditionalsFlow;

                    #endregion

                    mFlow.setFlow(_Row, _Coupon);

                }

                #endregion

                if (_CouponCurrent < mFlow.Count())
                {
                    _Coupon = mFlow.getFlow(_CouponCurrent);

                    if (_Coupon.StartingDate < mValuatorDate)
                    {

                        if (_CouponCurrent > 0)
                        {
                            _InterestProposed = mFlow.getFlow(_CouponCurrent).InterestProposed;
                        }

                        _BasisStating = new Basis(mFlow.BasisFixedRate, _Coupon.StartingDate, _Coupon.ExpiryDate);
                        _Accrual = (_Coupon.FixedRateEnd * 0.01) * _BasisStating.TermBasis * (_Coupon.BalanceResidual + _InterestProposed);
                    }

                }

            }

            #endregion

            mPresentValue = 0;
            mCashFlow = 0;

            #region "Cash Flow"

            for (_Row = 0; _Row < _CouponCurrent; _Row++)
            {
                if (mFlow.getFlow(_Row).ExchangeNotionalType == enumExchangeNotional.Yes)
                {
                    mCashFlow += (mFlow.getFlow(_Row).AmortizationFlow);
                }

                if (mFlow.getFlow(_Row).ExchangeInterestType == enumExchangeNotional.Yes)
                {
                    mCashFlow += (mFlow.getFlow(_Row).InterestFlow);
                }
            }

            #endregion

            #region "Calculate Present Value"

            for (_Row = _CouponCurrent; _Row < mFlow.Count(); _Row++)
            {
                mPresentValue += (mFlow.getFlow(_Row).AmortizationEnd + mFlow.getFlow(_Row).InterestEnd + mFlow.getFlow(_Row).AditionalsFlow);
            }

            #endregion

            return true;

        }

        #endregion

        #region "Funciones privadas"

        #region "Source Old"

        #region "Source Old Valuation"

        //public bool Valuation(DateTime valuatorDate, DateTime yieldDate, DateTime currencyDate)
        //{

        //    int _CouponCurrent = 0;
        //    int _Row = 0;

        //    mValuatorDate = valuatorDate;
        //    mYieldDate = yieldDate;
        //    mCurrencyDate = currencyDate;

        //    _CouponCurrent = CalculatePresentValueFlow();
        //    CalculatePresentValueInteres(_CouponCurrent);
        //    CalculatePresentValueAmortization(_CouponCurrent);
        //    CalculatePresentValueAditional(_CouponCurrent);

        //    mPresentValue = 0;
        //    mCashFlow = 0;

        //    for (_Row = 0; _Row < _CouponCurrent; _Row++)
        //    {
        //        if (mFlow.getFlow(_Row).ExchangeNotionalType == enumExchangeNotional.Yes)
        //        {
        //            mCashFlow += (mFlow.getFlow(_Row).AmortizationFlow);
        //        }

        //        if (mFlow.getFlow(_Row).ExchangeInterestType == enumExchangeNotional.Yes)
        //        {
        //            mCashFlow += (mFlow.getFlow(_Row).InterestFlow);
        //        }
        //    }

        //    for (_Row = _CouponCurrent; _Row < mFlow.Count(); _Row++)
        //    {
        //        mPresentValue += (mFlow.getFlow(_Row).AmortizationEnd + mFlow.getFlow(_Row).InterestEnd + mFlow.getFlow(_Row).AditionalsFlow);
        //    }

        //    return true;

        //}

        #endregion

        #region "Source Old CalculatePresentValueFlow"

        //private int CalculatePresentValueFlow()
        //{
        //    int _Row = 0;
        //    int _CouponCurrent = 0;
        //    double _InterestProposed = 0;
        //    double _Accrual = 0;
        //    StructDevelopmentTable _Coupon;
        //    Basis _Basis;
        //    double _RateEnd;
        //    double _RateTransferEnd;
        //    Indexes.Vanilla _IndexVanilla;
        //    Indexes.Indexes _Index;
        //    Indexes.ICP _IndexICP;
        //    Double _RateIndex;

        //    if (mFlow.Count() > 0) // contempla el caso de que los flujos puede provenir de flujos adicionales o amortizaciones
        //    {
        //        // notar que cortara los cupones en la fecha de pago
        //        while (mFlow.getFlow(_CouponCurrent).ExpiryDate <= mValuatorDate)
        //        {

        //            mFlow.CourtDateCoupon = mFlow.getFlow(_CouponCurrent).ExpiryDate;
        //            _CouponCurrent++;

        //            if (_CouponCurrent == mFlow.Count())
        //            {
        //                break;
        //            }

        //        }

        //        // Caso pata fija, contempla el caso de postposicion de intereses
        //        for (_Row = 0; _Row < mFlow.Count(); _Row++) ///_CouponCurrent
        //        {
        //            _Coupon = mFlow.getFlow(_Row);
        //            _Basis = new Basis(mFlow.BasisFixedRate, _Coupon.StartingDate, _Coupon.ExpiryDate);

        //            if (mFlow.FlagFixedFloating == enumFlagFixedFloating.Fixed)
        //            {
        //                _RateEnd = _Coupon.FixedRateEnd + _Coupon.SpreadFlotanteEnd;
        //                _RateTransferEnd = _Coupon.TransferFixedRate + _Coupon.SpreadFlotanteEnd;
        //            }
        //            else if (_Coupon.ExchangeInterestType == enumExchangeNotional.Yes)
        //            {
        //                if (mFlow.FlagValuator == enumFlagMartTOMarketFixingRate.RateToday)
        //                {
        //                    _RateEnd = _Coupon.FixedRateEnd;
        //                    _RateIndex = 0;
        //                }
        //                else
        //                {
        //                    _RateEnd = _Coupon.FixedRateEndYesterday;
        //                    _RateIndex = 0;
        //                }

        //                if (mIndexType == enumIndexType.Vanilla)
        //                {
        //                    _IndexVanilla = new Indexes.Vanilla(
        //                                                         mValuatorDate,
        //                                                         mYieldDate,
        //                                                         _Coupon.StartingDate,
        //                                                         _Coupon.ExpiryDate,
        //                                                         _Coupon.FixingDate,
        //                                                         mTermBenchmark,
        //                                                         mResetDays,
        //                                                         mRateID,
        //                                                         _RateEnd,
        //                                                         mSourceID,
        //                                                         mPeriodID,
        //                                                         mCurrencyID,
        //                                                         mRateList,
        //                                                         mYieldProjectedID,
        //                                                         mYieldList,
        //                                                         mYieldBasis,
        //                                                         mIndexIntervalType,
        //                                                         mIndexIntervalNumber,
        //                                                         mIndexBrokenPeriod,
        //                                                         mIndexConvention,
        //                                                         mIndexBasis,
        //                                                         mIndexCalendar,
        //                                                         mHolidayChile,
        //                                                         mHolidayEEUU,
        //                                                         mHolidayEnglan
        //                                                      );

        //                    _RateIndex = _IndexVanilla.Calculate();

        //                }
        //                else if (mIndexType == enumIndexType.Exotic)
        //                {
        //                    _Index = new Indexes.Indexes(
        //                                                  mValuatorDate,
        //                                                  mYieldDate,
        //                                                  mRateID,
        //                                                  mSourceID,
        //                                                  mPeriodID,
        //                                                  mCurrencyID,
        //                                                  mRateList,
        //                                                  mYieldProjectedID,
        //                                                  mYieldList,
        //                                                  mYieldBasis,
        //                                                  mIndexIntervalType,
        //                                                  mIndexIntervalNumber,
        //                                                  mIndexBrokenPeriod,
        //                                                  mIndexConvention,
        //                                                  mIndexBasis,
        //                                                  mIndexCalendar,
        //                                                  mTermBenchmark,
        //                                                  mResetDays,
        //                                                  mIndexAddressGenerationFixing,
        //                                                  _Coupon.StartingDate,
        //                                                  mIndexStartingIntervalType,
        //                                                  mIndexStartingIntervalNumber,
        //                                                  _Coupon.ExpiryDate,
        //                                                  mIndexExpiryIntervalType,
        //                                                  mIndexExpiryIntervalNumber,
        //                                                  mIndexConventionAccrual,
        //                                                  mIndexCalendarAccrual,
        //                                                  mIndexMicroCalendarIntervalType,
        //                                                  mIndexMicroCalendarIntervalNumber,
        //                                                  mIndexMicroCalendarConvention,
        //                                                  mIndexMicroCalendar,
        //                                                  mIndexFormulaIndexCalculation,
        //                                                  mIndexBasis,
        //                                                  mHolidayChile,
        //                                                  mHolidayEEUU,
        //                                                  mHolidayEnglan
        //                                               );

        //                    _RateIndex = _Index.Calculate();
        //                }
        //                else if (mIndexType == enumIndexType.ICP)
        //                {
        //                    _IndexICP = new Indexes.ICP(
        //                                                 mValuatorDate,
        //                                                 YieldDate,
        //                                                 _Coupon.StartingDate,
        //                                                 _Coupon.ExpiryDate,
        //                                                 mTermBenchmark,
        //                                                 mResetDays,
        //                                                 mRateID,
        //                                                 _RateEnd,
        //                                                 mSourceID,
        //                                                 mPeriodID,
        //                                                 mCurrencyID,
        //                                                 mRateList,
        //                                                 mYieldProjectedID,
        //                                                 mYieldList,
        //                                                 mYieldBasis,
        //                                                 mIndexIntervalType,
        //                                                 mIndexIntervalNumber,
        //                                                 mIndexBrokenPeriod,
        //                                                 mIndexConvention,
        //                                                 mIndexBasis,
        //                                                 mIndexCalendar
        //                                              );

        //                    _RateIndex = _IndexICP.Calculate();
        //                }

        //                _RateEnd = _RateIndex + _Coupon.SpreadFlotanteEnd;
        //                _RateTransferEnd = _RateIndex + _Coupon.TransferSpreadFlotante;
        //            }
        //            else
        //            {
        //                _RateEnd = 0;
        //                _RateTransferEnd = 0;
        //            }

        //            /*
        //             * Significa que paga normalmente el interes del periodo más eventuales intereses pasados posptuestos financiados a la misma 
        //             * tasa con la que se generó el devengo del periodo
        //            */
        //            if (_Coupon.ExchangeInterestType == enumExchangeNotional.Yes)
        //            {
        //                _Coupon.InterestFlow = _RateEnd * 0.01 * _Basis.TermBasis * (_Coupon.BalanceResidual + _Coupon.Amortization);
        //                _Coupon.InterestTransferFlow = (_RateTransferEnd * 0.01) * _Basis.TermBasis * (_Coupon.BalanceResidual + _Coupon.Amortization);

        //                /*
        //                 * Notar que la postposicion de interesesse realiza en las mismas condiciones que el interes corriente del periodo
        //                 * correpondiente
        //                */
        //                if (_Row > 0)
        //                {
        //                    _Coupon.InterestFlow += (1.0 + _RateEnd * 0.01 * _Basis.TermBasis) * mFlow.getFlow(_Row - 1).InterestProposed;
        //                    _Coupon.InterestTransferFlow += (1.0 + _RateTransferEnd * 0.01 * _Basis.TermBasis) *
        //                                                    mFlow.getFlow(_Row - 1).InterestTransferProposed;
        //                }

        //                _Coupon.InterestProposed = 0;
        //                _Coupon.InterestTransferProposed = 0;

        //            }
        //            else if (_Coupon.ExchangeInterestType == enumExchangeNotional.Not)
        //            {
        //                _Coupon.InterestProposed = _RateEnd * _Basis.TermBasis * _Coupon.BalanceResidual;
        //                _Coupon.InterestTransferProposed = _RateTransferEnd * _Basis.TermBasis * _Coupon.BalanceResidual;

        //                /*
        //                 * Notar que la postposicion de interesesse realiza en las mismas condiciones que el interes corriente del periodo
        //                 * correpondiente
        //                */
        //                if (_Row > 0)
        //                {
        //                    _Coupon.InterestProposed += (1.0 + _RateEnd * 0.01 * _Basis.TermBasis) *
        //                                                mFlow.getFlow(_Row - 1).InterestProposed;
        //                    _Coupon.InterestTransferProposed += (1.0 + _RateTransferEnd * 0.01 * _Basis.TermBasis) * 
        //                                                        mFlow.getFlow(_Row - 1).InterestTransferProposed;
        //                }

        //                _Coupon.InterestFlow = 0;
        //                _Coupon.InterestTransferFlow = 0;

        //            }
        //            else
        //            {
        //                // display('Flag Pago de intereses ingresado no coresponde a un tipo valido')
        //                return _CouponCurrent;
        //            }

        //            mFlow.FixedRateEnd = _RateEnd;
        //            _Coupon.TransferFixedRate = _RateTransferEnd;
        //            _Coupon.AmortizationFlow = _Coupon.Amortization;
        //            mFlow.setFlow(_Row, _Coupon);

        //        }

        //        if (_CouponCurrent < mFlow.Count())
        //        {
        //            _Coupon = mFlow.getFlow(_CouponCurrent);

        //            if (_Coupon.StartingDate < mValuatorDate)
        //            {

        //                if (_CouponCurrent > 0)
        //                {
        //                    _InterestProposed = mFlow.getFlow(_CouponCurrent).InterestProposed;
        //                }

        //                _Basis = new Basis(mFlow.BasisFixedRate, _Coupon.StartingDate, _Coupon.ExpiryDate);
        //                _Accrual = (_Coupon.FixedRateEnd * 0.01) * _Basis.TermBasis * (_Coupon.BalanceResidual + _InterestProposed);
        //            }

        //        }

        //    }

        //    return _CouponCurrent;
        //}

        #endregion

        #region "Source Old CalculatePresentValueInteres"

        //private void CalculatePresentValueInteres(int _CouponCurrent)
        //{
        //    DateTime _StartingDate;
        //    StructDevelopmentTable _Coupon;
        //    Basis _Basis;
        //    int _Row;
        //    int _Term = 0;
        //    double _TermBasis = 0;
        //    double _Rate = 0;
        //    double _Parity = 0;
        //    string _YieldOriginalName = "";
        //    CurrencyValue _ParityOriginal;
        //    double _ValueParityOriginal;
        //    CurrencyValue _ParityPayment;
        //    string _YieldPaymentName;
        //    double _ValueParityPayment;
        //    Yield.Yield _YieldOriginal;
        //    YieldPoint _YieldPoint;

        //    _StartingDate = mFlow.getFlow(0).StartingDate;

        //    // Determinacion de los factores de descuento relevantes para los flujos de interes
        //    for (_Row = _CouponCurrent; _Row < mFlow.Count(); _Row++)
        //    {

        //        _Coupon = mFlow.getFlow(_Row);

        //        if (_Coupon.InterestProposed.Equals(0))
        //        {

        //            // Rescata el nombre de la curva original
        //            _YieldOriginalName = mYieldDiscountID; // mCurrencyList.Read(mCurrencyOriginal).YieldID

        //            if (_YieldOriginalName.Equals(""))
        //            {
        //                _YieldOriginalName = mYieldProjectedID;
        //            }

        //            _YieldOriginal = mYieldList.Read(_YieldOriginalName);

        //            // calcula el factor de descuento
        //            //_Basis = new Basis(_YieldOriginal.Basis, _StartingDate, _Coupon.ExpiryDate);
        //            _Basis = new Basis(_YieldOriginal.Basis, mValuatorDate, _Coupon.PaymentDate); //_Coupon.ExpiryDate
        //            _Term = (int)_Basis.Term;
        //            _TermBasis = (double)_Basis.TermBasis;

        //            // Recupera el registro de la moneda y fecha.
        //            //_ParityOriginal = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mValuatorDate);
        //            _ParityOriginal = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mCurrencyDate);

        //            // Obtiene el valor de la tasa en el plazo.
        //            //_YieldPoint = mYieldList.Read(_YieldOriginalName, mSourceID, mValuatorDate, _Term);
        //            _YieldPoint = mYieldList.Read(_YieldOriginalName, mSourceID, mYieldDate, _Term);
        //            //_YieldValue.Read(_Term);
        //            _Rate = _YieldPoint.Rate;

        //            _ValueParityOriginal = Math.Pow((1 + _Rate / 100.0), -_TermBasis);

        //            // Rescata el valor de la moneda
        //            //_ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mValuatorDate);
        //            _ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mCurrencyDate);

        //            if (!mCurrencyOriginal.Equals(mCurrencyPayment))
        //            {
        //                _YieldPaymentName = mCurrencyList.Read(mCurrencyPayment).CurveID;

        //                // Obtiene el valor de la tasa en el plazo.
        //                //_Rate = mYieldList.Read(_YieldPaymentName, mSourceID, mValuatorDate, _Term).Rate;
        //                _Rate = mYieldList.Read(_YieldPaymentName, mSourceID, mYieldDate, _Term).Rate;

        //                _ValueParityPayment = Math.Pow((1 + _Rate / 100.0), -_TermBasis);

        //                _Parity = (_ParityPayment.Parity / _ParityOriginal.Parity) * (_ValueParityOriginal / _ValueParityPayment);
        //                _Coupon.InterestEndConvertion = _Coupon.InterestFlow * _Parity;
        //                _Coupon.InterestTransferEndConvertion = _Coupon.InterestTransferFlow * _Parity;
        //            }

        //            // Determinacion de los factores de descuento relevantes a partir de las tasas df curva moneda origen
        //            _Coupon.InterestEnd = _Coupon.InterestFlow * _ValueParityOriginal;
        //            _Coupon.InterestTransferFlow = _Coupon.InterestTransferProposed * _Parity;
        //            mFlow.setFlow(_Row, _Coupon);
        //        }

        //        //_Coupon.AmortizationFlowConvertion = _Coupon.AmortizationFlow * _Parity;
        //        //_Coupon.FlowConvertion = _Coupon.Flow * _Parity;

        //    }
        //}

        #endregion

        #region "Source Old CalculatePresentValueAmortization"

        //private void CalculatePresentValueAmortization(int _CouponCurrent)
        //{
        //    DateTime _StartingDate;
        //    StructDevelopmentTable _Coupon;
        //    Basis _Basis;
        //    int _Row;
        //    int _Term = 0;
        //    double _TermBasis = 0;
        //    double _Rate = 0;
        //    double _Parity = 0;
        //    string _YieldOriginalName = "";
        //    CurrencyValue _ParityOriginal;
        //    double _ValueParityOriginal;
        //    CurrencyValue _ParityPayment;
        //    string _YieldPaymentName;
        //    double _ValueParityPayment;
        //    Yield.Yield _YieldOriginal;
        //    YieldPoint _YieldPoint;

        //    _StartingDate = mFlow.getFlow(0).StartingDate;

        //    // Determinacion de los factores de descuento relevantes para los flujos de interes
        //    for (_Row = _CouponCurrent; _Row < mFlow.Count(); _Row++)
        //    {

        //        _Coupon = mFlow.getFlow(_Row);

        //        if (_Coupon.ExchangeNotionalType == enumExchangeNotional.Yes)
        //        {

        //            // Rescata el nombre de la curva original
        //            _YieldOriginalName = mYieldDiscountID; // mCurrencyList.Read(mCurrencyOriginal).YieldID

        //            if (_YieldOriginalName.Equals(""))
        //            {
        //                _YieldOriginalName = mYieldProjectedID;
        //            }

        //            _YieldOriginal = mYieldList.Read(_YieldOriginalName);

        //            // calcula el factor de descuento
        //            _Basis = new Basis(_YieldOriginal.Basis, mValuatorDate, _Coupon.PaymentDate);
        //            _Term = (int)_Basis.Term;
        //            _TermBasis = (double)_Basis.TermBasis;

        //            // Recupera el registro de la moneda y fecha.
        //            //_ParityOriginal = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mValuatorDate);
        //            _ParityOriginal = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mCurrencyDate);

        //            // Obtiene el valor de la tasa en el plazo.
        //            //_YieldPoint = mYieldList.Read(_YieldOriginalName, mSourceID, mValuatorDate, _Term);
        //            _YieldPoint = mYieldList.Read(_YieldOriginalName, mSourceID, mYieldDate, _Term);
        //            _Rate = _YieldPoint.Rate;

        //            _ValueParityOriginal = Math.Pow((1 + _Rate / 100.0), -_TermBasis);

        //            // Rescata el valor de la moneda
        //            //_ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mValuatorDate);
        //            _ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mCurrencyDate);

        //            if (!mCurrencyOriginal.Equals(mCurrencyPayment))
        //            {
        //                _YieldPaymentName = mCurrencyList.Read(mCurrencyPayment).CurveID;

        //                // Obtiene el valor de la tasa en el plazo.
        //                //_Rate = mYieldList.Read(_YieldPaymentName, mSourceID, mValuatorDate, _Term).Rate;
        //                _Rate = mYieldList.Read(_YieldPaymentName, mSourceID, mYieldDate, _Term).Rate;

        //                _ValueParityPayment = Math.Pow((1 + _Rate / 100.0), -_TermBasis);

        //                _Parity = (_ParityPayment.Parity / _ParityOriginal.Parity) * (_ValueParityOriginal / _ValueParityPayment);
        //                _Coupon.AmortizationFlow = _Coupon.AmortizationEndConvertion * _Parity;
        //            }

        //            // Determinacion de los factores de descuento relevantes a partir de las tasas df curva moneda origen
        //            _Coupon.AmortizationEnd = _Coupon.AmortizationFlow* _ValueParityOriginal;
        //            mFlow.setFlow(_Row, _Coupon);
        //        }

        //    }
        //}

        #endregion

        #region "Source Old CalculatePresentValueAditional"

        //private void CalculatePresentValueAditional(int _CouponCurrent)
        //{
        //    DateTime _StartingDate;
        //    StructDevelopmentTable _Coupon;
        //    Basis _Basis;
        //    int _Row;
        //    int _Term = 0;
        //    double _TermBasis = 0;
        //    double _Rate = 0;
        //    double _Parity = 0;
        //    string _YieldOriginalName = "";
        //    CurrencyValue _ParityOriginal;
        //    double _ValueParityOriginal;
        //    CurrencyValue _ParityPayment;
        //    string _YieldPaymentName;
        //    double _ValueParityPayment;
        //    Yield.Yield _YieldOriginal;
        //    YieldPoint _YieldPoint;

        //    _StartingDate = mFlow.getFlow(0).StartingDate;

        //    // Determinacion de los factores de descuento relevantes para los flujos de interes
        //    for (_Row = _CouponCurrent; _Row < mFlow.Count(); _Row++)
        //    {

        //        _Coupon = mFlow.getFlow(_Row);

        //        if (_Coupon.InterestProposed.Equals(0))
        //        {
        //            // Rescata el nombre de la curva original
        //            _YieldOriginalName = mCurrencyList.Read(mCurrencyOriginal).CurveID;

        //            _YieldOriginal = mYieldList.Read(_YieldOriginalName);

        //            // calcula el factor de descuento
        //            _Basis = new Basis(_YieldOriginal.Basis, mValuatorDate, _Coupon.ExpiryDate);
        //            _Term = (int)_Basis.Term;
        //            _TermBasis = _Basis.TermBasis;

        //            // Recupera el registro de la moneda y fecha.
        //            //_ParityOriginal = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mValuatorDate);
        //            _ParityOriginal = mCurrencyList.Read(mCurrencyOriginal, mSourceID, mCurrencyDate);

        //            // Obtiene el valor de la tasa en el plazo.
        //            //_YieldPoint = mYieldList.Read(_YieldOriginalName, mSourceID, mValuatorDate, _Term);
        //            _YieldPoint = mYieldList.Read(_YieldOriginalName, mSourceID, mYieldDate, _Term);
        //            _Rate = _YieldPoint.Rate;

        //            _ValueParityOriginal = Math.Pow((1 + _Rate / 100.0), -_TermBasis);

        //            // Rescata el valor de la moneda
        //            //_ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mValuatorDate);
        //            _ParityPayment = mCurrencyList.Read(mCurrencyPayment, mSourceID, mCurrencyDate);

        //            if (!mCurrencyOriginal.Equals(mCurrencyPayment))
        //            {
        //                _YieldPaymentName = mCurrencyList.Read(mCurrencyPayment).CurveID;

        //                // Obtiene el valor de la tasa en el plazo.
        //                //_Rate = mYieldList.Read(_YieldPaymentName, mSourceID, mValuatorDate, _Term).Rate;
        //                _Rate = mYieldList.Read(_YieldPaymentName, mSourceID, mYieldDate, _Term).Rate;

        //                _ValueParityPayment = Math.Pow((1 + _Rate / 100.0), -_Term);

        //                _Parity = (_ParityPayment.Parity / _ParityOriginal.Parity) * (_ValueParityOriginal / _ValueParityPayment);
        //                _Coupon.AditionalsFlowConvertion = _Coupon.AditionalsFlowValue * _Parity;
        //            }

        //            // Determinacion de los factores de descuento relevantes a partir de las tasas df curva moneda origen
        //            _Coupon.AditionalsFlow = _Coupon.AditionalsFlowValue * _ValueParityOriginal;
        //            mFlow.setFlow(_Row, _Coupon);
        //        }

        //    }
        //}

        #endregion

        #endregion

        private void Set(
                          SwapLeg flow,
                          int rateID,
                          enumSource sourceID,
                          enumPeriod periodID,
                          int currencyID,
                          RateList rateList,
                          String yieldProjectedID,
                          String yieldDiscountID,
                          enumBasisCurve yieldBasis,
                          YieldList yieldList,
                          int currencyOriginal,
                          int currencyPayment,
                          int currencyAssets,
                          CurrencyList currencyList,
                          int termBenchmark,
                          int resetDays,
                          enumIndexType indexType,
                          enumIntervalType indexIntervalType,
                          int indexIntervalNumber,
                          int indexBrokenPeriod,
                          enumConvention indexConvention,
                          enumBasis indexBasis,
                          int indexCalendarType,
                          Calendars indexCalendar,
                          enumBasis indexPartialBasis,
                          enumAddressGenerationFixing indexAddressGenerationFixing,
                          enumIntervalType indexStartingIntervalType,
                          int indexStartingIntervalNumber,
                          enumIntervalType indexExpiryIntervalType,
                          int indexExpiryIntervalNumber,
                          enumConvention indexConventionAccrual,
                          int indexCalendarAccrualType,
                          Calendars indexCalendarAccrual,
                          enumIntervalType indexMicroCalendarIntervalType,
                          int indexMicroCalendarIntervalNumber,
                          enumConvention indexMicroCalendarConvention,
                          int indexMicroCalendarType,
                          Calendars indexMicroCalendar,
                          enumFormulaIndexCalculation indexFormulaIndexCalculation,
                          enumBasis indexEndBasis,
                          int holidayChile,
                          int holidayEEUU,
                          int holidayEnglan
                      )
        {

            mFlow = flow;

            mRateID = rateID;
            mCurrencyID = currencyID;
            mPeriodID = periodID;
            mRateList = rateList;

            mYieldProjectedID = yieldProjectedID;
            mYieldDiscountID = yieldDiscountID;
            mYieldBasis = yieldBasis;
            mYieldList = yieldList;

            mCurrencyOriginal = currencyOriginal;
            mCurrencyPayment = currencyPayment;
            mCurrencyAssets = currencyAssets;
            mCurrencyList = currencyList;
            mTermBenchmark = termBenchmark;
            mResetDays = resetDays;

            mSourceID = sourceID;
            mIndexType = indexType;
            mIndexIntervalType = indexIntervalType;
            mIndexIntervalNumber = indexIntervalNumber;
            mIndexBrokenPeriod = indexBrokenPeriod;
            mIndexConvention = indexConvention;
            mIndexBasis = indexBasis;
            mIndexCalendarType = indexCalendarType;
            mIndexCalendar = indexCalendar;

            mIndexPartialBasis = indexPartialBasis;
            mIndexAddressGenerationFixing = indexAddressGenerationFixing;
            mIndexStartingIntervalType = indexStartingIntervalType;
            mIndexStartingIntervalNumber = indexStartingIntervalNumber;
            mIndexExpiryIntervalType = indexExpiryIntervalType;
            mIndexExpiryIntervalNumber = indexExpiryIntervalNumber;
            mIndexConventionAccrual = indexConventionAccrual;
            mIndexCalendarAccrualType = indexCalendarAccrualType;
            mIndexCalendarAccrual = indexCalendarAccrual;
            mIndexMicroCalendarIntervalType = indexMicroCalendarIntervalType;
            mIndexMicroCalendarIntervalNumber = indexMicroCalendarIntervalNumber;
            mIndexMicroCalendarConvention = indexMicroCalendarConvention;
            mIndexMicroCalendarType = indexMicroCalendarType;
            mIndexMicroCalendar = indexMicroCalendar;
            mIndexFormulaIndexCalculation = indexFormulaIndexCalculation;
            mIndexEndBasis = indexEndBasis;
            mPresentValue = 0;
            mHolidayChile = holidayChile;
            mHolidayEEUU = holidayEEUU;
            mHolidayEnglan = holidayEnglan;

            mCashFlow = 0;

        }

        #endregion

    }

}
