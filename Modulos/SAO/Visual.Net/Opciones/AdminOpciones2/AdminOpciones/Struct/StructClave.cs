using System;

namespace AdminOpciones.Struct
{
    public class StructClave
    {
        public StructClave() { }
        public StructClave(string clave, string tipousuario, DateTime fechaexpiracion, string cambioclave, bool bloqueado, int reset, int largo, string tipoClave)
        {
            __Clave = clave;
            __TipoUsuario = tipousuario;
            __FechaExpiracion = fechaexpiracion;
            __CambioClave = cambioclave;
            __Bloqueado = bloqueado;
            __ResetPassword = reset;
            __LargoPassword = largo;
            __TipoClave = tipoClave;
        }

        public StructClave(string clave, string clave1, string clave2, string clave3, string clave4, string clave5, string tipousuario, DateTime fechaexpiracion, string cambioclave, bool bloqueado, int reset, int largo, string tipoClave, int diasexpira)
        {
            __Clave = clave;
            __Clave1 = clave1;
            __Clave2 = clave2;
            __Clave3 = clave3;
            __Clave4 = clave4;
            __Clave5 = clave5;
            __TipoUsuario = tipousuario;
            __FechaExpiracion = fechaexpiracion;
            __CambioClave = cambioclave;
            __Bloqueado = bloqueado;
            __ResetPassword = reset;
            __LargoPassword = largo;
            __TipoClave = tipoClave;
            __DiasExpira = diasexpira;                                   
        }

        public StructClave(StructClave value)
        {
            __Clave = value.Clave;
            __Clave1 = value.Clave1;
            __Clave2 = value.Clave2;
            __Clave3 = value.Clave3;
            __Clave4 = value.Clave4;
            __Clave5 = value.Clave5;
            __TipoUsuario = value.TipoUsuario;
            __FechaExpiracion = value.FechaExpiracion;
            __CambioClave = value.CambioClave;
            __Bloqueado = value.Bloqueado;
            __ResetPassword = value.ResetPassword ;
            __LargoPassword = value.LargoPassword ;
            __TipoClave = value.TipoClave;
        }

        private string __Clave { get; set; }
        private string __Clave1 { get; set; }
        private string __Clave2 { get; set; }
        private string __Clave3 { get; set; }
        private string __Clave4 { get; set; }
        private string __Clave5 { get; set; }
        private string __TipoUsuario { get; set; }
        private DateTime __FechaExpiracion { get; set; }
        private string __CambioClave { get; set; }
        private bool __Bloqueado { get; set; }
        private int __ResetPassword { get;set; }
        private int __LargoPassword { get; set; }
        private string __TipoClave { get; set; }
        private int __DiasExpira { get; set; }


        public string Clave
        {
            get
            {
                return __Clave;
            }
        }

        public string Clave1
        {
            get
            {
                return __Clave1;
            }
        }

        public string Clave2
        {
            get
            {
                return __Clave2;
            }
        }

        public string Clave3
        {
            get
            {
                return __Clave3;
            }
        }

        public string Clave4
        {
            get
            {
                return __Clave4;
            }
        }

        public string Clave5
        {
            get
            {
                return __Clave5;
            }
        }

        public string TipoUsuario
        {
            get
            {
                return __TipoUsuario;
            }
        }

        public DateTime FechaExpiracion
        {
            get
            {
                return __FechaExpiracion;
            }
        }

        public string CambioClave
        {
            get
            {
                return __CambioClave;
            }
        }

        public bool Bloqueado
        {
            get
            {
                return __Bloqueado;
            }
        }

        public int ResetPassword
        {
            get
            {
                return __ResetPassword;
            }
        }

        public int LargoPassword
        {
            get
            {
                return __LargoPassword;
            }
        }

        public string TipoClave
        {
            get
            {
                return __TipoClave;
            }
        }

        public int DiasExpira
        {
            get
            {
                return __DiasExpira;
            }
        }

    }
}
