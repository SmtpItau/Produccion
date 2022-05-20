using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using CoreLib.Common;
using System.Globalization;



namespace CoreLib.Helpers
{
    /// <summary>
    /// Clase para implementacion de log de errores
    /// </summary>
    public static class LogHelper
    {
        
        private const string MSG_FILE_NOTFOUND = "No se puede(n) encontrar el/los archivo(s) {0}";
        private const string MSG_FILE_EXTENSION = "El/los archivo(s), no tiene(n) el formato correcto: {0}";
        private const string MSG_FILE_EMPTYNAME = "El nombre de archivo no puede ser nulo o vacio ";
        private const string MSG_PARAM_NOT_NULL = "El parametro no puede ser nulo o vacio";
        private const string PADDING_ZERO = "{0:D5}";
        private static string LogTimeStamp { 
            get { 
                return "[" + (DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.FFF")).PadRight(23,'0') + "]"; 
            } 
        }
         
        /// <summary>
        /// Formatea la excepcion
        /// </summary>
        /// <returns>String con formato para log</returns>
        public static string FormatException(Exception e, bool friendlyLog = true) {
            string msg = string.Empty;
            string pattern = string.Empty;
            string stack = string.Empty;

            pattern = @"en\x20\w\:(\\\w*)*(.aspx|.vb|.cs|.asmx):línea\x20\d*";
            Regex regex = new Regex(pattern, RegexOptions.None);

            if (!regex.IsMatch(e.StackTrace.ToString()))
            {
                pattern = @"in\x20\w\:(\\\w*)*(.aspx|.vb|.cs|.asmx):line\x20\d*";
                regex = new Regex(pattern, RegexOptions.None);
            }

            foreach (Match match in regex.Matches(e.StackTrace.ToString()))
            {
                if (match.Success == true)
                {
                    stack +=  match.Value + "\t" ;
                }
            }

            if (!string.IsNullOrEmpty(stack)) {
                stack = stack.Substring(0, stack.Length - 1);
            }
            
            if (friendlyLog == false)
            {
                msg = "Descripcion:{1}\tSource:{2}\tTarget:{3}\tStackTrace:{4}";
                msg = string.Format(msg, DateTime.Now.ToString("yyyy-M-d HH:mm:ss.FFF"), e.Message, e.Source, e.TargetSite, e.StackTrace);
            }
            else {
                msg = "Descripcion:{1}\tSource:{2}\tStackTrace:{3}";
                msg = string.Format(msg, DateTime.Now.ToString("yyyy-M-d HH:mm:ss.FFF"), e.Message, e.Source, stack);
            }            
            return msg;
        }

        /// <summary>
        /// Escribe un registro en el arhcivo indicado
        /// </summary>
        /// <param name="fileName">Nombre de Archivo de log</param>
        /// <param name="record">Registro a  escribir el log</param>
        /// <returns>True/false</returns>
        public static bool WriteLog(string fileName, string record) {
            if (string.IsNullOrWhiteSpace(fileName) || string.IsNullOrEmpty(fileName)) {
                throw new ArgumentException("fileName",MSG_FILE_EMPTYNAME);
            }

            if (string.IsNullOrWhiteSpace(record)||string.IsNullOrEmpty(record)) {
                throw new ArgumentException("record", MSG_PARAM_NOT_NULL);
            }
            FileInfo logFile = new FileInfo(fileName);
            StreamWriter logger;
            if (logFile.Exists == true)
            {
                logger = logFile.AppendText();
                logger.WriteLine(record);
            }
            else
            {
                logger = logFile.CreateText();
                logger.WriteLine(record);
            }
            logger.Flush();
            logger.Close();
            return true;               
        }

        /// <summary>
        /// Escribe una entrada del registro
        /// </summary>
        /// <param name="context">Contexto de aplicacion</param>
        /// <param name="exception">objeto Exception </param>
        /// <returns>true/false</returns>
        private static bool WriteLog(AppContext context, object exception) {
            if (context.LogContext.isEnable == false){
                return false;
            }
            if(exception == null){
                throw new ArgumentException("exception object", MSG_PARAM_NOT_NULL);
            }
            string msg = FormatException((Exception)exception,context.LogContext.FriendlyLog);

            return WriteLog(context, msg);            
        }

        /// <summary>
        /// Escribe un registro en el log
        /// </summary>
        /// <param name="context">Clase de contexto de aplicacion</param>
        /// <param name="record">Registro a escribir en el log de archivo</param>
        /// <returns>true/false</returns>
        public static bool WriteLog(AppContext context, string record) {
            if (context.LogContext.isEnable == false)
            {
                return false;
            }
            if (string.IsNullOrEmpty(record))
            {
                throw new ArgumentException("record", MSG_PARAM_NOT_NULL);
            }

            if (context.LogContext.AsyncWriteLog) {
                WriteLogAsync(context, record);
                return true;
            }

            //FileInfo logFile = new FileInfo(context.LogContext.LogFileName);
            //StreamWriter logger;
            //if (logFile.Exists == true)
            //{
            //    logger = logFile.AppendText();
            //    logger.WriteLine(record);
            //}
            //else
            //{
            //    logger = logFile.CreateText();
            //    logger.WriteLine(record);
            //}
            //logger.Flush();
            //logger.Close();
            return true;                                   
        }

        /// <summary>
        /// Escribe segun configuracion un mensaje en log de error.
        /// </summary>
        /// <param name="context"></param>
        /// <param name="level"></param>
        /// <param name="ex"></param>
        /// <param name="useTimeStamp"></param>
        /// <returns></returns>
        public static bool WriteLog(AppContext context, Exception ex, LevelInfo level = LevelInfo.Error, bool useTimeStamp = true)
        {
                       
            string aux_record = "{0}\t{1}\t{2}";
            string record_2 = string.Empty;
            string level_str = level.ToString().PadRight(15, '\x20');

            
            if (useTimeStamp == true)
            {
                record_2 = string.Format(aux_record, LogTimeStamp, level_str, FormatException(ex, context.LogContext.FriendlyLog));
            }
            else {
                record_2 = string.Format(aux_record, string.Empty, level_str, FormatException(ex, context.LogContext.FriendlyLog));
            }

            return LogHelper.WriteLog(context, record_2);            
        }
        
        /// <summary>
        /// Escribe en el log un objeto exception
        /// </summary>                                     
        /// <param name="context">Conteto de Aplicacion</param>
        /// <param name="ex">Objeto exception a escribir en el log.</param>
        /// <param name="code">Codigo de error o de exito</param>
        /// <param name="level">Nivel de informacion </param>
        /// <param name="useTimeStamp">indica si se utiliza time stamp para el log</param>
        /// <returns>true/false</returns>        
        public static bool WriteLog(AppContext context, Exception ex, int code, LevelInfo level = LevelInfo.Error, bool useTimeStamp = true) {

            string aux_record = "{0}\t{1}\t{2}\t{3}";
            string record_2 = string.Empty;
            string level_str = level.ToString().PadRight(15, '\x20');

            #region CODE STRING FORMATING, SEGUN CONST. PADDING_ZERO
            string code_str = string.Empty;
            if (code == 0)
            {
                code_str = "0";
            }
            else if (code.ToString().Length < 5)
            {
                code_str = string.Format(PADDING_ZERO, code);
            }
            else
            {
                code_str = code.ToString();
            }
            #endregion

            if (useTimeStamp == true)
            {
                record_2 = string.Format(aux_record, LogTimeStamp, level_str, code_str,FormatException(ex, context.LogContext.FriendlyLog));
            }
            else
            {
                record_2 = string.Format(aux_record, string.Empty, level_str, code_str, FormatException(ex, context.LogContext.FriendlyLog));
            }

            return LogHelper.WriteLog(context, record_2);        
        
        }

        /// <summary>
        /// Escribe en log un registro
        /// </summary>
        /// <param name="context">Conteto de Aplicacion</param>
        /// <param name="record">Registro a escribir</param>
        /// <param name="code">Codigo de error o de exito</param>
        /// <param name="level">Nivel de informacion </param>
        /// <param name="useTimeStamp">indica si se utiliza time stamp para el log</param>
        /// <returns>true/false</returns>
        public static bool WriteLog(AppContext context, string record,int code, LevelInfo level = LevelInfo.None, bool useTimeStamp = true) {


            string aux_record = "{0}\t{1}\t{2}\t{3}";
            string record_2 = string.Empty;
            string level_str = level.ToString().PadRight(15, '\x20');

            #region CODE STRING FORMATING, SEGUN CONST. PADDING_ZERO
            string code_str = string.Empty;
            if (code == 0){
                code_str = "0";
            }else if (code.ToString().Length < 5){
                code_str = string.Format(PADDING_ZERO, code);
            }else{
                code_str = code.ToString();
            }            
            #endregion
            if (useTimeStamp == true)
            {
                if (level == LevelInfo.None)
                {
                    record_2 = string.Format(aux_record, LogTimeStamp, string.Empty,code_str, record);
                }
                else
                {
                    record_2 = string.Format(aux_record, LogTimeStamp,level_str,code_str, record);
                }
            }
            else
            {
                if (level == LevelInfo.None)
                {
                    record_2 = string.Format(aux_record, string.Empty, string.Empty, code_str, record);
                }
                else
                {
                    record_2 = string.Format(aux_record, string.Empty,level_str,code_str, record);
                }
            }

            return LogHelper.WriteLog(context, record_2);
        }
        
        /// <summary>
        /// Escribe segun configuracion un mensaje en log de error.
        /// </summary>
        /// <param name="context"></param>
        /// <param name="record"></param>
        /// <param name="level"></param>
        /// <param name="useTimeStamp"></param>
        /// <returns></returns>
        public static bool WriteLog(AppContext context, string record,LevelInfo level = LevelInfo.None, bool useTimeStamp = true)
        {
            string aux_record = "{0}\t{1}\t{2}";
            string record_2 = string.Empty;
            string level_str = level.ToString().PadRight(15, '\x20');
            if (useTimeStamp == true)
            {
                if(level == LevelInfo.None){
                    record_2 = string.Format(aux_record, LogTimeStamp, string.Empty, record);
                }else{
                    record_2 = string.Format(aux_record, LogTimeStamp, level_str, record);                
                }
            }
            else {
                if (level == LevelInfo.None)
                {
                    record_2 = string.Format(aux_record, string.Empty, string.Empty, record);
                }
                else
                {
                    record_2 = string.Format(aux_record, string.Empty, level_str, record);
                }
            }

            return LogHelper.WriteLog(context, record_2);
        }

        
        /// <summary>
        /// Escribe en log de archivo, de manera asyncrona
        /// </summary>
        /// <param name="context">Application Context</param>
        /// <param name="record">Informacion a escribir en el archivo de log.</param>
        public static void WriteLogAsync(AppContext context,string record){
            
            string eol = record.Substring(record.Length - 2, 2);
            if (!eol.Contains("\r") || !eol.Contains("\n")){
                record += "\r\n";
            }
                
            byte[] byteWrite = Encoding.Unicode.GetBytes(record);

            AsyncCallback write_callback = new AsyncCallback(WriteLogCallback);
            using (FileStream fs = new FileStream(
                                        path:context.LogContext.LogFileName
                                        ,mode:FileMode.Append
                                        ,access:FileAccess.Write
                                        ,share:FileShare.ReadWrite
                                        ,bufferSize:4096
                                        ,useAsync:true
                                    ))  
            {            
                fs.BeginWrite(byteWrite, 0, byteWrite.Length, write_callback, fs);
            }            
        }

        /// <summary>
        /// Callback para escritura asincrona de archivo.
        /// </summary>
        /// <param name="async_result">Resultado de la operacion asincrona.</param>
        private static void WriteLogCallback(IAsyncResult async_result) {
            FileStream fs = (FileStream)async_result.AsyncState;
            fs.EndWrite(async_result);
            GC.Collect();
        }

         
    }
}

/*
 //implementacion de un capturador de global de exceptions
  [STAThread]
 static void Main()
 {
     Application.EnableVisualStyles();
     Application.SetCompatibleTextRenderingDefault(false);

     Application.ThreadException += new ThreadExceptionEventHandler(Application_ThreadException);

     Application.Run(new Form1());
 }

 static void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs e)
 {
     MessageBox.Show(e.Exception.Message);
 }  
 
 * static void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs e)
         {
             using(FileRecordSequence record = new FileRecordSequence("application.log", FileAccess.Write))
             {

                 string message = string.Format("[{0}]Message::{1} StackTrace:: {2}", DateTime.Now, 
                                                                                     e.Exception.Message, 
                                                                                     e.Exception.StackTrace);

                 record.Append(CreateData(message), SequenceNumber.Invalid, 
                                                             SequenceNumber.Invalid, 
                                                             RecordAppendOptions.ForceFlush);
             }
         }


         private static IList<ArraySegment<byte>> CreateData(string str)
         {
             Encoding enc = Encoding.Unicode;

             byte[] array = enc.GetBytes(str);

             ArraySegment<byte>[] segments = new ArraySegment<byte>[1];
             segments[0] = new ArraySegment<byte>(array);

             return Array.AsReadOnly<ArraySegment<byte>>(segments);
         } 
 
 */