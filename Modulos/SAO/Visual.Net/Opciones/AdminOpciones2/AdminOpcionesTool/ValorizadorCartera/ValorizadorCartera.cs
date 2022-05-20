using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using cData.Opciones;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using AdminOpcionesTool.Opciones.Payoffs;
using cFinancialTools.DayCounters;
using cFinancialTools.Yield;
using System.IO;

namespace AdminOpcionesTool.ValorizadorCartera
{
    public static class ValorizadorCartera
    {
        public static XDocument GetData(DateTime fechaContrato, string CaEstado, DateTime fechaDeProcesoSistema, string paridad, double spot, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing)
        {

            if (CaEstado.Equals("T"))
            {
                if (fechaContrato.ToString("dd-MM-yyyy").Equals(fechaDeProcesoSistema.ToString("dd-MM-yyyy")))
                {
                    CaEstado = "' OR CaEncContrato.CaEstado = 'C' )) --";
                }
                else
                {
                    //CaEstado = "' OR CaResEncContrato.CaEstado = 'C')) ORDER BY CaNumContrato --";
                    CaEstado = "' OR CaResEncContrato.CaEstado = 'C' )) --";
                }
            }

            DataSet _DataSetDeContratoFixing = new DataSet();

            _DataSetDeContratoFixing = ValorizarCarteraData.LoadValorizacionCarteraData(fechaContrato, CaEstado, fechaDeProcesoSistema);


            DataRow _Row;

            DataTable _DataTable = new DataTable();

            _DataTable = _DataSetDeContratoFixing.Tables["CaDetContrato"];

            string _DetContratoFixingData = "<Data>\n";
            _DetContratoFixingData += "<DetContrato>\n";

            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                _Row = _DataTable.Rows[i];
                _DetContratoFixingData += "<itemDetContrato NumContrato='" + _Row["CaNumContrato"] + "' ";
                _DetContratoFixingData += "CodEstructura='" + _Row["CaCodEstructura"] + "' ";
                _DetContratoFixingData += "NumEstructura='" + _Row["CaNumEstructura"] + "' ";
                _DetContratoFixingData += "Vinculacion='" + _Row["CaVinculacion"] + "' ";
                _DetContratoFixingData += "TipoPayOff='" + _Row["CaTipoPayOff"] + "' ";
                _DetContratoFixingData += "CallPut='" + _Row["CaCallPut"] + "' ";
                _DetContratoFixingData += "CVOpc='" + _Row["CaCVOpc"] + "' ";
                _DetContratoFixingData += "FechaInicioOpc='" + _Row["CaFechaInicioOpc"] + "' ";
                _DetContratoFixingData += "FechaVcto='" + _Row["CaFechaVcto"] + "' ";
                _DetContratoFixingData += "Strike='" + _Row["CaStrike"] + "' ";
                _DetContratoFixingData += "MontoMon1='" + _Row["CaMontoMon1"] + "' ";
                _DetContratoFixingData += "ParStrike='" + _Row["CaParStrike"] + "' ";
                _DetContratoFixingData += "SpotDet='" + _Row["CaSpotDet"] + "' ";
                _DetContratoFixingData += "CurveMon1='" + _Row["CaCurveMon1"] + "' ";
                _DetContratoFixingData += "CurveMon2='" + _Row["CaCurveMon2"] + "' ";
                _DetContratoFixingData += "PorcStrike='" + _Row["CaPorcStrike"] + "' ";//PRD_12567
                _DetContratoFixingData += "  />\n";
            }

            _DetContratoFixingData += "</DetContrato>\n";


            _DataTable = _DataSetDeContratoFixing.Tables["CaFixing"];

            _DetContratoFixingData += "<Fixing>\n";

            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                _Row = _DataTable.Rows[i];
                _DetContratoFixingData += "<itemFixing NumContrato='" + _Row["CaNumContrato"] + "' ";
                _DetContratoFixingData += "NumEstructura='" + _Row["CaNumEstructura"] + "' ";
                _DetContratoFixingData += "FixFecha='" + _Row["CaFixFecha"] + "' ";
                _DetContratoFixingData += "FixNumero='" + _Row["CaFixNumero"] + "' ";
                _DetContratoFixingData += "PesoFij='" + (double.Parse(_Row["CaPesoFij"].ToString()) / 100.0).ToString() + "' ";
                _DetContratoFixingData += "VolFij='" + _Row["CaVolFij"] + "' ";
                _DetContratoFixingData += "Fijacion='" + _Row["CaFijacion"] + "' ";
                _DetContratoFixingData += "  />\n";
            }
            _DetContratoFixingData += "</Fixing>\n";

            AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(fechaContrato, paridad, spot, curvaDom, curvaFor, 0);
            
            if (spot != double.NaN)
            {
                _Smile.Load(setPricing);
            }

            _DetContratoFixingData += "<ATMRRFLY>\n";

            for (int i = 0; i < _Smile.Tenors.Count; i++)
            {
                _DetContratoFixingData += "<itemATMRRFLY TENOR='" + _Smile.Tenors[i] + "' ";
                _DetContratoFixingData += " ATM='" + _Smile.SmileList[1][i] + "' ";
                _DetContratoFixingData += " RR10D='" + _Smile.SmileList[2][i] + "' ";
                _DetContratoFixingData += " BF10D='" + _Smile.SmileList[3][i] + "' ";
                _DetContratoFixingData += " RR25D='" + _Smile.SmileList[4][i] + "' ";
                _DetContratoFixingData += " BF25D='" + _Smile.SmileList[5][i] + "' />\n";
            }

            _DetContratoFixingData += "</ATMRRFLY>\n";

            _DetContratoFixingData += "<CALLPUT>\n";
            for (int i = 0; i < _Smile.Tenors.Count; i++)
            {
                _DetContratoFixingData += "<itemCALLPUT TENOR='" + _Smile.Tenors[i] + "' ";
                _DetContratoFixingData += " PUT10D='" + _Smile.Volas[i][0] + "' ";
                _DetContratoFixingData += " PUT25D='" + _Smile.Volas[i][1] + "' ";
                _DetContratoFixingData += " ATM='" + _Smile.Volas[i][2] + "' ";
                _DetContratoFixingData += " CALL25D='" + _Smile.Volas[i][3] + "' ";
                _DetContratoFixingData += " CALL10D='" + _Smile.Volas[i][4] + "' />\n";
            }
            _DetContratoFixingData += "</CALLPUT>\n";

            _DetContratoFixingData += "<STRIKES>\n";
            for (int i = 0; i < _Smile.Tenors.Count; i++)
            {
                _DetContratoFixingData += "<itemSTRIKES TENOR='" + _Smile.Tenors[i] + "' ";
                _DetContratoFixingData += " PUT10D='" + _Smile.Strikes[i][0] + "' ";
                _DetContratoFixingData += " PUT25D='" + _Smile.Strikes[i][1] + "' ";
                _DetContratoFixingData += " ATM='" + _Smile.Strikes[i][2] + "' ";
                _DetContratoFixingData += " CALL25D='" + _Smile.Strikes[i][3] + "' ";
                _DetContratoFixingData += " CALL10D='" + _Smile.Strikes[i][4] + "' />\n";
            }
            _DetContratoFixingData += "</STRIKES>\n";

            _DetContratoFixingData += "</Data>";

            XDocument DetContratoFixingDataXML = new XDocument(); ;
            try
            {
                DetContratoFixingDataXML = XDocument.Parse(_DetContratoFixingData);
            }
            catch { }

            return DetContratoFixingDataXML;
        }

        //public static XDocument GetEncDetFixData(DateTime fechaContrato, string CaEstado, DateTime fechaDeProcesoSistema, string paridad, double spot, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing)
        public static XDocument GetEncDetFixData(DateTime fechaContrato, string CaEstado, DateTime fechaDeProcesoSistema)
        {

            #region Chequeo de estado

            if (!CaEstado.Equals(""))
            {
                if (CaEstado.Split(',')[0].Equals("!"))
                {
                    CaEstado = CaEstado.Remove(0, 2);
                    CaEstado = "ENC.CaEstado Not in ( " + CaEstado + " )";
                }
                else
                {
                    CaEstado = "ENC.CaEstado in ( " + CaEstado + " )";
                }

            }

            #endregion

            #region Definición de variables

            DataSet _DataSetEncCOntratoDeContratoFixing = new DataSet();
            string _KeyContrato;
            double _Peso;
            int _numContrato;
            string _EncDetFix;
            DataTable _DataTableEncContrato = new DataTable();
            DataTable _DataTableDetContrato = new DataTable();
            DataTable _DataTableFijaciones = new DataTable();
            DataTable _DataTableDeltaSpot = new DataTable();
            DataTable _DataTableDeltaForward = new DataTable();
            double _deltaSpot = 0;
            double _deltaForward = 0;
            XDocument EncContratoDetContratoFixingDataXML = new XDocument();

            #endregion

            #region Obtención de datos

            _DataSetEncCOntratoDeContratoFixing = ValorizarCarteraData.LoadValorizacionCarteraData(fechaContrato, CaEstado, fechaDeProcesoSistema);

            #endregion

            #region Seteo de Tablas

            _DataTableEncContrato = _DataSetEncCOntratoDeContratoFixing.Tables["CaEncContrato"];
            _DataTableDetContrato = _DataSetEncCOntratoDeContratoFixing.Tables["CaDetContrato"];
            _DataTableFijaciones = _DataSetEncCOntratoDeContratoFixing.Tables["CaFixing"];

            try
            {
                _DataTableDeltaSpot = _DataSetEncCOntratoDeContratoFixing.Tables["SpotDelta"];
            }
            catch
            {
                _DataTableDeltaSpot = null;
            }

            try
            {
                _DataTableDeltaForward = _DataSetEncCOntratoDeContratoFixing.Tables["ForwardDelta"];
            }
            catch
            {
                _DataTableDeltaForward = null;
            }

            #endregion

            #region Genera formato XML

            _EncDetFix = "<Data>\n";

            #region Contratos

            foreach (DataRow _DREncabezado in _DataTableEncContrato.Rows)
            {
                _numContrato = int.Parse(_DREncabezado["caNumContrato"].ToString());
                _KeyContrato = string.Format("CaNumContrato='{0}'", _numContrato);

                _EncDetFix += string.Format("\t<Opcion NumContrato='{0}'>\n", _numContrato);

                #region Encabezado

                _EncDetFix += string.Format(
                                             "\t\t<itemEncContrato NumContrato='{0}' NumFolio='{1}' CodEstructura='{2}' Opcion='{3}' CVEstructura='{4}' " +
                                             "FechaContrato='{5}' FecValorizacion='{6}' Estado='{7}' CarteraFinanciera='{8}' Libro='{9}' " +
                                             "CarNormativa='{10}' SubCarNormativa='{11}' RutCliente='{12}' Codigo='{13}' TipoContrapartida='{14}' " +
                                             "CaCodMonPagPrima='{15}' PrimaInicial='{16}' ResultadoVta='{17}' ParMdaPrima='{18}' PrimaInicialML='{19}' CafPagoPrima='{20}' " +
                                             "Glosa='{21}' TipoTransaccion='{22}' FinancialPortfolio='{23}' Book='{24}' PortfolioRules='{25}' SubPortfolioRules='{26}' " +
                                             "NombreCliente='{27}' RelacionaPAE='{28}' />\n",
                                             _numContrato,                          // 00
                                             _DREncabezado["CaNumFolio"],           // 01
                                             _DREncabezado["caCodEstructura"],      // 02
                                             _DREncabezado["Opcion"],               // 03
                                             _DREncabezado["caCVEstructura"],       // 04
                                             _DREncabezado["caFechaContrato"],      // 05
                                             _DREncabezado["caFecValorizacion"],    // 06
                                             _DREncabezado["CaEStado"],             // 07
                                             _DREncabezado["CaCarteraFinanciera"],  // 08
                                             _DREncabezado["caLibro"],              // 09
                                             _DREncabezado["caCarNormativa"],       // 10
                                             _DREncabezado["caSubCarNormativa"],    // 11
                                             _DREncabezado["caRutCliente"],         // 12
                                             _DREncabezado["caCodigo"],             // 13
                                             _DREncabezado["caTipoContrapartida"],  // 14
                                             _DREncabezado["CaCodMonPagPrima"],     // 15
                                             _DREncabezado["CaPrimaInicial"],       // 16  //5843
                                             _DREncabezado["CaResultadoVentasML"],  // 17
                                             _DREncabezado["CaParMdaPrima"],        // 18
                                             _DREncabezado["CaPrimaInicialML"],     // 19
                                             _DREncabezado["CafPagoPrima"],         // 20
                                             _DREncabezado["CaGlosa"],              // 21
                                             _DREncabezado["CaTipoTransaccion"],    // 22
                                             _DREncabezado["FinancialPortfolio"],   // 23
                                             _DREncabezado["Book"],                 // 24
                                             _DREncabezado["PortfolioRules"],       // 25
                                             _DREncabezado["SubPortfolioRules"],    // 26
                                             _DREncabezado["NombreCliente"],        // 27
                                             //PRD_10449
                                             _DREncabezado["CaRelacionaPAE"]        // 28
                                           );

                #endregion

                #region Detalle de Contratos

                foreach (DataRow _DRDetalle in _DataTableDetContrato.Select(_KeyContrato))
                {
                    _EncDetFix += string.Format(
                                                 "\t\t<itemDetContrato NumContrato='{0}' CodEstructura='{1}' NumEstructura='{2}' Vinculacion='{3}' " +
                                                 "TipoPayOff='{4}' CallPut='{5}' CVOpc='{6}' FechaInicioOpc='{7}' FechaVcto='{8}' Strike='{9}' " +
                                                 "MontoMon1='{10}' ParStrike='{11}' SpotDet='{12}' CurveMon1='{13}' CurveMon2='{14}' " +
                                                 "CaFormaPagoMon1='{15}' CaFormaPagoMon2='{16}' CaMdaCompensacion='{17}' CaFormaPagoComp='{18}' " +
                                                 "Modalidad='{19}' TipoTransaccion='{20}' CaTipoEjercicio='{21}' CaPorcStrike = '{22}'/>\n", //PRD_12567
                                                 _DRDetalle["CaNumContrato"],           // 00
                                                 _DRDetalle["CaCodEstructura"],         // 01
                                                 _DRDetalle["CaNumEstructura"],         // 02
                                                 _DRDetalle["CaVinculacion"],           // 03
                                                 _DRDetalle["CaTipoPayOff"],            // 04
                                                 _DRDetalle["CaCallPut"],               // 05
                                                 _DRDetalle["CaCVOpc"],                 // 06
                                                 _DRDetalle["CaFechaInicioOpc"],        // 07
                                                 _DRDetalle["CaFechaVcto"],             // 08
                                                 _DRDetalle["CaStrike"],                // 09
                                                 _DRDetalle["CaMontoMon1"],             // 10
                                                 _DRDetalle["CaParStrike"],             // 11
                                                 _DRDetalle["CaSpotDet"],               // 12
                                                 _DRDetalle["CaCurveMon1"],             // 13
                                                 _DRDetalle["CaCurveMon2"],             // 14
                                                 _DRDetalle["CaFormaPagoMon1"],         // 15
                                                 _DRDetalle["CaFormaPagoMon2"],         // 16
                                                 _DRDetalle["CaMdaCompensacion"],       // 17
                                                 _DRDetalle["CaFormaPagoComp"],         // 18
                                                 _DRDetalle["CaModalidad"],             // 19
                                                 _DRDetalle["CaTipoTransaccion"],       // 20
                                                 _DRDetalle["CaTipoEjercicio"],         // 21
                                                 _DRDetalle["CaPorcStrike"]             // 22 PRD_12567
                                               );
                }

                #endregion

                #region Fixing

                foreach (DataRow _DRFixing in _DataTableFijaciones.Select(_KeyContrato))
                {

                    _Peso = (double.Parse(_DRFixing["CaPesoFij"].ToString()) / 100.0);
                    _EncDetFix += string.Format(
                                                 "\t\t<itemFixing NumContrato='{0}' NumEstructura='{1}' FixFecha='{2}' FixNumero='{3}' PesoFij='{4}' " +
                                                 "VolFij='{5}' Fijacion='{6}' />\n",
                                                 _DRFixing["CaNumContrato"],                // 00
                                                 _DRFixing["CaNumEstructura"],              // 01
                                                 _DRFixing["CaFixFecha"],                   // 02
                                                 _DRFixing["CaFixNumero"],                  // 03
                                                 _Peso,                                     // 04
                                                 _DRFixing["CaVolFij"],                     // 05
                                                 _DRFixing["CaFijacion"]                    // 06
                                               );
                }

                _EncDetFix += "\t</Opcion>\n";
                
                #endregion

            }

            #endregion

            #region Obtención de deltas

            #region Obtención del Delta Spot

            try
            {
                if (_DataTableDeltaSpot.Rows.Count > 0 && _DataTableDeltaSpot.Rows[0][4] != null && !_DataTableDeltaSpot.Rows[0][4].ToString().Equals(""))
                {
                    _deltaSpot = double.Parse(_DataTableDeltaSpot.Rows[0][4].ToString());
                }
            }
            catch
            {
                _deltaSpot = 0;
            }

            #endregion

            #region Obtención del Delta Forward

            try
            {
                if (_DataTableDeltaForward.Rows.Count > 0 && _DataTableDeltaForward.Rows[0][0] != null && !_DataTableDeltaForward.Rows[0][0].ToString().Equals(""))
                {
                    _deltaForward = double.Parse(_DataTableDeltaForward.Rows[0][0].ToString());
                }
            }
            catch
            {
                _deltaForward = 0;
            }

            #endregion

            _EncDetFix += string.Format(
                                         "\t<Deltas  SpotDelta='{0}' ForwardDelta='{1}' />\n",
                                         _deltaSpot.ToString("#,##0.#0000"),        // 00
                                         _deltaForward.ToString("#,##0.#0000")      // 01
                                       );

            #endregion

            //Comentado!
            #region Smile

            //AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(fechaContrato, paridad, spot, curvaDom, curvaFor, 0);            

            //if (!spot.Equals(double.NaN))
            //    _Smile.Load(setPricing);
          
            //#region ATMRRFLY

            //_EncDetFix += "\t<ATMRRFLY>\n";

            //for (int i = 0; i < _Smile.Tenors.Count; i++)
            //{
            //    _EncDetFix += string.Format(
            //                                 "\t\t<itemATMRRFLY TENOR='{0}' ATM='{1}' RR10D='{2}' BF10D='{3}' RR25D='{4}' BF25D='{5}' />\n",
            //                                 _Smile.Tenors[i],          // 00
            //                                 _Smile.SmileList[1][i],    // 01
            //                                 _Smile.SmileList[2][i],    // 02
            //                                 _Smile.SmileList[3][i],    // 03
            //                                 _Smile.SmileList[4][i],    // 04
            //                                 _Smile.SmileList[5][i]     // 05
            //                               );

            //}

            //_EncDetFix += "\t</ATMRRFLY>\n";

            //#endregion

            //#region CALLPUT

            //_EncDetFix += "\t<CALLPUT>\n";

            //for (int i = 0; i < _Smile.Tenors.Count; i++)
            //{
            //    _EncDetFix += string.Format(
            //                                 "\t\t<itemCALLPUT TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}' />\n",
            //                                 _Smile.Tenors[i],      // 00
            //                                 _Smile.Volas[i][0],    // 01
            //                                 _Smile.Volas[i][1],    // 02
            //                                 _Smile.Volas[i][2],    // 03
            //                                 _Smile.Volas[i][3],    // 04
            //                                 _Smile.Volas[i][4]     // 05
            //                               );
            //}

            //_EncDetFix += "\t</CALLPUT>\n";

            //#endregion

            //#region STRIKES

            //_EncDetFix += "\t<STRIKES>\n";

            //for (int i = 0; i < _Smile.Tenors.Count; i++)
            //{
            //    _EncDetFix += string.Format(
            //                                 "\t\t<itemSTRIKES TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}' />\n",
            //                                 _Smile.Tenors[i],          // 00
            //                                 _Smile.Strikes[i][0],      // 01
            //                                 _Smile.Strikes[i][1],      // 02
            //                                 _Smile.Strikes[i][2],      // 03
            //                                 _Smile.Strikes[i][3],      // 04
            //                                 _Smile.Strikes[i][4]       // 05
            //                               );
            //}

            //_EncDetFix += "\t</STRIKES>\n";

            //#endregion

            #endregion

            _EncDetFix += "</Data>\n";

            #endregion

            #region Seteo de variable XML

            try
            {
                EncContratoDetContratoFixingDataXML = XDocument.Parse(_EncDetFix);
            }
            catch { }

            #endregion

            return EncContratoDetContratoFixingDataXML;
        }

        public static string ValorizarCartera(List<StructDetContrato> DetContratoList, List<StructFixingDataContrato> FijacionesList, AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile, YieldList CurvaList, enumSetPrincingLoading setPricing
            , string curvasXML)
        {
            //ASVG_20130226
            //MEJORAR sacar esto, es solo para profiling.
            //PROFILING
            TimeSpan tsTotalVanillas = new TimeSpan(0, 0, 0);
            TimeSpan tsTotalAsiatico = new TimeSpan(0, 0, 0);
            TimeSpan tsTotalFwdES = new TimeSpan(0, 0, 0);
            TimeSpan tsTotalAmerican = new TimeSpan(0, 0, 0);

            //ASVG REVISAR
            /*
            string __FileExecuting = AdminOpcionesTool.ValorizadorCartera.Global.ServiceConnect + "Log_ValorizarCartera.txt";

            FileStream _StreamFileExecuting = new FileStream(__FileExecuting, FileMode.Append, FileAccess.Write);
            StreamWriter _FileExecuting = new StreamWriter(_StreamFileExecuting,Encoding.UTF8);
            _FileExecuting.AutoFlush = true;
            _FileExecuting.WriteLine();
            _FileExecuting.WriteLine("Entrando ValorizarCartera: " + DateTime.Now.ToString());
            _FileExecuting.Flush();//PROFILING

            //logueamos los parámetros de invocación de la función
            _FileExecuting.WriteLine("LOG: " + DetContratoList.ToString() + "\n\n" + FijacionesList.ToString());
            */

            string MtMGriegasOpcion = "";
            string TempOpcion = "";
            string _ForwardAmericano = "";
            string _Ticket = "";
            DateTime _ValuatorDate = new DateTime();
            double _Spot = 0;
            string _YieldDomestic = "";
            string _YieldForeign = "";
            List<StructDetContrato> _ForwardAmericanoList = new List<StructDetContrato>();

            for (int i = 0; i < DetContratoList.Count; i++)
            {
                if (!DetContratoList[i].Checked) continue;

                #region if Americano
                //MEJORAR esta condición
                //if (DetContratoList[i].CodEstructura.Equals(8) || DetContratoList[i].CodEstructura.Equals(13))
                if (DetContratoList[i].CodEstructura.Equals(8))
                {
                    _ForwardAmericanoList.Add(DetContratoList[i]);
                    _ValuatorDate = DetContratoList[i].FechaInicioOpc;
                    _Spot = DetContratoList[i].SpotDet;
                    _YieldDomestic = DetContratoList[i].CurveMon1;
                    _YieldForeign = DetContratoList[i].CurveMon2;
                }
                #endregion if Americano
                #region if Vanilla /PayOff.Equals("01")
                else if (DetContratoList[i].TipoPayOff.Equals("01"))//VANILLA                    
                {
                    string call_put_flag = DetContratoList[i].CallPut.Equals("Call") ? "c" : "p";
                    string conpraVenta = DetContratoList[i].CVOpc.Equals("C") ? "compra" : "venta";

                    Vanilla _Vanilla = new Vanilla(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, 0, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing);

                    DateTime _dt = DateTime.Now;//PROFILING

                    TempOpcion = _Vanilla.Opcion(DetContratoList[i].NumEstructura, DetContratoList[i].Vinculacion, "BsSpot") + "\n";

                    tsTotalVanillas += DateTime.Now - _dt;//PROFILING

                    XElement xElemet_Opcion = XElement.Parse(TempOpcion);

                    XAttribute _NumContratoAttribute = new XAttribute("NumContrato", DetContratoList[i].NumContrato);
                    XAttribute _NumEstructuraAttribute = new XAttribute("NumEstructura", DetContratoList[i].NumEstructura);
                    xElemet_Opcion.Add(_NumContratoAttribute);
                    xElemet_Opcion.Add(_NumEstructuraAttribute);

                    MtMGriegasOpcion += xElemet_Opcion.ToString();

                }
                #endregion if Vanilla /PayOff.Equals("01")
                #region if Asiatica /PayOff.Equals("02")
                else if (DetContratoList[i].TipoPayOff.Equals("02"))//Asiatica
                {
                    StructFixingDataContrato _FijacionesOpcion = new StructFixingDataContrato();
                    string call_put_flag = DetContratoList[i].CallPut.Equals("Call") ? "c" : "p";
                    string conpraVenta = DetContratoList[i].CVOpc.Equals("C") ? "compra" : "venta";

                    try
                    {
                        _FijacionesOpcion = FijacionesList.Where(x => x.NumContrato == DetContratoList[i].NumContrato && x.NucEstructura == DetContratoList[i].NumEstructura).ToList<StructFixingDataContrato>()[0];
                    }
                    catch
                    {
                        _FijacionesOpcion = null;
                    }

                    if (_FijacionesOpcion != null)
                    {

                        List<DateTime> fechas_fijacion = new List<DateTime>();
                        List<double> pesos_fijacion = new List<double>();
                        List<double> fijaciones = new List<double>();
                        List<double> volatilidades = new List<double>();
                        List<int> plazos = new List<int>();

                        Basis _Basis365;
                        int plazo;
                        int k = 0;

                        foreach (StructFixingData _fixing in _FijacionesOpcion.Fijaciones)
                        {
                            _Basis365 = new Basis(enumBasis.Basis_Act_365, DetContratoList[i].FechaInicioOpc, _fixing.Fecha);
                            plazo = (int)_Basis365.Term;
                            plazos.Add(plazo);
                            k++;
                        }

                        for (int j = 0; j < _FijacionesOpcion.Fijaciones.Count; j++)
                        {
                            fechas_fijacion.Add(_FijacionesOpcion.Fijaciones[j].Fecha);
                            pesos_fijacion.Add(_FijacionesOpcion.Fijaciones[j].Peso);
                            fijaciones.Add(_FijacionesOpcion.Fijaciones[j].Valor);
                            volatilidades.Add(_FijacionesOpcion.Fijaciones[j].Volatilidad);
                        }

                        //OJO: el objeto "Asiatica" tiene la CurvaList, que es accesible desde el valorizador que está dentro de la clase
                        //por lo que no sería necesario pasar las curvas como parámetro...
                        //lo que no entiendo es porqué se pasa el enumSetPrincingLoading setPricing si va dentro del YieldList CurvaList
                        
                        //ASVG_20130212
                        if(DetContratoList[i].CodEstructura.Equals(13))
                        {
                            DateTime _dt = DateTime.Now;//PROFILING

                            Forward _Forward = new Forward(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet
                                , DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos);

                            _Forward.Strike = DetContratoList[i].PorcStrike;
                            
                            TempOpcion = _Forward.ForwardAsiaticoEntradaSalida(DetContratoList[i].NumEstructura, DetContratoList[i].Vinculacion); //MEJORAR

                            tsTotalFwdES += DateTime.Now - _dt;//PROFILING
                        }
                        else
                        {
                            DateTime _dt = DateTime.Now;//PROFILING

                            Asiatica _Asiatica = new Asiatica(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet
                                , DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos);

                            TempOpcion = _Asiatica.Opcion(DetContratoList[i].NumEstructura, DetContratoList[i].Vinculacion);

                            tsTotalAsiatico += DateTime.Now - _dt;//PROFILING
                        }

                        XElement xElemet_Opcion = XElement.Parse(TempOpcion);

                        XAttribute _NumContratoAttribute = new XAttribute("NumContrato", DetContratoList[i].NumContrato);
                        XAttribute _NumEstructuraAttribute = new XAttribute("NumEstructura", DetContratoList[i].NumEstructura);
                        xElemet_Opcion.Add(_NumContratoAttribute);
                        xElemet_Opcion.Add(_NumEstructuraAttribute);

                        MtMGriegasOpcion += xElemet_Opcion.ToString();
                    }
                }
                #endregion if Asiatica /PayOff.Equals("02")
            }

            //PROFILING
            /*
            _FileExecuting.WriteLine("Entrando ForwardAmericano: " + DateTime.Now.ToString());
            _FileExecuting.Flush();
            */

            DateTime _dta = DateTime.Now;//PROFILING

            #region Valorización Forward Americano
            if (_ForwardAmericanoList.Count > 0)
            {
                string _ValueFwdAmericano = "";
                int _Count = 0;
                foreach (StructDetContrato _FwdAmer in _ForwardAmericanoList)
                {
                    int _SetPrice = 0;
                    if (setPricing == enumSetPrincingLoading.Costo)
                    {
                        _SetPrice = 2;
                    }

                    _Ticket = string.Format(
                                             "\t\t<Ticket OperationNumber='{0}' StructureID='{1}' Notional='{2}' Strike='{3}' ExpiryDate='{4}' Position='{5}' " +
                                             "Exercize='{6}' Gennus='{7}' StructureType='{8}' MTM='{9}' />\n",
                                              _FwdAmer.NumContrato,
                                              _FwdAmer.NumEstructura,
                                              _FwdAmer.MontoMon1,
                                              _FwdAmer.Strike,
                                              _FwdAmer.FechaVcto.ToString("dd/MM/yyyy"),
                                              _FwdAmer.CVOpc,
                                              "A",
                                              _FwdAmer.CallPut,
                                              _FwdAmer.CodEstructura,
                                              0
                                            );

                    _ForwardAmericano = "";
                    _ForwardAmericano += "<Pricing>\n";
                    _ForwardAmericano += "\t<Tickets>\n";
                    _ForwardAmericano += _Ticket;
                    _ForwardAmericano += "\t</Tickets>\n";
                    _ForwardAmericano += string.Format(
                                                        "\t<Data SetPrice='{0}' ValuatorDate='{1}' IsGreek='N' >\n",
                                                        _SetPrice,
                                                        _ValuatorDate.ToString("dd/MM/yyyy")
                                                      );

                    _ForwardAmericano += string.Format("\t\t<Spot Value='{0}' />\n", _Spot);
                    _ForwardAmericano += string.Format("\t\t<Yields Value='{0},{1}'>\n", _YieldDomestic, _YieldForeign);

                    _ForwardAmericano += string.Format("\t\t\t<Foreign YieldName='{0}' Type='FOREIGN'>\n", _YieldForeign);
                    _ForwardAmericano += "\t\t\t</Foreign>\n";

                    _ForwardAmericano += string.Format("\t\t\t<Domestic YieldName='{0}' Type='DOMESTIC'>\n", _YieldDomestic);
                    _ForwardAmericano += "\t\t\t</Domestic>\n";

                    _ForwardAmericano += "\t\t</Yields>\n";
                    _ForwardAmericano += "\t</Data>\n";
                    _ForwardAmericano += "</Pricing>\n";

                    _ValueFwdAmericano = string.Format("<Root>{0}</Root>", ValuatorOptions.Valuator(_ForwardAmericano));
                    XDocument _Fwd = XDocument.Parse(_ValueFwdAmericano);
                    if (_Count.Equals(0))
                    {
                        MtMGriegasOpcion += _Fwd.Element("Root").Element("ObservedDollar").ToString();
                        _Count = 1;
                    }
                    MtMGriegasOpcion += _Fwd.Element("Root").Element("Opcion").ToString();
                }
            }
            #endregion Valorización Forward Americano

            tsTotalAmerican = DateTime.Now - _dta;//PROFILING

            //PROFILING
            /*
            _FileExecuting.WriteLine("Saliendo ValorizarCartera: " + DateTime.Now.ToString());
            _FileExecuting.WriteLine("Total Vanillas  : " + tsTotalVanillas.ToString());
            _FileExecuting.WriteLine("Total Asiáticas : " + tsTotalAsiatico.ToString());
            _FileExecuting.WriteLine("Total Forward ES: " + tsTotalFwdES.ToString());
            _FileExecuting.WriteLine("Total Americanos: " + tsTotalAmerican.ToString());
            _FileExecuting.Flush();
            //PROFILING
            _FileExecuting.Close();
            _StreamFileExecuting.Close();
            */

            return MtMGriegasOpcion;
        }

        public static string TopologiaVega(string BsSpot_BsFwd, List<StructDetContrato> DetContratoList, List<StructFixingDataContrato> FijacionesList, AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile, YieldList CurvaList, double MTM_Totalizador, string rrfly_callput, enumSetPrincingLoading setPricing)
        {

            if (rrfly_callput.Equals("rrfly"))
            {

                string RRFLYDesplazado = "";
                try
                {
                    AdminOpcionesTool.Opciones.SmileNameSpace.Smile _SmileDesplazado;
                    RRFLYDesplazado = "<RRFLY rows='" + _Smile.Tenors.Count + "' detContratoElements='" + DetContratoList.Count + "' MTMTOTAL='" + MTM_Totalizador + "' >\n";

                    for (int row = 0; row < _Smile.Tenors.Count; row++)
                    {
                        _SmileDesplazado = _Smile.DesplazamientoATMRRFLY(row, "atm");
                        RRFLYDesplazado += "<ATM row='" + row + "' tenor='" + _SmileDesplazado.Tenors[row] + "' >\n";
                        RRFLYDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _SmileDesplazado, CurvaList, setPricing);
                        RRFLYDesplazado += "</ATM>\n";


                        _SmileDesplazado = _Smile.DesplazamientoATMRRFLY(row, "rr10");
                        RRFLYDesplazado += "<RR10 row='" + row + "' tenor='" + _SmileDesplazado.Tenors[row] + "'>\n";
                        RRFLYDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _SmileDesplazado, CurvaList, setPricing);
                        RRFLYDesplazado += "</RR10>\n";

                        _SmileDesplazado = _Smile.DesplazamientoATMRRFLY(row, "rr25");
                        RRFLYDesplazado += "<RR25 row='" + row + "' tenor='" + _SmileDesplazado.Tenors[row] + "'>\n";
                        RRFLYDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _SmileDesplazado, CurvaList, setPricing);
                        RRFLYDesplazado += "</RR25>\n";

                        _SmileDesplazado = _Smile.DesplazamientoATMRRFLY(row, "bf10");
                        RRFLYDesplazado += "<BF10 row='" + row + "' tenor='" + _SmileDesplazado.Tenors[row] + "'>\n";
                        RRFLYDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _SmileDesplazado, CurvaList, setPricing);
                        RRFLYDesplazado += "</BF10>\n";

                        _SmileDesplazado = _Smile.DesplazamientoATMRRFLY(row, "bf25");
                        RRFLYDesplazado += "<BF25 row='" + row + "' tenor='" + _SmileDesplazado.Tenors[row] + "'>\n";
                        RRFLYDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _SmileDesplazado, CurvaList, setPricing);
                        RRFLYDesplazado += "</BF25>\n";
                    }

                    RRFLYDesplazado += "</RRFLY>";
                }
                catch
                {
                    RRFLYDesplazado = "<RRFLY/>";
                }

                return RRFLYDesplazado;
            }
            else if (rrfly_callput.Equals("callput"))
            {
                string CALLPUTDesplazado = "";
                try
                {
                    AdminOpcionesTool.Opciones.SmileNameSpace.Smile _SmileDesplazado;

                    CALLPUTDesplazado = "<CALLPUT rows='" + _Smile.Tenors.Count + "' detContratoElements='" + DetContratoList.Count + "' MTMTOTAL='" + MTM_Totalizador + "' >\n";

                    for (int row = 0; row < _Smile.Tenors.Count; row++)
                    {
                        //_SmileDesplazado = _Smile.DesplazamientoVolas(row, "atm");
                        _Smile.Volas[row][2] += 0.01;
                        CALLPUTDesplazado += "<ATM row='" + row + "' tenor='" + _Smile.Tenors[row] + "' >\n";
                        CALLPUTDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);
                        CALLPUTDesplazado += "</ATM>\n";
                        _Smile.Volas[row][2] -= 0.01;


                        //_SmileDesplazado = _Smile.DesplazamientoVolas(row, "put10");
                        _Smile.Volas[row][0] += 0.01;
                        CALLPUTDesplazado += "<PUT10 row='" + row + "' tenor='" + _Smile.Tenors[row] + "'>\n";
                        CALLPUTDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);
                        CALLPUTDesplazado += "</PUT10>\n";
                        _Smile.Volas[row][0] -= 0.01;

                        //_SmileDesplazado = _Smile.DesplazamientoVolas(row, "put25");
                        _Smile.Volas[row][1] += 0.01;
                        CALLPUTDesplazado += "<PUT25 row='" + row + "' tenor='" + _Smile.Tenors[row] + "'>\n";
                        CALLPUTDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);
                        CALLPUTDesplazado += "</PUT25>\n";
                        _Smile.Volas[row][1] -= 0.01;

                        //_SmileDesplazado = _Smile.DesplazamientoVolas(row, "call10");
                        _Smile.Volas[row][4] += 0.01;
                        CALLPUTDesplazado += "<CALL10 row='" + row + "' tenor='" + _Smile.Tenors[row] + "'>\n";
                        CALLPUTDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);
                        CALLPUTDesplazado += "</CALL10>\n";
                        _Smile.Volas[row][4] -= 0.01;

                        //_SmileDesplazado = _Smile.DesplazamientoVolas(row, "call25");
                        _Smile.Volas[row][3] += 0.01;
                        CALLPUTDesplazado += "<CALL25 row='" + row + "' tenor='" + _Smile.Tenors[row] + "'>\n";
                        CALLPUTDesplazado += Valorizar_TopologiaVega(BsSpot_BsFwd, DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);
                        CALLPUTDesplazado += "</CALL25>\n";
                        _Smile.Volas[row][3] -= 0.01;
                    }

                    CALLPUTDesplazado += "</CALLPUT>";
                }
                catch
                {
                    CALLPUTDesplazado = "<CALLPUT/>";
                }

                return CALLPUTDesplazado;
            }


            return "";


        }

        private static string Valorizar_TopologiaVega(string BsSpot_BsFwd, List<StructDetContrato> DetContratoList, List<StructFixingDataContrato> FijacionesList, AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile, YieldList CurvaList, enumSetPrincingLoading setPricing)
        {
            string MtMGriegasOpcion = "";

            for (int i = 0; i < DetContratoList.Count; i++)
            {
                if (DetContratoList[i].CodEstructura.Equals(8)) // || DetContratoList[i].CodEstructura.Equals(9))
                {
                    MtMGriegasOpcion += "<itemTopologiaVega  NumContrato='" + DetContratoList[i].NumContrato + "' NumEstructura='" + DetContratoList[i].NumEstructura + "' MTM='" + DetContratoList[i].MtM + "' />\n";
                }
                else if (DetContratoList[i].TipoPayOff.Equals("01"))//VANILLA                    
                {
                    string call_put_flag = DetContratoList[i].CallPut.Equals("Call") ? "c" : "p";
                    string conpraVenta = DetContratoList[i].CVOpc.Equals("C") ? "compra" : "venta";

                    Vanilla _Vanilla = new Vanilla(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, DetContratoList[i].PuntosFwd, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing);


                    double _MTM = _Vanilla.GetScaled_BSSpot_BSFwd_(BsSpot_BsFwd);

                    MtMGriegasOpcion += "<itemTopologiaVega  NumContrato='" + DetContratoList[i].NumContrato + "' NumEstructura='" + DetContratoList[i].NumEstructura + "' MTM='" + _MTM.ToString() + "' />\n";



                }
                else if (DetContratoList[i].TipoPayOff.Equals("02"))//Asiatica
                {
                    StructFixingDataContrato _FijacionesOpcion = new StructFixingDataContrato();
                    string call_put_flag = DetContratoList[i].CallPut.Equals("Call") ? "c" : "p";
                    string conpraVenta = DetContratoList[i].CVOpc.Equals("C") ? "compra" : "venta";

                    try
                    {
                        _FijacionesOpcion = FijacionesList.Where(x => x.NumContrato == DetContratoList[i].NumContrato && x.NucEstructura == DetContratoList[i].NumEstructura).ToList<StructFixingDataContrato>()[0];
                    }
                    catch
                    {
                        _FijacionesOpcion = null;
                    }

                    if (_FijacionesOpcion != null)
                    {

                        List<DateTime> fechas_fijacion = new List<DateTime>();
                        List<double> pesos_fijacion = new List<double>();
                        List<double> fijaciones = new List<double>();
                        List<double> volatilidades = new List<double>();
                        List<int> plazos = new List<int>();

                        Basis _Basis365;
                        int plazo;
                        int k = 0;


                        foreach (StructFixingData _fixing in _FijacionesOpcion.Fijaciones)
                        {
                            _Basis365 = new Basis(enumBasis.Basis_Act_365, DetContratoList[i].FechaInicioOpc, _fixing.Fecha);
                            plazo = (int)_Basis365.Term;
                            plazos.Add(plazo);
                            k++;
                        }

                        for (int j = 0; j < _FijacionesOpcion.Fijaciones.Count; j++)
                        {
                            fechas_fijacion.Add(_FijacionesOpcion.Fijaciones[j].Fecha);
                            pesos_fijacion.Add(_FijacionesOpcion.Fijaciones[j].Peso);
                            fijaciones.Add(_FijacionesOpcion.Fijaciones[j].Valor);
                            volatilidades.Add(_FijacionesOpcion.Fijaciones[j].Volatilidad);
                        }

                        double _MTM = 0.0;

                        if (DetContratoList[i].CodEstructura.Equals(13))
                        {
                            //Forward _Forward = new Forward(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos);
                            //_Forward.TipoCurva = "Y";
                            //_MTM = _Forward.GetScaledArithmetic_asian_fx_momentosEntradaSalida();
                            MtMGriegasOpcion += "<itemTopologiaVega  NumContrato='" + DetContratoList[i].NumContrato + "' NumEstructura='" + DetContratoList[i].NumEstructura + "' MTM='" + DetContratoList[i].MtM + "' />\n";
                        }
                        else
                        {
                            Asiatica _Asiatica = new Asiatica(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos);
                            _MTM = _Asiatica.GetScaledArithmetic_asian_fx_momentos();
                            MtMGriegasOpcion += "<itemTopologiaVega  NumContrato='" + DetContratoList[i].NumContrato + "' NumEstructura='" + DetContratoList[i].NumEstructura + "' MTM='" + _MTM.ToString() + "' />\n";
                        }

                        //MtMGriegasOpcion += "<itemTopologiaVega  NumContrato='" + DetContratoList[i].NumContrato + "' NumEstructura='" + DetContratoList[i].NumEstructura + "' MTM='" + _MTM.ToString() + "' />\n";
                    }
                }
            }

            //MtMGriegasOpcion += "</Data>\n";

            return MtMGriegasOpcion;


        }

        #region Sensibilidad

        public static string Sensibilidad(DateTime fechaValorizacion, List<StructDetContrato> DetContratoList, List<StructFixingDataContrato> FijacionesList, AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile, YieldList CurvaList, double MTM_Totalizador, enumSetPrincingLoading setPricing)
        {

            string _Sensibilidad = "";
            string _YieldName = "";
            List<string> _YieldList = new List<string>();

            _YieldList.Add("CurvaSwapCLP");
            _YieldList.Add("CurvaSwapUSDLocal");

            try
            {
                _Sensibilidad = "<Sensitivity>\n";

                MTM_Totalizador = Valorizar_Sensibilidad(DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);

                for (int _Yield = 0; _Yield < _YieldList.Count; _Yield++)
                {

                    _YieldName = _YieldList[_Yield];

                    _Sensibilidad += string.Format("\t<{0}>\n", _YieldName);
                    CurvaList.Read(_YieldName, enumSource.System, fechaValorizacion).RateType = enumRate.RateOriginalSpread;

                    for (int _Point = 0; _Point < CurvaList.Read(_YieldName, enumSource.System, fechaValorizacion).Count; _Point++)
                    {
                        YieldPoint _YieldPoint = CurvaList.Read(_YieldName, enumSource.System, fechaValorizacion).Point(_Point);
                        _YieldPoint.Spread = 0.01;
                        double _MtmSens = Valorizar_Sensibilidad(DetContratoList, FijacionesList, _Smile, CurvaList, setPricing);
			//alanrevisar viejo
			/*
                        _Sensibilidad += string.Format(
                                                        "\t\t<Value Tenor='{0}' MTM='{1}' MTMSens='{2}' Delta='{3}' />\n",
                                                        _YieldPoint.Term,
                                                        MTM_Totalizador,
                                                        _MtmSens,
                                                        _MtmSens - MTM_Totalizador
                                                      );
			*/
                        _Sensibilidad += string.Format(
                                                        "\t\t<Value Tenor='{0}' MTM='{1}' MTMSensitivity='{2}' Sensitivity='{3}' />\n",
                                                        _YieldPoint.Term,
                                                        MTM_Totalizador,
                                                        _MtmSens,
                                                        _MtmSens - MTM_Totalizador
                                                      );
                        _YieldPoint.Spread = 0.00;
                    }
                    _Sensibilidad += string.Format("\t</{0}>\n", _YieldName);
                }
                _Sensibilidad += "</Sensitivity>\n";
                CurvaList.Read(_YieldName, enumSource.System, fechaValorizacion).RateType = enumRate.RateOriginal;

            }
            catch
            {
                _Sensibilidad = "<Sensitivity/>";
            }

            #region Sensibilidad Forward Americano

            string _ForwardAmerican = "";
            string _Ticket = "";
            DateTime _ValuatorDate = new DateTime();
            double _Spot = 0;
            string _YieldDomestic = "";
            string _YieldForeign = "";
            string _Sensitivity = "";

            foreach (StructDetContrato _Contract in DetContratoList)
            {
                if (_Contract.CodEstructura.Equals(8)) //PRD_7274 ASVG_2111202 || _Contract.CodEstructura.Equals(9))
                {
                    _Ticket += string.Format(
                                             "\t\t<Ticket OperationNumber='{0}' StructureID='{1}' Notional='{2}' Strike='{3}' ExpiryDate='{4}' Position='{5}' " +
                                             "Exercize='{6}' Gennus='{7}' StructureType='{8}' MTM='{9}' />\n",
                                              _Contract.NumContrato,
                                              _Contract.NumEstructura,
                                              _Contract.MontoMon1,
                                              _Contract.Strike,
                                              _Contract.FechaVcto.ToString("dd/MM/yyyy"),
                                              _Contract.CVOpc,
                                              "A",
                                              _Contract.CallPut,
                                              _Contract.CodEstructura,
                                              0
                                            );
                    _ValuatorDate = _Contract.FechaInicioOpc;
                    _Spot = _Contract.SpotDet;
                    _YieldDomestic = _Contract.CurveMon1;
                    _YieldForeign = _Contract.CurveMon2;
                }
            }

            if (!_Ticket.Equals(""))
            {
                int _SetPrice = 0;
                if (setPricing == enumSetPrincingLoading.Costo)
                {
                    _SetPrice = 2;
                }
                _ForwardAmerican += "<Pricing>\n";
                _ForwardAmerican += "\t<Tickets>\n";
                _ForwardAmerican += _Ticket;
                _ForwardAmerican += "\t</Tickets>\n";
                _ForwardAmerican += string.Format(
                                                   "\t<Data SetPrice='{0}' ValuatorDate='{1}' IsGreek='Y' >\n",
                                                   _SetPrice,
                                                   _ValuatorDate.ToString("dd/MM/yyyy")
                                                 );

                _ForwardAmerican += string.Format("\t\t<Spot Value='{0}' />\n", _Spot);
                _ForwardAmerican += string.Format("\t\t<Yields Value='{0},{1}'>\n", _YieldDomestic, _YieldForeign);

                _ForwardAmerican += string.Format("\t\t\t<Foreign YieldName='{0}' Type='FOREIGN'>\n", _YieldForeign);
                _ForwardAmerican += "\t\t\t</Foreign>\n";

                _ForwardAmerican += string.Format("\t\t\t<Domestic YieldName='{0}' Type='DOMESTIC'>\n", _YieldDomestic);
                _ForwardAmerican += "\t\t\t</Domestic>\n";

                _ForwardAmerican += "\t\t</Yields>\n";
                _ForwardAmerican += "\t</Data>\n";
                _ForwardAmerican += "</Pricing>\n";


                _Sensitivity += ValuatorOptions.Sensivility(_ForwardAmerican, _Sensibilidad);
            }
            else
            {
                _Sensitivity = _Sensibilidad;
            }

            #endregion


            return _Sensitivity;
        }

        private static double Valorizar_Sensibilidad(List<StructDetContrato> DetContratoList, List<StructFixingDataContrato> FijacionesList, AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile, YieldList CurvaList, enumSetPrincingLoading setPricing)
        {
            double MtM = 0;

            for (int i = 0; i < DetContratoList.Count; i++)
            {
                string call_put_flag = DetContratoList[i].CallPut.Equals("Call") ? "c" : "p";
                string conpraVenta = DetContratoList[i].CVOpc.Equals("C") ? "compra" : "venta";

                if (DetContratoList[i].CodEstructura.Equals(8)) //PRD_7274 ASVG_2111202 || DetContratoList[i].CodEstructura.Equals(9))
                {
                }
                else if (DetContratoList[i].TipoPayOff.Equals("01"))//VANILLA
                {
                    Vanilla _Vanilla = new Vanilla(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, DetContratoList[i].PuntosFwd, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing);

                    MtM += _Vanilla.GetScaled_BSSpot_BSFwd_("BsSpot");
                }
                else if (DetContratoList[i].TipoPayOff.Equals("02"))//Asiatica
                {
                    StructFixingDataContrato _FijacionesOpcion = new StructFixingDataContrato();

                    try
                    {
                        _FijacionesOpcion = FijacionesList.Where(x => x.NumContrato == DetContratoList[i].NumContrato && x.NucEstructura == DetContratoList[i].NumEstructura).ToList<StructFixingDataContrato>()[0];
                    }
                    catch
                    {
                        _FijacionesOpcion = null;
                    }

                    if (_FijacionesOpcion != null)
                    {

                        List<DateTime> fechas_fijacion = new List<DateTime>();
                        List<double> pesos_fijacion = new List<double>();
                        List<double> fijaciones = new List<double>();
                        List<double> volatilidades = new List<double>();
                        List<int> plazos = new List<int>();

                        Basis _Basis365;
                        int plazo;
                        int k = 0;


                        //REVISAR
                        foreach (StructFixingData _fixing in _FijacionesOpcion.Fijaciones)
                        {
                            _Basis365 = new Basis(enumBasis.Basis_Act_365, DetContratoList[i].FechaInicioOpc, _fixing.Fecha);
                            plazo = (int)_Basis365.Term;
                            plazos.Add(plazo);
                            k++;
                        }

                        for (int j = 0; j < _FijacionesOpcion.Fijaciones.Count; j++)
                        {
                            fechas_fijacion.Add(_FijacionesOpcion.Fijaciones[j].Fecha);
                            pesos_fijacion.Add(_FijacionesOpcion.Fijaciones[j].Peso);
                            fijaciones.Add(_FijacionesOpcion.Fijaciones[j].Valor);
                            volatilidades.Add(_FijacionesOpcion.Fijaciones[j].Volatilidad);
                        }

                        if (DetContratoList[i].CodEstructura.Equals(13)) //PRD_12567 y PRD_17477
                        {
                            //ASVG Copy-Paste bestial
                            Forward _Forward = new Forward(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos);
                            
                            //es necesaria la suma?
                            MtM += _Forward.GetScaledPricingFxForwardGeneralModel();
                        }
                        else
                        {
                            Asiatica _Asiatica = new Asiatica(CurvaList, _Smile, DetContratoList[i].ParStrike, call_put_flag, conpraVenta, DetContratoList[i].MontoMon1, DetContratoList[i].SpotDet, DetContratoList[i].Strike, DetContratoList[i].FechaInicioOpc, DetContratoList[i].FechaVcto, _Smile.FechaSmile, DetContratoList[i].CurveMon1, DetContratoList[i].CurveMon2, setPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos);
                            MtM += _Asiatica.GetScaledArithmetic_asian_fx_momentos();
                        }
                    }
                }
            }

            return MtM;

        }

        #endregion

    }
}
