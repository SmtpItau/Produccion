using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using cData.Yield;
using System.Xml.Linq;
using System.Data;

using AdminOpcionesTool.Opciones.Functions;
using cFinancialTools.Yield;

namespace AdminOpciones.Web.WebService.OpcionesFX.ValoriadorCartera
{
    /// <summary>
    /// Descripción breve de SrvCurvasMonedas
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class SrvCurvasMonedas : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetCurvasMonedas(string idCurvasMonedasXML, int enuSetPricing)
        {

            XDocument _xdoc = new XDocument();
            _xdoc = XDocument.Parse(idCurvasMonedasXML);

            cData.Yield.Yield _Moneda = new cData.Yield.Yield();

            List<string> IdCurvaList = new List<string>();

            DateTime _FechaVal = new DateTime();
            //DataTable _DataTableCurvasMoneda;
            DataSet _DataSetCurvasMoneda = new DataSet();

            _FechaVal = DateTime.Parse(_xdoc.Element("CurvasMoneda").Attribute("Fecha").Value);

            foreach(XElement _itemCurva in _xdoc.Descendants("itemCurva") )
            {
                IdCurvaList.Add(_itemCurva.Attribute("ID").Value);
            }

            //for(int i=0; i< IdCurvaList.Count; i++)
            //{
            //    _DataTableCurvasMoneda = new DataTable();
            //    _DataTableCurvasMoneda = _Moneda.LoadValue(IdCurvaList[i], _FechaVal, _FechaVal);
            //    _DataTableCurvasMoneda.TableName = IdCurvaList[i];
            //    _DataSetCurvasMoneda.Merge(_DataTableCurvasMoneda);
            //}

            YieldList CurvaList = new YieldList();
            CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enuSetPricing;
            //CurvaList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, fechaVal);
            //CurvaList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, fechaVal);

            for (int i = 0; i < IdCurvaList.Count; i++) 
            {
                CurvaList.Load(IdCurvaList[i], enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, _FechaVal);
            }

            string _CurvasMonedas="<CurvasMoneda>\n";

            cFinancialTools.Yield.YieldValue _Yield = new YieldValue();;
            for (int _iYield = 0; _iYield < CurvaList.Count; _iYield++ )
            {
                _Yield = CurvaList.Read(IdCurvaList[_iYield], enumSource.System, _FechaVal);
                _CurvasMonedas += "<Curva>\n";
                for (int _iValue = 0; _iValue < _Yield.Count; _iValue++)
                {
                    //_Yield.Point(_iValue).Rate
                    _CurvasMonedas += string.Format(
                                                     "<itemCurva FechaGeneracion='{0}' CodigoCurva='{1}' " +
                                                     "Dias='{2}' ValorBid='{3}' ValorAsk='{4}' />",
                                                     _FechaVal,
                                                     IdCurvaList[_iYield],
                                                     _Yield.Point(_iValue).Term,
                                                     enuSetPricing.Equals(0) ? _Yield.Point(_iValue).Rate : _Yield.Point(_iValue).RateBid,
                                                     enuSetPricing.Equals(0) ? _Yield.Point(_iValue).Rate : _Yield.Point(_iValue).RateOffer
                                                   );
                }
                _CurvasMonedas += "</Curva>\n";
            }

            //foreach (DataTable _Table in _DataSetCurvasMoneda.Tables)
            //{
            //    _CurvasMonedas += "<Curva>\n";
            //    for (int i = 0; i < _Table.Rows.Count; i++)
            //    {
            //        _CurvasMonedas += "<itemCurva FechaGeneracion='" + _Table.Rows[i]["FechaGeneracion"] + "' CodigoCurva='" + _Table.Rows[i]["CodigoCurva"] + "' Dias='" + _Table.Rows[i]["Dias"] + "' ValorBid='" + _Table.Rows[i]["ValorBid"] + "' ValorAsk='" + _Table.Rows[i]["ValorAsk"] + "' />\n";
            //    }
            //    _CurvasMonedas += "</Curva>\n";

            //}
            _CurvasMonedas+="</CurvasMoneda>";

            return _CurvasMonedas;
        }


        [WebMethod]
        public string GetPuntosForward(DateTime fechaVal, DateTime FechaSetdePrecios ,double Spot, string CurvaDom, string CurvaFor, int enumSetPricing)
        {
            try
            {
                cData.Yield.Yield _Moneda = new cData.Yield.Yield();

                DataTable _DataTableCurvaForwadUSD;

                _DataTableCurvaForwadUSD = new DataTable();
                _DataTableCurvaForwadUSD = _Moneda.LoadValue("CurvafwUSD", FechaSetdePrecios, FechaSetdePrecios);
                _DataTableCurvaForwadUSD.TableName = "CurvafwUSD";

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
                CurvaList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);

                DateTime _fechaPlazo = new DateTime();
                double _plazo, _forward;

                string _PesosForward = "<PesosForward>\n";
                try
                {
                    foreach (DataRow _Row in _DataTableCurvaForwadUSD.Rows)
                    {
                        _plazo = double.Parse(_Row["Dias"].ToString());
                        _fechaPlazo = fechaVal.AddDays(_plazo);
                        _forward = Function.Forward(fechaVal, _fechaPlazo, FechaSetdePrecios, Spot, CurvaDom, CurvaFor, CurvaList);
                        _PesosForward += "<itemCurva Dias='" + (int)_plazo + "' Puntos='" + (_forward - Spot) + "'/>\n";
                    }
                }
                catch { }

                _PesosForward += "</PesosForward>\n";

                return _PesosForward;
            }
            catch 
            {
                return "<PesosForward/>\n";
            }
        }
    }
}
