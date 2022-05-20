using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Parameters
{

    public class PublicationIPC
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public PublicationIPC()
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
                    _Message = "Se encuentran cargodos los tipos de SWAP.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error de la carga de los tipos de SWAP.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error de la carga de los tipos de SWAP.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error de la carga de los tipos de SWAP.";
                    break;
                case enumStatus.Initialize:
                    _Message = "La clase se encuentra en estado inicializada.";
                    break;
                case enumStatus.Loaded:
                    _Message = "Se esta cargando.";
                    break;
                case enumStatus.Loading:
                    _Message = "Se cargo correctamente los tipos de SWAP.";
                    break;
                case enumStatus.NotFound:
                    _Message = "No se encontro el tipo de SWAP solicitado.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro el tipo de SWAP solicitado.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataTable Load(DateTime dateIPC)
        {
            DataTable _DateIPC = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _DateIPC = _System.Load(dateIPC);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _DateIPC = _Bloomberg.Load(dateIPC);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _DateIPC = _Excel.Load(dateIPC);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _DateIPC;

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

            public virtual DataTable Load(DateTime dateIPC)
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load(DateTime dateIPC)
            {
                String _QueryRate = "";

                _QueryRate += "SET NOCOUNT ON\n\n";

                _QueryRate += "SELECT 'ValueDate'              = ValueDate\n";
                _QueryRate += "     , 'PublicationDate'        = PublicationDate\n";
                _QueryRate += "     , 'PublicationEntrySystem' = PublicationEntrySystem\n";
                _QueryRate += "  FROM dbo.PublicationICP\n";
                _QueryRate += " WHERE ValueDate = '" + dateIPC.ToString("yyyyMMdd") + "'\n\n";

                _QueryRate += "SET NOCOUNT OFF\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _DateIPC;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _DateIPC = _Connect.QueryDataTable();
                    _DateIPC.TableName = "DateIPC";

                    if (_DateIPC.Rows.Count.Equals(0))
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
                    _DateIPC = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _DateIPC;
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

