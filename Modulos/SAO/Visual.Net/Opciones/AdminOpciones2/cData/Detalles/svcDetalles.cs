using System;
using System.Data;

namespace cData.Detalles 
{
    public static class svcDetalles
    {
        #region "Atributos Privados"
        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;
        #endregion

        public static DataTable dMoEncContrato(int cliRut, int cliDv)
        {
            return dMoEncContrato(cliRut, cliDv, "Todos");
        }

        public static DataTable dMoEncContrato(int rut, int codigo, string tipocontrato)
        {
            String _QuerySpMoEncContrato = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _ContratoData;

            #region "Ejecuta Sp_MoEncContrato"
            if (tipocontrato == "Solicitud")
            {
                _QuerySpMoEncContrato = string.Format("SP_CON_SOLICITUD_SDA {0}, {1}, '{2}'", rut, codigo, tipocontrato);
            }
            else if (tipocontrato == "Leasing")
            {
                _QuerySpMoEncContrato = string.Format("SP_CON_LEASING_RELACIONADO {0}, {1}, '{2}'", rut, codigo, tipocontrato);
            }
            else
            {
                _QuerySpMoEncContrato = string.Format("Sp_MoEncContrato {0}, {1}, '{2}'", rut, codigo, tipocontrato);
            }
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpMoEncContrato);
                _ContratoData = _Connect.QueryDataTable();
                _ContratoData.TableName = "Contratos";

                if (_ContratoData.Rows.Count.Equals(0))
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
                _ContratoData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _ContratoData;
        }

        public static DataTable dMoEncCotizacion(int cliRut, int cliCod)
        {
            String _QuerySpMoEncCotizacion = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _CotizacionData;

            #region "Ejecuta Sp_MoEncCotizacion"
            _QuerySpMoEncCotizacion = "Sp_MoEncCotizacion " + cliRut + ", " + cliCod;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpMoEncCotizacion);
                _CotizacionData = _Connect.QueryDataTable();
                _CotizacionData.TableName = "Contratos";

                if (_CotizacionData.Rows.Count.Equals(0))
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
                _CotizacionData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _CotizacionData;
        }

        public static DataTable dCaEncContrato(int cliRut, int cliCodigo, int Estado, string fContratoIni, string fContratoFin, string fEjercicioIni, string fEjercicioFin, string Relacionado)
        {
            String _QuerySpCaEncContrato = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _ContratoData;

//REVISAR
            #region "Ejecuta Sp_CaEncContrato"
            _QuerySpCaEncContrato = string.Format(
                                                   "EXECUTE dbo.Sp_CaEncContrato {0}, {1}, {2}, '{3}', '{4}', '{5}', '{6}'",//, '{7}'",
                                                   cliRut,
                                                   cliCodigo,
                                                   Estado,
                                                   fContratoIni,
                                                   fEjercicioFin,
                                                   fEjercicioIni,
                                                   fEjercicioFin,
                                                   Relacionado
                                                 );
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpCaEncContrato);
                _ContratoData = _Connect.QueryDataTable();
                _ContratoData.TableName = "Contratos";

                if (_ContratoData.Rows.Count.Equals(0))
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
                _ContratoData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _ContratoData;
        }

        public static DataTable dGenCntVoucher(string _fecha)
        {
            String _QuerySPGenCntVoucher = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _VoucherData;

            #region "Ejecuta SP_GenCntVoucher"
            _QuerySPGenCntVoucher = "SP_GenCntVoucher '" + _fecha + "'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySPGenCntVoucher);
                _VoucherData = _Connect.QueryDataTable();
                _VoucherData.TableName = "Vouchers";

                if (_VoucherData.Rows.Count.Equals(0))
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
                _VoucherData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _VoucherData;
        }

        #region "Ejecuta procedimientos directos sin parametros"

        public static DataTable dSpInterContableOpc()
        {
            String _QuerydSpInterContableOpc = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _InterContData;

            #region "Ejecuta sp_inter_contable_opc"
            _QuerydSpInterContableOpc = "sp_inter_contable_opc ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpInterContableOpc);
                _InterContData = _Connect.QueryDataTable();
                _InterContData.TableName = "InterContOpc";

                if (_InterContData.Rows.Count.Equals(0))
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
                _InterContData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _InterContData;
        }

        public static DataTable dSpRecalculoLineasOpciones()
        {
            String _QuerydSpRecalculoLineasOpciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _RecalculoData;

            #region "Ejecuta sp_recalculo_lineas_opciones"
            _QuerydSpRecalculoLineasOpciones = "sp_recalculo_lineas_opciones " + "opt";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpRecalculoLineasOpciones);
                _RecalculoData = _Connect.QueryDataTable();
                _RecalculoData.TableName = "RecalculoLinea";

                if (_RecalculoData.Rows.Count.Equals(0))
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
                _RecalculoData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _RecalculoData;
        }

        public static DataTable dSpInterfazDerivadosOpciones() 
        {
            String _QuerySpInterfazDerivadosOpciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _DerivadosData;

            #region "Ejecuta Sp_Interfaz_derivados_Opciones"
            _QuerySpInterfazDerivadosOpciones = "Sp_Interfaz_derivados_Opciones";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpInterfazDerivadosOpciones);
                _DerivadosData = _Connect.QueryDataTable();
                _DerivadosData.TableName = "Interfaz";

                if (_DerivadosData.Rows.Count.Equals(0))
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
                _DerivadosData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _DerivadosData;
        }

        public static DataTable dSpInterfazOperacionesOpciones() 
        {
            String _QuerySpInterfazOperacionesOpciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _DerivadosData;

            #region "Ejecuta Sp_Interfaz_operaciones_Opciones"
            _QuerySpInterfazOperacionesOpciones = "Sp_Interfaz_operaciones_Opciones";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpInterfazOperacionesOpciones);
                _DerivadosData = _Connect.QueryDataTable();
                _DerivadosData.TableName = "Interfaz";

                if (_DerivadosData.Rows.Count.Equals(0))
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
                _DerivadosData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _DerivadosData;
        }

        public static DataTable dSpInterfazBalanceOpciones()
        {
            String _QuerydSpInterfazBalanceOpciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _BalanceData;

            #region "Ejecuta sp_interfaz_balance_opciones"
            _QuerydSpInterfazBalanceOpciones = "sp_interfaz_balance_opciones";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpInterfazBalanceOpciones);
                _BalanceData = _Connect.QueryDataTable();
                _BalanceData.TableName = "Interfaz";

                if (_BalanceData.Rows.Count.Equals(0))
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
                _BalanceData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _BalanceData;       
        }

        public static DataTable dConsultaDefiniciones() 
        {
            String _QuerydConsultaDefiniciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _Definiciones;

            #region "Ejecuta Query Definiciones"
           /* _QuerydConsultaDefiniciones = @"Select _clip.clrut,
                                                                   _clip.cldv,
                                                                   _clip.clnombre,
                                                                   FechaFirma_cond_Opc = isnull(( select ClFechaFirma_Cond_Opc 
                                                                                                                 from BreakBacParamsudaCliente _CliB 
                                                                                                                where _CliB.ClRut = _Clip.ClRut 
                                                                                                                   and _CliB.ClCodigo = _Clip.ClCodigo), '19000101'),
                                                                   _clip.clcodigo
                                                            from BacparamSudaCliente _Clip"; */

            _QuerydConsultaDefiniciones = @"SELECT _clip.clrut
                                          , _clip.cldv
                                          , _clip.clnombre
                                          , FechaFirma_cond_Opc       = ISNULL( _CliB.ClFechaFirma_Cond_Opc, '19000101' )                                          
                                          , clFechaFirma_cond_OpcChk  = ISNULL( _CliB.clFechaFirma_cond_OpcChk, 0 )
                                          , clFechaFirma_Supl_Opc     = ISNULL( clFechaFirma_Supl_Opc, '19000101' )
                                          , clFechaFirma_Supl_OpcChk  = ISNULL( _CliB.clFechaFirma_Supl_OpcChk, 0 )
                                          , _clip.clcodigo
                                          FROM BacparamSudaCliente _Clip
                                          LEFT JOIN BreakBacParamsudaCliente _CliB  ON _CliB.ClRut    = _Clip.ClRut
                                          AND _CliB.ClCodigo = _Clip.ClCodigo";
            /*_QuerydConsultaDefiniciones = @"SELECT distinct  _clip.clrut
                                                , _clip.cldv
                                                , _clip.clnombre
                                                , FechaFirma_cond_Opc       = ISNULL( _CliB.ClFechaFirma_Cond_Opc, '19000101' )                                          
                                                , clFechaFirma_cond_OpcChk  = ISNULL( _CliB.clFechaFirma_cond_OpcChk, 0 )
                                                , clFechaFirma_Supl_Opc     = ISNULL( clFechaFirma_Supl_Opc, '19000101' )
                                                , clFechaFirma_Supl_OpcChk  = ISNULL( _CliB.clFechaFirma_Supl_OpcChk, 0 )
                                                , _clip.clcodigo
                                            FROM BacparamSudaCliente _Clip     
                                                LEFT JOIN BreakBacParamsudaCliente _CliB  ON _CliB.ClRut    = _Clip.ClRut
                                                AND _CliB.ClCodigo = _Clip.ClCodigo
                                                ,MoEncContrato as MoEnc
                                                ,MoHisEncContrato as MoHisEnc 
                                            WHERE (_clip.clrut = MoEnc.MoRutCliente AND  _clip.clcodigo = MoEnc.MoCodigo AND MoEnc.MoEstado <> '' AND MoEnc.MoEstado <> ' ' AND MoEnc.MoEstado <> 'N') 
                                                OR (_clip.clrut = MoHisEnc.MoRutCliente AND  _clip.clcodigo = MoHisEnc.MoCodigo AND MoHisEnc.MoEstado <> '' AND MoHisEnc.MoEstado <> ' ' AND MoHisEnc.MoEstado <> 'N')";*/

            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydConsultaDefiniciones);
                _Definiciones = _Connect.QueryDataTable();
                _Definiciones.TableName = "Definiciones";

                if (_Definiciones.Rows.Count.Equals(0))
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
                _Definiciones = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _Definiciones;
        }

        #endregion

        public static DataTable dSpCaFixDesdeHastaOpt(string f1, string f2, int NumContrato, string Usuario)
        {
            String _QuerydSpInterContableOpc = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _InterContData;

            #region "Ejecuta Sp_CaFixDesdeHastaOpt"
            _QuerydSpInterContableOpc = "Sp_CaFixDesdeHastaOpt " + "'" + f1 + "' ,'" + f2 + "' ," + NumContrato + ",'" + Usuario + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpInterContableOpc);
                _InterContData = _Connect.QueryDataTable();
                _InterContData.TableName = "CaFixDHOpt";

                if (_InterContData.Rows.Count.Equals(0))
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
                _InterContData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _InterContData;
        }

        public static DataTable dSpGridDecisionEjercicio(string f1, string f2, int cliRut, int cliCod, string usuario)
        {
            String _QuerydSpGridDecisionEjercicio = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _DecisionEjData;

            #region "Ejecuta Sp_GridDecisionEjercicio"
            _QuerydSpGridDecisionEjercicio = "Sp_GridDecisionEjercicio " + "'" + f1 + "' ,'" + f2 + "' ," + cliRut + "," + cliCod + ",'" + usuario + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpGridDecisionEjercicio);
                _DecisionEjData = _Connect.QueryDataTable();
                _DecisionEjData.TableName = "GridDecisionEj";

                if (_DecisionEjData.Rows.Count.Equals(0))
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
                _DecisionEjData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DecisionEjData;
        }

        public static DataTable dSpGridCaLiquidaciones(int cliRut, int cliCod, string f1, string f2, string estado, string usuario)
        {
            String _QuerydSpGridCaLiquidaciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _LiquidacionesData;

            #region "Ejecuta Sp_GridCaLiquidaciones"
            _QuerydSpGridCaLiquidaciones = "Sp_GridCaLiquidaciones " + cliRut + " , " + cliCod + " , '" + f1 + "', '" + f2 + "', '" + estado + "', '" + usuario + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpGridCaLiquidaciones);
                _LiquidacionesData = _Connect.QueryDataTable();
                _LiquidacionesData.TableName = "GridCaLiquidaciones";

                if (_LiquidacionesData.Rows.Count.Equals(0))
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
                _LiquidacionesData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _LiquidacionesData;
        }

        public static DataTable VerificaFixingPendientes()
        {
            string _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _DataTable;

            #region "Ejecuta Sp_GridCaPagosCompensados"
            _Query = "SRV_Verifica_Fixing_Pendientes";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _DataTable = _Connect.QueryDataTable();
                _DataTable.TableName = "VerificaFixingPendientes";

                if (_DataTable.Rows.Count.Equals(0))
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
                _DataTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataTable;
        }

        public static DataTable dSpGridCaPagosCompensados(int cliRut, int cliCod, string f1, string f2)
        {
            String _QuerydSpGridCaPagosCompensados = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _PagosCompensados;

            #region "Ejecuta Sp_GridCaPagosCompensados"
            _QuerydSpGridCaPagosCompensados = "Sp_GridCaPagosCompensados " + cliRut + " , " + cliCod + " , '" + f1 + "', '" + f2 + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpGridCaPagosCompensados);
                _PagosCompensados = _Connect.QueryDataTable();
                _PagosCompensados.TableName = "GridCaPagosCompensados";

                if (_PagosCompensados.Rows.Count.Equals(0))
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
                _PagosCompensados = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _PagosCompensados;
        }

        public static DataTable dSpGridCaPagosEntregaFisica(int cliRut, int cliCod, string f1, string f2)
        {
            String _QuerydSpGridCaPagosEntregaFisica = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _PagosEntregaFisica;

            #region "Ejecuta Sp_GridCaPagosEntregaFisica"
            _QuerydSpGridCaPagosEntregaFisica = "Sp_GridCaPagosEntregaFisica " + cliRut + " , " + cliCod + " , '" + f1 + "', '" + f2 + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydSpGridCaPagosEntregaFisica);
                _PagosEntregaFisica = _Connect.QueryDataTable();
                _PagosEntregaFisica.TableName = "GridCaPagosEntregaFisica";

                if (_PagosEntregaFisica.Rows.Count.Equals(0))
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
                _PagosEntregaFisica = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _PagosEntregaFisica;
        }

        public static DataTable ResulDB_IniDia(string fechaProc, string fechaAnt, string fechaProx, int inicioDia)
        {
            String _QuerySpOpcionesGeneralFecha = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _InicioData;

            #region "Ejecuta Sp_OpcionesGeneralFecha"
            _QuerySpOpcionesGeneralFecha = "Sp_OpcionesGeneral_Fechas '" + fechaProc + "' ,'" + fechaAnt + "' ,'" + fechaProx + "'," + inicioDia;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpOpcionesGeneralFecha);
                _InicioData = _Connect.QueryDataTable();
                _InicioData.TableName = "OpcionesGeneral_Fecha";

                if (_InicioData.Rows.Count.Equals(0))
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
                _InicioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _InicioData;
        }

        public static DataTable CierreMesa(string fechaProc)
        {
            String _QuerySpOpcionesGeneralMesa = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _MesaData;

            #region "Ejecuta Sp_OpcionesGeneralMesa"
            _QuerySpOpcionesGeneralMesa = "Sp_OpcionesGeneral_Mesa '" + Convert.ToDateTime(fechaProc).ToString("yyyyMMdd") + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpOpcionesGeneralMesa);
                _MesaData = _Connect.QueryDataTable();
                _MesaData.TableName = "OpcionesGeneral_Mesa";

                if (_MesaData.Rows.Count.Equals(0))
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
                _MesaData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _MesaData;
        }

        public static DataTable ResulDB_FechaProxHabil(string fechaProx, string fechaRet)
        {
            String _QuerySpFechaProxima = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _InicioData;

            #region "Ejecuta Sp_Fecha_Proxima_Habil"
            _QuerySpFechaProxima = "SP_FECHA_PROXIMA_HABIL '" + fechaProx + "' ,'" + fechaRet + "'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpFechaProxima);
                _InicioData = _Connect.QueryDataTable();
                _InicioData.TableName = "FechaProxima";

                if (_InicioData.Rows.Count.Equals(0))
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
                _InicioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _InicioData;
        }

        public static DataTable ResulDB_FechaAnteriorHabil(string fechaProx, string fechaRet)
        {
            String _QuerySpFechaAnterior = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _InicioData;

            #region "Ejecuta Sp_Fecha_Anterior_Habil"
            _QuerySpFechaAnterior = "SP_FECHA_ANTERIOR_HABIL '" + fechaProx + "' ,'" + fechaRet + "'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpFechaAnterior);
                _InicioData = _Connect.QueryDataTable();
                _InicioData.TableName = "FechaProxima";

                if (_InicioData.Rows.Count.Equals(0))
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
                _InicioData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _InicioData;
        }

        //Prd_13090

        public static DataTable Trae_SDA(string NumFolio)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "SP_TREA_SOLICITUD_SDA"
            _Query = "SP_TREA_SOLICITUD_SDA '" + NumFolio + "'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
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
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable ConsultaSolicitud(string NumContrato,string FechaProceso)
        {
            String _QuerydConsultaDefiniciones = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _Definiciones;

            #region "Ejecuta Query Consulta Sda"

            _QuerydConsultaDefiniciones = @"DECLARE @EXISTE INT
                                            SET  @EXISTE = 0

                                            SELECT @EXISTE = 1 
                                            FROM TBL_SOLICITUD_SDA  
                                            WHERE FECHA_ACTIVACION = '" + Convert.ToDateTime(FechaProceso).ToString("yyyyMMdd") +
                                            "' AND  NUM_CONTRATO = " + NumContrato ;

            _QuerydConsultaDefiniciones += @" IF @EXISTE =1
                                             BEGIN

                                                SELECT	Ca.CaNumContrato
                                                ,		    Sda.NUM_SOLICITUD
                                                ,		    Sda.TIPO_ANTICIPO
                                                ,		    Sda.FECHA_ACTIVACION
                                                ,		    Ca.CaFechaContrato 
                                                ,		    Cad.CaFechaVcto
                                                ,		    Sda.MONTO_SOLICITUD
                                                FROM CaEncContrato Ca
				                                                INNER JOIN TBL_SOLICITUD_SDA Sda ON Ca.CaNumContrato = Sda.NUM_CONTRATO
				                                                INNER JOIN CaDetContrato Cad ON  ca.CaNumContrato  = Cad.CaNumContrato 
                                                WHERE 	Sda.FECHA_ACTIVACION = '" + Convert.ToDateTime(FechaProceso).ToString("yyyyMMdd") +
                                                "' AND		Ca.CaNumContrato = " + NumContrato + " END ";
	                                     

             _QuerydConsultaDefiniciones +=  @"ELSE
                                               BEGIN
	                                                SELECT		'CaNumContrato' = 0
	                                                ,		    'NUM_SOLICITUD' = 0
	                                                ,		    'TIPO_ANTICIPO' = ''
	                                                ,		    'FECHA_ACTIVACION'=''
	                                                ,		    'CaFechaContrato'='' 
	                                                ,		    'CCaFechaVcto'=''
	                                                ,		    'MONTO_SOLICITUD'='0'
                                                		
	                                            END ";
            
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerydConsultaDefiniciones);
                _Definiciones = _Connect.QueryDataTable();
                _Definiciones.TableName = "ConsultaSda";

                if (_Definiciones.Rows.Count.Equals(0))
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
                _Definiciones = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _Definiciones;
        }

        public static DataTable Trae_Operacion(string NumContrato)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "SP_CONSULTA_OPERACION"
            _Query = "SP_CONSULTA_OPERACION '" + NumContrato + "'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
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
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable Trae_EstructuraRelacionada()
        {
            String _QueryConsulta= "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _Resultado;

            #region "Ejecuta Query"

            _QueryConsulta = @"SELECT	ReId
                               ,		ReDescripcion 
                               FROM     TBL_ESTRUCTURAS_RELACION
                               ORDER BY CONVERT(INT,ReId)";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryConsulta);
                _Resultado = _Connect.QueryDataTable();
                _Resultado.TableName = "Consulta";

                if (_Resultado.Rows.Count.Equals(0))
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
                _Resultado = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _Resultado;
        }

        public static DataTable Trae_ForwardRelacionado(int _NumContrato)
        {
            String _QueryConsulta = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _Resultado;

            #region "Ejecuta Query"

            _QueryConsulta = @" SELECT ReNumeroLeasing, ReNumeroBien, ReCaNumContrato, ReCaNumFolio 
                                FROM TBL_RELACION_SAO_LEASING 
                                WHERE ReCaNumContrato =" + _NumContrato;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryConsulta);
                _Resultado = _Connect.QueryDataTable();
                _Resultado.TableName = "Consulta";

                if (_Resultado.Rows.Count.Equals(0))
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
                _Resultado = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _Resultado;
        }


        /// <summary>
        /// Consulta a la base de datos para saber si se permite el control en línea del artículo 84
        /// </summary>
        /// <returns>Resultado del query</returns>
        public static DataTable PermiteArticulo84() {
            String _QueryConsulta = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
            DataTable _Resultado;

            #region "Ejecuta Query"

            //Query hardcoded for the lulz
            _QueryConsulta = @"select tbtasa from BacParamSuda..TABLA_GENERAL_DETALLE
                               where nemo = 'OPT' and tbcateg = '8604'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryConsulta);
                _Resultado = _Connect.QueryDataTable();
                _Resultado.TableName = "Consulta";

                if (_Resultado.Rows.Count.Equals(0)) {
                    mStatus = enumStatus.NotFound;
                }
                else {
                    mStatus = enumStatus.Already;
                }
            }
            catch (Exception _Error) {
                _Resultado = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _Resultado;
        }

        /// <summary>
        /// Consulta a la base de datos para obtener la URL del WS Art84
        /// </summary>
        /// <returns>Url WS Art84 (DataTable) </returns>
        public static DataTable ObtieneURLArticulo84()
        {
            String _QueryConsulta = "";
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
            DataTable dtResult;

            #region "Ejecuta SP_CON_URL_WS"
            _QueryConsulta = "SP_CON_RUTA_WS 8605";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryConsulta);
                dtResult = _Connect.QueryDataTable();

                if (dtResult.Rows.Count.Equals(0))
                    mStatus = enumStatus.NotFound;
                else
                    mStatus = enumStatus.Already;
            }
            catch (Exception _Error)
            {
                dtResult = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return dtResult;
        }

        /// <summary>
        /// Consulta a la base de datos para obtener la URL del WS de Toma de Linea
        /// </summary>
        /// <returns>Url WS TomaLinea (DataTable) </returns>
        public static DataTable ObtieneURLTomaLinea()
        {
            String _QueryConsulta = "";
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
            DataTable dtResult;

            #region "Ejecuta SP_CON_URL_WS"
            _QueryConsulta = "SP_CON_RUTA_WS 9925";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryConsulta);
                dtResult = _Connect.QueryDataTable();

                if (dtResult.Rows.Count.Equals(0))
                    mStatus = enumStatus.NotFound;
                else
                    mStatus = enumStatus.Already;
            }
            catch (Exception _Error)
            {
                dtResult = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return dtResult;
        }


        public static DataTable TraeDolarContable()
        {
            String _QueryConsulta = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BacParamSuda");
            DataTable _Resultado;

            #region "Ejecuta Query"

            //Query hardcoded for the lulz
            _QueryConsulta = @"SELECT	*
                               FROM VALOR_MONEDA_CONTABLE  WHERE Fecha = (SELECT Convert(varchar(10),acfecante,112) FROM BacTraderSuda.dbo.MDAC) AND Codigo_Moneda  = 994";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryConsulta);
                _Resultado = _Connect.QueryDataTable();
                _Resultado.TableName = "Consulta";

                if (_Resultado.Rows.Count.Equals(0))
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
                _Resultado = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            return _Resultado;
        }
    }
}