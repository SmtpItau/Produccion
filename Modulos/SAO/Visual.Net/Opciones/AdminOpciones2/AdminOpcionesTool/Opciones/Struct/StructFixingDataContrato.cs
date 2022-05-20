using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdminOpcionesTool.Opciones.Struct
{
    public class StructFixingDataContrato
    {
        public int NumContrato { get; set; }
        public int NucEstructura { get; set; } // componente de la estructura
        public List<StructFixingData> Fijaciones;


        public StructFixingDataContrato()
        {
            Fijaciones = new List<StructFixingData>();
        }
    }
}
