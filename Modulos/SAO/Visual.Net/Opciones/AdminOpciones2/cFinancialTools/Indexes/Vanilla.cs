using System;
using System.Collections.Generic;
using System.Text;
using cFinancialTools.BussineDate;
using cFinancialTools.Rate;
using cFinancialTools.Yield;
using cData.Rate;

namespace cFinancialTools.Indexes
{

    public class Vanilla
    {

        #region "Variables"

        private DateTime mValuatorDate;                         // Fecha Valoración
        private DateTime mYieldDate;                            // Fecha de Curvas
        private DateTime mStartingDate;                         // Fecha Inicio
        private DateTime mExpiryDate;                           // Fecha Termino
        private DateTime mFixingDate;                           // Fecha Fijación
        private int mTermBenchmark;                             // Plazo Benchmark
        private int mResetDays;                                 // Dias Reset
        private enumSource mSourceID;                           // Fuente de Datos
        private int mRateID;                                    // Código de Tasa
        private double mRate;                                   // Tasa a Aplicar
        private int mCurrencyID;                                // Código de la Moneda
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

        private int mHolidayChile;
        private int mHolidayEEUU;
        private int mHolidayEnglan;

        #endregion

        #region "Constructor"

        public Vanilla()
        {
            DateTime _Date = new DateTime(1900,1,1);
            RateList _HistoryRate = new RateList();
            YieldList _HistoryYield = new YieldList();
            cFinancialTools.BussineDate.Calendars _Calendar = new Calendars();
            _Calendar.Load();

            Set(
                    _Date,
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
                    _HistoryRate,
                    "",
                    _HistoryYield,
                    enumBasisCurve.YieldAct360,
                    enumIntervalType.Month,
                    0,
                    0,
                    enumConvention.Next,
                    enumBasis.Basis_Act_360,
                    _Calendar,
                    0,
                    0,
                    0
               );
        }

        public Vanilla(
                        DateTime valuatorDate,
                        DateTime yieldDate,
                        DateTime startingDate,
                        DateTime expiryDate,
                        DateTime fixingDate,
                        int termBenchmark,
                        int resetDays,
                        int rateID,
                        double rate,
                        enumSource sourceID,
                        enumPeriod periodID,
                        int currencyID,
                        RateList historyRate,
                        String curveID,
                        YieldList hitoryYield,
                        enumBasisCurve basisCurve,
                        enumIntervalType intervalType,
                        int intervalNumber,
                        int brokenPeriod,
                        enumConvention convention,
                        enumBasis basis,
                        Calendars calendar,
                        int holidayChile,
                        int holidayEEUU,
                        int holidayEnglan
                      )
        {
            Set(
                 valuatorDate,
                 yieldDate,
                 startingDate,
                 expiryDate,
                 fixingDate,
                 termBenchmark,
                 resetDays,
                 rateID,
                 rate,
                 sourceID,
                 periodID,
                 currencyID,
                 historyRate,
                 curveID,
                 hitoryYield,
                 basisCurve,
                 intervalType,
                 intervalNumber,
                 brokenPeriod,
                 convention,
                 basis,
                 calendar,
                 holidayChile,
                 holidayEEUU,
                 holidayEnglan
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

        public DateTime FixingDate
        {
            get
            {
                return mFixingDate;
            }
            set
            {
                mFixingDate = value;
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
                                 DateTime fixingDate,
                                 int termBenchmark,
                                 int resetDays,
                                 int rateID,
                                 enumPeriod periodID,
                                 int currencyID,
                                 RateList historyRate,
                                 String curveID,
                                 YieldList historyYield,
                                 enumBasisCurve basisCurve,
                                 enumIntervalType intervalType,
                                 int intervalNumber,
                                 int brokenPeriod,
                                 enumConvention convention,
                                 enumBasis basis,
                                 Calendars calendar,
                                 int holidayChile,
                                 int holidayEEUU,
                                 int holidayEnglan
                               )
        {

            #region "Seteo de valores"

            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mStartingDate = startingDate;
            mExpiryDate = expiryDate;
            mFixingDate = fixingDate;
            mTermBenchmark = termBenchmark;
            mResetDays = resetDays;
            mRateID = rateID;
            mCurrencyID = currencyID;
            mPeriodID = periodID;
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
            mHolidayChile = holidayChile;
            mHolidayEEUU = holidayEEUU;
            mHolidayEnglan = holidayEnglan;

            #endregion

            return Calculate();
        }

        public Double Calculate()
        {

            Double _Rate = 0;
            bool _InterpolateRate = false;
            cFinancialTools.Rate.RateValue _RateValue = new cFinancialTools.Rate.RateValue();

            if (mValuatorDate >= mFixingDate)
            {
                _Rate = mRate;
                //******************************************************************************************************************************//
                // Ver la forma para obtener el ultimo elemento del arreglo en el caso de que no exista la fecha en que se conoce la tasa.      //
                //******************************************************************************************************************************//

            }
            else
            {
                _InterpolateRate = true;

            }

            if (_InterpolateRate)
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
                int _Days;

                // Calculo de la Fecha de Fijacion
                //_Date = new cFinancialTools.BussineDate.BussineDate(mStartingDate);
                //_Date.Value = _Date.MovesDate(enumIntervalType.DayHoliday, mBrokenPeriod, enumConvention.NotAdjusted, mCalendar);
                //_StartingDate = mStartingDate;
                _StartingDate = mFixingDate;

                for (_Days = 1; _Days <= mResetDays; _Days++)
                {
                    _StartingDate = _StartingDate.AddDays(1);
                    while (
                            (!mCalendar.IsBussineDay(6, _StartingDate) && mHolidayChile.Equals(1)) ||
                            (!mCalendar.IsBussineDay(225, _StartingDate) && mHolidayEEUU.Equals(1)) || 
                            (!mCalendar.IsBussineDay(510, _StartingDate) && mHolidayEnglan.Equals(1)) ||
                            (_StartingDate.DayOfWeek == DayOfWeek.Saturday) || (_StartingDate.DayOfWeek == DayOfWeek.Sunday))
                    {
                        _StartingDate = _StartingDate.AddDays(1);
                    }
                    //_StartingDate = mCalendar.NextHolidayDate(6, _StartingDate);
                }

                _StartingTerm = DateDiffDays(_StartingDate, mValuatorDate);
                _ExpiryTerm = _StartingTerm + mTermBenchmark;

                _ExpiryDate = _StartingDate.AddDays(_ExpiryTerm); //_Date.MovesDate(mIntervalType, mIntervalNumber, mConvention, mCalendar);

                //_CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mValuatorDate);
                _CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mYieldDate);
                _StartingRate = _CurveValue.Read((int)_StartingTerm).Rate;
                mRateStarting = _StartingRate;

                //_CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mValuatorDate);
                _CurveValue = (YieldValue)mHistoryYield.Read(mCurveID, mSourceID, mYieldDate);
                _ExpiryRate = _CurveValue.Read((int)_ExpiryTerm).Rate;
                mRateExpiry = _ExpiryRate;

                if (mBasisCurve == enumBasisCurve.YieldAct365)
                {
                    _ConventionCurve = (double)365;
                }

                _StartingRate = Math.Pow((1.0 + _StartingRate / 100.0), _StartingTerm / _ConventionCurve);
                _ExpiryRate = Math.Pow((1.0 + _ExpiryRate / 100.0 ), _ExpiryTerm / _ConventionCurve);

                mFactorRateStarting = _StartingRate;
                mFactorRateExpiry = _ExpiryRate;

                //_Basis = new cFinancialTools.DayCounters.Basis(mBasis, _StartingDate, _ExpiryDate);
                mFactorRateFra = (360.0 / (_ExpiryTerm - _StartingTerm));
                _Rate = ((_ExpiryRate / _StartingRate) - 1.0) * mFactorRateFra * 100.0;

                mRateFra = _Rate;

            }

            return _Rate;
        }


        #endregion

        #region "Funciones Protegidas"

        private Double DateDiffDays(DateTime startingDate, DateTime expiryDate)
        {
            BussineDate.BussineDate _StartingDate = new cFinancialTools.BussineDate.BussineDate(startingDate);
            BussineDate.BussineDate _ExpiryDate = new cFinancialTools.BussineDate.BussineDate(expiryDate);

            return (_StartingDate.DayOfYears - _ExpiryDate.DayOfYears); 
        }

        private void Set(
                            DateTime valuatorDate,
                            DateTime yieldDate,
                            DateTime startingDate,
                            DateTime expiryDate,
                            DateTime fixingDate,
                            int termBenchmark,
                            int resetDays,
                            int rateID,
                            double rate,
                            enumSource sourceID,
                            enumPeriod periodID,
                            int currencyID,
                            RateList historyRate,
                            String curveID,
                            YieldList historyYield,
                            enumBasisCurve basisCurve,
                            enumIntervalType intervalType,
                            int intervalNumber,
                            int brokenPeriod,
                            enumConvention convention,
                            enumBasis basis,
                            Calendars calendar,
                            int holidayChile,
                            int holidayEEUU,
                            int holidayEnglan
                          )
        {

            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mStartingDate = startingDate;
            mExpiryDate = expiryDate;
            mFixingDate = fixingDate;
            mTermBenchmark = termBenchmark;
            mResetDays = resetDays;
            mRateID = rateID;
            mRate = rate;
            mSourceID = sourceID;
            mPeriodID = periodID;
            mCurrencyID = currencyID;
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
            mHolidayChile = holidayChile;
            mHolidayEEUU = holidayEEUU;
            mHolidayEnglan = holidayEnglan;
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
