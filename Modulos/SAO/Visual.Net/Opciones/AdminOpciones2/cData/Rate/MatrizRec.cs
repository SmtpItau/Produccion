using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace cData.Rate
{
    public class MatrizRec
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public MatrizRec()
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
            String _Message = "Error";

            switch (status)
            {
                case enumStatus.Already:
                    break;
                case enumStatus.ErrorLoadValue:
                    break;
                case enumStatus.ErrorLoad:
                    break;
                case enumStatus.ErrorLoaded:
                    break;
                case enumStatus.Initialize:
                    break;
                case enumStatus.Loaded:
                    break;
                case enumStatus.Loading:
                    break;
                case enumStatus.NotFound:
                    break;
                case enumStatus.NotFoundValue:
                    break;
                default:
                    break;
            }
            return _Message;
        }

        public DataTable Load(string TipoBidAsk)
        {
            DataTable _Rate = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Rate = _System.Load(TipoBidAsk);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Rate = _Bloomberg.Load();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Rate = _Excel.Load();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Rate;

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
                DataTable _Rate = new DataTable();

                return _Rate;
            }

        }

        private class SourceSystem : Source
        {
            //public override DataTable Load()
            public DataTable Load(string TipoBidAsk)
            {
                String _Query = "";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _DT;

                try
                {
                    _Query += "SET NOCOUNT ON\n";
                    _Query += "SELECT 'Moneda1' = P.LCRParMda1\n";
                    _Query += "     , 'Moneda2' = P.LCRParMda2\n";
                    _Query += "     , 'Plazo'   = ROUND( F.lcrpla * 365.0, 0 )\n";
                    _Query += "     , 'Factor'  = F.lcrpon\n";
                    _Query += "  FROM BACLINEAS.dbo.lcrparmdagrumda P\n";
                    _Query += "     , BACLINEAS.dbo.LCRRieParMdaPon F\n";
                    _Query += " WHERE F.lcrgrumdacod   = P.LCRGruMdaCod\n";
                    _Query += "   AND F.codigo_riesgo  = 2\n";
                    _Query += "   AND P.LCRParMda1     = 13\n";
                    _Query += "   AND P.LCRParMda2     = 999\n";
                    _Query += "   AND F.lcrTipoBID_ASK = '" + TipoBidAsk +"'\n";
                    _Query += " ORDER BY\n";
                    _Query += "       F.codigo_riesgo\n";
                    _Query += "     , F.lcrgrumdacod\n";
                    _Query += "     , F.lcrpla\n";
                    _Query += "SET NOCOUNT OFF\n";

                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_Query);
                    _DT = _Connect.QueryDataTable();
                    _DT.TableName = "MatrizRec"; //VER tipos de datos del DT

                    if (_DT.Rows.Count.Equals(0))
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
                    _DT = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _DT;
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
