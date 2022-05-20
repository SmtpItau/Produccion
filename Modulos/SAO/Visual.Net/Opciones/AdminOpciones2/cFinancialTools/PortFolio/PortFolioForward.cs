using System;
using System.Collections;
using System.Text;
using System.Data;
using cFinancialTools.Yield;
using cFinancialTools.Currency;
using cFinancialTools.Rate;
using cFinancialTools.Struct;
using cData.PortFolio;
using cFinancialTools.BussineDate;
using cFinancialTools.Instruments;
using cFinancialTools.Valuation;
using System.Data.OleDb;

namespace cFinancialTools.PortFolio
{

    public class PortFolioForward
    {

        #region "Constantes"

        private const string cPortFolioToday = "PortFolioToday";
        private const string cPortFolioTomorrow = "PortFolioTomorrow";
        private const string cSensibilitiesOperationData = "SensibilitiesOperationData";
        private const string cSensibilitiesOperationByYield = "SensibilitiesOperationByYield";
        private const string cSensibilitiesOperationByTerm = "SensibilitiesOperationByTerm";
        private const string cSensibilitiesByYield = "SensibilitiesByYield";

        private const string cPortFolioTimeDecay = "PortFolioTimeDecay";
        private const string cPortFolioExchangeRate = "PortFolioExchangeRate";

        private const string cPortFolioTodayFlow = "ForwardPortFolioFlow";
        private const string cPortFolioFlowTomorrow = "PortFolioFlowTomorrow";

        #endregion

        #region "Atributos Privados"

        private DateTime mPortFolioDate;                        // Fecha PortFolio
        private enumValuatorForward mValuatorForward;           // Metodo de Valorización
        private enumCalculateDate mCalculateDate;               // Fecha de Calculo

        private DateTime mPortFolioDateYesterday;               // Fecha de la Cartera t(-1)
        private DateTime mPortFolioDateToday;                   // Fecha de la Cartera t(0)
        private DateTime mPortFolioDateTomorrow;                // Fecha de la Cartera t(0)
        private DateTime mPortFolioEndofMonth;                  // Fecha de Fin de Mes
        private DateTime mPortFolioPreviousEndOfMonth;          // Fecha de Fin de Mes Previo

        private DateTime mYieldDateRateToday;                   // Fecha de la carga de las Tasa de Mercado en t(0)
        private DateTime mYieldDateRateYesterday;               // Fecha de la carga de las Tasa de Mercado en t(-1)

        private DateTime mCurrencyDateExchangeRateToday;        // Fecha de la carga de los Tipos de Cambio en t(0)
        private DateTime mCurrencyDateExchangeRateYesterday;    // Fecha de la carga de los Tipos de Cambio en t(-1)

        private MnemonicsList mMnemonicsList;                   // Lista de Instrumentos Utilizados
        private DataSet mPortFolioDataSet;                      // Tablas de la Cartera t(0) y t(1).
        private CurrencyList mCurrencyList;                     // Lista de Tipos de Cambios
        private YieldList mYieldList;                           // Lista de Curvas
        private RateList mRateList;                             // Lista de Tasas
        private ArrayList mYieldArray;                          // Arreglo de Curvas utilizadas en la valorización

        private double mPresenteValue;                          // Valor Presente

        private double mMarkToMarketValue;                      // Valor Mercado
        private double mMarkToMarketValueUM;                    // Valor Mercado en UM

        private double mMarkToMarketTodayBAC;                   // Valor Mercado en t(0) BAC
        private double mMarkToMarketTomorrowBAC;                // Valor Mercado en t(1) BAC

        private double mMarkToMarketToday;                      // Valor Mercado en t(0)
        private double mMarkToMarketTomorrow;                   // Valor Mercado en t(1)
        private double mMarkToMarketTimeDecay;                  // Valor Mercado en Cambio de Tiempo
        private double mMarkToMarketExchangeRate;               // Valor Mercado en Tipo de Cambio
        private double mMarkToMarketTodayUM;                    // Valor Mercado en t(0) en UM
        private double mMarkToMarketTomorrowUM;                 // Valor Mercado en t(1) en UM
        private double mMarkToMarketTimeDecayUM;                // Valor Mercado en Cambio de Tiempo en UM
        private double mMarkToMarketExchangeRateUM;             // Valor Mercado en Tipo de Cambio en UM

        private double mBalanceReal;                            // Valor real
        private double mSensibilitiesValue;                     // Valor de la Sensibilización
        private double mEstimationValue;                        // Valor de la Estimación
        private double mTimeDecayValue;                         // Valor por Paso del Tiempo
        private double mCashFlowValue;                          // Valor por Flujos de Caja
        private double mNewOperationValue;                      // Valor por Operaciones Nuevas
        private double mEffectExchangeRateValue;                // Valor por el Efecto de Tipo de Cambio
        private double mEffectRateValue;                        // Valor por el Efecto de Tasa
        private double mCashFlow;                               // Valor por Flujos de Caja

        private double mRateUSD;                                // Tasa USD
        private double mRateCLP;                                // Tasa CLP
        private double mTAB30Days;                              // Tasa TAB 30 días
        private double mCarryRateUSD;
        private double mPointForward;                           // Puntos Forward
        private int mTenorUSD;                                  // Plazo mas cercano a 30 días en curva USD

        private enumValuatorFixingRate mValuatorFixingRate;

        private int mUserID;
        private cFinancialTools.PortFolio.PortFolio mPortFolio;

        private Calendars mCalendar;

        #endregion

        #region "Constructores"

        public PortFolioForward()
        {
            Set();
        }

        #endregion

        #region "Atributos Publicos"

        #region "Fecha de la Cartera"

        public DateTime PortFolioDate
        {
            get
            {
                return mPortFolioDate;
            }
            set
            {

                #region "Definición de Variables a Utilizar"

                cFinancialTools.BussineDate.BussineDate _Date;

                #endregion

                #region "Inicialización de Fechas"

                // Fecha de Carga de la Cartera
                mPortFolioDate = value;

                // Fecha de la Cartera t(-1)
                _Date = new cFinancialTools.BussineDate.BussineDate(value);
                mPortFolioDateYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

                // Fecha de la Cartera t(0)
                mPortFolioDateToday = value;

                // Fecha de la Cartera t(1)
                _Date = new cFinancialTools.BussineDate.BussineDate(value);
                mPortFolioDateTomorrow = _Date.MovesDate(enumIntervalType.DayHoliday, 1, enumConvention.NextModified, 6, mCalendar);

                // Fin de Mes
                _Date = new cFinancialTools.BussineDate.BussineDate(value);
                mPortFolioEndofMonth = _Date.EnfOfMonth;

                // Fin de Mes Previo
                _Date = new cFinancialTools.BussineDate.BussineDate(value);
                mPortFolioPreviousEndOfMonth = _Date.PreviousEndOfMonth;

                // Fecha de la carga de los Tipos de Cambio en t(0)
                mCurrencyDateExchangeRateToday = mPortFolioDateToday;

                // Fecha de la carga de los Tipos de Cambio en t(-1)
                mCurrencyDateExchangeRateYesterday = mPortFolioDateYesterday;

                if (mPortFolioDateToday.Equals(mPortFolioEndofMonth))
                {
                    // Fecha Mercado Fin de Mes
                    mYieldDateRateToday = mPortFolioDateYesterday;

                    // Fecha de carga mercado 2 días habiles antes de la fecha de proceso
                    _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioDateYesterday);
                    mYieldDateRateYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

                }
                else
                {
                    // Tasa de Mercado t(0)
                    mYieldDateRateToday = mPortFolioDateToday;

                    // Tasa de Mercado t(1)
                    mYieldDateRateYesterday = mPortFolioDateYesterday;
                }

                #endregion

                #region "Inicialización de Valores para la Cartera"

                SetYieldList();
                LoadYield(mYieldDateRateYesterday);
                LoadYield(mYieldDateRateToday);
                LoadCurrency(mCurrencyDateExchangeRateYesterday);
                LoadCurrency(mCurrencyDateExchangeRateToday);
                LoadConfiguration();

                #endregion

                #region "Valida que exista curva para la fecha de proceso"

                if (mYieldList.Read("CURVAFWCLP", enumSource.System, mYieldDateRateToday).Count == 0)
                {

                    mYieldDateRateToday = mYieldDateRateYesterday;

                    _Date = new cFinancialTools.BussineDate.BussineDate(mYieldDateRateYesterday);
                    mYieldDateRateYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);
                    LoadYield(mYieldDateRateYesterday);

                }

                #endregion

                #region "Destrucción de Variables Utilizadas"

                _Date = null;

                #endregion

            }
        }

        #endregion

        #region "Metodo de Valorización"

        public enumValuatorForward ValuatorForward
        {

            get
            {
                return mValuatorForward;
            }
            set
            {
                mValuatorForward = value;
            }

        }

        #endregion

        #region "Fecha de Calculo"

        public enumCalculateDate CalculateDate
        {

            get
            {
                return mCalculateDate;
            }
            set
            {
                mCalculateDate = value;
            }

        }

        #endregion

        #region "Carteras"

        public DataSet PortFolioDataSet
        {
            get
            {
                return mPortFolioDataSet;
            }
        }

        #endregion

        #region "Valores Presentes"

        public double PresenteValue
        {

            get
            {
                return mPresenteValue;
            }

        }

        #endregion

        #region "Valores de Mercado"

        public double MarkToMarketValue
        {
            get
            {
                return mMarkToMarketValue;
            }
        }

        public double MarkToMarketTodayBAC
        {

            get
            {
                return mMarkToMarketTodayBAC;
            }

        }

        public double MarkToMarketTomorrowBAC
        {
            get
            {
                return mMarkToMarketTomorrowBAC;
            }
        }

        public double MarkToMarketToday
        {
            get
            {
                return mMarkToMarketToday;
            }
        }

        public double MarkToMarketTomorrow
        {
            get
            {
                return mMarkToMarketTomorrow;
            }
        }

        public double MarkToMarketTimeDecay
        {
            get
            {
                return mMarkToMarketTimeDecay;
            }
        }

        public double MarkToMarketExchangeRate
        {
            get
            {
                return mMarkToMarketExchangeRate;
            }
        }

        public double MarkToMarketTodayUM
        {
            get
            {
                return mMarkToMarketTodayUM;
            }
        }

        public double MarkToMarketTomorrowUM
        {
            get
            {
                return mMarkToMarketTomorrowUM;
            }
        }

        public double MarkToMarketTimeDecayUM
        {
            get
            {
                return mMarkToMarketTimeDecayUM;
            }
        }

        public double MarkToMarketExchangeRateUM
        {
            get
            {
                return mMarkToMarketExchangeRateUM;
            }
        }

        #endregion

        #region "Sensibilización y estimaciones"

        public double SensibilitiesValue
        {
            get
            {
                return mSensibilitiesValue;
            }
        }

        public double EstimationValue
        {
            get
            {
                return mEstimationValue;
            }
        }

        public double TimeDecayValue
        {
            get
            {
                return mTimeDecayValue;
            }
        }

        public double CashFlowValue
        {
            get
            {
                return mCashFlowValue;
            }
        }

        public double NewOperationValue
        {
            get
            {
                return mNewOperationValue;
            }
        }

        public double EffectExchangeRateValue
        {
            get
            {
                return mEffectExchangeRateValue;
            }
        }

        public double EffectRateValue
        {
            get
            {
                return mEffectRateValue;
            }
        }

        #endregion

        #endregion

        #region "Metodos Publicos"

        #region "Seteo de Fechas"

        public void SetDate(cFinancialTools.PortFolio.PortFolio portFolio)
        {

            #region "Inicialización de Fechas"

            // Fecha de Carga de la Cartera
            mPortFolioDate = portFolio.PortFolioDate;

            // Fecha de la Cartera t(-1)
            mPortFolioDateYesterday = portFolio.PortFolioYesterday;

            // Fecha de la Cartera t(0)
            mPortFolioDateToday = portFolio.PortFolioToday;

            // Fecha de la Cartera t(1)
            mPortFolioDateTomorrow = portFolio.PortFolioTomorrow;

            // Fin de Mes
            mPortFolioEndofMonth = portFolio.EndofMonth;

            // Fin de Mes Previo
            mPortFolioPreviousEndOfMonth = portFolio.PreviousEndofMonth;

            // Fecha de la carga de las Tasa de Mercado en t(0)
            mYieldDateRateToday = portFolio.YieldToday;

            // Fecha de la carga de las Tasa de Mercado en t(-1)
            mYieldDateRateYesterday = portFolio.YieldYesterday;

            // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyDateExchangeRateToday = portFolio.CurrencyExchangeRateToday;

            // Fecha de la carga de los Tipos de Cambio en t(-1)
            mCurrencyDateExchangeRateYesterday = portFolio.CurrencyExchangeRateYesterday;

            if (mPortFolioDateToday.Equals(portFolio.EndofMonth))
            {

                mYieldDateRateToday = portFolio.EndofMonthSkillful;
                mCurrencyDateExchangeRateToday = portFolio.EndofMonthSkillful;
                mYieldDateRateYesterday = portFolio.EndofMonthSkillful;
                mCurrencyDateExchangeRateYesterday = portFolio.EndofMonthSkillful;

            }

            if (mPortFolioDateYesterday.Equals(portFolio.PreviousEndofMonth))
            {

                mYieldDateRateYesterday = portFolio.PreviousEndofMonthSkillful;
                mCurrencyDateExchangeRateYesterday = portFolio.PreviousEndofMonthSkillful;

            }

            mUserID = portFolio.UserID;
            mPortFolio = portFolio;

            #endregion

            #region "Inicialización de Valores para la Cartera"

            mRateList.Load(9, 999, enumPeriod.Anual, enumSource.System, mPortFolioDateToday);

            mTAB30Days = mRateList.Read(9, 999, enumPeriod.Anual, enumSource.System, mPortFolioDateToday).Rate;

            SetYieldList();
            LoadYield(mYieldDateRateYesterday);
            LoadYield(mYieldDateRateToday);
            LoadCurrency(mCurrencyDateExchangeRateYesterday);
            LoadCurrency(mCurrencyDateExchangeRateToday);
            LoadConfiguration();

            #endregion

            #region "Calculo Tasa USD"

            int _Tenors = 0;
            int _DifAnt = 0;

            for (int _Point = 0; _Point < mYieldList.Read("CURVAFWUSD", enumSource.System, mYieldDateRateToday).Count; _Point++)
            {

                _Tenors = mYieldList.Read("CURVAFWUSD", enumSource.System, mYieldDateRateToday).Point(_Point).Term;

                if (_Tenors > 30)
                {
                    if (Math.Abs(_DifAnt) < (_Tenors - 30))
                    {
                        _Tenors = mYieldList.Read("CURVAFWUSD", enumSource.System, mYieldDateRateToday).Point(_Point - 1).Term;
                    }

                    mTenorUSD = _Tenors;

                    break;

                }

                _DifAnt = _Tenors - 30;

            }

            mRateUSD = mYieldList.Read("CURVAFWUSD", enumSource.System, mYieldDateRateToday, mTenorUSD).Rate;
            mRateCLP = mYieldList.Read("CURVAFWCLP", enumSource.System, mYieldDateRateToday, mTenorUSD).Rate;

            double _Spot = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateToday).ExchangeRate;
            double _PriceForwardTheory = _Spot * ((1 + mRateCLP * 0.01 * (double)mTenorUSD / 360.0) / (1 + mRateUSD * 0.01 * (double)mTenorUSD / 360.0));
            mPointForward = Math.Round(_PriceForwardTheory - _Spot, 2);

            mCarryRateUSD = ((((1 + mTAB30Days * 0.01 * 30.0 / 360.0) / ((mPointForward / _Spot) + 1.0)) - 1.0) * (360.0 / 30.0)) * 100.0;

            #endregion

        }

        #endregion

        #region "Carga PortFolio"

        public void Load()
        {

            DataSet _PortFolio;
            DataTable _PortFolioToday;
            DataTable _PortFolioFlowToday;

            _PortFolioToday = new DataTable();
            _PortFolioFlowToday = new DataTable();
            mPortFolioDataSet = new DataSet();

            _PortFolio = Load(mPortFolioDateToday);

            _PortFolioToday = _PortFolio.Tables["ForwardPortFolio"];
            _PortFolioToday.TableName = cPortFolioToday;

            _PortFolioFlowToday = _PortFolio.Tables["ForwardPortFolioFlow"];
            _PortFolioFlowToday.TableName = cPortFolioTodayFlow;

            AddTableDataSet(cPortFolioToday, _PortFolioToday);

            mPortFolioDataSet.Merge(_PortFolio);

        }

        #endregion

        #region "Mark to Market"

        public void MarkToMarket()
        {

            DataTable _PortFolioToday = new DataTable();
            DataTable _PortFolioFlow = new DataTable();
            DataTable _RateBenchMark = new DataTable();
            DataTable _IndexValueForwardFixingRate = new DataTable();

            _PortFolioToday = mPortFolioDataSet.Tables[cPortFolioToday];
            _PortFolioFlow = mPortFolioDataSet.Tables[cPortFolioTodayFlow];
            _RateBenchMark = mPortFolioDataSet.Tables["RateBenchMarck"];
            _IndexValueForwardFixingRate = mPortFolioDataSet.Tables["IndexValueForwardFixingRate"];

            _PortFolioToday = MarkToMarket(
                                            _PortFolioToday,
                                            _PortFolioFlow,
                                            _RateBenchMark,
                                            _IndexValueForwardFixingRate,
                                            mPortFolioDateToday,
                                            mYieldDateRateToday,
                                            mCurrencyDateExchangeRateToday
                                          );

            AddTableDataSet(cPortFolioToday, _PortFolioToday);

        }

        #endregion

        #region "Calculo de la Sensibilidad"

        public void Sensibilities()
        {

            DataSet _SensibilitiesTables = new DataSet();
            DataTable _PortFolioToday = new DataTable();

            _SensibilitiesTables = SensibilitiesTables();

            _PortFolioToday = CopyTable("PortFolio", mPortFolioDataSet.Tables[cPortFolioToday]);
            _SensibilitiesTables.Tables.Add(_PortFolioToday);

            _SensibilitiesTables = Sensibilities(
                                                  _SensibilitiesTables,
                                                  mPortFolioDateToday,
                                                  mYieldDateRateToday,
                                                  mCurrencyDateExchangeRateToday
                                                );

            AddTableDataSet(cSensibilitiesOperationData, _SensibilitiesTables.Tables[cSensibilitiesOperationData]);
            AddTableDataSet(cSensibilitiesOperationByYield, _SensibilitiesTables.Tables[cSensibilitiesOperationByYield]);
            AddTableDataSet(cSensibilitiesOperationByTerm, _SensibilitiesTables.Tables[cSensibilitiesOperationByTerm]);
            AddTableDataSet(cSensibilitiesByYield, _SensibilitiesTables.Tables[cSensibilitiesByYield]);

        }

        #endregion

        #region "Estimación"

        public void Estimation()
        {

            #region "Definición de Variables"

            DataSet _PortFolio;
            DataSet _Sensibilities;

            DataTable _PortFolioToday;
            DataTable _PortFolioTomorrow;
            DataTable _PortFolioEstimation;
            DataTable _PortFolioTimeDecay;
            DataTable _ExchangeRate;
            DataTable _EffectRate;
            DataTable _IndexValueForwardFixingRate;
            DataTable _RateBenchMark;

            DataTable _PortFolioFlowToday;
            DataTable _PortFolioFlowTomorrow;
            DataTable _PortFolioEstimationFlow;
            DataTable _PortFolioTimeDecayFlow;
            DataTable _ExchangeRateFlow;
            DataTable _EffectRateFlow;

            DateTime _LoadPortFolioDate;
            DateTime _ExpiryDate;

            int _Row;
            DataRow _DataRow;

            BussineDate.BussineDate _ValidDate = new cFinancialTools.BussineDate.BussineDate(mPortFolioDateToday);

            #endregion

            #region "Inicialización de Variables"

            _PortFolio = new DataSet();
            _Sensibilities = new DataSet();

            _PortFolioToday = new DataTable();
            _PortFolioFlowToday = new DataTable();
            _PortFolioTomorrow = new DataTable();
            _PortFolioTimeDecay = new DataTable();
            _ExchangeRate = new DataTable();
            _EffectRate = new DataTable();
            _IndexValueForwardFixingRate = new DataTable();
            _RateBenchMark = new DataTable();

            _PortFolioFlowToday = new DataTable();
            _PortFolioFlowTomorrow = new DataTable();
            _PortFolioEstimationFlow = new DataTable();
            _PortFolioTimeDecayFlow = new DataTable();
            _ExchangeRateFlow = new DataTable();
            _EffectRateFlow = new DataTable();

            #endregion

            #region "Validación de Fin de Mes Especial"

            _LoadPortFolioDate = mPortFolioDateToday;

            if (mPortFolioDateToday.Equals(_ValidDate.EnfOfMonth))
            {
                _LoadPortFolioDate = mPortFolioDateYesterday;
            //    mPortFolioDateToday = _ValidDate.EnfOfMonth;
            //    mYieldDateRateToday = _ValidDate.EnfOfMonth;
            //    mCurrencyDateExchangeRateToday = _ValidDate.EnfOfMonth;

            //    mYieldDateRateYesterday = mPortFolioDateYesterday;
            //    mCurrencyDateExchangeRateYesterday = mPortFolioDateYesterday;s


            //    LoadCurrency(mPortFolioDateToday);
            //    LoadYield(mPortFolioDateToday);

            }

            //_ValidDate = new cFinancialTools.BussineDate.BussineDate(mPortFolioDateYesterday);

            //if (!(mPortFolioDateYesterday.Month == mPortFolioDateToday.Month) && !(mPortFolioDateYesterday.Equals(_ValidDate.EnfOfMonth)))
            //{
            //    mPortFolioDateYesterday = _ValidDate.EnfOfMonth;
            //    mYieldDateRateYesterday = _ValidDate.EnfOfMonth;
            //    mCurrencyDateExchangeRateYesterday = _ValidDate.EnfOfMonth;

            //    LoadCurrency(mYieldDateRateYesterday);
            //    LoadYield(mYieldDateRateYesterday);
            //}

            #endregion

            #region "01.- Carga de Carteras"

            #region "Carga Cartera 1"

            _PortFolio = Load(_LoadPortFolioDate); //mPortFolioDateToday

            _PortFolioToday = _PortFolio.Tables["ForwardPortFolio"];
            _PortFolioToday.TableName = cPortFolioToday;

            #region "Limpieza de operaciones que vencieron en t(-1)"

            for (_Row = (_PortFolioToday.Rows.Count - 1); _Row > 0; _Row--)
            {

                _DataRow = _PortFolioToday.Rows[_Row];

                _ExpiryDate = DateTime.Parse(_DataRow["ExpiryDate"].ToString());

                if (_ExpiryDate < mPortFolioDateToday)
                {
                    _PortFolioToday.Rows.Remove(_DataRow);
                }

            }

            #endregion

            _PortFolioFlowToday = _PortFolio.Tables["ForwardPortFolioFlow"];
            _PortFolioFlowToday.TableName = cPortFolioTodayFlow;
            _IndexValueForwardFixingRate = _PortFolio.Tables["IndexValueForwardFixingRate"];
            _RateBenchMark = _PortFolio.Tables["RateBenchMarck"];

            #endregion

            #region "Asigna Cartera 1 a Time Decay y Cambio de T/C"

            _PortFolioTimeDecay = CopyTable("TimeDecay", _PortFolioToday);
            _ExchangeRate = CopyTable("ExchangeRate", _PortFolioToday);
            _EffectRate = CopyTable("EffectRate", _PortFolioToday);

            _PortFolioTimeDecayFlow = CopyTable("TimeDecayFlow", _PortFolioFlowToday); ;
            _ExchangeRateFlow = CopyTable("ExchangeRateFlow", _PortFolioFlowToday); ;
            _EffectRateFlow = CopyTable("EffectRateFlow", _PortFolioFlowToday); ;

            #endregion

            #region "Carga Cartera 2"

            //_PortFolioTomorrow = Load(mPortFolioDateTomorrow, mMarkToMarketDateTomorrow);
            _PortFolioTomorrow = CopyTable(cPortFolioTomorrow, _PortFolioToday);
            _PortFolioFlowTomorrow = CopyTable(cPortFolioFlowTomorrow, _PortFolioFlowToday);
            //_PortFolioTomorrow.TableName = cPortFolioTomorrow;
            //LoadFlow(_PortFolioTomorrow);

            #endregion

            #endregion

            #region "02.- Valorización y MTM de Cartera T0"

            #region "Mark To Market"

            _PortFolioToday = MarkToMarket(
                                             _PortFolioToday,
                                             _PortFolioFlowToday,
                                             _RateBenchMark,
                                             _IndexValueForwardFixingRate,
                                             mPortFolioDateToday,
                                             mYieldDateRateToday,
                                             mCurrencyDateExchangeRateToday
                                           );
            mMarkToMarketToday = mMarkToMarketValue;
            mMarkToMarketTodayUM = mMarkToMarketValueUM;

            #endregion

            #endregion

            #region "03.- Cajas"

            mCashFlowValue = mCashFlow; // Falta agregar el tema de los cupones en los valorizadores"

            #endregion

            #region "04.- Valorización y MTM de Cartera T1"

            #region "Valorización Cartera"

            mPresenteValue = 0;

            #endregion

            #region "Mark To Market"

            _PortFolioTomorrow = MarkToMarket(
                                               _PortFolioTomorrow,
                                               _PortFolioFlowTomorrow,
                                               _RateBenchMark,
                                               _IndexValueForwardFixingRate,
                                               mPortFolioDateYesterday,
                                               mYieldDateRateYesterday,
                                               mCurrencyDateExchangeRateYesterday
                                             );
            mMarkToMarketTomorrow = mMarkToMarketValue;
            mMarkToMarketTomorrowUM = mMarkToMarketValueUM;

            #endregion

            #endregion

            #region "05.- Calculo del Valor Real"

            mBalanceReal = mMarkToMarketTomorrow - mMarkToMarketToday;

            #endregion

            #region "06.- Calculo de la Estimación"

            _PortFolioEstimation = CopyTable("PortFolio", _PortFolioToday);
            _PortFolioEstimationFlow = CopyTable("PortFolioFlow", _PortFolioFlowToday); ;

            _Sensibilities = SensibilitiesTables();
            _Sensibilities.Merge(_PortFolioEstimation);
            _Sensibilities.Merge(_PortFolioEstimationFlow);
            _Sensibilities.Merge(_IndexValueForwardFixingRate);
            _Sensibilities.Merge(_RateBenchMark);


            mValuatorFixingRate = enumValuatorFixingRate.Sensibilite;
            _Sensibilities = Sensibilities(_Sensibilities, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);
            mValuatorFixingRate = enumValuatorFixingRate.MartToMarket;

            AddTableDataSet(cSensibilitiesOperationData, _Sensibilities.Tables[cSensibilitiesOperationData]);
            AddTableDataSet(cSensibilitiesOperationByYield, _Sensibilities.Tables[cSensibilitiesOperationByYield]);
            AddTableDataSet(cSensibilitiesOperationByTerm, _Sensibilities.Tables[cSensibilitiesOperationByTerm]);
            AddTableDataSet(cSensibilitiesByYield, _Sensibilities.Tables[cSensibilitiesByYield]);

            #endregion

            #region "07.- Time Decay"

            _PortFolioTimeDecay = MarkToMarket(
                                                _PortFolioTimeDecay,
                                                _PortFolioTimeDecayFlow,
                                                _RateBenchMark,
                                                _IndexValueForwardFixingRate, 
                                                mPortFolioDateToday,
                                                mYieldDateRateYesterday,
                                                mCurrencyDateExchangeRateYesterday
                                              );
            mMarkToMarketTimeDecay = mMarkToMarketValue;
            mMarkToMarketTimeDecayUM = mMarkToMarketValueUM;
            mTimeDecayValue = mMarkToMarketTimeDecay - mMarkToMarketTomorrow;

            #endregion

            #region "08.- Operaciones Nuevas"

            mNewOperationValue = 0; // Falta contruir esta rutina

            #endregion

            #region "09.- Efecto Cambio / Reajuste"

            _ExchangeRate = MarkToMarket(
                                           _ExchangeRate,
                                           _ExchangeRateFlow,
                                           _RateBenchMark,
                                           _IndexValueForwardFixingRate,
                                           mPortFolioDateYesterday,
                                           mYieldDateRateYesterday,
                                           mCurrencyDateExchangeRateToday
                                         );
            mEffectExchangeRateValue = mMarkToMarketValue - mMarkToMarketTomorrow;

            #endregion

            #region "10.- Efecto Tasa"

            _EffectRate = MarkToMarket(
                                        _EffectRate,
                                        _EffectRateFlow,
                                        _RateBenchMark,
                                        _IndexValueForwardFixingRate,
                                        mPortFolioDateYesterday,
                                        mYieldDateRateToday,
                                        mCurrencyDateExchangeRateYesterday
                                      );
            mEffectRateValue = mMarkToMarketValue - mMarkToMarketTomorrow;

            #endregion

            #region "11.- Actualiza DataSet con Cartera T0 y T1"

            AddTableDataSet(cPortFolioToday, _PortFolioToday);
            AddTableDataSet(cPortFolioTomorrow, _PortFolioTomorrow);
            AddTableDataSet("TimeDecay", _PortFolioTimeDecay);
            AddTableDataSet("ExhangeRate", _ExchangeRate);
            AddTableDataSet("EffectRate", _EffectRate);

            #endregion

            #region "12.- Grabar valores"

            SaveData();

            #endregion

        }

        private void SaveData()
        {

            #region "Definición de Variables a Utilizar"

            cData.PortFolio.PortFolioForward _PortFolioForward;
            int _Yield;
            string _YieldName;
            int _Currency;
            int _CurrencyID;
            enumSource _Source;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioForward = new cData.PortFolio.PortFolioForward(enumSource.System);

            #endregion

            #region "Grabar Cartera"

            mPortFolio.SaveLog(2);

            _PortFolioForward.SavePortFolio(PortFolioDate, PortFolioDataSet, mUserID);

            #endregion

            #region "Save Yield"

            for (_Yield = 0; _Yield < mYieldArray.Count; _Yield++)
            {
                _YieldName = (string)mYieldArray[_Yield];
                mYieldList.Save(_YieldName, mPortFolioDateToday, mYieldDateRateToday, mYieldDateRateYesterday);
                //mYieldList.Save(_YieldName, mYieldDateRateYesterday);
            }

            #endregion

            #region "Save Currency"

            for (_Currency = 0; _Currency < mCurrencyList.Currency.Count; _Currency++)
            {
                _CurrencyID = int.Parse(mCurrencyList.Currency[_Currency].ToString());
                _Source = enumSource.System;

                if (_CurrencyID.Equals(994))
                {
                    _Source = enumSource.CurrencyValueAccount;
                }

                mCurrencyList.Save(
                                    _CurrencyID,
                                    mPortFolioDateToday,
                                    _Source,
                                    mCurrencyDateExchangeRateToday,
                                    mCurrencyDateExchangeRateYesterday,
                                    mUserID
                                  );

            }

            #endregion
        }

        #endregion

        #endregion

        #region "Metodos Privados"

        #region "Carga de instrumentos mencionados en la Cartera"

        private void LoadInstruments(DataRow[] dataRow)
        {

            int _Row;
            String _MNemonicsMask;
            int _OperationNumber;
            int _ID;
            bool _FlagSerie;
            DateTime _PurchaseDate;
            double _PurchaseRate;
            double _Nominal;

            DataRow _DataRow;

            _Row = 0;
            _MNemonicsMask = "";
            _OperationNumber = 0;
            _ID = 0;
            _FlagSerie = false;
            _PurchaseDate = new DateTime(1900, 1, 1);
            _PurchaseRate = 0;
            _Nominal = 0;

            for (_Row = 0; _Row < dataRow.Length; _Row++)
            {

                _DataRow = dataRow[_Row];

                // Leer Datos Forward Renta Fija

                _MNemonicsMask = _DataRow["MNemonicsMask"].ToString();
                _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());
                _ID = 0;
                _FlagSerie = _DataRow["DevelonmentTable"].Equals("S");
                _Nominal = double.Parse(_DataRow["AmountPrimaryCurrency"].ToString());

                if (!(_DataRow["PurchaseDate"].ToString() == ""))
                {
                    _PurchaseDate = DateTime.Parse(_DataRow["PurchaseDate"].ToString());
                }

                _PurchaseRate = double.Parse(_DataRow["ExchangeRate"].ToString());

                if (_FlagSerie)
                {
                    mMnemonicsList.Load(_MNemonicsMask, enumSource.System, _Nominal, _PurchaseDate, _PurchaseRate);
                }
                else
                {
                    mMnemonicsList.Load(_OperationNumber, _ID, enumSource.System, _Nominal, _PurchaseDate, _PurchaseRate);
                }

            }

        }

        #endregion

        #region "Rutinas de Valorización privadas"

        #region "Carga Cartera"

        private DataSet Load(DateTime portFolioDate)
        {

            #region "Definición de Variables a Utilizar"

            cData.PortFolio.PortFolioForward _PortFolioForward;
            DataSet _PortFolio;
            DataTable _PortFolioData;
            DataTable _PortFolioFlow;
            DataTable _IndexValueForwardFixingRate;
            DataRow[] _DataRows;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioForward = new cData.PortFolio.PortFolioForward(enumSource.System);
            _PortFolio = new DataSet();
            _PortFolioData = new DataTable();
            _PortFolioFlow = new DataTable();
            _IndexValueForwardFixingRate = new DataTable();
            mPortFolioDataSet = new DataSet();

            #endregion

            #region "Carga de Cartera"

            _PortFolio = (DataSet)_PortFolioForward.LoadPortFolio(portFolioDate);

            _PortFolioData = _PortFolio.Tables["ForwardPortFolio"];
            _PortFolioFlow = _PortFolio.Tables["ForwardPortFolioFlow"];
            _IndexValueForwardFixingRate = _PortFolio.Tables["IndexValueForwardFixingRate"];

            AddColumnPortFolio(_PortFolioData);
            AddColumnPortFolio(_PortFolioFlow);

            _PortFolio.Merge(LoadBenchMarck(mPortFolioDateToday, mPortFolioDateYesterday));

            _DataRows = _PortFolioData.Select("ProductType = 10");

            if (!_DataRows.Length.Equals(0))
            {
                LoadInstruments(_DataRows);
            }

            #endregion

            return _PortFolio;

        }

        #endregion

        #region "Mark to Market"

        private DataTable MarkToMarket(
                                        DataTable portFolioData,
                                        DataTable portFolioFlow,
                                        DataTable rateBenchMark,
                                        DataTable indexValueForwardFixingRate,
                                        DateTime valuatorDate,
                                        DateTime yieldDate,
                                        DateTime exchangeRateDate
                                      )
        {

            #region "Variable utilizadas en la configuracion"

            int _Row;
            int _Column;
            DataRow _DataRow;
            string _YieldName;
            int _ProductType;
            int _OperationNumber;

            #endregion

            #region "Cambia el tipo de tasa que se aplicará en la curva"

            for (_Row = 0; _Row < mYieldList.Count; _Row++)
            {
                _YieldName = (string)mYieldArray[_Row];
                if (_YieldName.Equals("CURVASWAPUF") || _YieldName.Equals("CURVASWAPUSDLOCAL") || _YieldName.Equals("CURVASWAPCLP"))
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                }
                else
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateOriginalSpread;
                }
            }

            #endregion

            #region "Ciclo para recorrer la cartera"

            mMarkToMarketValue = 0;

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {

                #region "Rescata el Contrato"

                _DataRow = portFolioData.Rows[_Row];

                #endregion

                #region "Obtiene tipo de forward"

                _ProductType = int.Parse(_DataRow["ProductType"].ToString());
                _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());

                #endregion


                if (_OperationNumber.Equals(9189))
                {
                    _OperationNumber = 9189;
                }


                #region "Valoriza el Contrato a Mark to Market"

                _DataRow = MarkToMarketProductValuator(
                                                        _ProductType,
                                                        _DataRow,
                                                        portFolioFlow,
                                                        rateBenchMark,
                                                        indexValueForwardFixingRate,
                                                        valuatorDate,
                                                        yieldDate,
                                                        exchangeRateDate
                                                      );


                mMarkToMarketValue += double.Parse(_DataRow["ValuatorFairValueNet"].ToString());

                #endregion

                #region "Setea valores contratos"

                for (_Column = 0; _Column < portFolioData.Columns.Count; _Column++)
                {
                    portFolioData.Rows[_Row][_Column] = _DataRow[_Column];
                }

                #endregion

            }

            #endregion

            return portFolioData;

        }

        private DataRow MarkToMarketProductValuator(
                                                     int _ProductType,
                                                     DataRow dataRow,
                                                     DataTable dataFlow,
                                                     DataTable rateBenchMark,
                                                     DataTable indexValueForwardFixingRate,
                                                     DateTime portFolioDate,
                                                     DateTime yieldDate,
                                                     DateTime currencyDate
                                                   )
        {

            switch (_ProductType)
            {

                case 1: // Seguros de Cambio
                    dataRow = MarkToMarktSureChange(dataRow, portFolioDate, yieldDate, currencyDate);
                    break;

                case 2: // Arbitrajes
                    //dataRow = MarkToMarktArbitration(dataRow, portFolioDate, yieldDate, currencyDate);
                    break;

                case 3: // Seguros de Inflación
                    dataRow = MarkToMarktSureInflation(dataRow, portFolioDate, yieldDate, currencyDate);
                    break;

                case 10: // Forward de Renta Fija
                    dataRow = MarkToMarktForwardRateFixing(
                                                            dataRow,
                                                            rateBenchMark,
                                                            indexValueForwardFixingRate,
                                                            portFolioDate,
                                                            yieldDate,
                                                            currencyDate
                                                          );
                    break;

                case 13: // Forward Anidados
                    dataRow = MarkToMarktForwardNested(dataRow, dataFlow, portFolioDate, yieldDate, currencyDate);
                    break;

                default:
                    break;

            }

            return dataRow;

        }

        private DataRow MarkToMarktSureChange(
                                               DataRow dataRow,
                                               DateTime portFolioDate,
                                               DateTime yieldDate,
                                               DateTime currencyDate
                                             )
        {

            return MarkToMarketContract(dataRow, portFolioDate, yieldDate, currencyDate);
            
        }

        private DataRow MarkToMarktSureInflation(
                                                  DataRow dataRow,
                                                  DateTime portFolioDate,
                                                  DateTime yieldDate,
                                                  DateTime currencyDate
                                                )
        {

            return MarkToMarketContract(dataRow, portFolioDate, yieldDate, currencyDate);

        }

        private DataRow MarkToMarktForwardNested(
                                                  DataRow dataRow,
                                                  DataTable dataFlow,
                                                  DateTime portFolioDate,
                                                  DateTime yieldDate,
                                                  DateTime currencyDate
                                                )
        {


            #region "Definición de Variables"

            DataRow[] _DataRows;
            DataRow _DataRow;
            int _Row;
            int _OperationNumber;
            string _OperationType;
            int _CurrencyPrincipal;
            int _CurrencySecondary;
            double _OperationFairValueAsset;
            double _OperationFairValueAssetUM;
            double _OperationFairValueLiabilities;
            double _OperationFairValueLiabilitiesUM;
            double _OperationFairValueNet;
            int _OperationTerm;
            double _CashFlow;

            #endregion

            #region "Asignación de Variables"

            _OperationNumber = int.Parse(dataRow["OperationNumber"].ToString());
            _OperationType = dataRow["OperationType"].ToString();
            _CurrencyPrincipal = int.Parse(dataRow["PrimaryCurrency"].ToString());
            _CurrencySecondary = int.Parse(dataRow["SecondaryCurrency"].ToString());
            _OperationFairValueAsset = 0;
            _OperationFairValueAssetUM = 0;
            _OperationFairValueLiabilities = 0;
            _OperationFairValueLiabilitiesUM = 0;
            _OperationFairValueNet = 0;
            _OperationTerm = 0;
            _CashFlow = 0;

            #endregion

            #region "Obtiene Flujos de la operación Forward"

            _DataRows = dataFlow.Select("OperationNumber = " + _OperationNumber.ToString());

            #endregion

            #region Calculo de Mark To Market por Flujo"

            for (_Row = 0; _Row < _DataRows.Length; _Row++)
            {

                _DataRow = _DataRows[_Row];

                _DataRow["PrimaryCurrency"] = _CurrencyPrincipal;
                _DataRow["SecondaryCurrency"] = _CurrencySecondary;
                _DataRow["OperationType"] = _OperationType;
                _DataRow = MarkToMarketContract(_DataRow, portFolioDate, yieldDate, currencyDate);

                _OperationFairValueAsset += double.Parse(_DataRow["ValuatorFairValueAsset"].ToString());
                _OperationFairValueAssetUM += double.Parse(_DataRow["ValuatorFairValueAssetUM"].ToString());
                _OperationFairValueLiabilities += double.Parse(_DataRow["ValuatorFairValueLiabilities"].ToString());
                _OperationFairValueLiabilitiesUM += double.Parse(_DataRow["ValuatorFairValueLiabilitiesUM"].ToString());
                _OperationFairValueNet += double.Parse(_DataRow["ValuatorFairValueNet"].ToString());
                _OperationTerm += int.Parse(_DataRow["ValuatorTerm"].ToString());
                _CashFlow += double.Parse(_DataRow["CashFlow"].ToString());

            }

            #endregion

            #region "Actualiza valores de la operación"

            dataRow["ValuatorFairValueAsset"] = _OperationFairValueAsset;
            dataRow["ValuatorFairValueAssetUM"] = _OperationFairValueAssetUM;
            dataRow["ValuatorFairValueLiabilities"] = _OperationFairValueLiabilities;
            dataRow["ValuatorFairValueLiabilitiesUM"] = _OperationFairValueLiabilitiesUM;
            dataRow["ValuatorFairValueNet"] = _OperationFairValueNet;
            dataRow["ValuatorTerm"] = _OperationTerm;
            dataRow["ValuatorPrimaryCurrencyRate"] = 0;
            dataRow["ValuatorSecondaryCurrencyRate"] = 0;
            dataRow["ValuatorForwardPriceTheory"] = 0;
            dataRow["PriceForwardTheory"] = 0;
            dataRow["CashFlow"] = _CashFlow;

            #endregion

            return dataRow;

        }

        private DataRow MarkToMarketContract(
                                              DataRow dataRow,
                                              DateTime portFolioDate,
                                              DateTime yieldDate,
                                              DateTime currencyDate
                                            )
        {

            #region "Definición de Variables"

            int _OperationNumber;
            int _CurrencyPrincipal;
            int _CurrencySecondary;
            double _AmountPrincipal;
            double _AmountSecondary;
            double _ExchangeRate;
            string _CurvePrincipal;
            string _CurveSecondary;
            double _RateCurvePrincipal;
            double _RateCurveSecondary;
            DateTime _ExpiryDate;
            DateTime _CloseContractDate;

            DateTime _Date;
            int _Term;
            int _TermYield;
            double _ForwardRate;
            double _ForwardRateDiscount;
            double _ContractRate;

            double _FairValueAsset;
            double _FairValueAssetUM = 0;
            double _FairValueLiabilities;
            double _FairValueLiabilitiesUM = 0;
            double _FairValueNet;
            double _FairValueNetCost;
            double _ExchangeRateCost;
            double _ForwardRateCost;
            double _CurrencyExhangeRate;
            double _CashFlowAsset;
            double _CashFlowLiabilities;
            double _ContractRateCost;

            double _WFactorCurrencyPrincipal;
            double _WFactorCurrencySecondary;
            double _WFactorDiscount;

            double _ExchangeRateContract;
            double _ForwardRateAdjusment;
            double _ExchangeRateAdjustmentValue;
            double _ExchangeRateAdjustment;
            double _MarktoMakerRateAdjustment;
            double _CarryCostValue;
            double _CarryCostValueCLP;
            string _OperationType;
            double _UM;
            string _UnWind;
            string _PaymentType;

            cFinancialTools.DayCounters.Basis _Basis = new cFinancialTools.DayCounters.Basis();

            #endregion

            #region "Asignación de Variables"

            _OperationNumber = int.Parse(dataRow["OperationNumber"].ToString());
            _CurrencyPrincipal = int.Parse(dataRow["PrimaryCurrency"].ToString());
            _CurrencySecondary = int.Parse(dataRow["SecondaryCurrency"].ToString());
            _AmountPrincipal = double.Parse(dataRow["AmountPrimaryCurrency"].ToString());
            _AmountSecondary = double.Parse(dataRow["AmountSecondaryCurrency"].ToString());
            _OperationType = dataRow["OperationType"].ToString();
            _CloseContractDate = DateTime.Parse(dataRow["PurchaseDate"].ToString());
            _ContractRateCost = double.Parse(dataRow["ExchangeRatePoint"].ToString());
            _UnWind = dataRow["UnWind"].ToString();
            _PaymentType = dataRow["PaymentType"].ToString();

            #endregion

            #region "Rescata Valor de Tasa"

            _ExchangeRateContract = double.Parse(dataRow["ExchangeRate"].ToString());

            #endregion

            #region "Asignación de la Fecha Efectiva o Vencimiento"

            _ExpiryDate = DateTime.Parse(dataRow["ExpiryDate"].ToString());

            if (mCalculateDate == enumCalculateDate.ExpiryDate)
            {
                _Date = DateTime.Parse(dataRow["ExpiryDate"].ToString());
            }
            else
            {
                _Date = DateTime.Parse(dataRow["EffectiveDate"].ToString());
            }

            #endregion

            #region "Tipo Cambio Spot"

            if (_CurrencyPrincipal.Equals(13) && _CurrencySecondary.Equals(999))
            {
                _ExchangeRate = ExchangeRate(994, currencyDate);
                //mCurrencyList.Read(994, enumSource.CurrencyValueAccount, currencyDate).ExchangeRate;

                if (_ExchangeRate.Equals(0))
                {
                    _ExchangeRate = ExchangeRate(994, mCurrencyDateExchangeRateYesterday);
                    //mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                }

            }
            else if (_CurrencyPrincipal.Equals(13) && _CurrencySecondary.Equals(998))
            {
                _ExchangeRate = ExchangeRate(994, currencyDate); 
                //mCurrencyList.Read(994, enumSource.CurrencyValueAccount, currencyDate).ExchangeRate;

                if (_ExchangeRate.Equals(0))
                {
                    _ExchangeRate = ExchangeRate(994, mCurrencyDateExchangeRateYesterday);
                    //mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                }

                _ExchangeRate = _ExchangeRate / ExchangeRate(998, currencyDate); 
                //mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
            }
            else if (_CurrencyPrincipal.Equals(998) && _CurrencySecondary.Equals(999))
            {
                _ExchangeRate = ExchangeRate(998, currencyDate);
                //mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
            }
            else
            {
                _ExchangeRate = 0;
            }

            if (_CloseContractDate.Equals(mPortFolioDateToday))
            {
                _ExchangeRateCost = double.Parse(dataRow["ExchangeRateCost"].ToString());
            }
            else
            {
                _ExchangeRateCost = 0;
            }

            _ExchangeRateAdjustmentValue = double.Parse(dataRow["ExchangeRateCost"].ToString());

            #endregion

            #region "Obtener nombre de la curva"

            _CurvePrincipal = GetYield(_CurrencyPrincipal, _CurrencySecondary);
            _CurveSecondary = GetYield(_CurrencySecondary, _CurrencyPrincipal);

            #endregion

            #region "Calculo del Plazo"

            _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, portFolioDate, _Date);
            _Term = (int)_Basis.Term;

            #endregion

            #region "Calculo del Plazo"

            _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, yieldDate, _Date);
            _TermYield = (int)_Basis.Term;

            #endregion
            
            #region "Obtiene las tasas para cada pierna"

            // Se Cambia el plazo con el cual se rescata la tasas en MP y MS.
            // _RateCurvePrincipal = mYieldList.Read(_CurvePrincipal, enumSource.System, yieldDate, _TermYield).Rate;
            // _RateCurveSecondary = mYieldList.Read(_CurveSecondary, enumSource.System, yieldDate, _TermYield).Rate;

            _RateCurvePrincipal = mYieldList.Read(_CurvePrincipal, enumSource.System, yieldDate, _Term).Rate;
            _RateCurveSecondary = mYieldList.Read(_CurveSecondary, enumSource.System, yieldDate, _Term).Rate;

            #endregion

            #region "Calculo de la tasa Forward"

            if (_CurrencyPrincipal.Equals(998))
            {
                _WFactorCurrencyPrincipal = Math.Pow(1.0 + _RateCurvePrincipal * 0.01, _Term / 360.0);
                _WFactorCurrencySecondary = Math.Pow(1.0 + _RateCurveSecondary * 0.01, _Term / 360.0);

            }
            else
            {
                _WFactorCurrencyPrincipal = (1.0 + _RateCurvePrincipal * 0.01 * _Term / 360.0);
                _WFactorCurrencySecondary = (1.0 + _RateCurveSecondary * 0.01 * _Term / 360.0);

            }

            _WFactorDiscount = (1.0 + _RateCurveSecondary * 0.01 * _Term / 360.0);

            // Calculo de la tasa Forward para los Seguro de Cambio
            _ForwardRate = _ExchangeRate * _WFactorCurrencySecondary / _WFactorCurrencyPrincipal;
            _ForwardRateCost = _ExchangeRateCost *  _WFactorCurrencySecondary / _WFactorCurrencyPrincipal;
            _ForwardRateAdjusment = _ExchangeRateAdjustmentValue * _WFactorCurrencySecondary / _WFactorCurrencyPrincipal;

            #endregion

            #region "Asigna el precio de contrato"

            _ContractRate = _ExchangeRateContract;

            #endregion

            #region "Calculo del delta a descuento, entre el precio de contrato y tasas forward"

            if (_OperationType.Equals("C"))
            {
                _ExchangeRate = (_ForwardRate - _ExchangeRateContract) / _WFactorDiscount;
                _ExchangeRateCost = (_ForwardRateCost - _ExchangeRateContract) / _WFactorDiscount;
                _ExchangeRateAdjustment = (_ForwardRateAdjusment - _ExchangeRateContract) / _WFactorDiscount;
            }
            else
            {
                _ExchangeRate = (_ExchangeRateContract - _ForwardRate) / _WFactorDiscount;
                _ExchangeRateCost = (_ExchangeRateContract - _ForwardRateCost) / _WFactorDiscount;
                _ExchangeRateAdjustment = (_ExchangeRateContract - _ForwardRateAdjusment) / _WFactorDiscount;
            }

            #endregion

            #region "Calculo de los precio a valor presente"

            _ForwardRateDiscount = _ForwardRate / _WFactorDiscount;
            _ContractRate = _ContractRate / _WFactorDiscount;

            #endregion

            #region "Calculo del Valor Razonable Activo y pasivo"

            if (_OperationType.Equals("C"))
            {
                _FairValueAsset = _AmountPrincipal * _ForwardRateDiscount;
                _FairValueLiabilities = _AmountPrincipal * _ContractRate;
            }
            else
            {
                _FairValueAsset = _AmountPrincipal * _ContractRate;
                _FairValueLiabilities = _AmountPrincipal * _ForwardRateDiscount;
            }

            #endregion

            #region "Calculo del Valor Razonable Neto"

            _FairValueNet = _AmountPrincipal * _ExchangeRate;
            _FairValueNetCost = _AmountPrincipal * _ExchangeRateCost;
            _MarktoMakerRateAdjustment = _AmountPrincipal * _ExchangeRateAdjustment;

            #endregion

            #region "Carry Value"

            _CarryCostValue = 0;
            _CarryCostValueCLP = 0;

            if (!_UnWind.Equals("A"))
            {
                if ((_ExpiryDate > portFolioDate && _PaymentType.Equals("E")) || (_Date > portFolioDate && _PaymentType.Equals("C")))
                {

                    _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, mPortFolioDateToday, mPortFolioDateTomorrow);
                    _CarryCostValue = _AmountPrincipal / (1.0 + _RateCurvePrincipal * 0.01 * _Term / 360.0);

                    if (_OperationType.Equals("C"))
                    {
                        _CarryCostValue = _CarryCostValue * (mTAB30Days - mCarryRateUSD) * 0.01 * _Basis.TermBasis;
                    }
                    else
                    {
                        _CarryCostValue = _CarryCostValue * (mCarryRateUSD - mTAB30Days) * 0.01 * _Basis.TermBasis;
                    }

                    if (_CurrencyPrincipal.Equals(13) && _CurrencySecondary.Equals(999))
                    {

                        _CarryCostValueCLP = _CarryCostValue * ExchangeRate(994, mCurrencyDateExchangeRateToday);

                    }

                }

            }

            #endregion

            #region "Si el Forward es un Seguro de cambio reajustable se multiplica por la UF"

            if (_CurrencySecondary.Equals(998))
            {
                _CurrencyExhangeRate = mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
                _FairValueAsset = _FairValueAsset * _CurrencyExhangeRate;
                _FairValueLiabilities = _FairValueLiabilities * _CurrencyExhangeRate;
                _FairValueNet = _FairValueNet * _CurrencyExhangeRate;
            }

            #endregion

            #region "Calculo del Valor Razonable en la moneda de origen"

            if (_OperationType.Equals("C"))
            {
                if (_CurrencyPrincipal.Equals(13))
                {
                    _CurrencyExhangeRate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, currencyDate).ExchangeRate;
                    if (_CurrencyExhangeRate.Equals(0))
                    {
                        _CurrencyExhangeRate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                    }

                    _FairValueAssetUM = _FairValueAsset / _CurrencyExhangeRate;
                    _FairValueLiabilitiesUM = _FairValueLiabilities;


                    if (_CurrencySecondary.Equals(998))
                    {
                        _CurrencyExhangeRate = mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
                        _FairValueLiabilitiesUM = _FairValueLiabilities / _CurrencyExhangeRate;
                    }

                }
                else if (_CurrencyPrincipal.Equals(998))
                {
                    _CurrencyExhangeRate = mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
                    _FairValueAssetUM = _FairValueAsset / _CurrencyExhangeRate;
                    _FairValueLiabilitiesUM = _FairValueLiabilities;
                }
            }
            else
            {
                if (_CurrencyPrincipal.Equals(13))
                {
                    _CurrencyExhangeRate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, currencyDate).ExchangeRate;
                    if (_CurrencyExhangeRate.Equals(0))
                    {
                        _CurrencyExhangeRate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                    }

                    _FairValueAssetUM = _FairValueAsset;
                    _FairValueLiabilitiesUM = _FairValueLiabilities / _CurrencyExhangeRate;

                    if (_CurrencySecondary.Equals(998))
                    {
                        _CurrencyExhangeRate = mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
                        _FairValueAssetUM = _FairValueAsset / _CurrencyExhangeRate;
                    }

                }
                else if (_CurrencyPrincipal.Equals(998))
                {
                    _CurrencyExhangeRate = mCurrencyList.Read(998, enumSource.System, currencyDate).ExchangeRate;
                    _FairValueAssetUM = _FairValueAsset;
                    _FairValueLiabilitiesUM = _FairValueLiabilities / _CurrencyExhangeRate;
                }
            }

            #endregion

            #region "Asignación de valores a retornar"

            dataRow["ValuatorFairValueAsset"] = _FairValueAsset;
            dataRow["ValuatorFairValueAssetUM"] = _FairValueAssetUM;
            dataRow["ValuatorFairValueLiabilities"] = _FairValueLiabilities;
            dataRow["ValuatorFairValueLiabilitiesUM"] = _FairValueLiabilitiesUM;
            dataRow["ValuatorFairValueNet"] = _FairValueNet;
            dataRow["ValuatorFairValueNetCost"] = _FairValueNetCost;
            dataRow["ValuatorTerm"] = _Term;
            dataRow["ValuatorPrimaryCurrencyRate"] = _RateCurvePrincipal;
            dataRow["ValuatorSecondaryCurrencyRate"] = _RateCurveSecondary;
            dataRow["ValuatorForwardPriceTheory"] = _ExchangeRate;
            dataRow["PriceForwardTheory"] = _ForwardRate;
            dataRow["MarktoMarketRateAdjustment"] = _MarktoMakerRateAdjustment;
            dataRow["PointForward"] = mPointForward;
            dataRow["RateUSD"] = mRateUSD;
            dataRow["RateCLP"] = mRateCLP;
            dataRow["TAB30Days"] = mTAB30Days;
            dataRow["CarryRateUSD"] = mCarryRateUSD;
            dataRow["CarryCostValue"] = _CarryCostValueCLP; // _CarryCostValue;

            #endregion

            #region "Cash Flow"

            if (_ExpiryDate.Equals(portFolioDate))
            {

                double _ExhangeRateCashFlow = 0;

                if (_CurrencyPrincipal.Equals(13))
                {
                    _UM = mCurrencyList.Read(994, enumSource.System, currencyDate).ExchangeRate;
                }
                else
                {
                    _UM = ExchangeRate(_CurrencyPrincipal, currencyDate);
                }

                _ExhangeRateCashFlow = _ExchangeRateContract;

                if (_CurrencySecondary.Equals(998))
                {
                    _ExhangeRateCashFlow = _ExchangeRateContract * ExchangeRate(_CurrencySecondary, currencyDate);
                }

                if (_OperationType.Equals("C"))
                {
                    _CashFlowAsset = _AmountPrincipal * _UM;
                    _CashFlowLiabilities = _AmountPrincipal * _ExhangeRateCashFlow;
                }
                else
                {
                    _CashFlowAsset = _AmountPrincipal * _ExhangeRateCashFlow;
                    _CashFlowLiabilities = _AmountPrincipal * _UM;
                }

                dataRow["CashFlow"] = _CashFlowAsset - _CashFlowLiabilities;

            }

            #endregion

            #region "Calcula Resultado de Distribución"

            if (_CloseContractDate.Equals(mPortFolioDateToday))
            {

                if (_OperationType.Equals("V"))
                {
                    dataRow["TransferDistribution"] = _AmountPrincipal * (_ExchangeRateContract - _ContractRateCost) /
                                                    (1.0 + _RateCurveSecondary * 0.01 * _Term / 360.0);
                    dataRow["ResultDistribution"] = _AmountPrincipal * (_ExchangeRateContract - _ContractRateCost);
                }
                else
                {
                    dataRow["TransferDistribution"] = _AmountPrincipal * (_ContractRateCost - _ExchangeRateContract) /
                                                      (1.0 + _RateCurveSecondary * 0.01 * _Term / 360.0);
                    dataRow["ResultDistribution"] = _AmountPrincipal * (_ContractRateCost - _ExchangeRateContract);
                }
            }

            #endregion

            return dataRow;

        }

        private double ExchangeRate(int currency, DateTime date)
        {

            double _Value;

            if (currency.Equals(13) || currency.Equals(994))
            {
                _Value = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, date).ExchangeRate;
            }
            else if (currency.Equals(998))
            {
                _Value = mCurrencyList.Read(998, enumSource.System, date).ExchangeRate;
            }
            else
            {
                _Value = 1.0;
            }

            return _Value;

        }

        private DataRow MarkToMarktForwardRateFixing(
                                                      DataRow dataRow,
                                                      DataTable rateBenchMark,
                                                      DataTable indexValueForwardFixingRate,
                                                      DateTime portFolioDate,
                                                      DateTime yieldDate,
                                                      DateTime currencyDate
                                                    )
        {

            #region "Definición de Variables"

            int _OperationNumber;
            string _OperationType;
            int _CurrencyPrincipal;
            int _CurrencySecondary;
            double _OperationFairValueAsset;
            double _OperationFairValueAssetUM;
            double _OperationFairValueLiabilities;
            double _OperationFairValueLiabilitiesUM;
            double _OperationFairValueNet;
            double _OperationFairValueNetUM;
            DateTime _ExpiryContract;
            double _RateForward;
            int _OperationTerm;
            int _MNemonicsTerm;

            string _MNemonicsMask;

            double _RateBenchMarck;
            double _ExchangeRate;

            DataRow[] _IndexDataRow;

            DateTime _ExpiryDate;
            DateTime _IssueDate;
            int _IssueCurrency;

            cFinancialTools.DayCounters.Basis _Basis = new cFinancialTools.DayCounters.Basis();
            enumBasis _IssueBasis;
            int _IssueBasisCode;
            string _Key;
            string _YieldName;
            int _MNemonicsCode;
            cFinancialTools.Instruments.MNemonics _MNemonics = new MNemonics();

            double _ValuatorRateForwardUM;
            double _ValuatorRateForwardCLP;
            double _Duration;
            double _RateForwardTheoretical;
            double _RateExpiry;
            double _ValuatorRateForwardTheoreticalUM;
            double _ValuatorRateForwardTheoreticalCLP;

            double _DailyVariationCLP;
            double _DailyVariationUM;
            double _MarkToMarketAssetValue;
            double _MarkToMarketLiabilitiesValue;

            #endregion

            #region "Asignación de Variables"

            _OperationNumber = int.Parse(dataRow["OperationNumber"].ToString());
            _OperationType = dataRow["OperationType"].ToString();
            _CurrencyPrincipal = int.Parse(dataRow["PrimaryCurrency"].ToString());
            _CurrencySecondary = int.Parse(dataRow["SecondaryCurrency"].ToString());
            _MNemonicsMask = dataRow["MNemonicsMask"].ToString();
            _RateForward = double.Parse(dataRow["ExchangeRate"].ToString());
            _RateExpiry = double.Parse(dataRow["ExchangeRateExpiry"].ToString());

            _MNemonics = mMnemonicsList.Read(_MNemonicsMask);
            _YieldName = GetYield(_CurrencyPrincipal);

            _MNemonics.Nominal = double.Parse(dataRow["AmountPrimaryCurrency"].ToString());

            _ExpiryContract = DateTime.Parse(dataRow["ExpiryDate"].ToString());

            if (_CurrencyPrincipal.Equals(994))
            {
                _ExchangeRate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, currencyDate).ExchangeRate;
                if (_ExchangeRate.Equals(0))
                {
                    _ExchangeRate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                }
            }
            else if (_CurrencyPrincipal.Equals(998))
            {
                mCurrencyList.Load(998, enumSource.System, _ExpiryContract, "CURVAFWUSD");
                _ExchangeRate = mCurrencyList.Read(998, enumSource.System, _ExpiryContract).ExchangeRate;

            }
            else if (_CurrencyPrincipal.Equals(999))
            {
                _ExchangeRate = 1;
            }
            else
            {
                _ExchangeRate = 0;
            }

            _OperationFairValueAsset = 0;
            _OperationFairValueAssetUM = 0;
            _OperationFairValueLiabilities = 0;
            _OperationFairValueLiabilitiesUM = 0;
            _OperationFairValueNet = 0;
            _OperationFairValueNetUM = 0;
            _OperationTerm = 0;
            _RateForwardTheoretical = 0;

            #endregion

            #region "Obtener Tasa Bench Marck"

            _RateBenchMarck = 0;

            _ExpiryDate = mMnemonicsList.Read(_MNemonicsMask).ExpiryDate;
            _IssueDate = mMnemonicsList.Read(_MNemonicsMask).StartingDate;
            _IssueBasisCode = mMnemonicsList.Read(_MNemonicsMask).IssueBasis;
            _MNemonicsCode = mMnemonicsList.Read(_MNemonicsMask).MnemonicsID;
            _IssueCurrency = mMnemonicsList.Read(_MNemonicsMask).IssueCurrency;

            switch (_IssueBasisCode)
            {
                case 30:
                    _IssueBasis = enumBasis.Basis_Act_30;
                    break;

                case 360:
                    _IssueBasis = enumBasis.Basis_Act_360;
                    break;

                case 365:
                    _IssueBasis = enumBasis.Basis_Act_365;
                    break;

                default:
                    _IssueBasis = enumBasis.Basis_Act_360;
                    break;
            }

            _Basis = new cFinancialTools.DayCounters.Basis(_IssueBasis, portFolioDate, _ExpiryDate);
            _MNemonicsTerm = (int)Math.Floor(_Basis.TermBasis);

            _Key = "";
            _Key += "Date = '" + mYieldDateRateToday.ToString("dd-MM-yyyy") + "' AND ";
            _Key += "MnemonicsCode = " + _MNemonicsCode.ToString() + " AND ";
            _Key += "Currency = " + _IssueCurrency.ToString() + " AND ";
            _Key += "TermFrom <= " + _MNemonicsTerm.ToString() + " AND ";
            _Key += "TermUntil >= " + _MNemonicsTerm.ToString();

            _IndexDataRow = rateBenchMark.Select(_Key);

            if (!(_IndexDataRow == null))
            {
                _RateBenchMarck = double.Parse(_IndexDataRow[0]["Rate"].ToString());
            }

            #endregion

            if (_ExpiryContract.Equals(portFolioDate))
            {

                #region "Valorizador a Tasa Forward Contrato a Fecha Proceso"

                _MNemonics.PurchaseRate = _RateForward;
                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateForward, portFolioDate, yieldDate, currencyDate);

                _ValuatorRateForwardUM = _MNemonics.PresentValueUM;
                _ValuatorRateForwardCLP = _MNemonics.PresentValueCLP;

                #endregion

                #region "Valorización a Tasa Forward Teorica a Fecha Proceso Contrato"

                _MNemonics.PurchaseRate = _RateExpiry;

                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateExpiry, portFolioDate, yieldDate, currencyDate);

                if (mValuatorFixingRate == enumValuatorFixingRate.Sensibilite)
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                }

                _ValuatorRateForwardTheoreticalUM = _MNemonics.PresentValueUM;
                _ValuatorRateForwardTheoreticalCLP = _MNemonics.PresentValueCLP;

                #endregion

                #region "Calculo de Valor Razonable"

                if (_OperationType.Equals("C"))
                {

                    _OperationFairValueAsset = _ValuatorRateForwardTheoreticalCLP;
                    _OperationFairValueAssetUM = _ValuatorRateForwardTheoreticalUM;
                    _OperationFairValueLiabilities = _ValuatorRateForwardCLP;
                    _OperationFairValueLiabilitiesUM = _ValuatorRateForwardUM;

                }
                else
                {

                    _OperationFairValueAsset = _ValuatorRateForwardCLP;
                    _OperationFairValueAssetUM = _ValuatorRateForwardUM;
                    _OperationFairValueLiabilities = _ValuatorRateForwardTheoreticalCLP;
                    _OperationFairValueLiabilitiesUM = _ValuatorRateForwardTheoreticalUM;

                }

                _OperationFairValueNet = _OperationFairValueAsset - _OperationFairValueLiabilities;
                _OperationFairValueNetUM = _OperationFairValueAssetUM - _OperationFairValueLiabilitiesUM;

                #endregion

                #region "Actualiza valores de la operación"

                dataRow["ValuatorFairValueAsset"] = _OperationFairValueAsset;
                dataRow["ValuatorFairValueAssetUM"] = _OperationFairValueAssetUM;
                dataRow["ValuatorFairValueLiabilities"] = _OperationFairValueLiabilities;
                dataRow["ValuatorFairValueLiabilitiesUM"] = _OperationFairValueLiabilitiesUM;
                dataRow["ValuatorFairValueNet"] = _OperationFairValueNet;
                dataRow["ValuatorFairValueNetUM"] = _OperationFairValueNetUM;
                dataRow["ValuatorTerm"] = _OperationTerm;
                dataRow["ValuatorPrimaryCurrencyRate"] = 0;
                dataRow["ValuatorSecondaryCurrencyRate"] = 0;
                dataRow["ValuatorForwardPriceTheory"] = 0;
                dataRow["ValuatorPrimaryCurrencyRate"] = _RateExpiry;
                dataRow["RateForwardTheory"] = _RateExpiry;
                dataRow["CashFlow"] = _OperationFairValueNet;

                #endregion

            }
            else
            {

                #region "Valorizador a Tasa Forward Contrato a Fecha Vencimiento Contrato"

                _MNemonics.PurchaseRate = _RateForward;
                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateForward, _ExpiryContract, yieldDate, currencyDate);

                _ValuatorRateForwardUM = _MNemonics.PresentValueUM;
                _ValuatorRateForwardCLP = _MNemonics.PresentValueUM * _ExchangeRate;

                #endregion

                #region "Valorización a Tasa Bench Mark a Fecha Vencimiento Contrato"

                _MNemonics.PurchaseRate = _RateBenchMarck;

                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateBenchMarck, _ExpiryContract, yieldDate, currencyDate);

                dataRow["MacaulayDuration"] = _MNemonics.DurationMacaulay;
                dataRow["ModifiedDuration"] = _MNemonics.DurationModificed;
                dataRow["Convexity"] = _MNemonics.Convextion;
                dataRow["ValuatorPrimaryCurrencyRate"] = _MNemonics.PurchaseRate;

                _Duration = _MNemonics.DurationMacaulay;

                #endregion

                #region "Calcula Tasa Forward Teorica a Fecha Vencimiento"

                if (_ExpiryContract.Equals(yieldDate))
                {
                    _RateForwardTheoretical = _RateExpiry;
                }
                else
                {
                    if (mValuatorFixingRate == enumValuatorFixingRate.Sensibilite)
                    {
                        mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                    }

                    _RateForwardTheoretical = RateForwardTheoretical(
                                                                      yieldDate,
                                                                      _ExpiryDate,
                                                                      _ExpiryContract,
                                                                      _RateBenchMarck,
                                                                      _Duration,
                                                                      indexValueForwardFixingRate
                                                                    );
                }

                if (mValuatorFixingRate == enumValuatorFixingRate.Sensibilite)
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                }

                #endregion

                #region "Valorización a Tasa Forward Teorica a Fecha Vencimiento Contrato"

                _MNemonics.PurchaseRate = _RateForwardTheoretical;
                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateForwardTheoretical, _ExpiryContract, yieldDate, currencyDate);

                _ValuatorRateForwardTheoreticalUM = _MNemonics.PresentValueUM;
                _ValuatorRateForwardTheoreticalCLP = _MNemonics.PresentValueUM * _ExchangeRate;

                #endregion

                #region "Calculo de MTM"

                if (_OperationType.Equals("C"))
                {
                    _DailyVariationCLP = _ValuatorRateForwardTheoreticalCLP - _ValuatorRateForwardCLP;
                    _DailyVariationUM = _ValuatorRateForwardTheoreticalUM - _ValuatorRateForwardUM;

                    _MarkToMarketAssetValue = _DailyVariationCLP;
                    _MarkToMarketLiabilitiesValue = _ValuatorRateForwardCLP;

                }
                else
                {
                    _DailyVariationCLP = _ValuatorRateForwardCLP - _ValuatorRateForwardTheoreticalCLP;
                    _DailyVariationUM = _ValuatorRateForwardUM - _ValuatorRateForwardTheoreticalUM;

                    _MarkToMarketAssetValue = _ValuatorRateForwardCLP;
                    _MarkToMarketLiabilitiesValue = _DailyVariationCLP;

                }

                #endregion

                #region "Valorizador a Tasa Forward Contrato a Fecha Proceso"

                _MNemonics.PurchaseRate = _RateForward;
                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateForward, portFolioDate, yieldDate, currencyDate);

                _ValuatorRateForwardUM = _MNemonics.PresentValueUM;
                _ValuatorRateForwardCLP = _MNemonics.PresentValueCLP;

                #endregion

                #region "Valorización a Tasa Bench Mark a Fecha Proceso"

                _MNemonics.PurchaseRate = _RateBenchMarck;
                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateBenchMarck, portFolioDate, yieldDate, currencyDate);

                _Duration = _MNemonics.DurationMacaulay;

                #endregion

                #region "Calcula Tasa Forward Teorica a Fecha Procso"

                if (_ExpiryContract.Equals(yieldDate))
                {

                    _RateForwardTheoretical = _RateExpiry;

                }
                else
                {

                    _RateForwardTheoretical = RateForwardTheoretical(
                                                                      yieldDate,
                                                                      _ExpiryDate,
                                                                      _ExpiryContract,
                                                                      _RateBenchMarck,
                                                                      _Duration,
                                                                      indexValueForwardFixingRate
                                                                    );
                }

                #endregion

                #region "Valorización a Tasa Forward Teorica a Fecha Proceso Contrato"

                _MNemonics.PurchaseRate = _RateForwardTheoretical;

                if (mValuatorFixingRate == enumValuatorFixingRate.Sensibilite)
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                }

                _MNemonics = ValuatorTX(mValuatorFixingRate, dataRow, _RateForwardTheoretical, portFolioDate, yieldDate, currencyDate);

                if (mValuatorFixingRate == enumValuatorFixingRate.Sensibilite)
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                }

                _ValuatorRateForwardTheoreticalUM = _MNemonics.PresentValueUM;
                _ValuatorRateForwardTheoreticalCLP = _MNemonics.PresentValueCLP;

                #endregion

                #region "Calculo de Valor Razonable"

                if (_OperationType.Equals("C"))
                {

                    _OperationFairValueAsset = _ValuatorRateForwardTheoreticalCLP;
                    _OperationFairValueAssetUM = _ValuatorRateForwardTheoreticalUM;
                    _OperationFairValueLiabilities = _ValuatorRateForwardCLP;
                    _OperationFairValueLiabilitiesUM = _ValuatorRateForwardUM;

                }
                else
                {

                    _OperationFairValueAsset = _ValuatorRateForwardCLP;
                    _OperationFairValueAssetUM = _ValuatorRateForwardUM;
                    _OperationFairValueLiabilities = _ValuatorRateForwardTheoreticalCLP;
                    _OperationFairValueLiabilitiesUM = _ValuatorRateForwardTheoreticalUM;

                }

                _OperationFairValueNet = _OperationFairValueAsset - _OperationFairValueLiabilities;
                _OperationFairValueNetUM = _OperationFairValueAssetUM - _OperationFairValueLiabilitiesUM;

                #endregion

                #region "Actualiza valores de la operación"

                dataRow["ValuatorFairValueAsset"] = _OperationFairValueAsset;
                dataRow["ValuatorFairValueAssetUM"] = _OperationFairValueAssetUM;
                dataRow["ValuatorFairValueLiabilities"] = _OperationFairValueLiabilities;
                dataRow["ValuatorFairValueLiabilitiesUM"] = _OperationFairValueLiabilitiesUM;
                dataRow["ValuatorFairValueNet"] = _OperationFairValueNet;
                dataRow["ValuatorFairValueNetUM"] = _OperationFairValueNetUM;
                dataRow["ValuatorTerm"] = _OperationTerm;
                dataRow["ValuatorPrimaryCurrencyRate"] = 0;
                dataRow["ValuatorSecondaryCurrencyRate"] = 0;
                dataRow["ValuatorForwardPriceTheory"] = 0;
                dataRow["ValuatorPrimaryCurrencyRate"] = _RateForwardTheoretical;
                dataRow["RateForwardTheory"] = _RateForwardTheoretical;

                #endregion
            }

            return dataRow;

        }

        #endregion

        #region "Rutina de ejecución de los valorizadores de renta fija"

        protected double RateForwardTheoretical(
                                                  DateTime portFolioDate,
                                                  DateTime expiryDateMNemonics,
                                                  DateTime expiryDateContract,
                                                  double rateBenchMark,
                                                  double duration,
                                                  DataTable indexValueForwardFixingRate
                                               )
        {

            double _RateForwardTheoretical;

            DateTime _DateIPCNext;
            DateTime _DateIPCCurrent;
            DateTime _DateIPCPreviousMonth;
            DateTime _DateIPCTwoMonthBefore;
            DateTime _DateRateMonetaryPolicy;
            double _RateIPCCurrent;
            double _RateIPCPreviousMonth;
            double _RateIPCTwoMonthBefore;
            double _RateMonetaryPolicy;
            double _TermContract;
            double _TermIPCCurrent;
            double _TermIPCNext;
            double _CurrentVariation;
            double _CurrentNext;
            double _RateFinancing;
            double _BasisDay;

            string _Key;

            DataRow[] _IndexDataRow;

            cFinancialTools.DayCounters.Basis _Basis;

            _BasisDay = 360;

            #region "Calculo del Plazo Remanente del Contrato"

            _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_Act, portFolioDate, expiryDateContract);
            _TermContract = _Basis.Term;

            #endregion

            #region "Calculo del plazo Remanente del proximo periodo del IPC"

            if (portFolioDate.Day.Equals(9))
            {
                _DateIPCNext = portFolioDate;
            }
            else if (portFolioDate.Day > 9)
            {
                _DateIPCNext = portFolioDate.AddDays(-portFolioDate.Day + 9);
                _DateIPCNext = _DateIPCNext.AddMonths(1);
            }
            else
            {
                _DateIPCNext = portFolioDate.AddDays(9 - portFolioDate.Day);
            }

                   //select @dFechaProximoNueve = ( case when day( @Fecha ) > 9 then 
                   //                        dateadd( mm, 1, dateadd( dd, - day( @Fecha ) + 9, @Fecha ) )                                                                    
                   //                 else 
                   //                        dateadd( dd, 9 + - day( @Fecha ) ,  @Fecha )
                   //                 end  )

            if (portFolioDate.Day.Equals(9))
            {
                _DateIPCNext = _DateIPCNext.AddMonths(1);
            }

            _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_Act, portFolioDate, _DateIPCNext);
            _TermIPCCurrent = _Basis.Term;

            _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_Act, _DateIPCNext, expiryDateContract);
            _TermIPCNext = 0;
            if (_Basis.Term > 0.0)
            {
                _TermIPCNext = _Basis.Term;
            }

            #endregion

            #region "Rescatar Fecha y Tasa de la politica monetaria"

            _IndexDataRow = indexValueForwardFixingRate.Select("RateCode = 807");
            _RateMonetaryPolicy = 0;

            if (!(_IndexDataRow == null))
            {
                _DateRateMonetaryPolicy = DateTime.Parse(_IndexDataRow[0]["DateValue"].ToString());
                _RateMonetaryPolicy = double.Parse(_IndexDataRow[0]["RateValue"].ToString());
            }

            #endregion

            #region "Calculo de la Fecha IPC Vigente Actual"

            _DateIPCCurrent = _DateIPCNext.AddMonths(-1);
            _DateIPCCurrent = _DateIPCCurrent.AddDays(-_DateIPCCurrent.Day);
            _DateIPCCurrent = _DateIPCCurrent.AddDays(1);

            _Key = "RateCode = 502 AND DateValue = '" + _DateIPCCurrent.ToString("dd/MM/yyyy") + "'";

            _IndexDataRow = indexValueForwardFixingRate.Select(_Key);
            _RateIPCCurrent = 0;

            if (!_IndexDataRow.Length.Equals(0))
            {
                _RateIPCCurrent = double.Parse(_IndexDataRow[0]["RateValue"].ToString());
            }

            #endregion

            #region "Calculo de la Fecha IPC Mes anterior"

            _DateIPCPreviousMonth = _DateIPCCurrent.AddMonths(-1);

            _Key = "RateCode = 502 AND DateValue = '" + _DateIPCPreviousMonth.ToString("dd/MM/yyyy") + "'";

            _IndexDataRow = indexValueForwardFixingRate.Select(_Key);
            _RateIPCPreviousMonth = 0;

            if (!_IndexDataRow.Length.Equals(0))
            {
                _RateIPCPreviousMonth = double.Parse(_IndexDataRow[0]["RateValue"].ToString());
            }

            #endregion

            #region "Calculo de la Fecha IPC 2 Mes anterior"

            _DateIPCTwoMonthBefore = _DateIPCPreviousMonth.AddMonths(-1);

            _Key = "RateCode = 502 AND DateValue = '" + _DateIPCTwoMonthBefore.ToString("dd/MM/yyyy") + "'";

            _IndexDataRow = indexValueForwardFixingRate.Select(_Key);
            _RateIPCTwoMonthBefore = 0;

            if (!_IndexDataRow.Length.Equals(0))
            {
                _RateIPCTwoMonthBefore = double.Parse(_IndexDataRow[0]["RateValue"].ToString());
            }


            #endregion

            #region "Variación Vigente"

            _CurrentVariation = (Math.Pow(
                                          (1.0 + Math.Round(((_RateIPCPreviousMonth - _RateIPCTwoMonthBefore) / _RateIPCPreviousMonth) * 100.0, 1) * 0.01),
                                          12
                                        ) - 1.0) * 100.0; // _RateIPCCurrent

            #endregion

            #region "Variación Poxima"

            if (_RateIPCPreviousMonth.Equals(0) || _RateIPCCurrent.Equals(0))
            {
                _CurrentNext = _CurrentVariation;
            }
            else
            {
                _CurrentNext = (Math.Pow(
                                          (1.0 + Math.Round(((_RateIPCCurrent - _RateIPCPreviousMonth) / _RateIPCPreviousMonth) * 100.0, 1) * 0.01),
                                          12
                                         ) - 1.0) * 100.0;
            }

            #endregion

            #region "Tasa Financiamiento"

            _RateFinancing = ((((1.0 + _RateMonetaryPolicy * 0.01) /
                             (Math.Pow((1.0 + _CurrentVariation * 0.01), (_TermIPCCurrent / _TermContract)))) /
                             (Math.Pow((1.0 + _CurrentNext * 0.01), (_TermIPCNext / _TermContract)))) - 1.0) * 100.0;

            #endregion

            #region "Tasa Forward Teorica"

            _RateForwardTheoretical = Math.Round((Math.Pow((Math.Pow(1.0 + rateBenchMark * 0.01, duration) /
                                                   Math.Pow(1.0 + _RateFinancing * 0.01, _TermContract / _BasisDay)),
                                                   _BasisDay / (duration * _BasisDay - _TermContract)) - 1.0) * 100.0, 4);
                                      
                //(Math.Pow(1.0 + rateBenchMark * 0.01, duration) / Math.Pow((1.0 + _RateFinancing * 0.01),
                                      //_BasisDay / (duration * _BasisDay - _TermContract)) - 1) * 100.0;

            #endregion

            return _RateForwardTheoretical;

        }

        protected cFinancialTools.Instruments.MNemonics ValuatorTX(
                                                                    enumValuatorFixingRate _valuatorFixingRate,
                                                                    DataRow currentRow,
                                                                    double tirValuator,
                                                                    DateTime dateValuator,
                                                                    DateTime dateYield,
                                                                    DateTime dateCurrency
                                                                  )
        {

            int _MNnemonicsID;
            String _MNemonicsMask;
            Boolean _FlagSerie;
            int _OperationNumber;
            int _ID;
            String _MNemonicsKey = "";
            cFinancialTools.Instruments.MNemonics _MNemonics = new MNemonics();
            String _YieldName;
            int _Currency;
            DateTime _ValuatorDate;
            cFinancialTools.Yield.Yield _Yield = new cFinancialTools.Yield.Yield();


            _MNemonicsKey = currentRow["MNemonicsMask"].ToString();
            _MNemonics = mMnemonicsList.Read(_MNemonicsKey);

            _MNemonicsMask = _MNemonics.MnemonicsMask;
            _OperationNumber = int.Parse(currentRow["OperationNumber"].ToString());
            _ID = 0;
            _FlagSerie = _MNemonics.FlagSerie;
            _MNnemonicsID = _MNemonics.MnemonicsID;
            _Currency = _MNemonics.IssueCurrency;
            _YieldName = GetCurve(_Currency);

            _Yield = mYieldList.Read(_YieldName);
            _Yield.Read(enumSource.System).Read(dateYield).RateBasis = tirValuator;

            if (_FlagSerie)
            {
                _MNemonicsKey = _MNemonicsMask;
            }
            else
            {
                _MNemonicsKey = _OperationNumber.ToString() + "." + _ID;
            }

            _MNemonics.Nominal = _MNemonics.Nominal;
            _MNemonics.PurchaseDate = _MNemonics.PurchaseDate;
            _MNemonics.PurchaseRate = tirValuator;
            _MNemonics.StartingDate = _MNemonics.StartingDate;
            _MNemonics.ExpiryDate = _MNemonics.ExpiryDate;

            _ValuatorDate = dateValuator;

            switch (_MNnemonicsID)
            {
                case 4:         // PRC
                case 15:        // BONOS
                case 31:        // PRD
                case 32:        // BCU
                case 33:        // BCP
                case 34:        // BCD
                case 36:        // BTU
                case 38:        // PCX
                case 39:        // BCX
                case 40:        // BTP
                    Bonds _Bonds = new Bonds(enumSource.System, _valuatorFixingRate, _ValuatorDate, dateYield, dateCurrency, 2, _MNemonics, mCurrencyList, _Yield);

                    _Bonds.ValuatorBonds();

                    _MNemonics = _Bonds.MNemonics;

                    break;

                // MD0621C 
                case 6:         // PDBC
                case 7:         // PRBC
                case 9:         // DPF
                case 11:        // DPR
                case 12:        // DPXD
                case 13:        // DPX
                case 14:        // DPD
                case 16:        // ECP
                case 17:        // ECU
                case 18:        // DPE
                case 19:        // DPU$
                case 35:        // PRTR
                case 50:        // DPXA
                case 51:        // DPXB
                case 52:        // DPXC
                case 54:        // DPXE
                    ZeroCoupon _ZeroCoupon = new ZeroCoupon(enumSource.System, _valuatorFixingRate, _ValuatorDate, dateYield, dateCurrency, 2, _MNemonics, mCurrencyList, _Yield);

                    _ZeroCoupon.ValuatorZeroCoupon();

                    _MNemonics = _ZeroCoupon.MNemonics;

                    break;

                // MD0622C
                case 37:        // XERO
                case 300:       // CERO
                case 301:       // ZERO
                    ZeroCouponCompound _ZeroCouponCompound = new ZeroCouponCompound(enumSource.System, _valuatorFixingRate, _ValuatorDate, dateYield, dateCurrency, 2, _MNemonics, mCurrencyList, _Yield);

                    _ZeroCouponCompound.ValuatorZeroCouponCompound();

                    _MNemonics = _ZeroCouponCompound.MNemonics;

                    break;

                default:
                    break;
            }

            return _MNemonics;

        }

        private String GetCurve(int currency)
        {

            String _Value = "";

            if (currency.Equals(998))
            {
                _Value = "CURVASWAPUF";
            }
            else if (currency.Equals(994))
            {
                _Value = "CURVASWAPUSDLOCAL";
            }
            else if (currency.Equals(999))
            {
                _Value = "CURVASWAPCLP";
            }

            return _Value;

        }

        #endregion

        #region Sensibilidad"

        private DataSet Sensibilities(
                                       DataSet sensibilitiesData,
                                       DateTime valuatorDate,
                                       DateTime yieldDate,
                                       DateTime exchangeRateDate
                                     )
        {

            #region "Definición de Variables"

            int _Row;
            DataRow _NewRow;
            DataRow _DataRow;
            string _YieldName;

            int _CurrencyPrincipal;
            int _CurrencySecondary;
            int _Point;
            int _ProductType;
            string _YieldPrincipal;
            string _YieldSecondary;
            double _MarkToMarket;

            DataTable _SensibilitiesOperation;
            DataTable _SensibilitiesOperationByYield;
            DataTable _SensibilitiesOperationByTerm;
            DataTable _SensibilitiesByYield;
            DataTable _PortFolioToday;

            DataRow _CurrentOperationByTerm;

            #endregion

            #region "Inicialización de Variables"

            _SensibilitiesOperation = new DataTable();
            _SensibilitiesOperationByYield = new DataTable();
            _SensibilitiesOperationByTerm = new DataTable();
            _SensibilitiesByYield = new DataTable();
            _PortFolioToday = new DataTable();
            
            _CurrencyPrincipal = 0;
            _CurrencySecondary = 0;
            _YieldPrincipal = "";
            _YieldSecondary = "";

            #endregion

            #region "Seteo de Tablas"

            _PortFolioToday = sensibilitiesData.Tables["PortFolio"];
            _SensibilitiesOperation = sensibilitiesData.Tables[cSensibilitiesOperationData];
            _SensibilitiesOperationByYield = sensibilitiesData.Tables[cSensibilitiesOperationByYield];
            _SensibilitiesOperationByTerm = sensibilitiesData.Tables[cSensibilitiesOperationByTerm];
            _SensibilitiesByYield = sensibilitiesData.Tables[cSensibilitiesByYield];

            #endregion

            #region "Generación de Curvas"

            int _YieldID = 0;
            ArrayList _YieldPointList = new ArrayList();
            YieldValue _YieldValue = new YieldValue();

            for (_YieldID = 0; _YieldID < mYieldArray.Count; _YieldID++)
            {

                _YieldName = (String)mYieldArray[_YieldID];
                _YieldValue = mYieldList.Read(_YieldName, enumSource.System, yieldDate);
                _YieldPointList = new ArrayList();

                for (_Point = 0; _Point < _YieldValue.Count; _Point++)
                {
                    _NewRow = _SensibilitiesByYield.NewRow();

                    _NewRow["YieldName"] = _YieldName;
                    _NewRow["ID"] = _Point;
                    _NewRow["Term"] = _YieldValue.Point(_Point).Term;
                    _NewRow["Sensibilities"] = 0;
                    _NewRow["DeltaRate"] = _YieldValue.Point(_Point).Rate - mYieldList.Read(_YieldName, enumSource.System, mYieldDateRateYesterday).Point(_Point).Rate;
                    _NewRow["Estimation"] = 0;

                    _SensibilitiesByYield.Rows.Add(_NewRow);

                }

            }

            #endregion

            #region "Cambia el tipo de tasa que se aplicará en la curva"

            for (_Row = 0; _Row < mYieldList.Count; _Row++)
            {
                _YieldName = (String)mYieldArray[_Row];
                if (_YieldName.Equals("CURVASWAPUF") || _YieldName.Equals("CURVASWAPUSDLOCAL") || _YieldName.Equals("CURVASWAPCLP"))
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateBasis;
                }
                else
                {
                    mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = enumRate.RateOriginalSpread;
                }
            }

            #endregion

            #region "Proceso Sensibilización y Estimación"

            for (_Row = 0; _Row < _PortFolioToday.Rows.Count; _Row++)
            {

                _DataRow = _PortFolioToday.Rows[_Row];

                _CurrencyPrincipal = int.Parse(_DataRow["PrimaryCurrency"].ToString());
                _CurrencySecondary = int.Parse(_DataRow["SecondaryCurrency"].ToString());
                _MarkToMarket = double.Parse(_DataRow["ValuatorFairValueNet"].ToString());
                _ProductType = int.Parse(_DataRow["ProductType"].ToString());

                if (_ProductType.Equals(10))
                {
                    _YieldPrincipal = GetYield(_CurrencyPrincipal);
                    _YieldSecondary = GetYield(_CurrencySecondary);
                }
                else
                {
                    _YieldPrincipal = GetYield(_CurrencyPrincipal, _CurrencySecondary);
                    _YieldSecondary = GetYield(_CurrencySecondary, _CurrencyPrincipal);
                }

                #region "Valoriza el Contrato a Mark to Market"

                if (!_ProductType.Equals(2))
                {

                    #region "Sensibilidad por Curva Activo"

                    Sensibilities(_Row, sensibilitiesData, valuatorDate, yieldDate, exchangeRateDate, _YieldPrincipal, 1);

                    #endregion

                    if (!_ProductType.Equals(10))
                    {
                        #region "Sensibilidad por Curva Pasivo"

                        _DataRow["ValuatorFairValueNet"] = _MarkToMarket;

                        Sensibilities(_Row, sensibilitiesData, valuatorDate, yieldDate, exchangeRateDate, _YieldSecondary, 2);

                        #endregion
                    }

                    #region "Valor Mercado"

                    mMarkToMarketValue += double.Parse(_DataRow["ValuatorFairValueNet"].ToString());

                    #endregion

                }

                #endregion

            }

            #endregion

            #region "Genera Datos"

            for (_Row = 0; _Row < _SensibilitiesOperationByTerm.Rows.Count; _Row++)
            {
                _CurrentOperationByTerm = _SensibilitiesOperationByTerm.Rows[_Row];

                AddSensibilitiesOperationYield(_CurrentOperationByTerm, sensibilitiesData.Tables[cSensibilitiesOperationByYield]);
                AddSensibilitiesYield(_CurrentOperationByTerm, sensibilitiesData.Tables[cSensibilitiesByYield]);
                AddSensibilitiesOperation(_CurrentOperationByTerm, sensibilitiesData.Tables[cSensibilitiesOperationData]);

            }

            #endregion

            return sensibilitiesData;

        }

        private DataSet Sensibilities(
                                       int row,
                                       DataSet sensibilitiesData,
                                       DateTime valuatorDate,
                                       DateTime yieldDate,
                                       DateTime exchangeRateDate,
                                       string yieldName,
                                       int leg
                                     )
        {

            #region "Definicion de Variables"

            DateTime _Date;

            cFinancialTools.DayCounters.Basis _Basis;

            int _Term;
            int _Point;
            int _PointInit;
            int _PointEnd;
            int _OperationNumber;
            int _ProductType;
            int _CurrencyPrincipal;
            int _CurrencySecondary;
            int _IssueBasisCode;
            int _MNemonicsCode;
            int _IssueCurrency;
            int _MNemonicsTerm;

            double _RateMarkToMarketToday;
            double _RateMarkToMarketYesterday;
            double _ValuatorMarkToMarket;
            double _ValuatorSensibilities;
            double _ValueSensibilities;
            double _DeltaSensibilidad;
            double _ValueEstimation;
            double _ExchangeRate;
            double _RateBenchMarkToday;
            double _RateBenchMarkYesterday;

            ArrayList _FindTermStarting;
            ArrayList _FindTermExpiry;

            DataTable _SensibilitiesByYield;
            DataTable _SensibilitiesOperationByTerm;
            DataTable _PortFolioToday;
            DataTable _PortFolioFlowToday;
            DataTable _PortFolioOriginal;
            DataTable _RateBenchMark;
            DataTable _IndexValueForwardFixingRate;

            DataRow _CurrentOperationByTerm;
            DataRow _DataRow;
            DataRow _DataRowOperation;
            DataRow[] _DataRows;

            DateTime _ExpiryContract;
            DateTime _ExpiryDate;
            DateTime _IssueDate;

            cFinancialTools.Yield.Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue;
            YieldPoint _YieldPoint;
            
            string _Key;
            string _MNemonicsMask;

            enumBasis _IssueBasis;

            cFinancialTools.Instruments.MNemonics _MNemonics = new MNemonics();

            #endregion

            #region "Inicialización de Variables"

            _FindTermStarting = new ArrayList();
            _FindTermExpiry = new ArrayList();
            
            _Yield = new cFinancialTools.Yield.Yield();
            _YieldSource = new YieldSource();
            _YieldValue = new YieldValue();
            _YieldPoint = new YieldPoint();

            _SensibilitiesByYield = new DataTable();
            _SensibilitiesOperationByTerm = new DataTable();
            _PortFolioToday = new DataTable();
            _PortFolioFlowToday = new DataTable();
            _PortFolioOriginal = new DataTable();
            _RateBenchMark = new DataTable();
            _IndexValueForwardFixingRate = new DataTable();

            #endregion

            #region "Seteo de Tablas"

            _SensibilitiesByYield = sensibilitiesData.Tables[cSensibilitiesByYield];
            _SensibilitiesOperationByTerm = sensibilitiesData.Tables[cSensibilitiesOperationByTerm];
            _PortFolioToday = sensibilitiesData.Tables["PortFolio"];
            _PortFolioFlowToday = sensibilitiesData.Tables["PortFolioFlow"];
            _PortFolioOriginal = CopyTable("PortFolioOriginal", _PortFolioToday);
            _RateBenchMark = sensibilitiesData.Tables["RateBenchMarck"];
            _IndexValueForwardFixingRate = sensibilitiesData.Tables["IndexValueForwardFixingRate"];

            _DataRow = _PortFolioToday.Rows[row];
            _DataRowOperation = _PortFolioOriginal.Rows[row];

            #endregion

            #region "Seteo de Curva"

            _Yield = mYieldList.Read(yieldName);

            #endregion

            #region "Actualiza valores para la operación por plazo"

            _OperationNumber = int.Parse(_DataRowOperation["OperationNumber"].ToString());
            _ProductType = int.Parse(_DataRowOperation["ProductType"].ToString());
            _ValuatorMarkToMarket = double.Parse(_DataRowOperation["ValuatorFairValueNet"].ToString());
            _ExchangeRate = double.Parse(_DataRowOperation["ExchangeRate"].ToString());
            _CurrencyPrincipal = int.Parse(_DataRow["PrimaryCurrency"].ToString());
            _CurrencySecondary = int.Parse(_DataRow["SecondaryCurrency"].ToString());
            _MNemonicsMask = _DataRow["MNemonicsMask"].ToString();
            _ExpiryContract = DateTime.Parse(_DataRow["ExpiryDate"].ToString());

            _MNemonics = mMnemonicsList.Read(_MNemonicsMask);

            if (_ProductType.Equals(10))
            {
                _DataRow = MarkToMarketProductValuator(
                                                        _ProductType,
                                                        _DataRow,
                                                        _PortFolioFlowToday,
                                                        _RateBenchMark,
                                                        _IndexValueForwardFixingRate,
                                                        valuatorDate,
                                                        yieldDate,
                                                        exchangeRateDate
                                                      );

                _ValuatorMarkToMarket = double.Parse(_DataRow["ValuatorFairValueNet"].ToString());
            }

            #endregion

            #region "Buscar Plazo de la Fecha Efectiva o Fecha Vencimiento"

            if (mCalculateDate == enumCalculateDate.EffectiveDate)
            {
                _Date = DateTime.Parse(_DataRowOperation["EffectiveDate"].ToString());
            }
            else
            {
                _Date = DateTime.Parse(_DataRowOperation["ExpiryDate"].ToString());
            }

            _Basis = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, valuatorDate, _Date);
            _Term = (int)_Basis.Term;

            _FindTermStarting = FindTerm(yieldName, _Term, _SensibilitiesByYield);

            #endregion

            #region "Recupera Tasas de Mercado"

            _ExpiryDate = mMnemonicsList.Read(_MNemonicsMask).ExpiryDate;
            _IssueDate = mMnemonicsList.Read(_MNemonicsMask).StartingDate;
            _IssueBasisCode = mMnemonicsList.Read(_MNemonicsMask).IssueBasis;
            _MNemonicsCode = mMnemonicsList.Read(_MNemonicsMask).MnemonicsID;
            _IssueCurrency = mMnemonicsList.Read(_MNemonicsMask).IssueCurrency;

            switch (_IssueBasisCode)
            {
                case 30:
                    _IssueBasis = enumBasis.Basis_Act_30;
                    break;

                case 360:
                    _IssueBasis = enumBasis.Basis_Act_360;
                    break;

                case 365:
                    _IssueBasis = enumBasis.Basis_Act_365;
                    break;

                default:
                    _IssueBasis = enumBasis.Basis_Act_360;
                    break;
            }

            _Basis = new cFinancialTools.DayCounters.Basis(_IssueBasis, valuatorDate, _ExpiryDate);
            _MNemonicsTerm = (int)Math.Floor(_Basis.TermBasis);

            _Key = "";
            _Key += "Date = '" + mYieldDateRateToday.ToString("dd-MM-yyyy") + "' AND ";
            _Key += "MnemonicsCode = " + _MNemonicsCode.ToString() + " AND ";
            _Key += "Currency = " + _IssueCurrency.ToString() + " AND ";
            _Key += "TermFrom <= " + _MNemonicsTerm.ToString() + " AND ";
            _Key += "TermUntil >= " + _MNemonicsTerm.ToString();
            _DataRows = _RateBenchMark.Select(_Key);
            _RateBenchMarkToday = 0;

            if (!(_DataRows.Length.Equals(0)))
            {
                _RateBenchMarkToday = double.Parse(_DataRows[0]["Rate"].ToString());
            }

            _Key = "";
            _Key += "Date = '" + mYieldDateRateYesterday.ToString("dd-MM-yyyy") + "' AND ";
            _Key += "MnemonicsCode = " + _MNemonicsCode.ToString() + " AND ";
            _Key += "Currency = " + _IssueCurrency.ToString() + " AND ";
            _Key += "TermFrom <= " + _MNemonicsTerm.ToString() + " AND ";
            _Key += "TermUntil >= " + _MNemonicsTerm.ToString();
            _DataRows = _RateBenchMark.Select(_Key);
            _RateBenchMarkYesterday = 0;

            if (!(_DataRows.Length.Equals(0)))
            {
                _RateBenchMarkYesterday = double.Parse(_DataRows[0]["Rate"].ToString());
            }


            #endregion

            #region "Proceso Sensibilización y Estimación por Operacion"

            if (_ProductType.Equals(10))
            {
                _PointInit = 0;
                _PointEnd = mYieldList.Read(yieldName, enumSource.System, yieldDate).Count;

            }
            else
            {
                if (_ProductType.Equals(13))
                {
                    _PointInit = 0;
                }
                else
                {
                    _PointInit = (int)_FindTermStarting[0];
                }

                _PointEnd = (int)_FindTermStarting[1];

            }

            for (_Point = 0; _Point < mYieldList.Read(yieldName, enumSource.System, yieldDate).Count; _Point++)
            {

                #region "Inicializa Variables"

                _Yield = new cFinancialTools.Yield.Yield();
                _YieldSource = new YieldSource();
                _YieldValue = new YieldValue();
                _YieldPoint = new YieldPoint();

                #endregion

                #region "Setea Variables"

                _Yield = mYieldList.Read(yieldName);
                _YieldSource = _Yield.Read(enumSource.System);
                _YieldValue = _YieldSource.Read(yieldDate);
                _YieldPoint = _YieldValue.Point(_Point);
                _Term = _YieldPoint.Term;
                _ValueSensibilities = 0;

                #endregion

                #region "Suma 1bps al plazo"

                _YieldPoint.Spread = 0.01;

                #endregion

                #region "Rescata Valores de Tasa Mercado para el calculo de la estimación"

                if (_ProductType.Equals(10))
                {
                    _RateMarkToMarketToday = _RateBenchMarkToday;
                    _RateMarkToMarketYesterday = _RateBenchMarkYesterday;
                }
                else
                {
                    _RateMarkToMarketToday = _Yield.Read(enumSource.System).Read(mYieldDateRateToday).Point(_Point).Rate;
                    _RateMarkToMarketYesterday = _Yield.Read(enumSource.System).Read(mYieldDateRateYesterday).Read(_Term).Rate;
                }

                #endregion

                #region "Valoriza el contrato"

                _DeltaSensibilidad = (_RateMarkToMarketToday - _RateMarkToMarketYesterday) * 100.0;

                if ((_Point >= _PointInit) && (_Point <= _PointEnd))
                {
                    _DataRow = MarkToMarketProductValuator( 
                                                            _ProductType,
                                                            _DataRow,
                                                            _PortFolioFlowToday,
                                                            _RateBenchMark,
                                                            _IndexValueForwardFixingRate,
                                                            valuatorDate,
                                                            yieldDate,
                                                            exchangeRateDate
                                                          );

                    _ValuatorSensibilities = double.Parse(_DataRow["ValuatorFairValueNet"].ToString());
                    _ValueSensibilities = _ValuatorSensibilities - _ValuatorMarkToMarket;
                    _ValueEstimation = _ValueSensibilities * _DeltaSensibilidad;

                }
                else
                {

                    _ValuatorSensibilities = 0;
                    _ValueSensibilities = 0;
                    _ValueEstimation = 0;

                }

                #endregion

                #region "Quita el 1bps al plazo"

                _YieldPoint.Spread = 0.0;

                #endregion

                #region "Grabar Vector Curva v/s Punto"

                _CurrentOperationByTerm = _SensibilitiesOperationByTerm.NewRow();

                _CurrentOperationByTerm["OperationNumber"] = _OperationNumber;
                _CurrentOperationByTerm["Leg"] = leg;
                _CurrentOperationByTerm["YieldName"] = yieldName;
                _CurrentOperationByTerm["Term"] = _Term;
                _CurrentOperationByTerm["MarkToMarketValue"] = _ValuatorMarkToMarket;
                _CurrentOperationByTerm["SensibilitiesValue"] = _ValuatorSensibilities;
                _CurrentOperationByTerm["Sensibilities"] = _ValueSensibilities;
                _CurrentOperationByTerm["DeltaRate"] = _DeltaSensibilidad;
                _CurrentOperationByTerm["Estimation"] = _ValueEstimation;

                _SensibilitiesOperationByTerm.Rows.Add(_CurrentOperationByTerm);

                #endregion

            }

            #endregion

            return sensibilitiesData;

        }

        private void AddSensibilitiesYield(DataRow dataRow, DataTable sensibilitiesYield)
        {

            DataRow[] _DataRowArray;
            DataRow _DataRow;

            string _YieldName;
            int _Term;
            double _Sensibilities;
            double _Estimation;

            double _SaveSensibilities;
            double _SaveDeltaRate;
            double _SaveEstimation;

            string _Filter;

            _YieldName = dataRow["YieldName"].ToString();
            _Term = int.Parse(dataRow["Term"].ToString());
            _Sensibilities = double.Parse(dataRow["Sensibilities"].ToString());
            _Estimation = double.Parse(dataRow["Estimation"].ToString());

            _Filter = "YieldName = '" + _YieldName + "' AND Term = " + _Term.ToString();
            _DataRowArray = sensibilitiesYield.Select(_Filter);

            if (_DataRowArray.Length.Equals(0))
            {
                _DataRow = sensibilitiesYield.NewRow();
            }
            else
            {
                _DataRow = _DataRowArray[0];
            }

            _SaveSensibilities = double.Parse(_DataRow["Sensibilities"].ToString()) + _Sensibilities;
            _SaveDeltaRate = 0;
            _SaveEstimation = double.Parse(_DataRow["Estimation"].ToString()) + _Estimation;

            if (!_SaveEstimation.Equals(0))
            {
                _SaveDeltaRate = _SaveSensibilities / _SaveEstimation;
            }

            _DataRow["YieldName"] = _YieldName;
            _DataRow["Term"] = _Term;
            _DataRow["Sensibilities"] = _SaveSensibilities;
            _DataRow["DeltaRate"] = _SaveDeltaRate;
            _DataRow["Estimation"] = _SaveEstimation;

            if (_DataRowArray.Length.Equals(0))
            {
                sensibilitiesYield.Rows.Add(_DataRow);
            }

        }

        private void AddSensibilitiesOperationYield(DataRow dataRow, DataTable sensibilitiesOperationYield)
        {

            DataRow[] _DataRowArray;
            DataRow _DataRow;

            double _OperationNumber;
            double _Leg;
            string _YieldName;
            double _MarktoMarketValue;
            double _SensibilitiesValue;
            double _Sensibilities;
            double _DeltaRate;
            double _Estimation;

            double _SaveMarktoMarketValue;
            double _SaveSensibilitiesValue;
            double _SaveSensibilities;
            double _SaveDeltaRate;
            double _SaveEstimation;

            string _Filter;

            _OperationNumber = int.Parse(dataRow["OperationNumber"].ToString());
            _Leg = int.Parse(dataRow["Leg"].ToString());
            _YieldName = dataRow["YieldName"].ToString();
            _MarktoMarketValue = double.Parse(dataRow["MarktoMarketValue"].ToString());
            _SensibilitiesValue = double.Parse(dataRow["SensibilitiesValue"].ToString());
            _Sensibilities = double.Parse(dataRow["Sensibilities"].ToString());
            _DeltaRate = double.Parse(dataRow["DeltaRate"].ToString());
            _Estimation = double.Parse(dataRow["Estimation"].ToString());

            _Filter = "OperationNumber = " + _OperationNumber.ToString() + " AND Leg = " + _Leg.ToString() + " AND YieldName = '" + _YieldName + "'";
            _DataRowArray = sensibilitiesOperationYield.Select(_Filter);

            if (_DataRowArray.Length.Equals(0))
            {
                _DataRow = sensibilitiesOperationYield.NewRow();
            }
            else
            {
                _DataRow = _DataRowArray[0];
            }

            _SaveMarktoMarketValue = _MarktoMarketValue;
            _SaveSensibilities = double.Parse(_DataRow["Sensibilities"].ToString()) + _Sensibilities;
            _SaveDeltaRate = 0;
            _SaveSensibilitiesValue = _SaveMarktoMarketValue + _SaveSensibilities;
            _SaveEstimation = double.Parse(_DataRow["Estimation"].ToString()) + _Estimation;

            if (!_SaveEstimation.Equals(0))
            {
                _SaveDeltaRate = _SaveSensibilities / _SaveEstimation;
            }

            _DataRow["OperationNumber"] = _OperationNumber;
            _DataRow["Leg"] = _Leg;
            _DataRow["YieldName"] = _YieldName;
            _DataRow["MarktoMarketValue"] = _SaveMarktoMarketValue;
            _DataRow["SensibilitiesValue"] = _SaveSensibilitiesValue;
            _DataRow["Sensibilities"] = _SaveSensibilities;
            _DataRow["DeltaRate"] = _SaveDeltaRate;
            _DataRow["Estimation"] = _SaveSensibilitiesValue;

            if (_DataRowArray.Length.Equals(0))
            {
                sensibilitiesOperationYield.Rows.Add(_DataRow);
            }

        }

        private void AddSensibilitiesOperation(DataRow dataRow, DataTable sensibilitiesOperation)
        {

            DataRow[] _DataRowArray;
            DataRow _DataRow;

            double _OperationNumber;
            double _Leg;
            int _IssueCurrency;
            double _MarktoMarketValue;
            double _SensibilitiesValue;
            double _Sensibilities;
            double _DeltaRate;
            double _Estimation;

            double _SaveMarktoMarketValue;
            double _SaveSensibilitiesValue;
            double _SaveSensibilities;
            double _SaveDeltaRate;
            double _SaveEstimation;

            string _Filter;

            _OperationNumber = int.Parse(dataRow["OperationNumber"].ToString());
            _Leg = int.Parse(dataRow["Leg"].ToString());
            _IssueCurrency = 0;
            _MarktoMarketValue = double.Parse(dataRow["MarktoMarketValue"].ToString());
            _SensibilitiesValue = double.Parse(dataRow["SensibilitiesValue"].ToString());
            _Sensibilities = double.Parse(dataRow["Sensibilities"].ToString());
            _DeltaRate = double.Parse(dataRow["DeltaRate"].ToString());
            _Estimation = double.Parse(dataRow["Estimation"].ToString());

            _Filter = "OperationNumber = " + _OperationNumber.ToString() + " AND Leg = " + _Leg.ToString();
            _DataRowArray = sensibilitiesOperation.Select(_Filter);

            if (_DataRowArray.Length.Equals(0))
            {
                _DataRow = sensibilitiesOperation.NewRow();
            }
            else
            {
                _DataRow = _DataRowArray[0];
            }

            _SaveMarktoMarketValue = _MarktoMarketValue;
            _SaveSensibilities = double.Parse(_DataRow["Sensibilities"].ToString()) + _Sensibilities;
            _SaveDeltaRate = 0;
            _SaveSensibilitiesValue = _SaveMarktoMarketValue + _SaveSensibilities;
            _SaveEstimation = double.Parse(_DataRow["Estimation"].ToString()) + _Estimation;

            if (!_SaveEstimation.Equals(0))
            {
                _SaveDeltaRate = _SaveSensibilities / _SaveEstimation;
            }

            _DataRow["OperationNumber"] = _OperationNumber;
            _DataRow["Leg"] = _Leg;
            _DataRow["IssueCurrency"] = _IssueCurrency;
            _DataRow["MarktoMarketValue"] = _SaveMarktoMarketValue;
            _DataRow["SensibilitiesValue"] = _SaveSensibilitiesValue;
            _DataRow["Sensibilities"] = _SaveSensibilities;
            _DataRow["DeltaRate"] = _SaveDeltaRate;
            _DataRow["Estimation"] = _SaveSensibilitiesValue;

            if (_DataRowArray.Length.Equals(0))
            {
                sensibilitiesOperation.Rows.Add(_DataRow);
            }

        }

        #endregion

        #endregion

        #region "Carga Tasas BenchMark"

        private DataTable LoadBenchMarck(DateTime portFolioToday, DateTime portFolioYesterday)
        {

            cData.Rate.BenchMarck _BenchMarkRate;
            DataTable _IndexValueForwardFixingRate;

            _BenchMarkRate = new cData.Rate.BenchMarck();
            _IndexValueForwardFixingRate = new DataTable();

            _IndexValueForwardFixingRate = _BenchMarkRate.LoadValue(portFolioYesterday, portFolioToday);

            return _IndexValueForwardFixingRate;

        }

        #endregion

        #region "Agrega campos necesarios para la valorización en la tabla de Cartera"

        private DataTable AddColumnPortFolio(DataTable _PortFolioData)
        {

            #region "Def Variable"

            DataColumn _DataColumn;

            #endregion

            #region "Valor Razonable Activo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueAsset";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Activo";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Razonable Activo UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueAssetUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Activo UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Razonable Pasivo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueLiabilities";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Pasivo";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Razonable Pasivo UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueLiabilitiesUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Pasivo UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Razonable Neto"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueNet";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Neto";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Razonable Neto UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueNetUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Neto";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Razonable Neto Costo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorFairValueNetCost";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Razonable Neto Costo";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Plazo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorTerm";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Plazo";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Tasa Moneda Principal"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorPrimaryCurrencyRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Convexidad";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Tasa Moneda Secundaria"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorSecondaryCurrencyRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Moneda Secundaria";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Tasa Forward Teorica"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorForwardPriceTheory";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Forward Teorica";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Duracion Macaulay"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MacaulayDuration";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Duration Macaulay";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Duracion Modificado"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ModifiedDuration";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Duration Modified";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Convexidad"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Convexity";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Convexity";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Precio Forward Theorico"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PriceForwardTheory";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Convexidad";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Tasa Forward Theorica"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "RateForwardTheory";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Convexidad";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Cash Flow"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CashFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Flujo Caja";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Result Distribution"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ResultDistribution";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Resultado Distribución";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Transfer Distribution"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "TransferDistribution";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Transferencia Distribución";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Mark to Market Effect Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarktoMarketEfectRate"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Efecto de tasa acumulativa";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Mark to Market Rate Adjusment"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarktoMarketRateAdjustment"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Efecto de tasa acumulativa";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "PointForward"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PointForward"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Puntos Forward";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "RateUSD"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "RateUSD"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa USD";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "RateCLP"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "RateCLP"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa CLP";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "TAB30Days"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "TAB30Days"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa TAB 30 dias";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "CarryRateUSD"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CarryRateUSD"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Carry en USD";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "CarryCostValue"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CarryCostValue"; //marktomarketeffectrate
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Carry en USD";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            return _PortFolioData;

        }

        #endregion

        #region "Agregar tabla al DataSet"

        private void AddTableDataSet(string tableName, DataTable _Table)
        {

            if (mPortFolioDataSet.Tables.Contains(tableName))
            {
                mPortFolioDataSet.Tables.Remove(tableName);
            }

            mPortFolioDataSet.Merge(_Table);

        }

        #endregion

        #region "Metodo para la Definición de Estructuras de Tablas para la Sensibilización"

        private DataSet SensibilitiesTables()
        {

            DataSet _Sendibilities = new DataSet();

            _Sendibilities.Tables.Add(OperationSensibilities());
            _Sendibilities.Tables.Add(OperationYieldSensibilities());
            _Sendibilities.Tables.Add(OperationTermSensibilities());
            _Sendibilities.Tables.Add(YieldSensibilities());

            return _Sendibilities;

        }

        protected DataTable OperationSensibilities()
        {

            #region "Def Variable"

            DataTable _DataTable;
            DataColumn _DataColumn;
            DataColumn[] _DataColumnConstraints;

            #endregion

            #region "Init Variable"

            _DataTable = new DataTable();
            _DataColumnConstraints = new DataColumn[2];

            #endregion

            #region "Operation Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[0] = _DataColumn;

            #endregion

            #region "Leg"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Leg";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Pierna";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Issue Currency"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "IssueCurrency";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "Moneda Emisión";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Mark To Market Valuator"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarktoMarketValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Sensibilities Valuator"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SensibilitiesValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Sensibilities"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Sensibilities";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Delta Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DeltaRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Diferencia Tasa";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Estimation"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Estimation";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Estimación";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Add Constraint"

            _DataTable.Constraints.Add("PK_OperationSensibilities", _DataColumnConstraints, true);

            #endregion

            #region "Setting Table Name"

            _DataTable.TableName = cSensibilitiesOperationData;

            #endregion

            return _DataTable;

        }

        protected DataTable OperationYieldSensibilities()
        {

            #region "Def Variable"

            DataTable _DataTable;
            DataColumn _DataColumn;
            DataColumn[] _DataColumnConstraints;

            #endregion

            #region "Init Variable"

            _DataTable = new DataTable();
            _DataColumnConstraints = new DataColumn[3];

            #endregion

            #region "Operation Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[0] = _DataColumn;

            #endregion

            #region "Leg"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Leg";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Pierna";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Yield Name"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "YieldName";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Nombre Curva";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[2] = _DataColumn;

            #endregion

            #region "Mark To Market Valuator"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarktoMarketValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Sensibilities Valuator"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SensibilitiesValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Sensibilities"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Sensibilities";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Delta Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DeltaRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Diferencia Tasa";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Estimation"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Estimation";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Estimación";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Add Constraint"

            _DataTable.Constraints.Add("PK_OperationYieldSensibilities", _DataColumnConstraints, true);

            #endregion

            #region "Setting Table Name"

            _DataTable.TableName = cSensibilitiesOperationByYield;

            #endregion

            return _DataTable;

        }

        protected DataTable OperationTermSensibilities()
        {

            #region "Def Variable"

            DataTable _DataTable;
            DataColumn _DataColumn;
            DataColumn[] _DataColumnConstraints;

            #endregion

            #region "Init Variable"

            _DataTable = new DataTable();
            _DataColumnConstraints = new DataColumn[4];

            #endregion

            #region "Operation Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[0] = _DataColumn;

            #endregion

            #region "Leg"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Leg";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Pierna";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Yield Name"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "YieldName";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Nombre Curva";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[2] = _DataColumn;

            #endregion

            #region "Term"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Term";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "Plazo";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[3] = _DataColumn;

            #endregion

            #region "Mark To Market Valuator"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarktoMarketValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Sensibilities Valuator"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SensibilitiesValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Sensibilities"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Sensibilities";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Delta Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DeltaRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Diferencia Tasa";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Estimation"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Estimation";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Estimación";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Add Constraint"

            _DataTable.Constraints.Add("PK_OperationTermSensibilities", _DataColumnConstraints, true);

            #endregion

            #region "Setting Table Name"

            _DataTable.TableName = cSensibilitiesOperationByTerm;

            #endregion

            return _DataTable;

        }

        protected DataTable YieldSensibilities()
        {

            #region "Def Variable"

            DataTable _DataTable;
            DataColumn _DataColumn;
            DataColumn[] _DataColumnConstraints;

            #endregion

            #region "Init Variable"

            _DataTable = new DataTable();
            _DataColumnConstraints = new DataColumn[2];

            #endregion

            #region "Yield Name"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "YieldName";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Nombre Curva";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[0] = _DataColumn;

            #endregion

            #region "Term"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Term";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "Plazo";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "ID"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ID";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "ID";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Sensibilities"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Sensibilities";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Sensibilidad";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Delta Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DeltaRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Diferencia Tasa";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Estimation"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Estimation";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Estimación";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Add Constraint"

            _DataTable.Constraints.Add("PK_YieldSensibilities", _DataColumnConstraints, true);

            #endregion

            #region "Setting Table Name"

            _DataTable.TableName = cSensibilitiesByYield;

            #endregion

            return _DataTable;

        }

        #endregion

        #region "Copiar Estructuras"

        private DataTable CopyTable(string nameTable, DataTable _Table)
        {

            int _Row;
            int _Column;
            DataRow _DataRow;
            DataRow _NewRow;
            DataTable _TableNew;

            _TableNew = new DataTable();

            _TableNew = _Table.Clone();
            _TableNew.TableName = nameTable;

            for (_Row = 0; _Row < _Table.Rows.Count; _Row++)
            {
                _DataRow = _Table.Rows[_Row];
                _NewRow = _TableNew.NewRow();

                for (_Column = 0; _Column < _Table.Columns.Count; _Column++)
                {
                    _NewRow[_Column] = _DataRow[_Column];
                }

                _TableNew.Rows.Add(_NewRow);

            }

            return _TableNew;

        }

        #endregion

        #region "Metodos para la Carga de Datos básicos"

        private void SetYieldList()
        {

            mYieldArray.Add("CURVAFWCLP");
            mYieldArray.Add("CURVAFWUF");
            mYieldArray.Add("CURVAFWUSD");
            mYieldArray.Add("CURVASCUFUSD");
            mYieldArray.Add("CURVASWAPUF");
            mYieldArray.Add("CURVASWAPUSDLOCAL");
            mYieldArray.Add("CURVASWAPCLP");
        }

        private void LoadYield(DateTime dateYield)
        {

            int _Row;
            string _YieldName;

            for (_Row = 0; _Row < mYieldArray.Count; _Row++)
            {
                _YieldName = (string)mYieldArray[_Row];
                mYieldList.Load(_YieldName, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, dateYield);
                mYieldList.Read(_YieldName, enumSource.System, dateYield).RateBasis = 0;
            }

        }

        private void LoadCurrency(DateTime currencyDate)
        {
            mCurrencyList.Load(994, enumSource.CurrencyValueAccount, currencyDate, "CURVAFWUSD");
            mCurrencyList.Load(994, enumSource.System, currencyDate, "CURVAFWUSD");
            mCurrencyList.Load(998, enumSource.System, currencyDate, "CURVAFWUF");
            mCurrencyList.Load(999, enumSource.System, currencyDate, "CURVAFWCLP");
        }

        #endregion

        #region "Carga de la configuración de las curvas"

        private void LoadConfiguration()
        {
            
            //throw new Exception("The method or operation is not implemented.");

            // Por Implementar

        }

        private string GetYield(int currency)
        {

            string _Value = "";

            if (currency.Equals(998))
            {
                _Value = "CURVASWAPUF";

            }
            else if (currency.Equals(994))
            {
                _Value = "CURVASWAPUSDLOCAL";
            }
            else
            {
                _Value = "CURVASWAPCLP";
            }

            return _Value;

        }

        private string GetYield(int currencyPrincipal, int currencySecondary)
        {

            string _Value = "";

            if (currencyPrincipal.Equals(13))
            {
                _Value = "CURVAFWUSD";
            }
            else if (currencyPrincipal.Equals(998))
            {
                if (currencySecondary.Equals(13))
                {
                    _Value = "CURVASCUFUSD";
                }
                else
                {
                    _Value = "CURVAFWUF";
                }
            }
            else if (currencyPrincipal.Equals(999))
            {
                _Value = "CURVAFWCLP";
            }

            return _Value;

        }

        #endregion

        #region "Buscar Item"

        private ArrayList FindTerm(string yieldName, int term, DataTable sensibilitiesYield)
        {

            #region "Definición de Variables"

            DataRow[] _DataRows;
            string _Key;
            int _TermLength;
            ArrayList _ArrayList;

            #endregion

            #region "Inicialización de Variables"

            _ArrayList = new ArrayList();

            #endregion

            #region "Plazo < 1"

            if (term < 1)
            {

                _ArrayList.Add(1);
                _ArrayList.Add(1);

            }
            else
            {

                try
                {

                    #region "Busca el Plazo exacto"

                    _Key = "YieldName = '" + yieldName + "' AND Term = " + term.ToString();
                    _DataRows = sensibilitiesYield.Select(_Key);

                    #endregion

                    #region "Verifica el Resultado"

                    if (_DataRows.Length.Equals(1))
                    {

                        _ArrayList.Add(int.Parse(_DataRows[0]["ID"].ToString()));
                        _ArrayList.Add(int.Parse(_DataRows[0]["ID"].ToString()));

                    }
                    else
                    {

                        #region "Busca el plazo anterior"

                        _Key = "YieldName = '" + yieldName + "' AND Term < " + term.ToString();
                        _DataRows = sensibilitiesYield.Select(_Key);
                        _TermLength = _DataRows.Length - 1;

                        _ArrayList.Add(int.Parse(_DataRows[_TermLength]["ID"].ToString()));

                        #endregion

                        #region "Busca el plazo siguiente"

                        _Key = "YieldName = '" + yieldName + "' AND Term > " + term.ToString();
                        _DataRows = sensibilitiesYield.Select(_Key);

                        _ArrayList.Add(int.Parse(_DataRows[0]["ID"].ToString()));

                        #endregion

                    }

                    #endregion
                }
                catch
                {
                    _ArrayList = new ArrayList();
                    _ArrayList.Add(0);
                    _ArrayList.Add(0);
                }
            }

            #endregion

            return _ArrayList;

        }

        #endregion

        #region "Inicialización de Variables"

        private void Set()
        {

            mPortFolioDate = new DateTime();                                        // Fecha de Carga de la Cartera

            mPortFolioDateYesterday = new DateTime();                               // Fecha de la Cartera t(-1)
            mPortFolioDateToday = new DateTime();                                   // Fecha de la Cartera t(0)
            mPortFolioDateTomorrow = new DateTime();                                // Fecha de la Cartera t(1)
            mPortFolioEndofMonth = new DateTime();
            mPortFolioPreviousEndOfMonth = new DateTime();

            mYieldDateRateYesterday = new DateTime();                               // Fecha de la carga de las Tasa de Mercado en t(-1)
            mYieldDateRateToday = new DateTime();                                   // Fecha de la carga de las Tasa de Mercado en t(0)

            mCurrencyDateExchangeRateToday = new DateTime();                        // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyDateExchangeRateYesterday = new DateTime();                    // Fecha de la carga de los Tipos de Cambio en t(-1)

            mValuatorForward = enumValuatorForward.ValuatorForwardPriceTheory;      // Metodo de Valorización
            mCalculateDate = enumCalculateDate.EffectiveDate;                       // Fecha de Calculo

            mMnemonicsList = new MnemonicsList();
            mPortFolioDataSet = new DataSet();                                      // Tablas de la Cartera t(0) y t(1).
            mCurrencyList = new CurrencyList();                                     // Lista de Tipos de Cambios
            mYieldList = new YieldList();                                           // Lista de Curvas
            mRateList = new RateList();                                             // Lista de Tasas
            mYieldArray = new ArrayList();                                          // Arreglo de Curvas utilizadas en la valorización

            mPresenteValue = 0;                                                     // Valor Presente

            mMarkToMarketValue = 0;                                                 // Valor Mercado
            mMarkToMarketValueUM = 0;                                               // Valor Mercado en UM

            mMarkToMarketTodayBAC = 0;                                              // Valor Mercado en t(0) BAC
            mMarkToMarketTomorrowBAC = 0;                                           // Valor Mercado en t(1) BAC

            mMarkToMarketToday = 0;                                                 // Valor Mercado en t(0)
            mMarkToMarketTomorrow = 0;                                              // Valor Mercado en t(1)
            mMarkToMarketTimeDecay = 0;                                             // Valor Mercado en Cambio de Tiempo
            mMarkToMarketExchangeRate = 0;                                          // Valor Mercado en Tipo de Cambio
            
            mMarkToMarketTodayUM = 0;                                               // Valor Mercado en t(0) en UM
            mMarkToMarketTomorrowUM = 0;                                            // Valor Mercado en t(1) en UM
            mMarkToMarketTimeDecayUM = 0;                                           // Valor Mercado en Cambio de Tiempo en UM
            mMarkToMarketExchangeRateUM = 0;                                        // Valor Mercado en Tipo de Cambio en UM

            mBalanceReal = 0;                                                       // Valor real
            mSensibilitiesValue = 0;                                                // Valor de la Sensibilización
            mEstimationValue = 0;                                                   // Valor de la Estimación
            mTimeDecayValue = 0;                                                    // Valor por Paso del Tiempo
            mCashFlowValue = 0;                                                     // Valor por Flujos de Caja
            mNewOperationValue = 0;                                                 // Valor por Operaciones Nuevas
            mEffectExchangeRateValue = 0;                                           // Valor por el Efecto de Tipo de Cambio
            mEffectRateValue = 0;                                                   // Valor por el Efecto de Tasa
            mValuatorFixingRate = enumValuatorFixingRate.MartToMarket;
            mCashFlow = 0;

            mUserID = 0;
            mPortFolio = new PortFolio();
            mPointForward = 0;
            mRateUSD = 0;
            mRateCLP = 0;
            mTAB30Days = 0;
            mCarryRateUSD = 0;

            mCalendar = new Calendars();
            mCalendar.Load();

        }

        #endregion

        #endregion

    }

}