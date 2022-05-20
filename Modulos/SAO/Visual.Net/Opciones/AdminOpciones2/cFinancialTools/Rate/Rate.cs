using System;
using System.Collections;
using cData.Rate;

namespace cFinancialTools.Rate
{

    public class Rate
    {

#region "Definición de Variables"

        private int mID;
        private String mName;
        private enumPeriod mPeriod;
        private enumBasis mBasis;
        private enumStatus mStatus;
        private String mMessage;

        private Hashtable mList;

#endregion

#region "Constructor"

        public Rate()
        {

            Set(0, "", enumPeriod.Anual, enumBasis.Basis_Act_360);
        }

        public Rate(int id, String name, enumPeriod period, enumBasis basis)
        {
            Set(id, name, period, basis);
        }

#endregion

#region "Propiedades"

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

        public String Name
        {
            get
            {
                return mName;
            }
            set
            {
                mName = value;
            }
        }

        public enumPeriod Period
        {
            get
            {
                return mPeriod;
            }
            set
            {
                mPeriod = value;
            }
        }

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

        public enumStatus Status
        {
            get
            {
                return mStatus;
            }
            set
            {
                mStatus = value;
            }
        }

        public String Message
        {
            get
            {
                return mMessage;
            }
            set
            {
                mMessage = value;
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

        public bool Add(int id)
        {
            bool _Status = true;
            String _ID = id.ToString();

            if (Find(id))
            {
                _Status = false;
            }
            else
            {
                RateCurrency _Item = new RateCurrency(id);
                mList.Add(_ID, _Item);
            }

            return _Status;

        }

        public bool Find(int id)
        {

            RateCurrency _Source = new RateCurrency();
            String _ID = id.ToString();
            bool _Status = true;

            _Source = (RateCurrency)mList[_ID];

            if (_Source == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public RateCurrency Read(int id)
        {

            String _ID = id.ToString();
            RateCurrency _Item = new RateCurrency();

            if (Find(id))
            {
                _Item = (RateCurrency)mList[_ID];
            }

            return _Item;
        }

        public bool Item(int id, RateCurrency item)
        {

            bool _Status = false;
            String _ID = id.ToString();

            if (Find(id))
            {
                mList[_ID] = item;
                _Status = true;
            }

            return _Status;

        }

        public bool Remove(int id)
        {
            bool _Status = false;

            if (Find(id))
            {
                mList.Remove(id);
                _Status = true;
            }

            return _Status;
        }

#endregion

#region "Funciones Protegidas"

        protected void Set(int id, String name, enumPeriod period, enumBasis basis)
        {
            mID = id;
            mName = name;
            mPeriod = period;
            mBasis = basis;
            if (id == 0)
            {
                mStatus = enumStatus.Initialize;
            }
            else
            {
                mStatus = enumStatus.Loaded;
            }
            mList = new Hashtable();
        }

#endregion

    }

}
