using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using cFinancialTools.Yield;
using cFinancialTools.DayCounters;
using cFinancialTools.BussineDate;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using AdminOpcionesTool.Opciones.SmileNameSpace;
using AdminOpcionesTool.Opciones.Functions;

namespace AdminOpcionesTool.Opciones.Payoffs
{
    public class Vanilla
    {
        public Smile Smile;
        public string Paridad;
        public string Call_Put;
        public string Compra_Venta;
        public double Nocional;
        public double Spot;
        public double Puntos;
        public double Strike;
        public DateTime FechaVal;
        public DateTime FechaVcto;
        public DateTime FechaSetDePrecios {get;set;}
        public string CurvaDom;
        public string CurvaFor;
        public bool SmileLoaded;
        public YieldList mYieldList;

        public int Plazo_Dias;//PRD_12567 era private, se cambia para debug.

        public double wf_dom { get; set; }//PRD_12567 era private, se cambia para debug.
        public double wf_for { get; set; }//PRD_12567 era private, se cambia para debug.

        public double r_dom { get; set; }
        public double r_for { get; set; }

        public Basis _Basis360;//PRD_12567 era private, se cambia para debug.
        public Basis _Basis365;//PRD_12567 era private, se cambia para debug.

        private double sig;

        public enumSetPrincingLoading SetPricing { get; set; }
        //public string BsSpot_BsFwd_flag="";

        public int call_put_flag;

        //Debug LogDebug = new Debug("Valoriza");//PRD_12567 para debug

        public Vanilla(YieldList CurvaList, Smile smile, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double puntos, double strike, DateTime fecha_val, DateTime fecha_vencimiento, DateTime fechaSetDePrecios, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, string BsSpot_BsFwd)
        {
            this.FechaVcto = fecha_vencimiento;
            this.FechaSetDePrecios = fechaSetDePrecios;

            this.Paridad = paridad;
            this.Call_Put = call_put_flag;
            this.Compra_Venta = compraVenta;
            this.Nocional = nocional;
            this.Spot = spot;
            this.Puntos = puntos;
            this.Strike = strike;
            this.FechaVal = fecha_val;

            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.Smile = smile;
            SmileLoaded = true;

            this.SetPricing = setPricing;

            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);
            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);

            mYieldList = CurvaList;

            //PRD_12567
            //ASVG_20130228 desgloce del cálculo para comparar con Fwd Asiático
            double alan_Rate = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate;

            wf_dom = Math.Pow((1 + 0.01 * alan_Rate), _Basis360.TermBasis);
            
            wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);
            r_dom = _Basis365.Term.Equals(0) ? 0 : (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaFor, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);
                r_for = _Basis365.Term.Equals(0) ? 0 : (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);
            }
            else
            {
                r_for = _Basis365.Term.Equals(0) ? 0 : r_dom + 1 / _Basis365.TermBasis * Math.Log(spot / (spot + puntos));
                wf_for = Math.Exp(-r_for * _Basis365.TermBasis);//in case
            }

            sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

            Plazo_Dias = (int)_Basis365.Term;

            //LogDebug.LogVanilla(this);//PRD_12567 para debug
        }

        public Vanilla(YieldList CurvaList ,Smile smile, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double puntos, double strike, DateTime fecha_val, DateTime fecha_vencimiento , DateTime fechaSetDePrecios,string curvaDom, string curvaFor, enumSetPrincingLoading setPricing)
        {
            this.FechaVcto = fecha_vencimiento;
            this.FechaSetDePrecios = fechaSetDePrecios;

            this.Paridad = paridad;
            this.Call_Put = call_put_flag;
            this.Compra_Venta = compraVenta;
            this.Nocional = nocional;
            this.Spot= spot;
            this.Puntos = puntos;
            this.Strike = strike;
            this.FechaVal = fecha_val;
            
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.Smile = smile;
            SmileLoaded = true;

            this.SetPricing = setPricing;

            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);
            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);

            mYieldList = CurvaList;

            double Term = _Basis360.TermBasis;
            double TasaDomestica = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate;
            double TasaForanea   = mYieldList.Read(CurvaFor, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate;

            wf_dom = Math.Pow((1 + 0.01 * TasaDomestica), Term);
            wf_for = Math.Pow((1 + 0.01 * TasaForanea), Term);

            r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

            Plazo_Dias = (int)_Basis365.Term;

            //LogDebug.LogVanilla(this);//PRD_12567 para debug
        }

        public Vanilla(YieldList CurvaList, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double puntos, double strike, DateTime fecha_val, DateTime fecha_vencimiento, DateTime fechaSetdePrecios, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, int flag_smile_0_1)
        {
            this.Paridad = paridad;
            this.Call_Put = call_put_flag;
            this.Compra_Venta = compraVenta;
            this.Nocional = nocional;
            this.Spot = spot;
            this.Puntos = puntos;
            this.Strike = strike;
            this.FechaVal = fecha_val;
            this.FechaVcto = fecha_vencimiento;
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.FechaSetDePrecios = fechaSetdePrecios;

            this.Smile = new Smile(FechaSetDePrecios, paridad, spot, curvaDom, curvaFor, flag_smile_0_1);
            try
            {
                Smile.Load(setPricing);
                SmileLoaded = true;
            }
            catch 
            {
                SmileLoaded = false;
            }

            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);
            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);

            mYieldList = CurvaList;

            wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaFor, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike,1, 1);

            Plazo_Dias = (int)_Basis365.Term;

            //LogDebug.LogVanilla(this);//PRD_12567 para debug
        }

        public Vanilla(YieldList CurvaList, string paridad, string call_put_flag, string compraVenta, double nocional, double spot, double puntos, double strike, DateTime fecha_val, DateTime fecha_vencimiento, DateTime fechaSetdePrecios, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, int flag_smile_0_1, string BsSpot_BsFwd)
        {
            this.Paridad = paridad;
            this.Call_Put = call_put_flag;
            this.Compra_Venta = compraVenta;
            this.Nocional = nocional;
            this.Spot = spot;
            this.Puntos = puntos;
            this.Strike = strike;
            this.FechaVal = fecha_val;
            this.FechaVcto = fecha_vencimiento;
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.FechaSetDePrecios = fechaSetdePrecios;

            int town = 6;


            this.Smile = new Smile(FechaSetDePrecios, paridad, spot, curvaDom, curvaFor, flag_smile_0_1);
            try
            {
                Smile.Load(setPricing);
                SmileLoaded = true;
            }
            catch
            {
                SmileLoaded = false;
            }



            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);
            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);


            mYieldList = CurvaList;

            wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);
            r_dom = _Basis365.Term.Equals(0) ? 0 : (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaFor, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);
                r_for = _Basis365.Term.Equals(0) ? 0 : (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);
            }
            else
            {
                r_for = _Basis365.Term.Equals(0) ? 0 : r_dom + 1 / _Basis365.TermBasis * Math.Log(spot / (spot + puntos));
                wf_for = Math.Exp(-r_for * _Basis365.TermBasis);//in case
            }

            sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

            Plazo_Dias = (int)_Basis365.Term;

            //LogDebug.LogVanilla(this);//PRD_12567 para debug
        }

        public Vanilla(int call_put_flag, string compra_venta , double spot, double strike, int T ,double R_Dom, double R_For, double Sig)
        {
            this.Spot = spot;            
            this.Strike = strike;
            r_dom = R_Dom;
            r_for = R_For;
            sig = Sig;
            this.call_put_flag = call_put_flag;
            this.Call_Put = call_put_flag == 1 ? "c" : "p";
            this.Compra_Venta = compra_venta;

            Plazo_Dias = T;

            _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, FechaVcto);
            _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, FechaVcto);

            //LogDebug.LogVanilla(this);//PRD_12567 para debug
        }
        
        public double CallBsSpotFunc()
        {
            //declarations
            double _T, _d1, _d2, _sig_sqT, _D_dom, _D_for, _X;
            
            //constants
            _T = this.Plazo_Dias / 365.0;//time to maturity in years
            _sig_sqT = sig * Math.Sqrt(_T);
            _D_dom = Math.Exp(-r_dom * _T);
            _D_for = Math.Exp(-r_for * _T);

            //border cases
            if (Strike < 0)
                return double.NaN;
            if (Strike == double.PositiveInfinity)
                return 0;
            if (_T <= 0)
                return Math.Max(Spot - Strike, 0);
            
            //general case
            _d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * sig * sig) * _T) / _sig_sqT;
            _d2 = _d1 - _sig_sqT;
            _X = Spot * _D_for * Function.CND(_d1) - Strike * _D_dom * Function.CND(_d2);
            return _X;
        }

        public double PutBsSpotFunc()
        { 
            //declarations
            double _T, _d1, _d2, _sig_sqT, _D_dom, _D_for, _X;
            
            //constants
            _T = this.Plazo_Dias / 365.0;//time to maturity in years
            _sig_sqT = sig * Math.Sqrt(_T);
            _D_dom = Math.Exp(-r_dom * _T);
            _D_for = Math.Exp(-r_for * _T);

            //border cases
            if (Strike < 0)
                return double.NaN;
            if (Strike == double.PositiveInfinity)
                return double.PositiveInfinity;
            if (_T<= 0)
                return Math.Max(Strike - Spot, 0);
            
            //general case
            _d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * sig * sig) * _T) / _sig_sqT;
            _d2 = _d1 - _sig_sqT;
            _X = Strike * _D_dom * Function.CND(-_d2) - Spot * _D_for * Function.CND(-_d1);
            return _X;
           /*
            if (_Basis365.Term <= 0)
            {
                return Math.Max(Strike - Spot, 0);

            }
            else
            {
               
                double d1, d2;

                d1 = (Math.Log(this.Spot / this.Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

                d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));

                double returnValue;

                returnValue = this.Strike * Math.Exp(-r_dom * (_Basis365.Term / 365.0)) * Function.CND(-d2) - Spot * Math.Exp(-r_for * (_Basis365.Term / 365.0)) * Function.CND(-d1);

                return returnValue;
            }
            */
        }

        public double BS_Spot()
        {
            if (Call_Put == "c")
            {
                return CallBsSpotFunc();

            }
            else if (Call_Put == "p")
            {
                return PutBsSpotFunc();
            }
            return 0;
        }
        
        public string Opcion(int numComponente_Estruc, string Estruct_Indiv, string BsSpot_BsFwd)
        {     

            double _MtM = this.GetScaled_BSSpot_BSFwd_(BsSpot_BsFwd);

            string _ScaledGriegas = this.GetScaledGriegas();

            double _vol = Smile.interp_vol(this.Plazo_Dias, Strike, 1, 1);
            double fowd_teo = 0;

            if (BsSpot_BsFwd.Equals("BsFwd"))
            {
                fowd_teo = this.Spot + this.Puntos;
            }
            else
            {
                fowd_teo = Function.Forward(this.FechaVal, this.FechaVcto, this.FechaSetDePrecios, this.Spot, CurvaDom, CurvaFor, this.mYieldList);
            }
            
            XDocument _geiegasXML = new XDocument(XDocument.Parse(_ScaledGriegas));


            var griegasVanillaVar = from itemGriega in _geiegasXML.Descendants("GriegaData")
                                    select new StructGriegas
                                    {
                                        DeltaSpot = double.Parse(itemGriega.Attribute("DeltaSpot").Value.ToString()),
                                        DeltaForward = double.Parse(itemGriega.Attribute("DeltaFwd").Value.ToString()),
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


            string TipoEmisionPT = this.Compra_Venta == "compra" ? "T" : "P";
            string Call_Put = this.Call_Put == "c" ? "Call" : "Put";
            string Compra_Venta = this.Compra_Venta == "compra" ? "C" : "V";

            string detContrato = "<Opcion>\n";
            //--------------------
            detContrato += "<detContrato>\n";
            detContrato += "<Estructura MoNumFolio='' MoNumEstructura='" + numComponente_Estruc + "' MoVinculacion='" + Estruct_Indiv + "' />\n";
            detContrato += "<DetallesOpcion MoTipoOpc='V' MoSubyacente='FX' MoTipoPayOff='01' MoCallPut='" + Call_Put + "' MoCVOpc='" + Compra_Venta + "' MoTipoEmisionPT='" + TipoEmisionPT + "' MoFechaInicioOpc='" + this.FechaVal.ToString("dd-MM-yyyy") + "' MoFechaFijacion='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' />\n";
            detContrato += "<Vencimiento MoFechaVcto='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' />\n";
            detContrato += "<Subyacente MoFormaPagoMon1='' MoFechaPagMon1='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' MoFormaPagoMon2='' MoFechaPagMon2='" + this.FechaVcto.ToString("dd-MM-yyyy") + "' MoFechaPagoEjer='" + this.FechaVcto.ToString("dd-MM-yyy") + "' MoCodMon1='' MoMontoMon1='" + this.Nocional + "' MoCodMon2='' MoMontoMon2='" + this.Nocional * this.Strike + "' MoModalidad='' MoMdaCompensacion='' MoFormaPagoComp='' MoBenchComp='994' MoParStrike='" + this.Paridad + "' MoStrike='" + this.Strike + "' MoPorcStrike='' MoTipoEjercicio='E' />\n";
            detContrato += "<Proceso MoSpotDet='" + this.Spot + "' />\n";
            detContrato += "<Curvas MoCurveMon1='" + this.CurvaDom + "' MoCurveMon2='" + this.CurvaFor + "' MoCurveSmile='' />\n";
            detContrato += "<MtM MoWf_mon1='" + this.wf_dom + "' MoWf_mon2='" + this.wf_for + "' MoVol='" + _vol + "' MoFwd_teo='" + fowd_teo + "'  MoVrDet='" + _MtM + "' MoSpotDetCosto='' MoWf_Mon1_Costo='' MoWf_Mon2_Costo='' MoVol_Costo='' MoFwd_Teo_Costo='' MoVr_Costo='' MoVr_CostoDet='' MoPrimaBSSpotDet='' MoIteAsoSis='' MoIteAsoCon='' />\n";
            detContrato += "<Griegas MoDelta_spot='" + Griegas.DeltaSpot + "' MoDelta_spot_num='' MoDelta_fwd='" + Griegas.DeltaForward + "' MoDelta_fwd_num='' MoGamma_spot='" + Griegas.Gamma + "' MoGamma_spot_num='' MoGamma_fwd='' MoGamma_fwd_num='' MoVega='" + Griegas.Vega + "' MoVega_num='' MoVanna_spot='" + Griegas.Vanna + "' MoVanna_spot_num='' MoVanna_fwd='' MoVanna_fwd_num='' MoVolga='" + Griegas.Volga + "' MoVolga_num='' MoTheta='" + Griegas.Theta + "' MoTheta_num='' MoRho='" + Griegas.RhoDom + "' MoRho_num='' MoRhof='" + Griegas.RhoFor + "' MoRhof_num='' MoCharm_spot='" + Griegas.Charm + "' MoCharm_spot_num='' MoCharm_fwd='' MoCharm_fwd_num=''  />";
            detContrato += "</detContrato>\n";
            //--------------------
            detContrato += "<GriegasMonto Delta='" + Griegas.DeltaSpot + "' DeltaForward='" + Griegas.DeltaForward + "'  Gamma='" + Griegas.Gamma + "' Vega='" + Griegas.Vega + "' Vanna='" + Griegas.Vanna + "' Volga='" + Griegas.Volga + "' Theta='" + Griegas.Theta + "' Rho='" + Griegas.RhoDom + "' Rhof='" + Griegas.RhoFor + "' Charm='" + Griegas.Charm + "'  />\n";
            detContrato += "</Opcion>";
            return detContrato;

        }
       
        public double GetScaled_BSSpot_BSFwd_(string BsSpot_BsFwd)
        {

            int c_v = 1;
            double returnValue;

            if (BsSpot_BsFwd.Equals("BsSpot"))
            {
                returnValue = BS_Spot();
            }
            else // BsFwd
            {
                returnValue = BS_fwd((this.Spot + this.Puntos));
            }

            if (this.Compra_Venta == "venta")
            {
                c_v = -1;
            }

            returnValue = this.Nocional * c_v * returnValue;

            return returnValue;
        }

        public string GetGriegas()
        {

            double forward = Function.Forward(this.FechaVal, this.FechaVcto, this.FechaSetDePrecios, this.Spot, CurvaDom, CurvaFor, this.mYieldList);

            double DeltaSpot = BS_Spot_Delta();
            double DeltaForward = BS_Fwd_Delta(forward);
            double Gamma = BS_Spot_Gamma();
            double Vega = BS_Spot_Vega();
            double RhoDom = BS_Spot_Rho();
            double RhoFor = BS_Spot_Rhof();
            double Theta = BS_Spot_Theta();
            double Charm = BS_Spot_Charm();
            double Vanna = BS_Spot_Vanna();
            double Volga = BS_Spot_Volga();
            double Zomma = BS_Spot_Zomma();
            double Speed = BS_Spot_Speed();

            string returnValue = "<GriegasVanilla>\n";

            returnValue += "<GriegaData DeltaSpot='" + DeltaSpot.ToString() + "' " +
                           "DeltaFwd='" + DeltaForward.ToString() + "' " +
                           "Gamma='" + Gamma.ToString() + "' " +
                           "Vega='" + Vega.ToString() + "' " +
                           "RhoDom='" + RhoDom.ToString() + "' " +
                           "RhoFor='" + RhoFor.ToString() + "' " +
                           "Theta='" + Theta.ToString() + "' " +
                           "Charm='" + Charm.ToString() + "' " +
                           "Vanna='" + Vanna.ToString() + "' " +
                           "Volga='" + Volga.ToString() + "' " +
                           "Zomma='" + Zomma.ToString() + "' " +
                           "Speed='" + Speed.ToString() + "' />\n";

            returnValue += "</GriegasVanilla>";

            return returnValue;
        }

        public string GetScaledGriegas()
        {
            double _forward = 0;
            double _DeltaSpot = 0;
            double _DeltaForward = 0;
            double _Gamma = 0;
            double _Vega = 0;
            double _RhoDom = 0;
            double _RhoFor = 0;
            double _Theta = 0;
            double _Charm = 0;
            double _Vanna = 0;
            double _Volga = 0;
            double _Zomma = 0;
            double _Speed = 0;

            if (!this.FechaVal.Equals(this.FechaVcto))
            {
                _forward = Function.Forward(this.FechaVal, this.FechaVcto, FechaSetDePrecios, this.Spot, this.CurvaDom, this.CurvaFor, this.mYieldList);
                _DeltaSpot = BS_Spot_Delta();
                _DeltaForward = BS_Fwd_Delta(_forward);
                _Gamma = BS_Spot_Gamma();
                _Vega = BS_Spot_Vega();
                _RhoDom = BS_Spot_Rho();
                _RhoFor = BS_Spot_Rhof();
                _Theta = BS_Spot_Theta();
                _Charm = BS_Spot_Charm();
                _Vanna = BS_Spot_Vanna();
                _Volga = BS_Spot_Volga();
                _Zomma = BS_Spot_Zomma();
                _Speed = BS_Spot_Speed();
            }

            int c_v = 1;

            if (this.Compra_Venta == "venta")
            {
                c_v = -1;
            }

            _DeltaSpot = Nocional * c_v * _DeltaSpot;
            _DeltaForward = Nocional * c_v * _DeltaForward;
            _Gamma = Nocional * c_v * _Gamma;
            _Vega = Math.Pow(0.01, 2) * Nocional * c_v * _Vega;
            _RhoDom = Math.Pow(0.01, 2) * Nocional * c_v * _RhoDom;
            _RhoFor = Math.Pow(0.01, 2) * Nocional * c_v * _RhoFor;
            _Theta = (1.0 / 365) * Nocional * c_v * _Theta;
            _Charm = (1.0 / 365) * Nocional * c_v * _Charm;
            _Vanna = Math.Pow(0.01, 2) * Nocional * c_v * _Vanna;
            _Volga = Math.Pow(0.01, 2) * Nocional * c_v * _Volga;
            _Zomma = 0.01 * Nocional * c_v * _Zomma;
            _Speed = Nocional * c_v * _Speed;

            string returnValue = "<GriegasVanilla>\n";

            returnValue += "<GriegaData DeltaSpot='" + _DeltaSpot.ToString() + "' " +
                           "DeltaFwd='" + _DeltaForward.ToString() + "' " +
                           "Gamma='" + _Gamma.ToString() + "' " +
                           "Vega='" + _Vega.ToString() + "' " +
                           "RhoDom='" + _RhoDom.ToString() + "' " +
                           "RhoFor='" + _RhoFor.ToString() + "' " +
                           "Theta='" + _Theta.ToString() + "' " +
                           "Charm='" + _Charm.ToString() + "' " +
                           "Vanna='" + _Vanna.ToString() + "' " +
                           "Volga='" + _Volga.ToString() + "' " +
                           "Zomma='" + _Zomma.ToString() + "' " +
                           "Speed='" + _Speed.ToString() + "' />\n";

            returnValue += "</GriegasVanilla>";

            return returnValue;
        }

        public double BS_Spot_Delta()
        {
            if (Call_Put == "c")
            {
                return DeltaCallBS_Spot();
            }
            else if (Call_Put == "p")
            {
                return DeltaPutBS_Spot();
            }
            return 0;
        }

        private double DeltaCallBS_Spot()
        {
            #region DeltaCallBS_Spot 2010
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);


            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);
            #endregion DeltaCallBS_Spot 2010

            double d1;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            double returnValue = Function.CND(d1) * Math.Exp(-r_for * (_Basis365.Term / 365.0));
            return returnValue;
        }

        private double DeltaPutBS_Spot()
        {
            #region DeltaPutBS_Spot 2010
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);


            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);
            #endregion DeltaPutBS_Spot 2010

            double d1;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            double returnValue = -Function.CND(-d1) * Math.Exp(-r_for * (_Basis365.Term / 365.0));
            return returnValue;
        }

        public double BS_Spot_Gamma()
        {
            return GammaBS_Spot();
        }

        private double GammaBS_Spot()
        {
            

            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, N_d1; ;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));

            double returnValue;

            returnValue = N_d1 * Math.Exp(-r_for * (_Basis365.Term / 365.0)) / (Spot * sig * Math.Sqrt((_Basis365.Term / 365.0)));

            return returnValue;
        }

        public double BS_Spot_Vega()
        {

            return VegaBS_Spot();
        }

        private double VegaBS_Spot()
        {         

            YieldList mYieldList = new YieldList();

            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, N_d1; ;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));


            double returnValue;

            returnValue = Spot * Math.Sqrt((_Basis365.Term / 365.0)) * N_d1 * Math.Exp(-r_for * (_Basis365.Term / 365.0));

            return returnValue;
        }

        public double BS_Spot_Vanna()
        {

            return VannaBS_Spot();
        }

        private double VannaBS_Spot()
        {          
            //declaration
            double d1, d2, N_d1, _vanna;

            //exception
            if (Strike == double.PositiveInfinity)
                return 0;

            //constants
            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));
            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));
            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));

            //vanna
            _vanna = -Math.Exp((-r_for) * (_Basis365.Term / 365.0)) * d2 / sig * N_d1;

            return _vanna;

        }

        public double BS_Spot_Volga()
        {

            return VolgaBS_Spot();
        }

        private double VolgaBS_Spot()
        {           
            //declaration
            double d1, d2, _vega, _volga;

            //exception
            if (Strike == double.PositiveInfinity)
                return 0;

            //constants
            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));
            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));
            _vega = VegaBS_Spot();

            //volga
            _volga = (1.0 / 10000) * _vega * d1 * d2 / sig;

            return _volga;
        }

        public double BS_Spot_Theta()
        {
            if (this.Call_Put == "c")
            {
                return ThetaCallBS_Spot();
            }
            else if (this.Call_Put == "p")
            {
                return ThetaPutBS_Spot();
            }
            return 0;
        }

        private double ThetaCallBS_Spot()
        {
            //declaration
            double d1, d2, N_d1, _theta;

            //exception
            if (Strike == double.PositiveInfinity)
                return 0;

            //constants
            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));
            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));
            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));

            //theta
            _theta = (-Spot * N_d1 * sig * Math.Exp(-r_for * (_Basis365.Term / 365.0))) / (2 * Math.Sqrt((_Basis365.Term / 365.0))) + r_for * Spot * Function.CND(d1) * Math.Exp(-r_for * (_Basis365.Term / 365.0)) - r_dom * Strike * Math.Exp(-r_dom * (_Basis365.Term / 365.0)) * Function.CND(d2);

            return _theta;


            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);
        }

        private double ThetaPutBS_Spot()
        {       

            YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2, N_d1; ;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));

            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));


            double returnValue = (-Spot * N_d1 * sig * Math.Exp(-r_for * (_Basis365.Term / 365.0))) / (2 * Math.Sqrt((_Basis365.Term / 365.0))) - r_for * Spot * Function.CND(-d1) * Math.Exp(-r_for * (_Basis365.Term / 365.0)) + r_dom * Strike * Math.Exp(-r_dom * (_Basis365.Term / 365.0)) * Function.CND(-d2);

            return returnValue;
        }

        public double BS_Spot_Rho()
        {
            if (Call_Put == "c")
            {
                return RhoCallBS_Spot();
            }
            else if (Call_Put == "p")
            {
                return RhoPutBS_Spot();
            }
            return 0;
        }

        private double RhoCallBS_Spot()
        {
            //decleration
            double _d1, _d2, _rho;

            //exception
            if (Strike == double.PositiveInfinity)
                return 0;

            //constants
            _d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));
            _d2 = _d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));

            //rho
            _rho = Strike * (_Basis365.Term / 365.0) * Math.Exp(-r_dom * (_Basis365.Term / 365.0)) * Function.CND(_d2);

            return _rho;

            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);
        }

        private double RhoPutBS_Spot()
        {
     
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));


            double returnValue = -Strike * (_Basis365.Term / 365.0) * Math.Exp(-r_dom * (_Basis365.Term / 365.0)) * Function.CND(-d2);

            return returnValue;
        }

        public double BS_Spot_Rhof()
        {
            if (Call_Put == "c")
            {
                return RhofCallBS_Spot();
            }
            else if (Call_Put == "p")
            {
                return RhofPutBS_Spot();
            }
            return 0;
        }

        private double RhofCallBS_Spot()
        {
           //YieldList mYieldList = new YieldList();
           // mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
           // mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
           // Basis _Basis360;
           // Basis _Basis365;
           // int int_strike = 1;
           // int int_time = 1;

           // double r_dom, r_for;

           // double sig;

           // _Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
           // _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

           // wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

           // wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

           // r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
           // r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

           // sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));


            double returnValue = -(_Basis365.Term / 365.0) * Math.Exp(-r_for * (_Basis365.Term / 365.0)) * Spot * Function.CND(d1);

            return returnValue;
        }

        private double RhofPutBS_Spot()
        {
           
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));


            double returnValue = (_Basis365.Term / 365.0) * Math.Exp(-r_for * (_Basis365.Term / 365.0)) * Spot * Function.CND(-d1);

            return returnValue;
        }

        public double BS_Spot_Charm()
        {
            if (Call_Put == "c")
            {
                return CharmCallBS_Spot();
            }
            else if (Call_Put == "p")
            {
                return CharmPutBS_Spot();
            }
            return 0;
        }

        private double CharmCallBS_Spot()
        {
            //declaration
            double d1, d2, N_d1, _charm;

            //exception
            if (Strike == double.PositiveInfinity)
                return 0;

            //constants
            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));
            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));
            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));

            //charm
            _charm = -Math.Exp((-r_for) * (_Basis365.Term / 365.0)) * (N_d1 * ((r_dom - r_for) / (sig * Math.Sqrt((_Basis365.Term / 365.0))) - d2 / (2 * (_Basis365.Term / 365.0))) + (-r_for) * Function.CND(d1));

            return _charm;
        }

        private double CharmPutBS_Spot()
        {          

            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2, N_d1; ;

            d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));

            N_d1 = 1 / Math.Sqrt(2 * Math.PI) * Math.Exp(-0.5 * Math.Pow(d1, 2));


            double returnValue = -Math.Exp((r_for) * (_Basis365.Term / 365.0)) * (N_d1 * ((r_dom - r_for) / (sig * Math.Sqrt((_Basis365.Term / 365.0))) - d2 / (2 * (_Basis365.Term / 365.0))) - (-r_for) * Function.CND(-d1));

            return returnValue;
        }

        public double BS_Spot_Zomma()
        {

            return ZommaBS_Spot();
        }

        private double ZommaBS_Spot()
        {           
            //declaration
            double _d1, _d2, _zomma, _gamma;


            //exception
            if (Strike == double.PositiveInfinity)
                return 0;

            //constants
            _d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));
            _d2 = _d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));       
            _gamma = GammaBS_Spot();

            //Zomma
            _zomma = _gamma * ((_d1 * _d2 - 1) / sig);

            return _zomma;
        }

        public double BS_Spot_Speed()
        {

            return SpeedBS_Spot();
        }

        private double SpeedBS_Spot()
        {           

            //declaration
            double _d1, _d2, _speed, _gamma;

            //exception
            if (Strike == double.PositiveInfinity)
                return 0;
            //constants
            _d1 = (Math.Log(Spot / Strike) + (r_dom - r_for + 0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            _d2 = _d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));

            _gamma = GammaBS_Spot();


            //speed
            _speed = -_gamma * (1 + _d1 / (sig * Math.Sqrt((_Basis365.Term / 365.0)))) / Spot;

            return _speed;
        }

        public double BS_Spot_Dual_Delta()
        {
            //declaracion
            double _T, _D_dom, _D_for, _F, _d1, _d2, _N2, _X;
            int _flag_Call_Put;

            //constantes
            _flag_Call_Put = this.Call_Put.Equals("c") ? 1 : -1;
            _T = this.Plazo_Dias / 365.0; // tiempo hasta vencimiento (años)
            _D_dom = Math.Exp(-this.r_dom * _T); // factor de descuento domestico
            _D_for = Math.Exp(-this.r_for * _T); // factor de descuento foreano                     
            _F = Spot * _D_for / _D_dom; //forward

            // calculo de Dual_Delta
            _d1 = (Math.Log(_F / Strike) + 0.5 * sig * sig * _T) / (sig * Math.Sqrt(_T));
            _d2 = _d1 - sig * Math.Sqrt(_T);
            _N2 = Function.CND(_flag_Call_Put * _d2);

            _X = -_flag_Call_Put * _D_dom * _N2;  // Dual_Delta
          
            //retorno
            return _X;
        }

        public double BS_Delta_Fwd()
        {
            //definitions
            double _D_dom, _D_for, _delta_fwd, _F, _d1, _sig_sqT;
            int _cpf, _T;

            //constants
            if (Call_Put == "c")//call
                _cpf = 1;
            else//put
                _cpf = -1;
            _T = Plazo_Dias;
            _D_dom = Math.Exp(-r_dom * _T/365.0);
            _D_for = Math.Exp(-r_for * _T / 365.0);

            //exceptions
            if(Strike < 0)
                return double.NaN;
            if(Strike==double.PositiveInfinity){
                if(_cpf==1)//call
                    return 0;
                if(_cpf==-1)//put
                    return _D_dom;
            }
            if(Strike==0){
                if(_cpf==1)//call
                    return _D_dom;
                if(_cpf==-1)//put
                    return 0;
            }

            //general case
            _F = Spot*_D_for/_D_dom;//forward
            _sig_sqT = sig*Math.Sqrt(_T/365.0);
            _d1 = Math.Log(_F/Strike)/_sig_sqT + 0.5*_sig_sqT;

            _delta_fwd = _cpf * _D_dom * Function.CND(_cpf * _d1);
            return _delta_fwd;
        }

        public double BS_Fwd_Delta(double fwd)
        {
            if (Call_Put == "c")
            {
                return DeltaCallBS_fwd(fwd);
            }
            else if (Call_Put == "p")
            {
                return DeltaPutBS_fwd(fwd);
            }
            return 0;
        }

        private double DeltaCallBS_fwd(double fwd)
        {      
                      

            double d1;

            double df_dom = 1 / wf_dom;
            d1 = (Math.Log(fwd / Strike) + (0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            double returnValue = Function.CND(d1) * Math.Exp(-r_dom * (_Basis365.Term / 365.0));

            return returnValue;
        }

        private double DeltaPutBS_fwd(double fwd)
        {
            double d1;

            double df_dom = 1 / wf_dom;


            d1 = (Math.Log(fwd / Strike) + (0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));



            double returnValue = -Function.CND(-d1) * Math.Exp(-r_dom * (_Basis365.Term / 365.0));

            return returnValue;
        }

        public double BS_fwd(double fwd)
        {
            if (Call_Put == "c")
            {
                return CallBS_Fwd(fwd);
            }
            else if (Call_Put == "p")
            {
                return PutBS_Fwd(fwd);
            }
            return 0;
        }

        private double CallBS_Fwd(double fwd)
        {
        
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2;

            double df_dom = 1 / wf_dom;


            d1 = (Math.Log(fwd / Strike) + (0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));
            
            double returnValue = df_dom * (fwd * Function.CND(d1) - Strike * Function.CND(d2));

            return returnValue;
        }

        private double PutBS_Fwd(double fwd)
        {
           
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
            //Basis _Basis360;
            //Basis _Basis365;
            //int int_strike = 1;
            //int int_time = 1;

            //double r_dom, r_for;

            //double sig;

            //_Basis360 = new Basis(enumBasis.Basis_Act_360, this.FechaVal, this.FechaVcto);
            //_Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

            //wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaVal, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            //r_dom = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_dom);
            //r_for = (1 / (_Basis365.Term / 365.0)) * Math.Log(wf_for);

            //sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, int_strike, int_time);

            double d1, d2;

            double df_dom = 1 / wf_dom;


            d1 = (Math.Log(fwd / Strike) + (0.5 * Math.Pow(sig, 2)) * (_Basis365.Term / 365.0)) / (sig * Math.Sqrt((_Basis365.Term / 365.0)));

            d2 = d1 - sig * Math.Sqrt((_Basis365.Term / 365.0));

            double returnValue = df_dom * (Strike * Function.CND(-d2) - fwd * Function.CND(-d1));

            return returnValue;
        }

        public double find_atm_strike(double delta_objetivo, int flagSmile_0_1)
        {
            try
            {
               
                int N = this.Smile.Tenors.Count;
                double[] strikes_aux = new double[N];
                Basis _Basis365;

                int _t;
                double _k_ini, _r_clp, _r_usd, _wf_clp, _wf_usd, _fwd;

                for (int i = 0; i < N; i++)
                {
                    strikes_aux[i] = this.Smile.Strikes[i][2];
                }

                _Basis365 = new Basis(enumBasis.Basis_Act_365, this.FechaVal, this.FechaVcto);

                _t = (int)_Basis365.Term;
                _k_ini = this.Spot;

                //YieldList mYieldList = new YieldList();
                //mYieldList.SetPrincingLoading = this.SetPricing;
                //mYieldList.Load(this.CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);
                //mYieldList.Load(this.CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaVal);

                _r_clp = mYieldList.Read(CurvaDom, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate / 100.0;
                _r_usd = mYieldList.Read(CurvaFor, enumSource.System, this.FechaSetDePrecios, (int)_Basis365.Term).Rate / 100.0;

                _wf_clp = Math.Pow((1 + _r_clp), (_t / 360.0));
                _wf_usd = Math.Pow((1 + _r_usd), (_t / 360.0));

                _fwd = this.Spot * _wf_clp / _wf_usd;


                double _diff, _strike, _h, _e, _deriv;

                _diff = 1;
                _strike = _k_ini;
                _h = 0.000001;
                _e = 0.00001;

                double _TempStrike = this.Strike;
                double _TempSig = this.sig;

                double delta_straddle, delta_straddle_desp;
                while (Math.Abs(_diff) >= _e)
                {
                    if (flagSmile_0_1 == 0)
                    {
                        
                        this.Strike = _strike;
                        this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

                        delta_straddle = DeltaCallBS_fwd(_fwd) + DeltaPutBS_fwd(_fwd);
                       
                        this.Strike = _strike + _h;
                        this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

                        delta_straddle_desp = DeltaCallBS_fwd(_fwd) + DeltaPutBS_fwd(_fwd);
                    }
                    else
                    {
                        this.Strike = _strike;
                        this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

                        delta_straddle = DeltaCallBS_Spot() + DeltaPutBS_Spot();

                        this.Strike = _strike + _h;
                        this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

                        delta_straddle_desp = DeltaCallBS_Spot() + DeltaPutBS_Spot();
                    }


                    _diff = delta_straddle - delta_objetivo;
                    _deriv = (delta_straddle_desp - delta_straddle) / _h;

                    if (_deriv == 0)
                    {
                        break;

                    }
                    _strike = _strike - _diff / _deriv;

                }

                this.Strike = _TempStrike;
                this.sig = _TempSig;

                return _strike;
            }
            catch { return 0; };

        }

        public double find_strike_fwd(double delta_objetivo)
        {
            //delta_objetivo is the absolute value of the strike
            //Declaration
            double _dK, _K_left, _K_right, _K_mid, _Delta_left, _Delta_right, _Delta_mid, _Delta_star, _Delta_max;
            int _T, _nIter, _nMax;

            //Constants
            _nMax = 100;//maximum number of iterations
            _nIter = 0;//initial number of iterations
            _dK = 1e-8;//strike precision
            _T = this.Plazo_Dias;
            _Delta_max = Math.Exp(-r_dom * _T / 365.0);//max absolute forward delta
            _K_mid = 0;//initial strike solution
            _Delta_star = (this.Call_Put.Equals("c")) ? delta_objetivo : -delta_objetivo;//objective forward delta


            //Tackle invalid target prices
            if (this.Call_Put.Equals("c"))//call
            {
                if (_Delta_star < 0 || _Delta_star > _Delta_max)
                    return double.NaN;
                if (_Delta_star == _Delta_max)
                    return 0;
                if (_Delta_star == 0)
                    return double.PositiveInfinity;
            }
            if (this.Call_Put.Equals("p"))//put
            {
                if (_Delta_star > 0 || _Delta_star < -_Delta_max)
                    return double.NaN;
                if (_Delta_star == 0)
                    return 0;
                if (_Delta_star == -_Delta_max)
                    return double.PositiveInfinity;
            }

            //Search for appropriate upper and lower boundaries of the ideal strike
            _K_left = 0;
            this.set_Strike_Sig(_K_left);
            _Delta_left = this.BS_Delta_Fwd();
            _K_right = this.Spot;
            this.set_Strike_Sig(_K_right);
            _Delta_right = this.BS_Delta_Fwd();
            while (_Delta_right > _Delta_star)
            {
                _K_left = _K_right;
                _Delta_left = _Delta_right;
                _K_right *= 2.0;
                this.set_Strike_Sig(_K_right);
                _Delta_right = this.BS_Delta_Fwd();
            }

            //Dichotomy search of the strike
            while (Math.Abs(_K_right - _K_left) > _dK && _nIter < _nMax)
            {
                _K_mid = 0.50 * (_K_right + _K_left);
                this.set_Strike_Sig(_K_mid);
                _Delta_mid = this.BS_Delta_Fwd();
                if (_Delta_mid > _Delta_star)
                {
                    _K_left = _K_mid;
                    _Delta_left = _Delta_mid;
                }
                else
                {
                    _K_right = _K_mid;
                    _Delta_right = _Delta_mid;
                }
                _nIter++;
            }

            return _K_mid; 
            /*
            _h = 1e-4;//solution accuracy
            _e = 1e-7;

            _fwd_teo = Function.Forward(this.FechaVal, this.FechaVcto, this.Spot, this.CurvaDom, this.CurvaFor, this.mYieldList);

            _diff = 2*_e;
            _strike = _fwd_teo;
                 
            _TempStrike = this.Strike;
            _TempSig = this.sig;

            //loop
            while (Math.Abs(_diff) >= _e)
            {
                this.Strike = _strike;
                this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

                _delta = this.BS_Fwd_Delta(_fwd_teo);

                this.Strike = _strike + _h;
                this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, Strike, 1, 1);

                _delta_desp = this.BS_Fwd_Delta(_fwd_teo);

                _diff = _delta - _delta_obj;
                _deriv = (_delta_desp - _delta) / _h;

                if (_deriv == 0)
                {
                    return -1;
                    //break;                   
                }

                _strike = _strike - _diff / _deriv;
            }

            this.Strike = _TempStrike;
            this.sig = _TempSig;

            return _strike;
            */
        }

        public double find_strike_price_CallPut(double price_objetivo, string BsSpot_BsFwd_flag)
        {

            double _Nocional, _Precio_ajustado , _K;
            double _dK; // precisión
            int flag_compra_venta;
            
            flag_compra_venta = this.Compra_Venta.Equals("compra") ? 1 : -1;

            _Nocional = this.Nocional;
            _dK = 1e-6 / Math.Max(_Nocional, 1);
            _Precio_ajustado = price_objetivo / _Nocional * flag_compra_venta;

            _K = find_strike_price(_Precio_ajustado, _dK, BsSpot_BsFwd_flag);
            
            return _K;
        }

        private void set_Strike_Sig(double _strike)
        {
            this.Strike = _strike;
            this.sig = 0.01 * Smile.interp_vol((int)_Basis365.Term, _strike, 1, 1); ;
        }

        public double find_strike_price(double price_objective, double strike_precision, string BsSpot_BsFwd_flag)
        {            
            // price_objetivo tiene un nocional de 1

            //Declaration
            double _dK, _K_left, _K_right, _K_mid, _P_left, _P_right, _P_mid, _P_star;
            int _nIter, _nMax;

            //Constants
            _nMax = 100;//maximum number of iterations
            _nIter = 0;//initial number of iterations
            _dK = Math.Abs(strike_precision);//strike precision
            _P_star = price_objective;//objective price
            _K_mid = 0;//initial strike solution
            
            //Tackle invalid target prices
            _K_left = 0;
            this.set_Strike_Sig(_K_left);

            if (BsSpot_BsFwd_flag.Equals("BsSpot"))
            {
                _P_left = this.BS_Spot();
            }
            else 
            {
                _P_left = this.BS_fwd((this.Spot + this.Puntos));
            }

            
            //    _P_left = this.BS_Spot();

            if (this.Call_Put.Equals("c"))//call: _P_left = Soexp(-qT)
            {
                if(_P_star < 0 || _P_star > _P_left)
                    return double.NaN;
                if(_P_star == _P_left)
                    return 0;
                if(_P_star == 0)
                    return double.PositiveInfinity;
            }
            if (this.Call_Put.Equals("p"))//put
            {
                if(_P_star < 0)
                    return double.NaN;
                if(_P_star == 0)
                    return 0;
            }

            //Search for appropriate upper and lower boundaries of the ideal strike
            _K_right = this.Spot;
            this.set_Strike_Sig(_K_right);


            //_P_right = this.BS_Spot();

            if (BsSpot_BsFwd_flag.Equals("BsSpot"))
            {
                _P_right = this.BS_Spot();
            }
            else
            {
                _P_right = this.BS_fwd((this.Spot + this.Puntos));
            }
            
            if (this.Call_Put.Equals("c"))//call
            {
                while (_P_right > _P_star)
                {
                    _K_left = _K_right;
                    _P_left = _P_right;
                    _K_right *= 2.0;
                    this.set_Strike_Sig(_K_right);
                    _P_right = this.BS_Spot();
                }
            }
            if (this.Call_Put.Equals("p"))//put
            {
                while (_P_right < _P_star)
                {
                    _K_left = _K_right;
                    _P_left = _P_right;
                    _K_right *= 2.0;
                    this.set_Strike_Sig(_K_right);
                    //_P_right = this.BS_Spot();

                    if (BsSpot_BsFwd_flag.Equals("BsSpot"))
                    {
                        _P_right = this.BS_Spot();
                    }
                    else
                    {
                        _P_right = this.BS_fwd((this.Spot + this.Puntos));
                    }
                }
            }

            //Dichotomy search of the strike
            while (Math.Abs(_K_right - _K_left) > _dK && _nIter<_nMax) 
            {
                _K_mid = 0.50 * (_K_right + _K_left);
                this.set_Strike_Sig(_K_mid);

                //_P_mid = this.BS_Spot();

                if (BsSpot_BsFwd_flag.Equals("BsSpot"))
                {
                    _P_mid = this.BS_Spot();
                }
                else
                {
                    _P_mid = this.BS_fwd((this.Spot + this.Puntos));
                }


                if ((this.Call_Put.Equals("c") && _P_mid > _P_star) || (this.Call_Put.Equals("p") && _P_mid < _P_star))
                {
                    _K_left = _K_mid;
                    _P_left = _P_mid;
                }
                else 
                {
                    _K_right = _K_mid;
                    _P_right = _P_mid;
                }
                _nIter++;
            }

            return _K_mid;                       

        }

        public double find_strike_price_ForwardSintetico(double price_objective, string BsSpot_BsFwd)
        {
            //Declaracion
            double _K, _N, _D_dom, _D_for, _T, _price_adjusted;
            int _cvf;

            //Constantes
            _cvf = Compra_Venta.Equals("compra") ? 1 : -1;
            _N = this.Nocional;
            _price_adjusted = _cvf *price_objective / _N;
            _T = this._Basis365.Term / 365.0;
            _D_dom = Math.Exp(-this.r_dom * _T);
            _D_for = Math.Exp(-this.r_for * _T);

            //Cálculo de Strike
            _K = (this.Spot * _D_for - _price_adjusted) / _D_dom;

            //Retorno
            return _K;
        }

        public double find_strike_RaphsonNewton(double price_objective, double strike_precision)
        {
            // price_objetivo tiene un nocional de 1
            //no adjustment for the smile: implied volatility is constant

            //Declaration
            double _dK, _F, _K_new, _K_old, _P , _alpha;
            int _nIter, _nMax;
            double _D_dom, _D_for, _T;

            //Constants
            _T = this.Plazo_Dias / 365.0;
            _nMax = 100;//maximum number of iterations
            _nIter = 0;//initial number of iterations
            _dK = Math.Abs(strike_precision);//strike precision            
            _D_dom = Math.Exp(-r_dom * _T);
            _D_for = Math.Exp(-r_for * _T);
            _F = Spot * _D_for / _D_dom;

            //Tackle invalid target prices
            if (this.call_put_flag.Equals("c"))//call
            {
                if (price_objective >= Spot * _D_for)
                {
                    return 0;
                }
                if (price_objective <= 0)
                {
                    return double.PositiveInfinity;
                }
            }
            if (this.call_put_flag.Equals("p"))//put
            {
                if (price_objective <= 0)
                {
                    return 0;
                }
            }

            //Raphson-Newton algorithm
            _K_old = _F;
            this.Strike = _K_old;
            _alpha = this.BS_Spot_Dual_Delta();
            _P = this.BS_Spot();
            _K_new = _K_old + (price_objective - _P)/_alpha;
            _nIter = 0;

            while(Math.Abs(_K_old -_K_new) > _dK && _nIter < _nMax)
            {
                _K_old = _K_new;
                this.Strike = _K_old;
                _alpha = this.BS_Spot_Dual_Delta();
                _P = this.BS_Spot();
                _K_new = _K_old + (price_objective - _P) / _alpha;
                _nIter ++;                
            }


            return _K_new;           
           
        }

        public List<List<double>> smile_mid_1_1()
        {

            int N = this.Smile.Volas.Count;
            double[] atm = new double[N];
            double[] rr_25 = new double[N];
            double[] fly_25 = new double[N];
            double[] rr_10 = new double[N];
            double[] fly_10 = new double[N];

            for (int h = 0; h < N; h++)
            {
                atm[h] = this.Smile.Volas[h][0];
                rr_25[h] = this.Smile.Volas[h][1];
                fly_25[h] = this.Smile.Volas[h][2];
                rr_10[h] = this.Smile.Volas[h][3];
                fly_10[h] = this.Smile.Volas[h][4];
            }

            List<List<double>> salida = new List<List<double>>();
            for (int k = 1; k <= N; k++)
            {
                salida.Add(new List<double>(5));
            }
            double sig_call_25;
            double sig_put_25;
            double sig_call_10;
            double sig_put_10;

            for (int i = 0; i < N; i++)
            {
                sig_call_25 = atm[i] + fly_25[i] + 0.5 * rr_25[i];
                sig_put_25 = atm[i] + fly_25[i] - 0.5 * rr_25[i];
                sig_call_10 = atm[i] + fly_10[i] + 0.5 * rr_10[i];
                sig_put_10 = atm[i] + fly_10[i] - 0.5 * rr_10[i];

                salida[i].Add(sig_put_10);
                salida[i].Add(sig_put_25);
                salida[i].Add(atm[i]);
                salida[i].Add(sig_call_25);
                salida[i].Add(sig_call_10);
            }
            return salida;
        }    
    }
}
