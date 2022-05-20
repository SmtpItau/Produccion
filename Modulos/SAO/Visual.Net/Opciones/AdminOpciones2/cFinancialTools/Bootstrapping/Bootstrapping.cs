using System;
using System.Collections;
using System.Text;
using cFinancialTools.Yield;
using cFinancialTools.BussineDate;
using cFinancialTools.DayCounters;

namespace cFinancialTools.Bootstrapping
{
    public class Bootstrapping
    {

    #region "Atributos Protegidos"
        protected DateTime mCurveDate;
        protected BYieldValue mYield;
        protected int mSpotLag;
        protected enumBasis mMoneyMarketBasis;
        protected enumBasis mSwapBasis;
        protected enumFrecuency mFrecuencyID;
        protected bool mInterpolate;
        protected int mCalendarType;
        protected BussineDate.Calendars mCalendar;
    #endregion

    #region "Constructores"
        public Bootstrapping()
        {
            DateTime _Date = new DateTime(1900, 1, 1);
            BYieldValue _Yield = new BYieldValue();

            Set(_Date, _Yield, 0, enumBasis.Basis_Act_360, enumBasis.Basis_Act_360, enumFrecuency.Year, 6, false);

        }

        public Bootstrapping(
                              DateTime curveDate,
                              BYieldValue yield,
                              int spotLag,
                              enumBasis moneyMarketBasis,
                              enumBasis swapBasis,
                              enumFrecuency frecuencyID,
                              int calendarType,
                              bool interpolate
                           )
        {
            Set(curveDate, yield, spotLag, moneyMarketBasis, swapBasis, frecuencyID, calendarType, interpolate);
        }
    #endregion

    #region "Propiedades"
        public DateTime CurveDate
        {
            get
            {
                return mCurveDate;
            }
            set
            {
                mCurveDate = value;
            }
        }

        public BYieldValue Yield
        {
            get
            {
                return mYield;
            }
            set
            {
                mYield = value;
            }
        }

        public int SpotLag
        {
            get
            {
                return mSpotLag;
            }
            set
            {
                mSpotLag = value;
            }
        }

        public enumBasis MoneyMarketBasis
        {
            get
            {
                return mMoneyMarketBasis;
            }
            set
            {
                mMoneyMarketBasis = value;
            }
        }

        public enumBasis SwapBasis
        {
            get
            {
                return mSwapBasis;
            }
            set
            {
                mSwapBasis = value;
            }
        }

        public enumFrecuency FrecuencyID
        {
            get
            {
                return mFrecuencyID;
            }
            set
            {
                mFrecuencyID = value;
            }
        }

        public int CalendarType
        {
            get
            {
                return mCalendarType;
            }
            set
            {
                mCalendarType = value;
            }
        }

        public Calendars Calendars
        {
            get
            {
                return mCalendar;
            }
        }

        public bool Interpolate
        {
            get
            {
                return mInterpolate;
            }
            set
            {
                mInterpolate = value;
            }
        }
    #endregion

    #region "Metodos Publicos"
        public BYieldValue Calculate()
        {
            DateTime _SpotDate = mCurveDate;
            DateTime _DateStarting;
            DateTime _DateExpiry;
            BussineDate.BussineDate _Date = new cFinancialTools.BussineDate.BussineDate(mCurveDate);
            int _Point;
            int _PointSwap = 0;
            int _Day;
            int _PointNew;
            int _PointEval;
            int _FlowNumber = 0;
            double _Period;
            double _Rate;
            double _FactorSpot;
            Basis _Basis = new Basis();
            Basis _BasisStrating = new Basis();
            Basis _BasisExpiry = new Basis();

            BYieldPoint _YieldPoint = new BYieldPoint();
            BYieldPoint _YieldPointNext = new BYieldPoint();
            BYieldPoint _YieldPointNew = new BYieldPoint();

            BYieldValue _YieldValue = new BYieldValue();
            BYieldValue _DateYieldValue = new BYieldValue();
            BYieldValue _FactorYieldValue = new BYieldValue();
            BYieldValue _FactorYieldValue2 = new BYieldValue();

            double _Differences;
            double _Delta;
            double _DifferencesLimit;
            double _RateCurrent;
            double _RateNext;

            // Suma mSpotLag días habiles
            for (_Day = 1; _Day <= mSpotLag; _Day++)
            {
                _SpotDate = _Date.MovesDate(enumIntervalType.DayHoliday, 1, enumConvention.Next, 6, mCalendar);
                _Date.Value = _SpotDate;
            }

            // Generación de Puntos
            if (mInterpolate)
            {
                // Busca el Primer caso donde el tipo de punto en la curva es un punto SWAP.
                for (_Point = 0; _Point < mYield.Count; _Point++)
                {
                    _YieldPoint = mYield.Point(_Point);

                    if ((_YieldPoint.BootstrappingType == enumBootstrappingType.MoneyMarket) || (_YieldPoint.BootstrappingType == enumBootstrappingType.MoneyMarket))
                    {
                        _YieldValue.Add(_YieldPoint);
                    }
                    else
                    {
                        _PointSwap = _Point;
                        break;
                    }

                }

                // Se posicióna en el punto anterior al punto SWAP.
                _PointSwap--;

                for (_Point = _PointSwap; _Point < (mYield.Count - 1); _Point++)
                {
                    _PointNew = _PointSwap + 1;

                    // Vencimiento actual
                    _YieldPoint = (BYieldPoint)mYield.Point(_Point);
                    _Basis = new Basis(enumBasis.Basis_30E_360, _SpotDate, _YieldPoint.Date);

                    // Proximo vencimiento
                    _YieldPointNext = (BYieldPoint)mYield.Point(_Point + 1);
                    _BasisExpiry = new Basis(enumBasis.Basis_30E_360, _SpotDate, _YieldPointNext.Date);

                    // Calculo del Periodo
                    _Period = (_BasisExpiry.TermBasis + 1.0 / 12.0) - (_BasisStrating.TermBasis + 1.0 / 12.0);

                    // Agrega punto actual
                    _YieldValue.Add(_YieldPoint);

                    for (_PointEval = 0; _PointEval < (Frecuency() * _Period - 1); _PointEval++)
                    {
                        // Calcula la Fecha de Inicio del Periodo
                        _Date = new cFinancialTools.BussineDate.BussineDate(_SpotDate);
                        _DateStarting = _Date.Add(enumDateIntevale.Month, (int)(_PointNew - (_PointSwap - 1) + _Period * 12 / Frecuency()));

                        // Calcula la Fecha de Final del Periodo
                        _Date = new cFinancialTools.BussineDate.BussineDate(_DateStarting);
                        _DateExpiry = _Date.Add(enumDateIntevale.Month, 12 / Frecuency() * _PointEval);
                        _Rate = (_YieldPoint.Rate * DateDiffDay(_Date.Value, _YieldPointNext.Date) + _YieldPointNext.Rate *
                                DateDiffDay(_YieldPoint.Date, _Date.Value)) / DateDiffDay(_YieldPoint.Date, _YieldPointNext.Date);

                        //_YieldPoint.Date = _Date.MovesDate(enumIntervalType.Month, 
                        _YieldPointNew = new BYieldPoint();
                        _YieldPointNew.Date = _DateExpiry;
                        _YieldPointNew.Rate = _Rate;
                        _YieldPointNew.BootstrappingType = _YieldPoint.BootstrappingType;

                        _YieldValue.Add(_YieldPointNew);
                        _PointNew++;
                    }

                }

                _YieldPoint = (BYieldPoint)mYield.Point(mYield.Count);
                _YieldValue.Add(_YieldPoint);

            }
            else
            {
                _YieldValue = mYield;
            }

            // Vector de fechas de pagos SWAP
            _YieldPoint = mYield.Point(mYield.Count-1);
            
            _FlowNumber = Frecuency() * (int)(DateDiffDay(_SpotDate, _YieldPoint.Date) / 365.25) + 2;

            _Date.Value = _SpotDate;
            _DateYieldValue.Add(_SpotDate, 0, enumBootstrappingType.MoneyMarket);

            _Point = 1;
            
            while (_Date.Value <= _YieldPoint.Date)
            {
                _Date = new cFinancialTools.BussineDate.BussineDate(_SpotDate);
                _Date.Value = _Date.Add(enumDateIntevale.Month, _Point * 12 / Frecuency());

                _DateYieldValue.Add(_Date.Value, 0, enumBootstrappingType.MoneyMarket);

                for (_PointEval = 0; _PointEval < _YieldValue.Count; _PointEval++)
                {
                    _YieldPointNext = _YieldValue.Point(_PointEval);

                    if (Math.Abs(DateDiffDay(_YieldPointNext.Date, _DateYieldValue.Point(_Point).Date)) <= 5)
                    {
                        _DateYieldValue.Point(_Point).Date = _YieldPointNext.Date;
                    }

                }
                _Point++;

            }

            // Crea Tabla de Factores
            _FactorYieldValue = new BYieldValue();
            _FactorSpot = 1;
            _SpotDate = CurveDate;
            _YieldPointNew = new BYieldPoint();

            _YieldPointNew.Date = CurveDate;
            _YieldPointNew.Rate = _FactorSpot;

            _FactorYieldValue.Add(_YieldPointNew);

            for (_Point = 0; _Point < mSpotLag; _Point++)
            {
                _YieldPoint = _YieldValue.Point(_Point);
                _Basis = new Basis(mMoneyMarketBasis, _SpotDate, _YieldPoint.Date);

                _YieldPointNew = new BYieldPoint();
                _YieldPointNew.Date = _YieldPoint.Date;
                _YieldPointNew.Rate = _FactorSpot / (1 + _YieldPoint.Rate / 100 * _Basis.TermBasis);

                _FactorYieldValue.Add(_YieldPointNew);

                _FactorSpot = _YieldPointNew.Rate;
                _SpotDate = _YieldPoint.Date;

            }

            double _Factor = Math.Pow(10, -5);

            for (_Point = mSpotLag; _Point < _YieldValue.Count; _Point++)
            {
                _YieldPoint = mYield.Point(_Point);
                _FactorYieldValue.Add(_YieldPoint.Date, 1, _YieldPoint.BootstrappingType);

                _YieldPointNext = _FactorYieldValue.Point(_Point + 1);

                switch(_YieldPoint.BootstrappingType)
                {
                    case enumBootstrappingType.MoneyMarket:
                        _Basis = new Basis(mMoneyMarketBasis, _SpotDate, _YieldPoint.Date);

                        _YieldPointNew = new BYieldPoint();
                        _YieldPointNew.Date = _YieldPoint.Date;
                        _YieldPointNew.Rate = _FactorSpot / (1 + _YieldPoint.Rate / 100 * _Basis.TermBasis);

                        _FactorYieldValue.Item(_Point+1, _YieldPointNew);

                        break;

                    case enumBootstrappingType.Forward:
                        _Date = new cFinancialTools.BussineDate.BussineDate(_YieldPoint.Date);
                        _DateStarting = _Date.Add(enumDateIntevale.Month, -3);

                        if (_DateStarting > _YieldPointNew.Date)
                        {
                            _YieldPointNew = new BYieldPoint();
                            _YieldPointNew.Date = _YieldPoint.Date;
                            _YieldPointNew.Rate = UnderlapFut(
                                                               CurveDate,
                                                               _YieldPointNext.Date,
                                                               _YieldPointNext.Rate,
                                                               _DateStarting,
                                                               _YieldPoint.Date,
                                                               _YieldPoint.Rate
                                                             );


                        }
                        else
                        {
                            _YieldPointNew = new BYieldPoint();
                            _YieldPointNew.Date = _YieldPoint.Date;

                            _Differences = InterpolZeros(CurveDate, _Date.Value, _FactorYieldValue, 0);
                            _Basis = new Basis(mMoneyMarketBasis, _Date.Value, _YieldPoint.Date);

                            _YieldPointNew.Rate = _Differences / (1 + (1 - _YieldPoint.Rate / 100) * _Basis.TermBasis);
                        }

                        _FactorYieldValue.Item(_Point + 1, _YieldPointNew);
                        break;

                    case enumBootstrappingType.Swap:
                        _Differences = 1;

                        _Delta = 1;

                        _DifferencesLimit = 1E+20;

                        _RateCurrent = _YieldPoint.Rate;

                        _RateNext = _YieldPointNext.Rate;

                        while (Math.Abs(_Delta) > 9.9E-15)
                        {
                            _FactorYieldValue2 = new BYieldValue();
                            for (_PointNew = 0; _PointNew <= _FactorYieldValue.Count; _PointNew++)
                            {
                                _YieldPointNew = new BYieldPoint();
                                _YieldPointNew.Date = _FactorYieldValue.Point(_PointNew).Date;
                                _YieldPointNew.Rate = _FactorYieldValue.Point(_PointNew).Rate;
                                _YieldPointNew.BootstrappingType = _FactorYieldValue.Point(_PointNew).BootstrappingType;
                                _FactorYieldValue2.Add(_YieldPointNew);
                            }

                            _Differences = _Differences - _Delta / _DifferencesLimit;

                            _RateCurrent = _Differences;

                            _FactorYieldValue.Point(_Point + 1).Rate = _Differences;
                            _FactorYieldValue2.Point(_Point + 1).Rate = _Differences + _Factor;
                            _Delta = SwapPrice(_SpotDate, CurveDate, _YieldPoint.Date, _DateYieldValue, _YieldPoint.Rate, _FactorYieldValue);
                            _DifferencesLimit = (SwapPrice(_SpotDate, CurveDate, _YieldPoint.Date, _DateYieldValue, _YieldPoint.Rate, _FactorYieldValue2) - 
                                                 _Delta) / _Factor;
                        }
                        break;
                    default:
                        break;
                }
            }
            
            return _FactorYieldValue;

        }
    #endregion

    #region "Metodos privados"
        protected int Frecuency()
        {
            int _Frecuency;

            switch (mFrecuencyID)
            {
                case enumFrecuency.Year:
                    _Frecuency = 1;
                    break;
                case enumFrecuency.Semesters:
                    _Frecuency = 2;
                    break;
                case enumFrecuency.Month:
                    _Frecuency = 12;
                    break;
                case enumFrecuency.TwoMonth:
                    _Frecuency = 6;
                    break;
                case enumFrecuency.ThreeMonth:
                    _Frecuency = 4;
                    break;
                case enumFrecuency.FourMonth:
                    _Frecuency = 3;
                    break;
                default:
                    _Frecuency = 1;
                    break;
            }

            return _Frecuency;
        }

        protected double UnderlapFut(DateTime curveDate, DateTime zeroDate, double zeroRate, DateTime startingDate, DateTime originalDate, double originalRate)
        {
            double _Factor = Math.Pow(10, -5);
            double _RateNew = 1 - originalRate / 100;
            double _Delta = 1;
            double _Differences = 1;
            double _DifferencesLimit = 1E+20;
            double _Rate = 0;

            while (Math.Abs(_Differences) > Math.Pow(10, -15))
            {
                _Delta = _Delta - _Differences / _DifferencesLimit;
                _Rate = _Delta / ( 1 + originalRate * DateDiffDay(startingDate, originalDate) / 360);

                _Differences = GetFactor(curveDate, startingDate, zeroDate, zeroRate, originalDate, _Rate) - _Delta;
                _Differences = (GetFactor(curveDate, startingDate, zeroDate, zeroRate, originalDate, _Rate) - (_Delta + _Factor) - _Differences) / _Factor;
            }

            return _Delta / (1 + originalRate * DateDiffDay(startingDate, originalDate) / 360);

        }

        protected double GetFactor(DateTime curveDate, DateTime startingDate, DateTime zeroDate, double zeroRate, DateTime originalDate, double originalRate)
        {
            int _Method = 0;
            double _Term = 0;
            double _Rate = 0;

            if (_Method.Equals(0))
            {
                if (zeroDate.Equals(curveDate))
                {
                    _Term = Math.Pow(10, -11);
                }
                else
                {
                    _Term = DateDiffDay(curveDate, zeroDate);
                }

                zeroRate = Math.Pow(zeroRate, -365 / _Term);
                originalRate = Math.Pow(originalRate, -365 / DateDiffDay(curveDate, originalDate));

                _Rate = ((zeroRate * DateDiffDay(startingDate, originalDate)) + (originalRate * DateDiffDay(zeroDate, startingDate))) /
                            DateDiffDay(zeroDate, originalDate);
                _Rate = Math.Pow(1 / _Rate, DateDiffDay(zeroDate, startingDate) / 365);

            }
            else
            {
                zeroRate = -Math.Log(zeroRate);
                originalRate = -Math.Log(originalRate);
                _Rate = ((zeroRate * DateDiffDay(startingDate, originalDate)) + (originalRate * DateDiffDay(zeroDate, startingDate))) /
                            DateDiffDay(zeroDate, originalDate);
                _Rate = Math.Exp(_Rate);

            }
            return _Rate;
        }

        protected double DateDiffDay(DateTime dateStarting, DateTime dateExpiry)
        {

            double _DayStarting = 0;
            double _DayExpiry = 0;
            BussineDate.BussineDate _Date;

            _Date = new cFinancialTools.BussineDate.BussineDate(dateStarting);
            _DayStarting = _Date.DayOfYears;

            _Date = new cFinancialTools.BussineDate.BussineDate(dateExpiry);
            _DayExpiry = _Date.DayOfYears;

            return (_DayExpiry - _DayStarting);
        }

        protected double InterpolZeros(DateTime curveDate, DateTime startingDate, BYieldValue factorYieldValue, int Method)
        {
            if (startingDate < curveDate)
            {
                return 0;
            }
            else
            {

                double _Days = DateDiffDay(curveDate, startingDate);
                if (_Days < 0.9)
                {
                    return 1;
                }
                else
                {
                    int _CurrentPoint = factorYieldValue.Count;
                    int _CurrentNext = 0;
                    int _Point = 0;
                    BYieldPoint _PointCurrent;
                    BYieldPoint _PointNext;
                    double _Term;
                    double _Rate;
                    double _RateCurrent;
                    double _RateNext;

                    for (_Point = 1; _Point < factorYieldValue.Count; _Point++)
                    {
                        _PointCurrent = factorYieldValue.Point(_Point);

                        if (DateDiffDay(startingDate, _PointCurrent.Date) >= 0)
                        {
                            _CurrentPoint = _Point;
                            break;
                        }
                    }

                    _CurrentPoint--;
                    _CurrentNext = _CurrentPoint + 1;

                    _PointCurrent = factorYieldValue.Point(_CurrentPoint);

                    if (_CurrentPoint >= factorYieldValue.Count)
                    {
                        return Math.Pow(_PointCurrent.Rate, (DateDiffDay(CurveDate, startingDate) / DateDiffDay(CurveDate, _PointCurrent.Date)));
                    }
                    else
                    {
                        _PointNext = factorYieldValue.Point(_CurrentNext);
                        if (Method.Equals(0))
                        {
                            if (_PointCurrent.Date.Equals(curveDate))
                            {
                                _Term = Math.Pow(10, -11);
                            }
                            else
                            {
                                _Term = DateDiffDay(curveDate, _PointCurrent.Date);
                            }

                            _RateCurrent = Math.Pow(_PointCurrent.Rate, -365 / _Term);
                            _RateNext = Math.Pow(_PointNext.Rate, -365 / DateDiffDay(curveDate, _PointNext.Date));

                            _Rate = ((_RateCurrent * DateDiffDay(startingDate, _PointNext.Date)) + (_RateNext * DateDiffDay(_PointCurrent.Date, startingDate))) /
                                        DateDiffDay(_PointCurrent.Date, _PointNext.Date);
                            _Rate = 1 / Math.Pow(_Rate, DateDiffDay(CurveDate, startingDate) / 365);

                        }
                        else
                        {
                            _RateCurrent = -Math.Log(_PointCurrent.Rate);
                            _RateNext = -Math.Log(_PointNext.Rate);

                            _Rate = ((_RateCurrent * DateDiffDay(startingDate, _PointNext.Date)) + (_RateNext * DateDiffDay(startingDate, _PointCurrent.Date))) /
                                        DateDiffDay(_PointCurrent.Date, _PointNext.Date);
                            _Rate = Math.Exp(_Rate);
                        }
                        return _Rate;
                    }
                }
            }
        }

        protected double SwapPrice(
                                    DateTime spotDate,
                                    DateTime curveDate,
                                    DateTime zeroDate,
                                    BYieldValue dateYieldValue,
                                    double zeroRate,
                                    BYieldValue factorYieldValue
                                  )
        {
            int _Point = 1;
            double _Rate = InterpolZeros(CurveDate, spotDate, factorYieldValue, 0) - InterpolZeros(CurveDate, zeroDate, factorYieldValue, 0);
            double _CalculateRate = 0;
            Basis _Basis;
            while (dateYieldValue.Point(_Point).Date <= zeroDate)
            {
                _Basis = new Basis(mSwapBasis, dateYieldValue.Point(_Point - 1).Date, dateYieldValue.Point(_Point).Date);
                _CalculateRate = _CalculateRate + _Basis.TermBasis * InterpolZeros(CurveDate, dateYieldValue.Point(_Point).Date, factorYieldValue, 0);
                _Point++;
            }
            return _Rate - _CalculateRate * zeroRate / 100.0;
        }

        protected void Set(
                            DateTime curveDate,
                            BYieldValue yield,
                            int spotLag,
                            enumBasis moneyMarketBasis,
                            enumBasis swapBasis,
                            enumFrecuency frecuencyID,
                            int calendarType,
                            bool interpolate
                          )
        {
            mCurveDate = curveDate;
            mYield = yield;
            mSpotLag = spotLag;
            mMoneyMarketBasis = moneyMarketBasis;
            mSwapBasis = swapBasis;
            mFrecuencyID = frecuencyID;
            mCalendarType = calendarType;
            mCalendar = new cFinancialTools.BussineDate.Calendars(); //mCalendarType
            mCalendar.Load();
            mInterpolate = interpolate;
        }
    #endregion

    }

}
