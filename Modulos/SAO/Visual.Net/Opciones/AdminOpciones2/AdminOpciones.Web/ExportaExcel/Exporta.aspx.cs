using System;
using System.Xml.Linq;
using AdminOpciones.Web.Recursos;
using System.Web.UI;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using AdminOpciones.Web.Struct;
using System.ComponentModel;
using System.Text;
using System.Web.UI.HtmlControls;

namespace AdminOpciones.Web.ExportaExcel
{
    public partial class Exporta : System.Web.UI.Page
    {
        private string _tipoSvc, _CR, _CT;
        private string _xmlDoc;
        public string XmlResultContra;
        XDocument _Xml = new XDocument();
        private List<StructMoConWeb> _ContraList, ContraList;        
        Recursos.SerMoContrato _svc = new SerMoContrato();
                
        protected void Page_Load(object sender, EventArgs e)
        {
            _tipoSvc = Request["TipoServicio"].ToString();
            _CR = Request["CR"].ToString();
            _CT = Request["CT"].ToString();
            if (_CR == "" | _CR == null) _CR = "Nulo";
            if (_CT == "" | _CT == null) _CT = "Nulo";
            _xmlDoc = _svc._MoEncContrato(0,0);
            _Xml = XDocument.Parse(_xmlDoc);
            ContratoOPT();
            if ((_CR != "Nulo") | (_CT !="Nulo")) Filtra();                        
            GridView1.DataSource = _ContraList;
            GridView1.DataBind();
            ExportaExcel(_Xml);
        }

        private void ExportaExcel(XDocument _Xml)
        {
                                       
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            System.Web.UI.Page pagina = new System.Web.UI.Page();
            HtmlForm form = new HtmlForm();
            GridView1.EnableViewState = false;

            pagina.EnableEventValidation = false;
            pagina.DesignerInitialize();

            pagina.Controls.Add(form);
            form.Controls.Add(GridView1);
            pagina.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=MoEncContrato.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
        }

        void ContratoOPT()
        {
            var MoContratos = from ContraOPTXML in _Xml.Descendants("Data")
                              select new StructMoConWeb
                              {
                                  VF = ContraOPTXML.Attribute("VF").Value.ToString(),
                                  Objeto = ContraOPTXML.Attribute("Objeto").Value.ToString(),
                                  NumContrato = ContraOPTXML.Attribute("NumContrato").Value.ToString(),
                                  NumFolio = ContraOPTXML.Attribute("NumFolio").Value.ToString(),
                                  FechaContrato = ContraOPTXML.Attribute("FechaContrato").Value.ToString(),
                                  ConOpcEstCod = ContraOPTXML.Attribute("ConOpcEstCod").Value.ToString(),
                                  ConOpcEstDsc = ContraOPTXML.Attribute("ConOpcEstDsc").Value.ToString(),
                                  CliRut = ContraOPTXML.Attribute("CliRut").Value.ToString(),
                                  CliCod = ContraOPTXML.Attribute("CliCod").Value.ToString(),
                                  CliDv = ContraOPTXML.Attribute("CliDv").Value.ToString(),
                                  CliNom = ContraOPTXML.Attribute("CliNom").Value.ToString(),
                                  Operador = ContraOPTXML.Attribute("Operador").Value.ToString(),
                                  OpcEstCod = ContraOPTXML.Attribute("OpcEstCod").Value.ToString(),
                                  OpcEstDsc = ContraOPTXML.Attribute("OpcEstDsc").Value.ToString(),
                                  TipoTransaccion = ContraOPTXML.Attribute("TipoTransaccion").Value.ToString(),
                                  Contrapartida = ContraOPTXML.Attribute("Contrapartida").Value.ToString(),
                                  FechaCreacionRegistro = ContraOPTXML.Attribute("FechaCreacionRegistro").Value.ToString(),
                                  Impreso = ContraOPTXML.Attribute("Impreso").Value.ToString()
                              };

            _ContraList = new List<StructMoConWeb>(MoContratos.ToList<StructMoConWeb>());            
        }

        void Filtra()
        {
            string _ID = _CR;
            string _TC = _CT;

            var _p = from _ps in _ContraList
                     where _ps.CliRut.Equals(_ID) | _ps.Contrapartida.Equals(_TC)
                     select _ps;

            int _cont = _p.Count<StructMoConWeb>();
            if (_cont > 0)
            {                            
                ContraList = new List<StructMoConWeb>(_p.ToList<StructMoConWeb>());
                _ContraList.Clear();
                foreach (StructMoConWeb _Aux in ContraList)
                {
                    _ContraList.Add(_Aux);
                }              
            }
        }
    }
}
