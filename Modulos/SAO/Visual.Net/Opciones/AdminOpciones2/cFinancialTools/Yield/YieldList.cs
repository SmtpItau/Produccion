using System;
using System.Collections;
using System.Text;
using System.Data;
using cData.Yield;

namespace cFinancialTools.Yield
{

    public class YieldList
    {

        #region "Definicion de Variables"

        protected Hashtable mList;
        protected String mMessage;
        protected String mStack;
        protected enumSetPrincingLoading mSetPrincingLoading;

        #endregion

        #region "Constructor"

        public YieldList()
        {
            mList = new Hashtable();
            mSetPrincingLoading = enumSetPrincingLoading.OrginalSystem;
        }

        public YieldList(String id, DateTime date)
        {
            mList = new Hashtable();
            mSetPrincingLoading = enumSetPrincingLoading.OrginalSystem;
            Load(id, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, date);
        }

        public YieldList(String id, enumGenerate generate, enumInterpolateType interpolateType, enumSource sourceID, DateTime date)
        {
            mList = new Hashtable();
            mSetPrincingLoading = enumSetPrincingLoading.OrginalSystem;
            Load(id, generate, interpolateType, sourceID, date);
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

        public enumSetPrincingLoading SetPrincingLoading
        {
            get
            {
                return mSetPrincingLoading;
            }
            set
            {
                mSetPrincingLoading = value;
            }
        }

        #endregion

        #region "Funciones publicas"

        #region "Status (Falta Revisar esta seccion)"

        // Falta completar
        public enumStatus Status(String id)
        {
            //Hashtable _Ratestatus = new Hashtable();
            //cFinancialTools.Rate.Rate _Rate;
            //String _DateLoadRate = dateloadRate.ToString("yyyyMMdd");

            //_Ratestatus = (Hashtable)mList[id];
            //_Rate = (cFinancialTools.Rate.Rate)_Ratestatus[_DateLoadRate];
            //return _Rate.RateStatus;
            return enumStatus.Already;
        }

        // Falta completar
        public enumStatus Status(String id, enumSource sourceID)
        {
            return enumStatus.Already;
        }

        // Falta completar
        public enumStatus Status(String id, enumSource sourceID, DateTime date)
        {
            return enumStatus.Already;
        }

        // Falta completar
        public String Message(String id)
        {
            //Hashtable _Ratestatus = new Hashtable();
            //cData.Rate.enumStatus _Rate;
            //String _DateLoadRate = dateloadRate.ToString("yyyyMMdd");
            //String _Message;
            //cData.Rate.Rate _RateMessage = new cData.Rate.Rate();

            //_Rate = Ratestatus(rateID, dateloadRate);

            //_Message = _RateMessage.Message(_Rate);

            //return _Message;
            return "";
        }

        // Falta completar
        public String Message(String id, enumSource sourceID)
        {
            return "";
        }

        // Falta completar
        public String Message(String id, enumSource sourceID, DateTime date)
        {
            return "";
        }

        #endregion

        #region "LOAD"

        public bool Load(String id, enumGenerate generate, enumInterpolateType interpolateType, enumSource sourceID, DateTime date)
        {
            bool _Status = true;

            Yield _Yield = new Yield();
            YieldSource _YieldSource = new YieldSource();
            DateTime _Date = date;

            try
            {
                if (!Find(id))
                {
                    _Yield = LoadYield(id);
                }
                else
                {
                    _Yield = Read(id);
                }

                if (!_Yield.Find(sourceID))
                {
                    _Yield.Generate = generate;
                    _Yield.Add(sourceID);
                }

                _YieldSource = (YieldSource)_Yield.Read(sourceID);

                if (mSetPrincingLoading == enumSetPrincingLoading.OrginalSystem)
                {
                    LoadYieldValue(id, generate, interpolateType, sourceID, date);
                }
                else
                {
                    LoadYieldSetPricing(id, generate, interpolateType, sourceID, date);
                }
            }
            catch (Exception Error)
            {
                mMessage = Error.Message;
                mStack = Error.StackTrace;
                _Status = false;
            }

            return _Status;
        }

        public bool Load(String id, enumGenerate generate, enumInterpolateType interpolateType, enumSource sourceID, DateTime dateRateFrom, DateTime dateRateTo)
        {

            bool _Status = false;

            Yield _Yield = new Yield();
            YieldSource _YieldSource = new YieldSource();
            bool _CheckDate = false;
            DateTime _Date = dateRateFrom;

            try
            {
                if (!Find(id))
                {
                    _Yield = LoadYield(id);
                }
                else
                {
                    _Yield = Read(id);
                }

                if (!_Yield.Find(sourceID))
                {
                    _Yield.Generate = generate;
                    _Yield.Add(sourceID);
                }

                _YieldSource = (YieldSource)_Yield.Read(sourceID);

                while (_Date <= dateRateTo)
                {
                    if (!_YieldSource.Find(_Date))
                    {
                        _CheckDate = true;
                        break;
                    }
                    _Date = _Date.AddDays(1);
                }

                if (_CheckDate == true)
                {
                    if (mSetPrincingLoading == enumSetPrincingLoading.OrginalSystem)
                    {
                        LoadYieldValue(id, generate, interpolateType, sourceID, dateRateFrom, dateRateTo);
                    }
                    else
                    {
                        LoadYieldSetPricing(id, generate, interpolateType, sourceID, dateRateFrom);
                    }
                }
            }
            catch (Exception Error)
            {
                mMessage = Error.Message;
                mStack = Error.StackTrace;
                _Status = false;
            }

            return _Status;

        }

        #endregion

        #region "Find"

        public bool Find(String id)
        {
            Yield _Yield = new Yield();
            bool _Status = true;

            _Yield = (Yield)mList[id];

            if (_Yield == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public bool Find(String id, enumSource sourceID)
        {
            Yield _Yield = new Yield();
            bool _Status = true;

            if (Find(id))
            {
                _Yield = (Yield)Read(id);

                if (!_Yield.Find(sourceID))
                {
                    _Status = false;
                }
            }

            return _Status;
        }

        public bool Find(String id, enumSource sourceID, DateTime date)
        {
            YieldSource _YieldSource = new YieldSource();
            bool _Status = true;

            if (Find(id, sourceID))
            {
                _YieldSource = (YieldSource)Read(id, sourceID);

                if (!_YieldSource.Find(date))
                {
                    _Status = false;
                }
            }

            return _Status;
        }

        public bool Find(String id, enumSource sourceID, DateTime date, int term)
        {
            YieldValue _YieldValue = new YieldValue();
            cFinancialTools.Yield.Yield _Yield = new cFinancialTools.Yield.Yield();

            bool _Status = true;

            if (Find(id, sourceID, date))
            {
                _YieldValue = (YieldValue)Read(id, sourceID, date);

                _Yield = (Yield)mList[id];

                if (_Yield.Generate == enumGenerate.OriginalYield)
                {
                    _Status = true;
                }
                else if (!_YieldValue.Find(term))
                {
                    _Status = false;
                }
            }

            return _Status;
  
        }

        #endregion

        #region "READ"

        public Yield Read(String id)
        {
            Yield _Yield = new Yield();

            if (Find(id))
            {
                _Yield = (Yield)mList[id];
            }

            return _Yield;
        }

        public YieldSource Read(String id, enumSource sourceID)
        {
            YieldSource _YieldSource = new YieldSource();

            if (Find(id, sourceID))
            {
                _YieldSource = Read(id).Read(sourceID);
            }

            return _YieldSource;
        }

        public YieldValue Read(String id, enumSource sourceID, DateTime date)
        {
            YieldValue _YieldValue = new YieldValue();

            if (Find(id,sourceID,date))
            {
                _YieldValue = Read(id, sourceID).Read(date);
            }

            return _YieldValue;
        }

        public YieldPoint Read(String id, enumSource sourceID, DateTime date, int term)
        {
            YieldPoint _YieldPoint = new YieldPoint();

            if (Find(id, sourceID, date, term))
            {
                _YieldPoint = Read(id, sourceID, date).Read(term);
            }

            return _YieldPoint;
        }

        #endregion

        #region "READALL"

        public Hashtable ReadAll()
        {
            return mList;
        }

        public Hashtable ReadAll(String id)
        {
            Yield _Yield = new Yield();

            _Yield = Read(id);

            return _Yield.ReadAll();
        }

        public Hashtable ReadAll(String id, enumSource sourceID)
        {
            YieldSource _YieldSource = new YieldSource();

            _YieldSource = Read(id, sourceID);

            return _YieldSource.ReadAll();
        }

        public ArrayList ReadAll(String id, enumSource sourceID, DateTime date)
        {
            YieldValue _YieldValue = new YieldValue();

            _YieldValue = Read(id, sourceID, date);

            return _YieldValue.ReadAll();
        }

        #endregion

        #region "Save"

        public void Save(string id, DateTime portFolioDate, DateTime dateYield1, DateTime dateYield2)
        {

            YieldValue _YieldValue1 = new YieldValue();
            YieldValue _YieldValue2 = new YieldValue();
            YieldPoint _YieldPoint = new YieldPoint();
            DataTable _DataTableID = new DataTable();
            string _Query;
            string _QueryYield;
            int _Point;
            double _ID;

            _YieldValue1 = Read(id, enumSource.System, dateYield1);
            _YieldValue2 = Read(id, enumSource.System, dateYield2);

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");

            _Query = "SELECT 'ID' = ISNULL( MAX(id), 0 ) FROM dbo.YieldValue WHERE yieldDate = '[@Date]'\n";
            _Query = _Query.Replace("[@Date]", portFolioDate.ToString("yyyyMMdd"));

            _Connect.Execute(_Query);

            _DataTableID = _Connect.QueryDataTable();

            if (_DataTableID == null)
            {
                _ID = 0;
            }
            else if (_DataTableID.Rows.Count.Equals(0))
            {
                _ID = 0;
            }
            else
            {
                if (_DataTableID.Rows[0]["ID"].ToString().Equals("0"))
                {
                    _ID = 0;
                }
                else
                {
                    _ID = double.Parse(_DataTableID.Rows[0]["ID"].ToString().Substring(8));
                }
            }

            if (_ID.Equals(0))
            {
                _ID = 0; // double.Parse(portFolioDate.ToString("yyyyMMdd")) * Math.Pow(10, 8);
            }

            _Query = "";

            _Query += "DECLARE @ID        NUMERIC(18)\n";
            _Query += "DECLARE @Date      DATETIME\n";
            _Query += "DECLARE @YieldName VARCHAR(20)\n\n";

            _Query += "SET @Date      = '[@Date]'\n";
            _Query += "SET @YieldName = '[@YieldName]'\n\n";

            _Query += "DELETE dbo.YieldValue WHERE yieldDate = @Date AND yieldname = @YieldName\n\n";

            _Query = _Query.Replace("[@Date]", portFolioDate.ToString("yyyyMMdd"));
            _Query = _Query.Replace("[@YieldName]", id);

            for (_Point = 0; _Point < _YieldValue1.Count; _Point++)
            {

                _YieldPoint = _YieldValue1.Point(_Point);

                _ID++;

                _QueryYield = "";
                _QueryYield += "SELECT @ID = [@ID]\n\n";
                _QueryYield += "INSERT INTO dbo.YieldValue ( ID, yieldDate, yieldname, term, rate1, rate2 ) ";
                _QueryYield += "VALUES ( @ID, @Date, @YieldName, [@Term], [@Rate1], [@Rate2] )\n\n";

                _QueryYield = _QueryYield.Replace("[@ID]", portFolioDate.ToString("yyyyMMdd") + _ID.ToString("00000000"));
                _QueryYield = _QueryYield.Replace("[@Term]", _YieldPoint.Term.ToString());
                _QueryYield = _QueryYield.Replace("[@Rate1]", _YieldPoint.Rate.ToString().Replace(",", "."));
                _QueryYield = _QueryYield.Replace("[@Rate2]", _YieldValue2.Read(_YieldPoint.Term).Rate.ToString().Replace(",", "."));

                _Query += _QueryYield;

            }

            _Connect.Execute(_Query);
            _Connect.Disconnection();
            _Connect = null;

        }

        #endregion

        #region GetYield

        public string GetYield(String id, enumSource sourceID, DateTime date)
        {
            YieldValue _YieldValue = Read(id, sourceID, date);
            YieldPoint _YieldPoint;
            string _Yield = "";
            int _YieldItem = 0;

            if (_YieldValue.Count > 0)
            {
                _Yield = string.Format("<Yield Name='{0}'>\n", id);
                for (_YieldItem = 0; _YieldItem < _YieldValue.Count; _YieldItem++)
                {
                    _YieldPoint = _YieldValue.Point(_YieldItem);
                    _Yield += string.Format(
                                             "<Point Tenor='{0}' Rate='{1}' RateBid='{2}' RateOffer='{3}' RateMid='{4}' Spread='{5}' />\n",
                                             _YieldPoint.Term,
                                             _YieldPoint.Rate,
                                             _YieldPoint.RateBid,
                                             _YieldPoint.RateOffer,
                                             _YieldPoint.RateMid,
                                             _YieldPoint.Spread
                                          );
                }
                _Yield += string.Format("</Yield>\n", id);
            }
            else
            {
                _Yield += string.Format("<Yield/>", id);
            }

            return _Yield;
        }

        #endregion

        #endregion

        #region "Funciones Protegidas"

        protected Yield LoadYield(String id)
        {

            DataTable _DataYield;
            cData.Yield.Yield _LoadYield = new cData.Yield.Yield();

            _DataYield = (DataTable)_LoadYield.Load(id);

            Yield _Yield = new Yield(
                                      id,
                                      _DataYield.Rows[0]["Descripcion"].ToString(),
                                      enumBasis.Basis_Act_360,
                                      enumGenerate.OriginalYield,
                                      enumInterpolateType.InterpolateLineal
                                    );

            mList.Add(id, _Yield);

            return _Yield;

        }

        protected bool LoadYieldValue(String id, enumGenerate generate, enumInterpolateType interpolateType, enumSource sourceID, DateTime dateFrom, DateTime dateTo)
        {

            Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue;
            cData.Yield.Yield _LoadYield = new cData.Yield.Yield(enumSource.System);
            DataTable _DataYield;
            String _SourceID = sourceID.ToString();
            int _Row;
            DateTime _Date;
            int _Term;
            Double _Rate;

            _Yield = (Yield)mList[id];
            _YieldSource = (YieldSource)_Yield.Read(sourceID);
            
            _DataYield = (DataTable)_LoadYield.LoadValue(id, dateFrom, dateTo);
            
            for (_Row = 0;  _Row <= _DataYield.Rows.Count - 1; _Row++)
            {
                _Date = (DateTime)_DataYield.Rows[_Row]["FechaGeneracion"];
                _Term = int.Parse(_DataYield.Rows[_Row]["Dias"].ToString());
                _Rate = Double.Parse(_DataYield.Rows[_Row]["ValorAsk"].ToString());

                if (!_YieldSource.Find(_Date))
                {
                    _YieldSource.Add(_Date, generate, interpolateType);
                }

                _YieldValue = (YieldValue)_YieldSource.Read(_Date);

                if (!_YieldValue.Find(_Term))
                {
                    _YieldValue.Add(_Term, _Rate);
                }

                _YieldSource.Item(_Date, _YieldValue);

            }

            _Yield.Status = _LoadYield.Status;
            _Yield.Message = _LoadYield.Message;

            _Yield.Item(sourceID, _YieldSource);
            mList[id] = _Yield;

            return true;

        }

        protected bool LoadYieldValue(String id, enumGenerate generate, enumInterpolateType interpolateType, enumSource sourceID, DateTime date)
        {

            Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue;
            cData.Yield.Yield _LoadYield = new cData.Yield.Yield(enumSource.System);
            DataTable _DataYield;
            String _SourceID = sourceID.ToString();
            int _Row;
            DateTime _Date;
            int _Term;
            Double _Rate;

            _Yield = (Yield)mList[id];
            _YieldSource = (YieldSource)_Yield.Read(sourceID);

            _DataYield = (DataTable)_LoadYield.LoadValue(id, date);

            for (_Row = 0; _Row <= _DataYield.Rows.Count - 1; _Row++)
            {
                _Date = (DateTime)_DataYield.Rows[_Row]["FechaGeneracion"];
                _Term = int.Parse(_DataYield.Rows[_Row]["Dias"].ToString());
                _Rate = Double.Parse(_DataYield.Rows[_Row]["ValorAsk"].ToString());

                if (!_YieldSource.Find(_Date))
                {
                    _YieldSource.Add(_Date, generate, interpolateType);
                }

                _YieldValue = (YieldValue)_YieldSource.Read(_Date);

                if (!_YieldValue.Find(_Term))
                {
                    _YieldValue.Add(_Term, _Rate);
                }

                _YieldSource.Item(_Date, _YieldValue);

            }

            _Yield.Status = _LoadYield.Status;
            _Yield.Message = _LoadYield.Message;

            _Yield.Item(sourceID, _YieldSource);
            mList[id] = _Yield;

            return true;

        }

        protected bool LoadYieldSetPricing(String id, enumGenerate generate, enumInterpolateType interpolateType, enumSource sourceID, DateTime date)
        {

            Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue;
            Turing2009Data.Parameters.Yield.YieldLoad _LoadYield = new Turing2009Data.Parameters.Yield.YieldLoad();

            DataTable _DataYield;
            String _SourceID = sourceID.ToString();
            int _Row;
            int _Term;
            double _RateBid;
            double _RateOffer;
            double _RateAsk;

            _Yield = (Yield)mList[id];
            _YieldSource = (YieldSource)_Yield.Read(sourceID);
            
            _DataYield = _LoadYield.Load(date, id, (int)mSetPrincingLoading);
            
            for (_Row = 0;  _Row <= _DataYield.Rows.Count - 1; _Row++)
            {
                _Term = int.Parse(_DataYield.Rows[_Row]["Tenor"].ToString());
                _RateBid = Double.Parse(_DataYield.Rows[_Row]["BID"].ToString());
                _RateOffer = Double.Parse(_DataYield.Rows[_Row]["ASK"].ToString());
                _RateAsk = Double.Parse(_DataYield.Rows[_Row]["MIDDLE"].ToString());

                if (!_YieldSource.Find(date))
                {
                    _YieldSource.Add(date, generate, interpolateType);
                }

                _YieldValue = (YieldValue)_YieldSource.Read(date);

                if (!_YieldValue.Find(_Term))
                {
                    _YieldValue.Add(_Term, _RateBid, _RateOffer, _RateAsk);
                }

                _YieldSource.Item(date, _YieldValue);

            }

            //_Yield.Status = _LoadYield.Status;
            //_Yield.Message = _LoadYield.Message;

            _Yield.Item(sourceID, _YieldSource);
            mList[id] = _Yield;

            return true;

        }

        #endregion

    }

}
