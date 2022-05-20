using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Parameters
{

    public class SwapType
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public SwapType()
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

        public DataTable Load()
        {
            DataTable _SwapType = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _SwapType = _System.Load();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SwapType = _Bloomberg.Load();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SwapType = _Excel.Load();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _SwapType;

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

            public virtual DataTable Load()
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load()
            {
                String _QueryRate = "SELECT 'Codigo' = tbcodigo1, 'Glosa' = tbglosa FROM TABLA_GENERAL_DETALLE WHERE tbcateg = 1050 AND tbcodigo1 <> 3 " +
                                    "ORDER BY tbcodigo1";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _SwapType;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _SwapType = _Connect.QueryDataTable();
                    _SwapType.TableName = "SwapType";

                    if (_SwapType.Rows.Count.Equals(0))
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
                    _SwapType = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SwapType;
            }

        }

        private class SourceBloomberg : Source
        {

            public override DataTable Load()
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

        private class SourceExcel : Source
        {

            public override DataTable Load()
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

    }

}
