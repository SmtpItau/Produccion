using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Rate
{

    public class Rate
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public Rate()
        {
            mStatus = enumStatus.Initialize;
            mSource = enumSource.System;
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
                    _Message = "La Tasa se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error al carga los valores para la fecha solicitada.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error al cargar la definición de la curva.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la tasa.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Se fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "La tasa se esta cargando.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la tasa.";
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
            DataTable _Rate = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Rate = _System.Load(id);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Rate = _Bloomberg.Load(id);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Rate = _Excel.Load(id);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Rate;

        }

        public DataTable LoadValue(int id, DateTime date, int currencyID, enumPeriod periodID)
        {

            DataTable _Value = new DataTable();

            _Value = LoadValue(id, date, date, currencyID, periodID);

            return _Value;

        }

        public DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo, int currencyID, enumPeriod periodID)
        {

            DataTable _Value = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Value = _System.LoadValue(id, dateFrom, dateTo, currencyID, periodID);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Value = _Bloomberg.LoadValue(id, dateFrom, dateTo, currencyID, periodID);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Value = _Excel.LoadValue(id, dateFrom, dateTo, currencyID, periodID);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;


                    break;

                default:
                    break;
            }

            return _Value;

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
                mStatus = enumStatus.Initialize;
                mError = "";
                mStack = "";
            }

            public virtual DataTable Load(int id)
            {
                DataTable _Rate = new DataTable();

                return _Rate;
            }

            public virtual DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo, int currencyID, enumPeriod periodID)
            {
                DataTable _Value = new DataTable();

                return _Value;

            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load(int id)
            {
                String _QueryRate = "SELECT 'Codigo' = CAST( tbcodigo1 as int ), 'Descripcion' = tbglosa " +
                                    "FROM dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 AND CAST( tbcodigo1 as int ) =  " + id.ToString();
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Rate;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _Rate = _Connect.QueryDataTable();
                    _Rate.TableName = "Rate";

                    if (_Rate.Rows.Count.Equals(0))
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
                    _Rate = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Rate;
            }

            public override DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo, int currencyID, enumPeriod periodID)
            {
                int _PeriodID = (int)periodID;
                String _QueryRateValue = "SELECT 'Date' = fecha, 'Value' = tasa FROM dbo.MONEDA_TASA WHERE CodTasa = " + id.ToString() + " AND " +
                                         "Fecha BETWEEN '" + dateFrom.ToString("yyyyMMdd") + "' AND '" + dateTo.ToString("yyyyMMdd") +
                                         "' AND codmon = " + currencyID.ToString() +
                                         " AND periodo = " + _PeriodID.ToString();
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Value;

                try
                {
                    // 
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

        }

        private class SourceBloomberg : Source
        {

            public override DataTable Load(int id)
            {
                DataTable _Rate = new DataTable();

                return _Rate;
            }

            public override DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo, int currencyID, enumPeriod periodID)
            {
                DataTable _Value = new DataTable();

                return _Value;

            }

        }

        private class SourceExcel : Source
        {

            public override DataTable Load(int id)
            {
                DataTable _Rate = new DataTable();

                return _Rate;
            }

            public override DataTable LoadValue(int id, DateTime dateFrom, DateTime dateTo, int currencyID, enumPeriod periodID)
            {
                DataTable _Value = new DataTable();

                return _Value;

            }

        }

    }

}
