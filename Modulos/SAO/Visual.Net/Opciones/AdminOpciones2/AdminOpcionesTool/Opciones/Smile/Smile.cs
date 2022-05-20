using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using cData.Opciones;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using cFinancialTools.Yield;
using cFinancialTools.DayCounters;
using cFinancialTools.BussineDate;


namespace AdminOpcionesTool.Opciones.SmileNameSpace
{
    public class Smile
    {
        
        public string Paridad { get; set; }
        public string CurvaDom { get; set; }
        public string CurvaFor { get; set; }
        public DateTime FechaSmile { get; set; }
        public int  FlagSmile;
        public double Spot { get; set; }
        //public string ATMRRFLY = "";

        public List<int> Tenors {get;set;}
        public List<List<double>> Volas { get; set; }
        public List<List<double>> Strikes { get; set; }

        public List<List<double>> SmileList;

        public enumSetPrincingLoading SetPricing{get;set;}

        public Smile() { }

        public Smile(DateTime Fecha_Smile, string paridad, double spot ,string curvaDom, string curvaFor, int flagSmile)
        {
            this.Paridad = paridad;
            this.FechaSmile = Fecha_Smile;
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.FlagSmile = flagSmile;
            this.Spot = spot;

            this.Tenors = new List<int>();
            this.Volas = new List<List<double>>();
            this.Strikes = new List<List<double>>();
        }


        public Smile(DateTime Fecha_Smile, string paridad,double spot, string curvaDom, string curvaFor, List<int> tenors, List<List<double>> volas, List<List<double>> strikes, int flagSmile)
        {
            this.Paridad = paridad;
            this.FechaSmile = Fecha_Smile;
            this.Spot = spot;
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.FlagSmile = flagSmile;
            this.Tenors = tenors;
            this.Volas = volas;
            this.Strikes = strikes;
        }

        //public void Load()
        //{
        //    Load(enumSetPrincingLoading.OrginalSystem);
 
        //}
       
        public void Load(enumSetPrincingLoading setPricing)
        {

            this.SetPricing = setPricing;

            DataTable smileDataTable = new DataTable();

            switch (setPricing)
            {
                case enumSetPrincingLoading.OrginalSystem:

                    smileDataTable = cData.Opciones.Smiles.LoadSmiles(this.FechaSmile, this.Paridad);
                    break;
                
                case enumSetPrincingLoading.Costo:

                    smileDataTable = cData.Opciones.Smiles.LoadSmilesPricing(this.FechaSmile, this.Paridad, 2);
                    break;
            }
            

            //GenerateSmileATMRRFLY

            DataRow _DataRow;            

            SmileList = new List<List<double>>();

            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());

            for (int _Row = 1; _Row <= smileDataTable.Rows.Count; _Row++)
            {

                _DataRow = smileDataTable.Rows[_Row - 1];
                /*
                switch (_Row % 5)
                {
                    case 1://Tenor, ATM                     
                        SmileList[0].Add(double.Parse(_DataRow["SmlDias"].ToString()));
                        SmileList[1].Add(double.Parse(_DataRow["SmlMid"].ToString()));
                        break;
                    case 2://10DRR
                        SmileList[2].Add(double.Parse(_DataRow["SmlMid"].ToString()));
                        break;
                    case 3://10DBF
                        SmileList[3].Add(double.Parse(_DataRow["SmlMid"].ToString()));
                        break;
                    case 4://25DRR
                        SmileList[4].Add(double.Parse(_DataRow["SmlMid"].ToString()));
                        break;
                    case 0://25DBF
                        SmileList[5].Add(double.Parse(_DataRow["SmlMid"].ToString()));
                        break;
                } */
                if (_DataRow["SmlEstructura"].ToString().Equals("1") && _DataRow["SmlDelta"].ToString().Equals("0"))         // ATM
                {

                    SmileList[0].Add(double.Parse(_DataRow["SmlDias"].ToString()));

                    SmileList[1].Add(double.Parse(_DataRow["SmlMid"].ToString()));

                }

                else if (_DataRow["SmlEstructura"].ToString().Equals("2") && _DataRow["SmlDelta"].ToString().Equals("10"))   // 10DRR
                {

                    SmileList[2].Add(double.Parse(_DataRow["SmlMid"].ToString()));

                }

                else if (_DataRow["SmlEstructura"].ToString().Equals("3") && _DataRow["SmlDelta"].ToString().Equals("10"))   // 10DBF
                {

                    SmileList[3].Add(double.Parse(_DataRow["SmlMid"].ToString()));

                }

                else if (_DataRow["SmlEstructura"].ToString().Equals("2") && _DataRow["SmlDelta"].ToString().Equals("25"))   // 25DRR
                {

                    SmileList[4].Add(double.Parse(_DataRow["SmlMid"].ToString()));

                }

                else if (_DataRow["SmlEstructura"].ToString().Equals("3") && _DataRow["SmlDelta"].ToString().Equals("25"))   // 25DBF
                {

                    SmileList[5].Add(double.Parse(_DataRow["SmlMid"].ToString()));

                }


            }            
            

            this.Tenors = new List<int>();
            this.Volas = new List<List<double>>();
            this.Strikes = new List<List<double>>();

            //GenerateSmileCallPut
            int N = SmileList[0].Count;

            double sig_call_25, sig_put_25, sig_call_10, sig_put_10;

            for (int i = 0; i < N; i++)
            {
                sig_call_25 = SmileList[1][i] + SmileList[5][i] + 0.5 * SmileList[4][i];
                sig_put_25 = SmileList[1][i] + SmileList[5][i] - 0.5 * SmileList[4][i];
                sig_call_10 = SmileList[1][i] + SmileList[3][i] + 0.5 * SmileList[2][i];
                sig_put_10 = SmileList[1][i] + SmileList[3][i] - 0.5 * SmileList[2][i];

                Tenors.Add((int)SmileList[0][i]);
                Volas.Add(new List<double>());

                Volas[i].Add(sig_put_10);
                Volas[i].Add(sig_put_25);
                Volas[i].Add(SmileList[1][i]);
                Volas[i].Add(sig_call_25);
                Volas[i].Add(sig_call_10);               
            }          


            string strikesString = this.inversion_strikes(setPricing);

            XDocument StrikeXdoc = new XDocument();
            StrikeXdoc = XDocument.Parse(strikesString);

            var smileStrikeVars = from itemStrike in StrikeXdoc.Descendants("DataStrikes")
                                  select new StructSmileCallPut
                                  {
                                      Tenor = int.Parse(itemStrike.Attribute("Tenor").Value.ToString()),
                                      Put10 = double.Parse(itemStrike.Attribute("Put10").Value.ToString()),
                                      Put25 = double.Parse(itemStrike.Attribute("Put25").Value.ToString()),
                                      Atm = double.Parse(itemStrike.Attribute("Atm").Value.ToString()),
                                      Call25 = double.Parse(itemStrike.Attribute("Call25").Value.ToString()),
                                      Call10 = double.Parse(itemStrike.Attribute("Call10").Value.ToString())
                                  };



            for (int j = 0; j < smileStrikeVars.ToList().Count; j++)
            {
                Strikes.Add(new List<double>());
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Put10);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Put25);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Atm);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Call25);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Call10);
            }

        }

        private void Copy(Smile SmileToDuplicate)
        {
            try
            {
                this.Tenors = new List<int>();
                this.SmileList = new List<List<double>>();
                this.Volas = new List<List<double>>();
                this.Strikes = new List<List<double>>();
                this.FechaSmile = new DateTime(SmileToDuplicate.FechaSmile.Year,SmileToDuplicate.FechaSmile.Month, SmileToDuplicate.FechaSmile.Day);

                this.Spot = SmileToDuplicate.Spot;
                this.Paridad = SmileToDuplicate.Paridad;
                this.CurvaDom = SmileToDuplicate.CurvaDom;
                this.CurvaFor = SmileToDuplicate.CurvaFor;
                this.FlagSmile = SmileToDuplicate.FlagSmile;

                SmileList.Add(new List<double>());
                SmileList.Add(new List<double>());
                SmileList.Add(new List<double>());
                SmileList.Add(new List<double>());
                SmileList.Add(new List<double>());
                SmileList.Add(new List<double>());

                List<double> itemVolas, itemStrikes;
                for (int i = 0; i < SmileToDuplicate.Tenors.Count; i++)
                {
                    this.Tenors.Add(SmileToDuplicate.Tenors[i]);

                   

                    this.SmileList[0].Add(SmileToDuplicate.SmileList[0][i]);
                    this.SmileList[1].Add(SmileToDuplicate.SmileList[1][i]);
                    this.SmileList[2].Add(SmileToDuplicate.SmileList[2][i]);
                    this.SmileList[3].Add(SmileToDuplicate.SmileList[3][i]);
                    this.SmileList[4].Add(SmileToDuplicate.SmileList[4][i]);
                    this.SmileList[5].Add(SmileToDuplicate.SmileList[5][i]);

                    itemVolas = new List<double>();
                    itemStrikes = new List<double>();

                    itemVolas.Add(SmileToDuplicate.Volas[i][0]);
                    itemVolas.Add(SmileToDuplicate.Volas[i][1]);
                    itemVolas.Add(SmileToDuplicate.Volas[i][2]);
                    itemVolas.Add(SmileToDuplicate.Volas[i][3]);
                    itemVolas.Add(SmileToDuplicate.Volas[i][4]);

                    this.Volas.Add(itemVolas);


                    itemStrikes.Add(SmileToDuplicate.Strikes[i][0]);
                    itemStrikes.Add(SmileToDuplicate.Strikes[i][1]);
                    itemStrikes.Add(SmileToDuplicate.Strikes[i][2]);
                    itemStrikes.Add(SmileToDuplicate.Strikes[i][3]);
                    itemStrikes.Add(SmileToDuplicate.Strikes[i][4]);

                    this.Strikes.Add(itemStrikes);



     
                }

                
            }
            catch 
            {
                
            }


        }

        public Smile DesplazamientoATMRRFLY(int row , string atm_rr10_bf10_rr25_bf25)
        {
           
            Smile SmileDesplazado = new Smile();

            SmileDesplazado.Copy(this);
            //SmileDesplazado = this;

            double _atmTemp ,_rr10dTemp, _bf10dTemp, _rr25dTemp, _bf25dTemp;

            
            //GenerateSmileCallPut
            int N = SmileDesplazado.SmileList[0].Count;
            double _desplazamiento = 0.01;

            double sig_call_25, sig_put_25, sig_call_10, sig_put_10;

            _atmTemp = SmileDesplazado.SmileList[1][row];
            _rr10dTemp = SmileDesplazado.SmileList[2][row];
            _bf10dTemp = SmileDesplazado.SmileList[3][row];
            _rr25dTemp = SmileDesplazado.SmileList[4][row];
            _bf25dTemp = SmileDesplazado.SmileList[5][row];

            switch (atm_rr10_bf10_rr25_bf25)
            {
                case "atm":                    
                    SmileDesplazado.SmileList[1][row] = _atmTemp + _desplazamiento;
                    break;
                case "rr10":                    
                    SmileDesplazado.SmileList[2][row] = _rr10dTemp + _desplazamiento;
                    break;
                case "bf10":                    
                    SmileDesplazado.SmileList[3][row] = _bf10dTemp + _desplazamiento;
                    break;
                case "rr25":                    
                    SmileDesplazado.SmileList[4][row] = _rr25dTemp + _desplazamiento;
                    break;
                case "bf25":                    
                    SmileDesplazado.SmileList[5][row] = _bf25dTemp + _desplazamiento;
                    break;
            }


            sig_call_25 = SmileDesplazado.SmileList[1][row] + SmileDesplazado.SmileList[5][row] + 0.5 * SmileDesplazado.SmileList[4][row];
            sig_put_25 = SmileDesplazado.SmileList[1][row] + SmileDesplazado.SmileList[5][row] - 0.5 * SmileDesplazado.SmileList[4][row];
            sig_call_10 = SmileDesplazado.SmileList[1][row] + SmileDesplazado.SmileList[3][row] + 0.5 * SmileDesplazado.SmileList[2][row];
            sig_put_10 = SmileDesplazado.SmileList[1][row] + SmileDesplazado.SmileList[3][row] - 0.5 * SmileDesplazado.SmileList[2][row];


            SmileDesplazado.Volas[row][0] = sig_put_10;
            SmileDesplazado.Volas[row][1] = sig_put_25;
            SmileDesplazado.Volas[row][2] = SmileDesplazado.SmileList[1][row];
            SmileDesplazado.Volas[row][3] = sig_call_25;
            SmileDesplazado.Volas[row][4] = sig_call_10;

            //----------------STRIKES---------------------
            //YieldList mYieldList = new YieldList();
            //mYieldList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaSmile);
            //mYieldList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaSmile);
            
            //double rd, rf, f, t;
            //double delta_forward, vol, sig_atm;
            //double delta;
            //int tipo;

            //rd = (365.0 / SmileDesplazado.Tenors[row]) * Math.Log(Math.Pow((1 + 0.01 * mYieldList.Read(SmileDesplazado.CurvaDom, enumSource.System, SmileDesplazado.FechaSmile, SmileDesplazado.Tenors[row]).Rate), ((double)SmileDesplazado.Tenors[row]) / 360.0));
            //rf = (365.0 / SmileDesplazado.Tenors[row]) * Math.Log(Math.Pow((1 + 0.01 * mYieldList.Read(SmileDesplazado.CurvaFor, enumSource.System, SmileDesplazado.FechaSmile, SmileDesplazado.Tenors[row]).Rate), ((double)SmileDesplazado.Tenors[row]) / 360.0));

            //if (SmileDesplazado.FlagSmile == 0)
            //{
            //    f = this.Spot * Math.Exp((rd - rf) * (SmileDesplazado.Tenors[row] / 365.0)); //_Basis365.Term));
            //    t = (double)SmileDesplazado.Tenors[row] / 365.0;//_Basis365.Term;

             
            //    delta_forward = 0.1;
            //    tipo = 2;//'put
            //    vol = 0.01 * SmileDesplazado.Volas[row][0];//Put10
            //    SmileDesplazado.Strikes[row][0] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);


            //    delta_forward = 0.25;
            //    tipo = 2; //'put
            //    vol = 0.01 * SmileDesplazado.Volas[row][1];//Put25;
            //    SmileDesplazado.Strikes[row][1] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);


            //    sig_atm = 0.01 * SmileDesplazado.Volas[row][2];//Atm
            //    SmileDesplazado.Strikes[row][2] = SmileDesplazado.atm(this.Spot, sig_atm, rd, rf, t);


            //    delta_forward = 0.25;
            //    tipo = 1;// 'call
            //    vol = 0.01 * SmileDesplazado.Volas[row][3];//Call25;
            //    SmileDesplazado.Strikes[row][3] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);

            //    delta_forward = 0.1;
            //    tipo = 1; //'call
            //    vol = 0.01 * SmileDesplazado.Volas[row][4];//Call10;
            //    SmileDesplazado.Strikes[row][4] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);

                
            //}
            //else
            //{
            //    if (SmileDesplazado.FlagSmile == 1)
            //    {
            //        t = (double)SmileDesplazado.Tenors[row] / 365.0;                   

            //        delta = 0.1;
            //        tipo = 2;
            //        vol = 0.01 * SmileDesplazado.Volas[row][0];//Put10;
            //        //salida(i, 1) = pilar(s, vol, rd, rf, t, tipo, delta)
            //        SmileDesplazado.Strikes[row][0] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);

            //        delta = 0.25;
            //        tipo = 2;
            //        vol = 0.01 * SmileDesplazado.Volas[row][1];// Put25;
            //        SmileDesplazado.Strikes[row][1] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);


            //        sig_atm = 0.01 * SmileDesplazado.Volas[row][2];//Atm;
            //        SmileDesplazado.Strikes[row][2] = SmileDesplazado.atm(this.Spot, sig_atm, rd, rf, t);

            //        delta = 0.25;
            //        tipo = 1;
            //        vol = 0.01 * SmileDesplazado.Volas[row][3];//Call25;
            //        SmileDesplazado.Strikes[row][3] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);


            //        delta = 0.1;
            //        tipo = 1;
            //        vol = 0.01 * SmileDesplazado.Volas[row][4];//Call10;
            //        SmileDesplazado.Strikes[row][4] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);
            //    }
            //}

            SmileDesplazado.SmileList[1][row] = _atmTemp ;
            SmileDesplazado.SmileList[2][row] = _rr10dTemp;
            SmileDesplazado.SmileList[3][row] = _bf10dTemp;
            SmileDesplazado.SmileList[4][row] = _rr25dTemp;
            SmileDesplazado.SmileList[5][row] = _bf25dTemp;

            return SmileDesplazado;

        }






        public Smile DesplazamientoVolas(int row, string atm_put10_call10_put25_call25)
        {

            Smile SmileDesplazado = new Smile();

            //SmileDesplazado.Copy(this);
            SmileDesplazado = this;

            double _atmTemp, _put10dTemp, _call10dTemp, _put25dTemp, _call25dTemp;


            //GenerateSmileCallPut
            int N = SmileDesplazado.SmileList[0].Count;
            double _desplazamiento = 0.01;       

            
            _put10dTemp = this.Volas[row][0];
            _put25dTemp = this.Volas[row][1];
            _atmTemp = this.Volas[row][2];
            _call25dTemp = this.Volas[row][3];
            _call10dTemp = this.Volas[row][4];

            switch (atm_put10_call10_put25_call25)
            {
                case "put10":
                    SmileDesplazado.Volas[row][0] = _put10dTemp + _desplazamiento;
                    break;
                case "put25":
                    SmileDesplazado.Volas[row][1] = _put25dTemp + _desplazamiento;
                    break;
                case "atm":
                    SmileDesplazado.Volas[row][2] = _atmTemp + _desplazamiento;
                    break;
                case "call25":
                    SmileDesplazado.Volas[row][3] = _call25dTemp + _desplazamiento;
                    break;
                case "call10":
                   SmileDesplazado.Volas[row][4] = _call10dTemp + _desplazamiento;
                    break;
            }

            //----------------STRIKES---------------------
            YieldList mYieldList = new YieldList();
            mYieldList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaSmile);
            mYieldList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaSmile);

            double rd, rf, f, t;
            double delta_forward, vol, sig_atm;
            double delta;
            int tipo;

            rd = (365.0 / SmileDesplazado.Tenors[row]) * Math.Log(Math.Pow((1 + 0.01 * mYieldList.Read(SmileDesplazado.CurvaDom, enumSource.System, SmileDesplazado.FechaSmile, SmileDesplazado.Tenors[row]).Rate), ((double)SmileDesplazado.Tenors[row]) / 360.0));
            rf = (365.0 / SmileDesplazado.Tenors[row]) * Math.Log(Math.Pow((1 + 0.01 * mYieldList.Read(SmileDesplazado.CurvaFor, enumSource.System, SmileDesplazado.FechaSmile, SmileDesplazado.Tenors[row]).Rate), ((double)SmileDesplazado.Tenors[row]) / 360.0));

            if (SmileDesplazado.FlagSmile == 0)
            {
                f = this.Spot * Math.Exp((rd - rf) * (SmileDesplazado.Tenors[row] / 365.0)); //_Basis365.Term));
                t = (double)SmileDesplazado.Tenors[row] / 365.0;//_Basis365.Term;


                delta_forward = 0.1;
                tipo = 2;//'put
                vol = 0.01 * SmileDesplazado.Volas[row][0];//Put10
                SmileDesplazado.Strikes[row][0] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);


                delta_forward = 0.25;
                tipo = 2; //'put
                vol = 0.01 * SmileDesplazado.Volas[row][1];//Put25;
                SmileDesplazado.Strikes[row][1] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);


                sig_atm = 0.01 * SmileDesplazado.Volas[row][2];//Atm
                SmileDesplazado.Strikes[row][2] = SmileDesplazado.atm(this.Spot, sig_atm, rd, rf, t);


                delta_forward = 0.25;
                tipo = 1;// 'call
                vol = 0.01 * SmileDesplazado.Volas[row][3];//Call25;
                SmileDesplazado.Strikes[row][3] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);

                delta_forward = 0.1;
                tipo = 1; //'call
                vol = 0.01 * SmileDesplazado.Volas[row][4];//Call10;
                SmileDesplazado.Strikes[row][4] = SmileDesplazado.pilar_forward(f, vol, rd, t, tipo, delta_forward);


            }
            else
            {
                if (SmileDesplazado.FlagSmile == 1)
                {
                    t = (double)SmileDesplazado.Tenors[row] / 365.0;

                    delta = 0.1;
                    tipo = 2;
                    vol = 0.01 * SmileDesplazado.Volas[row][0];//Put10;
                    //salida(i, 1) = pilar(s, vol, rd, rf, t, tipo, delta)
                    SmileDesplazado.Strikes[row][0] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);

                    delta = 0.25;
                    tipo = 2;
                    vol = 0.01 * SmileDesplazado.Volas[row][1];// Put25;
                    SmileDesplazado.Strikes[row][1] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);


                    sig_atm = 0.01 * SmileDesplazado.Volas[row][2];//Atm;
                    SmileDesplazado.Strikes[row][2] = SmileDesplazado.atm(this.Spot, sig_atm, rd, rf, t);

                    delta = 0.25;
                    tipo = 1;
                    vol = 0.01 * SmileDesplazado.Volas[row][3];//Call25;
                    SmileDesplazado.Strikes[row][3] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);


                    delta = 0.1;
                    tipo = 1;
                    vol = 0.01 * SmileDesplazado.Volas[row][4];//Call10;
                    SmileDesplazado.Strikes[row][4] = SmileDesplazado.pilar(this.Spot, vol, rd, rf, t, tipo, delta);
                }
            }


            return SmileDesplazado;

        }









        public string GetSmile()
        {

            string _ReturnValue = "";

            _ReturnValue += "<SmileData>";

            //GenerateSmileCallPut
            int N = Tenors.Count;

            for (int i = 0; i < N; i++)
            {
                _ReturnValue += "<DataSmileCallPut Tenor='" + int.Parse(Tenors[i].ToString()) + "' Put10='" + Volas[i][0] + "' Put25 ='" + Volas[i][1] + "' Atm='" + Volas[i][2] + "' Call25='" + Volas[i][3] + "' Call10='" + Volas[i][4] + "' />\n";
            }

            _ReturnValue += "</SmileData>";
            return _ReturnValue;
        }


        //public void Load()
        //{
        //    DataTable smileDataTable = new DataTable();

        //    smileDataTable = cData.Opciones.Smiles.LoadSmiles(this.FechaSmile, this.Paridad);

        //    //GenerateSmileATMRRFLY

        //    DataRow _DataRow;

        //    ATMRRFLY += "<SmileData>";

        //    SmileList = new List<List<double>>();

        //    SmileList.Add(new List<double>());
        //    SmileList.Add(new List<double>());
        //    SmileList.Add(new List<double>());
        //    SmileList.Add(new List<double>());
        //    SmileList.Add(new List<double>());
        //    SmileList.Add(new List<double>());

        //    for (int _Row = 1; _Row <= smileDataTable.Rows.Count; _Row++)
        //    {

        //        _DataRow = smileDataTable.Rows[_Row - 1];

        //        switch (_Row % 5)
        //        {
        //            case 1://Tenor, ATM

        //                ATMRRFLY += "<DataATMRRFLY " +
        //                                "Tenor	='" + _DataRow["SmlDias"].ToString() + "' ";
        //                ATMRRFLY += "ATM ='" + _DataRow["SmlMid"].ToString() + "' ";

        //                SmileList[0].Add(double.Parse(_DataRow["SmlDias"].ToString()));
        //                SmileList[1].Add(double.Parse(_DataRow["SmlMid"].ToString()));

        //                break;
        //            case 2://10DRR
        //                ATMRRFLY += "RR10D ='" + _DataRow["SmlMid"].ToString() + "' ";

        //                SmileList[2].Add(double.Parse(_DataRow["SmlMid"].ToString()));
        //                break;
        //            case 3://10DBF
        //                ATMRRFLY += "BF10D ='" + _DataRow["SmlMid"].ToString() + "' ";

        //                SmileList[3].Add(double.Parse(_DataRow["SmlMid"].ToString()));
        //                break;
        //            case 4://25DRR
        //                ATMRRFLY += "RR25D ='" + _DataRow["SmlMid"].ToString() + "' ";

        //                SmileList[4].Add(double.Parse(_DataRow["SmlMid"].ToString()));
        //                break;
        //            case 0://25DBF
        //                ATMRRFLY += "BF25D ='" + _DataRow["SmlMid"].ToString() + "' />\n";

        //                SmileList[5].Add(double.Parse(_DataRow["SmlMid"].ToString()));
        //                break;
        //        }
        //    }


        //    //GenerateSmileCallPut
        //    int N = SmileList[0].Count;

        //    double sig_call_25, sig_put_25, sig_call_10, sig_put_10;

        //    for (int i = 0; i < N; i++)
        //    {
        //        sig_call_25 = SmileList[1][i] + SmileList[5][i] + 0.5 * SmileList[4][i];
        //        sig_put_25 = SmileList[1][i] + SmileList[5][i] - 0.5 * SmileList[4][i];
        //        sig_call_10 = SmileList[1][i] + SmileList[3][i] + 0.5 * SmileList[2][i];
        //        sig_put_10 = SmileList[1][i] + SmileList[3][i] - 0.5 * SmileList[2][i];

        //        ATMRRFLY += "<DataSmileCallPut Tenor='" + int.Parse(SmileList[0][i].ToString()) + "' Put10='" + sig_put_10 + "' Put25 ='" + sig_put_25 + "' Atm='" + SmileList[1][i] + "' Call25='" + sig_call_25 + "' Call10='" + sig_call_10 + "' />\n";
        //    }

        //    ATMRRFLY += "</SmileData>";

        //    XDocument SmileXdoc = new XDocument();
        //    SmileXdoc = XDocument.Parse(ATMRRFLY);

        //    var smileCallPutVars = from SmileCallPut in SmileXdoc.Descendants("DataSmileCallPut")
        //                           select new StructSmileCallPut
        //                           {
        //                               Tenor = int.Parse(SmileCallPut.Attribute("Tenor").Value.ToString()),
        //                               Put10 = double.Parse(SmileCallPut.Attribute("Put10").Value.ToString()),
        //                               Put25 = double.Parse(SmileCallPut.Attribute("Put25").Value.ToString()),
        //                               Atm = double.Parse(SmileCallPut.Attribute("Atm").Value.ToString()),
        //                               Call25 = double.Parse(SmileCallPut.Attribute("Call25").Value.ToString()),
        //                               Call10 = double.Parse(SmileCallPut.Attribute("Call10").Value.ToString())
        //                           };

        //    this.Tenors = new List<int>();
        //    this.Volas = new List<List<double>>();
        //    this.Strikes = new List<List<double>>();

        //    for (int j = 0; j < smileCallPutVars.ToList().Count; j++)
        //    {
        //        Tenors.Add(smileCallPutVars.ToList<StructSmileCallPut>()[j].Tenor);
        //        Volas.Add(new List<double>());
        //        Volas[j].Add(smileCallPutVars.ToList<StructSmileCallPut>()[j].Put10);
        //        Volas[j].Add(smileCallPutVars.ToList<StructSmileCallPut>()[j].Put25);
        //        Volas[j].Add(smileCallPutVars.ToList<StructSmileCallPut>()[j].Atm);
        //        Volas[j].Add(smileCallPutVars.ToList<StructSmileCallPut>()[j].Call25);
        //        Volas[j].Add(smileCallPutVars.ToList<StructSmileCallPut>()[j].Call10);

        //    }

        //    string strikesString = this.inversion_strikes();

        //    XDocument StrikeXdoc = new XDocument();
        //    StrikeXdoc = XDocument.Parse(strikesString);

        //    var smileStrikeVars = from itemStrike in StrikeXdoc.Descendants("DataStrikes")
        //                          select new StructSmileCallPut
        //                          {
        //                              Tenor = int.Parse(itemStrike.Attribute("Tenor").Value.ToString()),
        //                              Put10 = double.Parse(itemStrike.Attribute("Put10").Value.ToString()),
        //                              Put25 = double.Parse(itemStrike.Attribute("Put25").Value.ToString()),
        //                              Atm = double.Parse(itemStrike.Attribute("Atm").Value.ToString()),
        //                              Call25 = double.Parse(itemStrike.Attribute("Call25").Value.ToString()),
        //                              Call10 = double.Parse(itemStrike.Attribute("Call10").Value.ToString())
        //                          };



        //    for (int j = 0; j < smileStrikeVars.ToList().Count; j++)
        //    {
        //        Strikes.Add(new List<double>());
        //        Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Put10);
        //        Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Put25);
        //        Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Atm);
        //        Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Call25);
        //        Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Call10);
        //    }

        //}

        public string inversion_strikes(enumSetPrincingLoading setPricing)
        {

            YieldList mYieldList = new YieldList();
            mYieldList.SetPrincingLoading = setPricing;
            mYieldList.Load(CurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaSmile);
            mYieldList.Load(CurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, this.FechaSmile);



            string _salida = "<InversionStrike>\n";
            double rd, rf, f, t;
            double delta_forward, vol, sig_atm;
            double delta;
            int tipo;

            int N = Tenors.Count;

            for (int i = 0; i < N; i++)
            {

                rd = (365.0 / Tenors[i]) * Math.Log(Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaDom, enumSource.System, this.FechaSmile, Tenors[i]).Rate), ((double)Tenors[i]) / 360.0));
                rf = (365.0 / Tenors[i]) * Math.Log(Math.Pow((1 + 0.01 * mYieldList.Read(this.CurvaFor, enumSource.System, this.FechaSmile, Tenors[i]).Rate), ((double)Tenors[i]) / 360.0));
                _salida += "<DataStrikes ";
                if (this.FlagSmile == 0)
                {
                    f = this.Spot * Math.Exp((rd - rf) * (Tenors[i] / 365.0)); //_Basis365.Term));
                    t = (double)Tenors[i] / 365.0;//_Basis365.Term;

                    _salida += "Tenor='" + Tenors[i] + "' ";

                    delta_forward = 0.1;
                    tipo = 2;//'put
                    vol = 0.01 * Volas[i][0];//Put10
                    _salida += "Put10='" + pilar_forward(f, vol, rd, t, tipo, delta_forward) + "' ";


                    delta_forward = 0.25;
                    tipo = 2; //'put
                    vol = 0.01 * Volas[i][1];//Put25;
                    _salida += "Put25='" + pilar_forward(f, vol, rd, t, tipo, delta_forward) + "' ";


                    sig_atm = 0.01 * Volas[i][2];//Atm
                    _salida += "Atm='" + atm(this.Spot, sig_atm, rd, rf, t) + "' ";


                    delta_forward = 0.25;
                    tipo = 1;// 'call
                    vol = 0.01 * Volas[i][3];//Call25;
                    _salida += "Call25='" + pilar_forward(f, vol, rd, t, tipo, delta_forward) + "' ";

                    delta_forward = 0.1;
                    tipo = 1; //'call
                    vol = 0.01 * Volas[i][4];//Call10;
                    _salida += "Call10='" + pilar_forward(f, vol, rd, t, tipo, delta_forward) + "' ";

                    _salida += " />\n";

                    //return _salida;
                }
                else
                {
                    if (this.FlagSmile == 1)
                    {
                        t = (double)Tenors[i] / 365.0;


                        _salida += "Tenor='" + Tenors[i] + "' ";

                        delta = 0.1;
                        tipo = 2;
                        vol = 0.01 * Volas[i][0];//Put10;
                        //salida(i, 1) = pilar(s, vol, rd, rf, t, tipo, delta)
                        _salida += "Put10='" + pilar(this.Spot, vol, rd, rf, t, tipo, delta) + "' ";

                        delta = 0.25;
                        tipo = 2;
                        vol = 0.01 * Volas[i][1];// Put25;
                        _salida += "Put25='" + pilar(this.Spot, vol, rd, rf, t, tipo, delta) + "' ";


                        sig_atm = 0.01 * Volas[i][2];//Atm;
                        _salida += "Atm='" + atm(this.Spot, sig_atm, rd, rf, t) + "' ";

                        delta = 0.25;
                        tipo = 1;
                        vol = 0.01 * Volas[i][3];//Call25;
                        _salida += "Call25='" + pilar(this.Spot, vol, rd, rf, t, tipo, delta) + "' ";


                        delta = 0.1;
                        tipo = 1;
                        vol = 0.01 * Volas[i][4];//Call10;
                        _salida += "Call10='" + pilar(this.Spot, vol, rd, rf, t, tipo, delta) + "' ";
                        _salida += " />\n";


                    }
                }

            }

            _salida += "</InversionStrike>";

            return _salida;

        }


        private double pilar(double s, double sig, double rd, double rf, double t, int tipo, double delta)
        {
            double A, k = 0;

            A = -ICND(Math.Abs(delta) * Math.Exp(rf * t));

            if (tipo == 1)//call
            {
                k = s * Math.Exp(A * sig * Math.Sqrt(t) + (rd - rf + 0.5 * Math.Pow(sig, 2)) * t);
            }
            else
            {
                if (tipo == 2)//put
                {
                    k = s * Math.Exp(-A * sig * Math.Sqrt(t) + (rd - rf + 0.5 * Math.Pow(sig, 2)) * t);
                }
                else
                {
                    //Exit Function ?
                }

            }
            return k;

        }


        private double atm(double s, double sig_atm, double rd, double rf, double t)
        {

            return (s * Math.Exp((rd - rf + 0.5 * Math.Pow(sig_atm, 2)) * t));
        }


        private double pilar_forward(double f, double sig, double rd, double t, int tipo, double delta_forward)
        {
            double A, k = 0;

            A = -ICND(Math.Abs(delta_forward) * Math.Exp(rd * t));
            if (tipo == 1)//'call
            {
                k = f * Math.Exp(A * sig * Math.Sqrt(t) + 0.5 * Math.Pow(sig, 2) * t);
            }
            else
            {
                if (tipo == 2)
                {
                    k = f * Math.Exp(-A * sig * Math.Sqrt(t) + 0.5 * Math.Pow(sig, 2) * t);
                }
                else
                {
                    // Exit Function ?
                }
            }
            return k;
        }


        private double ICND(double u)
        {
            //'Inverse of the Cumulative Normal Distribution
            //'Beasley&Springer
            double[] A = { 2.50662823884, -18.61500062529, 41.39119773534, -25.44106049637 };
            double[] B = { -8.4735109309, 23.08336743743, -21.06224101826, 3.13082909833 };
            double[] C = { 0.337475482272615, 0.976169019091719, 0.160797971491821, 2.76438810333863E-02, 3.8405729373609E-03, 3.951896511919E-04, 3.21767881768E-05, 2.888167364E-07, 3.960315187E-07 };

            double x, r;

            x = u - 0.5;
            if (Math.Abs(x) <= 0.42)
            {
                r = Math.Pow(x, 2);
                r = x * (A[0] + r * (A[1] + r * (A[2] + A[3] * r))) / (1 + r * (B[0] + r * (B[1] + r * (B[2] + r * B[3]))));
            }
            else
            {
                r = u;
                if (x > 0)
                {
                    r = 1 - u;
                }

                r = Math.Log(-Math.Log(r));
                r = C[0] + r * (C[1] + r * (C[2] + r * (C[3] + r * (C[4] + r * (C[5] + r * (C[6] + r * (C[7] + r * C[8])))))));

                if (x < 0)
                {
                    r = -r;
                }

            }
            return r;
        }

        public double interp_vol(int tenor, double strike, int int_strike, int int_time)
        {
            List<double> fc;


            fc = find_cuad(tenor, strike);

            double[] stk = new double[2];
            double[] vol = new double[2];

            stk[0] = fc[2];
            stk[1] = fc[3];
            vol[0] = fc[6];
            vol[1] = fc[7];

            double vi;

            vi = interp_strikes(stk, vol, strike, int_strike);
            stk[0] = fc[4];
            stk[1] = fc[5];
            vol[0] = fc[8];
            vol[1] = fc[9];


            double vf;
            double[] plz = new double[2];

            vf = interp_strikes(stk, vol, strike, int_strike);

            plz[0] = fc[0];
            plz[1] = fc[1];
            vol[0] = vi;
            vol[1] = vf;


            double it;

            it = interp_time(plz, vol, tenor, int_time);

            return it;
        }



        private List<double> find_cuad(int tenor, double strike)
        {
            int n1, n2, n3, n4, n5;
            int i;
           
            n1 = Tenors.Count;
            n2 = Strikes.Count;
            n3 = Volas.Count;
            n4 = Strikes[0].Count; // smileStrikesList[0]  tenor, put10, put25, atm, call25,call10
            n5 = Volas[0].Count; // smileCallPutList[0]  tenor, put10, put25, atm, call25,call10

            int ta, tp;
            if (tenor <= Tenors[0])
            {
                ta = 0;
                tp = 0;
            }
            else
            {
                if (tenor >= Tenors[n1 - 1])
                {
                    ta = n1 - 1;
                    tp = n1 - 1;
                }
                else
                {
                    i = 0;
                    while (tenor >= Tenors[i])
                    {
                        i++;
                    }
                    ta = i - 1;
                    tp = i;
                }
            }
            int sa_ta, sp_ta;
            if (strike <= Strikes[ta][0])
            {
                sa_ta = 0;
                sp_ta = 0;
            }
            else
            {
                if (strike >= Strikes[ta][n5 - 1])
                {
                    sa_ta = n5 - 1;
                    sp_ta = n5 - 1;
                }
                else
                {
                    i = 0;
                    while (strike >= Strikes[ta][i])
                    {
                        i++;
                    }
                    sa_ta = i - 1;
                    sp_ta = i;
                }
            }
            int sa_tp, sp_tp;
            if (strike <= Strikes[tp][0])
            {
                sa_tp = 0;
                sp_tp = 0;
            }
            else
            {
                if (strike >= Strikes[tp][n5 - 1])
                {
                    sa_tp = n5 - 1;
                    sp_tp = n5 - 1;
                }
                else
                {
                    i = 0;
                    while (strike >= Strikes[tp][i])
                    {
                        i++;
                    }
                    sa_tp = i - 1;
                    sp_tp = i;
                }
            }


            double _A, _B, _C, _D, _e, _f, _g, _h, _i, _j;

            _A = Tenors[ta];
            _B = Tenors[tp];
            _C = Strikes[ta][sa_ta];
            _D = Strikes[ta][sp_ta];
            _e = Strikes[tp][sa_tp];
            _f = Strikes[tp][sp_tp];
            _g = Volas[ta][sa_ta];
            _h = Volas[ta][sp_ta];
            _i = Volas[tp][sa_tp];
            _j = Volas[tp][sp_tp];


            List<double> _salida = new List<double>();

            _salida.Add(_A);
            _salida.Add(_B);
            _salida.Add(_C);
            _salida.Add(_D);
            _salida.Add(_e);
            _salida.Add(_f);
            _salida.Add(_g);
            _salida.Add(_h);
            _salida.Add(_i);
            _salida.Add(_j);

            return _salida;
        }

        private double interp_strikes(double[] strikes, double[] volas, double _strike, int tipo_int)
        {

            if (strikes[1] == strikes[0])
            {
                return volas[0];
            }

            double vola = 0, M;

            switch (tipo_int)
            {
                case 1: // lineal

                    M = (volas[1] - volas[0]) / (strikes[1] - strikes[0]);
                    vola = volas[0] + M * (_strike - strikes[0]);
                    break;
                default:
                    // No corresponde a un tipo de interpolacion valido
                    break;
            }
            return vola;
        }

        private double interp_time(double[] tenors, double[] volas, double tenor, int tipo_int)
        {

            if (tenors[1] == tenors[0])
            {
                return volas[0];
            }

            double M, vola = 0;

            switch (tipo_int)
            {
                case 1: // lineal

                    M = (volas[1] - volas[0]) / (tenors[1] - tenors[0]);
                    vola = volas[0] + M * (tenor - tenors[0]);
                    break;
                case 2: // lineal en la raiz del tiempo

                    M = (volas[1] - volas[0]) / (Math.Sqrt(tenors[1]) - Math.Sqrt(tenors[0]));
                    vola = volas[0] + M * (Math.Sqrt(tenor) - Math.Sqrt(tenors[0]));
                    break;


                default:
                    // No corresponde a un tipo de interpolacion valido
                    break;
            }
            return vola;
        }



        public void Load(string SmileXML, DateTime Fecha_Smile, double spot, string parMon, string curvaDom, string curvaFor, enumSetPrincingLoading setPricing, int flagSmile)
        {
            XDocument SmileXDoc;
            XElement ElementXML;

            this.SetPricing = setPricing;
            this.Paridad = parMon;
            this.FechaSmile = Fecha_Smile;
            this.CurvaDom = curvaDom;
            this.CurvaFor = curvaFor;
            this.FlagSmile = flagSmile;
            this.Spot = spot;

            try
            {
                SmileXDoc = new XDocument(XDocument.Parse(SmileXML));
            }
            catch
            {
                SmileXDoc = null;
            }          

            ElementXML = SmileXDoc.Element("Smile").Element("ATMRRFLY");

            SmileList = new List<List<double>>();

            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());
            SmileList.Add(new List<double>());


            foreach (XElement element in ElementXML.Elements("itemATMRRFLY").OrderBy(x=> Convert.ToInt32(x.Attribute("TENOR").Value)) )
            {
                SmileList[0].Add(Convert.ToDouble(element.Attribute("TENOR").Value));
                SmileList[1].Add(Convert.ToDouble(element.Attribute("ATM").Value));
                SmileList[2].Add(Convert.ToDouble(element.Attribute("RR10D").Value));
                SmileList[3].Add(Convert.ToDouble(element.Attribute("BF10D").Value));
                SmileList[4].Add(Convert.ToDouble(element.Attribute("RR25D").Value));
                SmileList[5].Add(Convert.ToDouble(element.Attribute("BF25D").Value)); 
            }        

            this.Tenors = new List<int>();
            this.Volas = new List<List<double>>();
            this.Strikes = new List<List<double>>();

            //GenerateSmileCallPut
            int N = SmileList[0].Count;

            double sig_call_25, sig_put_25, sig_call_10, sig_put_10;

            for (int i = 0; i < N; i++)
            {
                sig_call_25 = SmileList[1][i] + SmileList[5][i] + 0.5 * SmileList[4][i];
                sig_put_25 = SmileList[1][i] + SmileList[5][i] - 0.5 * SmileList[4][i];
                sig_call_10 = SmileList[1][i] + SmileList[3][i] + 0.5 * SmileList[2][i];
                sig_put_10 = SmileList[1][i] + SmileList[3][i] - 0.5 * SmileList[2][i];

                Tenors.Add((int)SmileList[0][i]);
                Volas.Add(new List<double>());

                Volas[i].Add(sig_put_10);
                Volas[i].Add(sig_put_25);
                Volas[i].Add(SmileList[1][i]);
                Volas[i].Add(sig_call_25);
                Volas[i].Add(sig_call_10);
            }


            string strikesString = this.inversion_strikes(setPricing);

            XDocument StrikeXdoc = new XDocument();
            StrikeXdoc = XDocument.Parse(strikesString);

            var smileStrikeVars = from itemStrike in StrikeXdoc.Descendants("DataStrikes")
                                  select new StructSmileCallPut
                                  {
                                      Tenor = int.Parse(itemStrike.Attribute("Tenor").Value.ToString()),
                                      Put10 = double.Parse(itemStrike.Attribute("Put10").Value.ToString()),
                                      Put25 = double.Parse(itemStrike.Attribute("Put25").Value.ToString()),
                                      Atm = double.Parse(itemStrike.Attribute("Atm").Value.ToString()),
                                      Call25 = double.Parse(itemStrike.Attribute("Call25").Value.ToString()),
                                      Call10 = double.Parse(itemStrike.Attribute("Call10").Value.ToString())
                                  };


            for (int j = 0; j < smileStrikeVars.ToList().Count; j++)
            {
                Strikes.Add(new List<double>());
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Put10);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Put25);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Atm);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Call25);
                Strikes[j].Add(smileStrikeVars.ToList<StructSmileCallPut>()[j].Call10);
            }

        }

        



    }
}
