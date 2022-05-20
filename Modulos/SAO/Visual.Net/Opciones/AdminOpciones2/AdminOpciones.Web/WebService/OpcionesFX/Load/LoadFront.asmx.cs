using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using cData.Opciones;
using System.Data;
using AdminOpcionesTool.Opciones.Functions;
using cFinancialTools.Yield;

namespace AdminOpciones.Web.WebService.OpcionesFX.Load
{
    /// <summary>
    /// Descripción breve de LoadFront
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class LoadFront : System.Web.Services.WebService
    {
        
        [WebMethod]
        public string LoadSpot(int SetPricingLoading, DateTime FechaSetdePrecios)
        {
            

            cFinancialTools.Currency.CurrencyList _CurrencyList = new cFinancialTools.Currency.CurrencyList();                     // Lista de Tipos de Cambios
            _CurrencyList.SetPricingLoading = (enumSetPrincingLoading)SetPricingLoading;
            _CurrencyList.Load(994, enumSource.CurrencyValueAccount, FechaSetdePrecios, "CURVASWAPUSDLOCAL");

            string strSpot="";
            double spot;
            bool Status;

            try
            {
                spot = _CurrencyList.Read(994, enumSource.CurrencyValueAccount, FechaSetdePrecios).ExchangeRateMid;
            }
            catch
            {
                spot = 0;
            }

            Status = Math.Abs(spot) > 0 ? true: false;


            
            strSpot = "<Data>\n";

            #region Fecha Set de Precio
                strSpot += string.Format("\t<FechaSetPrecios  Fecha = '{0}'/>\n", FechaSetdePrecios.ToString("dd-MM-yyyy"));
            #endregion 

            #region Spot
            strSpot += string.Format("\t<Spot Value = '{0}'/>\n", spot);
            #endregion 

            #region Status
            strSpot += string.Format("\t<Status  Value = '{0}' />\n", Status ? "OK" : "NO");
            #endregion
            
            strSpot += "</Data>\n";


            return strSpot;
        }

        [WebMethod]
        public double PuntosForward(DateTime fechaVal, DateTime fechaVcto, DateTime FechaSetDePrecios, double Spot, string CurvaDom, string CurvaFor, int setPricing)
        {

            double _Forward, _Puntos;

            YieldList mYieldList = new YieldList();
            mYieldList.SetPrincingLoading = (enumSetPrincingLoading)setPricing;
            mYieldList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
            mYieldList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

            try
            {
                _Forward = Function.Forward(fechaVal, fechaVcto, FechaSetDePrecios, Spot, CurvaDom, CurvaFor, mYieldList);
                _Puntos = _Forward - Spot;

            }
            catch 
            {
                return double.NaN;

            }

            return _Puntos;


        }

        [WebMethod]
        public string LoadDateProcess()
        {
            string _returnValue;
            DataTable _DTDataProcess = cData.Opciones.LoadFront.LoadDateProcess();            
            
            _returnValue = "<DataLoadFront>\n";

            if (_DTDataProcess == null || _DTDataProcess.Rows.Count.Equals(0))
            {
                _returnValue += "<DateProccess DateProccess= '' Error='1' Mensaje='Problemas en la carga fecha de proceso' />\n";
            }
            else
            {
                _returnValue += "<DateProccess DateProccess= '" + _DTDataProcess.Rows[0][0] + "' Error='0' Mensaje='' />\n";
            }
            
            _returnValue += "</DataLoadFront>";
            
            return _returnValue;
        }

        [WebMethod]
        public string LoadFrontData()
        {
            string _returnValue;

            DataSet _DataSetLoadData = new DataSet();

            _DataSetLoadData = cData.Opciones.LoadFront.LoadAllFront();

            _returnValue = "<DataLoadFront>\n";

            #region Estructuras

            //for (int _Row = 0; _Row < _DataSetLoadData.Tables["OpcionEstructura"].Rows.Count; _Row++ )
            foreach (DataRow _DR in _DataSetLoadData.Tables["OpcionEstructura"].Rows)
            {
                //_returnValue += "<DataOpcionEstructura OpEstCod= '" + _DataSetLoadData.Tables["OpcionEstructura"].Rows[_Row][0] + "'  OpEstDsc ='" + _DataSetLoadData.Tables["OpcionEstructura"].Rows[_Row][1] + "' />\n";                
                _returnValue += string.Format(
                                               "<DataOpcionEstructura OpEstCod='{0}' OpEstDsc ='{1}' />\n",
                                               _DR[0],
                                               _DR[1]
                                             );
            }

            #endregion

            #region Tipos

            //for (int _Row = 0; _Row < _DataSetLoadData.Tables["OpcionTipo"].Rows.Count; _Row++)
            foreach (DataRow _DR in _DataSetLoadData.Tables["OpcionTipo"].Rows)
            {
                //_returnValue += "<DataOpcionTipo OptTipCod= '" + _DataSetLoadData.Tables["OpcionTipo"].Rows[_Row][0] + "'  OpcTipDsc='" + _DataSetLoadData.Tables["OpcionTipo"].Rows[_Row][1] + "'   />\n";
                _returnValue += string.Format(
                                               "<DataOpcionTipo OptTipCod='{0}' OpcTipDsc='{1}' />\n",
                                               _DR[0],
                                               _DR[1]
                                             );
            }

            #endregion

            #region PayOff

            //for (int _Row = 0; _Row < _DataSetLoadData.Tables["PayOffTipo"].Rows.Count; _Row++)
            foreach (DataRow _DR in _DataSetLoadData.Tables["PayOffTipo"].Rows)
            {
                //_returnValue += "<DataOpcionPayOff PayOffTipCod= '" + _DataSetLoadData.Tables["PayOffTipo"].Rows[_Row][0] + "'  PayOffTipDsc='" + _DataSetLoadData.Tables["PayOffTipo"].Rows[_Row][1] + "'   />\n";
                _returnValue += string.Format(
                                               "<DataOpcionPayOff PayOffTipCod='{0}' PayOffTipDsc='{1}' />\n",
                                               _DR[0],
                                               _DR[1]
                                             );
            }

            #endregion

            #region Benchmark

            //for (int _Row = 0; _Row < _DataSetLoadData.Tables["Benchmark"].Rows.Count; _Row++)
            foreach (DataRow _DR in _DataSetLoadData.Tables["FormaDePago"].Rows)
            {
                //_returnValue += "<DataOpcionBenchmark BenchmarkCod= '" + _DataSetLoadData.Tables["Benchmark"].Rows[_Row][0] + "'  BenchmarkDsc='" + _DataSetLoadData.Tables["Benchmark"].Rows[_Row][1] + "'  BenchmarkHora='" + _DataSetLoadData.Tables["Benchmark"].Rows[_Row][2] + "'   />\n";
                _returnValue += string.Format(
                                               "<DataOpcionBenchmark BenchmarkCod='{0}' BenchmarkDsc='{1}' BenchmarkHora='{2}' />\n",
                                               _DR[0],
                                               _DR[1],
                                               _DR[2]
                                             );
            }

            #endregion

            #region Forma Pago

            //for (int _Row = 0; _Row < _DataSetLoadData.Tables["FormaDePago"].Rows.Count; _Row++)
            foreach (DataRow _DR in _DataSetLoadData.Tables["FormaDePago"].Rows)
            {
                //_returnValue += "<DataFormaDePago FormaDePagoCod= '" + _DataSetLoadData.Tables["FormaDePago"].Rows[_Row][0] + "'  FormaDePagoDsc='" + _DataSetLoadData.Tables["FormaDePago"].Rows[_Row][1] + "'  FormaDePagoValuta='" + _DataSetLoadData.Tables["FormaDePago"].Rows[_Row][2] + "' />\n";
                _returnValue += string.Format(
                                               "<DataFormaDePago Moneda='{0}' FormaDePagoCod='{1}' FormaDePagoDsc='{2}' FormaDePagoValuta='{3}' Default='{4}' />\n",
                                               _DR[0],
                                               _DR[1],
                                               _DR[2],
                                               _DR[3],
                                               0
                                             );
            }

            #endregion

            #region Forma Pago por Defecto

            foreach (DataRow _DR in _DataSetLoadData.Tables["FormaPagoDefecto"].Rows)
            {
                //_returnValue += "<DataFormaDePago FormaDePagoCod= '" + _DataSetLoadData.Tables["FormaDePago"].Rows[_Row][0] + "'  FormaDePagoDsc='" + _DataSetLoadData.Tables["FormaDePago"].Rows[_Row][1] + "'  FormaDePagoValuta='" + _DataSetLoadData.Tables["FormaDePago"].Rows[_Row][2] + "' />\n";
                _returnValue += string.Format(
                                               "<DataFormaPagoDefecto ParMoneda='{0}' Moneda1='{1}' Moneda2='{2}' FormaPagoMoneda1='{3}' FormaPagoMoneda2='{4}' />\n",
                                               _DR["OpcParMdaCod"],
                                               _DR["OpcParMda1"],
                                               _DR["OpcParMda2"],
                                               _DR["OpcFPagoMda1"],
                                               _DR["OpcFPagoMda2"]
                                             );
            }

            #endregion

            #region Fecha Proceso

            //_returnValue +=  "<DateProccess DateProccess= '" + _DataSetLoadData.Tables["DateProccess"].Rows[0][0] + "' />";
            _returnValue += string.Format(
                                           "<DateProccess DateProccess= '{0}' />\n",
                                           _DataSetLoadData.Tables["DateProccess"].Rows[0][0]
                                         );

            #endregion

            #region Estados

            //for (int _Row = 0; _Row < _DataSetLoadData.Tables["OptionState"].Rows.Count; _Row++)
            foreach (DataRow _DR in _DataSetLoadData.Tables["OptionState"].Rows)
            {
                //_returnValue += "<OptionState OptionStateCod= '" + _DataSetLoadData.Tables["OptionState"].Rows[_Row][0] + "'  OptionStateDsc='" + _DataSetLoadData.Tables["OptionState"].Rows[_Row][1] + "'  />\n";
                _returnValue += string.Format(
                                               "<OptionState OptionStateCod='{0}'  OptionStateDsc='{1}' />\n",
                                               _DR[0],
                                               _DR[1]
                                             );
            }

            #endregion

            _returnValue += "</DataLoadFront>";

            return _returnValue;
        }
    }
}
