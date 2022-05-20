using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using cFinancialTools.DayCounters;
using cFinancialTools.Yield;

namespace AdminOpcionesTool.Opciones.Payoffs.Estructuras
{
    public class Estructura
    {
        #region Variables de Clase Estructura
        public string estrategia_estruct { get; set; }
        public string payoff { get; set; }
        public DateTime fecha_Valoracion { get; set; }
        public DateTime fecha_Vencimiento { get; set; }
        public double nominal { get; set; }

        //public double delta_obetivo { get; set; }
        public string compra_venta { get; set; }
        public double spot { get; set; }
        public double puntos_fwd_costo { get; set; }
        public string paridad { get; set; }
        public string YieldNameCurvaDom { get; set; }
        public string YieldNameCurvaFor { get; set; }
        public string formaPagoMon1 { get; set; }
        public string formapagoMon2 { get; set; }
        public int codigoMon1 { get; set; }
        public int codigoMon2 { get; set; }
        public double MontoMon1 { get; set; }
        public double MontoMon2 { get; set; }
        //public double Strike_fwd { get; set; }

        //volres "strikes" o "derlta" indicando si los valores vienen dados por los strikes o por los delta
        public string Strikes_Delta_flag;
        public double strike1 { get; set; }
        public double strike2 { get; set; }
        public double strike3 { get; set; }
        public double strike4 { get; set; } //PRD_20559

        public double delta1 { get; set; }
        public double delta2 { get; set; }
        public double delta3 { get; set; }
        private bool EstructuraCompuesta = false; // true cuando la opcion esta compuesta de otras estructuras

        public string TablaFijacion { get; set; }// Solo para Asiatica, puede ser "" para Vanila

        //PRD_7274
        public string __xmlStrip { get; set; }

        public DateTime fecha_inicio_fijacion { get; set; }
        public DateTime fecha_fin_fijacion { get; set; }

        private List<DateTime> fechaFixingList;
        private List<double> valorFixingList;
        private List<double> pesosFixingList;
        private List<double> volatilidadFixingList;
        private List<int> plazos_fijaciones;

        private Basis _Basis365;

        private enumSetPrincingLoading SetPrecios;

        public YieldList mYieldList;

        public int plazo { get; set; }

        AdminOpcionesTool.Opciones.SmileNameSpace.Smile Smile;
        #endregion Variables de Clase Estructura

        //estas no deberían ser variables de Clase...
        AdminOpcionesTool.Opciones.Payoffs.Asiatica Asiatica;
        AdminOpcionesTool.Opciones.Payoffs.Vanilla Vanilla;
        AdminOpcionesTool.Opciones.Payoffs.Forward Forward;

        public DateTime FechaSetDePrecios;

        public Estructura(YieldList CurvaList, AdminOpcionesTool.Opciones.SmileNameSpace.Smile smile, string Strikes_Delta_flag, string TablaFijacion, string estrategia_estruct, string payoff, DateTime fecha_Valoracion, DateTime _fecha_Vencimiento ,DateTime fechaSetDePrecios, string paridad, double nominal, string Strike_Delta_Values_XML, string compra_venta, double spot, double puntos_fwd_costo, string YieldNameCurvaDom, string YieldNameCurvaFor, enumSetPrincingLoading setPrecios)
        {
            this.FechaSetDePrecios = fechaSetDePrecios;
            this.Smile = smile;
            this.SetPrecios = setPrecios;
            this.mYieldList = CurvaList;
            this.Strikes_Delta_flag = Strikes_Delta_flag;
            List<double> Strike_List_Delta;

            Strike_List_Delta = ParseStrikesDelta(Strikes_Delta_flag, Strike_Delta_Values_XML);

            SetStrikesDelta(Strikes_Delta_flag, Strike_List_Delta);

            this.TablaFijacion = TablaFijacion;
            this.estrategia_estruct = estrategia_estruct;
            this.payoff = payoff;
            this.fecha_Valoracion = fecha_Valoracion;
            this.fecha_Vencimiento = _fecha_Vencimiento;
            this.paridad = paridad;
            this.nominal = nominal;
            //this.strike = strike;
            //this.delta_obetivo = delta_obetivo;
            this.compra_venta = compra_venta;
            this.spot = spot;
            this.puntos_fwd_costo = puntos_fwd_costo;
            this.YieldNameCurvaDom = YieldNameCurvaDom;
            this.YieldNameCurvaFor = YieldNameCurvaFor;
            //this.Strike_fwd = spot + puntos_fwd_costo;

            //Smile = new Turing2009Tools.Opciones.SmileNameSpace.Smile(fecha_Valoracion, paridad, spot, YieldNameCurvaDom, YieldNameCurvaFor, 0);

            _Basis365 = new Basis(enumBasis.Basis_Act_365, fecha_Valoracion, fecha_Vencimiento);

            if (TablaFijacion != "")
            {
                List<StructFixingData> fixingdataList = ParseTablaFijacion(TablaFijacion);

                fechaFixingList = new List<DateTime>();
                valorFixingList = new List<double>();
                pesosFixingList = new List<double>();
                volatilidadFixingList = new List<double>();
                plazos_fijaciones = new List<int>();

                for (int i = 0; i < fixingdataList.Count; i++)
                {
                    fechaFixingList.Add(fixingdataList[i].Fecha);
                    valorFixingList.Add(fixingdataList[i].Valor);
                    pesosFixingList.Add(fixingdataList[i].Peso);
                    volatilidadFixingList.Add(fixingdataList[i].Volatilidad);
                    plazos_fijaciones.Add(fixingdataList[i].Plazo);
                }
            }
        }

        public Estructura(YieldList CurvaList, string Strikes_Delta_flag, string TablaFijacion, string estrategia_estruct, string payoff, DateTime fecha_Valoracion, DateTime _fecha_Vencimiento, DateTime fechaSetDePrecios, string paridad, double nominal, string Strike_Delta_Values_XML, string compra_venta, double spot, double spotsmile, double puntos_fwd_costo, string YieldNameCurvaDom, string YieldNameCurvaFor, enumSetPrincingLoading setPrecios)
        {
            this.FechaSetDePrecios = fechaSetDePrecios;
            this.SetPrecios = setPrecios;
            this.mYieldList = CurvaList;
            this.Strikes_Delta_flag = Strikes_Delta_flag;
            List<double> Strike_List_Delta;

            Strike_List_Delta = ParseStrikesDelta(Strikes_Delta_flag, Strike_Delta_Values_XML);

            SetStrikesDelta(Strikes_Delta_flag, Strike_List_Delta);

            this.TablaFijacion = TablaFijacion;
            this.estrategia_estruct = estrategia_estruct;
            this.payoff = payoff;
            this.fecha_Valoracion = fecha_Valoracion;
            this.fecha_Vencimiento = _fecha_Vencimiento;
            this.paridad = paridad;
            this.nominal = nominal;
            //this.strike = strike;
            //this.delta_obetivo = delta_obetivo;
            this.compra_venta = compra_venta;
            this.spot = spot;
            this.puntos_fwd_costo = puntos_fwd_costo;
            this.YieldNameCurvaDom = YieldNameCurvaDom;
            this.YieldNameCurvaFor = YieldNameCurvaFor;
            //this.Strike_fwd = spot + puntos_fwd_costo;

            _Basis365 = new Basis(enumBasis.Basis_Act_365, fecha_Valoracion, fecha_Vencimiento);

            Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, paridad, spotsmile, YieldNameCurvaDom, YieldNameCurvaFor, 0);
            Smile.Load(setPrecios);

            if (TablaFijacion != "")
            {
                List<StructFixingData> fixingdataList = ParseTablaFijacion(TablaFijacion);

                fechaFixingList = new List<DateTime>();
                valorFixingList = new List<double>();
                pesosFixingList = new List<double>();
                volatilidadFixingList = new List<double>();
                plazos_fijaciones = new List<int>();

                for (int i = 0; i < fixingdataList.Count; i++)
                {
                    fechaFixingList.Add(fixingdataList[i].Fecha);
                    valorFixingList.Add(fixingdataList[i].Valor);
                    pesosFixingList.Add(fixingdataList[i].Peso);
                    volatilidadFixingList.Add(fixingdataList[i].Volatilidad);
                    plazos_fijaciones.Add(fixingdataList[i].Plazo);
                }
            }
        }

        //PRD7274 ASVG Para saber cuantas componentes tiene el Strip
        public Estructura(YieldList CurvaList, string Strikes_Delta_flag, string TablaFijacion, string estrategia_estruct, string payoff, DateTime fecha_Valoracion, DateTime _fecha_Vencimiento, DateTime fechaSetDePrecios, string paridad, double nominal, string Strike_Delta_Values_XML, string compra_venta, double spot, double spotsmile, double puntos_fwd_costo, string YieldNameCurvaDom, string YieldNameCurvaFor, enumSetPrincingLoading setPrecios, string xmlStrip)
        {
            this.FechaSetDePrecios = fechaSetDePrecios;
            this.SetPrecios = setPrecios;
            this.mYieldList = CurvaList;
            this.Strikes_Delta_flag = Strikes_Delta_flag;
            List<double> Strike_List_Delta;

            Strike_List_Delta = ParseStrikesDelta(Strikes_Delta_flag, Strike_Delta_Values_XML);

            SetStrikesDelta(Strikes_Delta_flag, Strike_List_Delta);

            this.TablaFijacion = TablaFijacion;
            this.estrategia_estruct = estrategia_estruct;
            this.payoff = payoff;
            this.fecha_Valoracion = fecha_Valoracion;
            this.fecha_Vencimiento = _fecha_Vencimiento;
            this.paridad = paridad;
            this.nominal = nominal;
            //this.strike = strike;
            //this.delta_obetivo = delta_obetivo;
            this.compra_venta = compra_venta;
            this.spot = spot;
            this.puntos_fwd_costo = puntos_fwd_costo;
            this.YieldNameCurvaDom = YieldNameCurvaDom;
            this.YieldNameCurvaFor = YieldNameCurvaFor;
            //this.Strike_fwd = spot + puntos_fwd_costo;

            this.__xmlStrip = xmlStrip;

            _Basis365 = new Basis(enumBasis.Basis_Act_365, fecha_Valoracion, fecha_Vencimiento);

            Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, paridad, spotsmile, YieldNameCurvaDom, YieldNameCurvaFor, 0);
            Smile.Load(setPrecios);

            if (TablaFijacion != "")
            {
                List<StructFixingData> fixingdataList = ParseTablaFijacion(TablaFijacion);

                fechaFixingList = new List<DateTime>();
                valorFixingList = new List<double>();
                pesosFixingList = new List<double>();
                volatilidadFixingList = new List<double>();
                plazos_fijaciones = new List<int>();

                for (int i = 0; i < fixingdataList.Count; i++)
                {
                    fechaFixingList.Add(fixingdataList[i].Fecha);
                    valorFixingList.Add(fixingdataList[i].Valor);
                    pesosFixingList.Add(fixingdataList[i].Peso);
                    volatilidadFixingList.Add(fixingdataList[i].Volatilidad);
                    plazos_fijaciones.Add(fixingdataList[i].Plazo);
                }
            }
        }

        /// <summary>
        /// Genera lista con los precios de la estructura en Strikes o Deltas.
        /// </summary>
        /// <param name="Strikes_Delta_flag">Flag indicando si precios son "strikes" o no.</param>
        /// <param name="Strike_Delta_Values_XML">XML con datos de Strikes o Deltas.</param>
        /// <returns></returns>
        private static List<double> ParseStrikesDelta(string Strikes_Delta_flag, string Strike_Delta_Values_XML)
        {
            List<double> Strike_List_Delta;
            XDocument xdoc_Strikes_Delta = new XDocument(XDocument.Parse(Strike_Delta_Values_XML));

            if (Strikes_Delta_flag == "strikes")
            {
                var Strikes_list_var = from itemStrike in xdoc_Strikes_Delta.Descendants("Strike")
                                       select double.Parse(itemStrike.Attribute("Valor").Value.ToString());

                Strike_List_Delta = new List<double>(Strikes_list_var.ToList<double>());
            }
            else //"delta"
            {
                var Delta_var = from itemDelta in xdoc_Strikes_Delta.Descendants("Delta")
                                select double.Parse(itemDelta.Attribute("Valor").Value.ToString());

                Strike_List_Delta = new List<double>(Delta_var.ToList<double>());
            }
            return Strike_List_Delta;
        }

        /// <summary>
        /// Setea los campos de strike o delta para la estructura.
        /// </summary>
        /// <param name="Strikes_Delta_flag">Flag indicando si precios son "strikes" o no.</param>
        /// <param name="Strike_List_Delta"></param>
        private void SetStrikesDelta(string Strikes_Delta_flag, List<double> Strike_List_Delta)
        {
            if (Strikes_Delta_flag == "strikes")
            {
                switch (Strike_List_Delta.Count)
                {
                    case 1:
                        strike1 = Strike_List_Delta[0];
                        break;
                    case 2:
                        strike1 = Strike_List_Delta[0];
                        strike2 = Strike_List_Delta[1];
                        break;
                    case 3:
                        strike1 = Strike_List_Delta[0];
                        strike2 = Strike_List_Delta[1];
                        strike3 = Strike_List_Delta[2];
                        break;
                    case 4:
                        strike1 = Strike_List_Delta[0];
                        strike2 = Strike_List_Delta[1];
                        strike3 = Strike_List_Delta[2];
                        strike4 = Strike_List_Delta[3];
                        break;
                }
            }
            else //Strikes_Delta_flag == "delta"
            {
                switch (Strike_List_Delta.Count)
                {
                    case 1:
                        delta1 = Strike_List_Delta[0];
                        break;
                    case 2:
                        delta1 = Strike_List_Delta[0];
                        delta2 = Strike_List_Delta[1];
                        break;
                    case 3:
                        delta1 = Strike_List_Delta[0];
                        delta2 = Strike_List_Delta[1];
                        delta3 = Strike_List_Delta[2];
                        break;
                }
            }
        }

        /// <summary>
        /// Genera lista con elementos para StructFixingData.
        /// </summary>
        /// <param name="TablaFijacion">XML con tabla de fijación.</param>
        /// <returns></returns>
        private static List<StructFixingData> ParseTablaFijacion(string TablaFijacion)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(TablaFijacion));

            var elements = from elementItem in xdoc.Descendants("FixingValues")
                           select new StructFixingData
                           {
                               Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                               Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                               Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                               Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                               Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())

                           };

            List<StructFixingData> fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());
            return fixingdataList;
        }

        /// <summary>
        /// Retorna XML con conjunto de <Opcion> que forman la estructura.
        /// </summary>
        /// <param name="vanilla_asiatica"></param>
        /// <param name="BsSpot_BsFwd"></param>
        /// <returns></returns>
        public string ForwardSintetico(string vanilla_asiatica, string BsSpot_BsFwd)
        {
            //double spot_mas_puntos = spotFwd + puntosFwd;
            double strike_fwd = this.strike1;

            string returnValue = "";
            string compra_venta2 = compra_venta == "compra" ? "venta" : "compra";
            try
            {
                //no se utiliza ninguno de los tres strikes ni deltas, sino que el strike es la suma del spot mas los puntos
                if (Strikes_Delta_flag == "strikes" || Strikes_Delta_flag == "delta")
                {
                    if (vanilla_asiatica == "Vanilla")
                    {

                        if (Smile.Volas.Count == 0)
                        {
                            return "<Data/>";
                        }
                        Vanilla = new Vanilla(this.mYieldList, this.Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                        Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, puntos_fwd_costo, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                        returnValue = "<Data>\n";

                        returnValue += ValueOpc1 + "\n" + ValueOpc2;
                        returnValue += "</Data>";

                    }
                    else if (vanilla_asiatica == "Asiaticas")
                    {
                        if (Smile.Volas.Count == 0)
                        {
                            return "<Data/>";
                        }

                        Asiatica = new Asiatica(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, strike_fwd, fecha_Valoracion, fecha_Vencimiento,this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios, fechaFixingList, pesosFixingList, valorFixingList, volatilidadFixingList, plazos_fijaciones);

                        string ValueOpc1 = Asiatica.Opcion(1, "Estructura");

                        Asiatica = new Asiatica(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, strike_fwd, fecha_Valoracion, fecha_Vencimiento,this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios, fechaFixingList, pesosFixingList, valorFixingList, volatilidadFixingList, plazos_fijaciones);

                        string ValueOpc2 = Asiatica.Opcion(2, "Estructura");

                        returnValue = "<Data>\n";
                        returnValue += ValueOpc1 + "\n" + ValueOpc2;
                        returnValue += "</Data>";

                    }
                }

            }
            catch { };

            return returnValue;

        }

        //PRD_12567
        /// <summary>
        /// Genera XML con estructura de ForwardAsiaticoEntradaSalida
        /// Esta función debe ser re-implementada completamente, migrando de Opción Asiática a Forward.
        /// Tiene un parámetro menos.
        /// </summary>
        /// <param name="vanilla_asiatica"></param>
        /// <param name="BsSpot_BsFwd"></param>
        /// <returns></returns>
        public string ForwardAsiaticoEntradaSalida(string vanilla_asiatica, string BsSpot_BsFwd)
        {
            //double spot_mas_puntos = spotFwd + puntosFwd;
            double strike_fwd = this.strike1;

            string returnValue = "";
            string compra_venta2 = compra_venta == "compra" ? "venta" : "compra";
            try
            {
                //no se utiliza ninguno de los tres strikes ni deltas, sino que el strike es la suma del spot mas los puntos
                if (Strikes_Delta_flag == "strikes" || Strikes_Delta_flag == "delta")
                {
                    //si es vanilla retornamos nada "<Data>\n</Data>".
                    #region if Vanilla
                    if (vanilla_asiatica == "Vanilla")
                    {
                        //if (Smile.Volas.Count == 0)
                        //{
                        //    return "<Data/>";
                        //}

                        //Vanilla = new Vanilla(this.mYieldList, this.Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        //string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                        //Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, puntos_fwd_costo, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        //string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                        returnValue = "<Data>\n";

                        //returnValue += ValueOpc1 + "\n" + ValueOpc2;
                        returnValue += "</Data>";
                    }
                    #endregion if Vanilla
                    #region if Asiaticas
                    else if (vanilla_asiatica == "Asiaticas")
                    {
                        if (Smile.Volas.Count == 0)
                        {
                            return "<Data/>";
                        }
                        if (compra_venta == "compra")
                        {

                            Forward = new Forward(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios, fechaFixingList, pesosFixingList, valorFixingList, volatilidadFixingList, plazos_fijaciones);

                            string ValueOpc1 = Forward.ForwardAsiaticoEntradaSalida(1, "Individual");

                            returnValue = "<Data>\n";
                            returnValue += ValueOpc1;
                            returnValue += "</Data>";
                        }
                        else if (compra_venta == "venta")
                        {
                            Forward = new Forward(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios, fechaFixingList, pesosFixingList, valorFixingList, volatilidadFixingList, plazos_fijaciones);

                            string ValueOpc2 = Forward.ForwardAsiaticoEntradaSalida(1, "Individual");
                            returnValue = "<Data>\n";
                            returnValue += ValueOpc2;
                            returnValue += "</Data>";
                        }
                    }
                    #endregion if Asiaticas
                }
            }
            catch { };

            return returnValue;
        }

        public string Straddle(string vanilla_asiatica, string BsSpot_BsFwd)
        {

            string returnValue = "";
            int numComponentestructura1, numComponentestructura2;
            try
            {
                double Srtike_1 = 0, Srtike_2 = 0;

                if (EstructuraCompuesta)
                {
                    // butterfly almacena el strike de Straddle en strike3 y es el mismo para Strike_1 y Strike_2
                    Srtike_1 = strike3;
                    Srtike_2 = strike3;
                    numComponentestructura1 = 3;
                    numComponentestructura2 = 4;
                    compra_venta = compra_venta.Equals("compra") ? "venta" : "compra";

                }
                else
                {
                    numComponentestructura1 = 1;
                    numComponentestructura2 = 2;

                    if (this.Strikes_Delta_flag == "delta")
                    {
                        Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        if (Smile.Volas.Count == 0)
                        {
                            return "<Data/>";
                        }

                        Srtike_1 = Vanilla.find_atm_strike(delta1, 0);
                        Srtike_1 = Math.Round(Srtike_1, 2);
                        Srtike_2 = Srtike_1;
                    }
                    else
                    {
                        if (this.strike1 != double.NaN)
                        {
                            Srtike_1 = strike1;
                            Srtike_2 = strike1;
                        }

                    }
                }


                if (vanilla_asiatica == "Vanilla")
                {

                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, Srtike_1, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc1 = Vanilla.Opcion(numComponentestructura1, "Estructura", BsSpot_BsFwd);

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, puntos_fwd_costo, Srtike_2, fecha_Valoracion, fecha_Vencimiento,this.FechaSetDePrecios ,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc2 = Vanilla.Opcion(numComponentestructura2, "Estructura", BsSpot_BsFwd);

                    returnValue = "<Data>\n";

                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</Data>";
                }

            }
            catch { };

            return returnValue;

        }

        public string Strangle(string vanilla_asiatica, string BsSpot_BsFwd)
        {

            string returnValue = "";


            double Srtike_Call = 0, strike_Put = 0;

            if (EstructuraCompuesta)
            {
                // butterfly almacena el strike de limite superior en strike1 y el strike de limite inferior en strike2.
                Srtike_Call = strike1;
                strike_Put = strike2;
            }
            else
            {

                if (this.Strikes_Delta_flag == "delta")
                {
                    //Smile.Smile _Smile_Aux = new Turing2009Tool.Opciones.Smile.Smile();

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento,this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    Srtike_Call = Vanilla.find_strike_fwd(delta1);
                    Srtike_Call = Math.Round(Srtike_Call, 2);

                    //_Smile_Aux.Load(paridad, "p", compra_venta, nominal, spot, 1, fecha_Valoracion, YieldNameCurvaDom, YieldNameCurvaFor, 0);
                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    strike_Put = Vanilla.find_strike_fwd(delta1);
                    strike_Put = Math.Round(strike_Put, 2);

                }
                else
                {
                    //this.Strikes_Delta_flag == "strikes"

                    if (this.strike1 != double.NaN && this.strike2 != double.NaN)
                    {
                        Srtike_Call = strike1;
                        strike_Put = strike2;
                    }

                }
            }


            try
            {
                if (vanilla_asiatica == "Vanilla")
                {


                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, Srtike_Call, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios ,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, puntos_fwd_costo, strike_Put, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                    returnValue = "<Data>\n";

                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</Data>";
                }


            }
            catch { };

            return returnValue;

        }

        public double find_strikeCeiling_RiskReversal(double price_objective, string BsSpot_BsFwd)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted, _price_put;
            Vanilla _Vanilla_call, _Vanilla_put;
            string compra_venta2;
            int _compra_venta_flag;

            //Constantes
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;

            compra_venta2 = compra_venta == "compra" ? "venta" : "compra";

            _Vanilla_call = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, 1.0, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            _Vanilla_put = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, 1.0, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                _price_put = _Vanilla_put.BS_Spot();
            }
            else
            {
                _price_put = _Vanilla_put.BS_fwd(spot + puntos_fwd_costo);
            }

            //Calculo
            _X = _Vanilla_call.find_strike_price(_price_adjusted + _price_put, _dK, BsSpot_BsFwd);
            //_X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public double find_strikeFloor_RiskReversal(double price_objective, string BsSpot_BsFwd)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted, _price_call;
            Vanilla _Vanilla_call, _Vanilla_put;
            string compra_venta2;
            int _compra_venta_flag;

            //Constantes
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;

            compra_venta2 = compra_venta == "compra" ? "venta" : "compra";

            _Vanilla_call = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, 1.0, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento,FechaSetDePrecios,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            _Vanilla_put = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, 1.0, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                _price_call = _Vanilla_call.BS_Spot();
            }
            else
            {
                _price_call = _Vanilla_call.BS_fwd(spot + puntos_fwd_costo);
            }



            //Calculo
            _X = _Vanilla_put.find_strike_price(_price_call - _price_adjusted, _dK, BsSpot_BsFwd);
            //_X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public string RiskReversal(string vanilla_asiatica, string BsSpot_BsFwd)
        {

            string returnValue = "";

            string compra_venta2 = compra_venta == "compra" ? "venta" : "compra";

            double Srtike_Call = 0, strike_Put = 0;



            if (this.Strikes_Delta_flag == "delta")
            {

                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios , YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                if (Smile.Volas.Count == 0)
                {
                    return "<Data/>";
                }

                Srtike_Call = Vanilla.find_strike_fwd(delta1);
                Srtike_Call = Math.Round(Srtike_Call, 2);
                this.strike1 = Srtike_Call;

                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento,FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                strike_Put = Vanilla.find_strike_fwd(delta1);
                strike_Put = Math.Round(strike_Put, 2);
                this.strike2 = strike_Put;

            }
            else
            {
                //this.Strikes_Delta_flag == "strikes"

                if (this.strike1 != double.NaN && this.strike2 != double.NaN)
                {
                    Srtike_Call = strike1;
                    strike_Put = strike2;
                }

            }


            try
            {
                if (vanilla_asiatica == "Vanilla")
                {

                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, Srtike_Call, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios,YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, puntos_fwd_costo, strike_Put, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                    returnValue = "<Data>\n";
                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</Data>";
                }
            }
            catch { };

            return returnValue;

        }

        // PRD Call/Put Spread
        public string CallPutSpread(string vanilla_asiatica, string BsSpot_BsFwd, string Estructura)
        {
            string returnValue = "";
            string TipoEstructura = "";
            string compra_venta2 = compra_venta == "compra" ? "venta" : "compra";
            double Srtike_1 = 0, strike_2 = 0;

            if (this.Strikes_Delta_flag == "delta")
            {
                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                if (Smile.Volas.Count == 0)
                {
                    return "<Data/>";
                }

                Srtike_1 = Vanilla.find_strike_fwd(delta1);
                Srtike_1 = Math.Round(Srtike_1, 2);
                this.strike1 = Srtike_1;

                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                strike_2 = Vanilla.find_strike_fwd(delta1);
                strike_2 = Math.Round(strike_2, 2);
                this.strike2 = strike_2;
            }
            else
            {
                //this.Strikes_Delta_flag == "strikes"
                if (this.strike1 != double.NaN && this.strike2 != double.NaN)
                {
                    Srtike_1 = strike1;
                    strike_2 = strike2;
                }
            }

            try
            {
                if (vanilla_asiatica == "Vanilla")
                {
                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    //La estructura se pasa para poder generar 
                    //componentes Call Call o Put Put de C y V 
                    if (Estructura == "11")
                    {
                        TipoEstructura = "c";
                    }
                    else
                    {
                        TipoEstructura = "p";
                    }

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, TipoEstructura, "compra", nominal, spot, puntos_fwd_costo, Srtike_1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, TipoEstructura, "venta", nominal, spot, puntos_fwd_costo, strike_2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                    returnValue = "<Data>\n";
                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</Data>";
                }
            }
            catch { };

            return returnValue;
        }

        /// <summary>
        /// Genera XML con estructura CallSpreadDoble (PRD_20559)
        /// Solamente se implementa "Venta de Call", no hay combinaciones posibles.
        /// La estructura resultante es:
        /// Venta Call (Componente 1, Strike1)
        /// Compra Call (Componente 2, Strike2)
        /// Compra Call (Componente 3, Strike3)
        /// Venta Call (Componente 4, Strike4)
        /// </summary>
        public string CallSpreadDoble(string BsSpot_BsFwd)
        {
            string returnValue = "";
            double srtike_1 = 0, strike_2 = 0, strike_3 = 0, strike_4 = 0;

            if (this.Strikes_Delta_flag == "delta")
            {               
                //No se implementa valorización por Deltas.
                //La pantalla debería controlar esto...
                return "<Data/>";
            }
            else
            {
                //this.Strikes_Delta_flag == "strikes"
                if (this.strike1 != double.NaN && this.strike2 != double.NaN && this.strike3 != double.NaN && this.strike4 != double.NaN)
                {
                    srtike_1 = strike1;
                    strike_2 = strike2;
                    strike_3 = strike3;
                    strike_4 = strike4;
                }
            }

            //Generación de la estructura
            try
            {
                if (Smile.Volas.Count == 0)
                {
                    return "<Data/>";
                }

                // Venta Call (Componente 1, Strike1)
                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", "venta", nominal, spot, puntos_fwd_costo, srtike_1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
                string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                // Compra Call (Componente 2, Strike2)
                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", "compra", nominal, spot, puntos_fwd_costo, strike_2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
                string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                // Compra Call (Componente 3, Strike3)
                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", "compra", nominal, spot, puntos_fwd_costo, strike_3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
                string ValueOpc3 = Vanilla.Opcion(3, "Estructura", BsSpot_BsFwd);

                // Venta Call (Componente 4, Strike4)
                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", "venta", nominal, spot, puntos_fwd_costo, strike_4, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
                string ValueOpc4 = Vanilla.Opcion(4, "Estructura", BsSpot_BsFwd);

                returnValue = "<Data>\n";
                returnValue += ValueOpc1 + "\n" + ValueOpc2 + "\n" + ValueOpc3 + "\n" + ValueOpc4;
                returnValue += "</Data>";
            }
            catch { };

            return returnValue;
        }

        public double find_strikeCeiling_CallPutSpread(double price_objective, string BsSpot_BsFwd, string Estructura)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted, _price_put;
            Vanilla _Vanilla_call, _Vanilla_put;
            string compra_venta2;
            int _compra_venta_flag;
            string TipoEstructura = "";

            //Constantes
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;

            compra_venta2 = compra_venta == "compra" ? "venta" : "compra";

            //La estructura se pasa para poder generar 
            //componentes Call Call o Put Put de C y V 
            if (Estructura == "11")
            {
                TipoEstructura = "c";
            }
            else
            {
                TipoEstructura = "p";
            }


            _Vanilla_call = new Vanilla(this.mYieldList, Smile, paridad, TipoEstructura, compra_venta, 1.0, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            _Vanilla_put = new Vanilla(this.mYieldList, Smile, paridad, TipoEstructura, compra_venta2, 1.0, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                _price_put = _Vanilla_put.BS_Spot();
            }
            else
            {
                _price_put = _Vanilla_put.BS_fwd(spot + puntos_fwd_costo);
            }

            //Calculo
            _X = _Vanilla_call.find_strike_price(_price_adjusted + _price_put, _dK, BsSpot_BsFwd);
            //_X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public double find_strikeFloor_CallPutSpread(double price_objective, string BsSpot_BsFwd, string Estructura)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted, _price_call;
            Vanilla _Vanilla_call, _Vanilla_put;
            string compra_venta2;
            int _compra_venta_flag;
            string TipoEstructura = "";

            //Constantes
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;

            compra_venta2 = compra_venta == "compra" ? "venta" : "compra";

            //La estructura se pasa para poder generar 
            //componentes Call Call o Put Put de C y V 
            if (Estructura == "11")
            {
                TipoEstructura = "c";
            }
            else
            {
                TipoEstructura = "p";
            }

            _Vanilla_call = new Vanilla(this.mYieldList, Smile, paridad, TipoEstructura, compra_venta, 1.0, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            _Vanilla_put = new Vanilla(this.mYieldList, Smile, paridad, TipoEstructura, compra_venta2, 1.0, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                _price_call = _Vanilla_call.BS_Spot();
            }
            else
            {
                _price_call = _Vanilla_call.BS_fwd(spot + puntos_fwd_costo);
            }



            //Calculo
            _X = _Vanilla_put.find_strike_price(_price_call - _price_adjusted, _dK, BsSpot_BsFwd);
            //_X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public double find_strike_CallSpreadDoble(double price_objective, string BsSpot_BsFwd, string Estructura, string TargetStrike)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted, _price_1, _price_2, _price_3, _price_4, _price_solver;
            
            int _compra_venta_flag;
            

            //Constantes
            //OK
            _N = this.nominal;
            //OK
            _dK = 1e-6 / Math.Max(_N, 1);
            //OK
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            //OK
            //_price_adjusted = price_objective / _N * _compra_venta_flag;
            _price_adjusted = price_objective / _N;

            //Venta Call PRD_20559
            Vanilla _Vanilla_1 = new Vanilla(this.mYieldList, Smile, paridad, "c", "venta", 1.0, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            //Compra Call PRD_20559
            Vanilla _Vanilla_2 = new Vanilla(this.mYieldList, Smile, paridad, "c", "compra", 1.0, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            //Compra Call PRD_20559
            Vanilla _Vanilla_3 = new Vanilla(this.mYieldList, Smile, paridad, "c", "compra", 1.0, spot, puntos_fwd_costo, strike3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            //Venta Call PRD_20559
            Vanilla _Vanilla_4 = new Vanilla(this.mYieldList, Smile, paridad, "c", "venta", 1.0, spot, puntos_fwd_costo, strike4, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                _price_1 = _Vanilla_1.BS_Spot();
                _price_2 = _Vanilla_2.BS_Spot();
                _price_3 = _Vanilla_3.BS_Spot();
                _price_4 = _Vanilla_4.BS_Spot();
            }
            else
            {
                _price_1 = _Vanilla_1.BS_fwd(spot + puntos_fwd_costo);
                _price_2 = _Vanilla_2.BS_fwd(spot + puntos_fwd_costo);
                _price_3 = _Vanilla_3.BS_fwd(spot + puntos_fwd_costo);
                _price_4 = _Vanilla_4.BS_fwd(spot + puntos_fwd_costo);
            }

            //Normalizar precios
            _price_1 = _price_1 * (_Vanilla_1.Compra_Venta.Equals("compra") ? 1 : -1);
            _price_2 = _price_2 * (_Vanilla_2.Compra_Venta.Equals("compra") ? 1 : -1);
            _price_3 = _price_3 * (_Vanilla_3.Compra_Venta.Equals("compra") ? 1 : -1);
            _price_4 = _price_4 * (_Vanilla_4.Compra_Venta.Equals("compra") ? 1 : -1);

            //confirmar signo del _price_adjusted, al parecer, siempre positivo.
            switch (TargetStrike)
            {
                case "Strike1":
                    //Calculo
                    _price_solver = _price_adjusted - (_price_2 + _price_3 + _price_4);
                    _X = _Vanilla_1.find_strike_price_CallPut(_price_solver, BsSpot_BsFwd);
                    //_X = Math.Round(_X, 2);
                    break;
                case "Strike2":
                    _price_solver = _price_adjusted - (_price_1 + _price_3 + _price_4);
                    _X = _Vanilla_2.find_strike_price_CallPut(_price_solver, BsSpot_BsFwd);
                    break;
                case "Strike3":
                    _price_solver = _price_adjusted - (_price_1 + _price_2 + _price_4);
                    _X = _Vanilla_3.find_strike_price_CallPut(_price_solver, BsSpot_BsFwd);
                    break;
                case "Strike4":
                    _price_solver = _price_adjusted - (_price_1 + _price_2 + _price_3);
                    _X = _Vanilla_4.find_strike_price_CallPut(_price_solver, BsSpot_BsFwd);
                    break;
                default:
                    _X = double.NaN;
                    break;
            }
            //Retorno
            return _X;
        }

        public double find_strikeFloor_Butterfly(double price_objective)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted;
            Vanilla _call_Strangle, _put_Strangle, _call_Straddle, _put_Straddle;
            string compra_venta_Straddle;
            double _price_call_Straddle, _price_put_Straddle, _price_call_Strangle;
            int _compra_venta_flag;

            //Constantes            
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;
            compra_venta_Straddle = compra_venta.Equals("compra") ? "venta" : "compra";

            //Vanilla Strangle
            _call_Strangle = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento,FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
            _put_Strangle = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            //Vanilla Straddle  
            _call_Straddle = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta_Straddle, nominal, spot, puntos_fwd_costo, strike3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
            _put_Straddle = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta_Straddle, nominal, spot, puntos_fwd_costo, strike3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            _price_call_Straddle = _call_Straddle.BS_Spot();
            _price_put_Straddle = _put_Straddle.BS_Spot();
            _price_call_Strangle = _call_Strangle.BS_Spot();

            //Calculo
            _X = _put_Strangle.find_strike_price(_price_adjusted - (_price_call_Strangle - _price_call_Straddle - _price_put_Straddle), _dK, "BsSpot");
            //_X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public double find_strikeCeiling_Butterfly(double price_objective)
        {
            //Declaracion
            double _X, _dK, _N, _price_adjusted;
            Vanilla _call_Strangle, _put_Strangle, _call_Straddle, _put_Straddle;
            string compra_venta_Straddle;
            double _price_call_Straddle, _price_put_Straddle, _price_put_Strangle;
            int _compra_venta_flag;

            //Constantes           
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _compra_venta_flag = compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;
            compra_venta_Straddle = compra_venta.Equals("compra") ? "venta" : "compra";

            //Vanilla Strangle
            _call_Strangle = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
            _put_Strangle = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            //Vanilla Straddle  
            _call_Straddle = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta_Straddle, nominal, spot, puntos_fwd_costo, strike3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
            _put_Straddle = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta_Straddle, nominal, spot, puntos_fwd_costo, strike3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

            _price_call_Straddle = _call_Straddle.BS_Spot();
            _price_put_Straddle = _put_Straddle.BS_Spot();

            _price_put_Strangle = _put_Strangle.BS_Spot();

            //Calculo
            _X = _call_Strangle.find_strike_price(_price_adjusted - (_price_put_Strangle - _price_call_Straddle - _price_put_Straddle), _dK, "BsSpot");
            //_X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public string Butterfly(string vanilla_asiatica, string BsSpot_BsFwd, bool isVegaWeighted, double NocionalStrangle)
        {
            EstructuraCompuesta = true;

            string returnValue = "";

            if (this.Strikes_Delta_flag == "delta")
            {
                if (Smile.Volas.Count == 0)
                {
                    return "<Data/>";
                }

                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                this.strike1 = Vanilla.find_strike_fwd(delta1);
                this.strike1 = Math.Round(this.strike1, 2);

                Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta, nominal, spot, puntos_fwd_costo, 1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                this.strike2 = Vanilla.find_strike_fwd(delta1);
                this.strike2 = Math.Round(this.strike2, 2);

                this.strike3 = Vanilla.find_atm_strike(0, 0);
                this.strike3 = Math.Round(this.strike3, 2);
            }

            this.Strikes_Delta_flag = "strikes";

            try
            {
                if (vanilla_asiatica == "Vanilla")
                {


                    double Temp_nominal = this.nominal;


                    if (isVegaWeighted)//VegaWeighted
                    {
                        //Straddle_____                                              
                        string Temp_compra_venta = compra_venta.Equals("compra") ? "venta" : "compra";
                        //compra_venta = compra_venta.Equals("compra") ? "venta" : "compra";
                        Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", Temp_compra_venta, nominal, spot, puntos_fwd_costo, strike3, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        double _Vega_Straddle = Vanilla.BS_Spot_Vega();
                        //---------

                        //Strangle___
                        Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, strike1, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);
                        double _Vega_Strangle = Vanilla.BS_Spot_Vega();
                        //--------

                        NocionalStrangle = (_Vega_Straddle / _Vega_Strangle) * nominal;
                    }


                    this.nominal = NocionalStrangle;
                    string ValueOpc1 = this.Strangle("Vanilla", BsSpot_BsFwd);

                    this.nominal = Temp_nominal;
                    string ValueOpc2 = this.Straddle("Vanilla", BsSpot_BsFwd);

                    returnValue = "<DataCompuesta>\n";

                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</DataCompuesta>";
                }

            }
            catch { };
            EstructuraCompuesta = false;

            return returnValue;

        }

        public string FwdGananciaAcotada(string vanilla_asiatica, string BsSpot_BsFwd)
        {
            string returnValue = "";
            string _compra_venta2 = "venta";
            string _call_put_flag = compra_venta == "compra" ? "c" : "p";

            try
            {
                double Strike_Cota = 0;
                if (this.Strikes_Delta_flag == "strikes")
                {
                    Strike_Cota = strike2;
                }

                if (vanilla_asiatica == "Vanilla")
                {
                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    string ValueOpc1 = this.ForwardSintetico("Vanilla", BsSpot_BsFwd);

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, _call_put_flag, _compra_venta2, nominal, spot, puntos_fwd_costo, Strike_Cota, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    string ValueOpc2 = Vanilla.Opcion(3, "Estructura", BsSpot_BsFwd);

                    returnValue = "<Data>\n";

                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</Data>";
                }

            }
            catch { };

            return returnValue;

        }

        public double find_strikeVanilla_price_ForwardAcotado(double price_objective, string Perdida_Ganancia, string BsSpot_BsFwd)
        {
            //Declaracion
            string _call_put_flag, _compra_venta2;
            int _cpf, _cvf;
            double _N, _dK, _price_adjusted, _price_forward, _X;
            double _K, _D_dom, _D_for, _T;
            Vanilla _Vanilla;

            //Constantes            
            _N = this.nominal;
            _dK = 1e-6 / Math.Max(_N, 1);
            _cvf = this.compra_venta.Equals("compra") ? 1 : -1;
            _compra_venta2 = Perdida_Ganancia.Equals("Perdida") ? "compra" : "venta";
            if (Perdida_Ganancia.Equals("Perdida"))
                _call_put_flag = compra_venta == "compra" ? "p" : "c";
            else
                _call_put_flag = compra_venta == "compra" ? "c" : "p";

            _cpf = _call_put_flag.Equals("c") ? 1 : -1;
            _price_adjusted = price_objective / _N * _cvf; //objetivo normalizado
            _Vanilla = new Vanilla(this.mYieldList, Smile, paridad, _call_put_flag, _compra_venta2, 1.0, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios, BsSpot_BsFwd);

            //Calculo del precio del forward
            _K = strike1;//strike of the forward
            _T = _Basis365.Term / 365.0;//maturity of the forward
            _D_dom = Math.Exp(-_Vanilla.r_dom * _T);
            _D_for = Math.Exp(-_Vanilla.r_for * _T);

            _price_forward = spot * _D_for - _K * _D_dom;//price of the forward
            //Calculo de Strike
            _X = _Vanilla.find_strike_price(_cpf * (_price_forward - _price_adjusted), _dK, BsSpot_BsFwd);
           // _X = Math.Round(_X, 2);

            //Retorno
            return _X;
        }

        public double find_strikeForward_price_ForwardAcotado(double price_objective, string Perdida_Ganancia, string BsSpot_BsFwd)
        {
            //Declaracion
            string _call_put_flag, _compra_venta2;
            int _cpf, _cvf;
            double _N, _K_put, _T, _price_adjusted, _price_vanilla, _D_dom, _D_for, _X;
            Vanilla _Vanilla;

            //Constantes
            _N = this.nominal;
            _T = _Basis365.Term / 365.0; //Tiempo hasta el vencimiento
            _K_put = this.strike1;

            _cvf = this.compra_venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _cvf;//objetivo normalizado

            _compra_venta2 = Perdida_Ganancia.Equals("Perdida") ? "compra" : "venta";
            if (Perdida_Ganancia.Equals("Perdida"))
            {
                _call_put_flag = compra_venta == "compra" ? "p" : "c";

            }
            else
            {
                _call_put_flag = compra_venta == "compra" ? "c" : "p";
            }
            _cpf = _call_put_flag.Equals("c") ? 1 : -1;
            _Vanilla = new Vanilla(this.mYieldList, Smile, paridad, _call_put_flag, _compra_venta2, nominal, spot, puntos_fwd_costo, strike2, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios, BsSpot_BsFwd);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                _price_vanilla = _Vanilla.BS_Spot(); //Precio de la vanilla nomalizado
            }
            else
            {
                _price_vanilla = _Vanilla.BS_fwd(spot + puntos_fwd_costo);
            }

            _D_dom = Math.Exp(-_Vanilla.r_dom * _T);//Factor de descuento domestico
            _D_for = Math.Exp(-_Vanilla.r_for * _T);//Factor de descuento foraneo

            //Calculo de Strike
            _X = (spot * _D_for - _price_adjusted - _cpf * _price_vanilla) / _D_dom;
            //_X = Math.Round(_X, 2);


            //Retorno
            return _X;
        }

        public string FwdPerdidaAcotada(string vanilla_asiatica, string BsSpot_BsFwd)
        {
            string returnValue = "";
            string _compra_venta2 = "compra";

            string _call_put_flag = compra_venta == "compra" ? "p" : "c";

            try
            {
                double Srtike_Cota = 0;
                if (this.Strikes_Delta_flag == "strikes")
                {
                    Srtike_Cota = strike2;
                }

                if (vanilla_asiatica == "Vanilla")
                {

                    string ValueOpc1 = this.ForwardSintetico("Vanilla", BsSpot_BsFwd);

                    Vanilla = new Vanilla(this.mYieldList, Smile, paridad, _call_put_flag, _compra_venta2, nominal, spot, puntos_fwd_costo, Srtike_Cota, fecha_Valoracion, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                    if (Smile.Volas.Count == 0)
                    {
                        return "<Data/>";
                    }

                    string ValueOpc2 = Vanilla.Opcion(3, "Estructura", BsSpot_BsFwd);

                    returnValue = "<Data>\n";

                    returnValue += ValueOpc1 + "\n" + ValueOpc2;
                    returnValue += "</Data>";
                }

            }
            catch { };

            return returnValue;

        }

        #region comentada
        //private List<List<double>> mat_sensibilidad_asiatica(Fixing.Fixing _Asiatica, string call_put_flag, double spot, double strike, DateTime fecha_val, DateTime fecha_vencimiento, string YieldCurvaDom, string YieldCurvaFor, int tipo_flag)
        //{
        //    List<List<double>> volas_smile_idioma_0 = new List<List<double>>();

        //    List<List<double>> volas_smile_idioma_1 = new List<List<double>>();

        //    List<List<double>> strikes_smile_vol = new List<List<double>>();
        //    strikes_smile_vol = _Asiatica.strikes;

        //    double _MtM;

        //    int N = _Asiatica.volas.Count;
        //    int Estrategias = 5;
        //    double desplazamiento = 0.01;
        //    double sensibilidad;

        //    List<List<double>> mat_out = new List<List<double>>();
        //    for (int n = 0; n < N; n++)
        //    {
        //        mat_out.Add(new List<double>() { 0, 0, 0, 0, 0 });
        //    }



        //    if (tipo_flag == 1)
        //    {
        //        volas_smile_idioma_1 = _Asiatica.volas;
        //        _MtM = _Asiatica.arithmetic_asian_fx_momentos();

        //        for (int j = 1; j < Estrategias; j++)
        //        {
        //            for (int i = 0; i < N; i++)
        //            {
        //                volas_smile_idioma_1[i][j] = volas_smile_idioma_1[i][j] + desplazamiento;
        //                _Asiatica.volas = volas_smile_idioma_1;
        //                sensibilidad = _Asiatica.arithmetic_asian_fx_momentos() - _MtM;
        //                mat_out[i][j] = sensibilidad;
        //                volas_smile_idioma_1[i][j] = volas_smile_idioma_1[i][j] - desplazamiento;
        //                _Asiatica.volas = volas_smile_idioma_1;
        //            }
        //        }
        //    }
        //    else if (tipo_flag == 0)
        //    {

        //        Fixing.Fixing _Asiatica_1 = new Fixing.Fixing();
        //        _Asiatica_1 = _Asiatica;


        //        volas_smile_idioma_0 = new List<List<double>>(_Asiatica.volas);


        //        volas_smile_idioma_1 = new List<List<double>>(_Asiatica.smile_mid_1_1());


        //        _MtM = _Asiatica.arithmetic_asian_fx_momentos();

        //        for (int j = 0; j < Estrategias; j++)
        //        {
        //            for (int i = 0; i < N; i++)
        //            {
        //                volas_smile_idioma_0[i][j] = volas_smile_idioma_0[i][j] + desplazamiento;
        //                _Asiatica.volas = volas_smile_idioma_0;

        //                volas_smile_idioma_1 = _Asiatica.smile_mid_1_1();
        //                _Asiatica_1.volas = volas_smile_idioma_1;

        //                sensibilidad = _Asiatica_1.arithmetic_asian_fx_momentos() - _MtM;
        //                mat_out[i][j] = sensibilidad;

        //                volas_smile_idioma_0[i][j] = volas_smile_idioma_0[i][j] - desplazamiento;
        //                _Asiatica.volas = volas_smile_idioma_0;
        //            }
        //        }
        //    }




        //    return mat_out;
        //}


        //private List<List<double>> mat_sensibilidad(Smile.Smile _Smile, string call_put_flag, double spot, double strike, DateTime fecha_val, DateTime fecha_vencimiento, string YieldCurvaDom, string YieldCurvaFor, int tipo_flag)
        //{

        //    List<List<double>> volas_smile_idioma_0 = new List<List<double>>();

        //    List<List<double>> volas_smile_idioma_1 = new List<List<double>>();

        //    List<List<double>> strikes_smile_vol = new List<List<double>>();
        //    strikes_smile_vol = _Smile.strikes;

        //    double _MtM;


        //    int N = _Smile.volas.Count;
        //    int Estrategias = 5;
        //    double desplazamiento = 0.01;
        //    double sensibilidad;

        //    List<List<double>> mat_out = new List<List<double>>();
        //    for (int n = 0; n < N; n++)
        //    {
        //        mat_out.Add(new List<double>(Estrategias));
        //    }

        //    if (tipo_flag == 1)
        //    {
        //        volas_smile_idioma_1 = _Smile.volas;

        //        _MtM = _Smile.BS_Spot(this.plazo);

        //        for (int j = 1; j < Estrategias; j++)
        //        {
        //            for (int i = 0; i < N; i++)
        //            {
        //                volas_smile_idioma_1[i][j] = volas_smile_idioma_1[i][j] + desplazamiento;
        //                _Smile.volas = volas_smile_idioma_1;
        //                sensibilidad = _Smile.BS_Spot(this.plazo) - _MtM;
        //                mat_out[i][j] = sensibilidad;
        //                volas_smile_idioma_1[i][j] = volas_smile_idioma_1[i][j] - desplazamiento;
        //                _Smile.volas = volas_smile_idioma_1;
        //            }
        //        }
        //    }
        //    else if (tipo_flag == 0)
        //    {

        //        Smile.Smile _Smile_1 = new Smile.Smile();
        //        _Smile_1 = _Smile;

        //        volas_smile_idioma_0 = _Smile.volas;


        //        volas_smile_idioma_1 = _Smile.smile_mid_1_1();
        //        _MtM = _Smile.BS_Spot(this.plazo);

        //        for (int j = 0; j < Estrategias; j++)
        //        {
        //            for (int i = 0; i < N; i++)
        //            {
        //                volas_smile_idioma_0[i][j] = volas_smile_idioma_0[i][j] + desplazamiento;
        //                _Smile.volas = volas_smile_idioma_0;

        //                volas_smile_idioma_1 = _Smile.smile_mid_1_1();
        //                _Smile_1.volas = volas_smile_idioma_1;

        //                sensibilidad = _Smile_1.BS_Spot(this.plazo) - _MtM;
        //                mat_out[i][j] = sensibilidad;

        //                volas_smile_idioma_0[i][j] = volas_smile_idioma_0[i][j] - desplazamiento;
        //                _Smile.volas = volas_smile_idioma_0;
        //            }
        //        }
        //    }

        //    return mat_out;
        //}
        #endregion

        /// <summary>
        /// Retorna XML <Data> con conjunto de <Opcion> (Asiáticas)
        /// </summary>
        public string StripAsiatico(string vanilla_asiatica, string BsSpot_BsFwd, string call_put, string xmlStrip)//, List<EstructuraStripTool> lo) //List<Object> lo) //List<AdminOpcionesTool.Opciones.Payoffs.Estructuras.EstructuraStripTool> list)//AdminOpciones.OpcionesFX.Front.FontOpciones.StripList)
        {
            //nos guardamos!
            this.__xmlStrip = xmlStrip;

            //double spot_mas_puntos = spotFwd + puntosFwd;
            double strike_fwd = this.strike1;

            string returnValue = "";
            string compra_venta2 = compra_venta == "compra" ? "venta" : "compra";
            try
            {
                //no se utiliza ninguno de los tres strikes ni deltas, sino que el strike es la suma del spot mas los puntos
                if (Strikes_Delta_flag == "strikes" || Strikes_Delta_flag == "delta")
                {
                    #region Para después, StripVanilla
                    if (vanilla_asiatica == "Vanilla")
                    {
                        /* Acá debería ir la implementación del Strip Vanilla.
                         * Probablemente sea mejor meter el if adentro del for.
                        if (Smile.Volas.Count == 0)
                        {
                            return "<Data/>";
                        }
                        Vanilla = new Vanilla(this.mYieldList, this.Smile, paridad, "c", compra_venta, nominal, spot, puntos_fwd_costo, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        string ValueOpc1 = Vanilla.Opcion(1, "Estructura", BsSpot_BsFwd);

                        Vanilla = new Vanilla(this.mYieldList, Smile, paridad, "p", compra_venta2, nominal, spot, puntos_fwd_costo, strike_fwd, fecha_Valoracion, fecha_Vencimiento, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios);

                        string ValueOpc2 = Vanilla.Opcion(2, "Estructura", BsSpot_BsFwd);

                        returnValue = "<Data>\n";

                        returnValue += ValueOpc1 + "\n" + ValueOpc2;
                        returnValue += "</Data>";
                         * */

                    }
                    #endregion
                    else if (vanilla_asiatica == "Asiaticas")
                    {
                        if (Smile.Volas.Count == 0)
                        {
                            return "<Data/>";
                        }

                        returnValue = "<Data>\n";

                        XDocument xstrip = new XDocument();
                        xstrip = XDocument.Parse(xmlStrip);

                        DateTime FV = new DateTime();

                        foreach (XElement xe in xstrip.Element("stripList").Elements("Operacion"))
                        {
                            List<DateTime> STRIPfechaFixingList = new List<DateTime>();
                            List<double> STRIPpesosFixingList = new List<double>();
                            List<double> STRIPvalorFixingList = new List<double>();
                            List<double> STRIPvolatilidadFixingList = new List<double>();
                            List<int> STRIPplazos_fijaciones = new List<int>();

                            foreach (XElement fix in xe.Element("fixingOperacion").Elements("fixing"))
                            {
                                STRIPfechaFixingList.Add(DateTime.Parse(fix.Attribute("FixFecha").Value));
                                STRIPpesosFixingList.Add(double.Parse(fix.Attribute("FixPeso").Value));
                                STRIPvalorFixingList.Add(double.Parse(fix.Attribute("FixValor").Value));
                                STRIPvolatilidadFixingList.Add(double.Parse(fix.Attribute("FixVolatilidad").Value));
                                STRIPplazos_fijaciones.Add(int.Parse(fix.Attribute("FixPlazo").Value));
                            }

                            FV = DateTime.Parse(xe.Element("detOperacion").Attribute("fv").Value);

                            Asiatica = new Asiatica(this.mYieldList, Smile, paridad, call_put, compra_venta, nominal, spot, strike_fwd
                                , fecha_Valoracion, FV, this.FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, SetPrecios
                                , STRIPfechaFixingList, STRIPpesosFixingList, STRIPvalorFixingList, STRIPvolatilidadFixingList, STRIPplazos_fijaciones);

                            //ASVG mejorar.
                            int ii = 0;
                            try { ii = int.Parse(xe.Attribute("id").Value); }
                            catch (Exception asd) { string a = asd.ToString(); ii = 0; };

                            returnValue += Asiatica.Opcion(ii, "Estructura") + "\n";
                        }

                        returnValue += "</Data>";
                    }
                }
            }
            catch (Exception asd)
            {
                string a = asd.ToString();//System.win
            };

            return returnValue;
        }

        //itero en la generación de StripAsiatico hasta tener el MtM deseado.
        public double find_StripAsiatico(double MtM_objective, string vanilla_asiatica, string BsSpot_BsFwd, string call_put)
        {

            string _xmlStrip = this.__xmlStrip;

            //precisión de la derivada parcial
            double dK = 0.01;

            double dMtM_dK = 0.0;
            double paso = 0.0;

            double MtM0 = 0.0;
            double MtM1 = 0.0;

            double K0 = 0.0;
            double K1 = 0.0;

            K0 = this.strike1;
            //esto ya debería estar calculado en algún lado de la pantalla
            MtM0 = MtM_K(K0, vanilla_asiatica, BsSpot_BsFwd, call_put, _xmlStrip);

            while (true)
            {
                K1 = K0 + dK;
                MtM1 = MtM_K(K1, vanilla_asiatica, BsSpot_BsFwd, call_put, _xmlStrip);

                dMtM_dK = (MtM1 - MtM0) / dK;
                paso = (MtM_objective - MtM0) / dMtM_dK;

                if (Math.Round(paso, 2) == 0) break;

                K0 += paso;
                MtM0 = MtM_K(K0, vanilla_asiatica, BsSpot_BsFwd, call_put, _xmlStrip);

                if (Math.Round(MtM0, 0) == MtM_objective) break;
            }

            return Math.Round(K0, 2);
        }

        private double MtM_K(double strike, string vanilla_asiatica, string BsSpot_BsFwd, string call_put, string _xmlStrip)
        {
            this.strike1 = strike;

            XDocument xmlResult = new XDocument(XDocument.Parse(StripAsiatico(vanilla_asiatica, BsSpot_BsFwd, call_put, _xmlStrip)));

            var MTMVar = from itemGriega in xmlResult.Descendants("MtM")
                         select new List<double>
                             {
                                  double.Parse(itemGriega.Attribute("MoVrDet").Value.ToString())
                             };
            double MtM = 0.0;
            for (int j = 0; j < MTMVar.ToList<List<double>>().Count; j++)
            {
                MtM += MTMVar.ToList<List<double>>()[j][0];
            }

            return MtM;
        }
    }
}
