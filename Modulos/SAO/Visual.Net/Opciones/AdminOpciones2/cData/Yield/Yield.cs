using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;


namespace cData.Yield
{

    public class Yield
    {

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        public Yield()
        {
            SetYield(enumSource.System);
        }

        public Yield(enumSource id)
        {
            SetYield(id);
        }

        public enumStatus Status
        {
            get
            {
                return mStatus;
            }
        }

        public String Message
        {
            get
            {
                return ReadMessage(mStatus);
            }
        }

        public String Error
        {
            get
            {
                return mError;
            }
        }

        public String Stack
        {
            get
            {
                return mStack;
            }
        }

        public String ReadMessage(enumStatus status)
        {
            String _Message;

            switch (status)
            {
                case enumStatus.Already:
                    _Message = "La curva se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error al carga los valores para la fecha solicitada.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error al cargar la definición de la curva.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error al cargar la curva.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Se fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "La curva se esta cargando.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la curva.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontraron los puntos en la fecha solicitada.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataTable Load()
        {
            DataTable _Curve = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Curve = (DataTable)_System.Load();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Curve = (DataTable)_Bloomberg.Load();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Curve = (DataTable)_Excel.Load();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Curve;

        }

        public DataTable Load(String id)
        {
            DataTable _Curve = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Curve = (DataTable)_System.Load(id);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Curve = (DataTable)_Bloomberg.Load(id);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Curve = (DataTable)_Excel.Load(id);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Curve;

        }

        public DataTable LoadValue(String id, DateTime dateFrom, DateTime dateTo)
        {

            DataTable _Value = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Value = (DataTable)_System.LoadValue(id, dateFrom, dateTo);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Value = (DataTable)_Bloomberg.LoadValue(id, dateFrom, dateTo);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Value = (DataTable)_Excel.LoadValue(id, dateFrom, dateTo);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Value;

        }

        public DataTable LoadValue(String id, DateTime date)
        {

            DataTable _Value = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Value = (DataTable)_System.LoadValue(id, date);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Value = (DataTable)_Bloomberg.LoadValue(id, date);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Value = (DataTable)_Excel.LoadValue(id, date);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Value;

        }

        public DataTable ValidYield(DateTime date)
        {

            DataTable _ValidYield = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _ValidYield = _System.ValidYield(date);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _ValidYield = _Bloomberg.ValidYield(date);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _ValidYield = _Excel.ValidYield(date);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _ValidYield;

        }

        public DataTable YieldConfig()
        {

            DataTable _YieldConfig = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _YieldConfig = _System.YieldConfig();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _YieldConfig = _Bloomberg.YieldConfig();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _YieldConfig = _Excel.YieldConfig();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _YieldConfig;

        }

        protected void SetYield(enumSource id)
        {
            mStatus = enumStatus.Initialize;
            mSource = id;
        }

        private class Source
        {

            private enumStatus mStatus;
            private String mError;
            private String mStack;

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

            public String Error
            {
                get
                {
                    return mError;
                }
                set
                {
                    mError = value;
                }
            }

            public String Stack
            {
                get
                {
                    return mStack;
                }
                set
                {
                    mStack = value;
                }
            }

            public Source()
            {
            }

            public virtual bool ValidDate(DateTime date)
            {

                return false;

            }

            public virtual DataTable Load()
            {
                DataTable _Curve = new DataTable();

                return _Curve;
            }

            public virtual DataTable Load(String id)
            {
                DataTable _Curve = new DataTable();

                return _Curve;
            }

            public virtual DataTable LoadValue(String id, DateTime dateFrom, DateTime dateTo)
            {
                DataTable _CurveValue = new DataTable();

                return _CurveValue;
            }

            public virtual DataTable LoadValue(String id, DateTime date)
            {
                DataTable _CurveValue = new DataTable();

                return _CurveValue;
            }

            public virtual DataTable ValidYield(DateTime date)
            {
                DataTable _ValidYield = new DataTable();

                return _ValidYield;
            }

            public virtual DataTable YieldConfig()
            {
                DataTable _ValidYield = new DataTable();

                return _ValidYield;
            }

        }

        private class SourceSystem : Source
        {

            public override bool ValidDate(DateTime date)
            {

                string _QueryCurveValue = "SELECT FechaGeneracion, CodigoCurva, Dias, ValorBid, " +
                                          " ValorAsk, Tipo, Origen FROM dbo WHERE FechaGeneracion = '" + date.ToString("yyyyMMdd") + "'" +
                                          " AND Tipo in ( '', 'CERO' )";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _CurveValue;
                bool _Status = false;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryCurveValue);
                    _CurveValue = _Connect.QueryDataTable();
                    _CurveValue.TableName = "CurveValue";

                    if (!_CurveValue.Rows.Count.Equals(0))
                    {
                        _Status = false;
                    }
                    else
                    {
                        _Status = true;
                    }

                }
                catch (Exception _Error)
                {
                    _Status = false;
                    _CurveValue = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _Status;
            }

            public override DataTable Load()
            {
                String _QueryCurve = "SELECT 'Codigo' = CodigoCurva, 'Descripcion' = Descripcion, 'Tipo' = TipoCurva FROM dbo.definicion_curvas";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Curve;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryCurve);
                    _Curve = _Connect.QueryDataTable();
                    _Curve.TableName = "Curve";

                    if (_Curve.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _Curve = null;
                    Status = enumStatus.ErrorLoad;
                    Stack = _Error.StackTrace;
                    Error = _Error.Message;
                }

                return _Curve;
            }

            public override DataTable Load(String id)
            {
                String _QueryCurve = "SELECT CodigoCurva, Descripcion, TipoCurva FROM dbo.definicion_curvas WHERE CodigoCurva = '" + id + "'";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Curve;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryCurve);
                    _Curve = _Connect.QueryDataTable();
                    _Curve.TableName = "Curve";

                    if (_Curve.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _Curve = null;
                    Status = enumStatus.ErrorLoad;
                    Stack = _Error.StackTrace;
                    Error = _Error.Message;
                }

                return _Curve;
            }

            public override DataTable LoadValue(String id, DateTime dateFrom, DateTime dateTo)
            {
                String _QueryCurveValue = "SELECT FechaGeneracion, CodigoCurva, Dias, ValorBid, " +
                                          " ValorAsk, Tipo, Origen FROM dbo.curvas WHERE CodigoCurva = '" + id + "' AND " +
                                          " FechaGeneracion BETWEEN '" + dateFrom.ToString("yyyyMMdd") + "' AND '" +
                                          dateTo.ToString("yyyyMMdd") + "' AND Tipo in ( '', 'CERO' )";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _CurveValue;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryCurveValue);
                    _CurveValue = _Connect.QueryDataTable();
                    _CurveValue.TableName = "CurveValue";

                    if (_CurveValue.Rows.Count == 0)
                    {
                        Status = enumStatus.NotFoundValue;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _CurveValue = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _CurveValue;
            }

            public override DataTable LoadValue(String id, DateTime date)
            {
                string _QueryCurveValue = "";

                _QueryCurveValue += "SET NOCOUNT ON\n\n";

                _QueryCurveValue += "DECLARE @Date        DATETIME\n";
                _QueryCurveValue += "DECLARE @DateCurva   DATETIME\n";
                _QueryCurveValue += "DECLARE @YieldName   VARCHAR(20)\n\n";

                _QueryCurveValue += "SET @YieldName = '{0}'\n";
                _QueryCurveValue += "SET @Date      = '{1}'\n\n";

                _QueryCurveValue += "SELECT @DateCurva = MAX(FechaGeneracion)\n";
                _QueryCurveValue += "  FROM dbo.Curvas\n";
                _QueryCurveValue += " WHERE CodigoCurva     = @YieldName\n\n";

                _QueryCurveValue += "IF @DateCurva > @Date\n";
                _QueryCurveValue += "BEGIN\n";
                _QueryCurveValue += "    SET @DateCurva = @Date\n\n";

                _QueryCurveValue += "END\n\n";

                _QueryCurveValue += "SELECT 'FechaGeneracion'  = @Date\n";
                _QueryCurveValue += "     , 'CodigoCurva'      = CodigoCurva\n";
                _QueryCurveValue += "     , 'Dias'             = Dias\n";
                _QueryCurveValue += "     , 'ValorBid'         = ValorBid\n";
                _QueryCurveValue += "     , 'ValorAsk'         = ValorAsk\n";
                _QueryCurveValue += "     , 'Tipo'             = Tipo\n";
                _QueryCurveValue += "     , 'Origen'           = Origen\n";
                _QueryCurveValue += "  FROM dbo.curvas\n";
                _QueryCurveValue += " WHERE CodigoCurva        = @YieldName\n";
                _QueryCurveValue += "   AND FechaGeneracion    = @DateCurva\n\n";
                _QueryCurveValue += "   AND Tipo            in ( '', 'CERO' )\n";

                _QueryCurveValue += "SET NOCOUNT OFF\n";

                _QueryCurveValue = string.Format(_QueryCurveValue, id, date.ToString("yyyyMMdd"));

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _CurveValue;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryCurveValue);
                    _CurveValue = _Connect.QueryDataTable();
                    _CurveValue.TableName = "CurveValue";

                    if (_CurveValue.Rows.Count == 0)
                    {
                        Status = enumStatus.NotFoundValue;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _CurveValue = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _CurveValue;
            }

            public override DataTable ValidYield(DateTime date)
            {

                string _QueryValidYield = "";

                _QueryValidYield += "SELECT 'Registros' = COUNT(*)\n";
                _QueryValidYield += "  FROM BacParamSuda.dbo.curvas\n";
                _QueryValidYield += " WHERE FechaGeneracion = '" + date .ToString("yyyyMMdd") + "'\n";
                _QueryValidYield += "   AND Tipo in ( '', 'CERO' )\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _YieldValid;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryValidYield);
                    _YieldValid = _Connect.QueryDataTable();
                    _YieldValid.TableName = "ValidYield";

                    if (_YieldValid.Rows.Count == 0)
                    {
                        Status = enumStatus.NotFoundValue;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _YieldValid = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _YieldValid;
            }

            public override DataTable YieldConfig()
            {

                string _QueryValidYield = "";

                _QueryValidYield += "SELECT 'RateID'                       = TYC.rateID\n";
                _QueryValidYield += "     , 'Rate'                         = TR.systemoriginal\n";
                _QueryValidYield += "     , 'DescriptionRate'              = TR.description\n";
                _QueryValidYield += "     , 'CurrencyPrimaryID'            = TYC.currencyprimaryid\n";
                _QueryValidYield += "     , 'CurrencyPrimary'              = TCP.systemoriginal\n";
                _QueryValidYield += "     , 'CurrencyPrimaryDescription'   = TCP.description\n";
                _QueryValidYield += "     , 'CurrencySecondaryID'          = TYC.currencysecondaryid\n";
                _QueryValidYield += "     , 'CurrencySecondary'            = TCS.systemoriginal\n";
                _QueryValidYield += "     , 'CurrencySecondaryDescription' = TCS.description\n";
                _QueryValidYield += "     , 'YieldNameProjected'           = TYC.yieldnameprojected\n";
                _QueryValidYield += "     , 'YieldNameDiscount'            = TYC.yieldnamediscount\n";
                _QueryValidYield += "     , 'TermBenchMark'                = TYC.termbenchmark\n";
                _QueryValidYield += "  FROM dbo.tblYieldConfig         TYC\n";
                _QueryValidYield += "       INNER JOIN dbo.tblRate     TR  ON  TYC.rateID              = TR.ID\n";
                _QueryValidYield += "       INNER JOIN dbo.tblCurrency TCP ON  TYC.currencyprimaryid   = TCP.ID\n";
                _QueryValidYield += "       INNER JOIN dbo.tblCurrency TCS ON  TYC.currencysecondaryid = TCS.ID\n";
                _QueryValidYield += " WHERE system = 3\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");
                DataTable _YieldValid;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryValidYield);
                    _YieldValid = _Connect.QueryDataTable();
                    _YieldValid.TableName = "ValidYield";

                    if (_YieldValid.Rows.Count == 0)
                    {
                        Status = enumStatus.NotFoundValue;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _YieldValid = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _YieldValid;
            }

        }

        private class SourceBloomberg : Source
        {
        }

        private class SourceExcel : Source
        {
        }

    }

}
