using System;
using System.Collections;
using System.Text;
using cData.Yield;

namespace cFinancialTools.Yield
{

    public class YieldSource
    {

        #region "Definicion de Variables"

        private enumSource mID;
        private Hashtable mList;

        #endregion

        #region "Constructor"

        public YieldSource()
        {
            Set(enumSource.System);
        }

        public YieldSource(enumSource id)
        {
            Set(id);
        }

        #endregion

        #region "Propiedades

        public enumSource ID
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

        public int Count
        {
            get
            {
                return mList.Count;
            }
        }

        #endregion

        #region "Funciones Publicas"

        public bool Add(DateTime date)
        {
            return Add(date, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal);
        }

        public bool Add(DateTime date, enumGenerate generate, enumInterpolateType interpolateType)
        {
            bool _Status = true;
            String _Date = date.ToString("yyyyMMdd");

            if (Find(date))
            {
                _Status = false;
            }
            else
            {
                YieldValue _Item = new YieldValue(date, generate, interpolateType);
                mList.Add(_Date, _Item);
            }

            return _Status;

        }

        public bool Find(DateTime date)
        {

            YieldValue _Item = new YieldValue();
            String _Date = date.ToString("yyyyMMdd");
            bool _Status = true;

            _Item = (YieldValue)mList[_Date];

            if (_Item == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public YieldValue Read(DateTime date)
        {

            String _Date = date.ToString("yyyyMMdd");
            YieldValue _Item = new YieldValue();

            if (Find(date))
            {
                _Item = (YieldValue)mList[_Date];
            }

            return _Item;
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

        public bool Item(DateTime date, YieldValue item)
        {

            bool _Status = true;
            String _Date = date.ToString("yyyyMMdd");

            if (Find(date))
            {
                mList[_Date] = item;
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
            String _Date = date.ToString("yyyyMMdd");

            if (Find(date))
            {
                mList.Remove(_Date);
            }
            else
            {
                _Status = false;
            }

            return _Status;
        }

        #endregion

        #region "Funciones Protegidas"

        protected void Set(enumSource id)
        {
            mList = new Hashtable();
            mID = id;
        }

        #endregion

    }

}
