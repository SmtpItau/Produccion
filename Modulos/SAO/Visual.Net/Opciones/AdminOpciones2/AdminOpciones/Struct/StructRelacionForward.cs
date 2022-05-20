using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace AdminOpciones.Struct
{
    /// <summary>
    /// Modela los tipos de relaciones.
    /// </summary>
    public class StructRelacion
    {
        public string CodigoRelacion { get; set; }
        public string DescripcionRelacion { get; set; }
    }

    /// <summary>
    /// Modela la relación entre un par de Leasing-Bien con un par Contrato-Folio de Forward.
    /// </summary>
    public class StructRelacionForward
    {
        public string ReNumeroLeasing { get; set; }
        public string ReNumeroBien { get; set; }
        public string ReCaNumContrato { get; set; }
        public string ReCaNumFolio { get; set; }
    }
}
