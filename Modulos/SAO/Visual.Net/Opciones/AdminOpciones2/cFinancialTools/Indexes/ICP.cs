using System;
using System.Collections;
using System.Text;
using cFinancialTools.BussineDate;
using cFinancialTools.Yield;
using cFinancialTools.Currency;
using cFinancialTools.Rate;

namespace cFinancialTools.Indexes
{
    public class ICP
    {

        #region "Variables"

        private DateTime mValuatorDate;                         // Fecha Valoración
        private DateTime mYieldDate;                            // Fecha Curva
        private DateTime mStartingDate;                         // Fecha Inicio
        private DateTime mExpiryDate;                           // Fecha Termino
        private int mTermBenchmark;                             // Plazo Benchmark
        private int mResetDays;                                 // Dias Reset
        private enumSource mSourceID;                           // Fuente de Datos
        private int mRateID;                                    // Código de Tasa
        private double mRate;                                   // Tasa a Aplicar
        private int mCurrencyID;                                // Código de la Moneda
        private CurrencyList mHistoryCurrency;                  // Valores de Monedas Historicas
        private enumPeriod mPeriodID;                           // Código del Periodo
        private RateList mHistoryRate;                          // Tasa e Indices Historicos
        private String mCurveID;                                // Código de la Curva
        private YieldList mHistoryYield;                        // Curvas Historicas
        private enumBasisCurve mBasisCurve;                     // Base Curva 1 Yield Act/360 y 2 Yield Act/365
        private enumIntervalType mIntervalType;                 // Tipo de Intervalo
        private int mIntervalNumber;                            // Número de Interval
        private int mBrokenPeriod;                              // Rezago Indice
        private enumConvention mConvention;                     // Convención
        private enumBasis mBasis;                               // Base
        private Calendars mCalendar;                            // Calendario días inhabiles

        private double mRateStarting;
        private double mFactorRateStarting;
        private double mRateExpiry;
        private double mFactorRateExpiry;
        private double mRateFra;
        private double mFactorRateFra;

        #endregion

        #region "Constructor"

        public ICP()
        {
            DateTime _Date = new DateTime(1900,1,1);
            CurrencyList _HistoryCurrency = new CurrencyList();
            RateList _HistoryRate = new RateList();
            YieldList _HistoryYield = new YieldList();
            cFinancialTools.BussineDate.Calendars _Calendar = new Calendars();
            _Calendar.Load();

            Set(
                 _Date,
                 _Date,
                 _Date,
                 _Date,
                 0,
                 0,
                 0,
                 0,
                 enumSource.System,
                 enumPeriod.Anual,
                 0,
                 _HistoryCurrency,
                 _HistoryRate,
                 "",
                 _HistoryYield,
                 enumBasisCurve.YieldAct360,
                 enumIntervalType.Month,
                 0,
                 0,
                 enumConvention.Next,
                 enumBasis.Basis_Act_360,
                 _Calendar
               );

        }

        public ICP(
                    DateTime valuatorDate,
                    DateTime yieldDate,
                    DateTime startingDate,
                    DateTime expiryDate,
                    int termBenchmark,
                    int resetDays,
                    int rateID,
                    double rate,
                    enumSource sourceID,
                    enumPeriod periodID,
                    int currencyID,
                    CurrencyList historyCurrency,
                    RateList historyRate,
                    String curveID,
                    YieldList hitoryYield,
                    enumBasisCurve basisCurve,
                    enumIntervalType intervalType,
                    int intervalNumber,
                    int brokenPeriod,
                    enumConvention convention,
                    enumBasis basis,
                    Calendars calendar
                  )
        {

            Set(
                 valuatorDate,
                 yieldDate,
                 startingDate,
                 expiryDate,
                 termBenchmark,
                 resetDays,
                 rateID,
                 rate,
                 sourceID,
                 periodID,
                 currencyID,
                 historyCurrency,
                 historyRate,
                 curveID,
                 hitoryYield,
                 basisCurve,
                 intervalType,
                 intervalNumber,
                 brokenPeriod,
                 convention,
                 basis,
                 calendar
               );

        }

        #endregion

        #region "Property"

        // Fecha Valoración
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

        // Fecha Curva
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

        // Fecha Inicio
        public DateTime StartingDate
        {
            get
            {
                return mStartingDate;
            }
            set
            {
                mStartingDate = value;
            }
        }

        // Fecha Vencimiento
        public DateTime ExpiryDate
        {
            get
            {
                return mExpiryDate;
            }
            set
            {
                mExpiryDate = value;
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

        // Tasa e Indices Historicos
        public RateList HistoryRate
        {
            get
            {
                return mHistoryRate;
            }
            set
            {
                mHistoryRate = value;
            }
        }

        // Curvas Historicas
        public YieldList HistoryYield
        {
            get
            {
                return mHistoryYield;
            }
            set
            {
                mHistoryYield = value;
            }
        }

        // Base Curva 1 Yield Act/360 y 2 Yield Act/365
        public enumBasisCurve BasisCurve
        {
            get
            {
                return mBasisCurve;
            }
            set
            {
                mBasisCurve = value;
            }
        }

        // Tipo de Intervalo
        public enumIntervalType IntervalType
        {
            get
            {
                return mIntervalType;
            }
            set
            {
                mIntervalType = value;
            }
        }

        // Número de Interval
        public int IntervalNumber
        {
            get
            {
                return mIntervalNumber;
            }
            set
            {
                mIntervalNumber = value;
            }
        }

        // Rezago Indice
        public int BrokenPeriod
        {
            get
            {
                return mBrokenPeriod;
            }
            set
            {
                mBrokenPeriod = value;
            }
        }

        // Convención
        public enumConvention Convention
        {
            get
            {
                return mConvention;
            }
            set
            {
                mConvention = value;
            }
        }
        
        // Base
        public enumBasis Basis
        {
            get
            {
                return mBasis;
            }
            set
            {
                mBasis = value;
            }
        }

        // Calendario días inhabiles
        public Calendars Calendar
        {
            get
            {
                return mCalendar;
            }
            set
            {
                mCalendar = value;
            }
        }

        public double RateStarting
        {

            get
            {
                return mRateStarting;
            }

        }

        public double FactorRateStarting
        {

            get
            {
                return mFactorRateStarting;
            }

        }

        public double RateExpiry
        {

            get
            {
                return mRateExpiry;
            }

        }

        public double FactorRateExpiry
        {

            get
            {
                return mFactorRateExpiry;
            }

        }

        public double RateFra
        {

            get
            {
                return mRateFra;
            }

        }

        public double FactorRateFra
        {

            get
            {
                return mFactorRateFra;
            }

        }

        #endregion

        #region "Funciones Publicas"

        public Double Calculate(
                                 DateTime valuatorDate,
                                 DateTime yieldDate,
                                 DateTime startingDate,
                                 DateTime expiryDate,
                                 int termBenchmark,
                                 int resetDays,
                                 int rateID,
                                 enumPeriod periodID,
                                 int currencyID,
                                 CurrencyList historyCurrency,
                                 RateList historyRate,
                                 String curveID,
                                 YieldList historyYield,
                                 enumBasisCurve basisCurve,
                                 enumIntervalType intervalType,
                                 int intervalNumber,
                                 int brokenPeriod,
                                 enumConvention convention,
                                 enumBasis basis,
                                 Calendars calendar
                               )
        {

            #region "Seteo de Variables"

            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mStartingDate = startingDate;
            mExpiryDate = expiryDate;
            mTermBenchmark = termBenchmark;
            mResetDays = resetDays;
            mRateID = rateID;
            mCurrencyID = currencyID;
            mPeriodID = periodID;
            mHistoryCurrency = historyCurrency;
            mHistoryRate = historyRate;
            mCurveID = curveID;
            mHistoryYield = historyYield;
            mBasisCurve = basisCurve;
            mIntervalType = intervalType;
            mIntervalNumber = intervalNumber;
            mBrokenPeriod = brokenPeriod;
            mConvention = convention;
            mBasis = basis;
            mCalendar = calendar;

            #endregion

            return Calculate();

        }

        public Double Calculate()
        {

            Double _Rate = 0;
            cFinancialTools.Rate.RateValue _RateValue = new cFinancialTools.Rate.RateValue();

            if (mValuatorDate >= mExpiryDate)
            {
                _Rate = mRate;
                //******************************************************************************************************************************//
                // Ver la forma para obtener el ultimo elemento del arreglo en el caso de que no exista la fecha en que se conoce la tasa.      //
                //******************************************************************************************************************************//

            }
            else if (mValuatorDate > mStartingDate)
            {
                //**************************************************************************************************************************//
                // Calculo de tasa forward                                                                                                  //
                //**************************************************************************************************************************//
                DateTime _StartingDate;
                DateTime _ExpiryDate;
                double _StartingTerm;
                double _ExpiryTerm;
                double _StartingRate;
                double _ExpiryRate;
                double _ExpiryRate_1;
                double _ExpiryRate_2;
                double _ConventionCurve = 360;
                YieldValue _CurveValue;

                // Calculo de la Fecha de Fijacion
                _StartingDate = mStartingDate;

                _StartingTerm = DateDiffDays(_StartingDate, mValuatorDate);
                _ExpiryTerm = DateDiffDays(mValuatorDate, mExpiryDate);

                _ExpiryDate = _StartingDate.AddDays(_ExpiryTerm); //_Date.MovesDate(mIntervalType, mIntervalNumber, mConvention, mCalendar);

                _StartingRate = RateICP(); // Calculo de la Tasa ICP ==> Valor Anterio : mRate;
                mRateStarting = _StartingRate;

                if (mBasisCurve == enumBasisCurve.YieldAct365)
                {
                    _ConventionCurve = (double)365;
                }

                //_CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mValuatorDate);
                _CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mYieldDate);
                _ExpiryRate_1 = _CurveValue.Read(0).Rate;
                _ExpiryRate_2 = _CurveValue.Read((int)_ExpiryTerm).Rate;

                _ExpiryRate_1 = 0; //Math.Pow((1.0 + _ExpiryRate_1 * 0.01), _StartingTerm / _ConventionCurve);
                _ExpiryRate_2 = Math.Pow((1.0 + _ExpiryRate_2 * 0.01), _ExpiryTerm / _ConventionCurve);

                _ExpiryRate = ((_ExpiryRate_2 - 1.0) * _ConventionCurve / _ExpiryTerm) * 100.0;
                mRateExpiry = _ExpiryRate;

                _StartingRate = 1.0 + _StartingRate * 0.01 * _StartingTerm / _ConventionCurve;
                _ExpiryRate = 1.0 + _ExpiryRate * 0.01 * _ExpiryTerm / _ConventionCurve;

                mFactorRateStarting = _StartingRate;
                mFactorRateExpiry = _ExpiryRate;

                //_Basis = new cFinancialTools.DayCounters.Basis(mBasis, _StartingDate, _ExpiryDate);
                mFactorRateFra = _ConventionCurve / DateDiffDays(_StartingDate, mExpiryDate);
                _Rate = ((_StartingRate * _ExpiryRate) - 1.0) * mFactorRateFra * 100.0;

                mRateFra = _Rate;

            }
            else if (mValuatorDate <= mStartingDate)
            {
                //**************************************************************************************************************************//
                // Calculo de tasa forward                                                                                                  //
                //**************************************************************************************************************************//
                DateTime _StartingDate;
                DateTime _ExpiryDate;
                double _StartingTerm;
                double _ExpiryTerm;
                double _StartingRate;
                double _ExpiryRate;
                double _ConventionCurve = 360;
                YieldValue _CurveValue;

                // Calculo de la Fecha de Fijacion
                if (mBasisCurve == enumBasisCurve.YieldAct365)
                {
                    _ConventionCurve = (double)365;
                }

                _StartingDate = mStartingDate;

                _StartingTerm = DateDiffDays(mValuatorDate, _StartingDate);

                _ExpiryDate = mExpiryDate;
                _ExpiryTerm = DateDiffDays(mValuatorDate, mExpiryDate);

                //_CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mValuatorDate);
                _CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mYieldDate);
                _StartingRate = _CurveValue.Read((int)_StartingTerm).Rate;
                mRateStarting = _StartingRate;

                //_CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mValuatorDate);
                _CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mYieldDate);
                _ExpiryRate = _CurveValue.Read((int)_ExpiryTerm).Rate;
                mRateExpiry = _ExpiryRate;

                _StartingRate = Math.Pow((1.0 + _StartingRate * 0.01), _StartingTerm / _ConventionCurve);
                _ExpiryRate = Math.Pow((1.0 + _ExpiryRate * 0.01), _ExpiryTerm / _ConventionCurve);
                mFactorRateStarting = _StartingRate;
                mFactorRateExpiry = _ExpiryRate;

                if ((_ExpiryRate / _StartingRate) == 1.0)
                {
                    _Rate = 0;
                    mFactorRateFra = 0;

                }
                else
                {
                    mFactorRateFra = (360.0 / (_ExpiryTerm - _StartingTerm));
                    _Rate = ((_ExpiryRate / _StartingRate) - 1.0) * mFactorRateFra * 100.0;
                }

                mRateFra = _Rate;

            }

            return _Rate;

        }

        #endregion

        #region "Funciones Privadas"

        protected double RateICP()
        {

            #region "Variable Definition"

            double _RateICP;
            double _StartingICP;
            double _TodayICP;
            double _StartingUF;
            double _TodayUF;
            double _ICP360;
            double _VariationUF;
            double _BasisICP;

            #endregion

            #region "Assing Value"

            _BasisICP = 36000.0;
            cFinancialTools.DayCounters.Basis _TermToday = new cFinancialTools.DayCounters.Basis();

            _TermToday = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, mStartingDate, mValuatorDate);

            #endregion

            #region "Load ICP and UF"

            mHistoryCurrency.Load(800, enumSource.System, mStartingDate, "");
            mHistoryCurrency.Load(800, enumSource.System, mValuatorDate, "");
            mHistoryCurrency.Load(998, enumSource.System, mStartingDate, "");

            #endregion

            #region "Assign ICP and UF"

            _StartingICP = mHistoryCurrency.Read(800, enumSource.System, mStartingDate).ExchangeRate;
            _TodayICP = mHistoryCurrency.Read(800, enumSource.System, mValuatorDate).ExchangeRate;

            _StartingUF = mHistoryCurrency.Read(998, enumSource.System, mStartingDate).ExchangeRate;
            _TodayUF = mHistoryCurrency.Read(998, enumSource.System, mValuatorDate).ExchangeRate;

            #endregion

            #region "Calculate ICP basis 360 and UF Variation"

            _VariationUF = (_TodayUF / _StartingUF);
            _ICP360 = ((_TodayICP / _StartingICP) - 1.0) * (_BasisICP / _TermToday.Term);

            #endregion

            #region "Calculate Rate"

            if (mCurrencyID.Equals(998))
            {
                _RateICP = Math.Round(((Math.Round(_ICP360, 2) * _TermToday.Term / _BasisICP) - (_VariationUF - 1.0)) / _VariationUF * _BasisICP / _TermToday.Term, 4);
            }
            else
            {
                _RateICP = Math.Round(_ICP360, 2);
            }

            #endregion

            return _RateICP;

        }

        private Double DateDiffDays(DateTime startingDate, DateTime expiryDate)
        {

            BussineDate.BussineDate _StartingDate = new cFinancialTools.BussineDate.BussineDate(startingDate);
            BussineDate.BussineDate _ExpiryDate = new cFinancialTools.BussineDate.BussineDate(expiryDate);

            return (_ExpiryDate.DayOfYears - _StartingDate.DayOfYears); 

        }

        private void Set(
                          DateTime valuatorDate,
                          DateTime yieldDate,
                          DateTime startingDate,
                          DateTime expiryDate,
                          int termBenchmark,
                          int resetDays,
                          int rateID,
                          double rate,
                          enumSource sourceID,
                          enumPeriod periodID,
                          int currencyID,
                          CurrencyList historyCurrency,
                          RateList historyRate,
                          String curveID,
                          YieldList historyYield,
                          enumBasisCurve basisCurve,
                          enumIntervalType intervalType,
                          int intervalNumber,
                          int brokenPeriod,
                          enumConvention convention,
                          enumBasis basis,
                          Calendars calendar
                        )
        {

            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mStartingDate = startingDate;
            mExpiryDate = expiryDate;
            mTermBenchmark = termBenchmark;
            mResetDays = resetDays;
            mRateID = rateID;
            mRate = rate;
            mSourceID = sourceID;
            mPeriodID = periodID;
            mCurrencyID = currencyID;
            mHistoryCurrency = historyCurrency;
            mHistoryRate = historyRate;
            mCurveID = curveID;
            mHistoryYield = historyYield;
            mBasisCurve = basisCurve;
            mIntervalType = intervalType;
            mIntervalNumber = intervalNumber;
            mBrokenPeriod = brokenPeriod;
            mConvention = convention;
            mBasis = basis;
            mCalendar = calendar;
            mRateStarting = 0;
            mFactorRateStarting = 0;
            mRateExpiry = 0;
            mFactorRateExpiry = 0;
            mRateFra = 0;
            mFactorRateFra = 0;

        }

        #endregion

    }
}
