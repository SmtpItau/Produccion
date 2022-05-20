using System;
using System.Collections;
using System.Text;

namespace cFinancialTools.Struct
{

    public class SensibilitiesStruct
    {

        #region "Atributos privados"

        private long mOperationNumber;
        private int mID;
        private int mCurrencyPrincipal;
        private int mCurrencySecundary;
        private String mInstruments;
        private String mCurveName;
        private double mMarkToMarketValue;
        private double mSensibilitiesValue;
        private double mDeltaSensibilitiesValue;
        private double mEstimationValue;
        private double mMarkToMarketRateDay0;
        private double mMarkToMarketRateDay1;
        private int mCurrencySensibilities;
        private enumPointStatus mPointStatus;
        private int mCurrencySensibilitiesLeft;
        private int mCurrencySensibilitiesRight;

        private ArrayList mList;

        #endregion

        #region "Construtores"

        public SensibilitiesStruct()
        {
            Set();
        }

        #endregion

        #region "Atributos Publicos"

        public long OperationNumber
        {
            get
            {
                return mOperationNumber;
            }
            set
            {
                mOperationNumber = value;
            }
        }

        public int ID
        {
            get
            {
                return mID;
            }
            set
            {
                mID = value;
            }
        }

        public int CurrencyPrincipal
        {
            get
            {
                return mCurrencyPrincipal;
            }
            set
            {
                mCurrencyPrincipal = value;
            }
        }

        public int CurrencySecundary
        {
            get
            {
                return mCurrencySecundary;
            }
            set
            {
                mCurrencySecundary = value;
            }
        }

        public String Instruments
        {
            get
            {
                return mInstruments;
            }
            set
            {
                mInstruments = value;
            }
        }

        public String CurveName
        {
            get
            {
                return mCurveName;
            }
            set
            {
                mCurveName = value;
            }
        }

        public double MarkToMarketValue
        {
            get
            {
                return mMarkToMarketValue;
            }
            set
            {
                mMarkToMarketValue = value;
            }
        }

        public double SensibilitiesValue
        {
            get
            {
                return mSensibilitiesValue;
            }
            set
            {
                mSensibilitiesValue = value;
            }
        }

        public double DeltaSensibilitiesValue
        {
            get
            {
                return mDeltaSensibilitiesValue;
            }
            set
            {
                mDeltaSensibilitiesValue = value;
            }
        }

        public double EstimationValue
        {
            get
            {
                return mEstimationValue;
            }
            set
            {
                mEstimationValue = value;
            }
        }

        public double MarkToMarketRateDay0
        {
            get
            {
                return mMarkToMarketRateDay0;
            }
            set
            {
                mMarkToMarketRateDay0 = value;
            }
        }

        public double MarkToMarketRateDay1
        {
            get
            {
                return mMarkToMarketRateDay1;
            }
            set
            {
                mMarkToMarketRateDay1 = value;
            }
        }

        public int CurrencySensibilities
        {
            get
            {
                return mCurrencySensibilities;
            }
        }

        public SensibilitiesDetail PointTop
        {
            get
            {
                return Point(0);
            }
        }

        public SensibilitiesDetail PointBottom
        {
            get
            {
                if (mList.Count.Equals(0))
                {
                    return new SensibilitiesDetail();
                }
                else
                {
                    return Point(mList.Count);
                }
            }
        }

        #endregion

        #region "Metodos Publicos"

        public bool Find(int term)
        {
            
            bool _Status = false;

            BinarySearch(term);

            if (mPointStatus.Equals(enumPointStatus.Found))
            {
                _Status = true;
            }

            return _Status;

        }

        public SensibilitiesDetail Read(int term)
        {

            SensibilitiesDetail _SensibilitiesStruct = new SensibilitiesDetail();

            if (Find(term))
            {
                _SensibilitiesStruct = (SensibilitiesDetail)mList[mCurrencySensibilities];
            }

            return _SensibilitiesStruct;

        }

        public void Add(SensibilitiesDetail sensibilitiesDetail)
        {
            mList.Add(sensibilitiesDetail);
        }

        public void Add(int term, double sensibilitiesValue, double deltaSensibilitiesValue, double estimationValue)
        {

            mSensibilitiesValue += sensibilitiesValue;
            mEstimationValue += estimationValue;

            SensibilitiesDetail _SensibilitiesDetail = new SensibilitiesDetail();

            _SensibilitiesDetail.Term = term;
            _SensibilitiesDetail.SensibilitiesValue = sensibilitiesValue;
            _SensibilitiesDetail.DeltaSensibilitiesValue = deltaSensibilitiesValue;
            _SensibilitiesDetail.EstimationValue = estimationValue;

            Add(_SensibilitiesDetail);
        }

        public void Remove(int index)
        {
            mList.Remove(index);
        }

        public void Item(SensibilitiesDetail sensibilitiesDetail)
        {
            
            int _Term = sensibilitiesDetail.Term;

            if (Find(_Term))
            {
                mList[_Term] = sensibilitiesDetail;
            }

        }

        public SensibilitiesDetail Point(int index)
        {
            SensibilitiesDetail _SensibilitiesDetail = new SensibilitiesDetail();

            if (index < mList.Count)
            {
                _SensibilitiesDetail = (SensibilitiesDetail)mList[index];
            }

            return _SensibilitiesDetail;
        }

        #endregion

        #region "Metodos Privados"

        private void BinarySearch(int term)
        {
            int _PointLeft = 0;
            int _Point = 0;
            int _PointRight = 0;
            int _Term = 0;
            SensibilitiesDetail _SensibilitiesStruct = new SensibilitiesDetail();

            if (mList.Count == 0)
            {
                mPointStatus = enumPointStatus.Initialize;
                mCurrencySensibilitiesLeft = -1;
                mCurrencySensibilities = _Point;
                mCurrencySensibilitiesRight = -1;
            }
            // Verifica si el punto solicitado es el primer punto
            else if (PointTop.Term >= term)
            {
                _PointLeft = 0;
                _PointRight = 0;
                _Point = 0;
                mPointStatus = enumPointStatus.OutRangeLeft;
                mCurrencySensibilities= 0;

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
                mCurrencySensibilities = _Point;

                mPointStatus = enumPointStatus.OutRangeRight;

                if (Point(_PointRight).Term == term)
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

                if (Point(_Point).Term.Equals(_Term))
                {
                    mPointStatus = enumPointStatus.Found;
                    mCurrencySensibilitiesLeft = -1;
                    mCurrencySensibilities = _Point;
                    mCurrencySensibilitiesRight = -1;
                }
                else
                {
                    mPointStatus = enumPointStatus.NotFound;
                    mCurrencySensibilitiesLeft = _PointLeft;
                    mCurrencySensibilities = -1;
                    mCurrencySensibilitiesRight = _PointRight;
                }

            }

        }

        private void Set()
        {
            mOperationNumber = 0;
            mID = 0;
            mCurrencyPrincipal = 0;
            mCurrencySecundary = 0;
            mInstruments = "";
            mCurveName = "";
            mMarkToMarketValue = 0;
            mSensibilitiesValue = 0;
            mDeltaSensibilitiesValue = 0;
            mEstimationValue = 0;
            mMarkToMarketRateDay0 = 0;
            mMarkToMarketRateDay1 = 0;
            mCurrencySensibilities = 0;
            mPointStatus = enumPointStatus.Initialize;
            mCurrencySensibilitiesLeft = 0;
            mCurrencySensibilitiesRight = 0;
            mList = new ArrayList();
        }

        #endregion

    }

}
