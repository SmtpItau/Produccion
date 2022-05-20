namespace AdminOpciones.Struct
{
    public class StructFechaProxH
    {
        public StructFechaProxH() { }
        public StructFechaProxH(string fechaprox,
                          string fecharet)
        {
            FechaProx = fechaprox;
            FechaRet = fecharet;
        }

        public string FechaProx { get; set; }
        public string FechaRet { get; set; }

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

        public string sFechaRet
        {
            get
            {
                if (FechaRet != "" && FechaRet != null)
                {
                    return this.FechaRet.ToString();
                }
                else
                {
                    return "";
                }
            }
        }
    }
}
