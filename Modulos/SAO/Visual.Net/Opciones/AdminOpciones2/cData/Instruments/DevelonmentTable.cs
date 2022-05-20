using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.Instruments
{
    public class DevelonmentTable
    {

        #region "Atributos Privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public DevelonmentTable()
        {
            Set(enumSource.System);
        }

        public DevelonmentTable(enumSource id)
        {
            Set(id);
        }

        #endregion

        #region "Atributos Publicos"

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

        #endregion

        #region "Metodos Publicos"

        public String ReadMessage(enumStatus status)
        {
            String _Message;

            switch (status)
            {
                case enumStatus.Already:
                    _Message = "La Tabla Desarrollo se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error en al carga de la Tabla Desarrollo.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error en al cargar de la Tabla Desarrollo.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la Tabla Desarrollo.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Ya fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "La Tabla Desarrollo se esta cargando.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la Tabla Desarrollo.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro la Tabla Desarrollo.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataTable Load(String mnemonicsID)
        {
            DataTable _DevelonmentTable = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _DevelonmentTable = _System.Load(mnemonicsID);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _DevelonmentTable = _Bloomberg.Load(mnemonicsID);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _DevelonmentTable = _Excel.Load(mnemonicsID);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _DevelonmentTable = _XML.Load(mnemonicsID);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _DevelonmentTable;

        }

        #endregion

        #region "Metodos Privados"

        protected void Set(enumSource id)
        {
            mStatus = enumStatus.Initialize;
            mSource = id;
        }

        #endregion

        #region "Clases para obtener la información"

        #region "Clase Source"

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

            public virtual DataTable Load(String mnemonicsID)
            {
                DataTable _DevelonmentTable = new DataTable();

                return _DevelonmentTable;
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                String _QueryRate = "SELECT 'Mascara'          = tdmascara " +
                                    "     , 'NumeroCupon'      = tdcupon " +
                                    "     , 'FechaVencimiento' = tdfecven " +
                                    "     , 'Interes'          = tdinteres " +
                                    "     , 'Amortizacion'     = tdamort " +
                                    "     , 'Flujo'            = tdflujo " +
                                    "     , 'SaldoResidual'    = tdsaldo " +
                                    "  FROM dbo.Tabla_Desarrollo " +
                                    " WHERE tdmascara          = '" + mnemonicsID + "'";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _DevelonmentTable;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _DevelonmentTable = _Connect.QueryDataTable();
                    _DevelonmentTable.TableName = "DevelonmentTable";

                    if (_DevelonmentTable.Rows.Count.Equals(0))
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
                    _DevelonmentTable = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _DevelonmentTable;
            }

        }

        #endregion

        #region "Datos que se obtinen del Bloomberg"

        private class SourceBloomberg : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                DataTable _DevelonmentTable = new DataTable();

                return _DevelonmentTable;
            }

        }

        #endregion

        #region "Datos que se obtinen de Excel"

        private class SourceExcel : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                DataTable _DevelonmentTable = new DataTable();

                return _DevelonmentTable;
            }

        }

        #endregion

        #region "Datos que se obtinen de XML"

        private class SourceXML : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                DataTable _DevelonmentTable = new DataTable();

                return _DevelonmentTable;
            }

        }

        #endregion

        #endregion

    }
}
