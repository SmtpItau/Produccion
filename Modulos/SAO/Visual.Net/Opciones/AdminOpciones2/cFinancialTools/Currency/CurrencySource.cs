using System;
using System.Collections;
using cData.Currency;

namespace cFinancialTools.Currency
{

    public class CurrencySource
    {

        #region "Definicion de Variables"

        private enumSource mID;
        private Hashtable mList;

        #endregion

        #region "Constructor"

        public CurrencySource()
        {
            Set(enumSource.System);
        }

        public CurrencySource(enumSource id)
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

        public bool Add(DateTime date, double value)
        {
            bool _Status = true;
            String _Date = date.ToString("yyyyMMdd");

            if (Find(date))
            {
                _Status = false;
            }
            else
            {
                CurrencyValue _Item = new CurrencyValue(date, value);
                mList.Add(_Date, _Item);
            }

            return _Status;

        }

        public bool Add(DateTime date, double valueBid, double valueOffer, double valueMid)
        {
            bool _Status = true;
            String _Date = date.ToString("yyyyMMdd");

            if (Find(date))
            {
                _Status = false;
            }
            else
            {
                CurrencyValue _Item = new CurrencyValue(date, valueBid, valueOffer, valueMid, 0);
                mList.Add(_Date, _Item);
            }

            return _Status;

        }

        public bool Find(DateTime date)
        {

            CurrencyValue _Item = new CurrencyValue();
            String _Date = date.ToString("yyyyMMdd");
            bool _Status = true;

            _Item = (CurrencyValue)mList[_Date];

            if (_Item == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public CurrencyValue Read(DateTime date)
        {

            String _Date = date.ToString("yyyyMMdd");
            CurrencyValue _Item = new CurrencyValue();

            if (Find(date))
            {
                _Item = (CurrencyValue)mList[_Date];
            }

            return _Item;
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

        public bool Item(DateTime date, CurrencyValue item)
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
