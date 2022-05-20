using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.DTO;

namespace CoreBusinessObjects.Common
{
    #region ENUMS PARA TemplateDataAddress
    
    /// <summary>    
    /// Indica direccion de volcado/extracción de los datos en el excel
    /// </summary>    
    /// <remarks>
    /// Hay que distinguir dos procesos: 
    /// - Escritura Excel (cuando se vuelcan los datos en el archivo), por lo tanto la direccion es OutPut
    /// - Lectura Excel (cuando se va a procesar de vuelta el archivo), por lo tonto la direccion es Input
    /// </remarks>
    public enum DataDirection
    {
        /// <summary>
        /// Indica que la celda/plantilla/store proc. es de solo entrada (para proceso de lectura)
        /// </summary>
        Input = 0,
        /// <summary>
        /// Indica que la celda/plantilla/store proc. es de entrada/salida (por lo tanto se procesara en la lectura y escritura de archivo)
        /// </summary>
        InputOutput = 1,
        /// <summary>
        /// Indica que la celda/plantilla/store proc. es de solo salida (para proceso de escritura)
        /// </summary>
        Output = 2
    }


    /// <summary>
    /// Indica la alineacion de la data (para motor PlainText)
    /// </summary>
    public enum Align
    { 
        /// <summary>Alineacion de la data a al derecha</summary>
        Right = 0,
        /// <summary>Alineacion de la data a la izquierda</summary>
        Left = 1
    }


    /// <summary>
    /// Indica al sistema cual va a ser el motor de exportacion/importacion
    /// </summary>
    public enum Engine {         
        /// <summary>Excel Engine (OpenExcel standar), para utilizar plantilla de volcado de datos.</summary>
        Excel = 0,
        
        /// <summary>Excel Engine (OpenExcel standar), para utilizar exportacion directa (sin plantilla para volcado de datos)/// </summary>
        ExcelRaw = 1,

        /// <summary>Plain Text/CSV (fixed field size)</summary>
        PlainText =2,

        /// <summary>Plain Text/CSV Volcado en bruto...</summary>
        PlainTextRaw = 3,

        /// <summary>Xml Engine</summary>
        Xml = 4
    }

    /// <summary>
    /// Indica el tipo de proceso que esta realizando el programa
    /// </summary>
    public enum ProcessEngineType { 
        /// <summary>
        /// Proceso Input (Ingreso de Datos a/los sistema(s))
        /// </summary>
        Input = 0,
        /// <summary>
        /// Proceso Output (Salidad de datos a/los sistema(s))
        /// </summary>
        Output =1    
    }


    /// <summary>
    /// Indica direccion del directorio de copia 
    /// </summary>
    public enum FolderDirection { 
        /// <summary>
        /// Indica si es de solo entrada
        /// </summary>
        Input =0,

        /// <summary>
        /// Indica si es de solo salida
        /// </summary>
        Output = 1,
    
        /// <summary>
        /// Indica si el directorio es de respaldo //se ignora el directorio
        /// </summary>
        Backup = 2,

        /// <summary>
        /// Indica si se ignora el directorio
        /// </summary>
        Ignore = 3
    }


    #endregion    
}
