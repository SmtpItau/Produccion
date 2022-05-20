using System;
using System.Collections;
using System.Text;
using cData.Rate;

namespace cFinancialTools.Rate
{

    public class RatePeriod
    {

#region "Definicion de Variables"

        private enumPeriod mID;
        private Hashtable mList;

#endregion

#region "Constructor"

        public RatePeriod()
        {
            Set(enumPeriod.Anual);
        }

        public RatePeriod(enumPeriod id)
        {
            Set(id);
        }

#endregion

#region "Propiedades

        public enumPeriod ID
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

        public bool Add(enumSource id)
        {
            bool _Status = true;
            String _ID = id.ToString();

            if (Find(id))
            {
                _Status = false;
            }
            else
            {
                RateSource _Item = new RateSource(id);
                mList.Add(_ID, _Item);
            }

            return _Status;
        }

        public bool Find(enumSource id)
        {

            RateSource _Source = new RateSource();
            String _ID = id.ToString();
            bool _Status = true;

            _Source = (RateSource)mList[_ID];

            if (_Source == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public RateSource Read(enumSource id)
        {

            String _ID = id.ToString();
            RateSource _Source = new RateSource();

            if (Find(id))
            {
                _Source = (RateSource)mList[_ID];
            }

            return _Source;
        }

        public bool Item(enumSource id, RateSource item)
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

        public bool Remove(enumSource id)
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

        protected void Set(enumPeriod id)
        {
            mList = new Hashtable();
            mID = id;
        }

#endregion

    }

}
