using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using cFinancialTools.Yield;
using System.Xml.Linq;
using Jacques;

namespace AdminOpcionesTool.ValorizadorCartera
{
    public class ForwardAmerican
    {

        #region Atributos Privados

        // {0} Referencia
        // {1} LONG/SHORT
        // {2} AMERICAN/EUROPEAN/BERMUDAN
        // {3} BUYER/WRITER
        // {4} FORWARD/VANILLA
        // {5} CALL/PUT
        // {6} OBSERVABLE-0
        private static string __FileProduct = "PRODUCT-{0}-{1}_{2}_{3}_{4}_{5}_{6}.txt";
        private List<string> __FileNames;

        private DateTime __ValuatorDate;
        private double __Spot;

        private string __EuropeanForwardFileName;

        private int __AmericanForwardID;
        private int __EuropeanForwardID;

        private int __SolverAmericanForwardID;
        private int __SolverEuropeanForwardID;

        private long __OperationNumber;
        private long __StructureID;
        private string __StructureType;
        private double __Notional;
        private double __Strike;
        private DateTime __ExpiryDate;
        private string __Position;
        private string __Gennus;
        private int __Tenor;

        private double __MTM;
        private double __FairValue;
        private double __Versus;
        private double __DeltaSpot;
        private double __DeltaForward;
        private double __Delta;
        private double __Gamma;
        private double __Vega;
        private double __RhoDom;
        private double __RhoFor;
        private double __Theta;
        private double __Charm;
        private double __Vanna;
        private double __Volga;

        private double __PointForward;
        private double __Forward;
        private double __Volatility;
        private double __RateDomestic;
        private double __RateForeign;
        private double __Objetive;

        private string __YieldDomestic = Global.YieldDomestic;
        private string __YieldForeign = Global.YieldForeign;

        private List<FASensitivity> __ListYieldDomestic = new List<FASensitivity>();
        private List<FASensitivity> __ListYieldForeign = new List<FASensitivity>();

        private bool __IsSolver = false;
        private bool __IsGreek = false;

        private cFinancialTools.BussineDate.Calendars __Calendar = new cFinancialTools.BussineDate.Calendars();

        private YieldList __YieldList = new YieldList();

        #endregion

        #region Atributos Publicos

        public List<string> FileNames
        {
            get
            {
                return __FileNames;
            }
        }

        public DateTime ValuatorDate
        {
            get
            {
                return __ValuatorDate;
            }
            set
            {
                __ValuatorDate = value;
            }
        }

        public double Spot
        {
            get
            {
                return __Spot;
            }
            set
            {
                __Spot = value;
            }
        }

        public int AmericanForwardID
        {
            get
            {
                return __AmericanForwardID;
            }
        }

        public int EuropeanForwardID
        {
            get
            {
                return __EuropeanForwardID;
            }
        }

        public long OperationNumber
        {
            get
            {
                return __OperationNumber;
            }
        }

        public long StructureID
        {
            get
            {
                return __StructureID;
            }
        }

        public string StructureType
        {
            get
            {
                return __StructureType;
            }
        }

        public double Notional
        {
            get
            {
                return __Notional;
            }
        }

        public double Strike
        {
            get
            {
                return __Strike;
            }
            set
            {
                __Strike = value;
            }
        }

        public DateTime ExpiryDate
        {
            get
            {
                return __ExpiryDate;
            }
        }

        public string Exercize
        {
            get
            {
                return "A";
            }
        }

        public string Position
        {
            get
            {
                return __Position;
            }
        }

        public string Gennus
        {
            get
            {
                return __Gennus;
            }
        }

        public int Tenor
        {
            get
            {
                return __Tenor;
            }
        }

        public double MTM
        {
            get
            {
                return __MTM;
            }
        }

        public double FairValue
        {
            get
            {
                return __FairValue;
            }
        }

        public double Versus
        {
            get
            {
                return __Versus;
            }
        }

        public double DeltaSpot
        {
            get
            {
                return __DeltaSpot;
            }
        }

        public double DeltaForward
        {
            get
            {
                return __DeltaForward;
            }
        }

        public double Delta
        {
            get
            {
                return __Delta;
            }
        }

        public double Gamma
        {
            get
            {
                return __Gamma;
            }
        }

        public double Vega
        {
            get
            {
                return __Vega;
            }
        }

        public double RhoDom
        {
            get
            {
                return __RhoDom;
            }
        }

        public double RhoFor
        {
            get
            {
                return __RhoFor;
            }
        }

        public double Theta
        {
            get
            {
                return __Theta;
            }
        }

        public double Charm
        {
            get
            {
                return __Charm;
            }
        }

        public double Vanna
        {
            get
            {
                return __Vanna;
            }
        }

        public double Volga
        {
            get
            {
                return __Volga;
            }
        }

        public double PointForward
        {
            get
            {
                return __PointForward;
            }
        }

        public double Forward
        {
            get
            {
                return __Forward;
            }
        }

        public double Volatility
        {
            get
            {
                return __Volatility;
            }
        }

        public double RateDomestic
        {
            get
            {
                return __RateDomestic;
            }
        }

        public double RateForeign
        {
            get
            {
                return __RateForeign;
            }
        }

        public double Objetive
        {
            get
            {
                return __Objetive;
            }
            set
            {
                __Objetive = value;
            }
        }

        public YieldList Yield
        {
            get
            {
                return __YieldList;
            }
            set
            {
                __YieldList = value;
            }
        }

        public bool IsSolver
        {
            get
            {
                return __IsSolver;
            }
            set
            {
                __IsSolver = value;
            }
        }

        public bool IsGreek
        {
            get
            {
                return __IsGreek;
            }
            set
            {
                __IsGreek = value;
            }
        }

        public List<FASensitivity> ListYieldDomestic
        {
            get
            {
                return __ListYieldDomestic;
            }
        }

        public List<FASensitivity> ListYieldForeign
        {
            get
            {
                return __ListYieldForeign;
            }
        }

        public cFinancialTools.BussineDate.Calendars Calendar
        {
            get
            {
                return __Calendar;
            }
            set
            {
                __Calendar = value;
            }
        }

        #endregion

        #region Constructor

        public ForwardAmerican()
        {
            Set();
        }

        public ForwardAmerican(long operationnumber, long structureid, string structuretype, double notional, double strike, DateTime expirydate, string position, string gennus)
        {
            Set(operationnumber, structureid, structuretype, notional, strike, expirydate, position, gennus);
        }

        public ForwardAmerican(ForwardAmerican value)
        {
            Set(value);
        }

        public ForwardAmerican(XElement value)
        {
            Set(value);
        }

        #endregion

        #region Metodos Privados

        private void __Set(long operationnumber, long structureid, string structuretype, double notional, double strike, DateTime expirydate, string position, string gennus)
        {

            // Valida si la fecha de vencimiento es feriada, si no calcula el proximo día hábil
            while (!__Calendar.IsBussineDay(6, expirydate))
            {
                expirydate = expirydate.AddDays(1);
            }

            __EuropeanForwardFileName = "";
            __AmericanForwardID = 0;
            __EuropeanForwardID = 0;

            __OperationNumber = operationnumber;
            __StructureID = structureid;
            __StructureType = structuretype;
            __Notional = notional;
            __Strike = strike;
            __ExpiryDate = expirydate;
            __Position = position;
            __Gennus = gennus;
            __Tenor = 0;

            __MTM = 0;
            __DeltaSpot = 0;
            __DeltaForward = 0;
            __Delta = 0;
            __Gamma = 0;
            __Vega = 0;
            __RhoDom = 0;
            __RhoFor = 0;
            __Theta = 0;
            __Charm = 0;
            __Vanna = 0;
            __Volga = 0;
            __FairValue = 0;

            __PointForward = 0;
            __Forward = 0;
            __Volatility = 0;
            __RateDomestic = 0;
            __RateForeign = 0;
        }

        private string SaveForwardEuropean(int reference, double delta)
        {
            string __FileForwardEuropean = string.Format(__FileProduct, reference, __Position, "EUROPEAN", "BUYER", "FORWARD", __Gennus, Global.Observable);

            FileStream _StreamForwardEuropean = new FileStream(Global.ServiceConnect + __FileForwardEuropean, FileMode.OpenOrCreate, FileAccess.Write);
            StreamWriter _FileForwardEuropean = new StreamWriter(_StreamForwardEuropean);

            __EuropeanForwardFileName = __FileForwardEuropean;

            _FileForwardEuropean.WriteLine("INFORMATION_TYPE PRODUCT");
            _FileForwardEuropean.WriteLine(string.Format("INFORMATION_INDEX {0}", reference));
            _FileForwardEuropean.WriteLine(string.Format("REFERENCE {0}", reference));
            _FileForwardEuropean.WriteLine(string.Format("UNDERLYING_FILENAME {0}-FX-CLP_USD.txt", Global.Observable)); //OBSERVABLE-0
            _FileForwardEuropean.WriteLine(string.Format("POSITION {0}", __Position));
            _FileForwardEuropean.WriteLine("SIDE BUYER");
            _FileForwardEuropean.WriteLine("FAMILY ONE_STRIKE");
            _FileForwardEuropean.WriteLine(string.Format("STRIKE {0}", (__Strike + delta).ToString().Replace(",", ".")));
            _FileForwardEuropean.WriteLine(string.Format("GENUS {0}", __Gennus));
            _FileForwardEuropean.WriteLine("SPECIE FORWARD");
            _FileForwardEuropean.WriteLine("EXERCIZE EUROPEAN");
            _FileForwardEuropean.WriteLine(string.Format("DATE_EXERCIZE 1 {0}", __ExpiryDate.ToOADate().ToString("0.0").Replace(",", ".")));
            _FileForwardEuropean.WriteLine("PATH_DEPENDENCY NONE");

            _FileForwardEuropean.Close();

            return __FileForwardEuropean;
        }

        private string SaveForwardAmerican(int reference, double delta)
        {
            string __FileForwardAmerican = string.Format(__FileProduct, reference, __Position, "AMERICAN", "BUYER", "FORWARD", __Gennus, Global.Observable);

            FileStream _StreamForwardAmerican = new FileStream(Global.ServiceConnect + __FileForwardAmerican, FileMode.OpenOrCreate, FileAccess.Write);
            StreamWriter _FileForwardAmerican = new StreamWriter(_StreamForwardAmerican);

            _FileForwardAmerican.WriteLine("INFORMATION_TYPE PRODUCT");
            _FileForwardAmerican.WriteLine(string.Format("INFORMATION_INDEX {0}", reference));
            _FileForwardAmerican.WriteLine(string.Format("REFERENCE {0}", reference));
            _FileForwardAmerican.WriteLine(string.Format("UNDERLYING_FILENAME {0}-FX-CLP_USD.txt", Global.Observable));
            _FileForwardAmerican.WriteLine(string.Format("POSITION {0}", __Position));
            _FileForwardAmerican.WriteLine("SIDE BUYER");
            _FileForwardAmerican.WriteLine("FAMILY ONE_STRIKE");
            _FileForwardAmerican.WriteLine(string.Format("STRIKE {0}", (__Strike + delta).ToString().Replace(",", ".")));
            _FileForwardAmerican.WriteLine(string.Format("GENUS {0}", __Gennus));
            _FileForwardAmerican.WriteLine("SPECIE FORWARD");
            _FileForwardAmerican.WriteLine("EXERCIZE AMERICAN");
            _FileForwardAmerican.WriteLine(string.Format("DATE_EXERCIZE 1 {0}", __ExpiryDate.ToOADate().ToString("0.0").Replace(",", ".")));
            _FileForwardAmerican.WriteLine("PATH_DEPENDENCY NONE");
            //_FileForwardAmerican.WriteLine(string.Format("LIMIT {0}", __Position.Equals("LONG") ? "LOWER" : "UPPER"));
            _FileForwardAmerican.WriteLine("LIMIT UPPER");
            _FileForwardAmerican.WriteLine("NUMBER_PRODUCTS 1");
            _FileForwardAmerican.WriteLine(string.Format("PRODUCT_FILENAME {0}", __EuropeanForwardFileName));

            _FileForwardAmerican.Close();

            return __FileForwardAmerican;
        }

        private void SaveValuator(ref int id)
        {
            __EuropeanForwardID = id;
            __FileNames.Add(SaveForwardEuropean(id, 0));
            id++;
            __AmericanForwardID = id;
            __FileNames.Add(SaveForwardAmerican(id, 0));
            id++;
        }

        private void SetPricing(PricingEngine pEng)
        {

        }

        private void SaveSolver(ref int id)
        {
            __SolverEuropeanForwardID = id;
            __FileNames.Add(SaveForwardEuropean(id, 0.01));
            id++;
            __SolverAmericanForwardID = id;
            __FileNames.Add(SaveForwardAmerican(id, 0.01));
            id++;

            __EuropeanForwardID = id;
            __FileNames.Add(SaveForwardEuropean(id, 0));
            id++;
            __AmericanForwardID = id;
            __FileNames.Add(SaveForwardAmerican(id, 0));
            id++;
        }

        private void Clear()
        {
            __ListYieldDomestic = new List<FASensitivity>();
            __ListYieldForeign = new List<FASensitivity>();
        }

        private void Add(int yield, int tenor, double delta, double gamma)
        {
            FASensitivity _Value = new FASensitivity(tenor, delta, gamma);

            if (yield.Equals(0))
            {
                __ListYieldDomestic.Add(_Value);
            }
            else if (yield.Equals(1))
            {
                __ListYieldForeign.Add(_Value);
            }
        }

        #endregion

        #region Metodos Publicos

        public void Set()
        {
            __Set(0, 0, "", 0, 0, new DateTime(), "", "");
        }

        public void Set(long operationnumber, long structureid, string structuretype, double notional, double strike, DateTime expirydate, string position, string gennus)
        {
            __Set(operationnumber, structureid, structuretype, notional, strike, expirydate, position, gennus);
        }

        public void Set(ForwardAmerican value)
        {
            __Set(value.OperationNumber, value.StructureID, value.StructureType, value.Notional, value.Strike, value.ExpiryDate, value.Position, value.Gennus);
        }

        public void Set(XElement value)
        {
            __Set(
                   long.Parse(value.Attribute("OperationNumber").Value),
                   long.Parse(value.Attribute("StructureID").Value),
                   value.Attribute("StructureType").Value,
                   double.Parse(value.Attribute("Notional").Value),
                   double.Parse(value.Attribute("Strike").Value),
                   DateTime.Parse(value.Attribute("ExpiryDate").Value),
                   value.Attribute("Position").Value.Equals("C") ? "LONG" : "SHORT",
                   value.Attribute("Gennus").Value.TrimEnd()
                 );
        }

        public void CalculateForwardTheorical()
        {
            __Tenor = (int)(__ExpiryDate.ToOADate() - __ValuatorDate.ToOADate());
            __RateDomestic = __YieldList.Read(Global.YieldDomestic, enumSource.System, __ValuatorDate, Tenor).Rate;
            __RateForeign = __YieldList.Read(Global.YieldForeign, enumSource.System, __ValuatorDate, Tenor).Rate;

            //DMATAMALA_20110510 cambio forma calcular precio forward de lineal a compuesta.
            //__Forward = __Spot * (1.0 + __RateDomestic * 0.01 * __Tenor / 360.0) / (1.0 + __RateForeign * 0.01 * __Tenor / 360.0);
            __Forward = __Spot * Math.Pow(1.0 + __RateDomestic * 0.01, __Tenor / 360.0) / Math.Pow(1.0 + __RateForeign * 0.01, __Tenor / 360.0);

            __PointForward = __Forward - __Spot;
            __Volatility = 0;
        }

        public void SetEngine(PricingEngine pEng)
        {
            __Versus = __Notional * __Strike;
            int _Index = (pEng.report[0].Count() <= __AmericanForwardID) ? 0 : __AmericanForwardID;

            __MTM = pEng.report[0][_Index].price * __Notional;
            __Delta = pEng.report[0][_Index].delta.get(2) * 100.0;
            __DeltaSpot = pEng.report[0][_Index].delta.get(2) * __Notional;
            __DeltaForward = 0;
            __Gamma = pEng.report[0][_Index].gamma.get(2, 2) * __Notional;
            __Vega = 0;
            __RhoDom = pEng.report[0][_Index].delta.get(0) / 10000.0 * __Notional;
            __RhoFor = pEng.report[0][_Index].delta.get(1) / 10000.0 * __Notional;

            __Theta = CheckValue(pEng.report[0][_Index].theta) / 365.0 * __Notional;
            //ASVG_20110308 Charm nulo para operación con vencimiento hoy.
            if ( pEng.report[0][_Index].charm == null )
            {
                __Charm = 0;
            }
            else
            {
                __Charm = CheckValue(pEng.report[0][_Index].charm.get(2)) / 365.0 * __Notional;
            }
            
            __Vanna = 0;
            __Volga = 0;

            if (__IsGreek)
            {
                for (int _Point = 0; _Point < pEng.report[0][0].topology[1].gamma.numberData; _Point++)
                {
                    Add(
                         0,
                         __YieldList.Read(__YieldDomestic, enumSource.System, __ValuatorDate).Point(_Point).Term,
                         pEng.report[0][_Index].topology[1].delta.get(_Point),
                         pEng.report[0][_Index].topology[1].gamma.get(_Point)
                       );
                }

                for (int _Point = 0; _Point < pEng.report[0][0].topology[2].gamma.numberData; _Point++)
                {
                    Add(
                         1,
                         __YieldList.Read(__YieldForeign, enumSource.System, __ValuatorDate).Point(_Point).Term,
                         pEng.report[0][_Index].topology[2].delta.get(_Point),
                         pEng.report[0][_Index].topology[2].gamma.get(_Point)
                       );
                }
            }
        }

        private double CheckValue(double value)
        {
            return (value.Equals(double.NaN) || value.Equals(null)) ? 0 : value;
        }

        public void Save(ref int id)
        {
            __FileNames = new List<string>();
            if (__IsSolver)
            {
                SaveSolver(ref id);
            }
            else
            {
                SaveValuator(ref id);
            }
        }

        public string ResultPricing()
        {
            string _Result = "";

            _Result += string.Format("\t<Opcion NumContrato='{0}' NumEstructura='{1}' >\n", __OperationNumber, __StructureID);
            _Result += "\t\t<detContrato>\n";
            _Result += "\t\t\t<Estructura MoNumFolio='' MoNumEstructura='1' MoVinculacion='Individual' />\n";

            _Result += string.Format(
                                      "\t\t\t<DetallesOpcion MoTipoOpc='{0}' MoSubyacente='FX' MoTipoPayOff='01' MoCallPut='{1}' MoCVOpc='{4}' " +
                                      "MoTipoEmisionPT='T' MoFechaInicioOpc='{2}' MoFechaFijacion='{3}' />\n",
                                      "E", //__Position.Equals("LONG") ? "C" : "V",
                                      __Gennus,
                                      __ValuatorDate.ToString("dd/MM/yyyy"),
                                      __ExpiryDate.ToString("dd/MM/yyyy"),
                                      __Position.Equals("LONG") ? "C" : "V"
                                    );

            _Result += string.Format("\t\t\t<Vencimiento 	MoFechaVcto='{0}' />\n", __ExpiryDate.ToString("dd/MM/yyyy"));

            _Result += string.Format(
                                      "\t\t\t<Subyacente MoFormaPagoMon1='' MoFechaPagMon1='{0}' MoFormaPagoMon2='' MoFechaPagMon2='{0}' " +
                                      "MoFechaPagoEjer='{0}' MoCodMon1='' MoMontoMon1='{1}' MoCodMon2='' MoMontoMon2='{2}' " +
                                      "MoModalidad='' MoMdaCompensacion='' MoFormaPagoComp='' MoBenchComp='994' MoParStrike='CLP/USD' MoStrike='{3}' " +
                                      "MoPorcStrike='' MoTipoEjercicio='A' />\n",
                                      __ExpiryDate.ToString("dd/MM/yyyy"),
                                      __Notional,
                                      __Versus,
                                      __Strike
                                    );

            _Result += string.Format("\t\t\t<Proceso MoSpotDet='{0}' />\n", __Spot);

            _Result += string.Format("\t\t\t<Curvas MoCurveMon1='{0}' MoCurveMon2='{1}' MoCurveSmile='' />\n", __YieldDomestic, __YieldForeign);

            _Result += string.Format(
                                      "\t\t\t<MtM MoWf_mon1='{0}' MoWf_mon2='{1}' MoVol='{2}' MoFwd_teo='{3}' MoVrDet='{4}' MoSpotDetCosto='' " +
                                      "MoWf_Mon1_Costo='' MoWf_Mon2_Costo='' MoVol_Costo='' MoFwd_Teo_Costo='' MoVr_Costo='' MoVr_CostoDet='' " +
                                      "MoPrimaBSSpotDet='' MoIteAsoSis='' MoIteAsoCon='' />\n",
                                      __RateDomestic,
                                      __RateForeign,
                                      0,
                                      __Forward,
                                      __MTM
                                    );

            _Result += string.Format(
                                      "\t\t\t<Griegas MoDelta_spot='{0}' MoDelta_spot_num='' MoDelta_fwd='{1}' MoDelta_fwd_num='' MoGamma_spot='{2}' " +
                                      "MoGamma_spot_num='' MoGamma_fwd='' MoGamma_fwd_num='' MoVega='{3}' MoVega_num='' MoVanna_spot='{4}' MoVanna_spot_num='' " +
                                      "MoVanna_fwd='' MoVanna_fwd_num='' MoVolga='{5}' MoVolga_num='' MoTheta='{6}' MoTheta_num='' MoRho='{7}' " +
                                      "MoRho_num='' MoRhof='{8}' MoRhof_num='' MoCharm_spot='{9}' MoCharm_spot_num='' " +
                                      "MoCharm_fwd='' MoCharm_fwd_num=''  />\n",
                                      __DeltaSpot,
                                      __DeltaForward,
                                      __Gamma,
                                      __Vega,
                                      __Vanna,
                                      __Volga,
                                      __Theta,
                                      __RhoDom,
                                      __RhoFor,
                                      __Charm
                                    );
            _Result += "\t\t</detContrato>\n";
            _Result += string.Format(
                                      "\t\t<GriegasMonto Delta='{0}' DeltaForward='{1}' Gamma='{2}' Vega='{3}' Vanna='{4}' Volga='{5}' Theta='{6}' Rho='{7}' " +
                                      "Rhof='{8}' Charm='{9}' />\n",
                                      __DeltaSpot,
                                      __DeltaForward,
                                      __Gamma,
                                      __Vega,
                                      __Vanna,
                                      __Volga,
                                      __Theta,
                                      __RhoDom,
                                      __RhoFor,
                                      __Charm
                                    );

            _Result += "\t\t<Sensivility>\n";
            _Result += "\t\t\t<Domestic>\n";
            foreach (FASensitivity _Value in __ListYieldDomestic)
            {
                _Result += string.Format("\t\t\t\t{0}", _Value.ToXML(__Notional));
            }
            _Result += "\t\t</Domestic>\n";
            _Result += "\t\t\t<Foreign>\n";
            foreach (FASensitivity _Value in __ListYieldForeign)
            {
                _Result += string.Format("\t\t\t\t{0}", _Value.ToXML(__Notional));
            }
            _Result += "\t\t\t</Foreign>\n";
            _Result += "\t\t</Sensivility>\n";
            _Result += "\t</Opcion>\n";

            return _Result;
        }

        public void Solver(PricingEngine pEng)
        {
            pEng.zero("1", __Objetive);
            __Strike = Math.Round(((OneStrike)pEng.portfolio.product[0].family).strike, 2);
        }

        #endregion

    }
}
