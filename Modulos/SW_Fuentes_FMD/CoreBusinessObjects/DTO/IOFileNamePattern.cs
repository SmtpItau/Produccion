#pragma warning disable 1591
using System;
using System.Xml;
using System.Xml.Serialization;

namespace CoreBusinessObjects.DTO
{
    /// <summary>
    /// Representa parametrizacion del nombre de archivo de salida para TemplateData
    /// </summary>
    /// <remarks>
    /// El resultado se conforma de la sig forma:
    /// <c>Prefix + Pattern&gt;useDatePattern|useNumericPattern&lt;+Suffix.Extension</c>
    /// </remarks>
    [Serializable()]
    [XmlType("IOFileNamePattern")]
    public class IOFileNamePattern : IDisposable
    {
        #region Private Members

        private bool _useDatePattern;

        /// <summary>guid del objeto</summary>
        protected Guid? _UniqueID;

        private bool _useNumericPattern;
        
        #endregion
        #region Properties
        /// <summary>Id Interno del objeto</summary>
        [XmlIgnore]
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }
                
        /// <summary>Prefijo para nombre de archivo</summary>
        [XmlElement("Prefix")]
        public string Prefix { get; set; }
        public bool ShouldSerializePrefix() {
            return !string.IsNullOrEmpty(this.Prefix);
        }
        
        /// <summary>
        /// Patron personalizado a utilizar en caso de:
        /// ej : 
        /// - DatePattern    : yyyyMMdd | yyyyMMdd_Hmmss
        /// - NumericPattern : N0 (en base 1) | 9## -> 901,902, etc -> experimental.
        /// </summary>
        [XmlElement("Pattern")]
        public string Pattern { get; set; }
        public bool ShouldSerializePattern() {
            return !string.IsNullOrEmpty(this.Pattern);
        }


        /// <summary>Sufijo para nombre de archivo</summary>
        [XmlElement("Suffix")]
        public string Suffix { get; set; }
        public bool ShouldSerializeSuffix() {
            return !string.IsNullOrEmpty(this.Suffix);
        }



        /// <summary>Extension del archivo</summary>
        /// <remarks>
        /// No implica necesariamente que el archivo a generar cumpla con la extension del archivo.
        /// </remarks>
        [XmlElement("Extension")]
        public string Extension { get; set; }
        public bool ShouldSerializeExtension() {
            return !string.IsNullOrEmpty(this.Extension);
        }

        
        /// <summary>Indica si usa patron de fecha para la generacion del nombre de archivo</summary>
        [XmlElement("useDatePattern")]
        public bool useDatePattern {
            get { return _useDatePattern; }
            set {
                if (value)
                {
                    _useDatePattern = value;
                    _useNumericPattern = false;
                }
                else {
                    _useDatePattern = value;
                    _useNumericPattern = true;
                }
            }         
        }

        /// <summary>Indica si usa patron de numero para generacion del nombre de archivo.</summary>
        /// <remarks>Experimental...</remarks>
        [XmlElement("useNumericPattern")]
        public bool useNumericPattern {
            get { return _useNumericPattern; }
            set {
                if (value)
                {
                    _useNumericPattern = value;
                    _useDatePattern = false;
                }
                else {
                    _useNumericPattern = value;
                    _useDatePattern = true;
                }
            }        
        }
        #endregion
        #region Methods
        /// <summary>
        /// Devuelve un nombre de archivo con la forma
        /// <c>Prefix + Pattern&gt;useDatePattern|useNumericPattern&lt;+Suffix.Extension</c>
        /// </summary>        
        /// <returns>string con el nombre de archivo generado, utiliza el patrón como parte de.</returns>              
        public string newFileName()
        {
            int pos = Extension.IndexOf(".");
            if (pos > 0)
            {
                Extension = Extension.Replace(".", "_");
            }
            else if (pos == 0)
            {
                Extension = Extension.Replace(".", "");
            }

            string tmp = Prefix + "{0}" + Suffix + "." + Extension;
            string pattern = string.Empty;
            if (_useDatePattern == true)
            {
                DateTime date = DateTime.Now;
                pattern = date.ToString(Pattern);

                return string.Format(tmp, pattern);
            }
            if (_useNumericPattern == true)
            {
                int seed = 1;
                pattern = seed.ToString(Pattern);
                return string.Format(tmp, pattern);
            }
            return string.Empty; //dummy return
        }

        /// <summary>
        /// Devuelve un nombre de archivo con la forma
        /// <c>Prefix + Pattern&gt;useDatePattern|useNumericPattern&lt;+Suffix.Extension</c>
        /// </summary>
        /// <param name="seed">semilla numerica para generar nombre de archivo (experimental)</param>
        /// <returns>string con el nombre de archivo generado</returns>    
        public string newFileName(int seed)
        {
            int pos = Extension.IndexOf(".");
            if (pos > 0)
            {
                Extension = Extension.Replace(".", "_");
            }
            else if (pos == 0)
            {
                Extension = Extension.Replace(".", "");
            }




            string tmp = Prefix + "{0}" + Suffix + "." + Extension;
            string result = string.Empty;
            if (_useDatePattern == true)
            {
                throw new ArgumentOutOfRangeException("seed", "Se esperaba un INT para continuar.");
            }

            try
            {
                string seed_tmp = seed.ToString(Pattern);
                result = String.Format(tmp, seed_tmp);
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Devuelve un nombre de archivo con la forma
        /// <c>Prefix + Pattern&gt;useDatePattern|useNumericPattern&lt;+Suffix.Extension</c>
        /// </summary>
        /// <param name="seed">semilla de fecha para generar nombre de archivo</param>
        /// <returns>string con el nombre de archivo generado</returns>    
        public string newFileName(DateTime seed)
        {
            //  Extension = Extension.Replace(".", "_"); //asumiendo que esta en primera posicion
            int pos = Extension.IndexOf(".");
            if (pos > 0)
            {
                Extension = Extension.Replace(".", "_");
            }
            else if (pos == 0)
            {
                Extension = Extension.Replace(".", "");
            }

            string tmp = Prefix + "{0}" + Suffix + "." + Extension;
            string result = string.Empty;
            if (_useNumericPattern == true)
            {
                throw new ArgumentOutOfRangeException("seed", "Se esperaba una fecha para continuar.");
            }

            try
            {
                string seed_tmp = seed.ToString(Pattern);
                result = String.Format(tmp, seed_tmp);
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }

        #endregion
        #region Implementacion IDisposable

        /// <summary>Default Constructor</summary>
        public IOFileNamePattern()
        {
            this._UniqueID = Guid.NewGuid();
        }

        /// <summary>Default Destructor</summary>
        ~IOFileNamePattern()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        /// <summary>Disposing Flag</summary>
        private bool disposed = false;

        /// <summary>Virtual Dispose Method</summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.
                    //this._ExcelFile = null;
                }
                disposed = true;
            }
        }

        /// <summary>Dispose Method</summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion
    }
}
