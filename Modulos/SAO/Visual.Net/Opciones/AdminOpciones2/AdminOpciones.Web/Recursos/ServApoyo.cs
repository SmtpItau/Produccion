using AdminOpciones.Web.WebService;
using System.Data;

namespace AdminOpciones.Web.Recursos 
{    
    public class SerMoContrato 
    {
        private string XmlResultContra;
        public string _MoEncContrato(int clirut, int clidv) 
        {
            WebDetalles _Xml = new WebDetalles();            
            XmlResultContra = _Xml.MoEncContrato(clirut, clidv, "Todos");
            return XmlResultContra;  
        }                    
    }

    public class SerIContableOpc 
    {
        private DataTable _data;
        public DataTable _InterContableOpc() 
        {
            WebDetalles _svc = new WebDetalles();
            _data = _svc.InterContableOpc();
            return _data;
        }
    }

    public class SerDerivados 
    {
        private DataTable _data;
        public DataTable _InterfazDerivadosOpciones() 
        {
            WebDetalles _svc = new WebDetalles();
            _data = _svc.InterfazDerivadosOpciones();
            return _data;
        }
    }

    public class SerOperaciones
    {
        private DataTable _data;
        public DataTable _InterfazOperacionesOpciones() 
        {
            WebDetalles _svc = new WebDetalles();
            _data = _svc.InterfazOperacionesOpciones();
            return _data;
        }
    }

    public class SerBalance
    {
        private DataTable _data;
        public DataTable _InterfazBalanceOpciones() 
        {
            WebDetalles _svc = new WebDetalles();
            _data = _svc.InterfazBalanceOpciones();
            return _data;
        }
    }
}