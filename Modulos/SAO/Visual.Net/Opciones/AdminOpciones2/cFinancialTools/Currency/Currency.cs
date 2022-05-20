using System;
using System.Collections;
using cData.Currency;

namespace cFinancialTools.Currency
{

    public class Currency
    {

#region "Definición de Variables"

        protected int mID;
        protected String mName;
        protected String mNemo;
        protected enumRelacionRespectoDolar mRelationAgainstTheUSD;
        protected enumBasis mBasis;
        protected int mDecimals;
        protected String mCurveID;
        protected enumStatus mStatus;
        protected String mMessage;

        protected Hashtable mList;

#endregion

#region "Constructor"

        public Currency()
        {

            Set(0, "", "", enumRelacionRespectoDolar.Multiplica, enumBasis.Basis_Act_360, 0);
        }

        public Currency(int id, String name, String nemo, enumRelacionRespectoDolar relationAgainstTheUSD, enumBasis basis, int decimals)
        {
            Set(id, name, nemo, relationAgainstTheUSD, basis, decimals);
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

        public String Nemo
        {
            get
            {
                return mNemo;
            }
            set
            {
                mNemo = value;
            }
        }

        public enumRelacionRespectoDolar RelationAgainstTheUSD
        {
            get
            {
                return mRelationAgainstTheUSD;
            }
            set
            {
                mRelationAgainstTheUSD = value;
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

        public int Decimals
        {
            get
            {
                return mDecimals;
            }
            set
            {
                mDecimals = value;
            }
        }

        public String CurveID
        {
            get
            {
                return mCurveID;
            }
            set
            {
                mCurveID = value;
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

        public bool Add(enumSource sourceID)
        {
            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                _Status = false;
            }
            else
            {
                CurrencySource _ItemList = new CurrencySource(sourceID);
                mList.Add(_SourceID, _ItemList);
            }

            return _Status;

        }

        public bool Find(enumSource sourceID)
        {

            CurrencySource _Source = new CurrencySource();
            String _SourceID = sourceID.ToString();
            bool _Status = true;

            _Source = (CurrencySource)mList[_SourceID];

            if (_Source == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public CurrencySource Read(enumSource sourceID)
        {

            String _SourceID = sourceID.ToString();
            CurrencySource _Source = new CurrencySource();

            if (Find(sourceID))
            {
                _Source = (CurrencySource)mList[_SourceID];
            }

            return _Source;
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

        public bool Item(enumSource sourceID, CurrencySource _Item)
        {

            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                mList[_SourceID] = _Item;
            }
            else
            {
                _Status = false;
            }

            return _Status;

        }

        public bool Remove(enumSource sourceID)
        {
            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                mList.Remove(sourceID);
            }
            else
            {
                _Status = false;
            }

            return _Status;
        }

#endregion

#region "Funciones Protegidas"

        protected void Set(int id, String name, String nemo, enumRelacionRespectoDolar relationAgainstTheUSD, enumBasis basis, int decimals)
        {
            mID = ID;
            mName = name;
            mNemo= nemo;
            mRelationAgainstTheUSD = relationAgainstTheUSD;
            mBasis = basis;
            mDecimals = decimals;
            mMessage = "";
            if (ID == 0)
            {
                mStatus = enumStatus.Initialize;
            }
            else
            {
                mStatus = enumStatus.Already;
            }
            mList = new Hashtable();
        }

#endregion

    }

}
