using System;
using System.Collections;
using System.Text;
using cData.Rate;

namespace cFinancialTools.Rate
{

    public class RateCurrency
    {

        
#region "Definicion de Variables"

        private int mID;
        private Hashtable mList;

#endregion

#region "Constructor"

        public RateCurrency()
        {
            Set(0);
        }

        public RateCurrency(int id)
        {
            Set(id);
        }

#endregion

#region "Propiedades

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

        public int Count
        {
            get
            {
                return mList.Count;
            }
        }

#endregion

#region "Funciones Publicas"

        public bool Add(enumPeriod id)
        {
            bool _Status = true;
            String _ID = id.ToString();

            if (Find(id))
            {
                _Status = false;
            }
            else
            {
                RatePeriod _Item = new RatePeriod(id);
                mList.Add(_ID, _Item);
            }

            return _Status;
        }

        public bool Find(enumPeriod id)
        {

            RatePeriod _Source = new RatePeriod();
            String _ID = id.ToString();
            bool _Status = true;

            _Source = (RatePeriod)mList[_ID];

            if (_Source == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public RatePeriod Read(enumPeriod id)
        {

            String _ID = id.ToString();
            RatePeriod _Source = new RatePeriod();

            if (Find(id))
            {
                _Source = (RatePeriod)mList[_ID];
            }

            return _Source;
        }

        public bool Item(enumPeriod id, RatePeriod item)
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

        public bool Remove(enumPeriod id)
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

        protected void Set(int id)
        {
            mList = new Hashtable();
            mID = id;
        }

#endregion
        
    }

}
