using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;


namespace clsCentralizacionProcesos
{
    public class clsUtil
    {
        public clsDb oDB = new clsDb();
        public clsLog oLog = new clsLog();

        /*control de excepciones*/
        private string _MSGEX;
        private string _MSGEXCTR;
        private string _TIPOMSEX;
        private int _NUMEX;
        private string MENSAJELOG;


        public string MSGEX { get => _MSGEX; set => _MSGEX = value; }
        public string MSGEXCTR { get => _MSGEXCTR; set => _MSGEXCTR = value; }
        public string TIPOMSEX { get => _TIPOMSEX; set => _TIPOMSEX = value; }
        public int NUMEX { get => _NUMEX; set => _NUMEX = value; }
        public string MENSAJELOG1 { get => MENSAJELOG; set => MENSAJELOG = value; }

        /*variable manejo feriados*/
        public int feano;
        public string feplaza;
        public string feene;
        public string fefeb;
        public string femar;
        public string feabr;
        public string femay;
        public string fejun;
        public string fejul;
        public string feago;
        public string fesep;
        public string feoct;
        public string fenov;
        public string fedic;

   
        static string sOrigen = "clsCentralizacionProcesos.clsUtil";

        public void AgregaRetornoLog(DataTable dataTable)
        {
                try
                {

                if (dataTable != null)
                {
                    var columnsWidths = new int[dataTable.Columns.Count];
                    var output = new StringBuilder();


                    // Get column widths
                    foreach (DataRow row in dataTable.Rows)
                    {
                        for (int i = 0; i < dataTable.Columns.Count; i++)
                        {
                            var length = row[i].ToString().Length;
                            if (columnsWidths[i] < length)
                                columnsWidths[i] = length;
                        }
                    }

                    // Get Column Titles
                    for (int i = 0; i < dataTable.Columns.Count; i++)
                    {
                        var length = dataTable.Columns[i].ColumnName.Length;
                        if (columnsWidths[i] < length)
                            columnsWidths[i] = length;
                    }

                    // Write Column titles
                    // Write Column titles
                    for (int i = 0; i < dataTable.Columns.Count; i++)
                    {
                        var text = dataTable.Columns[i].ColumnName;
                        output.Append("|" + PadCenter(text, columnsWidths[i] + 2));
                    }
                    oLog.GeneraLog(sOrigen, output.ToString());

                    // Write Rows
                    foreach (DataRow row in dataTable.Rows)
                    {
                        output = new StringBuilder();
                        for (int i = 0; i < dataTable.Columns.Count; i++)
                        {
                            var text = row[i].ToString();
                            output.Append("|" + PadCenter(text, columnsWidths[i] + 2));
                        }
                        oLog.GeneraLog(sOrigen, output.ToString());
                    }
                    //return output.ToString();
                }
                }
                catch (Exception ex)
                {
                    MSGEX = ex.Message;
                    MSGEXCTR = "Error al ejecutar AgregaRetornoLog";
                    NUMEX = -1;// ex.Number;
                    oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                }
            
        }


        public string ConvertDataTableToString(DataTable dataTable)
        {
         try
            {
            var output = new StringBuilder();

            var columnsWidths = new int[dataTable.Columns.Count];

            // Get column widths
            foreach (DataRow row in dataTable.Rows)
            {
                for (int i = 0; i < dataTable.Columns.Count; i++)
                {
                    var length = row[i].ToString().Length;
                    if (columnsWidths[i] < length)
                        columnsWidths[i] = length;
                }
            }

            // Get Column Titles
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                var length = dataTable.Columns[i].ColumnName.Length;
                if (columnsWidths[i] < length)
                    columnsWidths[i] = length;
            }

            // Write Column titles
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                var text = dataTable.Columns[i].ColumnName;
                output.Append("|" + PadCenter(text, columnsWidths[i] + 2));
            }
            output.Append("|\n" + new string('=', output.Length) + "\n");

            // Write Rows
            foreach (DataRow row in dataTable.Rows)
            {
                for (int i = 0; i < dataTable.Columns.Count; i++)
                {
                    var text = row[i].ToString();
                    output.Append("|" + PadCenter(text, columnsWidths[i] + 2));
                }
                output.Append("|\n");
            }
            return output.ToString();

            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar ConvertDataTableToString";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return MSGEXCTR;
            }
        }

        private static string PadCenter(string text, int maxLength)
        {
            int diff = maxLength - text.Length;
            return new string(' ', diff / 2) + text + new string(' ', (int)(diff / 2.0 + 0.5));

        }


        public string GeneraBodyHMTL(DataTable dataTable,string sTitulo="")
        {
            try
            {
            string sBody;

            if (dataTable == null)
            {
                return "";
            }

            if (sTitulo.ToString().Length == 0)
            {
                sTitulo = "Informe Inicios Automaticos";
            }
            sTitulo = sTitulo.ToString().ToUpper().Trim();


            sBody = @"<table border = ""1"" cellspacing = ""0"" cellpadding = ""2"" <tr><td bgcolor = ""#ECECEC"" colspan = """+ dataTable.Columns.Count.ToString() + @"""><strong><center>"+ sTitulo.ToString() +"</center></strong></td>";

            //rescate de columnas
            sBody += "<tr>";
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                sBody += "<td><strong>"+ dataTable.Columns[i].ColumnName.Trim() + "</strong></td>";
            }
            sBody += "</tr>";


            //rescate valores columnas
            foreach (DataRow row in dataTable.Rows)
            {
                sBody += "<tr>";
                for (int i = 0; i < dataTable.Columns.Count; i++)
                {
                    var text = row[i].ToString();
                    sBody += "<td>" + text.Trim() + "</td>";
                    //output.Append("|" + PadCenter(text, columnsWidths[i] + 2));
                }
                sBody += "</tr>";
            }

            sBody += "</table><p></p>";

            return sBody;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar GeneraBodyHMTL";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return MSGEXCTR;
            }
        }

        public bool EnvioEmail(string sMailhost,int iMailPort,bool bEnableSsl, string sMailhostUser,string sMailPassword, string sMailFrom, string sMailTo,string sMailSubject,string sMailBody)
        {
            try
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso EnvioEmail");

                TcpClient  TestPing;
                TestPing = new TcpClient(sMailhost, iMailPort);
                if (!TestPing.Connected)
                {
                    MSGEXCTR = "Host:Puerto inaccesible : " + sMailhost.ToString() + ":" + iMailPort.ToString();
                    oLog.GeneraLog(sOrigen, MSGEXCTR);
                    return false;
                }


                MailMessage mail = new MailMessage();


                string[] destinatario = sMailTo.Split(';');

                foreach (string destinos in destinatario)
                {
                    mail.To.Add(new MailAddress(destinos));
                }

                mail.From = new MailAddress(sMailFrom);
                mail.Subject = sMailSubject;
                mail.Body = sMailBody;
                mail.IsBodyHtml = true;

                SmtpClient client = new SmtpClient();
                client.Host = sMailhost;
                client.Port = iMailPort;
                client.EnableSsl = bEnableSsl;
                client.UseDefaultCredentials = false;

                client.Credentials = new NetworkCredential(sMailhostUser, sMailPassword);
                //client.DeliveryMethod = SmtpDeliveryMethod.Network;

                client.Timeout = 10000;

                client.Send(mail);

                oLog.GeneraLog(sOrigen, "Fin Proceso EnvioEmail");

                return true;
            }

            catch (SmtpException em)
            {
                MSGEX = em.Message;
                if (em.InnerException != null) { MSGEX += " : " + em.InnerException.ToString().Trim(); }
                MSGEXCTR = "Error al ejecutar EnvioEmail";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

            catch (Exception e)
            {
                MSGEX = e.Message;
                if (e.InnerException != null) { MSGEX += " : " + e.InnerException.ToString().Trim(); }
                MSGEXCTR = "Error al ejecutar EnvioEmail";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }



        
        public DateTime BacProxHabil(DateTime dFecha, string plaza)
        {
            try
            {
                dFecha = dFecha.AddDays(1);
                while (!BacEsHabil(dFecha, plaza))
                {
                    dFecha = dFecha.AddDays(1);
                }
                return dFecha;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacProxHabil";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return dFecha;
            }
        }


        public bool BacEsHabil(DateTime cFecha, string plaza)
        {

            try
            {
                //Dim objFeriado As New clsFeriado

                int iAno;
                int iMes;
                string sDia;
                int iDia;
                int n = 0;


                //lunes	1
                //martes	2
                //miércoles 3
                //jueves	4
                //viernes	5
                //sábado	6
                //domingo	0

                //cFecha = DateTime.Parse("12-11-2021");//v 0
                //cFecha = DateTime.Parse("13-11-2021");//sabado 6
                //cFecha = DateTime.Parse("14-11-2021");//domingo 0

                //obtener dia semana numerico
                iDia = (byte)cFecha.DayOfWeek;

                //en caso sabado o domingo
                if (iDia == 0 || iDia == 6)
                {
                    return false;
                }


                iAno = cFecha.Year;//   DatePart("yyyy", cFecha)
                iMes = cFecha.Month;// DatePart("m", cFecha)
                iDia = cFecha.Day;// Format(DatePart("d", cFecha), "00")
                sDia = iDia.ToString("D2");

                LeerFeriado(iAno, plaza);

                switch (iMes)
                {
                    case 1: return !feoct.Contains(sDia.Trim());//InStr(objFeriado.feene, sDia)
                    case 2: return !fefeb.Contains(sDia.Trim());//InStr(objFeriado.fefeb, sDia)
                    case 3: return !femar.Contains(sDia.Trim());//InStr(objFeriado.femar, sDia)
                    case 4: return !feabr.Contains(sDia.Trim());//InStr(objFeriado.feabr, sDia)
                    case 5: return !femay.Contains(sDia.Trim());//InStr(objFeriado.femay, sDia)
                    case 6: return !fejun.Contains(sDia.Trim());//InStr(objFeriado.fejun, sDia)
                    case 7: return !fejul.Contains(sDia.Trim());//InStr(objFeriado.fejul, sDia)
                    case 8: return !feago.Contains(sDia.Trim());//InStr(objFeriado.feago, sDia)
                    case 9: return !fesep.Contains(sDia.Trim());//InStr(objFeriado.fesep, sDia)
                    case 10: return !feoct.Contains(sDia.Trim());//InStr(objFeriado.feoct, sDia)
                    case 11: return !fenov.Contains(sDia.Trim());//InStr(objFeriado.fenov, sDia)
                    case 12: return !fedic.Contains(sDia.Trim());//InStr(objFeriado.fedic, sDia)
                    default: return false;
                }
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacEsHabil";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }



        public DateTime BacFirstHabil(DateTime dFecha, string plaza)
        {
            try
            {
                dFecha = new DateTime(dFecha.Year, dFecha.Month, 1);

                if (!BacEsHabil(dFecha, plaza))
                {
                    while (!BacEsHabil(dFecha, plaza))
                    {
                        dFecha = dFecha.AddDays(1);
                    }
                }
                //Do While Not BacEsHabil(BacFirstHabil, "00997")
                //    BacFirstHabil = Format(DateAdd("d", 1, BacFirstHabil), gsc_FechaDMA)
                //Loop
                return dFecha;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar BacFirstHabil";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return dFecha;
            }
        }


        public bool LeerFeriado(int idAnn, string IdPlaza)
        {
            try
            {
                //Dim Datos()
                //Leer = False

                feano = 0;
                feplaza = "";
                feene = "";
                fefeb = "";
                femar = "";
                feabr = "";
                femay = "";
                fejun = "";
                fejul = "";
                feago = "";
                fesep = "";
                feoct = "";
                fenov = "";
                fedic = "";

                ///lectura de fariados parametros
                oDB.AbrirConexion();
                DataTable dsDatos;
                oDB.Execute("SP_LEER_FERIADO", new object[] { new SqlParameter("@feAno", idAnn), new SqlParameter("@fePlaza", IdPlaza) });
                dsDatos = oDB.dtDatos;

                oDB.CerrarConexion();

                if (oDB.NUMEX != 0)
                {
                    return false;
                }

                if (dsDatos.Rows.Count > 0)
                {
                    feano = int.Parse(dsDatos.Rows[0]["feano"].ToString());
                    feplaza = dsDatos.Rows[0]["feplaza"].ToString();
                    feene = dsDatos.Rows[0]["feene"].ToString();
                    fefeb = dsDatos.Rows[0]["fefeb"].ToString();
                    femar = dsDatos.Rows[0]["femar"].ToString();
                    feabr = dsDatos.Rows[0]["feabr"].ToString();
                    femay = dsDatos.Rows[0]["femay"].ToString();
                    fejun = dsDatos.Rows[0]["fejun"].ToString();
                    fejul = dsDatos.Rows[0]["fejul"].ToString();
                    feago = dsDatos.Rows[0]["feago"].ToString();
                    fesep = dsDatos.Rows[0]["fesep"].ToString();
                    feoct = dsDatos.Rows[0]["feoct"].ToString();
                    fenov = dsDatos.Rows[0]["fenov"].ToString();
                    fedic = dsDatos.Rows[0]["fedic"].ToString();
                }

                return true;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar LeerFeriado";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public DataTable LeerValorMoneda(int Codigo, DateTime Fecha)
        {
            try
            {
                ///lectura de fariados parametros
                DataTable dsDatos;

                oDB.AbrirConexion();
                oDB.Execute("SP_LEER_VALORMONEDA", new object[] { new SqlParameter("@codmon", Codigo), new SqlParameter("@fecha", Fecha.ToString("yyyyMMdd")) });
                oDB.CerrarConexion();
                dsDatos = oDB.dtDatos;
                return dsDatos;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar LeerValorMoneda";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                DataTable dsDatos=null;
                return dsDatos;
            }
        }

        public DataTable LeerEstados(int stipoSalida, String sSistema="")
        {
            try
            {
                ///lectura de fariados parametros
                DataTable dsDatos;

                oDB.AbrirConexion();
                oDB.Execute("SP_EST_BAC_SW", new object[] {     new SqlParameter("@stipoSalida", stipoSalida.ToString()) 
                                                            ,   new SqlParameter("@sSistema", sSistema.ToString())
                                                            });
                oDB.CerrarConexion();
                dsDatos = oDB.dtDatos;
                return dsDatos;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar LeerEstados";
                NUMEX = -1;// ex.Number;
                oLog.GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                DataTable dsDatos = null;
                return dsDatos;
            }
        }



    }
}
