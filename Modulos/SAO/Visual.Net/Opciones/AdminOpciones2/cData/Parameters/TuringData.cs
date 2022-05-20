using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Parameters
{

    public class TuringData
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public TuringData()
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
                    _Message = "";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "";
                    break;
                case enumStatus.Initialize:
                    _Message = "";
                    break;
                case enumStatus.Loaded:
                    _Message = "";
                    break;
                case enumStatus.Loading:
                    _Message = "";
                    break;
                case enumStatus.NotFound:
                    _Message = "";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "";
                    break;
                default:
                    _Message = "";
                    break;
            }
            return _Message;
        }

        public DataSet Load()
        {

            DataSet _DataSet = new DataSet();

            _DataSet.Merge(LoadCustomer());
            _DataSet.Merge(LoadRate());
            _DataSet.Merge(LoadCurrency());
            _DataSet.Merge(LoadBook());
            _DataSet.Merge(LoadPortFolioRules());
            _DataSet.Merge(LoadFinancialPortFolio());

            return _DataSet;

        }

        //--- PRD-3162
        public DataSet Load(String User)
        {

            DataSet _DataSet = new DataSet();

            _DataSet.Merge(LoadCustomer());
            _DataSet.Merge(LoadRate());
            _DataSet.Merge(LoadCurrency());
            _DataSet.Merge(LoadBook(User));
            _DataSet.Merge(LoadPortFolioRules(User));
            _DataSet.Merge(LoadFinancialPortFolio(User));

            return _DataSet;

        }

        //--- PRD-3162


        public DataSet LoadBookAndPortfolio()
        {

            DataSet _DataSet = new DataSet();
                        
            _DataSet.Merge(LoadBook());
            _DataSet.Merge(LoadPortFolioRules());
            _DataSet.Merge(LoadFinancialPortFolio());
            _DataSet.Merge(LoadSubPortFolioRules());
            _DataSet.Merge(LoadConfiguracionPortFolio());
            _DataSet.Merge(LoadFinancialPortFolioPrioridad());

            return _DataSet;

        }

        //--- PRD-3162
        public DataSet LoadBookAndPortfolio(String User)
        {

            DataSet _DataSet = new DataSet();

            _DataSet.Merge(LoadBook(User));
            _DataSet.Merge(LoadPortFolioRules(User));
            _DataSet.Merge(LoadFinancialPortFolio(User));
            _DataSet.Merge(LoadSubPortFolioRules(User));
            _DataSet.Merge(LoadConfiguracionPortFolio(User));
            _DataSet.Merge(LoadFinancialPortFolioPrioridad(User));


            return _DataSet;

        }
        //--- PRD-3162


        private DataTable LoadCustomer()
        {
            DataTable _Customer = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Customer = _System.LoadCustomer();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Customer = _Bloomberg.LoadCustomer();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Customer = _Excel.LoadCustomer();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Customer;

        }

        private DataTable LoadRate()
        {
            DataTable _Rate = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Rate = _System.LoadRate();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Rate = _Bloomberg.LoadRate();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Rate = _Excel.LoadRate();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Rate;

        }

        private DataTable LoadCurrency()
        {
            DataTable _Currency = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Currency = _System.LoadCurrency();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Currency = _Bloomberg.LoadCurrency();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Currency = _Excel.LoadCurrency();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Currency;

        }

        private DataTable LoadBook()
        {
            DataTable _Book = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Book = _System.LoadBook();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Book = _Bloomberg.LoadBook();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Book = _Excel.LoadBook();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Book;

        }

        //--- PRD-3162

        private DataTable LoadBook(String Username)
        {
            DataTable _Book = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Book = _System.LoadBook(Username);  // PRD-3162
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Book = _Bloomberg.LoadBook();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Book = _Excel.LoadBook();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Book;

        }

        //--- PRD-3162


        private DataTable LoadPortFolioRules()
        {
            DataTable _PortFolioRules = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioRules = _System.LoadPortFolioRules();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioRules = _Bloomberg.LoadPortFolioRules();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioRules = _Excel.LoadPortFolioRules();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioRules;

        }

        //--- PRD-3162

        private DataTable LoadPortFolioRules(String Username)
        {
            DataTable _PortFolioRules = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioRules = _System.LoadPortFolioRules(Username); //Username
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioRules = _Bloomberg.LoadPortFolioRules();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioRules = _Excel.LoadPortFolioRules();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioRules;

        }

        //--- PRD-3162


        private DataTable LoadSubPortFolioRules()
        {
            DataTable _SubPortFolioRules = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _SubPortFolioRules = _System.LoadSubPortFolioRules();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SubPortFolioRules = _Bloomberg.LoadSubPortFolioRules();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SubPortFolioRules = _Excel.LoadSubPortFolioRules();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _SubPortFolioRules;

        }

        //--- PRD-3162
        private DataTable LoadSubPortFolioRules(String Username)
        {
            DataTable _SubPortFolioRules = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _SubPortFolioRules = _System.LoadSubPortFolioRules(Username);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SubPortFolioRules = _Bloomberg.LoadSubPortFolioRules();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SubPortFolioRules = _Excel.LoadSubPortFolioRules();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _SubPortFolioRules;

        }

        //--- PRD-3162


        private DataTable LoadFinancialPortFolio()
        {
            DataTable _FinancialPortFolio = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _FinancialPortFolio = _System.LoadFinancialPortFolio();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _FinancialPortFolio = _Bloomberg.LoadFinancialPortFolio();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _FinancialPortFolio = _Excel.LoadFinancialPortFolio();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _FinancialPortFolio;

        }

        //--- PRD-3162
        private DataTable LoadFinancialPortFolio(String Username) //PRD-3162
        {
            DataTable _FinancialPortFolio = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _FinancialPortFolio = _System.LoadFinancialPortFolio(Username);  // PRD-3162

                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _FinancialPortFolio = _Bloomberg.LoadFinancialPortFolio();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _FinancialPortFolio = _Excel.LoadFinancialPortFolio();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _FinancialPortFolio;

        }
        //--- PRD-3162

        // PRD-3162

        private DataTable LoadConfiguracionPortFolio() //PRD-3162
        {
            DataTable _ConfigPortFolio = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _ConfigPortFolio = _System.LoadConfiguracionPortFolio();

                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;


                default:
                    break;
            }

            return _ConfigPortFolio;

        }

        private DataTable LoadConfiguracionPortFolio(String Username) //PRD-3162
        {
            DataTable _ConfigPortFolio = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _ConfigPortFolio = _System.LoadConfiguracionPortFolio(Username);

                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;


                default:
                    break;
            }

            return _ConfigPortFolio;

        }


        private DataTable LoadFinancialPortFolioPrioridad() //PRD-3162
        {
            DataTable _FinancialPortFolioPrioridad = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _FinancialPortFolioPrioridad = _System.LoadFinancialPortFolioPrioridad();

                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;


                default:
                    break;
            }

            return _FinancialPortFolioPrioridad;

        }



        private DataTable LoadFinancialPortFolioPrioridad(String Username) //PRD-3162
        {
            DataTable _FinancialPortFolioPrioridad = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _FinancialPortFolioPrioridad = _System.LoadFinancialPortFolioPrioridad(Username);

                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;


                default:
                    break;
            }

            return _FinancialPortFolioPrioridad;

        }

       // PRD-3162









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

            public virtual DataTable LoadCustomer()
            {
                DataTable _Customer = new DataTable();

                return _Customer;
            }

            public virtual DataTable LoadRate()
            {
                DataTable _Rate = new DataTable();

                return _Rate;
            }

            public virtual DataTable LoadCurrency()
            {
                DataTable _Currency = new DataTable();

                return _Currency;
            }

            public virtual DataTable LoadBook()
            {
                DataTable _Book = new DataTable();

                return _Book;
            }

            //--- PRD-3162
            public virtual DataTable LoadBook(string usr)
            {
                DataTable _Book = new DataTable();

                return _Book;
            }
            //--- PRD-3162


            public virtual DataTable LoadPortFolioRules()
            {
                DataTable _PortFolioRules = new DataTable();

                return _PortFolioRules;
            }
            
            //--- PRD-3162
            public virtual DataTable LoadPortFolioRules(string usr)
            {
                DataTable _PortFolioRules = new DataTable();

                return _PortFolioRules;
            }
            //--- PRD-3162


            public virtual DataTable LoadSubPortFolioRules()
            {
                DataTable _SubPortFolioRules = new DataTable();

                return _SubPortFolioRules;
            }

            //--- PRD-3162
            public virtual DataTable LoadSubPortFolioRules(string usr)
            {
                DataTable _SubPortFolioRules = new DataTable();

                return _SubPortFolioRules;
            }
            //--- PRD-3162


            public virtual DataTable LoadFinancialPortFolio()
            {
                DataTable _FinancialPortFolio = new DataTable();

                return _FinancialPortFolio;
            }

            //--- PRD-3162
            public virtual DataTable LoadFinancialPortFolio(string usr)
            {
                DataTable _FinancialPortFolio = new DataTable();

                return _FinancialPortFolio;
            }
            //--- PRD-3162


            //--- PRD-3162
            public virtual DataTable LoadConfiguracionPortFolio()
            {
                DataTable _ConfiguracionPortFolio = new DataTable();

                return _ConfiguracionPortFolio;
            }
            public virtual DataTable LoadConfiguracionPortFolio(string usr)
            {
                DataTable _ConfiguracionPortFolio = new DataTable();

                return _ConfiguracionPortFolio;
            }
            //--- PRD-3162

            //--- PRD-3162
            public virtual DataTable LoadFinancialPortFolioPrioridad()
            {
                DataTable _FinancialPortFolioPrioridad = new DataTable();

                return _FinancialPortFolioPrioridad;
            }

            public virtual DataTable LoadFinancialPortFolioPrioridad(string usr)
            {
                DataTable _FinancialPortFolioPrioridad = new DataTable();

                return _FinancialPortFolioPrioridad;
            }
            //--- PRD-3162


        }

        private class SourceSystem : Source
        {

            public override DataTable LoadCustomer()
            {

                String _CustomerQuery = "";

                _CustomerQuery += "SELECT 'Rut'        = clrut\n";
                _CustomerQuery += "     , 'DigitoRut'  = cldv\n";
                _CustomerQuery += "     , 'Codigo'     = clcodigo\n";
                _CustomerQuery += "     , 'Nombre'     = clnombre\n";
                _CustomerQuery += "  FROM dbo.CLIENTE\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Customer;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_CustomerQuery);
                    _Customer = _Connect.QueryDataTable();
                    _Customer.TableName = "Customer";

                    if (_Customer.Rows.Count.Equals(0))
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
                    _Customer = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Customer;
            }

            public override DataTable LoadRate()
            {

                String _RateQuery = "";

                _RateQuery += "SELECT 'Codigo'      = CAST( tbcodigo1 as int )\n";
                _RateQuery += "     , 'Descripcion' = tbglosa\n";
                _RateQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _RateQuery += " WHERE tbcateg       = 1042\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Rate;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_RateQuery);
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

            public override DataTable LoadCurrency()
            {

                String _CurrencyQuery = "";

                _CurrencyQuery += "SELECT 'Codigo'      = mncodmon\n";
                _CurrencyQuery += "     , 'Nemotecnico' = mnnemo\n";
                _CurrencyQuery += "     , 'Glosa'       = mnglosa\n";
                _CurrencyQuery += "  FROM dbo.MONEDA\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Currency;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_CurrencyQuery);
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

            public override DataTable LoadBook()
            {

                String _BookQuery = "";

                _BookQuery += "SELECT 'Codigo'      = tbcodigo1\n";
                _BookQuery += "     , 'Descripcion' = tbglosa\n";
                _BookQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _BookQuery += " WHERE tbcateg = 1552\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Book;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_BookQuery);
                    _Book = _Connect.QueryDataTable();
                    _Book.TableName = "Book";

                    if (_Book.Rows.Count.Equals(0))
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
                    _Book = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Book;
            }

            //--- PRD-3162

            public override DataTable LoadBook(String Usuario)
            {
                String _BookQuery = "";

                // PRD-3162
                _BookQuery += "SET NOCOUNT ON\n";
                _BookQuery += "SELECT 'Codigo'  = tbcodigo1\n";
                _BookQuery += " , 'Descripcion' = tbglosa\n";
                _BookQuery += " , 'Prioridad'   = Ucn_Default\n";
                _BookQuery += "INTO dbo.#Temporal_Usuario_Libro\n";
                _BookQuery += " FROM dbo.TABLA_GENERAL_DETALLE\n";
                _BookQuery += " ,dbo.TBL_RELACION_PRODUCTO_LIBRO\n";
                _BookQuery += " ,dbo.TBL_REL_USUARIO_NORMATIVO\n";
                _BookQuery += " WHERE RPL_IDSISTEMA = 'OPT'\n";
                _BookQuery += " AND RPL_IDPRODUCTO  = 'OPT'\n";
                _BookQuery += " AND TBCATEG = 1552\n";
                _BookQuery += " AND TBCODIGO1 = RPL_IDLIBRO\n";
                _BookQuery += " AND Ucn_Usuario      = '" + Usuario + "'\n";
                _BookQuery += " AND Ucn_Sistema      = Rpl_IdSistema\n";
                _BookQuery += " AND Ucn_Producto     = Rpl_IdProducto\n";
                _BookQuery += " AND Ucn_Codigo_Lib   = Rpl_Idlibro\n";
                _BookQuery += " ORDER BY Ucn_Default	DESC\n";


                _BookQuery += "UPDATE dbo.#Temporal_Usuario_Libro\n";
                _BookQuery += " SET Prioridad = 'S'\n";
                _BookQuery += "FROM dbo.#Temporal_Usuario_Libro\n";
                _BookQuery += "    ,dbo.#Temporal_Usuario_Libro TUL\n";
                _BookQuery += "WHERE dbo.#Temporal_Usuario_Libro.Codigo    = TUL.Codigo\n";
                _BookQuery += " AND dbo.#Temporal_Usuario_Libro.Prioridad   = 'N'\n";
                _BookQuery += " AND TUL.Prioridad = 'S'\n";

                _BookQuery += "SELECT DISTINCT Codigo\n";
                _BookQuery += " , Descripcion\n";
                _BookQuery += " , Prioridad\n";
                _BookQuery += " FROM dbo.#Temporal_Usuario_Libro\n";
                _BookQuery += " ORDER BY Prioridad DESC\n";


                _BookQuery += "DROP TABLE dbo.#Temporal_Usuario_Libro\n";

                _BookQuery += "SET NOCOUNT OFF\n";



                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Book;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_BookQuery);
                    _Book = _Connect.QueryDataTable();
                    _Book.TableName = "Book";

                    if (_Book.Rows.Count.Equals(0))
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
                    _Book = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Book;
            }

            //--- PRD-3162

            public override DataTable LoadPortFolioRules()
            {

                String _PortFolioRulesQuery = "";

                _PortFolioRulesQuery += "SELECT 'Codigo'      = tbcodigo1\n";
                _PortFolioRulesQuery += "     , 'Descripcion' = tbglosa\n";
                _PortFolioRulesQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _PortFolioRulesQuery += " WHERE tbcateg = 1111\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _PortFolioRules;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_PortFolioRulesQuery);
                    _PortFolioRules = _Connect.QueryDataTable();
                    _PortFolioRules.TableName = "PortFolioRules";

                    if (_PortFolioRules.Rows.Count.Equals(0))
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
                    _PortFolioRules = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioRules;
            }

            //--- PRD-3162

            public override DataTable LoadPortFolioRules(String Usuario)
            {

                String _PortFolioRulesQuery = "";

                // PRD-3162

                _PortFolioRulesQuery += "SET NOCOUNT ON\n";
                _PortFolioRulesQuery += "SELECT 'Codigo'  = tbcodigo1\n";
                _PortFolioRulesQuery += " , 'Descripcion' = tbglosa\n";
                _PortFolioRulesQuery += " , 'Prioridad'   = Ucn_Default\n";
                _PortFolioRulesQuery += "INTO dbo.#Temporal_Usuario_Cart_Norm\n";
                _PortFolioRulesQuery += " FROM dbo.TABLA_GENERAL_DETALLE\n";
                _PortFolioRulesQuery += " ,dbo.TBL_RELACION_LIBRO_CARTERASUPER\n";
                _PortFolioRulesQuery += " ,dbo.TBL_REL_USUARIO_NORMATIVO\n";
                _PortFolioRulesQuery += " WHERE RLC_IDSISTEMA = 'OPT'\n";
                _PortFolioRulesQuery += " AND RLC_IDPRODUCTO  = 'OPT'\n";
                _PortFolioRulesQuery += " AND tbcateg = 1111\n";
                _PortFolioRulesQuery += " AND Ucn_Usuario      = '" + Usuario + "'\n";
                _PortFolioRulesQuery += " AND TBCODIGO1      = Rlc_IDCARTERASUPER\n";
                _PortFolioRulesQuery += " AND Ucn_Sistema      = Rlc_IdSistema\n";
                _PortFolioRulesQuery += " AND Ucn_Producto     = Rlc_IdProducto\n";
                _PortFolioRulesQuery += " AND Ucn_Codigo_Lib   = Rlc_Idlibro\n";
                _PortFolioRulesQuery += " AND Ucn_Codigo_CartN = Rlc_IDCARTERASUPER\n";
                _PortFolioRulesQuery += " ORDER BY Ucn_Default	DESC\n";


                _PortFolioRulesQuery += "UPDATE #Temporal_Usuario_Cart_Norm\n";
                _PortFolioRulesQuery += "   SET Prioridad = 'S'\n";
                _PortFolioRulesQuery += " FROM dbo.#Temporal_Usuario_Cart_Norm\n";
                _PortFolioRulesQuery += " ,dbo.#Temporal_Usuario_Cart_Norm TUCN\n";
                _PortFolioRulesQuery += " WHERE #Temporal_Usuario_Cart_Norm.Codigo    = TUCN.Codigo\n";
                _PortFolioRulesQuery += " AND #Temporal_Usuario_Cart_Norm.Prioridad   = 'N'\n";
                _PortFolioRulesQuery += " AND TUCN.Prioridad = 'S'\n";

                _PortFolioRulesQuery += "SELECT DISTINCT Codigo\n";
                _PortFolioRulesQuery += " , Descripcion\n";
                _PortFolioRulesQuery += " , Prioridad\n";
                _PortFolioRulesQuery += " FROM dbo.#Temporal_Usuario_Cart_Norm\n";
                _PortFolioRulesQuery += " ORDER  BY Prioridad DESC\n";


                _PortFolioRulesQuery += "DROP TABLE dbo.#Temporal_Usuario_Cart_Norm\n";

                _PortFolioRulesQuery += "SET NOCOUNT OFF\n";


                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _PortFolioRules;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_PortFolioRulesQuery);
                    _PortFolioRules = _Connect.QueryDataTable();
                    _PortFolioRules.TableName = "PortFolioRules";

                    if (_PortFolioRules.Rows.Count.Equals(0))
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
                    _PortFolioRules = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioRules;
            }

            //--- PRD-3162


            public override DataTable LoadSubPortFolioRules()
            {

                String _PortFolioRulesQuery = "";

                _PortFolioRulesQuery += "SELECT 'Codigo'      = tbcodigo1\n";
                _PortFolioRulesQuery += "     , 'Descripcion' = tbglosa\n";
                _PortFolioRulesQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _PortFolioRulesQuery += " WHERE tbcateg = 1554\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _SubPortFolioRules;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_PortFolioRulesQuery);
                    _SubPortFolioRules = _Connect.QueryDataTable();
                    _SubPortFolioRules.TableName = "SubPortFolioRules";

                    if (_SubPortFolioRules.Rows.Count.Equals(0))
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
                    _SubPortFolioRules = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SubPortFolioRules;
            }

            //--- PRD-3162
            public override DataTable LoadSubPortFolioRules(String Usuario)
            {
                String _PortFolioRulesQuery = "";

                //--- PRD-3162
                _PortFolioRulesQuery += "SET NOCOUNT ON\n";
                _PortFolioRulesQuery += "SELECT 'Codigo'  = tbcodigo1\n";
                _PortFolioRulesQuery += " , 'Descripcion' = tbglosa\n";
                _PortFolioRulesQuery += " , 'Prioridad'   = Ucn_Default\n";
                _PortFolioRulesQuery += "INTO dbo.#Temporal_Usuario_Libro\n";
                _PortFolioRulesQuery += " FROM dbo.TABLA_GENERAL_DETALLE\n";
                _PortFolioRulesQuery += " ,dbo.TBL_RELACION_PRODUCTO_LIBRO\n";
                _PortFolioRulesQuery += " ,dbo.TBL_REL_USUARIO_NORMATIVO\n";
                _PortFolioRulesQuery += " WHERE RPL_IDSISTEMA = 'OPT'\n";
                _PortFolioRulesQuery += " AND RPL_IDPRODUCTO  = 'OPT'\n";
                _PortFolioRulesQuery += " AND TBCATEG = 1554\n";
                _PortFolioRulesQuery += " AND TBCODIGO1 =  ucn_Codigo_SubCartN\n" ; //MAP 20130222 Falla latente en modificacion ? RPL_IDLIBRO\n";
                _PortFolioRulesQuery += " AND Ucn_Usuario      = '" + Usuario + "'\n";
                _PortFolioRulesQuery += " AND Ucn_Sistema      = Rpl_IdSistema\n";
                _PortFolioRulesQuery += " AND Ucn_Producto     = Rpl_IdProducto\n";
                _PortFolioRulesQuery += " AND Ucn_Codigo_Lib   = Rpl_Idlibro\n";
                _PortFolioRulesQuery += " ORDER BY Ucn_Default	DESC\n";


                _PortFolioRulesQuery += "UPDATE dbo.#Temporal_Usuario_Libro\n";
                _PortFolioRulesQuery += " SET Prioridad = 'S'\n";
                _PortFolioRulesQuery += "FROM dbo.#Temporal_Usuario_Libro\n";
                _PortFolioRulesQuery += "    ,dbo.#Temporal_Usuario_Libro TUL\n";
                _PortFolioRulesQuery += "WHERE dbo.#Temporal_Usuario_Libro.Codigo    = TUL.Codigo\n";
                _PortFolioRulesQuery += " AND dbo.#Temporal_Usuario_Libro.Prioridad   = 'N'\n";
                _PortFolioRulesQuery += " AND TUL.Prioridad = 'S'\n";

                _PortFolioRulesQuery += "SELECT DISTINCT Codigo\n";
                _PortFolioRulesQuery += " , Descripcion\n";
                _PortFolioRulesQuery += " , Prioridad\n";
                _PortFolioRulesQuery += " FROM dbo.#Temporal_Usuario_Libro\n";
                _PortFolioRulesQuery += " ORDER BY Prioridad DESC\n";


                _PortFolioRulesQuery += "DROP TABLE dbo.#Temporal_Usuario_Libro\n";


                _PortFolioRulesQuery += "SET NOCOUNT OFF\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _SubPortFolioRules;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_PortFolioRulesQuery);
                    _SubPortFolioRules = _Connect.QueryDataTable();
                    _SubPortFolioRules.TableName = "SubPortFolioRules";

                    if (_SubPortFolioRules.Rows.Count.Equals(0))
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
                    _SubPortFolioRules = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SubPortFolioRules;
            }


            //--- PRD-3162


            public override DataTable LoadFinancialPortFolio()
            {

                String _FinancialPortFolioQuery = "";

                _FinancialPortFolioQuery += "SELECT 'Codigo'      = CAST( tbcodigo1 as int )\n";
                _FinancialPortFolioQuery += "     , 'Descripcion' = tbglosa\n";
                _FinancialPortFolioQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _FinancialPortFolioQuery += " WHERE tbcateg = 204\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _FinancialPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_FinancialPortFolioQuery);
                    _FinancialPortFolio = _Connect.QueryDataTable();
                    _FinancialPortFolio.TableName = "FinancialPortFolio";

                    if (_FinancialPortFolio.Rows.Count.Equals(0))
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
                    _FinancialPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _FinancialPortFolio;
            }

            //--- PRD-3162
            public override DataTable LoadFinancialPortFolio(String Usuario) // PRD-3162
            {
                String _FinancialPortFolioQuery = "";

                // PRD-3162
                _FinancialPortFolioQuery += "SET NOCOUNT ON\n";
                _FinancialPortFolioQuery += "SELECT 'Codigo'  = tbcodigo1\n";
                _FinancialPortFolioQuery += " , 'Descripcion' = tbglosa\n";
                _FinancialPortFolioQuery += " , 'Prioridad'   = Ucf_Default\n";
                _FinancialPortFolioQuery += " FROM dbo.TIPO_CARTERA\n";
                _FinancialPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE\n";
                _FinancialPortFolioQuery += " ,dbo.TBL_REL_USU_CART_FINANCIERA\n";
                _FinancialPortFolioQuery += " WHERE rccodpro = 'OPT'\n";
                _FinancialPortFolioQuery += " AND tbcateg = 204\n";
                _FinancialPortFolioQuery += " AND rcsistema = 'OPT'\n";
                _FinancialPortFolioQuery += " AND tbcodigo1    = LTRIM(RTRIM(CONVERT(CHAR,rcrut)))\n";
                _FinancialPortFolioQuery += " AND Ucf_Usuario  = '" + Usuario + "'\n";
                _FinancialPortFolioQuery += " AND Ucf_Sistema  = rcsistema\n";
                _FinancialPortFolioQuery += " AND Ucf_Producto = rccodpro\n";
                _FinancialPortFolioQuery += " AND Ucf_Codigo_Cart = rcrut\n";
                _FinancialPortFolioQuery += " ORDER BY Ucf_Default DESC\n";


                _FinancialPortFolioQuery += "SET NOCOUNT OFF\n";



                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _FinancialPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_FinancialPortFolioQuery);
                    _FinancialPortFolio = _Connect.QueryDataTable();
                    _FinancialPortFolio.TableName = "FinancialPortFolio";

                    if (_FinancialPortFolio.Rows.Count.Equals(0))
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
                    _FinancialPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _FinancialPortFolio;
            }
            //--- PRD-3162

            //--- PRD-3162
            public override DataTable LoadConfiguracionPortFolio() // PRD-3162
            {
                String _ConfiguracionPortFolioQuery = "";

                // PRD-3162
                _ConfiguracionPortFolioQuery += "SET NOCOUNT ON\n";
                _ConfiguracionPortFolioQuery += "SELECT 'Usuario'  = Ucn_Usuario\n";
                _ConfiguracionPortFolioQuery += " , 'LibroCod' = Ucn_Codigo_Lib\n";
                _ConfiguracionPortFolioQuery += " , 'LibroDsc'   = Libro.tbglosa\n";
                _ConfiguracionPortFolioQuery += " , 'CarteraNormativaCod' = Ucn_Codigo_CartN\n";
                _ConfiguracionPortFolioQuery += " , 'CarteraNormativaDsc'   = CarteraNormativa.tbglosa\n";
                _ConfiguracionPortFolioQuery += " , 'SubCarteraNormativaCod' = Ucn_Codigo_SubCartN\n";
                _ConfiguracionPortFolioQuery += " , 'SubCarteraNormativaDsc'   = SubCarteraNormativa.tbglosa\n";
                _ConfiguracionPortFolioQuery += " , 'Prioridad'   = Ucn_Default\n";
                _ConfiguracionPortFolioQuery += " FROM dbo.TBL_REL_USUARIO_NORMATIVO\n";
                _ConfiguracionPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE Libro\n";
                _ConfiguracionPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE CarteraNormativa\n";
                _ConfiguracionPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE SubCarteraNormativa\n";
                _ConfiguracionPortFolioQuery += " WHERE Ucn_Sistema  = 'OPT'\n";
                _ConfiguracionPortFolioQuery += " AND Libro.tbCateg = 1552\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Codigo_Lib = Libro.tbcodigo1\n";

                _ConfiguracionPortFolioQuery += " AND CarteraNormativa.tbCateg = 1111\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Codigo_CartN = CarteraNormativa.tbcodigo1\n";
                _ConfiguracionPortFolioQuery += " AND SubCarteraNormativa.tbCateg = 1554\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Codigo_SubCartN = SubCarteraNormativa.tbcodigo1\n";


                _ConfiguracionPortFolioQuery += "SET NOCOUNT OFF\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _ConfiguracionPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_ConfiguracionPortFolioQuery);
                    _ConfiguracionPortFolio = _Connect.QueryDataTable();
                    _ConfiguracionPortFolio.TableName = "ConfiguracionPortFolio";

                    if (_ConfiguracionPortFolio.Rows.Count.Equals(0))
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
                    _ConfiguracionPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _ConfiguracionPortFolio;
            }



            public override DataTable LoadConfiguracionPortFolio(String Usuario) // PRD-3162
            {
                String _ConfiguracionPortFolioQuery = "";

                // PRD-3162
                _ConfiguracionPortFolioQuery += "SET NOCOUNT ON\n";
                _ConfiguracionPortFolioQuery += "SELECT 'Usuario'  = Ucn_Usuario\n";
                _ConfiguracionPortFolioQuery += " , 'LibroCod' = Ucn_Codigo_Lib\n";
                _ConfiguracionPortFolioQuery += " , 'LibroDsc'   = Libro.tbglosa\n";
                _ConfiguracionPortFolioQuery += " , 'CarteraNormativaCod' = Ucn_Codigo_CartN\n";
                _ConfiguracionPortFolioQuery += " , 'CarteraNormativaDsc'   = CarteraNormativa.tbglosa\n";
                _ConfiguracionPortFolioQuery += " , 'SubCarteraNormativaCod' = Ucn_Codigo_SubCartN\n";
                _ConfiguracionPortFolioQuery += " , 'SubCarteraNormativaDsc'   = SubCarteraNormativa.tbglosa\n";
                _ConfiguracionPortFolioQuery += " , 'Prioridad'   = Ucn_Default\n";
                _ConfiguracionPortFolioQuery += " FROM dbo.TBL_REL_USUARIO_NORMATIVO\n";
                _ConfiguracionPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE Libro\n";
                _ConfiguracionPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE CarteraNormativa\n";
                _ConfiguracionPortFolioQuery += " ,dbo.TABLA_GENERAL_DETALLE SubCarteraNormativa\n";
                _ConfiguracionPortFolioQuery += " WHERE Ucn_Usuario  = '" + Usuario + "'\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Sistema  = 'OPT'\n";
                _ConfiguracionPortFolioQuery += " AND Libro.tbCateg = 1552\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Codigo_Lib = Libro.tbcodigo1\n";

                _ConfiguracionPortFolioQuery += " AND CarteraNormativa.tbCateg = 1111\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Codigo_CartN = CarteraNormativa.tbcodigo1\n";
                _ConfiguracionPortFolioQuery += " AND SubCarteraNormativa.tbCateg = 1554\n";
                _ConfiguracionPortFolioQuery += " AND Ucn_Codigo_SubCartN = SubCarteraNormativa.tbcodigo1\n";


                _ConfiguracionPortFolioQuery += "SET NOCOUNT OFF\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _ConfiguracionPortFolio;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_ConfiguracionPortFolioQuery);
                    _ConfiguracionPortFolio = _Connect.QueryDataTable();
                    _ConfiguracionPortFolio.TableName = "ConfiguracionPortFolio";

                    if (_ConfiguracionPortFolio.Rows.Count.Equals(0))
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
                    _ConfiguracionPortFolio = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _ConfiguracionPortFolio;
            }
            //--- PRD-3162

            public override DataTable LoadFinancialPortFolioPrioridad() // PRD-3162
            {
                String _FinancialPortFolioPrioridadQuery = "";

                // PRD-3162
                _FinancialPortFolioPrioridadQuery += "SELECT 'Codigo'      = CAST( tbcodigo1 as int )\n";
                _FinancialPortFolioPrioridadQuery += " , 'Descripcion' = tbglosa\n";
                _FinancialPortFolioPrioridadQuery += " , 'Prioridad'   = ''\n";
                _FinancialPortFolioPrioridadQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _FinancialPortFolioPrioridadQuery += " WHERE tbcateg = 204\n";



                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _FinancialPortFolioPrioridad;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_FinancialPortFolioPrioridadQuery);
                    _FinancialPortFolioPrioridad = _Connect.QueryDataTable();
                    _FinancialPortFolioPrioridad.TableName = "FinancialPortFolioPrioridad";

                    if (_FinancialPortFolioPrioridad.Rows.Count.Equals(0))
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
                    _FinancialPortFolioPrioridad = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _FinancialPortFolioPrioridad;
            }


            public override DataTable LoadFinancialPortFolioPrioridad(String Usuario) // PRD-3162
            {
                String _FinancialPortFolioPrioridadQuery = "";

                // PRD-3162
                _FinancialPortFolioPrioridadQuery += "SET NOCOUNT ON\n";
                _FinancialPortFolioPrioridadQuery += "SELECT 'Codigo'  = tbcodigo1\n";
                _FinancialPortFolioPrioridadQuery += " , 'Descripcion' = tbglosa\n";
                _FinancialPortFolioPrioridadQuery += " , 'Prioridad'   = Ucf_Default\n";
                _FinancialPortFolioPrioridadQuery += " FROM dbo.TIPO_CARTERA\n";
                _FinancialPortFolioPrioridadQuery += " ,dbo.TABLA_GENERAL_DETALLE\n";
                _FinancialPortFolioPrioridadQuery += " ,dbo.TBL_REL_USU_CART_FINANCIERA\n";
                _FinancialPortFolioPrioridadQuery += " WHERE rccodpro = 'OPT'\n";
                _FinancialPortFolioPrioridadQuery += " AND tbcateg = 204\n";
                _FinancialPortFolioPrioridadQuery += " AND rcsistema = 'OPT'\n";
                _FinancialPortFolioPrioridadQuery += " AND tbcodigo1    = LTRIM(RTRIM(CONVERT(CHAR,rcrut)))\n";
                _FinancialPortFolioPrioridadQuery += " AND Ucf_Usuario  = '" + Usuario + "'\n";
                _FinancialPortFolioPrioridadQuery += " AND Ucf_Sistema  = rcsistema\n";
                _FinancialPortFolioPrioridadQuery += " AND Ucf_Producto = rccodpro\n";
                _FinancialPortFolioPrioridadQuery += " AND Ucf_Codigo_Cart = rcrut\n";
                _FinancialPortFolioPrioridadQuery += " ORDER BY Ucf_Default DESC\n";


                _FinancialPortFolioPrioridadQuery += "SET NOCOUNT OFF\n";



                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _FinancialPortFolioPrioridad;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_FinancialPortFolioPrioridadQuery);
                    _FinancialPortFolioPrioridad = _Connect.QueryDataTable();
                    _FinancialPortFolioPrioridad.TableName = "FinancialPortFolioPrioridad";

                    if (_FinancialPortFolioPrioridad.Rows.Count.Equals(0))
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
                    _FinancialPortFolioPrioridad = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _FinancialPortFolioPrioridad;
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
