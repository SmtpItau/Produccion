using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Rate
{

    public class BenchMarck
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public BenchMarck()
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

        public DataTable LoadValue(DateTime date)
        {

            DataTable _Value = new DataTable();

            _Value = LoadValue(date, date);

            return _Value;

        }

        public DataTable LoadValue(DateTime dateFrom, DateTime dateUntil)
        {

            DataTable _Value = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Value = _System.LoadValue(dateFrom, dateUntil);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Value = _Bloomberg.LoadValue(dateFrom, dateUntil);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Value = _Excel.LoadValue(dateFrom, dateUntil);
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

            public virtual DataTable LoadValue(DateTime dateFrom, DateTime dateUntil)
            {
                DataTable _Value = new DataTable();

                return _Value;

            }

        }

        private class SourceSystem : Source
        {

            public override DataTable LoadValue(DateTime dateFrom, DateTime dateUntil)
            {

                String _QueryBenchMarck = "";

                _QueryBenchMarck += "SELECT 'Date'          = fecha\n";
                _QueryBenchMarck += "     , 'MnemonicsCode' = Instrumento\n";
                _QueryBenchMarck += "     , 'Currency'      = Moneda\n";
                _QueryBenchMarck += "     , 'TermFrom'      = Desde\n";
                _QueryBenchMarck += "     , 'TermUntil'     = Hasta\n";
                _QueryBenchMarck += "     , 'Rate'          = Tasa\n";
                _QueryBenchMarck += "  FROM dbo.BENCH_MARCK\n";
                _QueryBenchMarck += " WHERE Fecha BETWEEN '" + dateFrom.ToString("yyyyMMdd") + "' AND '" + dateUntil.ToString("yyyyMMdd") + "'\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACFWDSUDA");
                DataTable _Value;

                try
                {
                    // 
                    Status = enumStatus.Loading;    
                    _Connect.Execute(_QueryBenchMarck);
                    _Value = _Connect.QueryDataTable();
                    _Value.TableName = "RateBenchMarck";

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
        }

        private class SourceExcel : Source
        {
        }


    }

}
