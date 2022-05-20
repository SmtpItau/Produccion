using System;
using System.Collections;
using System.Text;
using cData.Rate;

namespace cFinancialTools.Rate
{

    public class RateSource
    {

#region "Definicion de Variables"

        private enumSource mID;
        private Hashtable mList;

#endregion

#region "Constructor"

        public RateSource()
        {
            Set(enumSource.System);
        }

        public RateSource(enumSource id)
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

        public bool Add(DateTime date, Double value)
        {
            bool _Status = true;
            String _Date = date.ToString("yyyyMMdd");

            if (Find(date))
            {
                _Status = false;
            }
            else
            {
                RateValue _Item = new RateValue(date, value);
                mList.Add(_Date, _Item);
            }

            return _Status;

        }

        public bool Find(DateTime date)
        {

            RateValue _RateValue = new RateValue();
            String _Date = date.ToString("yyyyMMdd");
            bool _Status = true;

            _RateValue = (RateValue)mList[_Date];

            if (_RateValue == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public RateValue Read(DateTime date)
        {

            String _Date = date.ToString("yyyyMMdd");
            RateValue _Item = new RateValue();

            if (Find(date))
            {
                _Item = (RateValue)mList[_Date];
            }

            return _Item;
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

        public bool Item(DateTime date, RateValue item)
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
