using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using AdminOpcionesTool.ValorizadorCartera;
using AdminOpcionesTool.Opciones;
using cFinancialTools.Yield;
using cFinancialTools.BussineDate;
using System.Data;
using AdminOpcionesTool.Opciones.Functions;
using AdminOpciones.Struct.OpcionesXF.Smile;//se usa???

namespace AdminOpciones.Web.WebService.OpcionesFX.ValoriadorCartera
{
    /// <summary>
    /// Descripción breve de SrvValorizadorCartera
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class SrvValorizadorCartera : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetSetPreciosConSpot(DateTime fechaProceso, double Spot, string parMon, string nemoMonSpot, string idCurvasMonedasXML, int enuSetPricing)
        {
            string SetPrecios="";
            bool Status = false;
            YieldList CurvaList;
            AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile;
            XDocument idCurvasXDoc;
            DateTime FechaSetDePrecios;
            List<KeyValuePair<string, DateTime>> Fechas = new List<KeyValuePair<string, DateTime>>();
            int Count = 1;

            DataTable TableFechas;
            TableFechas = cData.Opciones.LoadFront.LoadDateProcess();

            if (TableFechas != null && TableFechas.Rows.Count > 0)
            {
                KeyValuePair<string, DateTime> date1 = new KeyValuePair<string, DateTime>("FechaProceso", DateTime.Parse(TableFechas.Rows[0][0].ToString()));
                KeyValuePair<string, DateTime> date2 = new KeyValuePair<string, DateTime>("FechaAnt", DateTime.Parse(TableFechas.Rows[0][1].ToString()));
                Fechas.Add(date1);
                Fechas.Add(date2);
            }            

            FechaSetDePrecios = fechaProceso;

            while (!Status && Count <= 2)
            {
                SetPrecios = "<Data>\n";

                SetPrecios += string.Format("\t<FechaSetPrecios  Fecha = '{0}'/>\n", FechaSetDePrecios.ToString("dd-MM-yyyy"));

                //ASVG esta es la única diferencia entre GetSetPreciosConSpot y GetSetPrecios
                //considerar juntar completamente ambos servicios en uno o al menos factorizar el código.
                #region Spot

                Status = true; // El set de precio se entrega, por eso ya se valida status para este dato.
                SetPrecios += string.Format("\t<Spot Value = '{0}'/>\n", Spot);

                #endregion

                #region Curvas de Moneda

                idCurvasXDoc = new XDocument();
                idCurvasXDoc = XDocument.Parse(idCurvasMonedasXML);

                cData.Yield.Yield _Moneda = new cData.Yield.Yield();

                List<string> IdCurvaList = new List<string>();

                foreach (XElement _itemCurva in idCurvasXDoc.Descendants("itemCurva"))
                {
                    IdCurvaList.Add(_itemCurva.Attribute("ID").Value);
                }

                CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enuSetPricing;
                try
                {
                    for (int i = 0; i < IdCurvaList.Count; i++)
                    {
                        CurvaList.Load(IdCurvaList[i], enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                        //PRD_12567 Validamos dinámicamente las curvas cargadas
                        Status = (CurvaList.Read(IdCurvaList[i], enumSource.System, FechaSetDePrecios).Count > 0 && Status == true) ? true : false;
                    }

                    SetPrecios += TagXML_CurvasMoneda(enuSetPricing, CurvaList, FechaSetDePrecios, IdCurvaList);
                }
                catch { Status = false; }//GetSetPreciosConSpot

                #endregion Curvas de Moneda

                #region PuntosFwd

                #region Tenor en palabras y valores

                List<String> _T = ListaNombresTenor();

                List<double> _Tenor = ListaValoresTenor();

                #endregion Tenor en palabras y valores

                DateTime _fechaPlazo = new DateTime();
                double _forward;
                double _plazo;

                SetPrecios += "\t<PesosForward>\n";

                try
                {
                    for (int _Item = 0; _Item < _Tenor.Count; _Item++)
                    {
                        _plazo = _Tenor[_Item];
                        _fechaPlazo = fechaProceso.AddDays(_plazo);
                        _forward = Function.Forward(fechaProceso, _fechaPlazo, FechaSetDePrecios, Spot, IdCurvaList[0], IdCurvaList[1], CurvaList);

                        SetPrecios += string.Format("\t\t<itemCurva Dias='{0}' Tenor='{1}' Puntos='{2}'/>\n", _plazo, _T[_Item], (_forward - Spot));
                    }
                }
                catch
                {
                    Status = false;
                }

                SetPrecios += "\t</PesosForward>\n";

                #endregion

                #region Smile

                try
                {
                    _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, parMon, Spot, IdCurvaList[0], IdCurvaList[1], 0);
                    _Smile.Load((enumSetPrincingLoading)enuSetPricing);

                    Status = (_Smile.Tenors.Count > 0 && Status == true) ? true : false;

                    SetPrecios += TagXML_ATMRRFLY(_Smile);

                    SetPrecios += TagXML_CALLPUT(_Smile);

                    SetPrecios += TagXML_STRIKES(_Smile);
                }
                catch
                {
                    Status = false;
                    SetPrecios += "\t<ATMRRFLY/>\n";
                    SetPrecios += "\t<CALLPUT/>\n";
                    SetPrecios += "\t<STRIKES/>\n";
                }

                #endregion Smile

                #region Status
                SetPrecios += string.Format("\t<Status  Value = '{0}' FechaAnt='{1}'/>\n", Status ? "OK" : "NO", Count == 2? "1": "0");
                #endregion               

                SetPrecios += "</Data>\n";

                //Si Set de Precio Es Costo, No Cargar Set de Precio de dia Anterior.
                if ((enumSetPrincingLoading)enuSetPricing == enumSetPrincingLoading.Costo)
                    break;

                //Si La fecha Consultada de Set de Precio es menor que la fecha de proceso, No Cargar Set de Precio de dia Anterior.
                //Simplemente cargar el set de precio de la fecha que se solicita.
                if (fechaProceso.CompareTo(Fechas[0].Value) < 0)
                    break;

                //Buscar Set de Precios en Fecha Ant.
                FechaSetDePrecios = Fechas[1].Value;
                Count++;
            }

            return SetPrecios;//GetSetPreciosConSpot

        }

        [WebMethod]
        public string GetSetPrecios(DateTime fechaProceso, string parMon, string nemoMonSpot ,string idCurvasMonedasXML, int enuSetPricing)
        {
            string SetPrecios="";
            bool Status = false;
            double Spot= 0;
            YieldList CurvaList;
            cFinancialTools.Currency.CurrencyList _CurrencyList = new cFinancialTools.Currency.CurrencyList();// Lista de Tipos de Cambios
            AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile;
            XDocument idCurvasXDoc;
            List<KeyValuePair<string, DateTime>> Fechas = new List<KeyValuePair<string, DateTime>>();
            DataTable TableFechas;
            DateTime FechaSetDePrecios;
            int Count = 1;

            TableFechas = cData.Opciones.LoadFront.LoadDateProcess();

            if (TableFechas != null && TableFechas.Rows.Count > 0)
            {
                KeyValuePair<string, DateTime> date1 = new KeyValuePair<string, DateTime>("FechaProceso", DateTime.Parse(TableFechas.Rows[0][0].ToString()));
                KeyValuePair<string, DateTime> date2 = new KeyValuePair<string, DateTime>("FechaAnt", DateTime.Parse(TableFechas.Rows[0][1].ToString()));
                Fechas.Add(date1);
                Fechas.Add(date2);
            }
                        
            FechaSetDePrecios = fechaProceso;

            while (!Status && Count <= 2)
            {
                SetPrecios = "<Data>\n";
                SetPrecios += string.Format("\t<FechaSetPrecios  Fecha = '{0}'/>\n", FechaSetDePrecios.ToString("dd-MM-yyyy"));

                #region Spot

                _CurrencyList.SetPricingLoading = (enumSetPrincingLoading)enuSetPricing;
                _CurrencyList.Load(994, enumSource.CurrencyValueAccount, FechaSetDePrecios, "CURVASWAPUSDLOCAL");

                try
                {
                    Spot = _CurrencyList.Read(994, enumSource.CurrencyValueAccount, FechaSetDePrecios).ExchangeRateMid;
                }
                catch 
                {
                    Spot = 0;
                }              

                Status = (Spot > 0) ? true : false;
               

                SetPrecios += string.Format("\t<Spot Value = '{0}'/>\n", Spot);

                #endregion

                #region Curvas de Moneda

                idCurvasXDoc = new XDocument();
                idCurvasXDoc = XDocument.Parse(idCurvasMonedasXML);

                CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enuSetPricing;

                cData.Yield.Yield _Moneda = new cData.Yield.Yield();

                List<string> IdCurvaList = new List<string>();

                try
                {
                    //DataSet _DataSetCurvasMoneda = new DataSet();

                    foreach (XElement _itemCurva in idCurvasXDoc.Descendants("itemCurva"))
                    {
                        IdCurvaList.Add(_itemCurva.Attribute("ID").Value);
                    }

                    for (int i = 0; i < IdCurvaList.Count; i++)
                    {
                        CurvaList.Load(IdCurvaList[i], enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                    }

                    Status = (CurvaList.Read(IdCurvaList[0], enumSource.System, FechaSetDePrecios).Count > 0 && Status == true) ? true : false;
                    Status = (CurvaList.Read(IdCurvaList[1], enumSource.System, FechaSetDePrecios).Count > 0 && Status == true) ? true : false;

                    SetPrecios += TagXML_CurvasMoneda(enuSetPricing, CurvaList, FechaSetDePrecios, IdCurvaList);

                }
                catch { Status = false; }//GetSetPrecios
                #endregion Curvas de Moneda

                #region PuntosFwd

                //DataTable _DataTableCurvaForwadUSD;
                //_DataTableCurvaForwadUSD = new DataTable();
                //_DataTableCurvaForwadUSD = _Moneda.LoadValue("CurvafwUSD", FechaSetDePrecios, FechaSetDePrecios);
                //_DataTableCurvaForwadUSD.TableName = "CurvafwUSD";

                #region Tenor en palabras y valores

                List<String> _T = ListaNombresTenor();

                List<double> _Tenor = ListaValoresTenor();

                #endregion Tenor en palabras y valores

                // Solicitud DContreras 9-12-2009 17:04.
                //Status = (_DataTableCurvaForwadUSD.Rows.Count > 0 && Status == true) ? true : false;

                DateTime _fechaPlazo = new DateTime();
                double _forward;
                double _plazo;

                SetPrecios += "\t<PesosForward>\n";

                try
                {
                    for (int _Item = 0; _Item < _Tenor.Count; _Item++ )
                    {
                        _plazo = _Tenor[_Item];
                        _fechaPlazo = fechaProceso.AddDays(_plazo);
                        _forward = Function.Forward(fechaProceso, _fechaPlazo, FechaSetDePrecios, Spot, IdCurvaList[0], IdCurvaList[1], CurvaList);

                        SetPrecios += string.Format("\t\t<itemCurva Dias='{0}' Tenor='{1}' Puntos='{2}'/>\n", _plazo, _T[_Item], (_forward - Spot));
                    }
                }
                catch
                {
                    Status = false;
                }

                SetPrecios += "\t</PesosForward>\n";

                #endregion

                #region Smile

                try
                {
                    _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, parMon, Spot, IdCurvaList[0], IdCurvaList[1], 0);
                    _Smile.Load((enumSetPrincingLoading)enuSetPricing);

                    Status = (_Smile.Tenors.Count > 0 && Status == true) ? true : false;

                    SetPrecios += TagXML_ATMRRFLY(_Smile);

                    SetPrecios += TagXML_CALLPUT(_Smile);

                    SetPrecios += TagXML_STRIKES(_Smile);
                }
                catch
                {
                    Status = false;
                    SetPrecios += "\t<ATMRRFLY/>\n";
                    SetPrecios += "\t<CALLPUT/>\n";
                    SetPrecios += "\t<STRIKES/>\n";
                }

                #endregion
                
                #region Status
                SetPrecios += string.Format("\t<Status  Value = '{0}' FechaAnt='{1}'/>\n", Status ? "OK" : "NO", Count == 2 ? "1" : "0");
                #endregion               

                SetPrecios += "</Data>\n";

                if ((enumSetPrincingLoading)enuSetPricing == enumSetPrincingLoading.Costo)
                    break;

                //Si La fecha Consultada de Set de Precio es menor que la fecha de proceso, No Cargar Set de Precio de dia Anterior.
                //Simplemente cargar el set de precio de la fecha que se solicita.
                if (fechaProceso.CompareTo(Fechas[0].Value) < 0)
                    break;

                //Buscar Set de Precios de Fecha Ant
                FechaSetDePrecios = Fechas[1].Value;
                Count++;
            }
            
            return SetPrecios;//GetSetPrecios
        }

        [WebMethod]
        public string getDetContratoFixing(DateTime fechaContrato, string Estado, DateTime fechaDeProcesoSistema)
        {            
            XDocument _xdoc = new XDocument();
            _xdoc = ValorizadorCartera.GetEncDetFixData(fechaContrato, Estado, fechaDeProcesoSistema);
            return _xdoc.ToString();
        }

        [WebMethod]
        public string ValorizarCartera(string DetContraToAndFixingData, DateTime FechaSetdePrecios ,int setPricing)
        {
            //ASVG_20130213 PRD_12567
            //MEJORAR
            //PRD_12567 Para configuración de curvas Forward a utilizar en valorización Fwd Asiático ES
            string curvaDom = "CurvaSwapCLP";
            string curvaFor = "CurvaSwapUSDLocal";
            string curvaDomFwd = "CurvaFwCLP";
            string curvaForFwd = "CurvaFwUSD";

            string _idCurvasSetPrecioXML = "<CurvasMoneda >\n";
            _idCurvasSetPrecioXML += "<itemCurva ID='" + curvaDom + "'/>\n";
            _idCurvasSetPrecioXML += "<itemCurva ID='" + curvaFor + "'/>\n";
            _idCurvasSetPrecioXML += "<itemCurva ID='" + curvaDomFwd + "'/>\n";//PRD_12567
            _idCurvasSetPrecioXML += "<itemCurva ID='" + curvaForFwd + "'/>\n";//PRD_12567
            _idCurvasSetPrecioXML += "</CurvasMoneda>";

            string SetPrecios = GetSetPrecios(FechaSetdePrecios, "CLP/USD", "DO", _idCurvasSetPrecioXML, setPricing);
            XDocument SetPreciosXML = new XDocument(XDocument.Parse(SetPrecios));

            XElement a = new XElement("CurvaSwapCLP");
            XElement b = new XElement("CurvaSwapUSDLocal");
            XElement c = new XElement("CurvaFwCLP");
            XElement d = new XElement("CurvaFwUSD");

            XElement CurvasMonedaXML = new XElement("CurvasMoneda",SetPreciosXML.Descendants("Curva"));
            foreach (XElement xe in CurvasMonedaXML.Descendants("itemCurva"))
            {
                if (xe.Attribute("CodigoCurva").Value.Equals("CurvaSwapCLP")) { a.Add(xe); }
                if (xe.Attribute("CodigoCurva").Value.Equals("CurvaSwapUSDLocal")) { b.Add(xe); }
            }

            foreach (XElement xe in CurvasMonedaXML.Descendants("itemCurva")) //Se sacó itemCurvaFed
            {
                XElement x = new XElement("itemCurva");
                x.ReplaceAttributes(xe.Attributes());
                if (xe.Attribute("CodigoCurva").Value.Equals("CurvaFwCLP")) { c.Add(x); }
                if (xe.Attribute("CodigoCurva").Value.Equals("CurvaFwUSD")) { d.Add(x); }
            }

            CurvasMonedaXML = new XElement("CurvasMoneda");
            CurvasMonedaXML.Add(a);
            CurvasMonedaXML.Add(b);
            CurvasMonedaXML.Add(c);
            CurvasMonedaXML.Add(d);
                
            string _CurvasDataXML = CurvasMonedaXML.ToString();//OJO

            XDocument _xdoc = new XDocument();
            _xdoc = XDocument.Parse(DetContraToAndFixingData);

            List<StructDetContrato> DetContratoList = new List<StructDetContrato>();
            StructDetContrato _itemDetContratoStruct;

            DateTime FechaValorizacion = new DateTime();
            FechaValorizacion = DateTime.Parse(_xdoc.Element("Data").Element("FechaValorizacion").Attribute("Fecha").Value);

            double BsSpot = 0;

            BsSpot = double.Parse(_xdoc.Element("Data").Element("SpotValorizacion").Attribute("Spot").Value);


            foreach (XElement itemdetContrato in _xdoc.Descendants("itemDetContrato"))
            {
                _itemDetContratoStruct = new StructDetContrato();

                _itemDetContratoStruct.Checked = bool.Parse(itemdetContrato.Attribute("Checked").Value);
                _itemDetContratoStruct.NumContrato = int.Parse(itemdetContrato.Attribute("NumContrato").Value);
                _itemDetContratoStruct.CurveMon1 = itemdetContrato.Attribute("CurveMon1").Value;
                _itemDetContratoStruct.CurveMon2 = itemdetContrato.Attribute("CurveMon2").Value;
                _itemDetContratoStruct.CVOpc = itemdetContrato.Attribute("CVOpc").Value;
                _itemDetContratoStruct.ParStrike = itemdetContrato.Attribute("ParStrike").Value;
                _itemDetContratoStruct.MontoMon1 = double.Parse(itemdetContrato.Attribute("MontoMon1").Value);
                _itemDetContratoStruct.FechaInicioOpc = FechaValorizacion;
                _itemDetContratoStruct.FechaVcto = DateTime.Parse(itemdetContrato.Attribute("FechaVcto").Value);
                _itemDetContratoStruct.NumEstructura = int.Parse(itemdetContrato.Attribute("NumEstructura").Value);
                _itemDetContratoStruct.CodEstructura = int.Parse(itemdetContrato.Attribute("CodEstructura").Value);
                _itemDetContratoStruct.SpotDet = BsSpot;
                _itemDetContratoStruct.Strike = double.Parse(itemdetContrato.Attribute("Strike").Value);
                _itemDetContratoStruct.PuntosFwd = double.Parse(itemdetContrato.Attribute("PuntosFwd").Value);
                _itemDetContratoStruct.TipoPayOff = itemdetContrato.Attribute("TipoPayOff").Value;
                _itemDetContratoStruct.Vinculacion = itemdetContrato.Attribute("Vinculacion").Value;
                _itemDetContratoStruct.CallPut = itemdetContrato.Attribute("CallPut").Value;
                _itemDetContratoStruct.PorcStrike = double.Parse(itemdetContrato.Attribute("PorcStrike").Value);
                DetContratoList.Add(_itemDetContratoStruct);
            }

            List<StructFixingDataContrato> FijacionesList = new List<StructFixingDataContrato>();
            

            StructFixingDataContrato _itemFixingData;
            StructFixingData itemFijacion;

            int _auxNumContrato = -1;
            int _auxNumEstructura = -1;
            foreach (XElement itemdFixing in _xdoc.Descendants("itemFixing"))
            {
                itemFijacion = new StructFixingData();

                if (!_auxNumContrato.Equals(int.Parse(itemdFixing.Attribute("NumContrato").Value)) || !_auxNumEstructura.Equals(int.Parse(itemdFixing.Attribute("NumEstructura").Value)))
                {
                    _auxNumContrato = int.Parse(itemdFixing.Attribute("NumContrato").Value);
                    _auxNumEstructura = int.Parse(itemdFixing.Attribute("NumEstructura").Value);

                    _itemFixingData = new StructFixingDataContrato();
                    _itemFixingData.NumContrato = _auxNumContrato;
                    _itemFixingData.NucEstructura = _auxNumEstructura;

                    itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                    itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                    itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                    itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                    _itemFixingData.Fijaciones.Add(itemFijacion);

                    FijacionesList.Add(_itemFixingData);
                }
                else
                {
                    itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                    itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                    itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                    itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                    FijacionesList[FijacionesList.Count - 1].Fijaciones.Add(itemFijacion);
                }

            }

            enumSetPrincingLoading _SetPricing = (enumSetPrincingLoading)setPricing;

            string MtMGriegas = "";

            if (DetContratoList.Count > 0)
            {
                try
                {
                    MtMGriegas = "<Data>\n";

                    #region Smile

                    AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetdePrecios, DetContratoList[0].ParStrike, DetContratoList[0].SpotDet, DetContratoList[0].CurveMon1, DetContratoList[0].CurveMon2, 0);
                    _Smile.Load(_SetPricing);

                    #endregion

                    //TODO
                    //OJO
                    //REVISAR
                    //HORROR
                    YieldList CurvaList = new YieldList();
                    CurvaList.SetPrincingLoading = (enumSetPrincingLoading) setPricing;
                    CurvaList.Load(DetContratoList[0].CurveMon1, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
                    CurvaList.Load(DetContratoList[0].CurveMon2, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
                    CurvaList.Load(curvaDomFwd, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
                    CurvaList.Load(curvaForFwd, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);

                    MtMGriegas += ValorizadorCartera.ValorizarCartera(DetContratoList, FijacionesList, _Smile, CurvaList, _SetPricing
                        , _CurvasDataXML);

                    MtMGriegas += "</Data>\n";
                }
                catch(Exception e)
                {
                    MtMGriegas = string.Format("<Data Error='{0}' />", e.Message);
                }
            }
            return MtMGriegas;
        }

        [WebMethod]
        public string Sensibilidad(string DetContratoAndFixingData, DateTime FechaSetdePrecios, double MTM_Totalizador, int setPricing)
        {
            string _Sensibilidad = "";

            try
            {
                XDocument _xdoc = new XDocument();
                _xdoc = XDocument.Parse(DetContratoAndFixingData);

                List<StructDetContrato> DetContratoList = new List<StructDetContrato>();
                StructDetContrato _itemDetContratoStruct;

                DateTime FechaValorizacion = new DateTime();
                FechaValorizacion = DateTime.Parse(_xdoc.Element("Data").Element("FechaValorizacion").Attribute("Fecha").Value);

                double BsSpot = 0;
                double BsSpotSmile = 0;

                BsSpot = double.Parse(_xdoc.Element("Data").Element("SpotValorizacion").Attribute("Spot").Value);
                BsSpotSmile = double.Parse(_xdoc.Element("Data").Element("SpotValorizacion").Attribute("SpotSmile").Value);

                foreach (XElement itemdetContrato in _xdoc.Descendants("itemDetContrato"))
                {
                    _itemDetContratoStruct = new StructDetContrato();

                    _itemDetContratoStruct.Checked = bool.Parse(itemdetContrato.Attribute("Checked").Value);
                    if (_itemDetContratoStruct.Checked)
                    {
                        _itemDetContratoStruct.NumContrato = int.Parse(itemdetContrato.Attribute("NumContrato").Value);
                        _itemDetContratoStruct.CurveMon1 = itemdetContrato.Attribute("CurveMon1").Value;
                        _itemDetContratoStruct.CurveMon2 = itemdetContrato.Attribute("CurveMon2").Value;
                        _itemDetContratoStruct.CVOpc = itemdetContrato.Attribute("CVOpc").Value;
                        _itemDetContratoStruct.ParStrike = itemdetContrato.Attribute("ParStrike").Value;
                        _itemDetContratoStruct.MontoMon1 = double.Parse(itemdetContrato.Attribute("MontoMon1").Value);
                        _itemDetContratoStruct.FechaInicioOpc = FechaValorizacion;
                        _itemDetContratoStruct.FechaVcto = DateTime.Parse(itemdetContrato.Attribute("FechaVcto").Value);
                        _itemDetContratoStruct.NumEstructura = int.Parse(itemdetContrato.Attribute("NumEstructura").Value);
                        _itemDetContratoStruct.CodEstructura = int.Parse(itemdetContrato.Attribute("CodEstructura").Value);
                        _itemDetContratoStruct.SpotDet = BsSpot;
                        _itemDetContratoStruct.Strike = double.Parse(itemdetContrato.Attribute("Strike").Value);
                        _itemDetContratoStruct.PuntosFwd = double.Parse(itemdetContrato.Attribute("PuntosFwd").Value);
                        _itemDetContratoStruct.TipoPayOff = itemdetContrato.Attribute("TipoPayOff").Value;
                        _itemDetContratoStruct.Vinculacion = itemdetContrato.Attribute("Vinculacion").Value;
                        _itemDetContratoStruct.CallPut = itemdetContrato.Attribute("CallPut").Value;
                        _itemDetContratoStruct.PorcStrike = double.Parse(itemdetContrato.Attribute("PorcStrike").Value);
                        DetContratoList.Add(_itemDetContratoStruct);
                    }
                }

                List<StructFixingDataContrato> FijacionesList = new List<StructFixingDataContrato>();

                StructFixingDataContrato _itemFixingData;
                StructFixingData itemFijacion;

                int _auxNumContrato = -1;
                int _auxNumEstructura = -1;
                foreach (XElement itemdFixing in _xdoc.Descendants("itemFixing"))
                {
                    itemFijacion = new StructFixingData();

                    if (!_auxNumContrato.Equals(int.Parse(itemdFixing.Attribute("NumContrato").Value)) || !_auxNumEstructura.Equals(int.Parse(itemdFixing.Attribute("NumEstructura").Value)))
                    {
                        _auxNumContrato = int.Parse(itemdFixing.Attribute("NumContrato").Value);
                        _auxNumEstructura = int.Parse(itemdFixing.Attribute("NumEstructura").Value);

                        _itemFixingData = new StructFixingDataContrato();
                        _itemFixingData.NumContrato = _auxNumContrato;
                        _itemFixingData.NucEstructura = _auxNumEstructura;

                        itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                        itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                        itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                        itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                        _itemFixingData.Fijaciones.Add(itemFijacion);

                        FijacionesList.Add(_itemFixingData);
                    }
                    else
                    {
                        itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                        itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                        itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                        itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                        FijacionesList[FijacionesList.Count - 1].Fijaciones.Add(itemFijacion);
                    }

                }

                List<StructFixingDataContrato> FijacionesList_Ckecked = new List<StructFixingDataContrato>();

                foreach (StructDetContrato _itemDetContrato in DetContratoList)
                {
                    FijacionesList_Ckecked.AddRange((FijacionesList.Where(x => x.NumContrato.Equals(_itemDetContrato.NumContrato) && x.NucEstructura.Equals(_itemDetContrato.NumEstructura))).ToList<StructFixingDataContrato>());

                }

                enumSetPrincingLoading _SetPricing = (enumSetPrincingLoading)setPricing;

                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetdePrecios, DetContratoList[0].ParStrike, BsSpotSmile, DetContratoList[0].CurveMon1, DetContratoList[0].CurveMon2, 0);
                _Smile.Load(_SetPricing);

                if (DetContratoList.Count > 0)
                {

                    YieldList CurvaList = new YieldList();
                    CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPricing;
                    CurvaList.Load(DetContratoList[0].CurveMon1, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
                    CurvaList.Load(DetContratoList[0].CurveMon2, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);


                    _Sensibilidad = ValorizadorCartera.Sensibilidad(FechaSetdePrecios, DetContratoList, FijacionesList_Ckecked, _Smile, CurvaList, MTM_Totalizador, _SetPricing);
                }
            }
            catch
            {
                _Sensibilidad = "<Sensibilidad><CurvaSwapCLP></CurvaSwapCLP><CurvaSwapUSDLocal></CurvaSwapUSDLocal></Sensibilidad>";
            }

            return _Sensibilidad;
        }

        [WebMethod]
        public string TopologiaVega(string BsSpotBsFwd, string DetContraToAndFixingData, DateTime FechaSetdePrecios, double MTM_Totalizador, string rrfly_callput, int setPricing)
        {

            try
            {
                XDocument _xdoc = new XDocument();
                _xdoc = XDocument.Parse(DetContraToAndFixingData);

                List<StructDetContrato> DetContratoList = new List<StructDetContrato>();
                StructDetContrato _itemDetContratoStruct;

                DateTime FechaValorizacion = new DateTime();
                FechaValorizacion = DateTime.Parse(_xdoc.Element("Data").Element("FechaValorizacion").Attribute("Fecha").Value);

                double BsSpot = 0;
                double BsSpotSmile = 0;

                BsSpot = double.Parse(_xdoc.Element("Data").Element("SpotValorizacion").Attribute("Spot").Value);
                BsSpotSmile = double.Parse(_xdoc.Element("Data").Element("SpotValorizacion").Attribute("SpotSmile").Value);

                //alanrevisar cambio en el xpath, viejo: foreach (XElement itemdetContrato in _xdoc.Descendants("itemDetContrato"))
                foreach (XElement itemdetContrato in _xdoc.Element("Data").Element("DetContrato").Descendants("itemDetContrato"))
                {
                    _itemDetContratoStruct = new StructDetContrato();

                    _itemDetContratoStruct.Checked = bool.Parse(itemdetContrato.Attribute("Checked").Value);
                    if (_itemDetContratoStruct.Checked)
                    {
                        _itemDetContratoStruct.NumContrato = int.Parse(itemdetContrato.Attribute("NumContrato").Value);
                        _itemDetContratoStruct.CurveMon1 = itemdetContrato.Attribute("CurveMon1").Value;
                        _itemDetContratoStruct.CurveMon2 = itemdetContrato.Attribute("CurveMon2").Value;
                        _itemDetContratoStruct.CVOpc = itemdetContrato.Attribute("CVOpc").Value;
                        _itemDetContratoStruct.ParStrike = itemdetContrato.Attribute("ParStrike").Value;
                        _itemDetContratoStruct.MontoMon1 = double.Parse(itemdetContrato.Attribute("MontoMon1").Value);
                        _itemDetContratoStruct.FechaInicioOpc = FechaValorizacion;
                        _itemDetContratoStruct.FechaVcto = DateTime.Parse(itemdetContrato.Attribute("FechaVcto").Value);
                        _itemDetContratoStruct.NumEstructura = int.Parse(itemdetContrato.Attribute("NumEstructura").Value);
                        _itemDetContratoStruct.CodEstructura = int.Parse(itemdetContrato.Attribute("CodEstructura").Value);
                        _itemDetContratoStruct.SpotDet = BsSpot;
                        _itemDetContratoStruct.Strike = double.Parse(itemdetContrato.Attribute("Strike").Value);
                        _itemDetContratoStruct.PuntosFwd = double.Parse(itemdetContrato.Attribute("PuntosFwd").Value);
                        _itemDetContratoStruct.TipoPayOff = itemdetContrato.Attribute("TipoPayOff").Value;
                        _itemDetContratoStruct.Vinculacion = itemdetContrato.Attribute("Vinculacion").Value;
                        _itemDetContratoStruct.CallPut = itemdetContrato.Attribute("CallPut").Value;
                        _itemDetContratoStruct.MtM = double.Parse(itemdetContrato.Attribute("MTM").Value);
                        _itemDetContratoStruct.PorcStrike = double.Parse(itemdetContrato.Attribute("PorcStrike").Value);
                        DetContratoList.Add(_itemDetContratoStruct);
                    }
                }

                List<StructFixingDataContrato> FijacionesList = new List<StructFixingDataContrato>();

                StructFixingDataContrato _itemFixingData;
                StructFixingData itemFijacion;

                int _auxNumContrato = -1;
                int _auxNumEstructura = -1;
                foreach (XElement itemdFixing in _xdoc.Descendants("itemFixing"))
                {
                    itemFijacion = new StructFixingData();

                    if (!_auxNumContrato.Equals(int.Parse(itemdFixing.Attribute("NumContrato").Value)) || !_auxNumEstructura.Equals(int.Parse(itemdFixing.Attribute("NumEstructura").Value)))
                    {
                        _auxNumContrato = int.Parse(itemdFixing.Attribute("NumContrato").Value);
                        _auxNumEstructura = int.Parse(itemdFixing.Attribute("NumEstructura").Value);

                        _itemFixingData = new StructFixingDataContrato();
                        _itemFixingData.NumContrato = _auxNumContrato;
                        _itemFixingData.NucEstructura = _auxNumEstructura;

                        itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                        itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                        itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                        itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                        _itemFixingData.Fijaciones.Add(itemFijacion);

                        FijacionesList.Add(_itemFixingData);
                    }
                    else
                    {
                        itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                        itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                        itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                        itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                        FijacionesList[FijacionesList.Count - 1].Fijaciones.Add(itemFijacion);
                    }

                }

                List<StructFixingDataContrato> FijacionesList_Ckecked = new List<StructFixingDataContrato>();

                foreach (StructDetContrato _itemDetContrato in DetContratoList)
                {
                    FijacionesList_Ckecked.AddRange((FijacionesList.Where(x => x.NumContrato.Equals(_itemDetContrato.NumContrato) && x.NucEstructura.Equals(_itemDetContrato.NumEstructura))).ToList<StructFixingDataContrato>());

                }

                enumSetPrincingLoading _SetPricing = (enumSetPrincingLoading)setPricing;

                string RRFLYDesplazado = "";

                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetdePrecios, DetContratoList[0].ParStrike, BsSpotSmile, DetContratoList[0].CurveMon1, DetContratoList[0].CurveMon2, 0);
                _Smile.Load(_SetPricing);

                if (DetContratoList.Count > 0)
                {

                    YieldList CurvaList = new YieldList();
                    CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPricing;
                    CurvaList.Load(DetContratoList[0].CurveMon1, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
                    CurvaList.Load(DetContratoList[0].CurveMon2, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);


                    RRFLYDesplazado = ValorizadorCartera.TopologiaVega(BsSpotBsFwd, DetContratoList, FijacionesList_Ckecked, _Smile, CurvaList, MTM_Totalizador, rrfly_callput, _SetPricing);
                }

                if (rrfly_callput.Equals("rrfly") && RRFLYDesplazado == "")
                {
                    RRFLYDesplazado = "<TOPOLOGIA Name='RRFLY' >" + RRFLYDesplazado + "<RRFLY/>\n";
                }
                else if (rrfly_callput.Equals("callput") && RRFLYDesplazado == "")
                {
                    RRFLYDesplazado = "<TOPOLOGIA Name='CALLPUT' >" + RRFLYDesplazado + "<CALLPUT/>\n";
                }
                else
                {
                    RRFLYDesplazado = string.Format("<TOPOLOGIA Name='{0}' >{1}\n", rrfly_callput.ToUpper(), RRFLYDesplazado);
                }

                RRFLYDesplazado += "<DataSmile>";

                #region Smile

                RRFLYDesplazado += TagXML_ATMRRFLY(_Smile);

                RRFLYDesplazado += TagXML_CALLPUT(_Smile);

                RRFLYDesplazado += TagXML_STRIKES(_Smile);

                #endregion

                RRFLYDesplazado += "</DataSmile>";
                RRFLYDesplazado += "</TOPOLOGIA>";

                return RRFLYDesplazado;
            }
            catch
            {
                string RRFLYDesplazado;

                if (rrfly_callput.Equals("rrfly"))
                {
                    RRFLYDesplazado = "<TOPOLOGIA Name='RRFLY' />\n";
                }
                else
                {
                    RRFLYDesplazado = "<TOPOLOGIA Name='CALLPUT' />";
                }

                return RRFLYDesplazado;
            }
        }

        [WebMethod]
        public double InterpVol(DateTime FechaVal, int plazo , string paridad, double Spot ,double Strike, string CurvaDom, string CurvaFor, int SetPrecios)
        {
            try
            {
                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaVal, paridad, Spot, CurvaDom, CurvaFor, 0);
                _Smile.SetPricing = (enumSetPrincingLoading)SetPrecios;
                _Smile.Load((enumSetPrincingLoading)SetPrecios);           

                double _Volatilidad;

                _Volatilidad = _Smile.interp_vol(plazo, Strike, 1, 1);
                return _Volatilidad;
            }
            catch 
            {
                return double.NaN;
            }
        }

	    //alanrevisar webmethod nuevo
        //20190614.RCHS. Se actualiza WebMethod tanto en parametría de entrada para invocar función Calculate2, 
        [WebMethod]
        #region Simular_LCR
        public string CalcularLCR(int _NumeroContrato, string _Operacion)
        {
         // 20190612.rch  return AdminOpcionesTool.ValorizadorCartera.CalcularLCR.Calculate(underlying, operationtype, mtm, deltaspot, tenor, dobs, Nocional, vinculacion);
            return AdminOpcionesTool.ValorizadorCartera.CalcularLCR.Calculate2(_NumeroContrato, _Operacion); // 20190612.rch
        }
        #endregion

        #region TagXML

        /// <summary>
        /// Genera tag XML con "itemCurva": FechaGeneracion, CodigoCurva, Dias, ValorBid, ValorAsk.
        /// </summary>
        /// <param name="enuSetPricing">Set de precios determina si es valor mid o Bid/Offer.</param>
        /// <param name="CurvaList">Estructura con la data del set de precios.</param>
        /// <param name="FechaSetDePrecios">Fecha del Set de Precios.</param>
        /// <param name="IdCurvaList">Lista con nombres de las curvas a generar.</param>
        /// <returns>Estructura "itemCurva FechaGeneracion='{0}' CodigoCurva='{1}' Dias='{2}' ValorBid='{3}' ValorAsk='{4}'"</returns>
        private static string TagXML_CurvasMoneda(int enuSetPricing, YieldList CurvaList, DateTime FechaSetDePrecios, List<string> IdCurvaList)
        {
            #region CurvasMoneda

            string _CurvasMoneda = "\t<CurvasMoneda>\n";

            cFinancialTools.Yield.YieldValue _Yield = new YieldValue();

            for (int _iYield = 0; _iYield < CurvaList.Count; _iYield++)
            {
                _CurvasMoneda += "\t\t<Curva>\n";

                try
                {
                    _Yield = CurvaList.Read(IdCurvaList[_iYield], enumSource.System, FechaSetDePrecios);

                    for (int _iValue = 0; _iValue < _Yield.Count; _iValue++)
                    {
                        //REVISAR, hay otra parte del cdigo que agrega elementos al xml de curva
                        _CurvasMoneda += string.Format(
                                                    "\t\t\t<itemCurva FechaGeneracion='{0}' CodigoCurva='{1}' " +
                                                    "Dias='{2}' ValorBid='{3}' ValorAsk='{4}' />\n",
                                                    FechaSetDePrecios,
                                                    IdCurvaList[_iYield],
                                                    _Yield.Point(_iValue).Term,
                                                    enuSetPricing.Equals(0) ? _Yield.Point(_iValue).Rate : _Yield.Point(_iValue).RateBid,
                                                    enuSetPricing.Equals(0) ? _Yield.Point(_iValue).Rate : _Yield.Point(_iValue).RateOffer
                                                    );
                    }
                }
                catch { }//ASVG definir qué es mejor, si generar XML vacío o con mensaje de error.
                _CurvasMoneda += "\t\t</Curva>\n";
            }

            _CurvasMoneda += "\t</CurvasMoneda>\n";

            #endregion CurvasMoneda

            return _CurvasMoneda;
        }

        /// <summary>
        /// Genera tag XML con "itemATMRRFLY": TENOR, ATM, RR10D, BF10D, RR25D, BF25D.
        /// </summary>
        /// <param name="_Smile">Smile con información de precios.</param>
        /// <returns>Estructura "itemATMRRFLY TENOR='{0}' ATM='{1}' RR10D='{2}' BF10D='{3}' RR25D='{4}' BF25D='{5}'"</returns>
        private static string TagXML_ATMRRFLY(AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile)
        {
            #region ATMRRFLY

            string _ATMRRFLY = "\t<ATMRRFLY>\n";

            for (int i = 0; i < _Smile.Tenors.Count; i++)
            {
                _ATMRRFLY += string.Format(
                                             "\t\t<itemATMRRFLY TENOR='{0}' ATM='{1}' RR10D='{2}' BF10D='{3}' RR25D='{4}' BF25D='{5}' />\n",
                                             _Smile.Tenors[i],          // 00
                                             _Smile.SmileList[1][i],    // 01
                                             _Smile.SmileList[2][i],    // 02
                                             _Smile.SmileList[3][i],    // 03
                                             _Smile.SmileList[4][i],    // 04
                                             _Smile.SmileList[5][i]     // 05
                                           );
            }

            _ATMRRFLY += "\t</ATMRRFLY>\n";

            #endregion ATMRRFLY

            return _ATMRRFLY;
        }

        /// <summary>
        /// Genera tag XML con "itemCALLPUT": TENOR, PUT10D, PUT25D, ATM, CALL25D, CALL10D
        /// </summary>
        /// <param name="_Smile">Smile con información de precios</param>
        /// <returns>Estructura "itemCALLPUT TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}'"</returns>
        private static string TagXML_CALLPUT(AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile)
        {
            #region CALLPUT

            string _CALLPUT = "\t<CALLPUT>\n";

            for (int i = 0; i < _Smile.Tenors.Count; i++)
            {
                _CALLPUT += string.Format(
                                             "\t\t<itemCALLPUT TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}' />\n",
                                             _Smile.Tenors[i],      // 00
                                             _Smile.Volas[i][0],    // 01
                                             _Smile.Volas[i][1],    // 02
                                             _Smile.Volas[i][2],    // 03
                                             _Smile.Volas[i][3],    // 04
                                             _Smile.Volas[i][4]     // 05
                                           );
            }

            _CALLPUT += "\t</CALLPUT>\n";

            #endregion CALLPUT

            return _CALLPUT;
        }

        /// <summary>
        /// Genera tag XML con "itemSTRIKES": TENOR, PUT10D, PUT25D, ATM, CALL25D, CALL10D
        /// </summary>
        /// <param name="_Smile">Smile con información de precios</param>
        /// <returns>Estructura "itemSTRIKES TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}'"</returns>
        private static string TagXML_STRIKES(AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile)
        {
            #region STRIKES

            string _STRIKES = "\t<STRIKES>\n";

            for (int i = 0; i < _Smile.Tenors.Count; i++)
            {
                _STRIKES += string.Format(
                                             "\t\t<itemSTRIKES TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}' />\n",
                                             _Smile.Tenors[i],          // 00
                                             _Smile.Strikes[i][0],      // 01
                                             _Smile.Strikes[i][1],      // 02
                                             _Smile.Strikes[i][2],      // 03
                                             _Smile.Strikes[i][3],      // 04
                                             _Smile.Strikes[i][4]       // 05
                                           );
            }

            _STRIKES += "\t</STRIKES>\n";

            #endregion STRIKES

            return _STRIKES;
        }

        #endregion TagXML

        #region Tenors

        /// <summary>
        /// Genera una lista con los Tenors en Palabras,
        /// Esto es momentaneo hasta que se cree una tabla con estos datos: DMV 23/12/2009
        /// </summary>
        /// <returns></returns>
        private static List<double> ListaValoresTenor()
        {
            List<double> _Tenor = new List<double>();
            _Tenor.Add(1);          //  1d
            _Tenor.Add(7);          //  1w
            _Tenor.Add(14);         //  2w
            _Tenor.Add(21);         //  3w
            _Tenor.Add(30);         //  1m
            _Tenor.Add(60);         //  2m
            _Tenor.Add(90);         //  3m
            _Tenor.Add(180);        //  6m
            _Tenor.Add(270);        //  9m
            _Tenor.Add(365);        //  1y
            _Tenor.Add(548);        // 18m
            _Tenor.Add(730);        //  2y
            _Tenor.Add(1095);       //  3y
            _Tenor.Add(1460);       //  4y
            _Tenor.Add(1825);       //  5y
            _Tenor.Add(2190);       //  6y
            _Tenor.Add(2555);       //  7y
            _Tenor.Add(2920);       //  8y
            _Tenor.Add(3285);       //  9y
            _Tenor.Add(3650);       // 10y
            _Tenor.Add(5475);       // 15y
            _Tenor.Add(7300);       // 20y
            return _Tenor;
        }

        /// <summary>
        /// Genera una lista con los Tenors en Palabras,
        /// Esto es momentaneo hasta que se cree una tabla con estos datos: DMV 23/12/2009
        /// </summary>
        /// <returns></returns>
        private static List<String> ListaNombresTenor()
        {
            List<String> _T = new List<string>();
            _T.Add("1D");       //  1d
            _T.Add("1W");       //  1w
            _T.Add("2W");       //  2w
            _T.Add("3W");       //  3w
            _T.Add("1M");       //  1m
            _T.Add("2M");       //  2m
            _T.Add("3M");       //  3m
            _T.Add("6M");       //  6m
            _T.Add("9M");       //  9m
            _T.Add("1Y");       //  1y
            _T.Add("18M");      // 18m
            _T.Add("2Y");       //  2y
            _T.Add("3Y");       //  3y
            _T.Add("4Y");       //  4y
            _T.Add("5Y");       //  5y
            _T.Add("6Y");       //  6y
            _T.Add("7Y");       //  7y
            _T.Add("8Y");       //  8y
            _T.Add("9Y");       //  9y
            _T.Add("10Y");      // 10y
            _T.Add("15Y");      // 15y
            _T.Add("20Y");      // 20y
            return _T;
        }

        #endregion Tenors
    }
}
