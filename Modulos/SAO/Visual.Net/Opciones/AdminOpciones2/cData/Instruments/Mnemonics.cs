using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.Instruments
{
    public class Mnemonics
    {

        #region "Atributos Privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public Mnemonics()
        {
            Set(enumSource.System);
        }

        public Mnemonics(enumSource id)
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
                    _Message = "La Serie se encuentra cargada.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error en al carga de la Serie.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error en al cargar de la serie.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error en la cargar de la Serie.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Ya fue cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "La Serie se esta cargando.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro la Serie.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro la Serie.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataTable Load(String mnemonicsID)
        {
            DataTable _Mnemonics = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _Mnemonics = _System.Load(mnemonicsID);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Mnemonics = _Bloomberg.Load(mnemonicsID);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Mnemonics = _Excel.Load(mnemonicsID);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _Mnemonics = _XML.Load(mnemonicsID);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _Mnemonics;

        }

        public DataTable Load(int operationNumber, int ID)
        {
            DataTable _Mnemonics = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _Mnemonics = _System.Load(operationNumber, ID);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Mnemonics = _Bloomberg.Load(operationNumber, ID);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Mnemonics = _Excel.Load(operationNumber, ID);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _Mnemonics = _XML.Load(operationNumber, ID);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _Mnemonics;

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
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

            public virtual DataTable Load(int operationNumber, int ID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                String _QueryRate = "SELECT 'Codigo'                  = S.secodigo " +
                                    "     , 'Familia'                 = I.inserie " +
                                    "     , 'Mascara'                 = S.semascara " +
                                    "     , 'Instrumento'             = S.seserie " +
                                    "     , 'RutEmisor'               = S.serutemi " +
                                    "     , 'FechaEmision'            = S.sefecemi " +
                                    "     , 'FechaVencimiento'        = S.sefecven " +
                                    "     , 'TasaEmision'             = S.setasemi " +
                                    "     , 'TERA'                    = S.setera " +
                                    "     , 'BaseEmision'             = S.sebasemi " +
                                    "     , 'MonedaEmision'           = S.semonemi " +
                                    "     , 'NumeroCupones'           = S.secupones " +
                                    "     , 'DiasVencimientoCupon'    = S.sediavcup " +
                                    "     , 'PeriodoVencimientoCupon' = S.sepervcup " +
                                    "     , 'TipoVencimientoCupon'    = S.setipvcup " +
                                    "     , 'Plazo'                   = S.seplazo " +
                                    "     , 'TipoAmortizacion'        = S.setipamort " +
                                    "     , 'NumeroAmortizaciones'    = S.senumamort " +
                                    "     , 'Decimales'               = S.sedecs " +
                                    "     , 'Seriado'                 = I.inmdse " +
                                    "     , 'TasaEstimada'            = I.intasest" +
                                    "  FROM dbo.Serie       S, " +
                                    "       dbo.Instrumento I " +
                                    " WHERE S.semascara               = '" + mnemonicsID + "'" +
                                    "   AND S.secodigo                = I.incodigo";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Mnemonics;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _Mnemonics = _Connect.QueryDataTable();
                    _Mnemonics.TableName = "Mnemonics";

                    if (_Mnemonics.Rows.Count.Equals(0))
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
                    _Mnemonics = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Mnemonics;
            }

            public override DataTable Load(int operationNumber, int ID)
            {
                String _QueryRate = "SELECT 'Codigo'                  = N.nscodigo " +
                                    "     , 'Familia'                 = I.inserie " +
                                    "     , 'Mascara'                 = N.nsserie " +
                                    "     , 'Instrumento'             = N.nsserie " +
                                    "     , 'RutEmisor'               = N.nsrutemi " +
                                    "     , 'FechaEmision'            = N.nsfecemi " +
                                    "     , 'FechaVencimiento'        = N.nsfecven " +
                                    "     , 'TasaEmision'             = N.nstasemi " +
                                    "     , 'TERA'                    = N.nstasemi " +
                                    "     , 'BaseEmision'             = N.nsbasemi " +
                                    "     , 'MonedaEmision'           = N.nsmonemi " +
                                    "     , 'NumeroCupones'           = 1 " +
                                    "     , 'DiasVencimientoCupon'    = 0 " +
                                    "     , 'PeriodoVencimientoCupon' = 0 " +
                                    "     , 'TipoVencimientoCupon'    = 'M' " +
                                    "     , 'Plazo'                   = DATEDIFF( DAY, N.nsfecemi, N.nsfecven ) " +
                                    "     , 'TipoAmortizacion'        = ' ' " +
                                    "     , 'NumeroAmortizaciones'    = 1 " +
                                    "     , 'Decimales'               = 0 " +
                                    "     , 'Seriado'                 = 'N' " +
                                    "     , 'TasaEstimada'            = 0 " +
                                    "  FROM dbo.NoSerie       N, " +
                                    "       dbo.Instrumento   I " +
                                    " WHERE N.nsnumdocu               = " + operationNumber.ToString() +
                                    "   AND N.nscorrela               = " + ID.ToString() +
                                    "   AND N.nscodigo                = I.incodigo";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Mnemonics;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _Mnemonics = _Connect.QueryDataTable();
                    _Mnemonics.TableName = "Mnemonics";

                    if (_Mnemonics.Rows.Count.Equals(0))
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
                    _Mnemonics = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Mnemonics;
            }

        }

        #endregion

        #region "Datos que se obtinen del Bloomberg"

        private class SourceBloomberg : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

            public override DataTable Load(int operationNumber, int ID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

        }

        #endregion

        #region "Datos que se obtinen de Excel"

        private class SourceExcel : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

            public override DataTable Load(int operationNumber, int ID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

        }

        #endregion

        #region "Datos que se obtinen de XML"

        private class SourceXML : Source
        {

            public override DataTable Load(String mnemonicsID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

            public override DataTable Load(int operationNumber, int ID)
            {
                DataTable _Mnemonics = new DataTable();

                return _Mnemonics;
            }

        }

        #endregion

        #endregion

    }
}
