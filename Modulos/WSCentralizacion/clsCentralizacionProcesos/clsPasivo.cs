using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace clsCentralizacionProcesos
{
    class clsPasivo
    {
        /*clases generales*/
        public clsDb oDB = new clsDb();
        public clsLog oLog = new clsLog();
        public clsUtil oUtil = new clsUtil();
        bool bProceso = false;
        string GLB_Sistema = "PSV";
        private string uDL_PARAMETROS;

        /*control de excepciones*/
        private string _MSGEX;
        private string _MSGEXCTR;
        private string _TIPOMSEX;
        private int _NUMEX;
        private string MENSAJELOG;



        /*datos generales*/
        public DataTable dtGeneral;
        public DataTable dtMonedas;

        DateTime dFechaProceso;
        DateTime dFechaProxima;
        DateTime gsBAC_Fecp;
        int Entidad_Codigo;
        static string sOrigen = "clsCentralizacionProcesos.clsPasivo";

        DateTime mvarFechaProceso;
        DateTime mvarFechaProximoProceso;
        DateTime mvarFechaAnterior;
        DateTime mvarFechaCierreMesAnterior;
        DateTime mvarFechaCierreMesNuevo;
        DateTime GLB_Fecha_FinMes;

        //variables cierre
        DateTime GLB_Fecha_Anterior;
        DateTime GLB_Fecha_Proceso;
        string GLB_Cliente_Bac;
        DateTime GLB_Fecha_Proxima;
        double GLB_Rut_Cliente;
        string GLB_Dig_Cliente;
        double GLB_Rut_Comision;
        double GLB_Precio_Comision;
        double GLB_IVA;
        double GLB_UF;
        double GLB_DO;
        //'GLB_Fecha_FinMes = .FechaCierreMesNuevo
        double GLB_Rut_Cartera;
        string  GLB_Dv_Cartera;
        string GLB_Nombre_Cartera;
        int GLB_Inicio_Dia;
        int GLB_Fin_Dia;
        int GLB_Devengamiento;
        int GLB_Contabilidad;

        bool mvarFinMesEspecial;


        public string UDL_PARAMETROS { get => uDL_PARAMETROS; set => uDL_PARAMETROS = value; }
        public string MSGEX { get => _MSGEX; set => _MSGEX = value; }
        public string MSGEXCTR { get => _MSGEXCTR; set => _MSGEXCTR = value; }
        public string TIPOMSEX { get => _TIPOMSEX; set => _TIPOMSEX = value; }
        public int NUMEX { get => _NUMEX; set => _NUMEX = value; }
        public string MENSAJELOG1 { get => MENSAJELOG; set => MENSAJELOG = value; }



        public bool ProcesarInicioDia()
        {
            try
            {
                MSGEX = "";
                NUMEX = 0;

                oDB.PATHLOG = oLog.PATHLOG;

                oLog.GeneraLog(sOrigen, "Inicio ProcesarInicioDia");
             
                oLog.GeneraLog(sOrigen, "Inicio Conexion");
                bProceso = oDB.AbrirConexion();

                oLog.GeneraLog(sOrigen, "Inicio Transaccion");
                bProceso = oDB.IniciarTran();

                /*obtener datos generales*/
                oUtil.oDB.DbUDL = uDL_PARAMETROS;

                //eventos load
                oLog.GeneraLog(sOrigen, "Inicio proceso Carga_Parametros");
                bProceso = Carga_Parametros();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso Carga_ParametrosInicio");
                bProceso = Carga_ParametrosInicio();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso Iniciar_Dia");
                bProceso = Iniciar_Dia();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio proceso CargarDatos_Grilla");
                bProceso = CargarDatos_Grilla();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso ProcesarInicio");
                bProceso = ProcesarInicio();
                if (!bProceso) { return false; }

                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ProcesarInicioDia";
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

        
        public bool Carga_Parametros()
        {
            try
            {
                oDB.Execute("sp_parametros_sistema");

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtGeneral = oDB.dtDatos;

                GLB_Fecha_Anterior = DateTime.Parse(dtGeneral.Rows[0]["fecante"].ToString());// Datos(16)
                GLB_Fecha_Proceso = DateTime.Parse(dtGeneral.Rows[0]["fecproc"].ToString());//Datos(1)
                GLB_Cliente_Bac = dtGeneral.Rows[0]["Nombre_entidad"].ToString();//Datos(2)
                GLB_Fecha_Proxima = DateTime.Parse(dtGeneral.Rows[0]["fecprox"].ToString());//Datos(3)
                GLB_Rut_Cliente = double.Parse(dtGeneral.Rows[0]["Rut_entidad"].ToString());//Datos(4)
                GLB_Dig_Cliente = dtGeneral.Rows[0]["Digito_entidad"].ToString();//Datos(5)
                GLB_Rut_Comision = double.Parse(dtGeneral.Rows[0]["Column1"].ToString());//Datos(6)
                GLB_Precio_Comision = double.Parse(dtGeneral.Rows[0]["Column2"].ToString());// Datos(7)
                GLB_IVA = double.Parse(dtGeneral.Rows[0]["Column3"].ToString());//Datos(8)
                GLB_UF = double.Parse(dtGeneral.Rows[0]["valuf"].ToString());//Datos(12)
                GLB_DO = double.Parse(dtGeneral.Rows[0]["valdol"].ToString());//Datos(13)
                //'GLB_Fecha_FinMes = .FechaCierreMesNuevo
                GLB_Rut_Cartera = double.Parse(dtGeneral.Rows[0]["rcrut"].ToString());//Datos(9)
                GLB_Dv_Cartera = dtGeneral.Rows[0]["rcdv"].ToString();//Datos(10)
                GLB_Nombre_Cartera = dtGeneral.Rows[0]["rcnombre"].ToString();//Datos(11)
                GLB_Inicio_Dia = int.Parse(dtGeneral.Rows[0]["Inicio_Dia"].ToString());//Datos(18)
                GLB_Fin_Dia = int.Parse(dtGeneral.Rows[0]["Fin_Dia"].ToString());//Datos(19)
                GLB_Devengamiento = int.Parse(dtGeneral.Rows[0]["Devengamiento"].ToString());//Datos(20)
                GLB_Contabilidad = int.Parse(dtGeneral.Rows[0]["Contabilidad"].ToString());// Datos(21)


                //            mvarFechaCierreMesNuevo = DateAdd("M", 1, GLB_Fecha_Proceso)
                //'            mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", GLB_Fecha_Proceso) * -1, mvarFechaCierreMesNuevo)
                //            mvarFechaCierreMesNuevo = DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))
                mvarFechaCierreMesNuevo = GLB_Fecha_Proceso.AddMonths(1);// DateAdd("M", 1, GLB_Fecha_Proceso)
                //'mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", GLB_Fecha_Proceso) * -1, mvarFechaCierreMesNuevo)
                mvarFechaCierreMesNuevo = DateTime.Parse("01-" + GLB_Fecha_Proceso.AddMonths(1).Month.ToString() + "-" + GLB_Fecha_Proceso.AddMonths(1).Year.ToString()).AddDays(-1);//DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))

                GLB_Fecha_FinMes = mvarFechaCierreMesNuevo;
                //'GLB_Fecha_FinMes = Datos(23)


                if (GLB_Fecha_Proceso<GLB_Fecha_FinMes & GLB_Fecha_Proxima > GLB_Fecha_FinMes )
                {
                    mvarFinMesEspecial = true;
                }
                else
                {
                    mvarFinMesEspecial = false;
                }

                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Carga_Parametros";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

       
        public bool Carga_ParametrosInicio()
        {
            try
            {
                oDB.Execute("sp_parametros_sistema");

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtGeneral = oDB.dtDatos;

                mvarFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fecproc"].ToString());
                mvarFechaProximoProceso = DateTime.Parse(dtGeneral.Rows[0]["fecprox"].ToString()); ;// oUtil.BacProxHabil(DateTime.Parse(dtGeneral.Rows[0]["acFecPrx"].ToString()), "00006");
                mvarFechaAnterior = DateTime.Parse(dtGeneral.Rows[0]["fecante"].ToString());

                mvarFechaCierreMesAnterior = mvarFechaProceso.AddDays(mvarFechaProceso.Day * -1);//DateAdd("D", DatePart("D", mvarFechaProceso) * -1, mvarFechaProceso)
                mvarFechaCierreMesNuevo = mvarFechaProceso.AddMonths(1);//DateAdd("M", 1, mvarFechaProceso)
                mvarFechaCierreMesNuevo = DateTime.Parse("01-" + GLB_Fecha_Proceso.AddMonths(1).Month.ToString() + "-" + GLB_Fecha_Proceso.AddMonths(1).Year.ToString()).AddDays(-1);//DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))));//DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))

                GLB_Fecha_FinMes = mvarFechaCierreMesNuevo;

                if (mvarFechaProceso < mvarFechaCierreMesNuevo & mvarFechaProximoProceso > mvarFechaCierreMesNuevo)
                {
                    mvarFinMesEspecial = true;
                }else
                {
                    mvarFinMesEspecial = false;
                }

                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Carga_ParametrosInicio";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool Iniciar_Dia()
        {
            try
            {
                mvarFechaAnterior = GLB_Fecha_Proceso;
                mvarFechaProceso = GLB_Fecha_Proxima;

                oDB.Execute("SP_CON_FECHA_FERIADO", new object[] {    new SqlParameter("@inpais", 1),
                                                                    new SqlParameter("@inplaza", 22),
                                                                    new SqlParameter("@idfecha", mvarFechaProceso),
                                                                    new SqlParameter("@inbuscar", 2) 
                                                                });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtGeneral = oDB.dtDatos;

                mvarFechaProximoProceso = DateTime.Parse(dtGeneral.Rows[0][0].ToString());// Datos(16)
              
                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Iniciar_Dia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool CargarDatos_Grilla()
        {
            try
            {
                mvarFechaAnterior = GLB_Fecha_Proceso;
                mvarFechaProceso = GLB_Fecha_Proxima;

                oDB.Execute("SP_CON_CARGA_VALORES_INICIO_DIA", new object[] {   new SqlParameter("@dfecpro", mvarFechaProceso.ToString("yyyyMMdd")),
                                                                                new SqlParameter("@dfecprox", mvarFechaProximoProceso.ToString("yyyyMMdd"))
                                                                            });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtMonedas = oDB.dtDatos;

                //mvarFechaProximoProceso = DateTime.Parse(dtGeneral.Rows[0][0].ToString());// Datos(16)

                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar CargarDatos_Grilla";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool ProcesarInicio()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_CON_ESTADO_SWITCH", new object[] {   new SqlParameter("@ssistema", "PSV") });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                foreach (DataRow row in dtDatos.Rows)
                {
                    if (row[4].ToString().Trim() == "0" & row[5].ToString().Trim() == "INICIO")
                    {
                        if (FUNC_INICIO_PSV())
                        {
                            bProceso = FUNC_GRABAR_VALORES();
                            if (!bProceso) { return false; }

                            //bProceso = Carga_Parametros();
                            //if (!bProceso) { return false; }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        if (row[4].ToString().Trim() == "1" & row[5].ToString().Trim() == "INICIO")
                        {
                            oLog.GeneraLog(sOrigen, "Inicio dia ya realizado");
                            return false;
                        }
                    }
                }
                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ProcesarInicio";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }


        public bool FUNC_INICIO_PSV()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = oDB.dtDatos;
                DateTime id_fecpro;
                DateTime id_fecprx;
                bool bRetorno;

                id_fecpro = GLB_Fecha_Proceso;

                //'mvarFechaCierreMesAnterior = DateAdd("D", DatePart("D", GLB_Fecha_Proceso) * -1, GLB_Fecha_Proceso)
                mvarFechaCierreMesAnterior = GLB_Fecha_Proxima.AddDays(GLB_Fecha_Proxima.Day * -1) ;// DateAdd("D", DatePart("D", GLB_Fecha_Proxima) * -1, GLB_Fecha_Proxima)
                mvarFechaCierreMesNuevo = GLB_Fecha_Proxima.AddMonths(1);//DateAdd("M", 1, GLB_Fecha_Proxima)
                //'mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", mvarFechaCierreMesNuevo) * -1, mvarFechaCierreMesNuevo)
                mvarFechaCierreMesNuevo = DateTime.Parse("01-" + GLB_Fecha_Proceso.AddMonths(1).Month.ToString() + "-" + GLB_Fecha_Proceso.AddMonths(1).Year.ToString()).AddDays(-1);//DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))));//DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))

                GLB_Fecha_FinMes = mvarFechaCierreMesNuevo;

             
                if (mvarFinMesEspecial)
                {
                    //'Parametros para realizar inicio de día con fin de mes especial
                    //GLB_Envia = Array()
                    //PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaCierreMesAnterior, "yyyymmdd")
                    //PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaProceso, "yyyymmdd")
                    id_fecpro= mvarFechaCierreMesAnterior;
                    id_fecprx= mvarFechaProceso;

                }
                else
                {
                    //'Respaldo en día normales, ya que en fin de mes especial, se respalda en el devengo
                    oDB.Execute("SP_RESPALDO_PASIVO", new object[] { new SqlParameter("@idfecha_anterior", id_fecpro) });

                    if (oDB.NUMEX != 0)
                    {
                        //"Problemas al realizar respaldo de cartera"
                        return false;
                    }


                    //'Parametros para realizar inicio de día de manera normal
                    //GLB_Envia = Array()
                    //PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaAnterior, "yyyymmdd")
                    //PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaProceso, "yyyymmdd")
                    id_fecpro = mvarFechaAnterior;
                    id_fecprx = mvarFechaProceso;
                }

                oDB.Execute("SP_ACT_INICIO_DIA_PSV", new object[] { new SqlParameter("@id_fecpro", id_fecpro)
                                                                   ,new SqlParameter("@id_fecprx", id_fecprx)});
                if (oDB.NUMEX != 0)
                {
                    //"Problemas al realizar respaldo de cartera"
                    return false;
                }

                //MsgBox "Proceso de Inicio de Día éxitoso", vbInformation
                bRetorno = Grabar_Estado("PSV", "INICIO", "1", false);
                if (!bRetorno) { return false; }

                bRetorno = Grabar_Estado("PSV", "CONTABILIDAD", "0", false);
                if (!bRetorno) { return false; }

                bRetorno = Grabar_Estado("PSV", "DEVENGAMIENTO", "0", false);
                if (!bRetorno) { return false; }

                bRetorno = Grabar_Estado("PSV", "FIN", "0", false);
                if (!bRetorno) { return false; }

                bRetorno = Grabar_Estado("PSV", "MESA", "0", false);
                if (!bRetorno) { return false; }


                return true;
            }

            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FUNC_INICIO_PSV";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool FUNC_GRABAR_VALORES()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_GRA_INICIO_DIA", new object[] { new SqlParameter("@dfecpro", mvarFechaProceso.ToString("yyyyMMdd")),
                                                            new SqlParameter("@dfecprox", mvarFechaProximoProceso.ToString("yyyyMMdd"))
                                                                            });
                if (oDB.NUMEX != 0)
                {
                    //"Problemas al realizar respaldo de cartera"
                    return false;
                }

                dtDatos = oDB.dtDatos;

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FUNC_GRABAR_VALORES";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
       
  
        public bool Grabar_Estado(string sSistema , string sCodigo , string sEstado , bool bMensaje)
        {
            bool bReturn=false;

            bReturn = Grabar_Status(sCodigo, sEstado, bMensaje);

            return bReturn;
        }

        public bool Grabar_Status(string sCodigo , string sEstado , bool bMensaje )
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_GRA_ESTADO_SWITCH", new object[] {      new SqlParameter("@icsistema", GLB_Sistema)
                                                                   ,new SqlParameter("@iccodigo", sCodigo)
                                                                   ,new SqlParameter("@icestado", bMensaje)});
                if (oDB.NUMEX != 0)
                {
                    //"Problemas al realizar respaldo de cartera"
                    return false;
                }

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0].ItemArray[0].ToString() != "OK")
                {
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Grabar_Status";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
       

    }

}
