#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace CoreLib.Common
{

    /// <summary>
    /// Clase Application Context
    /// </summary>
    [Serializable()]
    public class AppContext : IDisposable
    {
        #region Application Context
        /// <summary>
        /// Nombre de Aplicacion
        /// </summary>
        public string AppName { get; set; }

        #endregion

        /// <summary>
        /// Contexto de Base de datos
        /// </summary>
        public DBContext DBContext { get; set; }

        /// <summary>
        /// Contexto para mailer
        /// </summary>
        public CoreLib.Common.MailContext MailContext { get; set; }

        /// <summary>
        /// Contexto de log
        /// </summary>
        public LogContext LogContext { get; set; }

        #region Implementacion IDisposable
        public AppContext() { }

        ~AppContext()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        private bool disposed = false;
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.                  
                }
                disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion

        /// <summary>
        /// Lee de un diccionario la configuracion de aplicacion.
        /// </summary>
        /// <param name="configSettings"></param>
        public AppContext(Dictionary<string, object> configSettings)
        {
            try
            {
                DBContext db_ctx = new DBContext();
                MailContext mail_ctx = new MailContext();
                LogContext log_ctx = new LogContext();

                AppContext.ReadConfig(log_ctx, configSettings);
                AppContext.ReadConfig(mail_ctx, configSettings);
                AppContext.ReadConfig(db_ctx, configSettings);
                AppContext.ReadConfig(this, configSettings);

                this.DBContext = db_ctx;
                this.LogContext = log_ctx;
                this.MailContext = mail_ctx;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Lee un diccionario &lt;string,object&gt; con la configuracion de aplicacion
        /// </summary>
        /// <typeparam name="T">Tipo a convertir</typeparam>
        /// <param name="source">Objeto a convertir (llenar con el diccionario)</param>
        /// <param name="configSettings">Diccionario con los parametros de aplicacion.</param>
        /// <remarks>el objeto configSettings debe tener claves equivalentes en el objeto source.</remarks>
        public static void ReadConfig<T>(T source, Dictionary<string, object> configSettings)
        {
            try
            {

                PropertyDescriptorCollection prop_collection = TypeDescriptor.GetProperties(source.GetType());
                Dictionary<string, PropertyDescriptor> props = (from PropertyDescriptor obj in prop_collection
                                                                select new
                                                                {
                                                                    Key = obj.Name.ToLowerInvariant(),
                                                                    Value = obj

                                                                }).ToDictionary(a => a.Key, a => a.Value);

                foreach (KeyValuePair<string, object> kvp in configSettings)
                {
                    if (props.ContainsKey(kvp.Key.ToLower()))
                    {
                        PropertyDescriptor prop = props[kvp.Key.ToLower()];
                        object aux_value = null;
                        if (prop != null)
                        {
                            if (kvp.Value.GetType() == typeof(DateTime))
                            {
                                aux_value = ((DateTime)kvp.Value); //.ToString("yyyyMMdd", CultureInfo.InvariantCulture);
                            }
                            if (kvp.Value.GetType() == typeof(Decimal))
                            {
                                aux_value = ((Decimal)kvp.Value); //.ToString();//.Replace(".", "").Replace(",", ".");
                            }
                            if (kvp.Value.GetType() == typeof(Boolean))
                            {
                                aux_value = ((Boolean)kvp.Value); // == true ? true : false;
                            }
                            if (kvp.Value.GetType() == typeof(Int32))
                            {
                                aux_value = ((Int32)kvp.Value); //.ToString(); //.Replace(".", "");
                            }
                            if (kvp.Value.GetType() == typeof(String))
                            {
                                aux_value = ((String)kvp.Value); // == string.Empty || ((String)kvp.Value) == null ? "0" : kvp.Value.ToString();
                            }
                            prop.SetValue(source, aux_value);
                        }
                    }

                }//endforeach 
            }
            catch (Exception)
            {
                throw;
            }
        }
    }

    /// <summary>
    /// Clase contexto de log.
    /// </summary>
    [Serializable()]
    public class LogContext : IDisposable
    {
        /// <summary>
        /// Indica si esta abilitado el log de errores
        /// </summary>
        public bool isEnable { get; set; }
        /// <summary>
        /// Indica el nombre del archivo de error
        /// </summary>        
        /// <remarks> Por defecto App_YYYYMMDD.log</remarks>
        public string LogFileName { get { return _logFileName; } set { _logFileName = value; } }
        private string _logFileName;

        private bool _friendlyLog = true;
        /// <summary>
        /// Indica si se mostrara una version mas amigable del log (sin el stacktrace completo), default:true
        /// </summary>
        /// <remarks>Indica si mostrara el stacktrace completo de las excepciones o solo el archivo y numeros de lineas</remarks>
        /// <value>Por default True</value>
        public bool FriendlyLog { get { return _friendlyLog; } set { _friendlyLog = value; } }


        private bool _AsyncWriteLog = false;
        /// <summary>
        /// Indica si se escribira el log de aplicacion de manera asincrona.
        /// </summary>
        public bool AsyncWriteLog
        {
            get { return this._AsyncWriteLog; }
            set { this._AsyncWriteLog = value; }
        }


        #region Implementacion IDisposable
        public LogContext()
        {
            _logFileName = "App_" + DateTime.Now.ToString("YYYYmmdd") + ".log";
        }

        public LogContext(string fileName)
        {
            if (string.IsNullOrEmpty(fileName) || string.IsNullOrWhiteSpace(fileName))
            {
                throw new ArgumentNullException("fileName", "El nombre de archivo no puede ser nulo");
            }
            else
            {
                _logFileName = fileName;
            }
        }


        ~LogContext()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        private bool disposed = false;
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.                  
                }
                disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion


    }

}
