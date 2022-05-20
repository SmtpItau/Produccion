using System;
using System.Net;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Sockets;
using System.IO;
using System.Text.RegularExpressions;

namespace clsCentralizacionProcesos
{
    class clsTrader
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

        /*datos generales*/
        public DataTable dtGeneral;
        public DataTable dtMonedas;
        public DataTable dtValorMoneda;
        static string sOrigen = "clsCentralizacionProcesos.clsTrader";

        string _GSBAC_RECAL;
        string _GSBAC_DIRPAE;

        DateTime dFechaProceso;
        DateTime dFechaProxima;
        DateTime dFechaAnterior;
        DateTime gsBac_Fecp;
        string cSW_PD;
        int Entidad_Codigo;

        /*datos devengo*/
        DateTime devFecha_Proceso;
        DateTime devFecha_Proximo_Proceso;
        DateTime devFecha_Cierre_Mes;
        float devValPCDUSD;
        float devValPCDUF;
        float devValPTF;
        int devSwDevengo;
        DateTime devFecha_Anterior;

        DateTime devFecha_Proceso_Dev;
        DateTime devFecha_Proximo_Dev;
        DateTime devGsBac_FM;

        string gsBac_User = "ADMINISTRA";
        string gsBac_IP = "";

        string _PATHFILEPAE;

        private string uDL_PARAMETROS;

        public string UDL_PARAMETROS { get => uDL_PARAMETROS; set => uDL_PARAMETROS = value; }
        public string GSBAC_RECAL { get => _GSBAC_RECAL; set => _GSBAC_RECAL = value; }
        public string GSBAC_DIRPAE { get => _GSBAC_DIRPAE; set => _GSBAC_DIRPAE = value; }
        public string PATHFILEPAE { get => _PATHFILEPAE; set => _PATHFILEPAE = value; }
        public string MSGEX { get => _MSGEX; set => _MSGEX = value; }
        public string MSGEXCTR { get => _MSGEXCTR; set => _MSGEXCTR = value; }
        public string TIPOMSEX { get => _TIPOMSEX; set => _TIPOMSEX = value; }
        public int NUMEX { get => _NUMEX; set => _NUMEX = value; }
        public string MENSAJELOG1 { get => MENSAJELOG; set => MENSAJELOG = value; }

        public bool LocalIPAddress()
        {
            try
            {
                IPHostEntry host; string localIP = "";
                host = Dns.GetHostEntry(Dns.GetHostName());

                foreach (IPAddress ip in host.AddressList)
                {
                    if (ip.AddressFamily == AddressFamily.InterNetwork)
                    {
                        localIP = ip.ToString();
                        break;
                    }
                }
                gsBac_IP = localIP;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar LocalIPAddress";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool ProcesoInicioDia()
        {
            try
            {
                MSGEX = "";
                NUMEX = 0;

                oDB.PATHLOG = oLog.PATHLOG;

                oLog.GeneraLog(sOrigen, "Inicio ProcesarInicioDia");

                oLog.GeneraLog(sOrigen, "Inicio proceso LocalIPAddress");
                bProceso  = LocalIPAddress();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio Conexion");
                bProceso = oDB.AbrirConexion();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio Transaccion");
                bProceso = oDB.IniciarTran();
                if (!bProceso) { return false; }

                oUtil.oDB.DbUDL = UDL_PARAMETROS;

                /*obtener datos generales*/
                oLog.GeneraLog(sOrigen, "Inicio proceso Proc_Carga_Parametros");
                bProceso = Proc_Carga_Parametros();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso BacLeerParamAc");
                bProceso = BacLeerParamAc(dFechaProceso, dFechaProxima, cSW_PD);
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso Func_Buscar_Datos");
                bProceso = Func_Buscar_Datos();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso BacChkFechas");
                bProceso = BacChkFechas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso Agregarmonedas");
                bProceso = Agregarmonedas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso BacGrabarParamAc");
                bProceso = BacGrabarParamAc();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso TraspasoOperaciones");
                bProceso = TraspasoOperaciones();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FechasDevengo");
                bProceso = FechasDevengo();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso Func_Devengar_Dolares");
                bProceso = Func_Devengar_Dolares();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso ActualizaCartera");
                bProceso = ActualizaCartera();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso ActualizaCarteraLibreTrading");
                bProceso = ActualizaCarteraLibreTrading();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso funcProcesaRecompras");
                bProceso = funcProcesaRecompras();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso funcProcesaReventas");
                bProceso = funcProcesaReventas();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso TraspasoSorteoLCHR");
                bProceso = TraspasoSorteoLCHR();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso Proc_Carga_Parametros");
                bProceso = Proc_Carga_Parametros();
                if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso ProcesosDeCobertura");
                bProceso = ProcesosDeCobertura();
                if (!bProceso) { return false; }

                //oDB.ConfirmarTran;

                oLog.GeneraLog(sOrigen, "Inicio proceso Time_Express");
                bProceso = Time_Express(2);//[Finalizado Ok] = 2
                if (!bProceso) { return false; }

                //oLog.GeneraLog(sOrigen, "Inicio proceso CargaArchivo_PrestamosIBS");
                //bProceso = CargaArchivo_PrestamosIBS();
                //if (!bProceso) { return false; }

                //oLog.GeneraLog(sOrigen, "Inicio proceso CargaArchivo_AnticipoIBS");
                //bProceso = CargaArchivo_AnticipoIBS();
                //if (!bProceso) { return false; }

                oLog.GeneraLog(sOrigen, "Inicio proceso FuncReabajaLineas");
                bProceso = FuncReabajaLineas();
                if (!bProceso) { return false; }
                /*
                Let BacCalculoRec.gsBac_Fecp = cDatosgenerales.gsBac_Fecp
                Call BacCalculoRec.Proc_Recalculo_Lineas_DRV
                 */

                //oDB.CancelarTran();

                /*
                aqui1


                    Let BacCalculoRec.gsBac_Fecp = cDatosgenerales.gsBac_Fecp
                    Call BacCalculoRec.Proc_Recalculo_Lineas_DRV

                Call DllParametros.Func_MoveEventControls(RentaFija, 19, [Finalizado Ok])


                Call DllParametros.Func_MoveEventControls(RentaFija, 20, [En Ejecucion])
                If Bac_Sql_Execute("BacParamSuda.DBO.SP_GAR_GRABA_GARANTIAS_FALTANTES") = False Then
                    Call DllParametros.Func_MoveEventControls(RentaFija, 20, [Finalizado c / Warning])
                    Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso de Garantias.")
                Else
                    Call DllParametros.Func_MoveEventControls(RentaFija, 20, [Finalizado Ok])
                End If


                If HayMensajesEmail() Then
                    ok = EnviaMailGtias
                    If ok Then
                        Call MarcaEmailsEnviados(False)
                    End If
                End If


                Let ProcesoInicioDia = True
                'Apertura Mesas y envio de correo
                Call FuncAperturaMesa_BacCambio_RentaFija_Opciones
                Call EnvioMailInicioDia
                 */

                

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
                    oLog.GeneraLog(sOrigen, "Proceso cancelado por errores");
                    oLog.GeneraLog(sOrigen, "Transaccion Cancelada");
                    bProceso = oDB.CancelarTran();

                    oLog.GeneraLog(sOrigen, "Inicio CerrarConexion");
                    bProceso = oDB.CerrarConexion();
                }
            }

        }

        //aqui2
        bool Proc_Recalculo_Lineas_DRV()
        {
            return true;
        }
        bool Proc_Rescata_Clientes_DRV()
        {
            return true;
        }
        bool FuncReabajaLineas()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_LINEAS_ACTUALIZARMONTOS", new object[] { new SqlParameter("@dFecPro", dFechaProceso.ToString("yyyyMMdd"))
                                                                    ,new SqlParameter("@idSistema", "BTR")
                                                                    });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }
                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FuncReabajaLineas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool CargaArchivo_AnticipoIBS()
        {
            try
            {
                string oPath; ;
                string cNombreArchivo;
                long IBS_NumPrestamo;         //As Long
                string IBS_CodProd;
                string IBS_CodFam;
                long IBS_NumDerivado;         //As Long
                string IBS_cTipo;
                string IBS_cTipoAnti;
                string IBS_FecAnti;
                double IBS_Monto;               //As Double
                string IBS_RuCli;
                long total_registro;          //As Long
                string sRut;
                bool bRut;


                string sCaracter;
                int nCaracter;

                sCaracter = PATHFILEPAE.Substring(PATHFILEPAE.Count() - 1, 1);
                nCaracter = Encoding.ASCII.GetBytes(sCaracter)[0];


                if (PATHFILEPAE.Count() > 0)
                {
                    if (nCaracter != 92)//control barra ruta
                    {
                        PATHFILEPAE += (char)92;
                    }
                }


                DataTable dtDatos;

                oDB.Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", new object[] { new SqlParameter("@nArchivo", 2) });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                cNombreArchivo = "Derelant_" + dFechaProceso.ToString("yyyyMMdd") + ".dat";//& Format(dFechaProceso, "YYYY") & Format(dFechaProceso, "MM") & Format(dFechaProceso, "DD") & ".Dat"
                oPath = PATHFILEPAE.Trim() + cNombreArchivo.Trim();//gsBac_DIRPAE + cNombreArchivo

                if (!File.Exists(oPath))
                {
                    MSGEXCTR = "Archivo no Existente : " + oPath;
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }

                total_registro = 0;


                string[] lines = System.IO.File.ReadAllLines(@oPath);

                foreach (string line in lines)
                {
                    if (line.Length != 112)
                    {
                        MSGEXCTR = "Largo archivo no corresponde 112 : " + oPath;
                        NUMEX = -1;
                        MSGEX = "";
                        oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                        return false;
                    }

                    IBS_NumPrestamo = long.Parse(line.Substring(0, 12));// Val(Mid$(xLine, 1, 12))
                    IBS_CodProd = line.Substring(13, 4);// (Mid$(xLine, 14, 4))
                    IBS_CodFam = line.Substring(18, 4);//  (Mid$(xLine, 19, 4))
                    IBS_NumDerivado = long.Parse(line.Substring(23, 12));// Val(Mid$(xLine, 24, 12))
                    IBS_cTipo = line.Substring(36, 1);//(Mid$(xLine, 37, 1))
                    IBS_cTipoAnti = line.Substring(38, 30);//Mid$(xLine, 39, 30)
                    IBS_Monto = double.Parse(line.Substring(69, 17).Replace(".", ","));//Val(Mid$(xLine, 70, 17))
                    IBS_FecAnti = line.Substring(87, 8);//Mid$(xLine, 88, 8)

                    //IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), Right(Trim(Mid$(xLine, 149, 15)), 1)) = True, Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), 0))
                    sRut = line.Substring(96, 15).Trim();//Mid$(xLine, 97, 15)
                    bRut = BacValidaRut(sRut.Substring(0, sRut.Length - 1), sRut.Substring(sRut.Length - 1, 1));
                    IBS_RuCli = bRut ? sRut.Substring(0, sRut.Length - 1) : "0";



                    oDB.Execute("BacTraderSuda.dbo.SP_GRABA_ANTICIPOS_IBS", new object[] {
                                                                                         new SqlParameter("@IBS_FecProc", dFechaProceso.ToString("yyyyMMdd") )
                                                                                        ,new SqlParameter("@IBS_NumPrestamo", IBS_NumPrestamo )
                                                                                        ,new SqlParameter("@IBS_CodProd", IBS_CodProd )
                                                                                        ,new SqlParameter("@IBS_CodFam", IBS_CodFam )
                                                                                        ,new SqlParameter("@IBS_NumDerivado", IBS_NumDerivado )
                                                                                        ,new SqlParameter("@IBS_cTipo", IBS_cTipo )
                                                                                        ,new SqlParameter("@IBS_cTipoAnti", IBS_cTipoAnti)
                                                                                        ,new SqlParameter("@IBS_Monto", IBS_Monto )// CDbl(IBS_Monto)
                                                                                        ,new SqlParameter("@IBS_FecAnti", IBS_FecAnti )
                                                                                        ,new SqlParameter("@IBS_RuCli", IBS_RuCli )
                                                                                    });

                    if (oDB.NUMEX != 0)
                    {
                        return false;
                    }

                    total_registro += 1;
                }


                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar CargaArchivo_AnticipoIBS";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
    

        bool CargaArchivo_PrestamosIBS()
        {
            try
            {
                string oPath; ;
                string cNombreArchivo;
                string ruta;
                string SeparadorCampo;
                string xLine;//$
                string Prueba;
                string IBS_FecProc;
                long IBS_NumPrestamo;         //As Long
                string IBS_CodProd;
                string IBS_CodFam;
                long IBS_NumDerivado;         //As Long
                string IBS_cTipo;
                string IBS_Fecini;
                string IBS_FecVenc;
                double IBS_Monto;               //As Double
                string IBS_CodTasa;
                string IBS_TipoTasa;
                double IBS_TasaCli;             //As Double
                double IBS_Spread;              //As Double
                string IBS_Moneda;
                string IBS_RuCli;
                string IBS_cTipoPlazo;
                long IBS_Plazo;               //As Long
                string IBS_cEstadoOper;
                long LargoRegistro;          //As Long
                long total_registro;          //As Long
                string sRut;
                bool bRut;


                string sCaracter;
                int nCaracter;

                sCaracter = PATHFILEPAE.Substring(PATHFILEPAE.Count() - 1, 1);
                nCaracter = Encoding.ASCII.GetBytes(sCaracter)[0];


                if (PATHFILEPAE.Count() > 0)
                {
                    if (nCaracter != 92)//control barra ruta
                    {
                        PATHFILEPAE += (char)92;
                    }
                }


                DataTable dtDatos;

                oDB.Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", new object[] { new SqlParameter("@nArchivo", 1) });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                cNombreArchivo = "Derelpae_" + dFechaProceso.ToString("yyyyMMdd") + ".dat";//& Format(dFechaProceso, "YYYY") & Format(dFechaProceso, "MM") & Format(dFechaProceso, "DD") & ".Dat"
                oPath = PATHFILEPAE.Trim() + cNombreArchivo.Trim();//gsBac_DIRPAE + cNombreArchivo

                if (!File.Exists(oPath))
                {
                    MSGEXCTR = "Archivo no Existente : " + oPath;
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }

                total_registro = 0;


                string[] lines = System.IO.File.ReadAllLines(@oPath);

                foreach (string line in lines)
                {
                    if (line.Length != 202)
                    {
                        MSGEXCTR = "Largo arhivo no corresponde 202 : " + oPath;
                        NUMEX = -1;
                        MSGEX = "";
                        oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                        return false;
                    }

                    IBS_FecProc = line.Substring(0, 8);// (Mid$(xLine, 1, 8))
                    IBS_NumPrestamo = long.Parse(line.Substring(9, 12));// Val(Mid$(xLine, 10, 12))
                    IBS_CodProd = line.Substring(22, 4);// (Mid$(xLine, 23, 4))
                    IBS_CodFam = line.Substring(27, 4);// (Mid$(xLine, 28, 4))
                    IBS_NumDerivado = long.Parse(line.Substring(32, 12));// Val(Mid$(xLine, 33, 12))
                    IBS_cTipo = line.Substring(45, 1);//(Mid$(xLine, 46, 1))
                    IBS_Fecini = line.Substring(47, 8);//Mid$(xLine, 48, 8)
                    IBS_FecVenc = line.Substring(56, 8);// Mid$(xLine, 57, 8)
                    IBS_Monto = double.Parse(line.Substring(65, 17));// Val(Mid$(xLine, 66, 17))
                    IBS_CodTasa = line.Substring(83, 2);// (Mid$(xLine, 84, 2))
                    IBS_TipoTasa = line.Substring(86, 35);// (Mid$(xLine, 87, 35))
                    IBS_TasaCli = double.Parse(line.Substring(122, 10).Replace(".", ","));// Val(Mid$(xLine, 123, 10))
                    IBS_Spread = double.Parse(line.Substring(133, 10).Replace(".", ","));// Val(Mid$(xLine, 134, 10))
                    IBS_Moneda = line.Substring(144, 3);// Mid$(xLine, 145, 3)

                    //IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), Right(Trim(Mid$(xLine, 149, 15)), 1)) = True, Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), 0))
                    sRut = line.Substring(148, 15).Trim();
                    bRut = BacValidaRut(sRut.Substring(0, sRut.Length - 1), sRut.Substring(sRut.Length - 1, 1));
                    IBS_RuCli = bRut ? sRut.Substring(0, sRut.Length - 1) : "0";

                    IBS_cTipoPlazo = line.Substring(164, 1);// Mid$(xLine, 165, 1)
                    IBS_Plazo = long.Parse(line.Substring(166, 4));//Val(Mid$(xLine, 167, 4))
                    IBS_cEstadoOper = line.Substring(171, 30);// Mid$(xLine, 172, 30)


                    oDB.Execute("BacTraderSuda.dbo.SP_GRABA_PRESTAMOS_IBS", new object[] {
                                                                                        new SqlParameter("@IBS_FecProc", IBS_FecProc )
                                                                                        ,new SqlParameter("@IBS_NumPrestamo", IBS_NumPrestamo )
                                                                                        ,new SqlParameter("@IBS_CodProd", IBS_CodProd )
                                                                                        ,new SqlParameter("@IBS_CodFam", IBS_CodFam )
                                                                                        ,new SqlParameter("@IBS_NumDerivado", IBS_NumDerivado )
                                                                                        ,new SqlParameter("@IBS_cTipo", IBS_cTipo )
                                                                                        ,new SqlParameter("@IBS_Fecini", IBS_Fecini )
                                                                                        ,new SqlParameter("@IBS_FecVenc", IBS_FecVenc )
                                                                                        ,new SqlParameter("@IBS_Monto", IBS_Monto )// CDbl(IBS_Monto)
                                                                                        ,new SqlParameter("@IBS_CodTasa", IBS_CodTasa )
                                                                                        ,new SqlParameter("@IBS_TipoTasa", IBS_TipoTasa )
                                                                                        ,new SqlParameter("@IBS_TasaCli", IBS_TasaCli )// CDbl(IBS_TasaCli)
                                                                                        ,new SqlParameter("@IBS_Spread", IBS_Spread )//CDbl(IBS_Spread)
                                                                                        ,new SqlParameter("@IBS_Moneda", IBS_Moneda )
                                                                                        ,new SqlParameter("@IBS_RuCli", IBS_RuCli )
                                                                                        ,new SqlParameter("@IBS_TipoPlazo", IBS_cTipoPlazo )
                                                                                        ,new SqlParameter("@IBS_Plazo", IBS_Plazo )
                                                                                        ,new SqlParameter("@IBS_cEstadoOper", IBS_cEstadoOper )
                                                                                    });

                    if (oDB.NUMEX != 0)
                    {
                        return false;
                    }
                    total_registro += 1;
                }


                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar CargaArchivo_PrestamosIBS";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public static bool ValidaRut(string rut)
        {
            try
            {
                rut = rut.Replace(".", "").ToUpper();
                Regex expresion = new Regex("^([0-9]+-[0-9K])$");
                string dv = rut.Substring(rut.Length - 1, 1);
                if (!expresion.IsMatch(rut))
                {
                    return false;
                }
                char[] charCorte = { '-' };
                string[] rutTemp = rut.Split(charCorte);
                if (dv != Digito(int.Parse(rutTemp[0])))
                {
                    return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                //MSGEX = ex.Message;
                //MSGEXCTR = "Error proceso ValidaRut";
                //NUMEX = -1;// ex.Number;
                //oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        public static string Digito(int rut)
        {
            try
            {
                int suma = 0;
                int multiplicador = 1;
                while (rut != 0)
                {
                    multiplicador++;
                    if (multiplicador == 8)
                        multiplicador = 2;
                    suma += (rut % 10) * multiplicador;
                    rut = rut / 10;
                }
                suma = 11 - (suma % 11);
                if (suma == 11)
                {
                    return "0";
                }
                else if (suma == 10)
                {
                    return "K";
                }
                else
                {
                    return suma.ToString();
                }
            }
            catch (Exception ex)
            {
                //MSGEX = ex.Message;
                //MSGEXCTR = "Error proceso inicio dia";
                //NUMEX = -1;// ex.Number;
                //oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return "";
            }
        }
        bool BacValidaRut(string Rut, string dig)
        {
            try
            {
                string sRut;
                bool bRetorno;
                sRut = Rut.Trim() + "-" + dig.Trim();
                bRetorno = ValidaRut(sRut);

                return bRetorno;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacValidaRut";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        /*
         Private Function BacValidaRut(Rut As String, dig As String) As Integer
    
            Rut = Format(Rut, "00000000")
            D = 2
            For i = 8 To 1 Step -1
                multi = Val(Mid$(Rut, i, 1)) * D
                Suma = Suma + multi
                D = D + 1
                If D = 8 Then
                   D = 2
                End If
            Next i
    
            Divi = (Suma \ 11)
            multi = Divi * 11
            Digito = Trim$(Str$(11 - (Suma - multi)))
    
            If Digito = "10" Then
               Digito = "K"
            End If
    
            If Digito = "11" Then
               Digito = "0"
            End If
    
            devolver = Digito
    
            If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
               BacValidaRut = True
            End If
    
        End Function
         */


        bool Time_Express(int nEstado)
        {
            try
            {
                /*
                 Public Enum nEstados
                    [En Espera] = 0
                    [En Ejecucion] = 1
                    [Finalizado Ok] = 2
                    [Finalizado c / Warning] = 3
                    [No Finalizado] = 4
                End Enum
                 */
                DataTable dtDatos;
                string cSql;

                cSql = "UPDATE BacParamSuda.dbo.MID_Control_Inicio SET Estado = " + nEstado;

                oDB.Execute(cSql);

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Time_Express";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool ProcesosDeCobertura()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_VENCIMIENTOS_COBERTURAS");
                if (oDB.NUMEX != 0)
                {
                    return false;
                }
                oDB.Execute("SP_ACTUALIZACION_COBERTURAS");
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ProcesosDeCobertura";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool TraspasoSorteoLCHR()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("TRASPASOSORTEOLCHR");
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar TraspasoSorteoLCHR";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool funcProcesaReventas()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_REVENTA_AUTOMATICA", new object[] {
                                                            new SqlParameter("@user", gsBac_User )
                                                            ,new SqlParameter("@terminal", gsBac_IP )
                                                           });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }
                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar funcProcesaReventas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool funcProcesaRecompras()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_RECOMPRA_AUTOMATICA", new object[] {
                                                            new SqlParameter("@user", gsBac_User )
                                                            ,new SqlParameter("@terminal", gsBac_IP )
                                                           });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar funcProcesaRecompras";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }


        bool ActualizaCarteraLibreTrading()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_ACT_CARTERA_LIBRE_TRADING", new object[] {
                                                            new SqlParameter("@IdSistema", "BTR" )
                                                           });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ActualizaCarteraLibreTrading";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }


        bool ActualizaCartera()
        {
            try
            {
                DataTable dtDatos;

                oDB.Execute("SP_ACTUALIZA_CARTERA");

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0][0].ToString() != "SI")
                {
                    MSGEXCTR = dtDatos.Rows[0][1].ToString();
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ActualizaCartera";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool Func_Devengar_Dolares()
        {
            bool proc = false;

            proc= Func_Cartera_Inversiones();
            if (!proc) { return false; }

            proc = Func_Compras_Con_Pacto();
            if (!proc) { return false; }

            proc = Func_Ventas_Con_PactoDolar();
            if (!proc) { return false; }

            proc = Func_Interbancario();
            if (!proc) { return false; }

            return true;
        }
        bool Func_Cartera_Inversiones()
        {
            try
            {
                DataTable dtDatos;

                if (gsBac_Fecp != devGsBac_FM & devFecha_Proceso_Dev > devGsBac_FM)
                {
                    devFecha_Anterior = devGsBac_FM;
                }

                oDB.Execute("SP_DEVPROPIAINTER", new object[] {
                                                            new SqlParameter("@dFechoy", devFecha_Anterior.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@dFecprox", devFecha_Proceso.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@fTe_pcdus", devValPCDUSD )
                                                            ,new SqlParameter("@fTe_pcduf", devValPCDUF )
                                                            ,new SqlParameter("@fTe_ptf", devValPTF )
                                                            ,new SqlParameter("@cDevengo_dolar", "S" )
                                                           });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0][0].ToString() != "SI")
                {
                    MSGEXCTR = dtDatos.Rows[0][1].ToString();
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }
     
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Func_Cartera_Inversiones";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool Func_Compras_Con_Pacto()
        {
            try
            {
                DataTable dtDatos;

                if (gsBac_Fecp != devGsBac_FM & devFecha_Proceso_Dev > devGsBac_FM)
                {
                    devFecha_Anterior = devGsBac_FM;
                }

                oDB.Execute("SP_DEVENGO_COMPRAS_CON_PACTO", new object[] {
                                                            new SqlParameter("@dFechoy", devFecha_Anterior.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@dFecprox", devFecha_Proceso.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@fTe_pcdus", devValPCDUSD )
                                                            ,new SqlParameter("@fTe_pcduf", devValPCDUF )
                                                            ,new SqlParameter("@fTe_ptf", devValPTF )
                                                            ,new SqlParameter("@devengo_dolar", "S" )
                                                           });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0][0].ToString() != "OK")
                {
                    MSGEXCTR = dtDatos.Rows[0][1].ToString();
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }

                

                //if (dtDatos.Rows[0]["fecha_proceso"].ToString())
                //{

                //}

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Func_Compras_Con_Pacto";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }

        bool Func_Ventas_Con_PactoDolar()
        {
            try
            {
                DataTable dtDatos;

                if (gsBac_Fecp != devGsBac_FM & devFecha_Proceso_Dev > devGsBac_FM)
                {
                    devFecha_Anterior = devGsBac_FM;
                }

                oDB.Execute("SP_DEVENGO_VENTAS_CON_PACTO", new object[] {
                                                            new SqlParameter("@dFechoy", devFecha_Anterior.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@dFecprox", devFecha_Proceso.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@Devengo_dolar", "S" )
                                                           });
                if (oDB.NUMEX != 0)
                {
                    return false;
                }


                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0][0].ToString() != "OK")
                {
                    MSGEXCTR = dtDatos.Rows[0][1].ToString();
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Func_Ventas_Con_PactoDolar";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool Func_Interbancario()
        {
            try
            {
                DataTable dtDatos;

                if (gsBac_Fecp != devGsBac_FM & devFecha_Proceso_Dev > devGsBac_FM)
                {
                    devFecha_Anterior = devGsBac_FM;
                }

                oDB.Execute("SP_DEVENGO_INTERBANCARIOS", new object[] {
                                                            new SqlParameter("@dFechoy", devFecha_Anterior.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@dFecprox", devFecha_Proceso.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@Devengo_dolar", "S" )
                                                           });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtDatos = oDB.dtDatos;

                if (dtDatos.Rows[0][0].ToString() != "OK")
                {
                    MSGEXCTR = dtDatos.Rows[0][1].ToString();
                    NUMEX = -1;
                    MSGEX = "";
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Func_Interbancario";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }



        bool FechasDevengo()
        {
            try
            {
                DataTable Datos;
                DateTime fecha;

                oDB.Execute("SP_CHKFECHASDEVENGAMIENTO");
               
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                Datos = oDB.dtDatos;

                devFecha_Proceso = DateTime.Parse(Datos.Rows[0]["fecha_proceso"].ToString());
                devFecha_Proximo_Proceso = DateTime.Parse(Datos.Rows[0]["fecha_proximo_proceso"].ToString());
                devFecha_Cierre_Mes = DateTime.Parse(Datos.Rows[0]["fecha_cierre_mes"].ToString());

                devValPCDUSD = float.Parse(Datos.Rows[0]["tasa_estimada_pcdusd"].ToString());
                devValPCDUF = float.Parse(Datos.Rows[0]["tasa_estimada_pcduf"].ToString());
                devValPTF = float.Parse(Datos.Rows[0]["tasa_estimada_ptf"].ToString());
                devSwDevengo = int.Parse(Datos.Rows[0]["sw_devengo_prop"].ToString());
                devFecha_Anterior = DateTime.Parse(Datos.Rows[0]["fecha_anterior"].ToString());

                devFecha_Proceso_Dev = devFecha_Proceso;
                devFecha_Proximo_Dev = devFecha_Cierre_Mes;
                devGsBac_FM = new DateTime(devFecha_Anterior.Year, devFecha_Anterior.Month, 1);
                devGsBac_FM = devGsBac_FM.AddMonths(1).AddDays(-1);

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar FechasDevengo";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool TraspasoOperaciones()
        {
            try
            {
                DataTable Datos;

                oDB.Execute("SP_TRASPASOOPERVENCIDASMIDDLE");
                
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                Datos = oDB.dtDatos;

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar TraspasoOperaciones";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool BacGrabarParamAc()
        {
            try
            {
                DataTable Datos;

                oDB.Execute("SP_GRABARPARAMAC", new object[]{    new SqlParameter("@cfecproc", dFechaProceso.ToString("yyyyMMdd"))
                                                            ,new SqlParameter("@cfecprox", dFechaProxima.ToString("yyyyMMdd"))
                                                        });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                Datos = oDB.dtDatos;

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacGrabarParamAc";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool Agregarmonedas()//nuevo por control proceso
        {
            try
            {
                foreach (DataRow row in dtMonedas.Rows)
                {
                    oDB.Execute("SP_VMGRABAR", new object[] {new SqlParameter("@vmcodigo1", row[0])
                                                        ,new SqlParameter("@vmvalor1", row[2])
                                                        ,new SqlParameter("@vmfecha1", dFechaProceso.ToString("yyyyMMdd"))
                                                        });
                    if (oDB.NUMEX != 0)
                    {
                        return false;
                    }
                    oDB.Execute("SP_VMGRABAR", new object[] {new SqlParameter("@vmcodigo1", row[0])
                                                        ,new SqlParameter("@vmvalor1", row[2])
                                                        ,new SqlParameter("@vmfecha1", dFechaProxima.ToString("yyyyMMdd"))
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
                MSGEXCTR = "Error al ejecutar Agregarmonedas";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool Func_Buscar_Datos()
        {
            if (!(BacChkFechas()))
            {
                return false;
            }

            if (!(BacLeeParamPd()))
            {
                return false;
            }

           
            return true;
        }

        bool BacLeeParamPd()
        {
            try
            {
                oDB.Execute("SP_LEERPD", new object[] { new SqlParameter("@xfecpro", dFechaProceso.ToString("yyyyMMdd"))
                                                                    ,new SqlParameter("@xfecprox", dFechaProxima.ToString("yyyyMMdd"))
                                                                    });

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtMonedas = oDB.dtDatos;
                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacLeeParamPd";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        bool BacChkFechas()
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

        bool BacChkFecpro()
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

        bool BacChkFecprx()
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
        bool BacLeerParamAc(DateTime cFecpro, DateTime cFecprox,string scSW_PD)
        {
            try
            {
                DataTable Datos;

                oDB.Execute("SP_LEERPARAMAC");
               
                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                Datos = oDB.dtDatos;

                dFechaProceso = DateTime.Parse(Datos.Rows[0][1].ToString());
                dFechaProxima = DateTime.Parse(Datos.Rows[0][1].ToString());
                cSW_PD = Datos.Rows[0]["acsw_pd"].ToString();
                //dFechaProxima.AddDays(1);
                dFechaProxima = oUtil.BacProxHabil(dFechaProxima, "00006");

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacLeerParamAc";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        bool Proc_Carga_Parametros()
        {
            try
            {
                oDB.Execute("SP_PARAMETROS_SISTEMA");

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                dtGeneral = oDB.dtDatos;

                dFechaProceso = DateTime.Parse(dtGeneral.Rows[0]["fecproc"].ToString());
                dFechaProxima = DateTime.Parse(dtGeneral.Rows[0]["fecprox"].ToString());
                dFechaAnterior = DateTime.Parse(dtGeneral.Rows[0]["fecante"].ToString());
                gsBac_Fecp = DateTime.Parse(dtGeneral.Rows[0]["fecproc"].ToString());

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar Proc_Carga_Parametros";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        

    }
}
