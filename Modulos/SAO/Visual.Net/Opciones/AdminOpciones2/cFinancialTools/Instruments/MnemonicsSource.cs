using System;
using System.Collections;
using System.Text;
using cFinancialTools.Instruments;

namespace cFinancialTools.Instruments
{

    public class MnemonicsSource
    {

        #region "Atributos Privados"

        private enumSource mID;
        private ArrayList mList;

        #endregion

        #region "Constructor"

        public MnemonicsSource()
        {
            Set(enumSource.System);
        }

        public MnemonicsSource(enumSource id)
        {
            Set(id);
        }

        #endregion

        #region "Atributos Publicos"

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

        #region "Metodos Publicas"

        public bool Add(DevelonmentTable coupon)
        {
            bool _Status = true;

            if (Find(coupon.Coupon))
            {
                _Status = false;
            }
            else
            {
                mList.Add(coupon);
            }

            return _Status;

        }

        public bool Find(int couponNumber)
        {

            DevelonmentTable _Item = new DevelonmentTable();
            bool _Status = true;

            if (mList.Count >= couponNumber)
            {
                _Item = (DevelonmentTable)mList[couponNumber];

                if (_Item == null)
                {
                    _Status = false;
                }
            }
            else
            {
                _Status = false;

            }

            return _Status;
        }

        public DevelonmentTable Read(int couponNumber)
        {

            DevelonmentTable _Item = new DevelonmentTable();

            if (Find(couponNumber))
            {
                _Item = (DevelonmentTable)mList[couponNumber];
            }

            return _Item;
        }

        public ArrayList ReadAll()
        {
            return mList;
        }

        public bool Item(int couponNumber, DevelonmentTable item)
        {

            bool _Status = true;

            if (Find(couponNumber))
            {
                mList[couponNumber] = item;
            }
            else
            {
                _Status = false;
            }

            return _Status;

        }

        public bool Item(ArrayList develonmentTable)
        {
            mList = develonmentTable;
            return true;
        }

        public bool Remove(int couponNumber)
        {
            bool _Status = true;

            if (Find(couponNumber))
            {
                mList.Remove(couponNumber);
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
            mList = new ArrayList();
            mID = id;
        }

        #endregion

    }

}
