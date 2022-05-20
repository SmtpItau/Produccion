
namespace AdminOpciones.Struct
{
    public class StructMenu
    {
        public StructMenu() { }
        public StructMenu(string entidad,
                          string opcion,
                          string habilitado)
        {
            Entidad = entidad;
            Opcion = opcion;
            Habilitado = habilitado;
        }

        public string Entidad { get; set; }
        public string Opcion { get; set; }
        public string Habilitado { get; set; }

        public string sEntidad 
        {
            get 
            {
                if (Entidad != "" && Entidad != null)
                {
                    return this.Entidad.ToString();
                }
                else
                { 
                    return "";
                }
            }
        }

        public string sOpcion 
        {
            get 
            {
                if (Opcion != "" && Opcion != null)
                {
                    return this.Opcion.ToString();
                }
                else
                {
                    return "";
                }
            }
        }

        public string sHabilitado 
        {
            get 
            {
                if (Habilitado != "" && Habilitado != null)
                {
                    return this.Habilitado.ToString();
                }
                else 
                {
                    return "";
                }
            }
        }        
    }
}
