using System;
using System.Diagnostics;
using System.IO;
using System.Data;
using System.Data.SqlClient;

namespace clsCentralizacionProcesos
{
    public class clsLog
    {

        public clsLog()
        {
            dtLog= dsLog.Tables.Add("tbLog");
            dtLog.Columns.Add("Fecha", typeof(string));
            dtLog.Columns.Add("Origen", typeof(string));
            dtLog.Columns.Add("MensajeCTR", typeof(string));
            dtLog.Columns.Add("NumeroEx", typeof(int));
            dtLog.Columns.Add("MensajeEx", typeof(string));
        }

        public DataSet dsLog = new DataSet();
        public DataTable dtLog;

        private string _PATHLOG;
        private bool _TIPOLOGWIN;
        private bool _TIPOLOGTXT;
        private bool _TIPOLOGCMD;
        private string _NOMBREARCHIVO;
        private string ARCHLOG;

        //public clsDb oDB = new clsDb();

        private string uDL_PARAMETROS;

        private string _MSGEX;
        private string _MSGEXCTR;
        private string _TIPOMSEX;
        private int _NUMEX;
        private string MENSAJELOG;

        

        public string PATHLOG { get => _PATHLOG; set => _PATHLOG = value; }
        public bool TIPOLOGWIN { get => _TIPOLOGWIN; set => _TIPOLOGWIN = value; }
        public bool TIPOLOGTXT { get => _TIPOLOGTXT; set => _TIPOLOGTXT = value; }
        public bool TIPOLOGCMD { get => _TIPOLOGCMD; set => _TIPOLOGCMD = value; }
        public string NOMBREARCHIVO { get => _NOMBREARCHIVO; set => _NOMBREARCHIVO = value; }
        public string MSGEX { get => _MSGEX; set => _MSGEX = value; }
        public string TIPOMSEX { get => _TIPOMSEX; set => _TIPOMSEX = value; }
        public int NUMEX { get => _NUMEX; set => _NUMEX = value; }
        public string MSGEXCTR { get => _MSGEXCTR; set => _MSGEXCTR = value; }
        public string MENSAJELOG1 { get => MENSAJELOG; set => MENSAJELOG = value; }
        public string UDL_PARAMETROS { get => uDL_PARAMETROS; set => uDL_PARAMETROS = value; }

        public void GeneraLog(string Origen, string MensajeCTR, int NumeroEx=0, string MensajeEx="")
        {
            ARCHLOG = NOMBREARCHIVO + DateTime.Now.ToString("yyyyMMdd") + ".log";

          //table.Rows[0]  
          
            if (NumeroEx != 0)
            {
                MENSAJELOG = Origen + " - " + MensajeCTR + " - " + "(" + Convert.ToString(NumeroEx) + ")" + MensajeEx.Trim();

            }
            else
            {
                MENSAJELOG = Origen + " - " + MensajeCTR;
            }


            MENSAJELOG = MENSAJELOG.Trim();

            dtLog.Rows.Add(DateTime.Now, Origen,  MensajeCTR,  NumeroEx ,  MensajeEx );

            AgregaLog(MENSAJELOG);
           
        }

        public void AgregaLog(string sLog)
        {
            string cadena = "";

            cadena += DateTime.Now + " - " + sLog + Environment.NewLine;

            StreamWriter sw = new StreamWriter(PATHLOG + "/" + ARCHLOG, true);
            sw.Write(cadena);
            sw.Close();
        }

        //public bool AgregaLogDB(string sLog)
        //{
        //    try
        //    {
        //        DataTable dtDatos;

        //        //oDB.Execute("SP_LIBERA_LINEAS", new object[] { new SqlParameter("@FecProceso", dFechaProceso.ToString("yyyyMMdd")) });

        //        dtDatos = oDB.dtDatos;
                
        //        if (oDB.NUMEX == 0)
        //        {
        //            return true;

        //        }
        //        else
        //        {
        //            return false;
        //        }

        //    }

        //    catch (Exception ex)
        //    {
        //        MSGEX = ex.Message;
        //        MSGEXCTR = "Error al ejecutar AgregaLogDB";
        //        NUMEX = -1;// ex.Number;
        //        return false;
        //    }
        //}




    }
}
