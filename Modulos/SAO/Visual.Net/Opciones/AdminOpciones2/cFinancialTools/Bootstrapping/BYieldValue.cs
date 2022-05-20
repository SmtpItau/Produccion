using System;
using System.Collections;
using System.Text;

namespace cFinancialTools.Bootstrapping
{
    public class BYieldValue
    {

    #region "Definicion de Variables"
        protected ArrayList mList;
        protected enumPointStatus mPointStatus;
    #endregion

    #region "Constructor"
        public BYieldValue()
        {
            Set();
        }
    #endregion

    #region "Propiedades"
        public int Count
        {
            get
            {
                return mList.Count;
            }
        }

        public enumPointStatus PointStatus
        {
            get
            {
                return mPointStatus;
            }
        }
    #endregion

    #region "Funciones Publicas"
        public bool Find(DateTime date)
        {
            bool _Status = true;
            int _Point = BinarySearch(date);

            switch (mPointStatus)
            {
                case enumPointStatus.Initialize:
                case enumPointStatus.OutRangeRight:
                    _Status = false;
                    break;
                default:
                    _Status = true;
                    break;
            }

            return _Status;

        }

        public bool Add(BYieldPoint yieldPoint)
        {
            bool _Status = true;

            if (Find(yieldPoint.Date))
            {
                _Status = false;
            }
            else
            {
                mList.Add(yieldPoint);
            }

            return _Status;

        }

        public bool Add(DateTime date, Double rate, enumBootstrappingType bootstrappingType)
        {
            bool _Status = true;

            if (Find(date))
            {
                _Status = false;
            }
            else
            {
                BYieldPoint _Item = new BYieldPoint(date, rate, bootstrappingType);
                mList.Add(_Item);
            }

            return _Status;

        }

        public BYieldPoint Read(DateTime date)
        {

            BYieldPoint _Item = new BYieldPoint();
            int _Point = BinarySearch(date);

            if (_Point > 0)
            {
                _Item = (BYieldPoint)mList[_Point];
            }

            return _Item;
        }

        public BYieldPoint Point(int point)
        {
            BYieldPoint _YieldPoint = new BYieldPoint();
            int _PointBottom = mList.Count - 1;

            if (_PointBottom >= point)
            {
                _YieldPoint = (BYieldPoint)mList[point];
            }

            return _YieldPoint;
        }

        public ArrayList ReadAll()
        {
            return mList;
        }

        public bool Item(DateTime date, BYieldPoint item)
        {

            bool _Status = true;
            int _Point = BinarySearch(date);

            if (_Point > 0)
            {
                mList[_Point] = item;
            }
            else
            {
                _Status = false;
            }

            return _Status;

        }

        public bool Item(int point, BYieldPoint item)
        {

            bool _Status = true;

            if (point > 0)
            {
                mList[point] = item;
            }
            else
            {
                _Status = false;
            }

            return _Status;

        }

        public bool Remove(DateTime date)
        {
            bool _Status = true;
            int _Point = BinarySearch(date);

            if (_Point > 0)
            {
                mList.Remove(_Point);
            }
            else
            {
                _Status = false;
            }

            return _Status;
        }
    #endregion

    #region "Funciones Protegidas"
        protected int BinarySearch(DateTime date)
        {

            int _Point = 0;
            int _PointLeft = 0;
            int _PointRight = 0;
            DateTime _Date;

            if (Count == 0)
            {
                return 0;
            }

            // Verifica si el punto solicitado es el primer punto
            if (Point(PointTop()).Date >= date)
            {
                _Point = 0;
                mPointStatus = enumPointStatus.OutRangeLeft;

                if (Point(PointTop()).Date == date)
                {
                    mPointStatus = enumPointStatus.Found;
                }

            }
            // Verifica si el punto solicitado es el ultimo de la lista
            else if (Point(PointBottom()).Date <= date)
            {
                _Point = Count - 1;

                mPointStatus = enumPointStatus.OutRangeRight;

                if (Point(_Point).Date == date)
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

                    _Date = Point(_Point).Date;

                    if (_Date == date)
                    {
                        mPointStatus = enumPointStatus.Found;
                        break;
                    }
                    else if (_Date < date)
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

            return _Point;
        }

        protected int PointTop()
        {
            int _Point = -1;

            if (Count > 0)
            {
                _Point = 0;
            }

            return _Point;
        }

        protected int PointBottom()
        {
            return Count - 1;
        }

        protected void Set()
        {
            mList = new ArrayList();
        }
    #endregion

    }
}
