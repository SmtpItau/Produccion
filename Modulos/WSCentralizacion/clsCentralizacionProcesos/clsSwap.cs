using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace clsCentralizacionProcesos
{
    class clsSwap
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
        public DataTable dtValorMoneda;

        static string sOrigen = "clsCentralizacionProcesos.clsSwap";

        DateTime dFechaProceso;
        DateTime dFechaProxima;
        DateTime gsBAC_Fecp;
        int Entidad_Codigo;
        float DolarObs;
        float ValorUF;

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

                /*obtener datos generales*/
                oUtil.oDB.DbUDL = uDL_PARAMETROS;

                oLog.GeneraLog(sOrigen, "Inicio proceso DatosGenerales");
                bProceso = DatosGenerales();
                if (!bProceso) { return false; }

                dFechaProceso = oUtil.BacProxHabil(dFechaProceso, "006");
                dFechaProxima = oUtil.BacProxHabil(dFechaProceso, "006");

                oLog.GeneraLog(sOrigen, "Inicio proceso GenerarValoresMonedas");
                bProceso = GenerarValoresMonedas();
                if (!bProceso) { return false; }


                //oDB.IniciarTran();
                oLog.GeneraLog(sOrigen, "Inicio proceso FuncGenerarInicioDia");
                bProceso = FuncGenerarInicioDia();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso GrabarValoresMonedas");
                bProceso = GrabarValoresMonedas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncGeneradorICP");
                bProceso = FuncGeneradorICP();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncLimpiaTablaSim");
                bProceso = FuncLimpiaTablaSim();
                if (!bProceso) { return false; }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar inicio dia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            finally
            {
                if (bProceso)
                {
                    oLog.GeneraLog(sOrigen, "Proceso ProcesoInicioDia Finalizado con exito");
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

        bool FuncLimpiaTablaSim()
        {
            try
            {
                DataTable datos;
                oDB.Execute("SP_RESET_TABLAS_SIM");
                datos = oDB.dtDatos;

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
                MSGEXCTR = "Error al ejecutar FuncLimpiaTablaSim";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool FuncGeneradorICP()
        {
            try
            {
                DataTable datos;
                oDB.Execute("BacParamSuda..SP_GENERACION_AUTOMATICA_ICP");
                datos = oDB.dtDatos;

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
                MSGEXCTR = "Error al ejecutar FuncGeneradorICP";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool GrabarValoresMonedas()
        {
            try
            {
                foreach (DataRow row in dtValorMoneda.Rows)
                {
                    oDB.Execute("SP_GRABA_VALORESMONEDA", new object[] {new SqlParameter("@xCodigo", row[2])
                                                                    ,new SqlParameter("@xFecha", dFechaProceso.ToString("yyyyMMdd"))
                                                                    ,new SqlParameter("@xValor", row[1])
                                                                    });

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
                MSGEXCTR = "Error al ejecutar GrabarValoresMonedas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool FuncGenerarInicioDia()
        {
            try
            {
                DataTable datos;
                string sCmd;
                string retorno;
                string texto;

                sCmd = "declare @retorno numeric exec @retorno =" + "SP_INICIODIA " + "'"
                        + dFechaProceso.ToString("yyyyMMdd") + "'" + ","
                        + "'" + dFechaProxima.ToString("yyyyMMdd") + "'"
                        + " select @retorno";

                oDB.Execute(sCmd);

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                datos = oDB.dtDatos;

                retorno = datos.Rows[0][0].ToString();

                switch (retorno)
                {
                    case "- 100": texto = "NO pudo actualizar estado de flujos"; break;
                    case "- 101": texto = "NO pudo cargar registros en Cartera Historica"; break;
                    case "- 102": texto = "NO pudo cargar registros en Archivo de Log"; break;
                    case "- 103": texto = "NO pudo rebajar los Flujos Vencidos"; break;
                    case "- 104": texto = "NO pudo Limpiar archivo de Movimientos del Día"; break;
                    case "- 105": texto = "NO pudo Actualizar archivo de Parámetros"; break;
                    case "- 110": texto = "NO pudo Liberar las operaciones con Garantías"; break;
                    default: texto = ""; break;
                }

                if (texto.ToString() == "")
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
                MSGEXCTR = "Error al ejecutar FuncGenerarInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool GenerarValoresMonedas()
        {
            try
            {
                oDB.Execute("SP_BUSCA_VALORES_MERCADO", new object[] {  new SqlParameter("@cSistema", "PCS")
                                                                   ,new SqlParameter("@FechaProc", dFechaProceso)
                                                                });
                dtValorMoneda = oDB.dtDatos;

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
                MSGEXCTR = "Error al ejecutar GenerarValoresMonedas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool DatosGenerales()
        {
            try
            {
                DataTable datos;

                oDB.Execute("SP_DATOSGENERALES");
               
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtGeneral = oDB.dtDatos;

                dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fechaproc"].ToString());

                datos = oUtil.LeerValorMoneda(994, dFechaProceso);
                DolarObs = float.Parse(datos.Rows[0]["vmvalor"].ToString());

                datos = oUtil.LeerValorMoneda(998, dFechaProceso);
                ValorUF = float.Parse(datos.Rows[0]["vmvalor"].ToString());

                return true;
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
