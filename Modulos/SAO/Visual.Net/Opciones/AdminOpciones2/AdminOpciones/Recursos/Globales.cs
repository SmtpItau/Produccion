using System;
using System.Windows.Input;
using System.Windows;
using System.Collections.Generic;
using AdminOpciones.Struct;
using System.ServiceModel;

namespace AdminOpciones.Recursos
{
    public static class globales
    {
        ////etiqueta
        //public static string Valor = "ALGO"; metodo sucio pero funca

        private static string _usuario = string.Empty;
        public static string _Usuario
        {
            get { return _usuario; }
            set { _usuario = value; }
        }

        private static string _terminal = string.Empty;
        public static string _Terminal
        {
            get { return _terminal; }
            set { _terminal = value; }
        }

        private static DateTime __FechaProceso = DateTime.Now;
        public static DateTime FechaProceso
        {
            get
            {
                return __FechaProceso;
            }
            set
            {
                __FechaProceso = value;
            }
        }


        private static string _fechaproceso = string.Empty;
        public static string _FechaProceso
        {
            get { return _fechaproceso; }
            set { _fechaproceso = value; }
        }

        private static int _iniciodia = 0;
        public static int _InicioDia 
        {
            get { return _iniciodia; }
            set { _iniciodia = value; }
        }

        private static string _estado = string.Empty;
        public static string _Estado 
        {
            get { return _estado; }
            set {_estado = value;}
        }


        private static string _region = string.Empty;
        public static string _Region
        {
            get { return _region; }
            set { _region = value; }
        }

        private static int _numcontrato = 0;
        public static int _NumContrato 
        {
            get { return _numcontrato; }
            set { _numcontrato = value; }
        }

        private static int _cierremesa = 0;
        public static int _CierreMesa
        {
            get { return _cierremesa; }
            set { _cierremesa = value; }
        }

        private static List<StructCaContrato> _contrato = new List<StructCaContrato>();
        public static List<StructCaContrato> _Contrato
        {
            get { return _contrato; }
            set { _contrato = value; }
        }

        private static List<StructMoCotizacion> _cotizacion = new List<StructMoCotizacion>();
        public static List<StructMoCotizacion> _Cotizacion
        {
            get { return _cotizacion; }
            set { _cotizacion = value; }
        }

        private static int _numcotizacion = 0;
        public static int _NumCotizacion
        {
            get { return _numcotizacion; }
            set { _numcotizacion = value; }
        }

        private static bool _valida = false;
        public static bool _Valida 
        {
            get { return _valida; }
            set { _valida = value; }
        }

        private static int _numfolio = 0;
        public static int _NumFolio 
        {
            get { return _numfolio; }
            set { _numfolio = value; }
        }

        private static int _clirut = 0;
        public static int _CliRut
        {
            get { return _clirut; }
            set { _clirut = value; }
        }

        private static int _clicod = 0;
        public static int _CliCod
        {
            get { return _clicod; }
            set { _clicod = value; }
        }

        private static bool _limpiar = false;
        public static bool _Limpiar
        {
            get { return _limpiar; }
            set { _limpiar = value; }
        }

        private static string _sDA = string.Empty;
        public static string _SDA
        {
            get { return _sDA; }
            set { _sDA = value; }
        }

        private static bool _turing = false;
        public static bool _Turing
        {
            get { return _turing; }
            set { _turing = value; }
        }

        private static string _usuario_turing = string.Empty;
        public static string _Usuario_turing
        {
            get { return _usuario_turing; }
            set { _usuario_turing = value; }
        }

        private static string _password_turing = string.Empty;
        public static string _Password_turing
        {
            get { return _password_turing; }
            set { _password_turing = value; }
        }

        public static string _FechaContrato1 { get; set; }
        public static string _FechaContrato2 { get; set; }
        public static string _FechaEjercicio1 { get; set; }
        public static string _FechaEjercicio2 { get; set; }
    }

    /// <summary>
    /// Clase con definiciones globales de WS.
    /// Seguro que hay una mejor forma de implementar esto nativamente en .Net
    /// OJO, en controles XAML, declarar el SoapClient en la Clase, pero instanciar en el constructor o genera una UriFormatException.
	/// También al parecer importa que el evento de Completed se asigne en la misma función en que se invoca el Async.
    /// </summary>
    public static class wsGlobales
    {
        public static string UriArticulo84 {get; set; }

        public static string UriTomaLinea {get; set;}

        private static string _baseuri = string.Empty;
        /// <summary>
        /// Contiene la ruta base del sitio con la publicación de la solución.
        /// Se instancia automáticamente en el Startup del Silverlight.
        /// Ej: "http://corpbanca.cl:80/" OJO con "/" al final.
        /// </summary>
        public static string BaseUri
        {
            get { return _baseuri; }
            set { _baseuri = value; }
        }

        private static string _basedir = string.Empty;
        /// <summary>
        /// Contiene la ruta base del directorio virtual en el que puede estar publicado el sistema.
        /// Se instancia automáticamente en el Startup del Silverlight.
        /// Ej: "/AdminOpcionesCERT/" o "/", OJO con el "/" final.
        /// </summary>
        public static string BaseDir
        {
            get { return _basedir; }
            set { _basedir = value; }
        }

        private static string _fulluri = string.Empty;
        /// <summary>
        /// Entrega la ruta completa de acceso a los elementos publicados en el sistema.
        /// Se construye como: BaseUri + BaseDir, OJO con el "/" final.
        /// Ej: "http://corpbanca.cl:80/AdminOpcionesCERT/"
        /// Ej: "http://sao.corpbanca.cl/"
        /// </summary>
        public static string FullUri
        {
            get { return _baseuri + _basedir; }
        }

        /// <summary>
        /// BasicHttpBinding instanciado, para todos los WebServices.
        /// </summary>
        public static System.ServiceModel.BasicHttpBinding Binding
        {
            get
            {
                System.ServiceModel.BasicHttpBinding b = new System.ServiceModel.BasicHttpBinding();

                b.OpenTimeout       = new TimeSpan(0, 20, 0);
                b.ReceiveTimeout    = new TimeSpan(0, 20, 0);
                b.SendTimeout       = new TimeSpan(0, 20, 0);
                b.CloseTimeout      = new TimeSpan(0, 20, 0);

                b.MaxBufferSize = 2147483647;
                b.MaxReceivedMessageSize = 2147483647;
                
                return b;
            }
        }



        #region Endpoint's

        /// <summary>
        /// EndpointAddress para SrvConfig.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPConfig
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/SrvConfig.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para WebAcciones.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPWebAcciones
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/WebAcciones.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para SrvValorizadorCartera.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvValorizadorCartera
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/ValoriadorCartera/SrvValorizadorCartera.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para WebDetalles.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPWebDetalles
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/WebDetalles.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para WebLogin.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPWebLogin
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/WebLogin.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para SrvAsiaticas.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvAsiaticas
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/Asiatica/SrvAsiaticas.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para BDOpciones.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPBDOpciones
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/BDOpciones/BDOpciones.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para SrvCurvasMonedas.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvCurvasMonedas
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/ValoriadorCartera/SrvCurvasMonedas.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para SrvCustomers.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvCustomers
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/Customers/SrvCustomers.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para SrvEstructura.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvEstructura
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/Estructura/SrvEstructura.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para LoadFront.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPLoadFront
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/Load/LoadFront.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para LoadPortfolio.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPLoadPortfolio
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/Portfolio/LoadPortfolio.asmx"); }
        }

        /// <summary>
        /// EndpointAddress para SrvSmile.asmx
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvSmile
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/Smile/SrvSmile.asmx"); }
        }

        /// <summary>
        ///  Prd_16803 Relaciona Leasing Forward Americano
        /// </summary>
        public static System.ServiceModel.EndpointAddress EPSrvLeasing
        {
            get { return new System.ServiceModel.EndpointAddress(FullUri + "WebService/OpcionesFX/LeasingFwdAmericano/Leasing.asmx"); }
        }

        public static System.ServiceModel.EndpointAddress EPArt84 {
            get { return new System.ServiceModel.EndpointAddress(UriArticulo84 + "WSArticulo84.asmx"); }
        }

        public static System.ServiceModel.EndpointAddress EPTicket84 {
            get { return new System.ServiceModel.EndpointAddress(UriArticulo84 + "WSTicket.asmx"); }
        }

        public static System.ServiceModel.EndpointAddress EPOperaciones84 {
            get { return new System.ServiceModel.EndpointAddress(UriArticulo84 + "WSOperaciones.asmx"); }
        }

        public static System.ServiceModel.EndpointAddress EPSrvNumeroIBSPorOperacion84 {
            get { return new System.ServiceModel.EndpointAddress(UriArticulo84 + "WSNumeroIBSporOperacion.asmx"); }
        }

        public static System.ServiceModel.EndpointAddress EPSrvTomaLinea{
            get { return new System.ServiceModel.EndpointAddress(UriTomaLinea + ""); }
        }

        #endregion Endpoint's

        #region WebService's

        public static AdminOpciones.SrvLogin.WebLoginSoapClient WebLogin
        {
            get { return new AdminOpciones.SrvLogin.WebLoginSoapClient(Binding, EPWebLogin); }
        }

        public static AdminOpciones.SrvConfig.SrvConfigSoapClient ConfigReader
        {
            get { return new AdminOpciones.SrvConfig.SrvConfigSoapClient(Binding, EPConfig); }
        }

        public static AdminOpciones.SrvAcciones.WebAccionesSoapClient Acciones
        {
            get { return new AdminOpciones.SrvAcciones.WebAccionesSoapClient(Binding, EPWebAcciones); }
        }

        public static AdminOpciones.SrvDetalles.WebDetallesSoapClient Detalles
        {
            get { return new AdminOpciones.SrvDetalles.WebDetallesSoapClient(Binding, EPWebDetalles); }
        }

        public static AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient Asiaticas
        {
            get { return new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient(Binding, EPSrvAsiaticas); }
        }

        public static AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient BDOpciones
        {
            get { return new AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient(Binding, EPBDOpciones); }
        }

        //Ojo este no se invoca directamente.
        //public static AdminOpciones.SrvCurvasMonedas.SrvCurvasMonedasSoapClient CurvasMonedas
        //{
        //    get { return new AdminOpciones.SrvCurvasMonedas.SrvCurvasMonedasSoapClient(Binding, EPSrvCurvasMonedas); }
        //}

        public static AdminOpciones.SrvCustomers.SrvCustomersSoapClient Customers
        {
            get { return new AdminOpciones.SrvCustomers.SrvCustomersSoapClient(Binding, EPSrvCustomers); }
        }

        public static AdminOpciones.SrvEstructura.SrvEstructuraSoapClient Estructura
        {
            get { return new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient(Binding, EPSrvEstructura); }
        }

        public static AdminOpciones.SrvLoadFront.LoadFrontSoapClient LoadFront
        {
            get { return new AdminOpciones.SrvLoadFront.LoadFrontSoapClient(Binding, EPLoadFront); }
        }

        public static AdminOpciones.SrvPortfolioAndBook.LoadPortfolioSoapClient Portfolio
        {
            get { return new AdminOpciones.SrvPortfolioAndBook.LoadPortfolioSoapClient(Binding, EPLoadPortfolio); }
        }

        public static AdminOpciones.SrvSmile.SrvSmileSoapClient Smile
        {
            get { return new AdminOpciones.SrvSmile.SrvSmileSoapClient(Binding, EPSrvSmile); }
        }

        public static AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient Valorizador
        {
            get { return new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient(Binding, EPSrvValorizadorCartera); }
        }

        /// <summary>
        /// Prd_16803 Relaciona Leasing Forward Americano
        /// </summary>
        public static AdminOpciones.SrvLeasing.LeasingSoapClient Leasing
        {
            get { return new AdminOpciones.SrvLeasing.LeasingSoapClient(Binding, EPSrvLeasing); }
        }

        public static AdminOpciones.SrvArt84.WSArticulo84SoapClient Articulo84 {
            get { return new AdminOpciones.SrvArt84.WSArticulo84SoapClient(Binding, EPArt84); }
        }

        public static AdminOpciones.SrvTicket84.WSTicketSoapClient Ticket84 {
            get { return new AdminOpciones.SrvTicket84.WSTicketSoapClient(Binding, EPTicket84); }
        }

        public static AdminOpciones.SrvOperaciones84.WSOperacionesSoapClient Operaciones84 {
            get { return new AdminOpciones.SrvOperaciones84.WSOperacionesSoapClient(Binding, EPOperaciones84); }
        }

        public static AdminOpciones.SrvNumeroIBSPorOperacion84.WSNumeroIBSporOperacionSoapClient NumeroIBSPorOperacion84 {
            get { return new AdminOpciones.SrvNumeroIBSPorOperacion84.WSNumeroIBSporOperacionSoapClient(Binding, EPSrvNumeroIBSPorOperacion84); }
        }

        public static AdminOpciones.SrvTomaLinea.ProxyLineaCreditoClient TomaLinea{
            get { return new SrvTomaLinea.ProxyLineaCreditoClient(Binding, EPSrvTomaLinea); }
        }

        #endregion WebService's
    }
}
