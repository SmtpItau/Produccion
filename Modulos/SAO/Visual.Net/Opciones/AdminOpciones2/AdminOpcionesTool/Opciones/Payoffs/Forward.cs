using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using AdminOpcionesTool.Opciones.SmileNameSpace;
using AdminOpcionesTool.Opciones.Functions;
using cFinancialTools.BussineDate;
using cFinancialTools.Yield;
using cFinancialTools.DayCounters; //Ok (Basis)

namespace AdminOpcionesTool.Opciones.Payoffs
{
    public class Forward
    {
        #region Atributos
        public Smile Smile { get; set; }
        /// <summary>
        /// Par de monedas, ej: "CLP/USD"
        /// </summary>
        public string Paridad { get; set; }
        public string Call_Put
        {
            get
            {
                if (this.Compra_Venta.Equals("Compra")) return "c"; else return "v";
            }
        }
        public string Compra_Venta { get; set; }
        public double Nocional { get; set; }
        public double Spot { get; set; }
        /// <summary>
        /// Aquí se guarda el valor contractual con el que se negocia el contrato.
        /// Esto puede ser de la forma de un Strike o como un Spread sobre las fijaciones para el caso asiático de entrada.
        /// REVISAR: Valor calculado según calendario de fijación de Entrada (puede estar repetido?)
        /// </summary>
        public double Strike { get; set; } //PRD_12567
        public DateTime FechaVal { get; set; }//PRD_12567 era private, se cambia para debug.
        public DateTime FechaVcto { get; set; }//PRD_12567 era private, se cambia para debug.

        private DateTime fecha_val_Delta;
        public string CurvaDom { get; set; }
        public string CurvaFor { get; set; }
        public string TipoCurva { get; set; } //PRD_12567 indica si las curvas son Yield(Swap) valor: "Y" o Lineal(Forward) valor: "L"

        public List<DateTime> Fechas_Fijacion { get; set; }
        public List<double> Pesos_Fijacion { get; set; }
        public List<double> Fijaciones { get; set; }
        public List<double> Volatilidades { get; set; }
        public List<int> Plazos_Fijaciones { get; set; }

        private double[] wf_dom;
        private double[] wf_for;
        private double DeltaRateDom = 0;
        private double DeltaRateFor = 0;
        private YieldList mYieldList;

        /// <summary>
        /// Precio calculado según calendario de fijación de Salida
        /// </summary>
        double PrecioForward = 0 ;//ASVG_20130212 PRD_12567
        /// <summary>
        /// Precio calculado según calendario de fijación de Entrada (puede estar repetido?)
        /// </summary>
        double PrecioStrike = 0;//ASVG_20130212 PRD_12567
        double Delta_Spot_Num = 0;
        double Delta_fwd_Num = 0;
        public double wf_dom_ClPInter = 0.0;//PRD_12567 era private, se cambia para debug.
        public double wf_forUSD = 0.0;//PRD_12567 era private, se cambia para debug.
        
        public bool SmileLoaded;
        public enumSetPrincingLoading SetPricing;
        public DateTime FechaSetDePrecios { get; set; }
        #endregion Atributos

        //Debug LogDebug = new Debug("Valoriza");//PRD_12567 para debug

        #region Constructores
        /// <summary>
        /// Constructor de Forward.
        /// </summary>
        /// <param name="CurvaList"></param>
        /// <param name="smile"></param>
        /// <param name="paridad"></param>
        /// <param name="call_put_flag">No aplica, se debe eliminar.</param>
        /// <param name="compraVenta"></param>
        /// <param name="nocional"></param>
        /// <param name="spot"></param>
        /// <param name="strike"></param>
        /// <param name="FechaVal"></param>
        /// <param name="fecha_Vencimiento"></param>
        /// <param name="fechaSetdePrecios"></param>
        /// <param name="curvaDom"></param>
        /// <param name="curvaFor"></param>
        /// <param name="setPricing"></param>
        /// <param name="fechas_fijacion"></param>
        /// <param name="pesos_fijacion"></param>
        /// <param name="fijaciones"></param>
        /// <param name="volatilidades"></param>
        /// <param name="plazos_fijaciones"></param>
        public Forward(YieldList CurvaList, Smile smile, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double strike, DateTime FechaVal, DateTime fecha_Vencimiento, DateTime fechaSetdePrecios, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, List<DateTime> fechas_fijacion, List<double> pesos_fijacion, List<double> fijaciones, List<double> volatilidades, List<int> plazos_fijaciones)
        {
            this.Smile = smile;
            this.Paridad = paridad;
            this.Compra_Venta = compraVenta;
            this.Nocional = nocional;
            this.Spot = spot;
            this.Strike = strike;
            this.FechaVal = FechaVal;
            this.FechaVcto = fecha_Vencimiento;
            this.FechaSetDePrecios = fechaSetdePrecios;
            this.fecha_val_Delta = FechaVal;
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;

            this.Fechas_Fijacion = fechas_fijacion;
            this.Pesos_Fijacion = pesos_fijacion;
            this.Fijaciones = fijaciones;
            this.Volatilidades = volatilidades;
            this.Plazos_Fijaciones = plazos_fijaciones;

            this.SetPricing = setPricing;

            mYieldList = CurvaList;

            //Sería bueno usarlos para el conteo de días.
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);
            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);

            SmileLoaded = true;

            //esto está replicado en el método ForwardAsiaticoEntradaSalida
            //La definición de las curvas a utilizar debe estar en la clase.
            //MEJORAR
            this.CurvaDom = "CurvaSwapCLP"; //PUELCHE
            this.CurvaFor = "CurvaSwapUSDLocal"; //PUELCHE
            this.TipoCurva = "Y"; //Yield(Swap Y) Lineal(Forward L)

        }
        #endregion Constructores

        /// <summary>
        /// Genera el tag de "FixingData" para una Opcion.
        /// </summary>
        /// <param name="k">Cantidad de fijaciones ya "fijadas"</param>
        /// <param name="Kpp">Strike parcial ¿?</param>
        /// <param name="isFixedData">Indica si ya está todo fijado ¿?</param>
        /// <returns>string con xml con data de fixing.</returns>
        private string XML_FixingData(int k, double Kpp, bool isFixedData)
        {
            string NewFixingData = "<FixingData>";
            double _fixingVol;

            for (int i = 0; i < Fechas_Fijacion.Count; i++)
            {
              //  if (i > k)
                if (Fechas_Fijacion[i].CompareTo( FechaVal) > 0 ) // MAP 20130215 Otra manera ver si esta fijada o no
                {
                    Fijaciones[i] = Function.Forward(FechaVal, Fechas_Fijacion[i], this.FechaSetDePrecios, Spot, CurvaDom, CurvaFor, this.mYieldList);
                }

                if (isFixedData) // MAP 20130215 Recoerdar que este valor podría ser mal evaluado
                                 // por la falta de orden en las fechas
                {
                    if (Fechas_Fijacion[i] <= FechaVal)
                        _fixingVol = 0;
                    else
                        _fixingVol = Smile.interp_vol(Plazos_Fijaciones[i], Kpp, 1, 1);
                }
                else
                {
                    _fixingVol = Smile.interp_vol(Plazos_Fijaciones[i], Strike, 1, 1);
                }

                NewFixingData += "<FixingValues Fecha='" + Fechas_Fijacion[i].ToString("dd-MM-yyyy") + "' Valor='" + Fijaciones[i] + "' Peso='" + Pesos_Fijacion[i] + "' Volatilidad ='" + _fixingVol + "' Plazo='" + Plazos_Fijaciones[i] + "' />\n";
            }

            NewFixingData += "</FixingData>\n";
            return NewFixingData;
        }

//REVISAR
        //PRD_12567
        /// <summary>
        /// Genera estructura con detalle de "Opcion", valorizando Forward Asiático de Entrada Salida.
        /// Tiene un parámetro menos.
        /// </summary>
        /// <param name="numComponente_Estruc"></param>
        /// <param name="Estruct_Indiv"></param>
        /// <returns>String con XML de Detalle Contrato</returns>
        public string ForwardAsiaticoEntradaSalida(int numComponente_Estruc, string Estruct_Indiv)
        {
            //PRD_12567
            //Esta "Opción" es un Forward asiático de entrada salida.

            //esto está replicado en el constructor
            //La definición de las curvas a utilizar debe estar en la clase.
            //MEJORAR
            this.CurvaDom = "CurvaSwapCLP"; //PUELCHE
            this.CurvaFor = "CurvaSwapUSDLocal"; //PUELCHE
            this.TipoCurva = "Y"; //Yield(Swap Y) Lineal(Forward L)

            //Cálculo MtM
            double _MtM = this.GetScaledPricingFxForwardGeneralModel();
            string _ScaledGriegas = this.GetScaledGriegasPricingFxForwardGeneralModel();

            #region XML
            XDocument _geiegasXML = new XDocument(XDocument.Parse(_ScaledGriegas));


            var griegasVanillaVar = from itemGriega in _geiegasXML.Descendants("GriegaData")
                                    select new StructGriegas
                                    {
                                        DeltaSpot = double.Parse(itemGriega.Attribute("DeltaSpot").Value.ToString()),
                                        DeltaForward = this.Delta_fwd_Num,
                                        Gamma = double.Parse(itemGriega.Attribute("Gamma").Value.ToString()),
                                        Vega = double.Parse(itemGriega.Attribute("Vega").Value.ToString()),
                                        RhoDom = double.Parse(itemGriega.Attribute("RhoDom").Value.ToString()),
                                        RhoFor = double.Parse(itemGriega.Attribute("RhoFor").Value.ToString()),
                                        Theta = double.Parse(itemGriega.Attribute("Theta").Value.ToString()),
                                        Charm = double.Parse(itemGriega.Attribute("Charm").Value.ToString()),
                                        Vanna = double.Parse(itemGriega.Attribute("Vanna").Value.ToString()),
                                        Volga = double.Parse(itemGriega.Attribute("Volga").Value.ToString())
                                        //Zomma = double.Parse(itemGriega.Attribute("Zomma").Value.ToString()),
                                        //Speed = double.Parse(itemGriega.Attribute("Speed").Value.ToString())
                                    };

            StructGriegas Griegas = new StructGriegas();
            Griegas = griegasVanillaVar.ToList<StructGriegas>()[0];
            double fwd_teo = 0;

            int k = 0;
            int _N = Fechas_Fijacion.Count;
            double _vol = 0;
            string TipoEmisionPT = this.Compra_Venta == "compra" ? "T" : "P";
            string Call_Put = this.Call_Put == "c" ? "Call" : "Put";
            string Compra_Venta = this.Compra_Venta == "compra" ? "C" : "V";

            string detContrato = "<Opcion>\n";
            //--------------------
            detContrato += "<detContrato>\n";
            detContrato += "<Estructura MoNumFolio='' MoNumEstructura='" + numComponente_Estruc + "' MoVinculacion='" + Estruct_Indiv + "' />\n";
            detContrato += "<DetallesOpcion MoTipoOpc='E' MoSubyacente='FX' MoTipoPayOff='02' MoCallPut='" + Call_Put + "' MoCVOpc='" + Compra_Venta + "' MoTipoEmisionPT='" + TipoEmisionPT + "' MoFechaInicioOpc='" + this.FechaVal.ToString("dd-MM-yyyy") + "' MoFechaFijacion='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' />\n";
            detContrato += "<Vencimiento MoFechaVcto='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' />\n";
            detContrato += "<Subyacente MoFormaPagoMon1='' MoFechaPagMon1='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' MoFormaPagoMon2='' MoFechaPagMon2='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' MoFechaPagoEjer='" + this.FechaVcto.ToString("dd-MM-yyy") + "' MoCodMon1='' MoMontoMon1='" + this.Nocional + "' MoCodMon2='' MoMontoMon2='" + this.Nocional * this.PrecioStrike + "' MoModalidad='' MoMdaCompensacion='' MoFormaPagoComp='' MoBenchComp='994' MoParStrike='" + this.Paridad + "' MoStrike='" + this.PrecioStrike + "' MoPorcStrike='" + this.Strike + "' MoTipoEjercicio ='E' />\n";
            detContrato += "<Proceso MoSpotDet='" + this.Spot + "' />\n";
            detContrato += "<Curvas MoCurveMon1='" + this.CurvaFor + "' MoCurveMon2='" + this.CurvaDom + "' MoCurveSmile='' />\n";
            double _wf_dom = 0;
            if (this.wf_dom != null)
            {
                if (wf_dom.Length > 0)
                {
                    _wf_dom = this.wf_dom[this.wf_dom.Length - 1];
                }
            }
            double _wf_for = 0;
            if (this.wf_for != null)
            {
                if (wf_for.Length > 0)
                {
                    _wf_for = this.wf_for[this.wf_for.Length - 1];
                }
            }
            detContrato += "<MtM MoWf_mon1='" + wf_dom_ClPInter + "' MoWf_mon2='" + wf_forUSD + "' MoVol='" + _vol + "' MoFwd_teo='" + this.PrecioForward + "'  MoVrDet='" + _MtM + "' MoSpotDetCosto='' MoWf_Mon1_Costo='' MoWf_Mon2_Costo='' MoVol_Costo='' MoFwd_Teo_Costo='' MoVr_Costo='' MoVr_CostoDet='' MoPrimaBSSpotDet='' MoIteAsoSis='' MoIteAsoCon='' />\n";
            detContrato += "<Griegas MoDelta_spot='' MoDelta_spot_num='" + Griegas.DeltaSpot + "' MoDelta_fwd='' MoDelta_fwd_num='" + Griegas.DeltaForward + "' MoGamma_spot='' MoGamma_spot_num='" + Griegas.Gamma + "' MoGamma_fwd='' MoGamma_fwd_num='' MoVega='' MoVega_num='" + Griegas.Vega + "' MoVanna_spot='' MoVanna_spot_num='" + Griegas.Vanna + "' MoVanna_fwd='' MoVanna_fwd_num='' MoVolga='' MoVolga_num='" + Griegas.Volga + "' MoTheta='' MoTheta_num='" + Griegas.Theta + "' MoRho='' MoRho_num='" + Griegas.RhoDom + "' MoRhof='' MoRhof_num='" + Griegas.RhoFor + "' MoCharm_spot='' MoCharm_spot_num='" + Griegas.Charm + "' MoCharm_fwd='' MoCharm_fwd_num=''  />";

            //-----------------------------------------------------
            DateTime _fecha_fix;
            double _peso_fix, _valor_fix;
            double _m0, Kpp, _rem_fix, pesosTotales;

            // MAP: observacion esto no funciona para los Forward Entrada salida 
            // ya que las fijaciones no tienen porque estar ordenadas
            bool isFixedData = this.FechaVal.CompareTo(this.Fechas_Fijacion[0]) > 0 ? true : false;

            pesosTotales = 0;
            _rem_fix = 0;
            _m0 = 0;
            Kpp = 0;
            if (isFixedData)
            {
                for (int i = 0; i < Fechas_Fijacion.Count; i++)
                {
                    _fecha_fix = Fechas_Fijacion[i];
                    _peso_fix = this.Pesos_Fijacion[i];
                    _valor_fix = this.Fijaciones[i];

                    if (_fecha_fix <= this.FechaVal)
                    {
                        _m0 += _valor_fix * _peso_fix;
                    }
                    else
                    {
                        _rem_fix += _peso_fix;
                    }
                    pesosTotales += _peso_fix;
                }

                Kpp = (Strike - _m0) / _rem_fix;
            }

            string NewFixingData = XML_FixingData(k, Kpp, isFixedData);

            //-----------------------------------------------------
            detContrato += NewFixingData;
            detContrato += "</detContrato>\n";
            //--------------------
            detContrato += "<GriegasMonto Delta='" + Griegas.DeltaSpot + "' DeltaForward='" + Griegas.DeltaForward + "'  Gamma='" + Griegas.Gamma + "' Vega='" + Griegas.Vega + "' Vanna='" + Griegas.Vanna + "' Volga='" + Griegas.Volga + "' Theta='" + Griegas.Theta + "' Rho='" + Griegas.RhoDom + "' Rhof='" + Griegas.RhoFor + "' Charm='" + Griegas.Charm + "'  />\n";
            detContrato += "</Opcion>";
            #endregion XML

            return detContrato;
        }


//REVISAR
        //PRD_12567
        /// <summary>
        /// Función de valorización de Forward Asiático (Entrada y/o Salida)
        /// </summary>
        /// <param name="CurvasDomFor">XML con curvas Doméstica y Foránea</param>
        /// <param name="idCurvasXML">XML con tipo y nombres de las curvas</param>
        /// <returns>Valor razonable del Forward</returns>
        public double PricingFxForwardGeneralModel()
        {
            //0. declarations
            int cpf, CantidadFijaciones;
            double _X;
            double FactorDescuentoSUByacentePlazoEscalar = 0;
            double FactorDescuentoNUMerairePlazoEscalar = 0;
            double TasaForanea = 0;
            double TasaDomestica = 0;
            double Plazo;
            //string CurvaDomCLP = "";
            //string CurvaForUSD = "";

            double Suma_PesoEntr_i_Multiplicado_FactorProyec_i = 0;
            double Suma_PesoSlda_i_Multiplicado_FactorProyec_i = 0;
            double Suma_PesoEntr_i_Multiplicado_FijacionConocida_i = 0;
            double Suma_PesoSlda_i_Multiplicado_FijacionConocida_i = 0;

            List<string> _PlazoRem = new List<string>();     // Genera Lista Plazo Remanente(Fecha Fijación-Fecha Proceso)
            List<string> PlazoRem = new List<string>();     // Genera Lista Plazo Remanente(Fecha Fijación-Fecha Proceso)

            List<string> DiasCurvaCLP = new List<string>(); // Contiene los Dias de  curva CLP
            List<string> DiasCurvaUSD = new List<string>(); // Contiene los Dias de  curva USD
            List<string> BidCurvaCLP = new List<string>();  // Contiene ValorBid de Curva CLP
            List<string> BidCurvaUSD = new List<string>();  // Contiene ValorBid de Curva CLP
            List<string> LinInterpolUSD = new List<string>();//Contiene Interpolacion de Curva USD tasa foranea Subyacente
            List<string> LinInterpolCLP = new List<string>();//Contiene Interpolacion de Curva CLP tasa local Numeraire
            List<double> FactorDescuentoSUByacentePlazo_i = new List<double>();//Contiene factor descuento Subyacente de Plazo Ejem Excel Forward(=SI(K56>0;1/(1+L56/100*K56/360);0))Swap(=SI(K17>0;1/(1+L17/100)^(K17/360);0))
            List<double> FactorDescuentoNUMerairePlazo_i = new List<double>();// Contiene factor descuento Numeraire de Plazo Ejem Excel Forward(=SI(K17>0;1/(1+N17/100*K17/360);0)) Swap(=SI(K17>0;1/(1+N17/100)^(K17/360);0))

            //1. constants
            cpf = 1;//call put flag, call by default
            if (Compra_Venta == "venta")
                cpf = -1;

            Calendars calendar = new Calendars();
            CantidadFijaciones = this.Fechas_Fijacion.Count;

            for (int i = 0; i < CantidadFijaciones; i++)
            {
                DateTime _FechaPublicacion = Fechas_Fijacion[i].Date;
                // DateTime _FechaHabilAnterior = calendar.PreviousHolidayDate(6, _FechaPublicacion.Date);

                //PlazoRem.Add((_FechaHabilAnterior.Date - FechaVal.Date).Days.ToString());
                // JPFreire establece que no se usará el día habil anterior
                // para el cálculo del plazo remanente del plazo remanente
                _PlazoRem.Add((_FechaPublicacion.Date - FechaVal.Date).Days.ToString());
                PlazoRem.Add((_FechaPublicacion.Date - this.fecha_val_Delta.Date).Days.ToString());
            }

            DiasCurvaCLP = List_DesdeYieldList("Tenor", this.CurvaDom, this.mYieldList, this.FechaSetDePrecios);
            BidCurvaCLP = List_DesdeYieldList("Rate", this.CurvaDom, this.mYieldList, this.FechaSetDePrecios);
            DiasCurvaUSD = List_DesdeYieldList("Tenor", this.CurvaFor, this.mYieldList, this.FechaSetDePrecios);
            BidCurvaUSD = List_DesdeYieldList("Rate", this.CurvaFor, this.mYieldList, this.FechaSetDePrecios);

            #region Crea InterpolateUSD

            int CountDiasUSD = DiasCurvaUSD.Count();
            int CountBidUSD = BidCurvaUSD.Count();

            if (CountDiasUSD < CountBidUSD)
            {
                return 0;
            }

            for (int j = 0; j < CantidadFijaciones; j++)
            {
                int plazo1_USD = 0;
                double tasa1_USD = 0;
                int plazo2_USD = 0;
                double tasa2_USD = 0;

                if (Convert.ToInt32(PlazoRem[j]) < 0)
                {
                    LinInterpolUSD.Add("0");
                    continue;
                }

                if (Convert.ToInt32(PlazoRem[j]) >= Convert.ToInt32(DiasCurvaUSD[CountDiasUSD - 1]))
                {
                    LinInterpolUSD.Add(BidCurvaUSD[j].ToString());
                    continue;
                }

                if (Convert.ToInt32(PlazoRem[j]) <= Convert.ToInt32(DiasCurvaUSD[0]))
                {
                    LinInterpolUSD.Add(BidCurvaUSD[0].ToString());
                    continue;
                }

                for (int z = 0; z < CountDiasUSD; z++)
                {
                    if (Convert.ToInt32(PlazoRem[j]) > Convert.ToInt32(DiasCurvaUSD[z]))
                    {
                        plazo1_USD = Convert.ToInt32(DiasCurvaUSD[z]);
                        tasa1_USD = Convert.ToDouble(BidCurvaUSD[z]);
                        plazo2_USD = Convert.ToInt32(DiasCurvaUSD[z + 1]);
                        tasa2_USD = Convert.ToDouble(BidCurvaUSD[z + 1]);
                    }
                }
                LinInterpolUSD.Add((tasa1_USD + (tasa2_USD - tasa1_USD) / (plazo2_USD - plazo1_USD) * (Convert.ToInt32(PlazoRem[j]) - plazo1_USD)).ToString());
            }

            #endregion Crea InterpolateUSD

            #region Crea InterpolateCLP

            int CountDiasCLP = DiasCurvaCLP.Count();
            int CountBidCLP = BidCurvaCLP.Count();

            if (CountDiasCLP < CountBidCLP)
            {
                return 0;
            }

            for (int j = 0; j < CantidadFijaciones; j++)
            {
                int plazo1_CLP = 0;
                double tasa1_CLP = 0;
                int plazo2_CLP = 0;
                double tasa2_CLP = 0;

                if (Convert.ToInt32(PlazoRem[j]) < 0)
                {
                    LinInterpolCLP.Add("0");
                    continue;
                }

                if (Convert.ToInt32(PlazoRem[j]) >= Convert.ToInt32(DiasCurvaCLP[CountDiasCLP - 1]))
                {
                    LinInterpolCLP.Add(BidCurvaCLP[j].ToString());
                    continue;
                }

                if (Convert.ToInt32(PlazoRem[j]) <= Convert.ToInt32(DiasCurvaCLP[0]))
                {
                    LinInterpolCLP.Add(BidCurvaCLP[0].ToString());
                    continue;
                }

                for (int z = 0; z < CountDiasCLP; z++)
                {
                    if (Convert.ToInt32(PlazoRem[j]) > Convert.ToInt32(DiasCurvaCLP[z]))
                    {
                        plazo1_CLP = Convert.ToInt32(DiasCurvaCLP[z]);
                        tasa1_CLP = Convert.ToDouble(BidCurvaCLP[z]);
                        plazo2_CLP = Convert.ToInt32(DiasCurvaCLP[z + 1]);
                        tasa2_CLP = Convert.ToDouble(BidCurvaCLP[z + 1]);
                    }
                }
                LinInterpolCLP.Add((tasa1_CLP + (tasa2_CLP - tasa1_CLP) / (plazo2_CLP - plazo1_CLP) * (Convert.ToInt32(PlazoRem[j]) - plazo1_CLP)).ToString());
            }

            #endregion Crea InterpolateUSD

            #region FactorDescuentoSUByacentePlazo_i Y FactorDescuentoNUMerairePlazo_i
            PrecioStrike = 0.0;
            PrecioForward = 0.0;
            for (int j = 0; j < CantidadFijaciones; j++)
            {

                string _sPesosFijacion = Pesos_Fijacion[j].ToString("N16"); // MAP 20130213 Ajuste manejo decimales
                string _sFijaciones = Fijaciones[j].ToString("N2");

                double _fPesosFijacion = Convert.ToDouble(_sPesosFijacion);
                double _fFijaciones = Convert.ToDouble(_sFijaciones);

                #region Sumando información Conocida
                if (Convert.ToInt32(PlazoRem[j]) <= 0)    // MAP: Antes era < 0 , no se consideraban la fijación conocida d ela fecha de proceso
                    if (_fPesosFijacion < 0) // Fijacion de Entrada
                        Suma_PesoEntr_i_Multiplicado_FijacionConocida_i += _fPesosFijacion * _fFijaciones;
                    else
                        Suma_PesoSlda_i_Multiplicado_FijacionConocida_i += _fPesosFijacion * _fFijaciones;
                #endregion Sumando información Conocida

                TasaDomestica = Convert.ToDouble(LinInterpolCLP[j]);
                TasaForanea = Convert.ToDouble(LinInterpolUSD[j]);
                Plazo = Convert.ToInt32(PlazoRem[j]);

                #region Calculo de datos proyectados
                if (Convert.ToInt32(PlazoRem[j]) > 0)
                {
                    if (TipoCurva == "L")
                    {
                        FactorDescuentoSUByacentePlazoEscalar = (1 + TasaForanea / 100 * Plazo / 360);
                        FactorDescuentoNUMerairePlazoEscalar = (1 + TasaDomestica / 100 * Plazo / 360);
                    }
                    else if (TipoCurva == "Y")
                    {
                        // Modifica Standar de Factores de descuento
                        FactorDescuentoSUByacentePlazoEscalar = Math.Pow(1 + TasaForanea / 100, Plazo / 360);
                        FactorDescuentoNUMerairePlazoEscalar = Math.Pow(1 + TasaDomestica / 100, Plazo / 360);
                    }
                    if (_fPesosFijacion < 0) // entrada
                    {
                        // Modifica Standar de Factores de descuento
                        Suma_PesoEntr_i_Multiplicado_FactorProyec_i += _fPesosFijacion * FactorDescuentoNUMerairePlazoEscalar / FactorDescuentoSUByacentePlazoEscalar;
                    }
                    else                      // Salida
                    {
                        // Modifica Standar de Factores de descuento
                        Suma_PesoSlda_i_Multiplicado_FactorProyec_i += _fPesosFijacion * FactorDescuentoNUMerairePlazoEscalar / FactorDescuentoSUByacentePlazoEscalar;
                    }
                    FactorDescuentoNUMerairePlazo_i.Add(FactorDescuentoNUMerairePlazoEscalar);
                    FactorDescuentoSUByacentePlazo_i.Add(FactorDescuentoSUByacentePlazoEscalar);
                }
                else
                {                   
                    //plazo remanente es 0  factor de descuento debe ser 1 no 0 
                    FactorDescuentoNUMerairePlazo_i.Add(1);
                    FactorDescuentoSUByacentePlazo_i.Add(1);
                }
                #endregion Calculo de datos proyectados

                //LogDebug.LogForwardFijacion(FechaVal, Fechas_Fijacion[j], Plazo, j, CantidadFijaciones, TasaDomestica, TasaForanea, FactorDescuentoNUMerairePlazoEscalar, FactorDescuentoSUByacentePlazoEscalar);
            }
            Int32 MaxPlaRem = Int32.MinValue;
            Int32 AuxPlazo = Int32.MinValue;
            Int32 IndiceFactorDescuento = Int32.MinValue;

            for (int i = 0; i < CantidadFijaciones; i++)
            {
                AuxPlazo = Convert.ToInt32(PlazoRem[i]);

                if (AuxPlazo > MaxPlaRem)
                {
                    MaxPlaRem = AuxPlazo;
                    IndiceFactorDescuento = i;
                }
            }

            wf_dom_ClPInter = Convert.ToDouble(FactorDescuentoNUMerairePlazo_i[IndiceFactorDescuento]);
            wf_forUSD = Convert.ToDouble(FactorDescuentoSUByacentePlazo_i[IndiceFactorDescuento]);

            this.PrecioStrike = Math.Round(Strike - Spot * Suma_PesoEntr_i_Multiplicado_FactorProyec_i - Suma_PesoEntr_i_Multiplicado_FijacionConocida_i, 2);
            this.PrecioForward = Math.Round(Suma_PesoSlda_i_Multiplicado_FijacionConocida_i + Spot * Suma_PesoSlda_i_Multiplicado_FactorProyec_i, 4);

            // Modifica Standar de Factores de Descuento
            this.Delta_Spot_Num = Math.Round(Nocional / FactorDescuentoNUMerairePlazo_i[IndiceFactorDescuento]
                                              * (Suma_PesoSlda_i_Multiplicado_FactorProyec_i + Suma_PesoEntr_i_Multiplicado_FactorProyec_i)
                                              * cpf, 0);

            double Factores = FactorDescuentoNUMerairePlazo_i[IndiceFactorDescuento] / FactorDescuentoSUByacentePlazo_i[IndiceFactorDescuento];

            if (FactorDescuentoNUMerairePlazo_i[IndiceFactorDescuento] != 0)
            {
                // Modifica Standar de Factores de Descuento
                this.Delta_fwd_Num = Math.Round(this.Delta_Spot_Num * Factores);
            }
            else
            {
                this.Delta_fwd_Num = 0;
            }

            if (FactorDescuentoNUMerairePlazo_i[IndiceFactorDescuento] != 0)
            {
                // Modifica Standar de Factores de Descuento
                _X = (this.PrecioForward - this.PrecioStrike) / FactorDescuentoNUMerairePlazo_i[IndiceFactorDescuento];
            }
            else
            {
                _X = this.PrecioForward - this.PrecioStrike;
            }
            #endregion FactorDescuentoSUByacentePlazo_i Y FactorDescuentoNUMerairePlazo_i

            //LogDebug.LogForward(this, TasaDomestica, TasaForanea);//PRD_12567 para debug

            return _X;
        }

        #region Cálculos Griegas
//REVISAR
        //PRD_12567
        public double GetScaledPricingFxForwardGeneralModel()
        {
            double returnValue = this.PricingFxForwardGeneralModel();

            int c_v = 1;


            if (this.Compra_Venta == "venta")
            {
                c_v = -1;
            }

            returnValue = this.Nocional * c_v * returnValue;
            return returnValue;
        }

        /// <summary>
        /// Genera XML con griegas para Forward
        /// </summary>
        /// <returns></returns>
        public string GetScaledGriegasPricingFxForwardGeneralModel()
        {
            double _Delta = 0; 
            double _Gamma = 0; 
            double _Vega = 0; 
            double _Vanna = 0;
            double _Volga = 0;
            double _Theta = 0;
            double _Rho = 0; 
            double _Rhof = 0; 
            double _Charm = 0;

            //_Delta = this.Delta_Spot_Num;

            //ASVG_20140908 OJO, este cálculo sobre-escribe todas las griegas por el cálculo a t+1
            _Theta = theta_PricingFxForwardGeneralModel();
            _Theta = _Theta.Equals(double.NaN) ? 0 : _Theta;

            _Delta = this.Delta_Spot_Num;

            int c_v = 1;

            if (Compra_Venta == "venta")
            {
                c_v = -1;
            }
                      
            _Theta = (1.0 / 365) * Nocional * c_v * _Theta;

            string ReturnValue = "<GriegasAsiaticas>\n";

            ReturnValue += 
                String.Format("<GriegaData  DeltaSpot='{0}' Gamma='{1}' Vega='{2}' RhoDom='{3}' RhoFor='{4}' Theta='{5}' Charm='{6}' Vanna='{7}' Volga='{8}' />",
                    _Delta.ToString(),
                    _Gamma.ToString(),
                    _Vega.ToString(),
                    _Rho.ToString(),
                    _Rhof.ToString(),
                    _Theta.ToString(),
                    _Charm.ToString(),
                    _Vanna.ToString(),
                    _Volga.ToString());

            //ReturnValue += "<GriegaData  DeltaSpot='" + _Delta.ToString() + "' " +
            //                              "Gamma='" + _Gamma.ToString() + "' " +
            //                              "Vega='" + _Vega.ToString() + "' " +
            //                              "RhoDom='" + _Rho.ToString() + "' " +
            //                              "RhoFor='" + _Rhof.ToString() + "' " +
            //                              "Theta='" + _Theta.ToString() + "' " +
            //                              "Charm='" + _Charm.ToString() + "' " +
            //                              "Vanna='" + _Vanna.ToString() + "' " +
            //                              "Volga='" + _Volga.ToString() + "' />";
 
            ReturnValue += "</GriegasAsiaticas>";

            return ReturnValue;
        }

        private double theta_PricingFxForwardGeneralModel()
        {
            Calendars calendar = new Calendars();
            calendar.Load();

            // Revisar: BussDay(fecha_val + 1)
            int N = this.Fechas_Fijacion.Count;
            int _base = 365;

            DateTime _fecha_aux = new DateTime();
            _fecha_aux = calendar.NextHolidayDate(6, this.FechaVal); // =BussDay(fecha_val + 1)

            Basis _Basis1 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, _fecha_aux);
            Basis _Basis2 = new Basis(enumBasis.Basis_Act_365, _fecha_aux, this.Fechas_Fijacion[N - 1]);

            double _dt = _Basis1.TermBasis;
            double _condicion = _Basis2.TermBasis;

            double _v0 = PricingFxForwardGeneralModel();
            double _v1;

            DateTime aux_fecha_val = new DateTime();
            aux_fecha_val = this.FechaVal;

            //Esta condición no aplica para los Fwd-ES
            //if (_condicion <= 0)
            //{
            //    this.fecha_val_Delta = this.Fechas_Fijacion[N - 1].AddSeconds(-1.0);
            //}
            //else
            //{
            //    this.fecha_val_Delta = _fecha_aux;
            //}

            this.fecha_val_Delta = _fecha_aux;

            //valoriza en t+1
            _v1 = PricingFxForwardGeneralModel();
            this.fecha_val_Delta = aux_fecha_val;

            return _base * (_v1 - _v0);
        }

        #endregion Cálculos Griegas

        /// <summary>
        /// Genera una lista con el atributo deseado de una curva.
        /// </summary>
        /// <param name="Atributo">Puede ser "Tenor" para los días o "Rate" para el valor.</param>
        /// <param name="nombre_curva">Nombre de la curva</param>
        /// <param name="yl">Estructura de lista de Yield con los datos</param>
        /// <param name="FechaSetDePrecios">Fecha del Set de Precios, en general es igual a la fecha de proceso.</param>
        /// <returns></returns>
        private List<string> List_DesdeYieldList(string Atributo, string nombre_curva, YieldList yl, DateTime FechaSetDePrecios)
        {
            XDocument ___CurvaFwCLP = new XDocument(XDocument.Parse(yl.GetYield(nombre_curva, 0, FechaSetDePrecios)));

            List<string> l_Curva = new List<string>();

            foreach (XElement xe in ___CurvaFwCLP.Descendants("Point"))
            {
                if (Atributo.StartsWith("Rate"))
                {
                    l_Curva.Add((double.Parse(xe.Attribute(Atributo).Value.ToString()) + double.Parse(xe.Attribute("Spread").Value.ToString())).ToString());
                }
                else
                {
                    l_Curva.Add(xe.Attribute(Atributo).Value.ToString());
                }
            }

            return l_Curva;
        }
    }
}
