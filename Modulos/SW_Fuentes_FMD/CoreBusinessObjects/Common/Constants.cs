using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CoreBusinessObjects.Common
{
    /// <summary>
    /// Clase que expone constantes publicas de mensajes para las capas de negocio 
    /// </summary>
    public class Constants
    {
        #region Constantes publicas
        /// <summary>Mensaje que indica que no se puede encontrar el/los archivos </summary>
        public const string MSG_FILE_NOTFOUND = "No se puede(n) encontrar el/los archivo(s) {0}";
        /// <summary>Mensaje que indica que el archivo no tiene el formato correcto </summary>
        public const string MSG_FILE_EXTENSION = "El/los archivo(s), no tiene(n) el formato correcto: {0}";
        /// <summary>Mensaje que indica que el nombre de archivo no puede ser nulo o vacio </summary>
        public const string MSG_FILE_EMPTYNAME = "El nombre de archivo no puede ser nulo o vacio ";
        /// <summary>Mensaje que indica que el parametro no puede ser nulo o vacio </summary>
        public const string MSG_PARAM_NOT_NULL = "El parametro no puede ser nulo o vacio";
        /// <summary>Mensaje que indica que se deben cargar los datos de la plantilla </summary>
        public const string MSG_TDATA_NOT_NULL = "Debe cargar los datos de la plantilla antes de continuar";
        /// <summary>Mensaje que indica que la plantilla esta configurada para solo entrada </summary>
        public const string MSG_TDATA_INPUT = "La plantilla esta configurada para solo entrada de datos. No puede continuar.";
        /// <summary>Mensaje que indica que la plantilla esta configurada para solo salida </summary>
        public const string MSG_TDATA_OUTPUT = "La plantilla esta configurada para solo salida  de datos. No puede continuar.";
        /// <summary>Mensaje que indica que la columna de extraccion esta fuera de los rangos de los datos importados</summary>
        public const string MSG_TDATA_COLUMN = "La columna de extracción se encuentra\r\nfuera de rango de los datos importados";
        /// <summary>Mensaje que indica que la plantilla no contiene columnas de entrada </summary>
        public const string MSG_TDATA_EMPTY_COLUMNS = "La plantilla no contiene columnas de entrada";
        /// <summary>Mensaje que indica que la plantilla no especifica filas de entrada. </summary>
        public const string MSG_TDATA_EMPTY_ROWS = "La plantila no especifica filas de entrada";
        /// <summary>Mensaje que indica que la fila de extraccion se encuentra fuera del rango de datos importados</summary>
        public const string MSG_TDATA_ROW = "La fila de extracción se encuentra\r\nfuera de rango de los datos importados";
        /// <summary>Mensaje que indica que no se encuentra la hoja excel solicitada </summary>
        public const string MSG_TDATA_SHEET_NOT_FOUND = "La hoja solicitada no se encuentra.";
        /// <summary>Mensaje que indica que no se encuentran parametros en el storeprocedure </summary>
        public const string MSG_TDATA_STOREPARAMS_NOT_NULL = "No se encuentran parametros para store procedure {0}";
        /// <summary>Mensaje que indica que no se encuentra el store procedure </summary>
        public const string MSG_TDATA_STOREPROCS_NOT_NULL = "No se encuentra el store procedure {0}";
        /// <summary>Mensaje que indica que no se encuentra el valor del parametro </summary>
        public const string MSG_TDATA_STOREPARAMS_VALUE = "No se encuentra valor parametro @{0}";
        
        //public const string MSG_TDATA_STOREPROCS_OUTPUT = "";
        //public const string MSG_TDATA_STOREPROCS_INPUT = "E";

        /// <summary>Mensaje que indica que no se encuentra el archivo de consulta </summary>
        public const string MSG_TDATA_QUERYFILE_NOTFOUND = "No se puede encontrar el archivo de consulta {0}";
        /// <summary>Mensaje que indica que no se encuentra la cadena de consulta</summary>
        public const string MSG_TDATA_QUERY_NOTNULL = "La cadena de consulta no puede estar vacia. \r\n Revise la plantilla para continuar";
        /// <summary>Mensaje que indica que la plantilla esta mal configurada</summary>
        public const string MSG_TDATA_MISSCONFIG = "La plantilla se encuentra mal configurada\r\n Revise la plantilla e intente nuevamente";

        /// <summary>Mensaje que indica que no se encuentra el patron de generacion de nombres de archivo</summary>
        public const string MSG_TDATA_FILENAMEPATTERN = "No se encuentra patron de nombres para generar archivos";
        
        /// <summary>Mensaje que indica que  se deben cargar datos antes de exportar</summary>
        public const string MSG_DATA_NOT_NULL = "Debe procesar/cargar los datos antes de continuar";
        /// <summary>Mensaje que indica que no se encuentra datos para exportar  </summary>
        public const string MSG_DATA_NOT_FOUND = "No se encuentran datos para exportar/importar";

        /// <summary>Mensaje que indica que no coinciden DataSet.Tables vs ValueSource(TData)</summary>
        public const string MSG_TDATA_SOURCE_MISMATCH = "Las tablas del conjunto de datos no coinciden con opcion: ValueSource";
        
        /// <summary>Mensaje que indica que no se encuentra el valor fuente en las tablas del conjunto de datos.</summary>
        public const string MSG_TDATA_SOURCE_NOTFOUND = "No se puede encontrar la tabla[{0}], de opcion: ValueSource";

        /// <summary>Mensaje que indica que el valor del parametro/opcion no puede ser 0</summary>
        public const string MSG_TDATA_ZERO_VALUE = "El parametro no puede ser 0";

        /// <summary>Mensaje que indica que tamaño (del parametro/cadena) no es valido.</summary>
        public const string MSG_TDATA_INVALID_SIZE = "Tamaño invalido.";
        
        #endregion
    }
}
