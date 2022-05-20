using System;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Globalization;
using System.Xml.Serialization;
using System.Xml;
using System.Runtime.Serialization;

namespace CoreLib.Common
{
    /// <summary>
    /// Clase contexto para envio de correo
    /// </summary>
    [Serializable()]
    [XmlType("MailContext")]
    [DataContract(Name="MailContext")]
    public class MailContext : IDisposable
    {
        /// <summary>
        /// Guid Unico de Instancia
        /// </summary>
        protected Guid? _UniqueID = Guid.NewGuid();

        /// <summary>
        /// Guid de Instancia
        /// </summary>
        [XmlIgnore]        
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }


        /// <summary>
        /// Direccion IP o direccion del servidor de correo ej: smtp.googlemail.com
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string MailServer { get; set; }
        
        /// <summary>
        /// Cuenta de correo desde el cual se envia el mensaje
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string MailAccount { get; set; }

        /// <summary>
        /// Contraseña de correo desde el cual se envia el mensaje
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string MailAccountPass { get; set; }

        /// <summary>
        /// Habilita conexion SSL
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public bool MailSSL { get { return _mailssl; } set { _mailssl = value; } }
        private bool _mailssl = false;


        /// <summary>
        /// Especifica si usa la red para enviar el correo
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public bool UseNetworkForDelivery { get { return _useNetwork; } set { _useNetwork = value; } }
        private bool _useNetwork = false;


        private int _timeOut = 300; //Equivamente a 3 segundos
        /// <summary>
        /// Especifica el timeout del servicio para cliente SMTP.
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public int TimeOut { get { return _timeOut; } set { _timeOut = value; } }

        /// <summary>
        /// Habilita el envio de correo 
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public bool MailEnable { get; set; }

        /// <summary>
        /// Puerto de correo, default:25
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public int MailPort { get { return _mailport; } set { _mailport = value; } }
        private int _mailport = 25;

        ///// <summary>
        ///// Puerto SSL, default:443
        ///// </summary>
        //public int MailSSLPort { get; set; }
        //private int _mailsslport = 443;

        /// <summary>
        /// Valida que esten los datos basicos de conexion para realizar un envio
        /// </summary>
        ///<returns>true: estan los datos minimos para el envio</returns>        
        public bool ValidContext()
        {
            string error = string.Empty;
            string param = string.Empty;
            if (this.UseNetworkForDelivery == true)
            {
                if (this.MailAccount == string.Empty || this.MailAccount.Trim() == "")
                {
                    error = "No se encuentra la cuenta de envio de correo";
                    param = "MailAccount";
                }

                if (this.MailServer == string.Empty || this.MailServer.Trim() == "")
                {
                    error = "No se encuentra la direccion del servidor de correo";
                    param = "MailServer";
                }
            }
            else
            {
                if (this.MailAccount == string.Empty || this.MailAccount.Trim() == "")
                {
                    error = "No se encuentra la cuenta de envio de correo";
                    param = "MailAccount";
                }
                if (this.MailAccountPass == string.Empty || this.MailAccountPass.Trim() == "")
                {
                    error = "No se encuentra el password de la cuenta de envio";
                    param = "MailAccountPass";
                }
                if (this.MailServer == string.Empty || this.MailServer.Trim() == "")
                {
                    error = "No se encuentra la direccion del servidor de correo";
                    param = "MailServer";
                }

                if (this.MailSSL == true)
                {
                    if (this.MailPort == 0)
                    {
                        error = "No se encuentra el puerto del servidor de correo";
                        param = "MailPort";
                    }
                }

            }

            if (error != string.Empty)
            {
                throw new ArgumentException(error);
            }
            return true;
        }


        #region Implementacion IDisposable
        public MailContext() { }
        ~MailContext()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        private bool disposed = false;
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.

                }
                disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion
    }
}
