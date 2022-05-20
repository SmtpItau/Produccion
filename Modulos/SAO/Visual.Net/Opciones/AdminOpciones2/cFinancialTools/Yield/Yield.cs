using System;
using System.Collections;
using System.Text;
using cData.Yield;
using Microsoft.VisualBasic;

namespace cFinancialTools.Yield
{

    public class Yield
    {

        #region "Definición de Variables"

        private String mID;
        private String mName;
        private enumBasis mBasis;
        private enumGenerate mGenerate;

        private Hashtable mList;
        private enumInterpolateType mInterpolateType;
        //private enumPointStatus mPointStatus; // revisar

        private enumStatus mStatus;
        private String mMessage;

        #endregion

        #region "Constructor"

        public Yield()
        {
            Set("", "", enumBasis.Basis_Act_360, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal);
        }

        public Yield(String id, String name, enumBasis basis, enumGenerate generate, enumInterpolateType interpolateType)
        {
            Set(id, name, basis, generate, interpolateType);
            
        }

        #endregion

        #region "Propiedades"

        public String ID
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

        public enumGenerate Generate
        {
            get
            {
                return mGenerate;
            }
            set
            {
                mGenerate = value;
            }
        }

        public enumInterpolateType InterpolateType
        {
            get
            {
                return mInterpolateType;
            }
            set
            {
                mInterpolateType = value;
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
                YieldSource _Item = new YieldSource(sourceID);
                mList.Add(_SourceID, _Item);
            }

            return _Status;

        }

        public bool Find(enumSource sourceID)
        {

            YieldSource _Source = new YieldSource();
            String _SourceID = sourceID.ToString();
            bool _Status = true;

            _Source = (YieldSource)mList[_SourceID];

            if (_Source == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public YieldSource Read(enumSource sourceID)
        {

            String _SourceID = sourceID.ToString();
            YieldSource _Source = new YieldSource();

            if (Find(sourceID))
            {
                _Source = (YieldSource)mList[_SourceID];
            }

            return _Source;
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

        public bool Item(enumSource sourceID, YieldSource item)
        {

            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                mList[_SourceID] = item;
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

        protected void Set(String id, String name, enumBasis basis, enumGenerate generate, enumInterpolateType interpolateType)
        {
            mID = id;
            mName = name;
            mBasis = basis;
            mGenerate = generate;

            mList = new Hashtable();

            mInterpolateType = interpolateType;
            mStatus = enumStatus.Initialize;
            mMessage = "";
        }

        #endregion

    }

}
