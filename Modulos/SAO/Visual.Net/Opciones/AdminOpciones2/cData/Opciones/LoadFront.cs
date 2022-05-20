using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace cData.Opciones
{
    public static class LoadFront
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        public static DataSet LoadAllFront()
        {
            DataSet _DataSetReturn = new DataSet();


            DataTable _OpcionEstructuraData = new DataTable();
            DataTable _OpcionTipoData = new DataTable();
            DataTable _PayOffTipoData = new DataTable();
            DataTable _BenchmarkData = new DataTable();
            DataTable _FormaDePago = new DataTable();
            DataTable _FormaPagoDefecto = new DataTable();
            DataTable _DateProccess = new DataTable();
            //DataTable _SpotBS = new DataTable();
            DataTable _OptionStateTable = new DataTable();

            _OpcionEstructuraData = LoadOpcionEstructura();
            _OpcionTipoData = LoadOpcionTipo();
            _PayOffTipoData = LoadPayOffTipo();
            _BenchmarkData = LoadBenchmark();
            _FormaDePago = LoadFormaDePago();
            _FormaPagoDefecto = LoadFormaPagoDefecto("CLP/USD");
            _DateProccess = LoadDateProcess();
            _OptionStateTable = LoadOptionState();


            try
            {
            
                _DataSetReturn.Merge(_OpcionEstructuraData);
                _DataSetReturn.Merge(_OpcionTipoData);
                _DataSetReturn.Merge(_PayOffTipoData);
                _DataSetReturn.Merge(_BenchmarkData);
                _DataSetReturn.Merge(_FormaDePago);
                _DataSetReturn.Merge(_FormaPagoDefecto);
                _DataSetReturn.Merge(_DateProccess);               
                _DataSetReturn.Merge(_OptionStateTable);
            }
            catch (Exception e)
            {
                string error = e.Message;
            }

            return _DataSetReturn;
        }

        public static DataTable LoadOptionState()
        {
            String _QueryOptionsState = "";

            #region "Query Options State"

            _QueryOptionsState += " SELECT ConOpcEstCod, \n";
            _QueryOptionsState += " 	ConOpcEstDsc \n";
            _QueryOptionsState += " FROM ConOpcEstado \n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // DefiniciÃ³n de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryOptionsState);
                _DataTableReturn = _Connect.QueryDataTable();

                _DataTableReturn.TableName = "OptionState";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;


                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }



            return _DataTableReturn;

        }

        #region //public static DataTable LoadSpotBS
        //public static DataTable LoadSpotBS(DateTime DateProccess, string NemoMoneda)
        //{
        //    String _QueryDateProc = "";

        //    #region "Query DateProccess"



        //    _QueryDateProc += "SELECT Tipo_Cambio FROM valor_moneda_contable ";
        //    _QueryDateProc += "WHERE Fecha = '" + DateProccess.ToString("yyyyMMdd") + "' AND Nemo_Moneda='" + NemoMoneda + "'";


        //    #endregion

        //    cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");


        //    DataTable _DataTableReturn;

        //    try
        //    {
        //        // Definición de la Curva
        //        mStatus = enumStatus.Loading;
        //        _Connect.Execute(_QueryDateProc);
        //        _DataTableReturn = _Connect.QueryDataTable();

        //        _DataTableReturn.TableName = "SpotBS";

        //        if (_DataTableReturn.Rows.Count.Equals(0))
        //        {
        //            mStatus = enumStatus.NotFound;
        //        }
        //        else
        //        {
        //            mStatus = enumStatus.Already;


        //        }

        //    }
        //    catch (Exception _Error)
        //    {
        //        _DataTableReturn = null;
        //        mStatus = enumStatus.ErrorLoad;
        //        mError = _Error.StackTrace;
        //        mStack = _Error.Message;
        //    }



        //    return _DataTableReturn;

        //}
        #endregion

        public static DataTable LoadDateProcess()
        {
            String _QueryDateProc = "";
            
            #region "Query DateProccess"



            _QueryDateProc += "SELECT fechaproc, fechaant from opcionesgeneral \n";


            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryDateProc);
                _DataTableReturn = _Connect.QueryDataTable();

                _DataTableReturn.TableName = "DateProccess";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                   

                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }



            return _DataTableReturn;

        }

        public static DataTable LoadOpcionEstructura()
        {
            String _QueryOpcionEstructura = "";

            #region "Query Fixing Rate"

            //Esto ordena las opciones del combo de estructuras
            _QueryOpcionEstructura += "SELECT 'OpcEstCod' = OpcEstCod\n";
            _QueryOpcionEstructura += "     , 'OpcEstDsc' = OpcEstDsc\n";
            _QueryOpcionEstructura += "     , 'OrderBy'   = OpcEstOrden\n";
            _QueryOpcionEstructura += "  from OpcionEstructura\n";
            //visibilidad
            _QueryOpcionEstructura += " where OpcEstVisible = 1\n";
            _QueryOpcionEstructura += " order by OrderBy\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryOpcionEstructura);
                _DataTableReturn = _Connect.QueryDataTable();
                
                _DataTableReturn.TableName = "OpcionEstructura";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;           

        }

        public static DataTable LoadOpcionTipo()
        {
            String _QueryRateFixing = "";

            #region "Query Fixing Rate"


            _QueryRateFixing += "SELECT * from opciontipo \n";


            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFixing);
                _DataTableReturn = _Connect.QueryDataTable();
                
                _DataTableReturn.TableName = "OpcionTipo";
               
                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;

        }

        public static DataTable LoadPayOffTipo()
        {
            String _QueryRateFixing = "";

            #region "Query Fixing Rate"


            _QueryRateFixing += "Select * From payofftipo\n";


            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFixing);
                _DataTableReturn = _Connect.QueryDataTable();
                
                _DataTableReturn.TableName = "PayOffTipo";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;

        }

        public static DataTable LoadBenchmark()
        {
            String _QueryRateFixing = "";

            #region "Query Fixing Rate"


            _QueryRateFixing += "Select * From benchmark\n";


            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFixing);
                _DataTableReturn = _Connect.QueryDataTable();
               
                _DataTableReturn.TableName = "Benchmark";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;

        }

        public static DataTable LoadFormaPagoDefecto(string ParMonedas)
        {
            string _QueryFormaPagoDefecto = "";

            #region "Query Forma de Pago"

            /*
             * Solo se filtran las formas de pago para las moneda USD y CLP.
             */

            _QueryFormaPagoDefecto += "SET NOCOUNT ON\n\n";
            _QueryFormaPagoDefecto += "DECLARE @ParMoneda VARCHAR(7)\n\n";
            _QueryFormaPagoDefecto += "SET @ParMoneda = '{0}'\n\n";
            _QueryFormaPagoDefecto += "SELECT OpcParMdaCod\n";
            _QueryFormaPagoDefecto += "     , OpcParMda1\n";
            _QueryFormaPagoDefecto += "     , OpcParMda2\n";
            _QueryFormaPagoDefecto += "     , OpcFPagoMda1\n";
            _QueryFormaPagoDefecto += "     , OpcFPagoMda2\n";
            _QueryFormaPagoDefecto += "  FROM dbo.OpcionParMonedas\n";
            _QueryFormaPagoDefecto += " WHERE @ParMoneda in ( OpcParMdaCod, '' )\n\n";
            _QueryFormaPagoDefecto += "SET NOCOUNT OFF\n";

            _QueryFormaPagoDefecto = string.Format(_QueryFormaPagoDefecto, ParMonedas);
            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryFormaPagoDefecto);
                _DataTableReturn = _Connect.QueryDataTable();

                _DataTableReturn.TableName = "FormaPagoDefecto";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;

        }

        public static DataTable LoadFormaDePago()
        {
            string _QueryRateFormaDePago = "";

            #region "Query Forma de Pago"

            /*
             * Solo se filtran las formas de pago para las moneda USD y CLP.
             */

            _QueryRateFormaDePago += "SELECT MFP.mfcodmon\n";
            _QueryRateFormaDePago += "     , FP.codigo\n";
            _QueryRateFormaDePago += "     , FP.glosa\n";
            _QueryRateFormaDePago += "     , FP.diasvalor\n";
            _QueryRateFormaDePago += "  FROM MONEDA_FORMA_DE_PAGO MFP\n";
            _QueryRateFormaDePago += "       INNER JOIN FORMA_DE_PAGO FP ON MFP.mfcodfor = FP.codigo\n";
            _QueryRateFormaDePago += " WHERE MFSISTEMA  = 'PCS'\n";
            _QueryRateFormaDePago += "   AND mfestado   = 1\n";
            _QueryRateFormaDePago += "   AND mfcodmon  in ( 13, 999 )\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFormaDePago);
                _DataTableReturn = _Connect.QueryDataTable();

                _DataTableReturn.TableName = "FormaDePago";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;

        }

        public static DataTable LoadFormaDePago(string mnemotecnicoMoneda)
        {
            String _QueryRateFormaDePago = "";

            #region "Query Forma de Pago"

            _QueryRateFormaDePago += "DECLARE @Moneda VARCHAR(10)\n";

            _QueryRateFormaDePago += "SET @Moneda = '{0}'\n";

            _QueryRateFormaDePago += "SELECT codigo\n";
            _QueryRateFormaDePago += "     , glosa\n";
            _QueryRateFormaDePago += "     , diasvalor \n";
            _QueryRateFormaDePago += "  FROM MONEDA_FORMA_DE_PAGO\n";
            _QueryRateFormaDePago += "       INNER JOIN FORMA_DE_PAGO ON mfcodfor = codigo\n";
            _QueryRateFormaDePago += "       INNER JOIN MONEDA        ON mnnemo   = @Moneda\n";
            _QueryRateFormaDePago += " WHERE MFSISTEMA = 'PCS'\n";
            _QueryRateFormaDePago += "   AND mfcodmon  = mncodmon\n";
            _QueryRateFormaDePago += "   AND mfestado  = 1\n";

            _QueryRateFormaDePago = string.Format(_QueryRateFormaDePago, mnemotecnicoMoneda);

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");


            DataTable _DataTableReturn;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFormaDePago);
                _DataTableReturn = _Connect.QueryDataTable();

                _DataTableReturn.TableName = "FormaDePago";

                if (_DataTableReturn.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataTableReturn = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTableReturn;

        }


    }


}
