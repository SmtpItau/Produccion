using System;
using System.Runtime.Serialization;

namespace WindowsServiceFMD.Common.Enums
{
    [Serializable]
    [DataContract(Name = "ProcessType")]
    public enum ProcessType
    {
        Input = 0,
        Output = 1
    }

    [Serializable]
    [DataContract(Name = "CheckProcess")]
    public enum CheckProcess
    {
        Inicio_Dia = 0,
        Fin_Dia = 1,
        Apertura_Mesa = 2,
        Cierre_Mesa = 3,
        Devengo = 4        
    }

    /// <summary>
    /// Indica al sistema cual va a ser el motor de exportacion/importacion
    /// </summary>
    public enum Engine
    {
        /// <summary>Excel Engine (OpenExcel standar), para utilizar plantilla de volcado de datos.</summary>
        Excel = 0,

        /// <summary>Excel Engine (OpenExcel standar), para utilizar exportacion directa (sin plantilla para volcado de datos)/// </summary>
        ExcelRaw = 1,

        /// <summary>Plain Text/CSV (fixed field size)</summary>
        PlainText = 2,

        /// <summary>Plain Text/CSV Volcado en bruto...</summary>
        PlainTextRaw = 3,

        /// <summary>Xml Engine</summary>
        Xml = 4
    }


}
