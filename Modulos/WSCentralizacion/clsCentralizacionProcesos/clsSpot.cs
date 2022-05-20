using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace clsCentralizacionProcesos
{
    class clsSpot
    {
        /*clases generales*/
        public clsDb  oDB = new clsDb();
        public clsLog oLog = new clsLog();
        public clsUtil oUtil= new clsUtil();
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
        DateTime gsBAC_Fecp;
        int Entidad_Codigo;
        static string sOrigen = "clsCentralizacionProcesos.clsSpot";


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
                if (!bProceso) { return false; }

                //oLog.GeneraLog(sOrigen, "Inicio Transaccion");
                //bProceso = oDB.IniciarTran();
                

                /*obtener datos generales*/
                oUtil.oDB.DbUDL = uDL_PARAMETROS;

                oLog.GeneraLog(sOrigen, "Rescate Valores Generales");
                bProceso = DatosGenerales();
                

                dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["acFecPrx"].ToString());
                dFechaProxima = oUtil.BacProxHabil(DateTime.Parse(dtGeneral.Rows[0]["acFecPrx"].ToString()), "00006");
                Entidad_Codigo = int.Parse(dtGeneral.Rows[0]["accodigo"].ToString());

                //oUtil.BacEsHabil(DateTime.Now, "00997");
                oLog.GeneraLog(sOrigen, "Inicio proceso GenerarInicio");
                bProceso = GenerarInicio();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso LiberacionLineas");
                bProceso = LiberacionLineas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso TraspasoTxOnlineTarde");
                bProceso = TraspasoTxOnlineTarde();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso CapturaVencimientoFwd");
                bProceso = CapturaVencimientoFwd();
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


        bool TraspasoTxOnlineTarde()
        {
            return true;
        }

        bool BacTX_OnLine()
        {
            return true;
        }

        bool CapturaVencimientoFwd()
        {
            return true;
        }


        bool LiberacionLineas()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_LIBERA_LINEAS", new object[] { new SqlParameter("@FecProceso", dFechaProceso.ToString("yyyyMMdd")) });

                dtDatos = oDB.dtDatos;
                //Call WriteLogFile("Clase Spot : Error en la liberacion de Lineas (Sp_Libera_Lineas)")
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
                MSGEXCTR = "Error al ejecutar LiberacionLineas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

   
           
         bool DatosGenerales()
        {
            try
            {
                oDB.Execute("SP_CARGAPARAMETROS", new object[] { new SqlParameter("@Entidad", "ME") });
                dtGeneral = oDB.dtDatos;

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


        public bool GenerarInicio()
        {
            try
            {
                //Dim Datos()
                int ddHabil;
                int nEstado = 1;//     As Long
                string cEstado = "";
                DataTable dtDatos;

                ddHabil = 0;

                if (oUtil.BacFirstHabil(dFechaProceso, "00997") == dFechaProceso)//cDatosgenerales.Fecha_Proceso Then
                {
                    ddHabil = 1;
                }


                //DataTable dsDatos = oDB.Execute("SELECT 0, 'OK' ");

                //oDB.IniciarTran();
                oDB.Execute("SP_ACTINICIODIA", new object[] { new SqlParameter("@Entidad", "ME"),
                                                                    new SqlParameter("@fechaprop", dFechaProceso),
                                                                    new SqlParameter("@fechaprx", dFechaProxima),
                                                                    new SqlParameter("@ddhabil", ddHabil)
                                                                  });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows.Count > 0)
                {
                    nEstado = int.Parse(dtDatos.Rows[0].ItemArray[0].ToString());
                    cEstado = dtDatos.Rows[0].ItemArray[1].ToString();
                }

                if (nEstado != 0)
                {
                    //Call WriteLogFile("Clase Spot : Error en proceso de Apertura, cEstado = " & cEstado)
                    //Exit Function
                    MSGEX = "";
                    MSGEXCTR = "Error en proceso de Apertura, cEstado = " + cEstado;
                    NUMEX = -1;// ex.Number;
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }



                oLog.GeneraLog(sOrigen, "Proceso Bloqueo");

                ProcesaBloqueo(" ");//del

                oLog.GeneraLog(sOrigen, "Proceso Cambio Switch Operativo");
                ActuaIni(8, "0");//del

                //oDB.CancelarTran();

                ProcesaBloqueo(" ");
                ActuaIni(8, "0");
                ActuaIni(9, "0");
                ActuaIni(10, "0");
                //ActuaIni(0, "0");//no tiene case posicion en SP_GRABA_SWITCH
                ActuaIni(1, "1");

                //oDB.CancelarTran();

                return true;
            }
             
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar GenerarInicio";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }


        bool ActuaIni(int Pos, string ValPos)
        {
            try
            {
                bool estado = (ValPos == "1" ? true : false);

                if (!Graba_Switch(Pos, estado))///
                {
                    //Call WriteLogFile("Clase Spot : Error al mover Switch. ( Pos = " & Pos % &" Valor = " & ValPos$ &" ).")
                    MSGEX = "";
                    MSGEXCTR = "Error al mover Switch. (Pos = " + Pos +" Valor = " + ValPos +").";
                    NUMEX = -1;// ex.Number;
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ActuaIni";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool Graba_Switch(int Pos, bool bEstado)
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_GRABA_SWITCH", new object[] { new SqlParameter("@Pos", Pos),
                                                                    new SqlParameter("@Val", (bEstado?"1":"0") ),
                                                                    new SqlParameter("@Entidad", Entidad_Codigo)//cDatosgenerales.Entidad_Codigo
                                                                  });

                dtDatos = oDB.dtDatos;
                if (!(dtDatos is null))
                {
                    if (dtDatos.Rows.Count > 0)
                    {
                        if (int.Parse(dtDatos.Rows[0].ItemArray[0].ToString()) != 0)
                        {
                            return false;
                        }
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Graba_Switch";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool ProcesaBloqueo(string Var)
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_PRECIERRE", new object[] { new SqlParameter("@estado", Var) });
                dtDatos = oDB.dtDatos;

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                if (dtDatos.Rows.Count > 0)
                {
                    //dtDatos.Rows[0].ItemArray[0].ToString()
                    return (dtDatos.Rows[0].ItemArray[0].ToString() == "0") ? false : true;
                }
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ProcesaBloqueo";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
    }
}
