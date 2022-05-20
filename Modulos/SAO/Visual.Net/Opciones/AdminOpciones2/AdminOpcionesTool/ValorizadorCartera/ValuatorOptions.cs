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

    public static class ValuatorOptions
    {

        #region Atributos Privados

        private static cFinancialTools.BussineDate.Calendars __Calendar = new cFinancialTools.BussineDate.Calendars();
        private static List<ForwardAmerican> __ForwardAmericanList = new List<ForwardAmerican>();
        private static string __YieldDomestic = "";
        private static string __YieldForeign = "";
        private static int __SetPrice = 0;
        private static YieldList __YieldList = new YieldList();
        private static string[] __YieldListName;
        private static DateTime __ValuatorDate = new DateTime();
        private static double __Spot = 0;

        private static string __FileExecuting = Global.ServiceConnect + "PRICING_RUN.txt";
        private static string __FileProductMaster = Global.ServiceConnect + "PRODUCT_MASTER_FILE.txt";
        private static string __FileNameSpot = Global.ServiceConnect + "QUOTE-MARKET-0-MARKET_MAKER-0-MID_0.txt";
        private static string __FileYieldForeign = Global.ServiceConnect + "QUOTE-MARKET-2-MARKET_MAKER-0-MID_0.txt";
        private static string __FileYieldDomestic = Global.ServiceConnect + "QUOTE-MARKET-1-MARKET_MAKER-0-MID_0.txt";
        private static bool __IsValuator = true;
        private static bool __IsGreek = false;
        private static bool __Solver = false;
        private static double __Objetive = 0;

        private static List<string> __FileNameList = new List<string>();

        #endregion

        //alanrevisar
        public static bool FilesConfig()
        {

            SaveFileExecuting();

            bool FilesConfigOk = ExistFileExecuting();

            DeleteFileExecuting();

            return FilesConfigOk;
        }

        #region Valuator & Solver Structure

        public static string Valuator(string value)
        {
            try
            {
                __IsValuator = true;
                __IsGreek = false;
                __Solver = false;

                while (ExistFileExecuting())
                {
                    for (int _Timer = 0; _Timer < 20000; _Timer++) { }
                }

                SaveFileExecuting();

                __Calendar.Load();
                SettingData(value);
                GenerateFile();

                Pricing(false);

                if (ExistFileExecuting())
                {
                    DeleteFileExecuting();
                }

                return ResultPricing();
            }
            catch (Exception e)
            {
                if (ExistFileExecuting())
                {
                    DeleteFileExecuting();
                }
                return e.Message;
            }
        }

        public static string Solver(string value)
        {
            try
            {
                __IsValuator = true;
                __IsGreek = false;
                __Solver = true;

                while (ExistFileExecuting())
                {
                    for (int _Timer = 0; _Timer < 20000; _Timer++)
                    {
                    }
                }

                SaveFileExecuting();

                __Calendar.Load();
                SettingData(value);
                GenerateFile();

                Pricing(true);

                if (ExistFileExecuting())
                {
                    DeleteFileExecuting();
                }
                return ResultPricing();
            }
            catch (Exception e)
            {
                if (ExistFileExecuting())
                {
                    DeleteFileExecuting();
                }
                return e.Message;
            }
        }

        public static string Sensivility(string value, string sensitivity)
        {
            try
            {
                __IsValuator = true;
                __IsGreek = false;
                __Solver = false;

                while (ExistFileExecuting())
                {
                    for (int _Timer = 0; _Timer < 20000; _Timer++)
                    {
                    }
                }

                SaveFileExecuting();

                __Calendar.Load();
                SettingData(value);
                GenerateFile();
                Pricing(false);

                if (ExistFileExecuting())
                {
                    DeleteFileExecuting();
                }
                return ResultSensitivity(sensitivity);
            }
            catch (Exception e)
            {
                if (ExistFileExecuting())
                {
                    DeleteFileExecuting();
                }
                return e.Message;
            }
        }

        #endregion

        #region Metodos Privados

        private static void SettingData(string value)
        {
            XDocument _XMLValue = XDocument.Parse(value);
            XElement _XMLElement = _XMLValue.Element("Pricing");

            __YieldListName = _XMLElement.Element("Data").Element("Yields").Attribute("Value").Value.Split(',');
            __SetPrice = int.Parse(_XMLElement.Element("Data").Attribute("SetPrice").Value);
            __YieldDomestic = _XMLElement.Element("Data").Element("Yields").Element("Domestic").Attribute("YieldName").Value;
            __YieldForeign = _XMLElement.Element("Data").Element("Yields").Element("Foreign").Attribute("YieldName").Value;
            __YieldList.SetPrincingLoading = __SetPrice.Equals(0) ? enumSetPrincingLoading.OrginalSystem : enumSetPrincingLoading.Costo;
            __ValuatorDate = DateTime.Parse(_XMLElement.Element("Data").Attribute("ValuatorDate").Value);
            __Spot = double.Parse(_XMLElement.Element("Data").Element("Spot").Attribute("Value").Value);
            __IsGreek = _XMLElement.Element("Data").Attribute("IsGreek").Value.Equals("Y") ? true : false; // IsGreek

            Global.YieldDomestic = __YieldDomestic;
            Global.YieldForeign = __YieldForeign;

            __YieldList = new YieldList();

            foreach (string _YieldName in __YieldListName)
            {
                __YieldList.Load(_YieldName, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, __ValuatorDate);
            }

            ForwardAmerican _Ticket = new ForwardAmerican();
            __ForwardAmericanList = new List<ForwardAmerican>();

            foreach (XElement _Element in _XMLElement.Element("Tickets").Elements("Ticket"))
            {
                _Ticket = new ForwardAmerican(_Element);
                _Ticket.ValuatorDate = __ValuatorDate;
                _Ticket.Spot = __Spot;
                _Ticket.Yield = __YieldList;
                _Ticket.CalculateForwardTheorical();
                if (__Solver)
                {
                    __Objetive = double.Parse(_Element.Attribute("MTM").Value);
                    _Ticket.Objetive = double.Parse(_Element.Attribute("MTM").Value);
                }
                else
                {
                    __Objetive = 0;
                    _Ticket.Objetive = 0;
                }
                __ForwardAmericanList.Add(_Ticket);
            }
        }

        private static void GenerateFile()
        {
            int _ID = 0;

            __FileNameList = new List<string>();

            SaveQuoteSpot(__ValuatorDate.ToOADate(), __Spot);
            SaveQuoteYield(__ValuatorDate.ToOADate(), __YieldForeign, __FileYieldForeign);
            SaveQuoteYield(__ValuatorDate.ToOADate(), __YieldDomestic, __FileYieldDomestic);

            foreach (ForwardAmerican _Ticket in __ForwardAmericanList)
            {

                _Ticket.IsSolver = !__IsValuator;
                _Ticket.Save(ref _ID);
                foreach (string _FileName in _Ticket.FileNames)
                {
                    __FileNameList.Add(_FileName);
                }
            }

            SaveProductMasterFile(__FileNameList);
        }

        private static string ResultPricing()
        {
            string _Result = "";

            cFinancialTools.Currency.CurrencyList _Currency = new cFinancialTools.Currency.CurrencyList();
            _Currency.Load(994, enumSource.System, __ValuatorDate, "");

            double _Dolar = _Currency.Read(994, enumSource.System, __ValuatorDate).ExchangeRate;

            _Result += string.Format("<ObservedDollar Value='{0}' />", _Dolar);

            foreach (ForwardAmerican _Value in __ForwardAmericanList)
            {
                _Result += _Value.ResultPricing();
            }

            return _Result;
        }

        private static string ResultSensitivity(string value)
        {
            #region Definición Atributos de la Función
            string _Result = "";
            int _Tenor = 0;
            double _DV01Pos = 0;
            double _DV01Neg = 0;
            double _MTM = 0;
            List<Sensitivity> _Value;
            List<Sensitivity> _SensitivityDomestic = new List<Sensitivity>();
            List<Sensitivity> _SensitivityForeign = new List<Sensitivity>();
            #endregion

            #region Parse de la sensibilidad de los otros contratos

            XDocument _xmlValue = XDocument.Parse(value);

            #endregion

            #region Lee la sensibilidad de los otros contratos de opciones
            try
            {
                #region Sensibilidad Curva Domestica

                foreach (XElement _Sensitivity in _xmlValue.Element("Sensitivity").Element(Global.YieldDomestic).Elements("Value"))
                {
                    _SensitivityDomestic.Add(new Sensitivity(_Sensitivity));
                }

                #endregion

                #region Sensibilidad Curva Foranea

                foreach (XElement _Sensitivity in _xmlValue.Element("Sensitivity").Element(Global.YieldForeign).Elements("Value"))
                {
                    _SensitivityForeign.Add(new Sensitivity(_Sensitivity));
                }

                #endregion
            }
            catch
            {
            }
            #endregion

            #region Merge de sensibilidades

            #region Curva Domestica

            for (int _Point = 0; _Point < __YieldList.Read(Global.YieldDomestic, enumSource.System, __ValuatorDate).Count; _Point++)
            {
                _Tenor = __YieldList.Read(Global.YieldDomestic, enumSource.System, __ValuatorDate).Point(_Point).Term;
                _DV01Pos = 0;
                _DV01Neg = 0;
                _MTM = 0;

                foreach (ForwardAmerican _Contract in __ForwardAmericanList)
                {
                    _DV01Pos += _Contract.ListYieldDomestic[_Point].DV01Pos * _Contract.Notional;
                    _DV01Neg += _Contract.ListYieldDomestic[_Point].DV01Neg * _Contract.Notional;
                    _MTM += _Contract.MTM;
                }

                _Value = _SensitivityDomestic.Where(_Element => _Element.Tenor.Equals(_Tenor)).ToList();

                if (_Value.Count > 0)
                {
                    _Value[0].Add(_MTM, _DV01Pos);
                }
                else
                {
                    _SensitivityDomestic.Add(new Sensitivity(_Tenor, _MTM, _MTM + _DV01Pos, _DV01Pos));
                }
            }

            #endregion

            #region Curva Foranea

            for (int _Point = 0; _Point < __YieldList.Read(Global.YieldForeign, enumSource.System, __ValuatorDate).Count; _Point++)
            {
                _Tenor = __YieldList.Read(Global.YieldForeign, enumSource.System, __ValuatorDate).Point(_Point).Term;
                _DV01Pos = 0;
                _DV01Neg = 0;
                _MTM = 0;

                foreach (ForwardAmerican _Contract in __ForwardAmericanList)
                {
                    _DV01Pos += _Contract.ListYieldForeign[_Point].DV01Pos * _Contract.Notional;
                    _DV01Neg += _Contract.ListYieldForeign[_Point].DV01Neg * _Contract.Notional;
                    _MTM += _Contract.MTM;
                }
                _Value = _SensitivityForeign.Where(_Element => _Element.Tenor.Equals(_Tenor)).ToList();

                if (_Value.Count > 0)
                {
                    _Value[0].Add(_MTM, _DV01Pos);
                }
                else
                {
                    _SensitivityForeign.Add(new Sensitivity(_Tenor, _MTM, _MTM + _DV01Pos, _DV01Pos));
                }

            }

            #endregion

            #endregion

            #region Genera Resultado Final
            _Result += "<Sensitivity>\n";

            #region Curva Domestica
            _Result += string.Format("\t<{0}>\n", Global.YieldDomestic);
            foreach (Sensitivity _Sensitiviy in _SensitivityDomestic)
            {
                _Result += string.Format("\t\t{0}\n", _Sensitiviy.ToXML());
            }
            _Result += string.Format("\t</{0}>\n", Global.YieldDomestic);
            #endregion

            #region Curva Foranea
            _Result += string.Format("\t<{0}>\n", Global.YieldForeign);
            foreach (Sensitivity _Sensitiviy in _SensitivityForeign)
            {
                _Result += string.Format("\t\t{0}\n", _Sensitiviy.ToXML());
            }
            _Result += string.Format("\t</{0}>\n", Global.YieldForeign);
            #endregion

            _Result += "</Sensitivity>\n";
            #endregion

            return _Result;
        }

        private static void Pricing(bool solver)
        {
            #region Motor

            Church church = null;

            int _CountProduct = __FileNameList.Count;

            church = Church.load("CHURCH.txt");

            if (!solver)
            {
                DeleteFileExecuting();
            }

            List<Product> _ProductList = new List<Product>();

            for (int _Contract = 0; _Contract < _CountProduct; _Contract++)
            {
                Product pdct = (Product)church.informationBoard.search(enumInformationType.PRODUCT, _Contract);
                pdct.status.isOriginal = true;
                _ProductList.Add(pdct);
            }

            PricingEngine pEng;
            StopWatch s = new StopWatch();
            s.Start();
            pEng = church.engineBoard.pricingEngine[5];

            foreach (Product _Product in _ProductList)
            {
                _Product.status.isOriginal = true;
                pEng.portfolio.add(_Product);
            }

            #endregion

            if (solver)
            {
                pEng.portfolio.clearAll();
                if (_ProductList != null)
                    foreach (Product pdct in _ProductList)
                        pdct.status = new Status();
                pEng.portfolio.addOriginal(_ProductList[1]);
                pEng.zero("1", __Objetive / __ForwardAmericanList[0].Notional);
                __ForwardAmericanList[0].Strike = Math.Round(((OneStrike)_ProductList[1].family).strike, 2);
                ((OneStrike)pEng.portfolio.product[0].family).strike = __ForwardAmericanList[0].Strike;
                ((Jacques.OneStrike)pEng.portfolio.product[0].interval.limit(0).product[0].family).strike = __ForwardAmericanList[0].Strike;
                //((OneStrike)pEng.portfolio.product[1].family).strike = __ForwardAmericanList[0].Strike;
                pEng.run();
            }
            else
            {
            pEng.run();

                if (__IsGreek)
            {
                pEng.greek();
            }
            }

            #region Seting Motor Data

            int _TicketID = 0;
            foreach (ForwardAmerican _Ticket in __ForwardAmericanList)
            {
                _TicketID = _Ticket.AmericanForwardID;
                _Ticket.IsGreek = __IsGreek;
                _Ticket.SetEngine(pEng);
            }

            #endregion
        }

        private static void SaveQuoteSpot(double date, double spot)
        {
            FileStream _StreamSpot = new FileStream(__FileNameSpot, FileMode.OpenOrCreate, FileAccess.Write);
            StreamWriter _FileSpot = new StreamWriter(_StreamSpot);
            _FileSpot.WriteLine(string.Format("DAY {0}", date.ToString("0.0").Replace(",", ".")));
            _FileSpot.WriteLine(string.Format("DATA 1 1 {0}", spot.ToString().Replace(",", ".")));
            _FileSpot.Close();
        }

        private static void SaveQuoteYield(double date, string yieldname, string filename)
        {
            int _Element = 0;
            string _Data = "";
            string _Tenor = "";
            double _Rate = 0;
            double _Day = 0;
            double _FD = 0;

            for (int _T = 0; _T < __YieldList.Read(yieldname, enumSource.System, __ValuatorDate).Count; _T++) // _Value in value.Descendants("Value"))
            {
                YieldPoint _YieldPoint = __YieldList.Read(yieldname, enumSource.System, __ValuatorDate).Point(_T);

                _Element++;
                _Day = (double)_YieldPoint.Term;
                _Rate = _YieldPoint.Rate;
                _FD = Math.Log(1.0 / Math.Pow(( 1.0 + _Rate * 0.01), (_Day / 360)));
                //_FD = Math.Log(1.0 / (1.0 + _Rate * 0.01 * _Day / 360));

                _Data += _FD.ToString().Replace(",", ".") + " ";
                _Tenor += (_Day + date).ToString().Replace(",", ".") + " ";
            }

            FileStream _StreamYield = new FileStream(filename, FileMode.OpenOrCreate, FileAccess.Write);
            StreamWriter _FileYield = new StreamWriter(_StreamYield);
            _FileYield.WriteLine(string.Format("DAY {0}", date.ToString("0.0").Replace(",", ".")));
            _FileYield.WriteLine(string.Format("DATA 1 {0} {1}", _Element, _Data.TrimEnd()));
            _FileYield.WriteLine(string.Format("TENOR {0} {1}", _Element, _Tenor.TrimEnd()));
            _FileYield.Close();
        }

        private static void SaveProductMasterFile(List<string> productlist)
        {
            FileStream _StreamProductMasterFile = new FileStream(__FileProductMaster, FileMode.OpenOrCreate, FileAccess.Write);
            StreamWriter _FileProductMasterFile = new StreamWriter(_StreamProductMasterFile);

            _FileProductMasterFile.WriteLine("NUMBER_PRODUCTS {0}", productlist.Count);

            foreach (string _FileName in productlist)
            {
                _FileProductMasterFile.WriteLine(string.Format("PRODUCT_FILENAME {0}", _FileName));
            }

            _FileProductMasterFile.Close();
        }

        private static void SaveFileExecuting()
        {
            FileStream _StreamFileExecuting = new FileStream(__FileExecuting, FileMode.OpenOrCreate, FileAccess.Write);
            StreamWriter _FileExecuting = new StreamWriter(_StreamFileExecuting);

            _FileExecuting.WriteLine("EXECUTING");

            _FileExecuting.Close();
        }

        private static bool ExistFileExecuting()
        {
            return File.Exists(__FileExecuting);
        }

        private static void DeleteFileExecuting()
        {
            FileInfo _FileExecuting = new FileInfo(__FileExecuting);
            _FileExecuting.Delete();
        }

        #endregion

    }

}