using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace clsCentralizacionProcesos
{
    class clsBonex
    {
        /*clases generales*/
        public clsDb oDB = new clsDb();
        public clsLog oLog = new clsLog();
        public clsUtil oUtil = new clsUtil();
        bool bProceso = false;

        private string uDL_PARAMETROS;

        /*control de excepciones*/
        private string _MSGEX;
        private string _MSGEXCTR;
        private string _TIPOMSEX;
        private int _NUMEX;
        private string MENSAJELOG;

        /*datos generales*/
        public DataTable dtGeneral;


        DateTime dFechaProceso;
        DateTime dFechaProxima;
        DateTime dFechaAnterior;
        DateTime gsBAC_Fecp;
        int Entidad_Codigo;

        static string sOrigen = "clsCentralizacionProcesos.clsBonex";

        public string UDL_PARAMETROS { get => uDL_PARAMETROS; set => uDL_PARAMETROS = value; }
        public string MSGEX { get => _MSGEX; set => _MSGEX = value; }
        public string MSGEXCTR { get => _MSGEXCTR; set => _MSGEXCTR = value; }
        public string TIPOMSEX { get => _TIPOMSEX; set => _TIPOMSEX = value; }
        public int NUMEX { get => _NUMEX; set => _NUMEX = value; }
        public string MENSAJELOG1 { get => MENSAJELOG; set => MENSAJELOG = value; }

        public bool ProcesoInicioDia()
        {
            try
            {
                MSGEX = "";
                NUMEX = 0;

                oDB.PATHLOG = oLog.PATHLOG;

                oLog.GeneraLog(sOrigen, "Inicio Conexion");
                bProceso = oDB.AbrirConexion();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio Transaccion");
                bProceso = oDB.IniciarTran();
                if (!bProceso) { return false; }

                /*obtener datos generales*/
                oUtil.oDB.DbUDL = uDL_PARAMETROS;

                oLog.GeneraLog(sOrigen, "Rescate Valores Generales");
                bProceso = DatosGenerales();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio proceso FuncInicioDia");
                bProceso = FuncInicioDia();
                if (!bProceso) { return false; }
                
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ProcesoInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            finally
            {
                if (bProceso)
                {
                    oLog.GeneraLog(sOrigen, "Proceso ProcesarInicioDia Finalizado con exito");
                    oLog.GeneraLog(sOrigen, "Fin Transaccion");
                    bProceso = oDB.ConfirmarTran();

                    oLog.GeneraLog(sOrigen, "Inicio CerrarConexion");
                    bProceso = oDB.CerrarConexion();
                }
                else
                {
                    NUMEX = -1;// ex.Number;
                    oLog.GeneraLog(sOrigen, "Proceso cancelado por errores", NUMEX);
                    oLog.GeneraLog(sOrigen, "Transaccion Cancelada", NUMEX);
                    bProceso = oDB.CancelarTran();

                    oLog.GeneraLog(sOrigen, "Inicio CerrarConexion");
                    bProceso = oDB.CerrarConexion();
                }
            }
        }

        bool FuncInicioDia()
        {
            try
            {
                oLog.GeneraLog(sOrigen, "Inicio proceso BacChkFechas");
                bProceso = BacChkFechas();
                if (!bProceso) { return false; }


                // oDB.IniciarTran();

                oLog.GeneraLog(sOrigen, "Inicio proceso GeneraInicioAC");
                bProceso = GeneraInicioAC();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncActualizaCartera");
                bProceso = FuncActualizaCartera();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncProcesaValutas");
                bProceso = FuncProcesaValutas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncActualizaDolarFinMes");
                bProceso = FuncActualizaDolarFinMes();
                if (!bProceso) { return false; }

                //oDB.ConfirmarTran();

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool FuncActualizaDolarFinMes()
        {
            try
            {
                if (dFechaProceso.Month != dFechaAnterior.Month)
                {
                    oDB.Execute("sp_ActDolarFinMes", new object[] { new SqlParameter("@cfecha", dFechaAnterior.ToString("yyyyMMdd")) });

                    if (oDB.NUMEX != 0)
                    {
                        return false;
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncActualizaDolarFinMes";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool FuncProcesaValutas()
        {
            try
            {
                oDB.Execute("SVA_IND_ACT_VLU");

                if (oDB.NUMEX == 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncProcesaValutas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool FuncActualizaCartera()
        {
            try
            {
                oDB.Execute("SVA_IND_ACT_CAR", new object[] { new SqlParameter("@Fecha", dFechaAnterior.ToString("yyyyMMdd")) });
                if (oDB.NUMEX == 0)
                {
                    oDB.Execute("BacTraderSuda.dbo.SP_ACT_CARTERA_LIBRE_TRADING", new object[] { new SqlParameter("@IdSistema", "BEX") }); //revisar version erronea
                    if (oDB.NUMEX == 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }

                
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncActualizaCartera";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool GeneraInicioAC()
        {
            try
            {
                oDB.Execute("SVA_IND_GRB_PAT", new object[] { new SqlParameter("@cfecproc", dFechaProceso.ToString("yyyyMMdd"))
                                                                    ,new SqlParameter("@cfecprox", dFechaProxima.ToString("yyyyMMdd"))
                                                                    });
                if (oDB.NUMEX == 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar GeneraInicioAC";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool BacChkFechas()
        {
            try
            {
                if (!BacChkFecpro())
                {
                    return false;
                }

                if (!BacChkFecprx())
                {
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacChkFechas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool BacChkFecpro()
        {
            try
            {
                DateTime fecha;

                if (oUtil.BacEsHabil(dFechaProceso, "0006"))
                {
                    return true;
                }
                else
                {
                    fecha = dFechaProceso.AddDays(1);
                    if (dFechaProceso.Month == fecha.Month)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacChkFecpro";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool BacChkFecprx()
        {
            try
            {
                if ((dFechaProxima - dFechaProceso).Days <= 0)
                {
                    return false;
                }

                if (oUtil.BacEsHabil(dFechaProxima, "00006"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacChkFecprx";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        
        bool DatosGenerales()
        {
            try
            {
                oDB.Execute("SVC_IND_LEE_PAR");
                dtGeneral = oDB.dtDatos;

                dFechaAnterior = DateTime.Parse(dtGeneral.Rows[0][0].ToString());
                dFechaProceso = DateTime.Parse(dtGeneral.Rows[0][1].ToString());
                dFechaProxima = DateTime.Parse(dtGeneral.Rows[0][1].ToString());
                
                dFechaProxima = oUtil.BacProxHabil(dFechaProxima, "00006");

                if (oDB.NUMEX == 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar DatosGenerales";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

    }
}
