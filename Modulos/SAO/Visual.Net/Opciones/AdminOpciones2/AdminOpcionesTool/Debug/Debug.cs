using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace AdminOpcionesTool
{
    public class Debug
    {
        string LogPath;
        string LogFile;
        string separador;
        FileStream LogStream;
        StreamWriter LogWriter;

        /// <summary>
        /// Inicializa un asistente de debug, para grabar mensajes.
        /// Genera un archivo de texto en ruta de "Log" llamado Log_"nombre".txt con el parámetro entregado.
        /// </summary>
        /// <param name="nombre">Nombre para construir archivo de grabación.</param>
        public Debug(string nombre)
        {
            //Debug(nombre, "txt");   //.Debug(nombre, "txt");
            SetDebug(nombre, null, "txt");
        }

        public Debug(string nombre, string ext)
        {
            SetDebug(nombre, null, ext);
        }

        /// <summary>
        /// Inicializa un Debug, con nombre de archivo sin timestamp. En reemplazo, se identifica por tag.
        /// </summary>
        /// <param name="nombre">Nombre para construir archivo de grabación.</param>
        /// <param name="ext">Extensión del archivo de log.</param>
        /// <param name="tag">Tag para reemplazar el timestamp en nombre de archivo.</param>
        public Debug(string nombre, string tag, string ext)
        {
            SetDebug(nombre, tag, ext);
        }

        private void SetDebug(string nombre, string tag, string ext)
        {
            if (tag == null) { tag = DateTime.Now.ToString("yyyyMMddHHmmssfff"); }
            this.LogPath = AdminOpcionesTool.ValorizadorCartera.Global.LogPath;
            this.LogFile = "Log_" + nombre + "_" + tag + "." + ext;
            this.separador = "\t";
            this.LogStream = new FileStream(LogPath + LogFile, FileMode.Append, FileAccess.Write);
            this.LogWriter = new StreamWriter(LogStream, Encoding.UTF8);
            this.LogWriter.AutoFlush = true;
        }

        public void Log(string mensaje)
        {
            this.LogWriter.Write(mensaje);
            this.LogWriter.WriteLine();
            this.LogWriter.Flush();
        }

        /// <summary>
        /// Recibe muchos parámetros, los pasa a String y graba el mensaje.
        /// Actualmente soporta los siguientes tipos complejos: DateTime y enumSetPrincingLoading
        /// </summary>
        /// <param name="datos"></param>
        public void LogMulti(params object[] datos)
        {
            string msg = "";
            foreach(object o in datos)
            {
                if (o.GetType().Equals(DateTime.MinValue.GetType())) { msg += ((DateTime)o).ToShortDateString(); }
                if (o.GetType().Equals(enumSetPrincingLoading.Riesgo.GetType())) { msg += ((int)o).ToString(); }
                else { msg += o.ToString(); }
                //if (o.GetType().Equals(int.MinValue.GetType())) { msg += o.ToString(); }
                //if (o.GetType().Equals(string.Empty.GetType())) { msg += o.ToString(); }
                msg += "\t";
            }
            
            Log(msg);
            return;
        }

        public void LogClose()
        {
            this.LogWriter.Close();
            this.LogStream.Close();
        }

        public void LogVanilla(AdminOpcionesTool.Opciones.Payoffs.Vanilla v)
        {
            LogClose();
            return;
        }

        public void LogVanilla_(AdminOpcionesTool.Opciones.Payoffs.Vanilla v)
        {
            string msg = "Vanilla";
            Log(msg);

            //fechas
            msg += separador + v.FechaVal.ToShortDateString();
            msg += separador + v.FechaVcto.ToShortDateString();
            //plasos
            msg += separador + v.Plazo_Dias.ToString();
            msg += separador + ((int)v._Basis360.Term).ToString();
            msg += separador + ((int)v._Basis365.Term).ToString();
            //tasas
            msg += separador + v.r_dom.ToString("N16");
            msg += separador + v.r_for.ToString("N16");
            msg += separador + v.wf_dom.ToString("N16");
            msg += separador + v.wf_for.ToString("N16");

            Log(msg);
            LogClose();
        }

        public void LogForward(AdminOpcionesTool.Opciones.Payoffs.Forward f, double TasaDom, double TasaFor)
        {
            string msg = "Forward";
            Log(msg);
            int i = 0;
            //era un for, pero son todos los valores iguales...
            //for (; i < f.Fechas_Fijacion.Count; ++i)
            i = f.Fechas_Fijacion.Count - 1;
            {
                //fechas
                msg += separador + f.FechaVal.ToShortDateString();
                msg += separador + f.Fechas_Fijacion[i].ToShortDateString();
                //plasos
                msg += separador + f.Plazos_Fijaciones[i].ToString(); // f.Plazo_Dias.ToString();
                msg += separador + f.Plazos_Fijaciones[i].ToString(); // f((int)v._Basis360.Term).ToString();
                msg += separador + f.Plazos_Fijaciones[i].ToString(); // f((int)v._Basis365.Term).ToString();
                //tasas
                msg += separador + TasaDom / 100; // f.r_dom.ToString("N16");
                msg += separador + TasaFor / 100; // f.r_for.ToString("N16");
                msg += separador + f.wf_dom_ClPInter.ToString("N16");
                msg += separador + f.wf_forUSD.ToString("N16");

                Log(msg);
            }
            LogClose();
        }

        public void LogForwardFijacion(DateTime FechaVal, DateTime FechaFija, double plazo, int i, int cantidad, double TasaDom, double TasaFor, double FactorDom, double FactorFor)
        {
            string msg = "Fija";

            msg += separador + FechaVal.ToShortDateString();
            msg += separador + FechaFija.ToShortDateString(); // v.FechaVcto.ToShortDateString();
            //plasos
            msg += separador + plazo.ToString(); // v.Plazo_Dias.ToString();
            msg += separador + plazo.ToString(); // ((int)v._Basis360.Term).ToString();
            msg += separador + plazo.ToString(); // ((int)v._Basis365.Term).ToString();
            //tasas
            msg += separador + TasaDom/100; // v.r_dom.ToString();
            msg += separador + TasaFor/100; // v.r_for.ToString();
            msg += separador + FactorDom; // v.wf_dom.ToString();
            msg += separador + FactorFor; // v.wf_for.ToString();

            Log(msg);
            //LogClose();
        }
    }
}
