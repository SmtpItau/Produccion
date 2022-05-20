using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace clsCentralizacionProcesos
{
    class clsForward
    {
        /*clases generales*/
        public clsDb oDB = new clsDb();
        public clsLog oLog = new clsLog();
        public clsUtil oUtil = new clsUtil();

        /*datos generales*/
        public DataTable dtGeneral;
        public DataTable dtMonedas;

        DateTime dFechaProceso;
        DateTime dFechaProxima;
        int Entidad_Codigo;
        Boolean bProceso = false;

        private string uDL_PARAMETROS;

        /*control de excepciones*/
        private string _MSGEX;
        private string _MSGEXCTR;
        private string _TIPOMSEX;
        private int _NUMEX;
        private string MENSAJELOG;

        static string sOrigen = "clsCentralizacionProcesos.clsForward";

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
                oDB.PATHLOG = oLog.PATHLOG;

                oLog.GeneraLog(sOrigen, "Inicio ProcesarInicioDia");//aqui

                oLog.GeneraLog(sOrigen, "Inicio ProcesarInicioDia");

                oLog.GeneraLog(sOrigen, "Inicio Conexion");
                bProceso = oDB.AbrirConexion();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio Transaccion");
                bProceso = oDB.IniciarTran();
                if (!bProceso) { return false; }

                /*obtener datos generales*/
                oLog.GeneraLog(sOrigen, "Rescate Valores Generales");
                bProceso = DatosGenerales();
                if (!bProceso) { return false; }


                oUtil.oDB.DbUDL = UDL_PARAMETROS;

                oLog.GeneraLog(sOrigen, "Inicio CargarInicioDia");
                bProceso = CargarInicioDia();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio LeerValorMoneda");
                oUtil.LeerValorMoneda(994, dFechaProceso);
                if (!bProceso) { return false; }

                if (dtGeneral.Rows[0]["sw_final"].ToString() == "1")
                {
                    dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fecprox"].ToString());
                }
                else
                {
                    dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fecproc"].ToString());
                }

                dFechaProxima = oUtil.BacProxHabil(dFechaProceso, "00006");

                oLog.GeneraLog(sOrigen, "Inicio FuncGrabarInicioDia");
                bProceso = FuncGrabarInicioDia();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio Devengamiento");
                bProceso = Devengamiento(1);
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio FuncTraspasoOperaciones");
                bProceso = FuncTraspasoOperaciones();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio FuncCargaVencimientos");
                bProceso = FuncCargaVencimientos();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Inicio VenceOPTicket");
                bProceso = VenceOPTicket();
                if (!bProceso) { return false; }


                oLog.GeneraLog(sOrigen, "Proceso ProcesarInicioDia Finalizado con exito");

                return true;
            }
            catch (Exception ex)
            {
                oDB.CancelarTran();
                oDB.CerrarConexion();

                MSGEX = ex.Message;
                MSGEXCTR = "Error proceso ProcesarInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);

                return false;
            }
            finally
            {
                if (bProceso)
                {
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

        bool VenceOPTicket()
        {
            try
            {
                oDB.Execute("SP_VENCEOPETKINMESA", new object[] { new SqlParameter("@fecha_proceso", dFechaProceso.ToString("yyyyMMdd")) });

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
                MSGEXCTR = "Error al ejecutar VenceOPTicket";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        Boolean FuncCargaVencimientos()
        {
            try
            {
                oDB.Execute("SP_CARGAVENCIMIENTOS", new object[] { new SqlParameter("@fecha_proceso", dFechaProceso.ToString("yyyyMMdd")) });

                //LiberaOpeGarantias()
                //Lineas_Anular() 
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
                MSGEXCTR = "Error al ejecutar FuncCargaVencimientos";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool FuncTraspasoOperaciones()
        {
            try
            {
                oDB.Execute("SP_TRASPASOOPERACIONES");

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
                MSGEXCTR = "Error al ejecutar FuncTraspasoOperaciones";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }
       
       
        Boolean Devengamiento(int iDesdeIniDia)
        {
            try
            {
                string cRes;
                string cMsg;
                string SQL;
                string dFecPro;
                string dFecProAnt;
                string dFecProxPro;
                string cFirstHabil;
                string cLastHabil;
                string dUltDMesPro;
                string dUltDMesAnt;
                string dUltHabMesAnt;
                int nValUF_Ant;              //As Double
                int nValUF_Pro;              //As Double
                int nValUsd_Pro;             //As Double
                int nValUsd_Ant;             //As Double
                int nValUF_UDM;              //As Double
                int nValUsd_UDMA;            //As Double
                int nOk;                     //As Integer
                string sNameProcDevengo;
                DataTable Datos;

                //Set clsValorMoneda = New clsValorMoneda

                nOk = 0;                                      //'Por defecto Rechazado


                dFecPro = dFechaProceso.ToString("yyyyMMdd");//Format$(cDatosgenerales.ACfecproc, "dd-mm-yyyy")    'Fecha de Proceso


                cFirstHabil = "NO";
                cLastHabil = "NO";



                //If BacFirstHabil(dFecPro) Then
                cFirstHabil = "SI";
                
                //If BacLastHabil(dFecPro) Then
                cLastHabil = "SI";

                dUltDMesPro = dFechaProceso.ToString("yyyyMMdd");// BacUltimoDia(dFecPro, "SI")    'Ultimo Día Mes de Proceso
                dUltDMesAnt = dFechaProceso.ToString("yyyyMMdd");//BacUltimoDia(dFecPro, "NO")    'Ultimo Día Mes de Proceso Anterior
                dUltHabMesAnt = dUltDMesAnt;                  //'Ultimo Día Hábil Mes Anterior
                dFecProxPro = dFechaProxima.ToString("yyyyMMdd");// BacProxHabil(dFecPro)          'Siguiente Día Hábil
                dFecProAnt = dFechaProceso.ToString("yyyyMMdd");//BacPrevHabil(dFecPro)           'Día Hábil Anterior


                //If Not BacEsHabil(dUltHabMesAnt) Then
                //    dUltHabMesAnt = BacPrevHabil(dUltHabMesAnt)
                //End If


                //Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonobs, dFecPro)                               'Dólar Observado del Día de Proceso
                nValUsd_Pro = 0;// clsValorMoneda.vmValor


                //Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonobs, dFecProAnt)                            'Dólar Observado del Día Anterior
                nValUsd_Ant = 0;//clsValorMoneda.vmValor


                //Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonobs, dUltHabMesAnt)                         'Dólar Observado Ultimo Día Habil Mes Anterior
                nValUsd_UDMA = 0;//clsValorMoneda.vmValor


                //Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dFecPro)         'Valor UF del Día
                nValUF_Pro = 0;//clsValorMoneda.vmValor


                //Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dFecProAnt)
                nValUF_Ant = 0;//clsValorMoneda.vmValor                                  'Valor UF Día Anterior


                //If cFirstHabil = "SI" Then
                //    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dUltDMesAnt)
                //    nValUF_Ant = clsValorMoneda.vmValor                               'Para el Ajuste al Inicio del Mes
                //End If


                //Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dUltDMesPro)
                nValUF_UDM = 0;// clsValorMoneda.vmValor

                
                oDB.Execute("SP_DEVENGAMIENTO", new object[] { new SqlParameter("@dFecPro", dFecPro)
                                                                    ,new SqlParameter("@dFecProAnt", dFecProAnt)
                                                                    ,new SqlParameter("@dFecProxPro",dFecProxPro)
                                                                    ,new SqlParameter("@dFecUDMPro", dUltDMesPro)
                                                                    ,new SqlParameter("@dFecUDMAnt", dUltHabMesAnt)

                                                                    ,new SqlParameter("@cLastHabil", cLastHabil)
                                                                    ,new SqlParameter("@cFirstHabil", cFirstHabil)
                                                                    ,new SqlParameter("@nValorUF_Ant", nValUF_Ant)
                                                                    ,new SqlParameter("@nValorUF_Pro", nValUF_Pro)
                                                                    ,new SqlParameter("@nValorUF_UDM", nValUF_UDM)
                                                                    ,new SqlParameter("@nValUsd_Pro", nValUsd_Pro)
                                                                    ,new SqlParameter("@nValUsd_Ant", nValUsd_Ant)
                                                                    ,new SqlParameter("@nvalusd_udma", nValUsd_UDMA)
                                                                    ,new SqlParameter("@iEjecucionIniDia", iDesdeIniDia)
                                                                    });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                oDB.Execute("SP_DEVENGAMIENTO_BACK_TEST", new object[] { new SqlParameter("@dFecPro", dFecPro)
                                                                    ,new SqlParameter("@dFecProAnt", dFecProAnt)
                                                                    ,new SqlParameter("@dFecProxPro",dFecProxPro)
                                                                    ,new SqlParameter("@dFecUDMPro", dUltDMesPro)
                                                                    ,new SqlParameter("@dFecUDMAnt", dUltHabMesAnt)

                                                                    ,new SqlParameter("@cLastHabil", cLastHabil)
                                                                    ,new SqlParameter("@cFirstHabil", cFirstHabil)
                                                                    ,new SqlParameter("@nValorUF_Ant", nValUF_Ant)
                                                                    ,new SqlParameter("@nValorUF_Pro", nValUF_Pro)
                                                                    ,new SqlParameter("@nValorUF_UDM", nValUF_UDM)
                                                                    ,new SqlParameter("@nValUsd_Pro", nValUsd_Pro)
                                                                    ,new SqlParameter("@nValUsd_Ant", nValUsd_Ant)
                                                                    ,new SqlParameter("@nvalusd_udma", nValUsd_UDMA)
                                                                    ,new SqlParameter("@iEjecucionIniDia", iDesdeIniDia)
                                                                    });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                /*
                If LEEWEBSERVICES Then
                If Bac_Sql_Execute("SP_UDP_CARTERA_VS_TURING") Then
                If miSQL.SQL_Fetch(Datos()) = 0 Then
                If Datos(1) = -1 Then
                Call WriteLogFile("Clase Forward : Error en el proceso de Actualizacion Turing, Error en Sql : (Sp_UDP_Cartera_vs_Turing)")
                Let Devengamiento = True
                End If
                If Datos(1) = "OK" Then
                nOk = 1
                Let Devengamiento = True
                End If
                End If
                Else
                nOk = 0
                Call WriteLogFile("Clase Forward : Error en el proceso de Actualizacion Turing ... (Sp_UDP_Cartera_vs_Turing)")
                Let Devengamiento = True
                End If
                End If
                 */
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Devengamiento";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool FuncGrabarInicioDia()
        {
            try
            {
                if (!(BacChkFechas()))
                {
                    oLog.GeneraLog(sOrigen, "Problemas Validacion BacChkFechas");
                    return false;
                }

                //oDB.IniciarTran();

                oDB.Execute("SP_MDACINICIODIA", new object[] { new SqlParameter("@cFecproc", dFechaProceso.ToString("yyyyMMdd"))
                                                                    ,new SqlParameter("@cFecprox", dFechaProxima.ToString("yyyyMMdd"))
                                                                    });

                if (oDB.NUMEX == 0)
                {
                    foreach (DataRow row in dtMonedas.Rows)
                    {
                        oDB.Execute("SP_MDVMGRABAR", new object[] {  new SqlParameter("@ncodigo", row[0])
                                                                    ,new SqlParameter("@nvalor", row[2])
                                                                    ,new SqlParameter("@nptacmp", "0")
                                                                    ,new SqlParameter("@nptavta", "0")
                                                                    ,new SqlParameter("@dfecha", dFechaProceso.ToString("yyyyMMdd"))
                                                                    });
                    }

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

               
                //oDB.CancelarTran();
                //oDB.ConfirmarTran();
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncGrabarInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool BacChkFechas()
        {
            try
            {
                if (!(BacChkFecpro()))
                {
                    return false;
                }

                if (!(BacChkFecprx()))
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
                if (oUtil.BacEsHabil(dFechaProceso, "00006"))
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
                MSGEXCTR = "Error al ejecutar BacChkFecpro";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        } 
                

        bool DatosGenerales()
        {
            try

            {
                oDB.Execute("SP_DATOSGENERALES");

                dtGeneral = oDB.dtDatos;

                dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fecproc"].ToString());
                dFechaProxima = DateTime.Parse(dtGeneral.Rows[0]["fecprox"].ToString());

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

        //BAC_Conection
        //DatosGenerales
        //CargarInicioDia
        //cDatosgenerales.ACsw_fd
        //dFechaProxima
        //FuncGrabarInicioDia
        //Devengamiento
        //FuncTraspasoOperaciones
        //FuncCargaVencimientos
        //VenceOPTicket
        //ProcesoInicioDia = True

        bool CargarInicioDia()
        {
            try
            {
                oDB.Execute("SP_MDVMLEER", new object[] { new SqlParameter("@dFecpro1", dFechaProceso.ToString("yyyyMMdd")) });
                dtMonedas = oDB.dtDatos;
                //Fecha.ToString("yyyyMMdd")

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
                MSGEXCTR = "Error al ejecutar CargarInicioDia";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }



    }
}
