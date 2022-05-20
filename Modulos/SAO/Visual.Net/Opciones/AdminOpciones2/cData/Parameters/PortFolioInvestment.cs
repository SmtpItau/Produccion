using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Parameters
{

    public class PortFolioInvestment
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public PortFolioInvestment()
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
                    _Message = "Se encuentra cargodas las cartera de inversión de los SWAP.";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "Error de la carga de las cartera de inversión de los SWAP.";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "Error de la carga de las cartera de inversión de los SWAP.";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "Error de la carga de las cartera de inversión de los SWAPP.";
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
                    _Message = "No se encontro las cartera de inversión de los SWAP solicitado.";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "No se encontro las cartera de inversión de los SWAP solicitado.";
                    break;
                default:
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataTable Load(int id)
        {
            DataTable _SwapType = new DataTable();
            String _ID;

            switch (id)
            {
                case 1:
                    _ID = "ST";
                    break;
                case 2:
                    _ID = "SM";
                    break;
                case 4:
                    _ID = "SP";
                    break;
                default:
                    _ID = "NN";
                    break;
            }


            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _SwapType = _System.Load(_ID);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SwapType = _Bloomberg.Load(_ID);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SwapType = _Excel.Load(_ID);
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

            public virtual DataTable Load(String id)
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load(String id)
            {
                String _QueryRate = "SELECT 'Codigo' = rcrut, 'Glosa' = rcnombre FROM BacParamSuda..TIPO_CARTERA " +
                                    "WHERE rcsistema = 'PCS' AND rccodpro = '" + id + "'";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _SwapType;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _SwapType = _Connect.QueryDataTable();
                    _SwapType.TableName = "PortFolioInvestment";

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

            public override DataTable Load(String id)
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

        private class SourceExcel : Source
        {

            public override DataTable Load(String id)
            {
                DataTable _SwapType = new DataTable();

                return _SwapType;
            }

        }

    }

}
