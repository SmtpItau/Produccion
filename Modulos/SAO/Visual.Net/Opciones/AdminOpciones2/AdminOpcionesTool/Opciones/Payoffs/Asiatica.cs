using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AdminOpcionesTool.Opciones.Struct;
using AdminOpcionesTool.Opciones.SmileNameSpace;
using cFinancialTools.BussineDate;
using cFinancialTools.Yield;
using AdminOpcionesTool.Opciones.Functions;
using cFinancialTools.DayCounters;
using System.Xml.Linq;

namespace AdminOpcionesTool.Opciones.Payoffs
{
    public class Asiatica
    {
        #region Atributos
        public Smile Smile { get; set; }
        /// <summary>
        /// Par de monedas, ej: "CLP/USD"
        /// </summary>
        public string Paridad { get; set; }
        public string Call_Put { get; set; }
        public string Compra_Venta { get; set; }
        public double Nocional { get; set; }
        public double Spot { get; set; }
        /// <summary>
        /// Aquí se guarda el valor contractual con el que se negocia el contrato.
        /// Esto puede ser de la forma de un Strike o como un Spread sobre las fijaciones para el caso asiático de entrada.
        /// </summary>
        public double Strike { get; set; } //PRD_12567
        DateTime FechaVal { get; set; }
        DateTime FechaVcto { get; set; }
        private DateTime fecha_val_Delta;
        public string CurvaDom { get; set; }
        public string CurvaFor { get; set; }

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
        private Basis _Basis365;
        private Basis _Basis360;
        
        public bool SmileLoaded;
        public enumSetPrincingLoading SetPricing;
        public DateTime FechaSetDePrecios { get; set; }
        #endregion Atributos

        #region Constructores
        public Asiatica(YieldList CurvaList, Smile smile, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double strike, DateTime FechaVal, DateTime fecha_Vencimiento, DateTime fechaSetdePrecios, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, List<DateTime> fechas_fijacion, List<double> pesos_fijacion, List<double> fijaciones, List<double> volatilidades, List<int> plazos_fijaciones)
        {
            this.Smile = smile;
            this.Paridad = paridad;
            this.Call_Put = call_put_flag;
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

            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);
            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);

            SmileLoaded = true;

        }

        public Asiatica(YieldList CurvaList, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double strike, DateTime FechaVal, DateTime fecha_Vencimiento, DateTime fechaSetdePrecios, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, List<DateTime> fechas_fijacion, List<double> pesos_fijacion, List<double> fijaciones, List<double> volatilidades, List<int> plazos_fijaciones, int flag_smile_0_1)
        {
            this.Paridad = paridad;
            this.Call_Put = call_put_flag;
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
            this.SetPricing = setPricing;

            this.Fechas_Fijacion = fechas_fijacion;
            this.Pesos_Fijacion = pesos_fijacion;
            this.Fijaciones = fijaciones;
            this.Volatilidades = volatilidades;
            this.Plazos_Fijaciones = plazos_fijaciones;

            mYieldList = CurvaList;

            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);
            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);

            this.Smile = new Smile(this.FechaSetDePrecios, paridad, spot, curvaDom, curvaFor, flag_smile_0_1);
            try
            {
                Smile.Load((enumSetPrincingLoading)setPricing);
                SmileLoaded = true;
            }
            catch
            {
                SmileLoaded = false;
            }

        }
        #endregion Constructores

        public string Opcion(int numComponente_Estruc, string Estruct_Indiv)
        {

            //Cálculo MtM
            double _MtM = this.GetScaledArithmetic_asian_fx_momentos();
            string _ScaledGriegas = this.GetScaledGriegas();

            #region XML
            XDocument _geiegasXML = new XDocument(XDocument.Parse(_ScaledGriegas));


            var griegasVanillaVar = from itemGriega in _geiegasXML.Descendants("GriegaData")
                                    select new StructGriegas
                                    {
                                        DeltaSpot = double.Parse(itemGriega.Attribute("DeltaSpot").Value.ToString()),
                                        DeltaForward = 0,
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

            
            int k = 0; //cantidad de fijaciones ya "fijadas"
            int _N = Fechas_Fijacion.Count;
            double _pesos = 0;
            double _vol = 0;


            // MAP 20130215 Este código funciona solo cuando las fechas vienen
            // ordenadas lo que no se cumple para los Forward Asiáticos
            // entrada salida
            //if (Fechas_Fijacion[_N - 1] != this.FechaVal)
            if (Fechas_Fijacion[_N - 1] > this.FechaVal)                     // MAP 20130227 Antes era !=
            {
                while (Fechas_Fijacion[k].CompareTo(this.FechaVal) <= 0)
                {
                    k++;
                }

                for (int i = k; i < this.Fijaciones.Count; i++)
                {
                    _pesos += Pesos_Fijacion[i];
                    fwd_teo += Pesos_Fijacion[i] * Fijaciones[i];
                }
                fwd_teo = fwd_teo / _pesos;

                for (int j = 0; j < Fijaciones.Count; j++)
                {
                    if (this.Plazos_Fijaciones[j] > 0)
                        _vol += Pesos_Fijacion[j] * Volatilidades[j];

                }

            }
            else
            {
                k = _N;
                fwd_teo = this.Spot;
            }

            string TipoEmisionPT = this.Compra_Venta == "compra" ? "T" : "P";
            string Call_Put = this.Call_Put == "c" ? "Call" : "Put";
            string Compra_Venta = this.Compra_Venta == "compra" ? "C" : "V";



            string detContrato = "<Opcion>\n";
            //--------------------
            detContrato += "<detContrato>\n";
            detContrato += "<Estructura MoNumFolio='' MoNumEstructura='" + numComponente_Estruc + "' MoVinculacion='" + Estruct_Indiv + "' />\n";
            detContrato += "<DetallesOpcion MoTipoOpc='E' MoSubyacente='FX' MoTipoPayOff='02' MoCallPut='" + Call_Put + "' MoCVOpc='" + Compra_Venta + "' MoTipoEmisionPT='" + TipoEmisionPT + "' MoFechaInicioOpc='" + this.FechaVal.ToString("dd-MM-yyyy") + "' MoFechaFijacion='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' />\n";
            detContrato += "<Vencimiento MoFechaVcto='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' />\n";
            detContrato += "<Subyacente MoFormaPagoMon1='' MoFechaPagMon1='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' MoFormaPagoMon2='' MoFechaPagMon2='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' MoFechaPagoEjer='" + this.FechaVcto.ToString("dd-MM-yyy") + "' MoCodMon1='' MoMontoMon1='" + this.Nocional + "' MoCodMon2='' MoMontoMon2='" + this.Nocional * this.Strike + "' MoModalidad='' MoMdaCompensacion='' MoFormaPagoComp='' MoBenchComp='994' MoParStrike='" + this.Paridad + "' MoStrike='" + this.Strike + "' MoPorcStrike='' MoTipoEjercicio='E' />\n";
            detContrato += "<Proceso MoSpotDet='" + this.Spot + "' />\n";
            detContrato += "<Curvas MoCurveMon1='" + this.CurvaDom + "' MoCurveMon2='" + this.CurvaFor + "' MoCurveSmile='' />\n";
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
            detContrato += "<MtM MoWf_mon1='" + _wf_dom + "' MoWf_mon2='" + _wf_for + "' MoVol='" + _vol + "' MoFwd_teo='" + fwd_teo + "'  MoVrDet='" + _MtM + "' MoSpotDetCosto='' MoWf_Mon1_Costo='' MoWf_Mon2_Costo='' MoVol_Costo='' MoFwd_Teo_Costo='' MoVr_Costo='' MoVr_CostoDet='' MoPrimaBSSpotDet='' MoIteAsoSis='' MoIteAsoCon='' />\n";
            detContrato += "<Griegas MoDelta_spot='' MoDelta_spot_num='" + Griegas.DeltaSpot + "' MoDelta_fwd='' MoDelta_fwd_num='" + Griegas.DeltaForward + "' MoGamma_spot='' MoGamma_spot_num='" + Griegas.Gamma + "' MoGamma_fwd='' MoGamma_fwd_num='' MoVega='' MoVega_num='" + Griegas.Vega + "' MoVanna_spot='' MoVanna_spot_num='" + Griegas.Vanna + "' MoVanna_fwd='' MoVanna_fwd_num='' MoVolga='' MoVolga_num='" + Griegas.Volga + "' MoTheta='' MoTheta_num='" + Griegas.Theta + "' MoRho='' MoRho_num='" + Griegas.RhoDom + "' MoRhof='' MoRhof_num='" + Griegas.RhoFor + "' MoCharm_spot='' MoCharm_spot_num='" + Griegas.Charm + "' MoCharm_fwd='' MoCharm_fwd_num=''  />";

            //-----------------------------------------------------
            DateTime _fecha_fix;
            double _peso_fix, _valor_fix;
            double _m0, Kpp, _rem_fix, pesosTotales;
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

        /// <summary>
        /// 
        /// </summary>
        /// <returns>_M0 = 0;//utilized strike, _M1 = 0;//pseudo forward,_M2 = 0;//pseudo second moment</returns>
        public List<double> M0_M1_M2()
        {
            //0. declarations
            int N, n_fixings, fix_rem;
            double _wgt_rem, _RateDom, _RateFor, _Vol, _M0, _M1, _M2;
            double _k_m, _k_sig;
            int[] plazo_fixing;
            double[] wf;
            double[] vola;
            double[] Forward;
            double[] bi;
            double[] ti;
            double[] ei;
            List<double> ListM0M1M2;

            //1. constants
            N = this.Fechas_Fijacion.Count;//total number of fixings

            //2. count the number of remaining fixings
            n_fixings = 0;//number of past fixings
            while (n_fixings < N && fecha_val_Delta.CompareTo(Fechas_Fijacion[n_fixings]) >= 0)
                n_fixings++;

            fix_rem = N - n_fixings;//number of future fixings

            //3. set the remaining weight
            _wgt_rem = 0;
            for (int j = 0; j < fix_rem; j++)
                _wgt_rem += Pesos_Fijacion[j + n_fixings];


            //4. compute remaining strike
            _M0 = 0;//utilized strike
            for (int i = 0; i < n_fixings; i++)
            {
                _M0 = _M0 + Fijaciones[i] * Pesos_Fijacion[i];
            }
            _k_m = Strike - _M0;//remaining strike
            _k_sig = (Math.Abs(_wgt_rem) > 1e-40) ? _k_m / _wgt_rem : 0;//adjusted strike to extract the implied volatility

            cFinancialTools.DayCounters.Basis _Basis360;
            cFinancialTools.DayCounters.Basis _Basis365;

            //5. precompute data for the remaining fixings
            plazo_fixing = new int[fix_rem];
            wf = new double[fix_rem];
            wf_dom = new double[fix_rem];
            wf_for = new double[fix_rem];
            vola = new double[fix_rem];
            Forward = new double[fix_rem];
            bi = new double[fix_rem];
            ti = new double[fix_rem];
            ei = new double[fix_rem];
            for (int j = 0; j < fix_rem; j++)
            {
                _Basis360 = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, fecha_val_Delta, Fechas_Fijacion[j + n_fixings]);
                _Basis365 = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_365, fecha_val_Delta, Fechas_Fijacion[j + n_fixings]);

                plazo_fixing[j] = (int)_Basis360.Term;
                wf[j] = _Basis360.TermBasis;

                _RateDom = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, plazo_fixing[j]).Rate;
                _RateFor = mYieldList.Read(CurvaFor, enumSource.System, this.FechaSetDePrecios, plazo_fixing[j]).Rate;

                //DeltaRate solo cambia para griega Rho
                _RateDom += this.DeltaRateDom;
                _RateFor += this.DeltaRateFor;

                wf_dom[j] = Math.Pow(1 + 0.01 * _RateDom, _Basis360.TermBasis);
                wf_for[j] = Math.Pow(1 + 0.01 * _RateFor, _Basis360.TermBasis);

                Forward[j] = Spot * (wf_dom[j] / wf_for[j]);

                _Vol = this.Smile.interp_vol(plazo_fixing[j], _k_sig, 1, 1);//implied BS volatility with the sticky-strike assumption
                vola[j] = 0.01 * _Vol;

                bi[j] = Forward[j] * Pesos_Fijacion[j + n_fixings];
                ti[j] = _Basis365.TermBasis;
                ei[j] = Math.Exp(Math.Pow(vola[j], 2) * ti[j]);
            }

            //6. compute BS-equivalent variables
            _M1 = 0;//pseudo forward
            _M2 = 0;//pseudo second moment
            for (int i = 0; i < fix_rem; i++)
            {
                _M1 = _M1 + bi[i];
                _M2 = _M2 + Math.Pow(bi[i], 2) * ei[i];

                for (int j = i + 1; j < fix_rem; j++)
                {
                    _M2 = _M2 + 2 * bi[i] * bi[j] * ei[i];
                }
            }

            //7. store
            ListM0M1M2 = new List<double>();

            ListM0M1M2.Add(_M0);
            ListM0M1M2.Add(_M1);
            ListM0M1M2.Add(_M2);

            return ListM0M1M2;
        }

        #region Solver

        public double find_strike_ForwardAsiatico(double price_objective)
        {
            //Declaraciones
            double _N, _price_adjusted, _M0, _M1, _X, _D_dom, _T;
            int _compra_venta_flag;
            double _spot_dom;
            List<double> ListM0M1M2;

            //Constantes            
            _N = this.Nocional;
            _compra_venta_flag = this.Compra_Venta.Equals("compra") ? 1 : -1;
            _price_adjusted = price_objective / _N * _compra_venta_flag;
            _T = _Basis365.Term / 365.0;

            _spot_dom = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate;

            _D_dom = 1 / Math.Pow(1 + 0.01 * _spot_dom, _Basis360.TermBasis);

            ListM0M1M2 = M0_M1_M2();
            _M0 = ListM0M1M2[0];
            _M1 = ListM0M1M2[1];

            //Calculo
            _X = _M0 + _M1 - _price_adjusted / _D_dom;

            //Retorno
            return _X;

        }

        public double find_strike_CallPutAsiatico(double price_objective)
        {
            //0. declaration
            int MaxIter, nIter, _cvf;
            double dPrice, dVol, _N, _price_adjusted, new_strike, new_price;
            double[] eps_price_strike;

            //1. constants
            MaxIter = 100;
            _cvf = this.Compra_Venta.Equals("compra") ? 1 : -1;
            _N = this.Nocional;
            _price_adjusted = price_objective / _N * _cvf;
            
            //2. iterate
            nIter = 0;
            dPrice = 1;
            dVol = 1;
            new_strike = double.NaN;
            while (nIter < MaxIter && dVol > 1e-12 && dPrice > 0.01)
            {
                eps_price_strike = find_strike_CallPutAsiatico_Aux(_price_adjusted);//and replace the strike
                dVol = eps_price_strike[0];
                new_price = _N * _cvf * eps_price_strike[1];//rescaled price
                new_strike = eps_price_strike[2];
                dPrice = Math.Abs(new_price - price_objective);
                nIter++;
            }

            return new_strike;
        }

        public double[] find_strike_CallPutAsiatico_Aux(double _price_adjusted)
        {
            //0. declarations
            double _eps, _new_strike, _new_price;
            bool isBorder;
            double[] price_strike;
            double[] output;

            //1. constants   
            output = new double[3];

            //2. find the strike
            isBorder = find_strike_CallPutAsiatico_isBorderCase(_price_adjusted);
            //a. border case
            if (isBorder)
            {
                price_strike = find_strike_CallPutAsiatico_BorderCase(_price_adjusted);
            } 
            //b. general case
            else//if (!isBorder)
            {
                price_strike = find_strike_CallPutAsiatico_GeneralCase(_price_adjusted);
            }
            _new_price = price_strike[0];
            _new_strike = price_strike[1];

            //3. update the strike and fixing table
            //the strike changes and so do the implied volatilities
            this.Strike = _new_strike;
            _eps = (isBorder) ? 0 : find_strike_CallPutAsiatico_updateFixing();

            //4. store
            output[0] = _eps;
            output[1] = _new_price;
            output[2] = _new_strike;

            return output;

        }

        bool find_strike_CallPutAsiatico_isBorderCase(double _price_adjusted)
        {
            //0. declarations
            int _cpf;
            double _M0, _M1, _M2, _r_dom, _D_dom, _C_max, _B_min;
            List<double> ListM0M1M2;

            //1. constants   
            _cpf = this.Call_Put.Equals("c") ? 1 : -1;

            _r_dom = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, this.Plazos_Fijaciones[Plazos_Fijaciones.Count - 1]).Rate;
            _D_dom = 1 / Math.Pow(1 + 0.01 * _r_dom, _Basis360.TermBasis);
           
            ListM0M1M2 = M0_M1_M2();
            _M0 = ListM0M1M2[0];
            _M1 = ListM0M1M2[1];
            _M2 = ListM0M1M2[2];

            if (_cpf == 1)//call
            {
                _C_max = (_M0 + _M1) * _D_dom;
                _B_min = _M1 * _D_dom;
                if (_price_adjusted < 0 || _price_adjusted > _C_max)
                {
                    return true;
                }
                if (_price_adjusted == 0)
                {
                    return true;
                }
                if (_price_adjusted == _C_max)
                {
                    return true;
                }
                if (_price_adjusted >= _B_min && _price_adjusted <= _C_max)
                {
                    return true;
                }
            }
            if (_cpf == -1)
            {
                if (_price_adjusted < 0)
                {
                    return true;
                }
                if (_price_adjusted == 0)
                {
                    return true;
                }
            }

            return false;
        }

        double[] find_strike_CallPutAsiatico_BorderCase(double _price_adjusted)
        {
            //0. declarations
            int _cpf;
            double _M0, _M1, _M2, _D_dom, _r_dom, _C_max, _B_min, _new_strike, _new_price;
            List<double> ListM0M1M2;
            double[] output;

            //1. constants   
            _cpf = this.Call_Put.Equals("c") ? 1 : -1;

            _r_dom = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, this.Plazos_Fijaciones[Plazos_Fijaciones.Count - 1]).Rate;
            _D_dom = 1 / Math.Pow(1 + 0.01 * _r_dom, _Basis360.TermBasis);

            ListM0M1M2 = M0_M1_M2();
            _M0 = ListM0M1M2[0];
            _M1 = ListM0M1M2[1];
            _M2 = ListM0M1M2[2];

            //2. find the strike
            _new_strike = double.NaN;
            _new_price = double.NaN;
            if (_cpf == 1)//call
            {
                _C_max = (_M0 + _M1) * _D_dom;
                _B_min = _M1 * _D_dom;
                if (_price_adjusted < 0 || _price_adjusted > _C_max)
                {
                    _new_strike = double.NaN;
                    _new_price = double.NaN;
                }
                if (_price_adjusted == 0)
                {
                    _new_strike = double.PositiveInfinity;
                    _new_price = 0;
                }
                if (_price_adjusted == _C_max)
                {
                    _new_strike = 0;
                    _new_price = _C_max;
                }
                if (_price_adjusted >= _B_min && _price_adjusted <= _C_max)
                {
                    _new_strike = (_M0 + _M1 - _price_adjusted) * _D_dom;
                    _new_price = double.NaN;//undefined
                }
            }
            if (_cpf == -1)
            {
                if (_price_adjusted < 0)
                {
                    _new_strike = double.NaN;
                    _new_price = double.NaN;
                }
                if (_price_adjusted == 0)
                {
                    _new_strike = 0;
                    _new_price = 0;
                }
            }


            //3. store
            output = new double[2];
            output[0] = _new_price;
            output[1] = _new_strike;

            return output;
        }

        double[] find_strike_CallPutAsiatico_GeneralCase(double _price_adjusted)
        {
            //0. declarations
            int _nMax, _nIter, _cpf;
            double _eta, _eps, _new_strike, _new_price, _K_left, _K_right, _K_middle, _P_left, _P_right, _P_middle;
            double[] output;

            //1. constants   
            _cpf = this.Call_Put.Equals("c") ? 1 : -1;
            _nMax = 100;
            _eta = 1e-12;

            //2. find upper and lower boundaries for the strike
            //a. init
            _K_left = this.Strike;
            _eps = this.find_strike_CallPutAsiatico_updateFixing();
            _P_left = this.arithmetic_asian_fx_momentos();//standardized price
            _K_right = _K_left;
            _P_right = _P_left;
            _K_middle = _K_left;
            _P_middle = _P_left;
            //b. call
            if (_cpf == 1)
            {
                if (_P_left > _price_adjusted)
                {
                    while (_P_right > _price_adjusted)
                    {
                        _K_right = 2 * _K_right;
                        this.Strike = _K_right;
                        _eps = this.find_strike_CallPutAsiatico_updateFixing();
                        _P_right = this.arithmetic_asian_fx_momentos();
                    }
                }
                else 
                {
                    while (_P_left < _price_adjusted)
                    {
                        _K_left =  _K_left  / 2.0;
                        this.Strike = _K_left;
                        _eps = this.find_strike_CallPutAsiatico_updateFixing();
                        _P_left = this.arithmetic_asian_fx_momentos();
                    }
                }                
            }
            //c. put
            else//if (_cpf == -1)
            {
                if (_P_left < _price_adjusted)
                {
                    while (_P_right < _price_adjusted)
                    {
                        _K_right = 2 * _K_right;
                        this.Strike = _K_right;
                        _eps = this.find_strike_CallPutAsiatico_updateFixing();
                        _P_right = this.arithmetic_asian_fx_momentos();
                    }
                }
                else
                {
                    while (_P_left > _price_adjusted)
                    {
                        _K_left = _K_left / 2.0;
                        this.Strike = _K_left;
                        _eps = this.find_strike_CallPutAsiatico_updateFixing();
                        _P_left = this.arithmetic_asian_fx_momentos();
                    }
                }  
            }

            //2. find the strike
            _K_middle = (_K_left + _K_right) / 2.0;
            _P_middle = (_P_left + _P_right) / 2.0;
            _nIter = 0;
            while (Math.Abs(_P_left - _P_right) > _eta && _nIter<_nMax)
            {
                _K_middle = (_K_left + _K_right) / 2.0;
                this.Strike = _K_middle;
                _eps = this.find_strike_CallPutAsiatico_updateFixing();
                _P_middle = this.arithmetic_asian_fx_momentos();


                if (_cpf == 1)//call
                {
                    if (_P_middle > _price_adjusted)
                    {
                        _K_left = _K_middle;
                        _P_left = _P_middle;
                    }
                    else
                    {
                        _K_right = _K_middle;
                        _P_right = _P_middle;
                    }
                }
                if (_cpf == -1)//put
                {
                    if (_P_middle > _price_adjusted)
                    {
                        _K_right = _K_middle;
                        _P_right = _P_middle;
                    }
                    else
                    {
                        _K_left = _K_middle;
                        _P_left = _P_middle;
                    }
                }

                _nIter++;
            }

            _new_strike = _K_middle;
            _new_price = _P_middle;

            //3. store
            output = new double[2];
            output[0] = _new_price;
            output[1] = _new_strike;

            return output;
        }

        double find_strike_CallPutAsiatico_updateFixing()
        {
            //0. declarations
            double old_vol, new_vol, _eps, _strike;

            //1. constants
            _strike = this.Strike;

            //1. update the  fixing table
            //the strike changed and thus the implied volatilities must change as well
            _eps = 0;
            for (int i = 0; i < Volatilidades.Count; i++)
            {
                if (Volatilidades[i] > 0)
                {
                    old_vol = Volatilidades[i];
                    Volatilidades[i] = Smile.interp_vol(Plazos_Fijaciones[i], _strike, 1, 1);
                    new_vol = Volatilidades[i];
                    _eps = Math.Max(_eps, Math.Abs(new_vol - old_vol));

                }
            }

            return _eps;
        }

        #endregion Solver

        /// <summary>
        /// Función que valoriza una opción asiática
        /// </summary>
        /// <returns>Valor razonable de la opción asiática</returns>
        public double arithmetic_asian_fx_momentos()
        {
            //0. declarations
            int cpf, N, n_fixings, fix_rem;
            double _M0, _M1, _M2, _A, _v2;
            double _f, _k_m, _Df, _d1, _d2, _X;
            List<double> ListM0M1M2;

            //1. constants
            cpf = 1;//call put flag, call by default
            if (Call_Put == "p")
                cpf = -1;

            N = this.Fechas_Fijacion.Count;//total number of fixings

            //2. border case
            if (FechaVal == Fechas_Fijacion[N - 1])
            {
                _M0 = 0;//utilized strike
                for (int i = 0; i < N; i++)
                {
                    _M0 = _M0 + Fijaciones[i] * Pesos_Fijacion[i];
                }
                _X = Math.Max(cpf * (_M0 - Strike), 0);
                return _X;
            }

            //3. general case
            ListM0M1M2 = M0_M1_M2();
            _M0 = ListM0M1M2[0];
            _M1 = ListM0M1M2[1];
            _M2 = ListM0M1M2[2];

            n_fixings = 0;//number of past fixings
            while (n_fixings < N && fecha_val_Delta.CompareTo(Fechas_Fijacion[n_fixings]) >= 0)
                n_fixings++;
            fix_rem = N - n_fixings;//number of future fixings
            _k_m = Strike - _M0;//remaining strike            

            if (_M1 != 0 && _M2 != 0)
            {
                _A = 2 * Math.Log(_M1) - Math.Log(_M2) / 2;//log 'pseudo-forward'
                _v2 = Math.Log(_M2) - 2 * Math.Log(_M1);//remaining variance 
                _f = Math.Exp(_A + _v2 / 2);//equivalent forward, NB: _f = _M1
                _Df = 1 / wf_dom[fix_rem - 1];

                //compute the price
                _X = 0;
                if (_k_m >= 0)
                {
                    _d1 = (_A - Math.Log(_k_m) + _v2) / Math.Sqrt(_v2);
                    _d2 = _d1 - Math.Sqrt(_v2);

                    _X = _Df * cpf * (_f * Function.CND(cpf * _d1) - _k_m * Function.CND(cpf * _d2));
                }
                else
                {
                    _X = _Df * Math.Max(cpf * (_M0 + _M1 - Strike), 0);
                }
            }
            else
            {
                _A = 0;
                _v2 = 0;
                _f = 0;
                _Df = 1;
                _X = _Df * Math.Max(cpf * (_M0 + _M1 - Strike), 0);
            }

            //return
            return _X;

        }

        //public double arithmetic_asian_fx_momentos()
        //{
        //    int N = this.Fechas_Fijacion.Count;
        //    int n_fixings = 0;

        //    while (fecha_val_Delta.CompareTo(Fechas_Fijacion[n_fixings]) >= 0 && n_fixings < N) // VERIFICAR COMPARE TO FECHA_VAL  > FECHAS_FIJACION
        //    {
        //        n_fixings++;
        //    }

        //    if (n_fixings != 0)
        //    {
        //        n_fixings--;
        //    }

        //    int fix_rem = N - n_fixings;

        //    int[] plazo_fixing = new int[fix_rem];
        //    double[] wf = new double[fix_rem];
        //    wf_dom = new double[fix_rem];
        //    wf_for = new double[fix_rem];
        //    double[] vola = new double[fix_rem];
        //    double[] Forward = new double[fix_rem];
        //    double[] bi = new double[fix_rem];
        //    double[] ti = new double[fix_rem];
        //    double[] ei = new double[fix_rem];

        //    int cpf = 1;
        //    if (Call_Put == "c")
        //    {
        //        cpf = 1;
        //    }
        //    else if (Call_Put == "p")
        //    {
        //        cpf = -1;
        //    }

        //    double _RateDom;
        //    double _RateFor;
        //    double _Vol;
        //    cFinancialTools.DayCounters.Basis _Basis360;
        //    cFinancialTools.DayCounters.Basis _Basis365;


        //    //YieldList mYieldList = new YieldList();
        //    //mYieldList.SetPrincingLoading = this.SetPricing;
        //    //mYieldList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
        //    //mYieldList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);


        //    for (int j = 0; j < fix_rem; j++)
        //    {
        //        _Basis360 = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, fecha_val_Delta, Fechas_Fijacion[j + n_fixings]);
        //        _Basis365 = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_365, fecha_val_Delta, Fechas_Fijacion[j + n_fixings]);

        //        plazo_fixing[j] = (int)_Basis360.Term;
        //        wf[j] = _Basis360.TermBasis;


        //        _RateDom = mYieldList.Read(CurvaDom, enumSource.System, FechaVal, plazo_fixing[j]).Rate;
        //        _RateFor = mYieldList.Read(CurvaFor, enumSource.System, FechaVal, plazo_fixing[j]).Rate;

        //        //DeltaRate solo cambia para griega Rho
        //        _RateDom += this.DeltaRateDom;
        //        _RateFor += this.DeltaRateFor;

        //        wf_dom[j] = Math.Pow(1 + 0.01 * _RateDom, _Basis360.TermBasis);
        //        wf_for[j] = Math.Pow(1 + 0.01 * _RateFor, _Basis360.TermBasis);


        //        Forward[j] = Spot * (wf_dom[j] / wf_for[j]);

        //        _Vol = this.Smile.interp_vol(plazo_fixing[j], Forward[j], 1, 1);

        //        vola[j] = 0.01 * _Vol;
        //        bi[j] = Forward[j] * Pesos_Fijacion[j];
        //        ti[j] = _Basis365.TermBasis;
        //        ei[j] = Math.Exp(Math.Pow(vola[j], 2) * ti[j]);
        //    }

        //    double M1 = 0;
        //    double M2 = 0;

        //    for (int i = 0; i < fix_rem; i++)
        //    {
        //        M1 = M1 + bi[i];
        //        M2 = M2 + Math.Pow(bi[i], 2) * ei[i];

        //        for (int j = i + 1; j < fix_rem; j++)
        //        {
        //            M2 = M2 + 2 * bi[i] * bi[j] * ei[i];
        //        }
        //    }
        //    double _A, _v2, _m0;

        //    _A = 2 * Math.Log(M1) - Math.Log(M2) / 2;
        //    _v2 = Math.Log(M2) - 2 * Math.Log(M1);

        //    _m0 = 0;

        //    for (int i = 0; i < n_fixings; i++)
        //    {
        //        _m0 = _m0 + Fijaciones[i] * Pesos_Fijacion[i];
        //    }

        //    double _f, _k_m, _Df, _d1, _d2, _exp_ave;

        //    _f = Math.Exp(_A + _v2 / 2);
        //    _k_m = Strike - _m0;
        //    _Df = 1 / wf_dom[fix_rem - 1];


        //    double ReturnValue;

        //    if (_k_m >= 0)
        //    {
        //        _d1 = (_A - Math.Log(_k_m) + _v2) / Math.Sqrt(_v2);
        //        _d2 = _d1 - Math.Sqrt(_v2);

        //        ReturnValue = _Df * cpf * (_f * Function.CND(cpf * _d1) - _k_m * Function.CND(cpf * _d2));
        //        return ReturnValue;
        //    }
        //    else
        //    {
        //        _exp_ave = _m0 + M1;
        //        ReturnValue = _Df * Math.Max(cpf * (_exp_ave - Strike), 0);
        //        return ReturnValue;
        //    }

        //}

        public string getGriegas()
        {
            string ReturnValue = "";

            double Delta = 0;
            double Gamma = 0;
            double Vega = 0;
            double Vanna = 0;
            double Volga = 0;
            double Theta = 0;
            double Rho = 0;
            double Rhof = 0;
            double Charm = 0;
            double Zomma = 0;
            double Speed = 0;

            if (!this.FechaVal.Equals(this.FechaVcto))
            {
                Delta = delta_arithmetic_asian_fx_momentos();
                Gamma = gamma_arithmetic_asian_fx_momentos();
                Vega = vega_arithmetic_asian_fx_momentos();
                Vanna = vanna_arithmetic_asian_fx_momentos();
                Volga = volga_arithmetic_asian_fx_momentos();
                Theta = theta_arithmetic_asian_fx_momentos();//REVISAR
                Rho = rho_dom_arithmetic_asian_fx_momentos();
                Rhof = rho_for_arithmetic_asian_fx_momentos();
                Charm = charm_arithmetic_asian_fx_momentos();
                Zomma = zomma_arithmetic_asian_fx_momentos();
                Speed = speed_arithmetic_asian_fx_momentos();
            }

            ReturnValue += "<GriegasAsiaticas>\n";
            ReturnValue += "<GriegaData Delta='" + Delta +
                                            "' Gamma='" + Gamma +
                                            "' Vega ='" + Vega +
                                            "' Vanna ='" + Vanna +
                                            "' Volga ='" + Volga +
                                            "' Theta='" + Theta +
                                            "' Rho='" + Rho +
                                            "' Rhof='" + Rhof +
                                            "' Charm='" + Rhof +
                                            "' Zomma='" + Charm +
                                            "' Speed='" + Speed +
                                            "' />";
            ReturnValue += "</GriegasAsiaticas>";

            return ReturnValue;

        }

        #region Calculos Griegas

        private double delta_arithmetic_asian_fx_momentos()
        {
            double _ds = 0.01;
            this.Spot -= _ds;
            double _V1 = arithmetic_asian_fx_momentos();
            this.Spot += (2 * _ds);
            double _V2 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            return (_V2 - _V1) / (2 * _ds);
        }

        private double gamma_arithmetic_asian_fx_momentos()
        {
            double _ds = 0.01;

            double _v0 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            double _v1 = arithmetic_asian_fx_momentos();
            this.Spot += 2 * _ds;
            double _V2 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;

            return (_V2 - 2 * _v0 + _v1) / Math.Pow(_ds, 2);
        }

        private void despl_mat(string matriz, double desp)
        {
            if (matriz == "volas")
            {
                int rows = this.Smile.Volas.Count;
                int columns = this.Smile.Volas[0].Count;
                for (int i = 0; i < rows; i++)
                {
                    for (int j = 0; j < columns; j++)
                    {
                        this.Smile.Volas[i][j] += desp;
                    }
                }
            }
            else if (matriz == "strikes")
            {
                int rows = this.Smile.Strikes.Count;
                int columns = this.Smile.Strikes[0].Count;
                for (int i = 0; i < rows; i++)
                {
                    for (int j = 0; j < columns; j++)
                    {
                        this.Smile.Strikes[i][j] += desp;
                    }
                }

            }


        }

        private double vega_arithmetic_asian_fx_momentos()
        {
            double _dv = 0.0001;


            despl_mat("volas", -100 * _dv);
            double _V1 = arithmetic_asian_fx_momentos();
            //volver 200 ya que se aumento previamente en 100;
            despl_mat("volas", 200 * _dv);
            double _v2 = arithmetic_asian_fx_momentos();

            //Volver al valor original de volas
            despl_mat("volas", -100 * _dv);

            return (_v2 - _V1) / (2 * _dv);
        }

        private double vanna_arithmetic_asian_fx_momentos()
        {
            double _ds = 0.01;
            double _dv = 0.0001;

            this.Spot += _ds;
            despl_mat("volas", 100 * _dv);
            double _V1 = arithmetic_asian_fx_momentos();

            despl_mat("volas", -200 * _dv);
            double _v2 = arithmetic_asian_fx_momentos();

            this.Spot -= 2 * _ds;
            double _v4 = arithmetic_asian_fx_momentos();
            despl_mat("volas", 200 * _dv);
            double _V3 = arithmetic_asian_fx_momentos();

            //volver valores originales
            this.Spot += _ds;
            despl_mat("volas", -100 * _dv);

            return 1 / (4 * _ds * _dv) * (_V1 - _v2 - _V3 + _v4);

        }

        private double volga_arithmetic_asian_fx_momentos()
        {

            double _dv = 0.0001;

            double _V0 = arithmetic_asian_fx_momentos();

            despl_mat("volas", -100 * _dv);
            double _v1 = arithmetic_asian_fx_momentos();
            despl_mat("volas", 200 * _dv);
            double _V2 = arithmetic_asian_fx_momentos();

            //Volver a valores originales
            despl_mat("volas", -100 * _dv);

            return (_V2 - 2 * _V0 + _v1) / _dv;
        }

        /// <summary>
        /// Calcula la Theta (Time-Decay)
        /// </summary>
        /// <returns></returns>
        private double theta_arithmetic_asian_fx_momentos()
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

            double _v0 = arithmetic_asian_fx_momentos();
            double _v1;
            if (_condicion <= 0)
            {
                DateTime aux_fecha_val = new DateTime();
                aux_fecha_val = this.FechaVal;

                this.fecha_val_Delta = this.Fechas_Fijacion[N - 1].AddSeconds(-1.0);
                _v1 = arithmetic_asian_fx_momentos();
                this.fecha_val_Delta = aux_fecha_val;
                return _base * (_v1 - _v0);
            }
            else
            {
                DateTime aux_fecha_val = new DateTime();
                aux_fecha_val = this.FechaVal;

                this.fecha_val_Delta = _fecha_aux;
                _v1 = arithmetic_asian_fx_momentos();
                this.fecha_val_Delta = aux_fecha_val;
                return _base * (_v1 - _v0);
            }
        }

        private double rho_dom_arithmetic_asian_fx_momentos()
        {
            double _dr = 0.01;

            this.DeltaRateDom = -_dr;
            double _V1 = arithmetic_asian_fx_momentos();

            this.DeltaRateDom = _dr;
            double _V2 = arithmetic_asian_fx_momentos();

            // Volver DeltaRateDom a 0
            this.DeltaRateDom = 0;

            return (_V2 - _V1) / (2 * 0.01 * _dr);
        }

        private double rho_for_arithmetic_asian_fx_momentos()
        {
            double _dr = 0.01;

            this.DeltaRateFor = -_dr;
            double _V1 = arithmetic_asian_fx_momentos();

            this.DeltaRateFor = _dr;
            double _V2 = arithmetic_asian_fx_momentos();

            // Volver DeltaRateDom a 0
            this.DeltaRateFor = 0;

            return (_V2 - _V1) / (2 * 0.01 * _dr);
        }

        private double charm_arithmetic_asian_fx_momentos()
        {
            int N = Fechas_Fijacion.Count;
            int _base = 365;

            Calendars calendar = new Calendars();
            calendar.Load();

            DateTime _fecha_aux1 = new DateTime();
            _fecha_aux1 = calendar.NextHolidayDate(6, this.FechaVal);//BussDay(fecha_val + 1)

            //Basis _Basis1 = new Basis(enumBasis.Basis_30E_365,this.fecha_val, _fecha_aux1);
            //Basis _Basis2 = new Basis(enumBasis.Basis_30E_365,this.fecha_val, this.fechas_fijacion[N-1]);
            Basis _Basis1 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, _fecha_aux1);
            Basis _Basis2 = new Basis(enumBasis.Basis_Act_365, _fecha_aux1, this.Fechas_Fijacion[N - 1]);


            double _ds = 0.01;
            double _dt = _Basis1.TermBasis;

            double condicion = _Basis2.TermBasis;

            double _V0 = arithmetic_asian_fx_momentos();

            DateTime temp_fecha_val = new DateTime();
            temp_fecha_val = this.FechaVal;
            double _V1, _V2, _V3, _V4;
            if (condicion <= 0)
            {


                this.Spot += _ds;
                _V1 = arithmetic_asian_fx_momentos();
                this.Spot -= 2 * _ds;
                _V2 = arithmetic_asian_fx_momentos();

                this.fecha_val_Delta = Fechas_Fijacion[N - 1].AddSeconds(-1.0);
                this.Spot += 2 * _ds;
                _V3 = arithmetic_asian_fx_momentos();
                this.Spot -= 2 * _ds;
                _V4 = arithmetic_asian_fx_momentos();

                //volver spot
                this.Spot += _ds;

            }
            else
            {
                this.Spot += _ds;
                _V1 = arithmetic_asian_fx_momentos();
                this.Spot -= 2 * _ds;
                _V2 = arithmetic_asian_fx_momentos();

                this.fecha_val_Delta = _fecha_aux1;
                this.Spot += 2 * _ds;
                _V3 = arithmetic_asian_fx_momentos();
                this.Spot -= 2 * _ds;
                _V4 = arithmetic_asian_fx_momentos();

                //volver spot
                this.Spot += _ds;

            }


            //volver fecha_val_Delta
            this.fecha_val_Delta = temp_fecha_val;

            return _base * (_V3 - _V4 - _V1 + _V2) / (2 * _ds);
        }

        private double zomma_arithmetic_asian_fx_momentos()
        {
            double _ds = 0.01;
            double _dv = 0.0001;

            despl_mat("volas", 100 * _dv);
            this.Spot += _ds;
            double _V1 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            double _V2 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            double _V3 = arithmetic_asian_fx_momentos();


            despl_mat("volas", -200 * _dv);
            this.Spot += 2 * _ds;
            double _V4 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            double _V5 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            double _V6 = arithmetic_asian_fx_momentos();

            //volver volas y spot
            this.Spot += _ds;
            despl_mat("volas", 100 * _dv);

            return (_V1 - 2 * _V2 + _V3 - _V4 + 2 * _V5 - _V6) / (2 * 0.0001 * Math.Pow(_ds, 2));
        }

        private double speed_arithmetic_asian_fx_momentos()
        {
            double _ds = 0.01;
            double _V0 = arithmetic_asian_fx_momentos();
            this.Spot -= _ds;
            double _V1 = arithmetic_asian_fx_momentos();
            this.Spot += (2 * _ds);
            double _V2 = arithmetic_asian_fx_momentos();
            this.Spot += _ds;
            double _V3 = arithmetic_asian_fx_momentos();

            //volver spot
            this.Spot -= 2 * _ds;


            return (1 / Math.Pow(_ds, 3)) * (_V3 - (3 * _V2) + ((3 * _V0) - _V1));
        }

        public double GetScaledArithmetic_asian_fx_momentos()
        {
            double returnValue = this.arithmetic_asian_fx_momentos();

            int c_v = 1;


            if (this.Compra_Venta == "venta")
            {
                c_v = -1;
            }

            returnValue = this.Nocional * c_v * returnValue;
            return returnValue;
        }

        #endregion Cálculos Griegas

        /// <summary>
        /// Genera XML con griegas
        /// </summary>
        /// <returns></returns>
        public string GetScaledGriegas()
        {

            string ReturnValue = "";
            double _Delta = delta_arithmetic_asian_fx_momentos();
            double _Gamma = gamma_arithmetic_asian_fx_momentos();
            double _Vega = vega_arithmetic_asian_fx_momentos();
            double _Vanna = vanna_arithmetic_asian_fx_momentos();
            double _Volga = volga_arithmetic_asian_fx_momentos();
            double _Theta = theta_arithmetic_asian_fx_momentos();
            double _Rho = rho_dom_arithmetic_asian_fx_momentos();
            double _Rhof = rho_for_arithmetic_asian_fx_momentos();
            double _Charm = charm_arithmetic_asian_fx_momentos();
            //double _Zomma = zomma_arithmetic_asian_fx_momentos();
            //double _Speed = speed_arithmetic_asian_fx_momentos();

            #region Control NaN
            double Delta = _Delta.Equals(double.NaN) ? 0 : _Delta;
            double Gamma = _Gamma.Equals(double.NaN) ? 0 : _Gamma;
            double Vega = _Vega.Equals(double.NaN) ? 0 : _Vega;
            double Vanna = _Vanna.Equals(double.NaN) ? 0 : _Vanna;
            double Volga = _Volga.Equals(double.NaN) ? 0 : _Volga;
            double Theta = _Theta.Equals(double.NaN) ? 0 : _Theta;
            double Rho = _Rho.Equals(double.NaN) ? 0 : _Rho;
            double Rhof = _Rhof.Equals(double.NaN) ? 0 : _Rhof;
            double Charm = _Charm.Equals(double.NaN) ? 0 : _Charm;
            //double Zomma = _Zomma.Equals(double.NaN) ? 0 : _Zomma;
            //double Speed = _Speed.Equals(double.NaN) ? 0 : _Speed;
            #endregion Control NaN

            int c_v = 1;

            if (Compra_Venta == "venta")
            {
                c_v = -1;
            }

            Delta = Nocional * c_v * Delta;
            Gamma = Nocional * c_v * Gamma;
            Vega = Math.Pow(0.01, 2) * Nocional * c_v * Vega;
            Rho = Math.Pow(0.01, 2) * Nocional * c_v * Rho;
            Rhof = Math.Pow(0.01, 2) * Nocional * c_v * Rhof;
            Theta = (1.0 / 365) * Nocional * c_v * Theta;
            Charm = (1.0 / 365) * Nocional * c_v * Charm;
            Vanna = Math.Pow(0.01, 2) * Nocional * c_v * Vanna;
            Volga = Math.Pow(0.01, 2) * Nocional * c_v * Volga;
            //Zomma = 0.01 * Nocional * c_v * Zomma;
            //Speed = Nocional * c_v * Speed;

            ReturnValue += "<GriegasAsiaticas>\n";

            ReturnValue += "<GriegaData  DeltaSpot='" + Delta.ToString() + "' " +
                          "Gamma='" + Gamma.ToString() + "' " +
                          "Vega='" + Vega.ToString() + "' " +
                          "RhoDom='" + Rho.ToString() + "' " +
                          "RhoFor='" + Rhof.ToString() + "' " +
                          "Theta='" + Theta.ToString() + "' " +
                          "Charm='" + Charm.ToString() + "' " +
                          "Vanna='" + Vanna.ToString() + "' " +
                          "Volga='" + Volga.ToString() + "' />";
            //"Zomma='" + Zomma.ToString() + "' " +
            //"Speed='" + Speed.ToString() + "' />\n";

            ReturnValue += "</GriegasAsiaticas>";

            return ReturnValue;
        }
    }
}
