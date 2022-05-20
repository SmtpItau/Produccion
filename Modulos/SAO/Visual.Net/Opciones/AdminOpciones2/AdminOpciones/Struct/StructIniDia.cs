namespace AdminOpciones.Struct
{
    public class StructIniDia
    {
        public StructIniDia() { }
        public StructIniDia(string fechaproc,
                          string fechaant,
                          string fechaprox,
                          string iniciodia )
        {
            FechaProc = fechaproc;
            FechaAnt = fechaant;
            FechaProx = fechaprox;
            InicioDia = iniciodia;
        }

        public string FechaProc { get; set; }
        public string FechaAnt { get; set; }
        public string FechaProx { get; set; }
        public string InicioDia { get; set; }

        public string sFechaProc
        {
            get
            {
                if (FechaProc != "" && FechaProc != null)
                {
                    return this.FechaProc.ToString();
                }
                else
                {
                    return "";
                }
            }
        }

        public string sFechaAnt
        {
            get
            {
                if (FechaAnt != "" && FechaAnt != null)
                {
                    return this.FechaAnt.ToString();
                }
                else
                {
                    return "";
                }
            }
        }

        public string sFechaProx
        {
            get
            {
                if (FechaProx != "" && FechaProx != null)
                {
                    return this.FechaProx.ToString();
                }
                else
                {
                    return "";
                }
            }
        }

        public string sInicioDia
        {
            get
            {
                if (InicioDia != "" && InicioDia != null)
                {
                    return this.InicioDia.ToString();
                }
                else
                {
                    return "";
                }
            }
        }
    }
}