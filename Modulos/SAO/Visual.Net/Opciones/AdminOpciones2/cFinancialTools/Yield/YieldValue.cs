using System;
using System.Collections;
using System.Text;
using cData.Yield;

namespace cFinancialTools.Yield
{

    public class YieldValue
    {

        #region "Definicion de Variables"

        private DateTime mDate;
        private ArrayList mList;
        private enumGenerate mGenerate;
        private enumInterpolateType mInterpolateType;
        private enumRate mRateType;
        private double mRateBasis;

        private enumPointStatus mPointStatus;

        #endregion

        #region "Constructor"

        public YieldValue()
        {
            Set(enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal);
        }

        public YieldValue(DateTime date)
        {
            mDate = date;
            mGenerate = enumGenerate.OriginalYield;
            mInterpolateType = enumInterpolateType.InterpolateLineal;
            Set(enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal);
        }

        public YieldValue(DateTime date, enumGenerate generate, enumInterpolateType interpolateType)
        {
            mDate = date;
            Set(generate, interpolateType);
        }

        #endregion

        #region "Propiedades"

        public DateTime Date
        {
            get
            {
                return mDate;
            }
            set
            {
                mDate = value;
            }
        }

        public int Count
        {
            get
            {
                return mList.Count;
            }
        }

        public double RateBasis
        {
            get
            {
                return mRateBasis;
            }
            set
            {
                mRateBasis = value;
            }
        }

        public enumRate RateType
        {
            get
            {
                return mRateType;
            }
            set
            {
                mRateType = value;
            }
        }

        protected YieldPoint PointBottom
        {
            get
            {
                YieldPoint _YieldPoint = new YieldPoint(0, 0);
                int _Point = mList.Count - 1;

                if (!(_Point == 0))
                {
                    _YieldPoint = (YieldPoint)mList[_Point];
                }

                return _YieldPoint;
            }
        }

        protected YieldPoint PointTop
        {
            get
            {
                YieldPoint _YieldPoint = new YieldPoint(0, 0);
                int _Point = mList.Count - 1;

                if (mList.Count > 0)
                {
                    _YieldPoint = (YieldPoint)mList[0];
                }

                return _YieldPoint;
            }
        }

        #endregion

        #region "Funciones Publicas"

        public bool Add(int term, double rate)
        {
            bool _Status = true;

            if (Find(term))
            {
                _Status = false;
            }
            else
            {
                if (mGenerate == enumGenerate.OriginalYield)
                {
                    YieldPoint _Item = new YieldPoint(term, rate);
                    mList.Add(_Item);
                }
                else
                {
                    YieldPoint _YieldPoint = new YieldPoint();

                    int _PointFor;
                    int _Term;
                    int _PointTerm;

                    Double _PointRate;
                    Double _Rate;

                    if (mList.Count > 0)
                    {
                        _PointTerm = PointBottom.Term;
                        _PointFor = _PointTerm + 1;
                        _PointRate = PointBottom.Rate;
                    }
                    else
                    {
                        _PointTerm = 1;
                        _PointFor = 1;
                        _PointRate = rate;
                    }

                    for (_Term = _PointFor; _Term <= term; _Term++)
                    {
                        _Rate = Interpolate(_PointTerm, _PointRate, term, rate, _Term);

                        YieldPoint _Item = new YieldPoint(term, rate);
                        mList.Add(_Item);

                    }

                }
            }

            return _Status;

        }

        public bool Add(int term, double rateBid, double rateOffer, double rateMid)
        {
            bool _Status = true;

            if (Find(term))
            {
                _Status = false;
            }
            else
            {
                if (mGenerate == enumGenerate.OriginalYield)
                {
                    YieldPoint _Item = new YieldPoint(term, rateBid, rateOffer, rateMid);
                    mList.Add(_Item);
                }
                else
                {
                    YieldPoint _YieldPoint = new YieldPoint();

                    int _PointFor;
                    int _Term;
                    int _PointTerm;

                    double _PointRateBid;
                    double _PointRateOffer;
                    double _PointRateMid;

                    double _RateBid;
                    double _RateOffer;
                    double _RateMid;

                    if (mList.Count > 0)
                    {
                        _PointTerm = PointBottom.Term;
                        _PointFor = _PointTerm + 1;
                        _PointRateBid = PointBottom.RateBid;
                        _PointRateOffer = PointBottom.RateOffer;
                        _PointRateMid = PointBottom.RateMid;
                        
                    }
                    else
                    {
                        _PointTerm = 1;
                        _PointFor = 1;
                        _PointRateBid = rateBid;
                        _PointRateOffer = rateOffer;
                        _PointRateMid = rateMid;
                    }

                    for (_Term = _PointFor; _Term <= term; _Term++)
                    {

                        _RateBid = Interpolate(_PointTerm, _PointRateBid, term, rateBid, _Term);
                        _RateOffer = Interpolate(_PointTerm, _PointRateOffer, term, rateOffer, _Term);
                        _RateMid = Interpolate(_PointTerm, _PointRateMid, term, rateMid, _Term);

                        YieldPoint _Item = new YieldPoint(term, _RateBid, _RateOffer, _RateMid);
                        mList.Add(_Item);

                    }

                }
            }

            return _Status;
        }

        public bool Find(int term)
        {

            bool _Status = false;
            int _Point;
            YieldPoint _YieldPoint;

            if (mGenerate == enumGenerate.OriginalYield)
            {
                for (_Point = 0; _Point < mList.Count - 1; _Point++)
                {
                    _YieldPoint = (YieldPoint)mList[_Point];

                    if (_YieldPoint.Term == term)
                    {
                        _Status = true;
                        break;
                    }

                }
            }
            else
            {
                try
                {
                    _YieldPoint = (YieldPoint)mList[term];
                    _Status = true;
                }
                catch
                {
                    _Status = false;
                }

            }

            return _Status;
        }

        public YieldPoint Read(int term)
        {

            YieldPoint _Item = new YieldPoint();

            switch (mGenerate)
            {
                case enumGenerate.CalculateYield:
                    if (term < 0)
                    {
                        _Item = new YieldPoint(0, 0);
                    }
                    else if (term > PointBottom.Term)
                    {
                        _Item = PointBottom;
                    }
                    else
                    {
                        _Item = (YieldPoint)mList[term];
                    }
                    break;
                case enumGenerate.OriginalYield:
                    _Item = BinarySearch(term);
                    break;
                default:
                    break;
            }
            return _Item;
        }

        public YieldPoint Point(int point)
        {
            YieldPoint _YieldPoint = new YieldPoint();
            int _PointBottom = mList.Count - 1;
            if (_PointBottom >= point)
            {
                _YieldPoint = (YieldPoint)mList[point];
            }

            return _YieldPoint;
        }

        public YieldPoint SetPoint(int point, YieldPoint item)
        {
            YieldPoint _YieldPoint = new YieldPoint();
            int _PointBottom = mList.Count - 1;
            if (_PointBottom >= point)
            {
                mList[point] = item;
            }

            return _YieldPoint;
        }

        public ArrayList ReadAll()
        {
            return mList;
        }

        public bool Item(int term, YieldPoint item)
        {

            bool _Status = true;

            if (Find(term))
            {
                mList[term] = item;
            }
            else
            {
                _Status = false;
            }

            return _Status;

        }

        public bool Remove(int term)
        {
            bool _Status = true;
            String _Term = term.ToString();

            if (Find(term))
            {
                mList.Remove(_Term);
            }
            else
            {
                _Status = false;
            }

            return _Status;
        }

        #endregion

        #region "Funciones Protegidas"

        protected YieldPoint BinarySearch(int term)
        {
            int _PointLeft = 0;
            int _Point = 0;
            int _PointRight = 0;
            int _Term = 0;
            YieldPoint _YieldPoint = new YieldPoint();
            YieldPoint _YieldReturn = new YieldPoint();

            if (mList.Count == 0)
            {
                return _YieldPoint;
            }

            // Verifica si el punto solicitado es el primer punto
            if (PointTop.Term >= term)
            {
                _PointLeft = 0;
                _PointRight = 0;
                _Point = 0;
                mPointStatus = enumPointStatus.OutRangeLeft;
                if (PointTop.Term == term)
                {
                    mPointStatus = enumPointStatus.Found;
                }

            }
            // Verifica si el punto solicitado es el ultimo de la lista
            else if (PointBottom.Term <= term)
            {
                _PointLeft = mList.Count - 1;
                _Point = mList.Count - 1;

                mPointStatus = enumPointStatus.OutRangeRight;

                if (getPointYield(_PointRight).Term == term)
                {
                    mPointStatus = enumPointStatus.Found;
                }
            }
            // Busqueda binaria del punto en la lista
            else
            {

                _PointLeft = 0;
                _PointRight = mList.Count - 1;

                while (true)
                {
                    _Point = _PointLeft + ((_PointRight - _PointLeft) / 2);

                    _Term = Point(_Point).Term;

                    if (_Term == term)
                    {
                        mPointStatus = enumPointStatus.Found;
                        break;
                    }
                    else if (_Term < term)
                    {
                        _PointLeft = _Point;
                    }
                    else
                    {
                        _PointRight = _Point;
                    }

                    if ((_PointRight - _PointLeft) == 1)
                    {
                        mPointStatus = enumPointStatus.Interpolate;
                        break;
                    }
                }
            }

            switch (mPointStatus)
            {
                // El punto no fue encontrado, se setean las variables para realizar la interpolación
                case enumPointStatus.Interpolate:
                    _YieldPoint.Term = term;

                    switch(mRateType)
                    {
                        case enumRate.RateBasis:
                            _YieldPoint.Rate = Interpolate(
                                                            Point(_PointLeft).Term,
                                                            mRateBasis + Point(_PointLeft).Spread,
                                                            Point(_PointRight).Term,
                                                            mRateBasis + Point(_PointRight).Spread,
                                                            term
                                                          );
                            _YieldPoint.RateBid = Interpolate(
                                                               Point(_PointLeft).Term,
                                                               mRateBasis + Point(_PointLeft).Spread,
                                                               Point(_PointRight).Term,
                                                               mRateBasis + Point(_PointRight).Spread,
                                                               term
                                                             );
                            _YieldPoint.RateOffer = Interpolate(
                                                                 Point(_PointLeft).Term,
                                                                 mRateBasis + Point(_PointLeft).Spread,
                                                                 Point(_PointRight).Term,
                                                                 mRateBasis + Point(_PointRight).Spread,
                                                                 term
                                                               );
                            _YieldPoint.RateMid = Interpolate(
                                                               Point(_PointLeft).Term,
                                                               mRateBasis + Point(_PointLeft).Spread,
                                                               Point(_PointRight).Term,
                                                               mRateBasis + Point(_PointRight).Spread,
                                                               term
                                                             );


                            break;
                        case enumRate.RateOriginalSpread:
                            _YieldPoint.Rate = Interpolate(
                                                            Point(_PointLeft).Term,
                                                            Point(_PointLeft).Rate + Point(_PointLeft).Spread,
                                                            Point(_PointRight).Term,
                                                            Point(_PointRight).Rate + Point(_PointRight).Spread,
                                                            term
                                                          );
                            _YieldPoint.RateBid = Interpolate(
                                                               Point(_PointLeft).Term,
                                                               Point(_PointLeft).RateBid + Point(_PointLeft).Spread,
                                                               Point(_PointRight).Term,
                                                               Point(_PointRight).RateBid + Point(_PointRight).Spread,
                                                               term
                                                             );
                            _YieldPoint.RateOffer = Interpolate(
                                                                 Point(_PointLeft).Term,
                                                                 Point(_PointLeft).RateOffer + Point(_PointLeft).Spread,
                                                                 Point(_PointRight).Term,
                                                                 Point(_PointRight).RateOffer + Point(_PointRight).Spread,
                                                                 term
                                                               );
                            _YieldPoint.RateMid = Interpolate(
                                                               Point(_PointLeft).Term,
                                                               Point(_PointLeft).RateMid + Point(_PointLeft).Spread,
                                                               Point(_PointRight).Term,
                                                               Point(_PointRight).RateMid + Point(_PointRight).Spread,
                                                               term
                                                            );

                            break;
                        case enumRate.RateOriginal:
                        default:
                            _YieldPoint.Rate = Interpolate(Point(_PointLeft).Term, Point(_PointLeft).Rate, Point(_PointRight).Term, Point(_PointRight).Rate, term);
                            _YieldPoint.RateBid = Interpolate(Point(_PointLeft).Term, Point(_PointLeft).RateBid, Point(_PointRight).Term, Point(_PointRight).RateBid, term);
                            _YieldPoint.RateOffer = Interpolate(Point(_PointLeft).Term, Point(_PointLeft).RateOffer, Point(_PointRight).Term, Point(_PointRight).RateOffer, term);
                            _YieldPoint.RateMid = Interpolate(Point(_PointLeft).Term, Point(_PointLeft).RateMid, Point(_PointRight).Term, Point(_PointRight).RateMid, term);
                            break;
                    }
                    break;
                case enumPointStatus.Found:
                case enumPointStatus.OutRangeLeft:
                case enumPointStatus.OutRangeRight:
                    // El punto fue encontrado.
                    _YieldReturn = (YieldPoint)mList[_Point];

                    _YieldPoint.Term = _YieldReturn.Term;
                    _YieldPoint.Rate = _YieldReturn.Rate;
                    _YieldPoint.RateBid = _YieldReturn.RateBid;
                    _YieldPoint.RateOffer = _YieldReturn.RateOffer;
                    _YieldPoint.RateMid = _YieldReturn.RateMid;

                    if (mRateType.Equals(enumRate.RateBasis))
                    {
                        _YieldPoint.Rate = mRateBasis + Point(_Point).Spread;
                        _YieldPoint.RateBid = mRateBasis + Point(_Point).Spread;
                        _YieldPoint.RateOffer = mRateBasis + Point(_Point).Spread;
                        _YieldPoint.RateMid = mRateBasis + Point(_Point).Spread;
                    }
                    else if (mRateType.Equals(enumRate.RateOriginalSpread))
                    {
                        _YieldPoint.Rate = Point(_Point).Rate + Point(_Point).Spread;
                        _YieldPoint.RateBid = Point(_Point).RateBid + Point(_Point).Spread;
                        _YieldPoint.RateOffer = Point(_Point).RateOffer + Point(_Point).Spread;
                        _YieldPoint.RateMid = Point(_Point).RateMid + Point(_Point).Spread;
                    }
                    break;
                default:
                    break;
            }

            return _YieldPoint;
        }

        protected YieldPoint getPointYield(int index)
        {
            return (YieldPoint)mList[index];
        }

        protected void Set(enumGenerate generate, enumInterpolateType interpolateType)
        {
            mList = new ArrayList();
            mPointStatus = enumPointStatus.Initialize;
            mGenerate = generate;
            mInterpolateType = interpolateType;
            mRateBasis = 0;
            mRateType = enumRate.RateOriginal;
        }

        protected double Interpolate(int pointLeft, Double rateLeft, int pointRight, Double rateRight, int term)
        {
            Double _Rate = 0;
            switch (mInterpolateType)
            {
                case enumInterpolateType.InterpolateLineal:
                    _Rate = (rateLeft * (pointRight - term) / (pointRight - pointLeft)) + (rateRight * (term - pointLeft) / (pointRight - pointLeft));
                    break;

                default:
                    _Rate = 0;
                    break;
            }

            return _Rate;
        }

        #endregion

    }

}
