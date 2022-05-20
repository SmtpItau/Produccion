using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace clsCentralizacionProcesos
{
    class clsSao
    {
        /*clases generales*/
        public clsDb oDB = new clsDb();
        public clsLog oLog = new clsLog();
        public clsUtil oUtil = new clsUtil();
        bool bProceso = false;

        /*control de excepciones*/
        private string _MSGEX;
        private string _MSGEXCTR;
        private string _TIPOMSEX;
        private int _NUMEX;
        private string MENSAJELOG;

        private string uDL_PARAMETROS;


        /*datos generales*/
        public DataTable dtGeneral;

        static string sOrigen = "clsCentralizacionProcesos.clsSao";

        DateTime dFechaProceso;
        DateTime dFechaProxima;
        DateTime dFechaAnterior;
        int swIniciodia=0;
        int swFindia = 0;
        int swCierredia = 0;
        string status="";


        DateTime gsBAC_Fecp;
        int Entidad_Codigo;

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

                oLog.GeneraLog(sOrigen, "Inicio ProcesarInicioDia");
                oLog.GeneraLog(sOrigen, "Inicio Conexion");

                bProceso = oDB.AbrirConexion();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio Transaccion");
                bProceso = oDB.IniciarTran();
                if (!bProceso) { return false; }

                /*obtener datos generales*/
                oUtil.oDB.DbUDL = uDL_PARAMETROS;

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncLeerFechas");
                bProceso = FuncLeerFechas();
                if (!bProceso) { return false; }

                if (status != "OK")
                {
                    return false;
                }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncCambiaFechas");
                bProceso = FuncCambiaFechas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncGrabaInicioDia");
                bProceso = FuncGrabaInicioDia();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncPreparaAccionSDA");
                bProceso = FuncPreparaAccionSDA();
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

        bool FuncPreparaAccionSDA()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_PREPARA_ACCION_CON_SDA", new object[] { new SqlParameter("@FECHA_PROCESO", dFechaProceso.ToString("yyyyMMdd"))
                                                        ,new SqlParameter("@USUARIO", "")
                                                        });

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0]["Resultado"].ToString() == "SI")
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
                MSGEXCTR = "Error al ejecutar FuncPreparaAccionSDA";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }
        bool FuncGrabaInicioDia()
        {
            try
            {
                DataTable dtDatos;

                //oDB.IniciarTran();

                oDB.Execute("SP_INI_DIA_OPC", new object[] { new SqlParameter("@FechaApertura", dFechaProceso.ToString("yyyyMMdd"))
                                                        ,new SqlParameter("@FechaSigApertura", dFechaProxima.ToString("yyyyMMdd"))
                                                        ,new SqlParameter("@Usuario", "")
                                                        });

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0]["Mensaje"].ToString() == "Dia Abierto OK")
                {
                    return true;
                }
                else
                {
                    return false;
                }

                //oDB.CancelarTran();
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncGrabaInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool FuncCambiaFechas()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_FECHA_PROXIMA_HABIL", new object[] { new SqlParameter("@dFecha", dFechaProxima.ToString("yyyyMMdd"))
                                                                ,new SqlParameter("@dFecRet", dFechaProxima.ToString("yyyyMMdd"))
                                                                });

                if (oDB.NUMEX == 0)
                {
                    dtDatos = oDB.dtDatos;

                    dFechaAnterior = dFechaProceso;
                    dFechaProceso = dFechaProxima;
                    dFechaProxima = DateTime.Parse(dtDatos.Rows[0]["FechaProx"].ToString());

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
                MSGEXCTR = "Error al ejecutar FuncCambiaFechas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool FuncLeerFechas()
        {
            try
            {
                SqlParameter fechaproc = new SqlParameter("@fechaproc", SqlDbType.DateTime); fechaproc.Direction = ParameterDirection.Output;
                SqlParameter fechaant = new SqlParameter("@fechaant", SqlDbType.DateTime); fechaant.Direction = ParameterDirection.Output;
                SqlParameter fechaprox = new SqlParameter("@fechaprox", SqlDbType.DateTime); fechaprox.Direction = ParameterDirection.Output;
                SqlParameter iniciodia = new SqlParameter("@iniciodia", SqlDbType.Int); iniciodia.Direction = ParameterDirection.Output;

                oDB.Execute("Sp_OpcionesGeneral_Fechas", new object[] { fechaproc,fechaant,fechaprox,iniciodia
                                                                    });

                //oDB.Execute("Sp_OpcionesGeneral_Fechas", new object[] { new SqlParameter("@fechaproc", SqlDbType.DateTime).Direction=ParameterDirection.Output
                //                                                        ,new SqlParameter("@fechaant", SqlDbType.DateTime).Direction=ParameterDirection.Output
                //                                                        ,new SqlParameter("@fechaprox", SqlDbType.DateTime).Direction=ParameterDirection.Output
                //                                                        ,new SqlParameter("@iniciodia", SqlDbType.Int).Direction=ParameterDirection.Output
                //                                                        });

                if (oDB.NUMEX == 0)
                {
                    dtGeneral = oDB.dtDatos;

                    dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fechaproc"].ToString());
                    dFechaAnterior = DateTime.Parse(dtGeneral.Rows[0]["fechaant"].ToString());
                    dFechaProxima = DateTime.Parse(dtGeneral.Rows[0]["fechaprox"].ToString());
                    swIniciodia = int.Parse(dtGeneral.Rows[0]["iniciodia"].ToString());

                    swFindia = int.Parse(dtGeneral.Rows[0]["iniciodia"].ToString());
                    swCierredia = int.Parse(dtGeneral.Rows[0]["iniciodia"].ToString());
                    status = dtGeneral.Rows[0]["status"].ToString();

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
                MSGEXCTR = "Error al ejecutar FuncLeerFechas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
    }
}
