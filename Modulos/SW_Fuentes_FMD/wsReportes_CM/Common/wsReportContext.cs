using System.Collections.Generic;
using System.IO;
using CoreLib.Common;
using CoreLib.Common.Collections;


namespace WebServiceFMD.Common
{
    /// <summary>
    /// Extension para clase appcontext
    /// </summary>
    public class wsReportContext : AppContext
    {
        private DBContextCollection<DBContext> _DBContextCollection = new DBContextCollection<DBContext>();
        private List<string> _systems = new List<string>();
        private List<string> _reportType = new List<string>();
        private DirectoryInfo _download;
        private DirectoryInfo _log;
        private DirectoryInfo _template;
        private DirectoryInfo _upload;
        private DirectoryInfo _rootFolder;
        
        /// <summary>
        /// Constructor publico
        /// </summary>
        public wsReportContext()
        {
        }
        
        /// <summary>
        /// Coleccion de contextos de conexion a bd.
        /// </summary>
        public DBContextCollection<DBContext> DBContextCollection
        {
            get { return _DBContextCollection; }
            set { _DBContextCollection = value; }
        }
        /// <summary>
        /// Directorio de descarga.
        /// </summary>
        public string DownloadFolder { get { return _download.FullName; } set { _download = new DirectoryInfo(value); } }

        /// <summary>
        /// Directorio para el log de proceso.
        /// </summary>
        public string LogFolder { get { return _log.FullName; } set { _log = new DirectoryInfo(value); } }

        /// <summary>
        /// Directorio para los archivos de Plantilla(TemplateData).
        /// </summary>
        public string TemplateFolder { get { return _template.FullName; } set { _template = new DirectoryInfo(value); } }

        /// <summary>
        /// Directorio de entrega de archivos para cargar.
        /// </summary>
        public string UploadFolder { get { return _upload.FullName; } set { _upload = new DirectoryInfo(value); } }



        /// <summary>
        /// Directorio base de entrega de archivos 
        /// </summary>
        public string InterfaceRootFolder { get { return _rootFolder.FullName; } set { _rootFolder = new DirectoryInfo(value); } }


        /// <summary>
        /// Habilita procesamiento de 1 archivo a generacion de N archivos segun datos a exportar
        /// </summary>
        public bool AllowPaging { get; set; }


        /// <summary>
        /// Habilita la eliminacion en el proceso de copia y respaldo de archivos procesados.
        /// </summary>
        public bool DeleteFiles { get; set; }

    }
}