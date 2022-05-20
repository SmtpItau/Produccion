using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace cData.Currency
{

    public class Currency
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public Currency()
        {
            Set(enumSource.System);
        }

        public Currency(enumSource id)
        {
            Set(id);
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
                    _Message = "La Moneda se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error al carga los valores para la fecha solicitada.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error al cargar la definición de la curva.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la Moneda.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Se fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "La Moneda se esta cargando.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la Moneda.";
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

        public DataTable Load(int id)
        {
            DataTable _Currency = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Currency = _System.Load(id);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.CurrencyValueAccount:
                    SourceAccount _Account = new SourceAccount();

                    _Currency = _Account.Load(id);
                    mStatus = _Account.Status;
                    mError = _Account.Error;
                    mStack = _Account.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Currency = _Bloomberg.Load(id);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Currency = _Excel.Load(id);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Currency;

        }

        public DataTable LoadValue(int id, DateTime date)
        {

            DataTable _Value = new DataTable();

            _Value = LoadValue(id, date, date);

            return _Value;

        }

        public DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo)
        {

            DataTable _Value = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Value = _System.LoadValue(id, dateFrom, dateTo);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.CurrencyValueAccount:
                    SourceAccount _Account = new SourceAccount();

                    _Value = _Account.LoadValue(id, dateFrom, dateTo);
                    mStatus = _Account.Status;
                    mError = _Account.Error;
                    mStack = _Account.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Value = _Bloomberg.LoadValue(id, dateFrom, dateTo);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Value = _Excel.LoadValue(id, dateFrom, dateTo);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;


                    break;

                default:
                    break;
            }

            return _Value;

        }

        public DataTable ValidCurrency(DateTime date)
        {

            DataTable _ValidCurrency = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _ValidCurrency = _System.ValidCurrency(date);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.CurrencyValueAccount:
                    SourceAccount _Account = new SourceAccount();

                    _ValidCurrency = _Account.ValidCurrency(date);
                    mStatus = _Account.Status;
                    mError = _Account.Error;
                    mStack = _Account.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _ValidCurrency = _Bloomberg.ValidCurrency(date);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _ValidCurrency = _Excel.ValidCurrency(date);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _ValidCurrency;

        }

        protected void Set(enumSource id)
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

            public virtual DataTable Load(int id)
            {
                DataTable _Currency = new DataTable();

                return _Currency;
            }

            public virtual DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo)
            {
                DataTable _Value = new DataTable();

                return _Value;

            }

            public virtual DataTable ValidCurrency(DateTime date)
            {
                DataTable _ValidCurrency = new DataTable();

                return _ValidCurrency;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load(int id)
            {
                String _QueryRate = "SELECT 'Codigo'                = mncodmon," +
                                    "       'Descripcion'           = mnglosa, " +
                                    "       'Nemotecnico'           = mnnemo, " +
                                    "       'RelacionRespectoDolar' = mnrrda, " +
                                    "       'Base'                  = mnbase, " +
                                    "       'Decimales'             = mndecimal " +
                                    "  FROM dbo.moneda " +
                                    "  WHERE mncodmon                = " + id.ToString() +
                                    "  ORDER BY mncodmon";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Currency;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _Currency = _Connect.QueryDataTable();
                    _Currency.TableName = "Currency";

                    if (_Currency.Rows.Count.Equals(0))
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
                    _Currency = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Currency;
            }

            public override DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo)
            {
                String _QueryRateValue = "SELECT 'Date'  = vmfecha," +
                                         "       'Value' = vmvalor" +
                                         "  FROM dbo.VALOR_MONEDA " +
                                         " WHERE vmcodigo = " + id.ToString() +
                                         "   AND vmfecha  BETWEEN '" + dateFrom.ToString("yyyyMMdd") + "' AND '" + dateTo.ToString("yyyyMMdd") + "'" +
                                         " ORDER BY vmfecha, vmcodigo";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Value;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRateValue);
                    _Value = _Connect.QueryDataTable();
                    _Value.TableName = "CurrencyValue";

                    if (_Value.Rows.Count == 0)
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
                    _Value = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _Value;
            }

            public override DataTable ValidCurrency(DateTime date)
            {

                string _QueryValidCurrency = "";

                _QueryValidCurrency += "SELECT 'Registros' = COUNT( vmfecha )\n";
                _QueryValidCurrency += "  FROM dbo.VALOR_MONEDA\n";
                _QueryValidCurrency += " WHERE vmfecha     = '" + date.ToString("yyyyMMdd") + "'\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _CurrencyValid;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryValidCurrency);
                    _CurrencyValid = _Connect.QueryDataTable();
                    _CurrencyValid.TableName = "CurrencyValid";

                    if (_CurrencyValid.Rows.Count == 0)
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
                    _CurrencyValid = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _CurrencyValid;

            }

        }

        private class SourceAccount : Source
        {

            public override DataTable Load(int id)
            {
                String _QueryRate = "SELECT 'Codigo'                = mncodmon," +
                                    "       'Descripcion'           = mnglosa, " +
                                    "       'Nemotecnico'           = mnnemo, " +
                                    "       'RelacionRespectoDolar' = mnrrda, " +
                                    "       'Base'                  = mnbase, " +
                                    "       'Decimales'             = mndecimal " +
                                    "  FROM dbo.moneda " +
                                    "  WHERE mncodmon                = " + id.ToString();
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Currency;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _Currency = _Connect.QueryDataTable();
                    _Currency.TableName = "Currency";

                    if (_Currency.Rows.Count.Equals(0))
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
                    _Currency = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Currency;
            }

            public override DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo)
            {
                String _QueryRateValue = "SELECT 'Date'   = Fecha," +
                                         "       'Value'  = Tipo_Cambio" +
                                         "  FROM dbo.VALOR_MONEDA_CONTABLE " +
                                         " WHERE Codigo_Moneda = " + id.ToString() +
                                         "   AND Fecha         BETWEEN '" + dateFrom.ToString("yyyyMMdd") + "' AND '" + dateTo.ToString("yyyyMMdd") + "'";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Value;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRateValue);
                    _Value = _Connect.QueryDataTable();
                    _Value.TableName = "RateValue";

                    if (_Value.Rows.Count == 0)
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
                    _Value = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _Value;
            }

            public override DataTable ValidCurrency(DateTime date)
            {

                string _QueryValidCurrency = "";

                _QueryValidCurrency += "SELECT 'Registros' = COUNT( Fecha )\n";
                _QueryValidCurrency += "  FROM dbo.VALOR_MONEDA_CONTABLE\n";
                _QueryValidCurrency += " WHERE Fecha       = '" + date.ToString("yyyyMMdd") + "'\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _CurrencyValid;

                try
                {
                    // 
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryValidCurrency);
                    _CurrencyValid = _Connect.QueryDataTable();
                    _CurrencyValid.TableName = "CurrencyValid";

                    if (_CurrencyValid.Rows.Count == 0)
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
                    _CurrencyValid = null;
                    Error = _Error.Message;
                    Stack = _Error.StackTrace;
                    Status = enumStatus.ErrorLoadValue;
                }

                return _CurrencyValid;

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
