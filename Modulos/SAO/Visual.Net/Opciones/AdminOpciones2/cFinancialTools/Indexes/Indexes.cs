using System;
using System.Collections;
using System.Text;
using cFinancialTools.BussineDate;
using cFinancialTools.Yield;
using cFinancialTools.Rate;

namespace cFinancialTools.Indexes
{

    public class Indexes
    {

        #region "Definición de Variables"

        private DateTime mValuatorDate;                                     // Fecha Valoración
        private DateTime mYieldDate;                                        // Fecha Curva
        private enumSource mSourceID;                                       // Fuente de Datos
        private int mRateID;                                                // Código de Tasa
        private int mCurrencyID;                                            // Código de la Moneda
        private enumPeriod mPeriodID;                                       // Código del Periodo
        private RateList mHistoryRate;                                      // Tasa e Indices Historicos
        private String mCurveID;                                            // Código de la Curva
        private YieldList mHistoryYield;                                    // Curvas Historicas
        private enumBasisCurve mBasisCurve;                                 // Base Curva 1 Yield Act/360 y 2 Yield Act/365
        private enumIntervalType mIntervalType;                             // Tipo de Intervalo
        private int mIntervalNumber;                                        // Número de Interval
        private int mBackwardnessStart;                                     // Rezago Indice
        private enumConvention mConvention;                                 // Convención
        private enumBasis mBasis;                                           // Base
        private Calendars mCalendar;                                        // Calendario días inhabiles
        private int mTermBenchmark;                                         // Plazo Benchmark
        private int mResetDays;                                             // Dias Reset

        private enumAddressGenerationFixing mAddressGenerationFixing;       // Direccion Generacion_fijacion;

        private DateTime mStartingDate;                                     // Fecha Inicio
        private enumIntervalType mStartingIntervalType;                     // Tipo intervalo inicio devengo
        private int mStartingIntervalNumber;                                // Número intervalos inicio devengo

        private DateTime mExpiryDate;                                       // Fecha Termino;
        private enumIntervalType mExpiryIntervalType;                       // Tipo intervalo termino devengo
        private int mExpiryIntervalNumber;                                  // Número intervalos termino devengo
        private enumConvention mConvetionAccrual;                           // Convenio de Devengamiento
        private Calendars mCalendarAccrual;

        private enumIntervalType mMicroCalendarIntervalType;                // Tipo intervalo microcalendario
        private int mMicroCalendarIntervalNumber;                           // Número intervalos Microcalendario
        private enumConvention mMicroCalendarConvention;                    // Convención inhabiles Microcalendario
        private Calendars mMicroCalendar;                                   // Calendario generación microcalendario

        private enumFormulaIndexCalculation mFormulaIndexCalculation;       // formula_calculo_indice_final;
        private enumBasis mBasisIndex;                                      // Base Indice Final

        private int mHolidayChile;
        private int mHolidayEEUU;
        private int mHolidayEnglan;

        #endregion

        #region "Constructor"

        public Indexes()
        {
            DateTime _Date = new DateTime(1900,1,1);
            RateList _HistoryRate = new RateList();
            YieldList _HistoryYield = new YieldList();
            cFinancialTools.BussineDate.Calendars _Calendar = new Calendars();
            _Calendar.Load();

            Set(
                 _Date,
                 _Date,
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
                 enumAddressGenerationFixing.Forward,
                 _Date,
                 enumIntervalType.DayHoliday,
                 0,
                 _Date,
                 enumIntervalType.DayHoliday,
                 0,
                 enumConvention.NotAdjusted,
                 _Calendar,
                 enumIntervalType.DayHoliday,
                 0,
                 enumConvention.NotAdjusted,
                 _Calendar,
                 enumFormulaIndexCalculation.AverageGeometriFactorsCapitalization,
                 enumBasis.Basis_Act_360,
                 0,
                 0,
                 0
               );
        }

        public Indexes(
                        DateTime valuatorDate,
                        DateTime yieldDate,
                        int rateID,
                        enumSource sourceID,
                        enumPeriod periodID,
                        int currencyID,
                        RateList historyRate,
                        String curveID,
                        YieldList hitoryYield,
                        enumBasisCurve basisCurve,
                        enumIntervalType intervalType,
                        int intervalNumber,
                        int backwardnessStart,
                        enumConvention convention,
                        enumBasis basis,
                        Calendars calendar,
                        int termBenchmark,
                        int resetDays,
                        enumAddressGenerationFixing addressGenerationFixing,
                        DateTime startingDate,
                        enumIntervalType startingIntervalType,
                        int startingIntervalNumber,
                        DateTime expiryDate,
                        enumIntervalType expiryIntervalType,
                        int expiryIntervalNumber,
                        enumConvention convetionAccrual,
                        Calendars calendarAccrual,
                        enumIntervalType microCalendarIntervalType,
                        int microCalendarIntervalNumber,
                        enumConvention microCalendarConvention,
                        Calendars microCalendar,
                        enumFormulaIndexCalculation formulaIndexCalculation,
                        enumBasis basisIndex,
                        int holidayChile,
                        int holidayEEUU,
                        int holidayEnglan
                      )
        {
            Set(
                 valuatorDate,
                 yieldDate,
                 rateID,
                 sourceID,
                 periodID,
                 currencyID,
                 historyRate,
                 curveID,
                 hitoryYield,
                 basisCurve,
                 intervalType,
                 intervalNumber,
                 backwardnessStart,
                 convention,
                 basis,
                 calendar,
                 termBenchmark,
                 resetDays,
                 addressGenerationFixing,
                 startingDate,
                 startingIntervalType,
                 startingIntervalNumber,
                 expiryDate,
                 expiryIntervalType,
                 expiryIntervalNumber,
                 convetionAccrual,
                 calendarAccrual,
                 microCalendarIntervalType,
                 microCalendarIntervalNumber,
                 microCalendarConvention,
                 microCalendar,
                 formulaIndexCalculation,
                 basisIndex,
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
        public int BackwardnessStart
        {
            get
            {
                return mBackwardnessStart;
            }
            set
            {
                mBackwardnessStart = value;
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

        // Direccion Generacion fijacion
        public enumAddressGenerationFixing AddressGenerationFixing
        {
            get
            {
                return mAddressGenerationFixing;
            }
            set
            {
                mAddressGenerationFixing = value;
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

        // Tipo intervalo inicio devengo
        public enumIntervalType StartingIntervalType
        {
            get
            {
                return mStartingIntervalType;
            }
            set
            {
                mStartingIntervalType = value;
            }
        }

        // Número intervalos inicio devengo
        public int StartingIntervalNumber
        {
            get
            {
                return mStartingIntervalNumber;
            }
            set
            {
                mStartingIntervalNumber = value;
            }
        }

        // Fecha Termino
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

        // Tipo intervalo termino devengo
        public enumIntervalType ExpiryIntervalType
        {
            get
            {
                return mExpiryIntervalType;
            }
            set
            {
                mExpiryIntervalType = value;
            }
        }

        // Número intervalos termino devengo
        public int ExpiryIntervalNumber
        {
            get
            {
                return mExpiryIntervalNumber;
            }
            set
            {
                mExpiryIntervalNumber = value;
            }
        }

        // Convenio de Devengamiento
        public enumConvention ConvetionAccrual
        {
            get
            {
                return mConvetionAccrual;
            }
            set
            {
                mConvetionAccrual = value;
            }
        }

        // Calendario del Devengo
        public Calendars CalendarAccrual
        {
            get
            {
                return mCalendarAccrual;
            }
            set
            {
                mCalendarAccrual = value;
            }
        }

        // Tipo intervalo microcalendario
        public enumIntervalType MicroCalendarIntervalType
        {
            get
            {
                return mMicroCalendarIntervalType;
            }
            set
            {
                mMicroCalendarIntervalType = value;
            }
        }

        // Número intervalos Microcalendario
        public int MicroCalendarIntervalNumber
        {
            get
            {
                return mMicroCalendarIntervalNumber;
            }
            set
            {
                mMicroCalendarIntervalNumber = value;
            }
        }

        // Convención inhabiles Microcalendario
        public enumConvention MicroCalendarConvention
        {
            get
            {
                return mMicroCalendarConvention;
            }
            set
            {
                mMicroCalendarConvention = value;
            }
        }

        // Calendario generación microcalendario
        public Calendars MicroCalendar
        {
            get
            {
                return mMicroCalendar;
            }
            set
            {
                mMicroCalendar = value;
            }
        }

        // Formula Calculo Indice Final
        public enumFormulaIndexCalculation FormulaIndexCalculation
        {
            get
            {
                return mFormulaIndexCalculation;
            }
            set
            {
                mFormulaIndexCalculation = value;
            }
        }

        // Base Indice Final
        public enumBasis BasisIndex
        {
            get
            {
                return mBasisIndex;
            }
            set
            {
                mBasisIndex = value;
            }
        }

        #endregion

        #region "Funciones Publicas"

        public Double Calculate(
                                 DateTime valuatorDate,
                                 DateTime yieldDate,
                                 DateTime fixingDate,
                                 enumSource sourceID,
                                 int rateID,
                                 int currencyID,
                                 enumPeriod periodID,
                                 RateList historyRate,
                                 String curveID,
                                 YieldList historyYield,
                                 enumBasisCurve basisCurve,
                                 enumIntervalType intervalType,
                                 int intervalNumber,
                                 int backwardnessStart,
                                 enumConvention convention,
                                 enumBasis basis,
                                 Calendars calendar,
                                 int termBenchmark,
                                 int resetDays,
                                 enumAddressGenerationFixing addressGenerationFixing,
                                 DateTime startingDate,
                                 enumIntervalType startingIntervalType,
                                 int startingIntervalNumber,
                                 DateTime expiryDate,
                                 enumIntervalType expiryIntervalType,
                                 int expiryIntervalNumber,
                                 enumConvention convetionAccrual,
                                 Calendars calendarAccrual,
                                 enumIntervalType microCalendarIntervalType,
                                 int microCalendarIntervalNumber,
                                 enumConvention microCalendarConvention,
                                 Calendars microCalendar,
                                 enumFormulaIndexCalculation formulaIndexCalculation,
                                 enumBasis basisIndex,
                                 int holidayChile,
                                 int holidayEEUU,
                                 int holidayEnglan
                               )
        {

            Set(
                 valuatorDate,
                 YieldDate,
                 rateID,
                 sourceID,
                 periodID,
                 currencyID,
                 historyRate,
                 curveID,
                 historyYield,
                 basisCurve,
                 intervalType,
                 intervalNumber,
                 backwardnessStart,
                 convention,
                 basis,
                 calendar,
                 termBenchmark,
                 resetDays,
                 addressGenerationFixing,
                 startingDate,
                 startingIntervalType,
                 startingIntervalNumber,
                 expiryDate,
                 expiryIntervalType,
                 expiryIntervalNumber,
                 convetionAccrual,
                 calendarAccrual,
                 microCalendarIntervalType,
                 microCalendarIntervalNumber,
                 microCalendarConvention,
                 microCalendar,
                 formulaIndexCalculation,
                 basisIndex,
                 holidayChile,
                 holidayEEUU,
                 holidayEnglan
               );

            return Calculate();
        }

        public Double Calculate()
        {

            Double _Rate = 0;
            double _RateTX = 0;
            Double _RateIndex = 0;
            DateTime _FlowStartingDate;
            ArrayList _FlowFixing = new ArrayList();
            ArrayList _Index = new ArrayList();
            BussineDate.BussineDate _FlowDate;
            //DateTime _Date;
            int _Flow = 0;
            Vanilla _IndexVanilla = new Vanilla();
            cFinancialTools.DayCounters.Basis _Basis; 

            for (_Flow = 0; _Flow < _FlowFixing.Count; _Flow++)
            {
                _FlowStartingDate = (DateTime)_FlowFixing[_Flow]; //(DateTime)

                _IndexVanilla = new Vanilla(
                                             mValuatorDate,
                                             mYieldDate,
                                             mStartingDate,
                                             mExpiryDate,
                                             mExpiryDate, // Fecha de Fijacion
                                             mTermBenchmark,
                                             mResetDays,
                                             mRateID,
                                             _RateTX,
                                             mSourceID,
                                             mPeriodID,
                                             mCurrencyID,
                                             mHistoryRate,
                                             mCurveID,
                                             mHistoryYield,
                                             mBasisCurve,
                                             mIntervalType,
                                             mIntervalNumber,
                                             mBackwardnessStart,
                                             mConvention,
                                             mBasis,
                                             mCalendar,
                                             mHolidayChile,
                                             mHolidayEEUU,
                                             mHolidayEnglan
                                           );

                _RateIndex = _IndexVanilla.Calculate();

                _FlowDate = new cFinancialTools.BussineDate.BussineDate(_FlowStartingDate);
                _FlowStartingDate = _FlowDate.MovesDate(mStartingIntervalType, mStartingIntervalNumber, mConvetionAccrual, 6, mCalendarAccrual);

                _FlowDate = new cFinancialTools.BussineDate.BussineDate(_FlowStartingDate);
                _FlowStartingDate = _FlowDate.MovesDate(mExpiryIntervalType, mExpiryIntervalNumber, mConvetionAccrual, 6, mCalendarAccrual);

                _Basis = new cFinancialTools.DayCounters.Basis(mBasis, _FlowStartingDate, _FlowStartingDate);
                _RateIndex = 1.0 + _RateIndex * _Basis.TermBasis;
                _Index.Add( _RateIndex );

            }

            //% La idea es que en este ciclo se agreguen distintos payoffs, en la medida
            //% que se requiera
            switch (mFormulaIndexCalculation)
            {
                case enumFormulaIndexCalculation.AverageGeometriFactorsCapitalization:
                    _Rate = 1;
                    for (_Flow = 0; _Flow < _FlowFixing.Count; _Flow++)
                    {
                        _Rate = _Rate * (Double)_Index[_Flow];
                    }
                    _Basis = new cFinancialTools.DayCounters.Basis(mBasisIndex, mStartingDate, mExpiryDate);
                    _Rate = (_Rate - 1.0) * (1.0 / _Basis.TermBasis);
                    break;
                default:
                    break;
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
                            int rateID,
                            enumSource sourceID,
                            enumPeriod periodID,
                            int currencyID,
                            RateList historyRate,
                            String curveID,
                            YieldList historyYield,
                            enumBasisCurve basisCurve,
                            enumIntervalType intervalType,
                            int intervalNumber,
                            int backwardnessStart,
                            enumConvention convention,
                            enumBasis basis,
                            Calendars calendar,
                            int termBenchmark,
                            int resetDays,
                            enumAddressGenerationFixing addressGenerationFixing,
                            DateTime startingDate,
                            enumIntervalType startingIntervalType,
                            int startingIntervalNumber,
                            DateTime expiryDate,
                            enumIntervalType expiryIntervalType,
                            int expiryIntervalNumber,
                            enumConvention convetionAccrual,
                            Calendars calendarAccrual,
                            enumIntervalType microCalendarIntervalType,
                            int microCalendarIntervalNumber,
                            enumConvention microCalendarConvention,
                            Calendars microCalendar,
                            enumFormulaIndexCalculation formulaIndexCalculation,
                            enumBasis basisIndex,
                            int holidayChile,
                            int holidayEEUU,
                            int holidayEnglan
                          )
        {
            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mSourceID = sourceID;
            mRateID = rateID;
            mCurrencyID = currencyID;
            mHistoryRate = historyRate;
            mCurveID = curveID;
            mHistoryYield = historyYield;
            mBasisCurve = basisCurve;
            mIntervalType = intervalType;
            mIntervalNumber = intervalNumber;
            mBackwardnessStart = backwardnessStart;
            mConvention = convention;
            mBasis = basis;
            mCalendar = calendar;
            mTermBenchmark = termBenchmark;
            mResetDays = resetDays;
            mAddressGenerationFixing = addressGenerationFixing;
            mStartingDate = startingDate;
            mStartingIntervalType = startingIntervalType;
            mStartingIntervalNumber = startingIntervalNumber;
            mExpiryDate = expiryDate;
            mExpiryIntervalType = expiryIntervalType;
            mExpiryIntervalNumber = expiryIntervalNumber;
            mConvetionAccrual = convetionAccrual;
            mCalendarAccrual = calendarAccrual;
            mMicroCalendarIntervalType = microCalendarIntervalType;
            mMicroCalendarIntervalNumber = microCalendarIntervalNumber;
            mMicroCalendarConvention = microCalendarConvention;
            mMicroCalendar = microCalendar;
            mFormulaIndexCalculation = formulaIndexCalculation;
            mBasisIndex = basisIndex;
            mHolidayChile = holidayChile;
            mHolidayEEUU = holidayEEUU;
            mHolidayEnglan = holidayEnglan;
        }

        #endregion

    }

}
