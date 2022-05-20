using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using cData.Opciones;
using cFinancialTools.Yield;
using cFinancialTools.DayCounters;
using System.Xml.Linq;
using AdminOpciones.Web.Struct;
using AdminOpcionesTool.Opciones.SmileNameSpace;
using AdminOpcionesTool.Opciones.Payoffs;
using cFinancialTools.BussineDate;

namespace AdminOpciones.Web.WebService.OpcionesFX.Smile
{
    /// <summary>
    /// Descripción breve de SrvSmile
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class SrvSmile : System.Web.Services.WebService
    {
        DataTable _SmileDataTable;
        string _ReturnValue;

        //[WebMethod]
        //public string GetSmiles(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        _ReturnValue = "";
        //        _SmileDataTable = new DataTable();
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        _ReturnValue = _Smile.getSmile();
        //        return _ReturnValue;
        //    }
        //    catch { return ""; }
        //}       

        //[WebMethod]        
        //public string inversion_strikes(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        string _salida = _Smile.inversion_strikes();
        //        return _salida;
        //    }
        //    catch { return ""; }
        //}

        ////[WebMethod]
        ////public double CallBsSpotFunc(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, DateTime fecha_venc, string YieldNameCurvaDom, string YieldNameCurvaFor)
        ////{
        ////    Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        ////    _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, fecha_venc, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        ////    return _Smile.CallBsSpotFunc();            
        ////}

        ////[WebMethod]
        ////public double PutBsSpotFunc(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, DateTime fecha_venc, string YieldNameCurvaDom, string YieldNameCurvaFor)
        ////{
        ////    Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        ////    _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, fecha_venc, YieldNameCurvaDom, YieldNameCurvaFor, 0);             
        ////    return _Smile.PutBsSpotFunc();           
        ////}

        //[WebMethod]
        //public double interp_vol(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.interp_vol(plazo_dias, strike, 0, 0);
        //    }
        //    catch { return 0; }
        //}

        //[WebMethod]
        //public double BS_Spot(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.BS_Spot(plazo_dias);
        //    }
        //    catch { return 0; }
        //}

        //[WebMethod]
        //public double GetScaled_BS_Spot(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.GetScaled_BS_Spot(plazo_dias);
        //    }
        //    catch { return 0; }
        //}

        //[WebMethod]
        //public string GetGriegas(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.GetGriegas(plazo_dias);
        //    }
        //    catch { return ""; }
        //}

        //[WebMethod]
        //public string GetScaledGriegas(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.GetScaledGriegas(plazo_dias);
        //    }
        //    catch { return ""; }
        //}

        //[WebMethod]
        //public double find_atm_strike(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double delta_objetivo, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, delta_objetivo, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.find_atm_strike(delta_objetivo, plazo_dias);
        //    }
        //    catch { return 0; }
        //}

        //[WebMethod]
        //public double find_strike_fwd(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double delta_objetivo ,DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor)
        //{
        //    try
        //    {
        //        Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //        _Smile.Load(paridad, call_put_flag, compra_venta, nominal, spot, delta_objetivo, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //        return _Smile.find_strike_fwd(delta_objetivo, plazo_dias);
        //    }
        //    catch { return 0; }
        //}

        //[WebMethod]
        //public double BS_Spot_Delta(string call_put_flag, double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
        //{
        //   return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Delta( call_put_flag,  spot,  strike,  fecha_Val,  fecha_Venc,  yieldName_dom,  yieldName_for,  callPutAndStrikes) ;
        //}

        //[WebMethod]
        //public double BS_Spot_Gamma(string call_put_flag,double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
        //{
        //    return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Gamma( call_put_flag, spot,  strike,  fecha_Val,  fecha_Venc,  yieldName_dom,  yieldName_for,  callPutAndStrikes);
        //}

        


       // [WebMethod]
       // public double BS_Spot_Vega(string call_put_flag,double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {

       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Vega( call_put_flag, spot,  strike,  fecha_Val,  fecha_Venc,  yieldName_dom,  yieldName_for,  callPutAndStrikes);
       // }


       

       // [WebMethod]
       // public double BS_Spot_Vanna(string call_put_flag,double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {

       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Vanna(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }


      

       //[WebMethod]
       // public double BS_Spot_Volga(string call_put_flag,double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {

       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Volga(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }

       

       //  [WebMethod]
       // public double BS_Spot_Theta(string call_put_flag, double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {
       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Theta(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }

                 
         


       // [WebMethod]
       // public double BS_Spot_Rho(string call_put_flag, double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {
       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Rho(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }




       // [WebMethod]
       // public double BS_Spot_Rhof(string call_put_flag, double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {
       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Rhof(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }


        


       // [WebMethod]
       // public double BS_Spot_Charm(string call_put_flag, double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {
       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Charm(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }

        

       // [WebMethod]
       // public double BS_Spot_Zomma(string call_put_flag,double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {

       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Zomma(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }


        

       //  [WebMethod]
       // public double BS_Spot_Speed(string call_put_flag,double spot, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {

       //     return Turing2009Tool.Opciones.Smile.Smile.BS_Spot_Speed(call_put_flag, spot, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }       


        [WebMethod]
        public double Fwd_Delta(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, DateTime fecha_vencimiento, DateTime FechaSetDePrecios, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPricing)
        {
            try
            {
                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, paridad, spot, YieldNameCurvaDom, YieldNameCurvaFor, 0);
                _Smile.Load((enumSetPrincingLoading)enumSetPricing);
                YieldList CurvaList = new YieldList();

                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Vanilla _Vanilla = new AdminOpcionesTool.Opciones.Payoffs.Vanilla(CurvaList,_Smile, paridad, call_put_flag, compra_venta, nominal, spot, 0, strike, fecha_val, fecha_vencimiento,FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPricing);

                return _Vanilla.BS_Fwd_Delta(strike);
            }
            catch { return 0; };
        }


         
       // [WebMethod]
       // public double BS_fwd(string call_put_flag, double fwd, double strike, DateTime fecha_Val, DateTime fecha_Venc, string yieldName_dom, string yieldName_for, string callPutAndStrikes) 
       // {
       //     return Turing2009Tool.Opciones.Smile.Smile.BS_fwd(call_put_flag, fwd, strike, fecha_Val, fecha_Venc, yieldName_dom, yieldName_for, callPutAndStrikes);
       // }    

        //[WebMethod]
        //public string Opcion(string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike, DateTime fecha_val, DateTime FechaVenc, string YieldNameCurvaDom, string YieldNameCurvaFor, int numComponente_Estruc, string PayOff, string Estruct_Indiv)
        //{

        //    Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();

        //    _Smile.Load(paridad, call_put_flag, compraVenta, nominal, spot, strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor,0);

        //    if (_Smile.volas.Count == 0)
        //    {
        //        return "<Data/>";
        //    }

        //    string ReturnValue = _Smile.Opcion(FechaVenc, numComponente_Estruc, Estruct_Indiv);
            
        //    return ReturnValue; 
        //}

        //[WebMethod]
        //public string OpcionVanilla(string strikes_delta_flag ,string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike_delta, DateTime fecha_val, DateTime FechaVenc, string YieldNameCurvaDom, string YieldNameCurvaFor, int numComponente_Estruc, string PayOff, string Estruct_Indiv)
        //{
        //    double _strike = strike_delta;
        //    if (strikes_delta_flag.Equals("delta"))
        //    {
        //        int plazo = FechaVenc.Subtract(fecha_val).Days;
        //        Turing2009Tool.Opciones.Smile.Smile _Smile_Aux = new Turing2009Tool.Opciones.Smile.Smile();

        //        _Smile_Aux.Load(paridad, "c", compraVenta, nominal, spot, 1, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);

        //        _strike = _Smile_Aux.find_strike_fwd(strike_delta, plazo);
 
        //    }

        //    Turing2009Tool.Opciones.Smile.Smile _Smile = new Turing2009Tool.Opciones.Smile.Smile();
        //    _Smile.Load(paridad, call_put_flag, compraVenta, nominal, spot, _strike, fecha_val, YieldNameCurvaDom, YieldNameCurvaFor, 0);

        //    if (_Smile.volas.Count == 0)
        //    {
        //        return "<Data/>";
        //    }

        //    string ReturnValue = _Smile.Opcion(FechaVenc, numComponente_Estruc, Estruct_Indiv);

        //    return ReturnValue;
        //}


        [WebMethod]
        public string OpcionVanilla(string BsSpot_BsFwd, string strikes_delta_flag, string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double spot_smile, double puntos, double strike_delta, DateTime fecha_val, DateTime FechaVenc, DateTime FechaSetDePrecios, string YieldNameCurvaDom, string YieldNameCurvaFor, int numComponente_Estruc, string PayOff, string Estruct_Indiv, int enumSetPricing)
        {
            string _error = "";
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, FechaVenc))
                {
                    FechaVenc = calendario.NextHolidayDate(6, FechaVenc);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, paridad, spot_smile, YieldNameCurvaDom, YieldNameCurvaFor, 0);
                _Smile.Load((enumSetPrincingLoading)enumSetPricing);

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;

                CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                double _strike = strike_delta;
                AdminOpcionesTool.Opciones.Payoffs.Vanilla _Vanilla;

                if (strikes_delta_flag.Equals("delta"))
                {
                    int plazo = FechaVenc.Subtract(fecha_val).Days;

                    _Vanilla = new AdminOpcionesTool.Opciones.Payoffs.Vanilla(CurvaList, _Smile, paridad, call_put_flag, compraVenta, nominal, spot, puntos, strike_delta, fecha_val, FechaVenc,FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPricing);

                    _strike = _Vanilla.find_strike_fwd(strike_delta);
                    _strike = Math.Round(_strike, 2);

                    if (_strike.Equals(double.NaN))
                    {
                        _error = "Delta fuera de intervalo";
                    } 
                    if (_strike.Equals(double.NegativeInfinity) || _strike.Equals(double.PositiveInfinity))
                    {
                        _error = "Delta fuera de intervalo";
                    }
                }

                _Vanilla = new AdminOpcionesTool.Opciones.Payoffs.Vanilla(CurvaList, _Smile, paridad, call_put_flag, compraVenta, nominal, spot, puntos, _strike, fecha_val, FechaVenc, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPricing);

                if (_Smile.Volas.Count == 0)
                {
                    return "<Data/>";
                }

                string _Vanila_Option = _Vanilla.Opcion(numComponente_Estruc, Estruct_Indiv, BsSpot_BsFwd);

                string _Return_Vanilla ="<Data>\n";
                _Return_Vanilla += _Vanila_Option;
                _Return_Vanilla += "</Data>";

                return _Return_Vanilla;
            }
            catch 
            {
                string _return;

                _return = "<Data>\n";
                _return += "<ERROR MSG='" + _error + "'/>\n"; ;
                _return += "</Data>";

                return _return; 
            }
        }

        [WebMethod]
        public double Solver_CallPut_Vanilla(string BsSpot_BsFwd_flag, string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double puntos, double strike, double MtM_objetivo, DateTime fecha_val, DateTime FechaVenc, DateTime FechaSetDePrecios, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPricing)
        {
            Vanilla _Vanilla;
            double _Strike;

            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                _Vanilla = new Vanilla(CurvaList,paridad, call_put_flag, compraVenta, nominal, spot, puntos, strike, fecha_val, FechaVenc, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPricing, 0);

                _Strike = _Vanilla.find_strike_price_CallPut(MtM_objetivo, BsSpot_BsFwd_flag);
               // _Strike = Math.Round(_Strike, 2);
            }
            catch 
            {
                return double.NaN;
            }

            return _Strike;            
 
        }

        //[WebMethod]
        //public string Opcion(string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike, DateTime fecha_val, DateTime FechaVenc, string YieldNameCurvaDom, string YieldNameCurvaFor, int numComponente_Estruc, string PayOff, string Estruct_Indiv)
        //{
        //    Turing2009Tools.Opciones.SmileNameSpace.Smile _Smile = new Turing2009Tools.Opciones.SmileNameSpace.Smile(fecha_val, paridad, spot, YieldNameCurvaDom, YieldNameCurvaFor, 0);
        //    _Smile.Load();
        //    if (_Smile.Volas.Count == 0)
        //    {
        //        return "<Data/>";
        //    }
        //    Turing2009Tools.Opciones.Payoffs.Vanilla _Vanilla = new Turing2009Tools.Opciones.Payoffs.Vanilla( _Smile,paridad, call_put_flag, compraVenta, nominal, spot, strike, fecha_val, FechaVenc, YieldNameCurvaDom, YieldNameCurvaFor);
        //    string ReturnValue = _Vanilla.Opcion(numComponente_Estruc, Estruct_Indiv);
        //    return ReturnValue;
        //}

    }
}
