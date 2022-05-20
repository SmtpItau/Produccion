using System;
using System.Collections;
using System.Text;
using System.Data;
using cFinancialTools.Instruments;
using cFinancialTools.Currency;
using cFinancialTools.Yield;
using cFinancialTools.BussineDate;
using cFinancialTools.Valuation;
using cFinancialTools.Struct;

namespace cFinancialTools.PortFolio
{

    public class PortFolioFixingRate
    {

        #region "Constantes"

        private const string cPortFolioToday = "PortFolioT0";
        private const string cPortFolioTomorrow = "PortFolioT1";
        private const string cSensibilitiesOperationData = "DatosOperacion";
        private const string cSensibilitiesOperationByYield = "OperacionesxCurva";
        private const string cSensibilitiesOperationByTerm = "OperacionesPorPlazo";
        private const string cSensibilitiesByYield = "SensibilidadxCurva";

        private const string cPortFolioTimeDecay = "PortFolioTimeDecay";
        private const string cPortFolioExchangeRate = "PortFolioExchangeRate";
        private const int cLettersOfCreditMortgageID = 20;
        private const int cIssueID = 97023000;

        #endregion

        #region "Atributos Privados"

        private DateTime mPortFolioDate;                        // Fecha de Carga de la Cartera

        private DateTime mPortFolioDateYesterday;               // Fecha de la Cartera t(-1)
        private DateTime mPortFolioDateToday;                   // Fecha de la Cartera t(0)
        private DateTime mPortFolioDateTomorrow;                // Fecha de la Cartera t(1)
        private DateTime mPortFolioEndofMonth;                  // Fecha de Fin de Mes
        private DateTime mPortFolioPreviousEndOfMonth;          // Fecha de Fin de Mes Previo

        private DateTime mMarkToMarketDateYesterday;            // Fecha de la Tasa Mercado t(-1)
        private DateTime mMarkToMarketDateToday;                // Fecha de la Tasa Mercado t(0)

        private DateTime mYieldDateRateYesterday;               // Fecha de la carga de las Tasa de Mercado en t(-1)
        private DateTime mYieldDateRateToday;                   // Fecha de la carga de las Tasa de Mercado en t(0)

        private DateTime mCurrencyDateExchangeRateYesterday;    // Fecha de la carga de los Tipos de Cambio en t(-1)
        private DateTime mCurrencyDateExchangeRateToday;        // Fecha de la carga de los Tipos de Cambio en t(0)

        private MnemonicsList mMnemonicsList;                   // Lista de Instrumentos Utilizados
        private DataSet mPortFolioDataSet;                      // Tablas de la Cartera t(0) y t(-1).
        private CurrencyList mCurrencyList;                     // Lista de Tipos de Cambios
        private YieldList mYieldList;                           // Lista de Curvas
        private ArrayList mYieldArray;                          // Arreglo de Curvas utilizadas en la valorización

        private double mPresenteValue;                          // Valor Presente
        private double mPresenteValueValuator;                  // Valor Presente del Valorizador

        private double mMarkToMarketValue;                      // Valor Mercado
        private double mMarkToMarketValueUM;                    // Valor Mercado en UM

        private double mMarkToMarketTodayBAC;                   // Valor Mercado en t(0) BAC
        private double mMarkToMarketYesterdayBAC;               // Valor Mercado en t(-1) BAC

        private double mMarkToMarketToday;                      // Valor Mercado en t(0)
        private double mMarkToMarketTomorrow;                   // Valor Mercado en t(-1)
        private double mMarkToMarketTimeDecay;                  // Valor Mercado en Cambio de Tiempo
        private double mMarkToMarketExchangeRate;               // Valor Mercado en Tipo de Cambio
        private double mMarkToMarketTodayUM;                    // Valor Mercado en t(0) en UM
        private double mMarkToMarketTomorrowUM;                 // Valor Mercado en t(-1) en UM
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
        private double mTPMRate;                                // Tasa Politica Monetaria

        private cFinancialTools.PortFolio.PortFolio mPortFolio;

        private int mUserID;

        private Calendars mCalendar;

        #endregion

        #region "Constructores"

        public PortFolioFixingRate()
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
                int _Month;

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

                // Fecha de la carga de las Tasa de Mercado en t(0)
                if (mPortFolioDateToday.Equals(mPortFolioEndofMonth))
                {
                    mYieldDateRateToday = mPortFolioDateYesterday;
                }
                else
                {
                    mYieldDateRateToday = mPortFolioDateToday;
                }

                // Fecha de la carga de las Tasa de Mercado en t(-1)
                mYieldDateRateYesterday = mPortFolioDateYesterday;

                // Fecha de la carga de los Tipos de Cambio en t(0)
                mCurrencyDateExchangeRateToday = mPortFolioDateToday;

                // Fecha de la carga de los Tipos de Cambio en t(-1)
                mCurrencyDateExchangeRateYesterday = mPortFolioDateYesterday;

                if (mPortFolioDateToday.Equals(mPortFolioEndofMonth))
                {
                    // Fecha Mercado Fin de Mes
                    mMarkToMarketDateToday = mPortFolioDateToday;

                    // Fecha de carga mercado 2 días habiles antes de la fecha de proceso
                    _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioDateYesterday);
                    mMarkToMarketDateYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

                }
                else
                {
                    // Valida que no exista un cambio de mes inhabil entre la fecha del día y el proximo día habil
                    _Month = mPortFolioDateTomorrow.Month - mPortFolioDateToday.Month;
                    if (_Month.Equals(1) && (!mPortFolioDateToday.Equals(mPortFolioEndofMonth)))
                    {
                        // Fecha de la carga de la Tasa de Mercado es fin de mes especial
                        mMarkToMarketDateToday = mPortFolioEndofMonth;
                    }
                    else
                    {
                        // Tasa de Mercado t(0)
                        mMarkToMarketDateToday = mPortFolioDateToday;
                    }

                    _Month = mPortFolioDateToday.Month - mPortFolioDateYesterday.Month;
                    if (_Month.Equals(1) && (!mPortFolioDateYesterday.Equals(mPortFolioEndofMonth)))
                    {
                        // Fecha de la carga de la Tasa de Mercado es fin de mes especial
                        mMarkToMarketDateYesterday = mPortFolioPreviousEndOfMonth;
                    }
                    else
                    {
                        // Tasa de Mercado t(1)
                        mMarkToMarketDateYesterday = mPortFolioDateYesterday;
                    }
                }

                #endregion

                #region "Inicialización de Valores para la Cartera"

                SetYieldList();
                LoadYield(mYieldDateRateYesterday);
                LoadYield(mYieldDateRateToday);
                LoadCurrency(mCurrencyDateExchangeRateYesterday);
                LoadCurrency(mCurrencyDateExchangeRateToday);

                #endregion

                #region "Valida que exista curva para la fecha de proceso"

                if (mYieldList.Read("CURVASWAPCLP", enumSource.System, mYieldDateRateToday).Count == 0)
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

        public double MarkToMarketYesterdayBAC
        {
            get
            {
                return mMarkToMarketYesterdayBAC;
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

        public double MarkToMarketT1UM
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

            // Fecha Mercado Hoy
            mMarkToMarketDateToday = portFolio.MarkToMarketToday;

            // Fecha Mercado Ayer
            mMarkToMarketDateYesterday = portFolio.MarkToMarketYesterday;

            mUserID = portFolio.UserID;
            mPortFolio = portFolio;

            #endregion

            #region "Inicialización de Valores para la Cartera"

            SetYieldList();
            LoadYield(mYieldDateRateYesterday);
            LoadYield(mYieldDateRateToday);
            LoadCurrency(mCurrencyDateExchangeRateYesterday);
            LoadCurrency(mCurrencyDateExchangeRateToday);

            #endregion

        }

        #endregion

        #region "Carga de Datos"

        public void Load()
        {

            DataTable _PortFolioToday;

            _PortFolioToday = new DataTable();
            mPortFolioDataSet = new DataSet();

            _PortFolioToday = Load(mPortFolioDateToday, mMarkToMarketDateToday, mMarkToMarketDateYesterday);
            _PortFolioToday.TableName = cPortFolioToday;

            LoadInstruments(_PortFolioToday);

            AddTableDataSet(cPortFolioToday, _PortFolioToday);

        }

        #endregion

        #region "Valorización"

        public void Valuator()
        {

            DataTable _PortFolioToday = new DataTable();

            _PortFolioToday = mPortFolioDataSet.Tables[cPortFolioToday];

            _PortFolioToday = Valuator(_PortFolioToday, mPortFolioDateToday, mPortFolioDateToday, mPortFolioDateToday);
            mPresenteValue = mPresenteValueValuator;

            AddTableDataSet(cPortFolioToday, _PortFolioToday);

        }

        #endregion

        #region "Mark To Market"

        public void MarkToMarket()
        {

            DataTable _PortFolioToday = new DataTable();

            _PortFolioToday = mPortFolioDataSet.Tables[cPortFolioToday];

            _PortFolioToday = MarkToMarket(
                                            enumFlagMartTOMarketFixingRate.RateToday,
                                            _PortFolioToday,
                                            mPortFolioDateToday,
                                            mYieldDateRateYesterday,
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

            _PortFolioToday = mPortFolioDataSet.Tables[cPortFolioToday];
            _PortFolioToday.TableName = "PortFolio";
            _SensibilitiesTables.Tables.Add(_PortFolioToday);

            _SensibilitiesTables = Sensibilities(
                                                  _SensibilitiesTables,
                                                  mPortFolioDateToday,
                                                  mYieldDateRateToday,
                                                  mCurrencyDateExchangeRateToday
                                                );

            AddTableDataSet(cSensibilitiesOperationData, _SensibilitiesTables.Tables[cSensibilitiesOperationData]);
            AddTableDataSet(cSensibilitiesOperationByTerm, _SensibilitiesTables.Tables[cSensibilitiesOperationByTerm]);
            AddTableDataSet(cSensibilitiesByYield, _SensibilitiesTables.Tables[cSensibilitiesByYield]);

        }

        #endregion

        #region "Estimación"

        public void Estimation()
        {

            #region "Definición de Variables"

            DataTable _PortFolioToday;
            DataTable _PortFolioTomorrow;
            DataTable _PortFolioEstimation;
            DataTable _PortFolioTimeDecay;
            DataTable _ExchangeRate;
            DataTable _EffectRate;
            DataTable _TPM;
            DataSet _Sensibilities;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioToday = new DataTable();
            _PortFolioTomorrow = new DataTable();
            _PortFolioTimeDecay = new DataTable();
            _ExchangeRate = new DataTable();
            _EffectRate = new DataTable();
            _TPM = new DataTable();

            if (mPortFolio.MarkToMarketToday.Equals(mPortFolio.EndofMonth))
            {
                mPortFolioDateYesterday = mPortFolio.MarkToMarketYesterday;
                mCurrencyDateExchangeRateYesterday = mPortFolio.MarkToMarketYesterday;
                LoadCurrency(mCurrencyDateExchangeRateYesterday);
            }

            #endregion

            #region "01.- Carga de Carteras"

            #region "Carga Cartera 1"

            _PortFolioToday = Load(mPortFolioDateToday, mMarkToMarketDateToday, mMarkToMarketDateYesterday);

            _PortFolioToday = CalculateDateBR(_PortFolioToday);

            _PortFolioToday = RemoveVcto(mPortFolioDateYesterday, _PortFolioToday);

            _PortFolioToday.TableName = cPortFolioToday;
            
            LoadInstruments(_PortFolioToday);

            SumMarkToMarketBAC(_PortFolioToday);

            #endregion

            #region "Asigna Cartera 1 a Time Decay y Cambio de T/C"

            _PortFolioTimeDecay = CopyTable("TimeDecay", _PortFolioToday);
            _ExchangeRate = CopyTable("ExchangeRate", _PortFolioToday);
            _EffectRate = CopyTable("EffectRate", _PortFolioToday);

            #endregion

            #region "Carga Cartera 2"

            //_PortFolioTomorrow = Load(mPortFolioDateYesterday, mMarkToMarketDateYesterday);
            _PortFolioTomorrow = CopyTable(cPortFolioTomorrow, _PortFolioToday);
            //_PortFolioTomorrow.TableName = cPortFolioTomorrow;
            //LoadInstruments(_PortFolioTomorrow);

            #endregion

            #region "Carga Valores UF"

            LoadUM(_PortFolioToday);

            #endregion

            #region "Valid IPC"

            ValidIPC(_PortFolioToday);

            #endregion

            #endregion

            #region "02.- Valorización y MTM de Cartera T(0)"

            #region "Valorización Cartera"

            _PortFolioToday = ValuatorPortFolio(_PortFolioToday);

            //_PortFolioToday = Valuator(_PortFolioToday, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);

            //mPresenteValue = mPresenteValueValuator;

            #endregion

            #region "Mark To Market"

            //_PortFolioToday = MarkToMarket(
            //                                enumFlagMartTOMarketFixingRate.RateToday,
            //                                _PortFolioToday, 
            //                                mPortFolioDateToday, 
            //                                mYieldDateRateToday, 
            //                                mCurrencyDateExchangeRateToday
            //                              );
            //mMarkToMarketToday = mMarkToMarketValue;
            //mMarkToMarketTodayUM = mMarkToMarketValueUM;

            #endregion

            #endregion

            #region "03.- Cajas"

            //mCashFlowValue = mCashFlow; // Falta agregar el tema de los cupones en los valorizadores"

            #endregion

            #region "04.- Valorización y MTM de Cartera T(-1)"

            #region "Valorización Cartera"

            //_PortFolioTomorrow = Valuator(_PortFolioTomorrow, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday);

            //mPresenteValue = mPresenteValueValuator;

            #endregion

            #region "Mark To Market"

            //_PortFolioTomorrow = MarkToMarket(enumFlagMartTOMarketFixingRate.RateTomorrow, _PortFolioTomorrow, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday); // mCurrencyDateExchangeRateYesterday
            //_PortFolioTomorrow = MarkToMarket(
            //                                   enumFlagMartTOMarketFixingRate.RateYesterday, 
            //                                   _PortFolioTomorrow,
            //                                   mPortFolioDateYesterday, 
            //                                   mYieldDateRateYesterday, 
            //                                   mCurrencyDateExchangeRateYesterday
            //                                 ); // mCurrencyDateExchangeRateYesterday
            //mMarkToMarketTomorrow = mMarkToMarketValue;
            //mMarkToMarketTomorrowUM = mMarkToMarketValueUM;

            #endregion

            #endregion

            #region "05.- Calculo del Valor Real"

            mBalanceReal = mMarkToMarketTomorrow - mMarkToMarketToday;

            #endregion

            #region "06.- Calculo del DV01 y Estimación"

            _PortFolioEstimation = CopyTable("PortFolio", _PortFolioToday);

            _Sensibilities = SensibilitiesTables();
            _Sensibilities.Merge(_PortFolioEstimation);

            _Sensibilities = Sensibilities(_Sensibilities, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);

            AddTableDataSet(cSensibilitiesOperationData, _Sensibilities.Tables[cSensibilitiesOperationData]);
            AddTableDataSet(cSensibilitiesOperationByTerm, _Sensibilities.Tables[cSensibilitiesOperationByTerm]);
            AddTableDataSet(cSensibilitiesByYield, _Sensibilities.Tables[cSensibilitiesByYield]);

            #endregion

            #region "07.- Time Decay"

            //_PortFolioTimeDecay = MarkToMarket(
            //                                    enumFlagMartTOMarketFixingRate.RateYesterday, 
            //                                    _PortFolioTimeDecay, 
            //                                    mPortFolioDateToday, 
            //                                    mYieldDateRateYesterday, 
            //                                    mCurrencyDateExchangeRateYesterday
            //                                  );
            //mMarkToMarketTimeDecay = mMarkToMarketValue;
            //mMarkToMarketTimeDecayUM = mMarkToMarketValueUM;
            //mTimeDecayValue = mMarkToMarketTimeDecay - mMarkToMarketToday;

            #endregion

            #region "08.- Operaciones Nuevas"

            mNewOperationValue = 0; 
            
            #endregion

            #region "09.- Efecto Cambio / Reajuste"

            //_ExchangeRate = MarkToMarket(
            //                              enumFlagMartTOMarketFixingRate.RateYesterday, 
            //                              _ExchangeRate, 
            //                              mPortFolioDateYesterday, 
            //                              mYieldDateRateYesterday,
            //                              mCurrencyDateExchangeRateToday
            //                            );
            //mEffectExchangeRateValue = mMarkToMarketToday - mMarkToMarketValue;

            #endregion

            #region "10.- Efecto Tasa"

            //_EffectRate = MarkToMarket(
            //                            enumFlagMartTOMarketFixingRate.RateToday, 
            //                            _EffectRate, 
            //                            mPortFolioDateYesterday, 
            //                            mYieldDateRateToday, 
            //                            mCurrencyDateExchangeRateYesterday
            //                          );
            //mEffectRateValue = mMarkToMarketValue - mMarkToMarketToday;

            #endregion

            #region "11.- Actualiza DataSet con Cartera T0 y T1"

            AddTableDataSet(cPortFolioToday, _PortFolioToday);
            //AddTableDataSet(cPortFolioTomorrow, _PortFolioTomorrow);
            //AddTableDataSet("TimeDecay", _PortFolioTimeDecay);
            //AddTableDataSet("ExhangeRate", _ExchangeRate);
            //AddTableDataSet("EffectRate", _EffectRate);

            #endregion

            #region "12.- Grabar valores"
            
            SaveData();

            #endregion

        }

        #endregion

        #endregion

        #region "Metodos Privados"

        private DataTable CalculateDateBR(DataTable portFolio)
        {

            DateTime _IssueDate;
            DateTime _ExpiryDate;
            DataRow[] _DataRows;
            DataRow _DataRow;
            string _MNemonics;
            int _Row;
            int _Day;
            int _Month;
            int _Year;
            string _Character3;
            string _Character4;

            _DataRows = portFolio.Select("MNemonicsCode = 888");

            for (_Row = 0; _Row < _DataRows.Length; _Row++)
            {

                _DataRow = _DataRows[_Row];

                _MNemonics = _DataRow["MNemonics"].ToString();

                #region "Calculo de Fecha Emisión"

                _Character3 = _MNemonics.Substring(2, 1);
                _Character4 = _MNemonics.Substring(3, 1);

                _Day = 1;

                #region "Calculo del Mes"

                switch (Microsoft.VisualBasic.Strings.Asc(_Character3))
                {
                    case 48:
                        _Month = 10;
                        break;
                    case 49:
                    case 50:
                    case 51:
                    case 52:
                    case 53:
                    case 54:
                    case 55:
                    case 56:
                    case 57:
                        _Month = int.Parse(_Character3.ToString());
                        break;
                    case 65:
                    case 66:
                        _Month = Microsoft.VisualBasic.Strings.Asc(_Character3) - 54;
                        break;
                    default:
                        _Month = 0;
                        break;
                }

                #endregion

                #region "Calculo del Año"

                switch (Microsoft.VisualBasic.Strings.Asc(_Character4))
                {
                    case 48:
                        _Year = 10;
                        break;
                    case 49:
                    case 50:
                    case 51:
                    case 52:
                    case 53:
                    case 54:
                    case 55:
                    case 56:
                    case 57:
                        _Year = int.Parse(_Character4.ToString());
                        break;
                    default:
                        _Year = Microsoft.VisualBasic.Strings.Asc(_Character4) - 54;
                        break;
                }


                _Year += 1980;

                #endregion

                _IssueDate = new DateTime(_Year, _Month, _Day);

                #endregion

                #region "Calculo de Fecha de Vencimiento"

                _Day = int.Parse(_MNemonics.Substring(4,2).ToString());
                _Month = int.Parse(_MNemonics.Substring(6,2).ToString());
                _Year = int.Parse(_MNemonics.Substring(8,2).ToString());
    
                _Year += (_Year < 95) ? 2000 : 1900;

                _ExpiryDate = new DateTime(_Year, _Month, _Day);

                #endregion

                _DataRow["IssueDate"] = _IssueDate;
                _DataRow["ExpiryDate"] = _ExpiryDate;
                _DataRow["CouponExpiryDate"] = _ExpiryDate;

            }

            return portFolio;

        }

        #region "Rutinas de Valorización privadas"

        private void LoadUM(DataTable portfolio)
        {

            int _Row = 0;
            DateTime _PurchaseDate;

            LoadCurrency(mPortFolio.PreviousEndofMonth);

            for (_Row = 0; _Row < portfolio.Rows.Count; _Row++)
            {

                _PurchaseDate = DateTime.Parse(portfolio.Rows[_Row]["PurchaseDate"].ToString());
                LoadCurrency(_PurchaseDate);

            }

        }

        private void ValidIPC(DataTable portfolio)
        {

            DateTime _DateIPC;
            DateTime _DateIPCAux;
            DateTime _PublicationEntrySystem;
            DataTable _DateIPCData;
            cData.Parameters.PublicationIPC _PublicationIPC = new cData.Parameters.PublicationIPC();
            bool _AddDateICP = false;
            DataRow[] _DataRows;
            DataRow _DataRow;
            int _Row = 0;
            int _DocumentNumber;
            int _OperationNumber;
            int _ID;
            String _MNemonicsKey = "";
            cFinancialTools.Instruments.MNemonics _MNemonics = new MNemonics();

            _DateIPC = new DateTime(mPortFolioDateToday.Year, mPortFolioDateToday.Month, 1);
            _DateIPC = _DateIPC.AddMonths(-1);
            _PublicationEntrySystem = mPortFolioDateToday;

            _DateIPCData = _PublicationIPC.Load(mPortFolioDateToday);

            if (_DateIPCData.Rows.Equals(0))
            {

                _AddDateICP = false;

            }
            else
            {
                _PublicationEntrySystem = DateTime.Parse(_DateIPCData.Rows[0]["PublicationEntrySystem"].ToString());
                _DateIPC = DateTime.Parse(_DateIPCData.Rows[0]["ValueDate"].ToString());

                if (_PublicationEntrySystem <= mPortFolioDateToday)
                {

                    _AddDateICP = false;

                }
                else
                {

                    _AddDateICP = true;

                }

            }

            mCurrencyList.Load(502, enumSource.System, _DateIPC, ""); // IPC hoy

            _DateIPCAux = _DateIPC.AddMonths(-1);

            mCurrencyList.Load(502, enumSource.System, _DateIPCAux, ""); // IPC hoy

            _DataRows = portfolio.Select("MNemonicsCode = 888");

            for (_Row = 0; _Row < _DataRows.Length; _Row++)
            {

                _DataRow = _DataRows[_Row];

                _DocumentNumber = int.Parse(_DataRow["DocumentNumber"].ToString());
                _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());
                _ID = int.Parse(_DataRow["OperationID"].ToString());

                _MNemonicsKey = _DocumentNumber.ToString() + "." + _ID;

                _MNemonics = mMnemonicsList.Read(_MNemonicsKey);
                _MNemonics.DateICP = _DateIPC;
                _MNemonics.PublicationEntrySystem = _PublicationEntrySystem;

            }

        }

        private DataTable Load(DateTime portFolioDate, DateTime markToMarketDateToday, DateTime markToMarketRateYesterday)
        {

            #region "Definición de Variables a Utilizar"

            cData.PortFolio.PortFolioFixingRate _PortFolioFixingRate;
            DataSet _PortFolio;
            DataTable _PortFolioData;
            DataTable _TPM;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioFixingRate = new cData.PortFolio.PortFolioFixingRate(enumSource.System);
            _PortFolio = new DataSet();
            _PortFolioData = new DataTable();

            #endregion

            #region "Carga de Cartera"

            _PortFolio = (DataSet)_PortFolioFixingRate.LoadPortFolio(portFolioDate, markToMarketDateToday, markToMarketRateYesterday);
            _PortFolioData = _PortFolio.Tables["FixingRatePortFolio"];

            AddColumnPortFolio(_PortFolioData);

            #endregion

            #region "Rescata Valor de la Tasa Politica Monetaria"

            _TPM = _PortFolio.Tables["TPMrate"];
            
            mTPMRate = 0;

            if (_TPM.Rows.Count > 0)
            {
                mTPMRate = double.Parse(_TPM.Rows[0]["TPMRate"].ToString());
            }

            _TPM.Dispose();

            #endregion

            return _PortFolioData;

        }

        private DataTable ValuatorPortFolio(DataTable portFolioData)
        {

            #region "Definición de Variables"

            int _Row;
            cFinancialTools.Instruments.MNemonics _MNemonics;
            cFinancialTools.DayCounters.Basis _BasisTPM;
            double _ExchangeRate;
            int _Currency;
            DataRow _CurrentRow;
            int _DocumentNumber;
            double _PurchaseValue;
            double _PurchaseValueUM;
            double _CarryCost;
            double _CarryFactor;

            DateTime _PurchaseDate;
            string _YieldName;
            cFinancialTools.Yield.Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue; ;

            double _PresentValueToday;
            double _PresentValueYesterday;
            double _PresentValueEndOfMonthPrevious;
            double _MarkToMarketToday;
            double _MarkToMarketYesterday;
            DateTime _PaymentDate;

            //double _AccruedInterest;    // Interes Acumulado
            //double _DailyInterest;      // Interes Diario
            //double _MonthlyInterest;    // Interes Mensual
            //double _AccruedAdjustment;  // Reajuste Acumulado
            //double _DailyAdjustment;    // Reajuste Diario
            //double _MonthlyAdjustment;  // Reajuste Mensual

            double _UMToday;
            double _UMYesterday;
            double _UMEndOfMonthPrevious;
            double _UMPurchaseDate;
            double _SalesValue;
            double _PurchaseValueUMNew;
            double _PurchaseValueNew;
            double _Flow;
            //double _ExpiryInterest;
            //double _ExpiryAdjustment;

            #endregion

            #region "Inicialización de Variables"

            _MNemonics = new MNemonics();
            _ExchangeRate = 0;
            mPresenteValueValuator = 0;
            _PurchaseValue = 0;
            _CarryCost = 0;
            _CarryFactor = 0;
            _BasisTPM = new cFinancialTools.DayCounters.Basis();

            _PresentValueToday = 0;
            _PresentValueYesterday = 0;
            _PresentValueEndOfMonthPrevious = 0;
            _MarkToMarketToday = 0;
            _MarkToMarketYesterday = 0;

            _PurchaseValueUMNew = 0;
            _PurchaseValueNew = 0;
            _Flow = 0;
            //_ExpiryInterest = 0;
            //_ExpiryAdjustment = 0;

            #endregion

            #region "Valorización"

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {

                #region "Recupera Contrato"

                _CurrentRow = portFolioData.Rows[_Row];

                #endregion

                #region "Asignación de Valores"

                _DocumentNumber = int.Parse(_CurrentRow["DocumentNumber"].ToString());
                _PurchaseDate = DateTime.Parse(_CurrentRow["PurchaseDate"].ToString());
                _PurchaseValue = double.Parse(_CurrentRow["PurchaseValue"].ToString());
                _PurchaseValueUM = double.Parse(_CurrentRow["PurchaseValueUM"].ToString());
                _SalesValue = double.Parse(_CurrentRow["SalesValue"].ToString());
                _Currency = int.Parse(_CurrentRow["CurrencyIssueID"].ToString());
                _PaymentDate = DateTime.Parse(_CurrentRow["PaymentDate"].ToString());

                _PurchaseValueUMNew = double.Parse(_CurrentRow["PurchaseValueUMToday"].ToString()); ;
                _PurchaseValueNew = double.Parse(_CurrentRow["PurchaseValueToday"].ToString()); ;
                _Flow = double.Parse(_CurrentRow["Flow"].ToString()); ;

                _YieldName = GetCurve(_Currency);
                _Yield = new cFinancialTools.Yield.Yield();
                _Yield = mYieldList.Read(_YieldName);

                #endregion

                if (_DocumentNumber.Equals(46692))
                {
                    _DocumentNumber = 46692;
                }

                SetYieldRateType(enumRate.RateOriginal, mYieldDateRateToday);
                SetYieldRateType(enumRate.RateOriginal, mYieldDateRateYesterday);

                #region "Valoriza Hoy"

                _MNemonics = ValuatorTX(enumValuatorFixingRate.Valuator, _CurrentRow, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);

                #region "Recalcula en Valor Presente para las Letras de Propia Emisión"

                if (_MNemonics.MnemonicsID.Equals(cLettersOfCreditMortgageID))
                {
                    if (_MNemonics.IssuerID.Equals(cIssueID))
                    {
                        _Currency = _MNemonics.IssueCurrency;
                        _ExchangeRate = mCurrencyList.Read(_Currency, enumSource.System, mCurrencyDateExchangeRateToday).ExchangeRate;

                        _MNemonics.PresentValueUM = (_MNemonics.ParValue * 0.01) * _MNemonics.Nominal;
                        _MNemonics.PresentValueCLP = Math.Round(_MNemonics.PresentValueUM * _ExchangeRate, 0);
                    }
                }

                #endregion

                #region "Calculo del Costo de Carry"

                _CarryCost = 0;

                if (_PaymentDate < mPortFolioDateToday && !_PurchaseDate.Equals(mPortFolioDateToday))
                {
                    _BasisTPM = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, mPortFolioDateToday, mPortFolioDateTomorrow);
                    _CarryFactor = 0.70;
                    _PurchaseValue = double.Parse(_CurrentRow["PurchaseValue"].ToString());

                    if (_MNemonics.IssuerID.Equals(97029000) || _MNemonics.IssuerID.Equals(60805000))
                    {
                        _CarryFactor = 0.25;
                    }

                    _CarryCost = _PurchaseValue * ((mTPMRate + _CarryFactor) * 0.01) * _BasisTPM.TermBasis;

                }

                #endregion

                _PresentValueToday = _MNemonics.PresentValueCLP;

                portFolioData.Rows[_Row]["CourtDateCoupon"] = _MNemonics.CourtDateCoupon;
                portFolioData.Rows[_Row]["ValuatorPresentValueUM"] = _MNemonics.PresentValueUM;
                portFolioData.Rows[_Row]["ValuatorPresentValueCLP"] = _MNemonics.PresentValueCLP;
                portFolioData.Rows[_Row]["ValuatorMacaulayDuration"] = _MNemonics.DurationMacaulay;
                portFolioData.Rows[_Row]["ValuatorModifiedDuration"] = _MNemonics.DurationModificed;
                portFolioData.Rows[_Row]["ValuatorConvexity"] = _MNemonics.Convextion;
                portFolioData.Rows[_Row]["CorryCost"] = _CarryCost;
                portFolioData.Rows[_Row]["CashFlow"] = _Flow;

                #endregion

                #region "Valorización Ayer"

                _PresentValueYesterday = 0;

                if (_PurchaseDate < mPortFolioDateToday)
                {

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.Valuator, _CurrentRow, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday);

                    #region "Recalcula en Valor Presente para las Letras de Propia Emisión"

                    if (_MNemonics.MnemonicsID.Equals(cLettersOfCreditMortgageID))
                    {
                        if (_MNemonics.IssuerID.Equals(cIssueID))
                        {
                            _Currency = _MNemonics.IssueCurrency;
                            _ExchangeRate = mCurrencyList.Read(_Currency, enumSource.System, mCurrencyDateExchangeRateYesterday).ExchangeRate;

                            _MNemonics.PresentValueUM = (_MNemonics.ParValue * 0.01) * _MNemonics.Nominal;
                            _MNemonics.PresentValueCLP = Math.Round(_MNemonics.PresentValueUM * _ExchangeRate, 0);
                        }
                    }

                    #endregion

                    _PresentValueYesterday = _MNemonics.PresentValueCLP;

                    portFolioData.Rows[_Row]["ValuatorPresentValueYesterday"] = _MNemonics.PresentValueCLP;
                    portFolioData.Rows[_Row]["ValuatorPresentValueYesterdayUM"] = _MNemonics.PresentValueUM;

                }

                #endregion

                #region "Valor Presente a Fin de Mes previo"

                _PresentValueEndOfMonthPrevious = _PresentValueToday;

                if (_PurchaseDate < mPortFolio.PreviousEndofMonth)
                {

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.Valuator, _CurrentRow, mPortFolio.PreviousEndofMonth, mPortFolio.PreviousEndofMonth, mPortFolio.PreviousEndofMonth);

                    #region "Recalcula en Valor Presente para las Letras de Propia Emisión"

                    if (_MNemonics.MnemonicsID.Equals(cLettersOfCreditMortgageID))
                    {
                        if (_MNemonics.IssuerID.Equals(cIssueID))
                        {
                            _Currency = _MNemonics.IssueCurrency;
                            _ExchangeRate = mCurrencyList.Read(_Currency, enumSource.System, mPortFolio.PreviousEndofMonth).ExchangeRate;

                            _MNemonics.PresentValueUM = (_MNemonics.ParValue * 0.01) * _MNemonics.Nominal;
                            _MNemonics.PresentValueCLP = Math.Round(_MNemonics.PresentValueUM * _ExchangeRate, 0);
                        }
                    }

                    #endregion

                    _PresentValueEndOfMonthPrevious = _MNemonics.PresentValueCLP;

                    portFolioData.Rows[_Row]["ValuatorPresenteValueEndOfMonthPrevious"] = _MNemonics.PresentValueCLP;

                }

                #endregion

                SetYieldRateType(enumRate.RateBasis, mYieldDateRateToday);
                SetYieldRateType(enumRate.RateBasis, mYieldDateRateYesterday);

                #region "Valor Mercado HOY"

                _MarkToMarketToday = 0;

                if (!(_CurrentRow["DataType"].ToString().Equals("MO") && _CurrentRow["DataOperationType"].ToString().Equals("V")))
                {
                    _YieldSource = _Yield.Read(enumSource.System);
                    _YieldValue = _YieldSource.Read(mYieldDateRateToday);
                    _YieldValue.RateBasis = double.Parse(_CurrentRow["MarkToMarketRateToday"].ToString());

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.MartToMarket, _CurrentRow, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);

                    portFolioData.Rows[_Row]["MarkToMarketCLP"] = _MNemonics.PresentValueCLP;
                    portFolioData.Rows[_Row]["MarkToMarketUM"] = _MNemonics.PresentValueUM;
                    portFolioData.Rows[_Row]["ValuatorMacaulayDuration"] = _MNemonics.DurationMacaulay;
                    portFolioData.Rows[_Row]["ValuatorModifiedDuration"] = _MNemonics.DurationModificed;
                    portFolioData.Rows[_Row]["ValuatorConvexity"] = _MNemonics.Convextion;

                    _MarkToMarketToday = _MNemonics.PresentValueCLP;

                }

                #endregion

                #region "Valor Mercado Ayer"

                _MarkToMarketYesterday = 0;

                if (_PurchaseDate < mPortFolioDateToday)
                {

                    _YieldSource = _Yield.Read(enumSource.System);
                    _YieldValue = _YieldSource.Read(mYieldDateRateYesterday);
                    _YieldValue.RateBasis = double.Parse(_CurrentRow["MarkToMarketRateYesterday"].ToString());

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.MartToMarket, _CurrentRow, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday);

                    portFolioData.Rows[_Row]["ValuatorMarkToMarketYesterday"] = _MNemonics.PresentValueCLP;
                    portFolioData.Rows[_Row]["ValuatorMarkToMarketYesterdayUM"] = _MNemonics.PresentValueUM;
                    _MarkToMarketYesterday = _MNemonics.PresentValueCLP;

                }

                #endregion

                #region "Calculo Time Decay, Efecto Tasa y Efecto Tipo Cambio"

                if (_PurchaseDate == mPortFolioDateToday)
                {
                    portFolioData.Rows[_Row]["CashFlow"] = _MarkToMarketToday - _PurchaseValue;
                    portFolioData.Rows[_Row]["ValuatorEffectRate"] = _MarkToMarketToday;
                }
                else if (_CurrentRow["DataType"].ToString().Equals("MO") && _CurrentRow["DataOperationType"].ToString().Equals("V"))
                {
                    portFolioData.Rows[_Row]["CashFlow"] = _SalesValue - _PresentValueToday;
                }
                else
                {
                    _YieldSource = _Yield.Read(enumSource.System);
                    _YieldValue = _YieldSource.Read(mYieldDateRateYesterday);
                    _YieldValue.RateBasis = double.Parse(_CurrentRow["MarkToMarketRateYesterday"].ToString());

                    #region "Time Decay"

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.MartToMarket, _CurrentRow, mPortFolioDateToday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday);

                    portFolioData.Rows[_Row]["ValuatorTimeDecay"] = _MNemonics.PresentValueCLP;

                    #endregion

                    #region "Efecto Tipo Cambio"

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.MartToMarket, _CurrentRow, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateToday);

                    portFolioData.Rows[_Row]["ValuatorExchangeRate"] = _MNemonics.PresentValueCLP;

                    #endregion

                    #region "Efecto Tasa"

                    _YieldSource = _Yield.Read(enumSource.System);
                    _YieldValue = _YieldSource.Read(mYieldDateRateYesterday);
                    _YieldValue.RateBasis = double.Parse(_CurrentRow["MarkToMarketRateToday"].ToString());

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.MartToMarket, _CurrentRow, mPortFolioDateYesterday, mYieldDateRateToday, mCurrencyDateExchangeRateYesterday);

                    portFolioData.Rows[_Row]["ValuatorEffectRate"] = _MNemonics.PresentValueCLP;

                    #endregion

                }

                #endregion

                #region "Rescata Valores de Monedas"

                if (_Currency.Equals(999))
                {
                    _UMToday = 1;
                    _UMYesterday = 1;
                    _UMEndOfMonthPrevious = 1;
                    _UMPurchaseDate = 1;

                }
                else if (_Currency.Equals(994))
                {
                    _UMToday = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateToday).ExchangeRate;
                    _UMYesterday = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                    _UMEndOfMonthPrevious = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mPortFolio.PreviousEndofMonth).ExchangeRate;
                    _UMPurchaseDate = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, _PurchaseDate).ExchangeRate;
                }
                else
                {
                    _UMToday = mCurrencyList.Read(_Currency, enumSource.System, mCurrencyDateExchangeRateToday).ExchangeRate;
                    _UMYesterday = mCurrencyList.Read(_Currency, enumSource.System, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                    _UMEndOfMonthPrevious = mCurrencyList.Read(_Currency, enumSource.System, mPortFolio.PreviousEndofMonth).ExchangeRate;
                    _UMPurchaseDate = mCurrencyList.Read(_Currency, enumSource.System, _PurchaseDate).ExchangeRate;
                }

                #endregion

                #region "Calculo de Interes y Reajustes"

                //if (_PaymentDate < mPortFolioDateToday || _CurrentRow["DataOperationType"].ToString().Equals("V"))
                //{

                //    //_ExpiryInterest = 0;
                //    //_ExpiryAdjustment = 0;

                //    //if (!_Flow.Equals(0))
                //    //{
                //    //    _ExpiryInterest = 0;
                //    //    _ExpiryAdjustment = 0;
                //    //}

                //    #region "Calculo Interes y Reajuste Diario"

                //    //_DailyAdjustment = _PurchaseValueUM * (_UMToday - _UMYesterday);

                //    //if (_PurchaseDate.Equals(mPortFolioDateYesterday))
                //    //{
                //    //    _DailyInterest = _PresentValueToday - _PurchaseValue - _DailyAdjustment + _Flow;
                //    //}
                //    //else
                //    //{
                //    //    _DailyInterest = _PresentValueToday - _PresentValueYesterday - _DailyAdjustment + _Flow;
                //    //}

                //    //portFolioData.Rows[_Row]["DailyAdjustment"] = _DailyAdjustment;
                //    //portFolioData.Rows[_Row]["DailyInterest"] = _DailyInterest;

                //    #endregion

                //    #region "Calculo Interes y Reajuste Acumulado"

                //    //_AccruedAdjustment = _PurchaseValueUM * (_UMToday - _UMPurchaseDate);    // Interes Acumulado
                //    //_AccruedInterest = _PresentValueToday - _PurchaseValue - _AccruedAdjustment;

                //    //portFolioData.Rows[_Row]["AccruedAdjustment"] = _AccruedAdjustment;
                //    //portFolioData.Rows[_Row]["AccruedInterest"] = _AccruedInterest;

                //    #endregion

                //    #region "Calculo Interes y Reajuste Mensual"

                //    //_MonthlyAdjustment = _AccruedAdjustment;
                //    //_MonthlyInterest = _AccruedInterest;

                //    //if (_PurchaseDate < mPortFolio.PreviousEndofMonth)
                //    //{
                //    //    _MonthlyAdjustment = _PurchaseValueUM * (_UMToday - _UMEndOfMonthPrevious);
                //    //    _MonthlyInterest = _PresentValueToday - _PresentValueEndOfMonthPrevious - _MonthlyAdjustment;
                //    //}

                //    //portFolioData.Rows[_Row]["MonthlyAdjustment"] = _MonthlyAdjustment;
                //    //portFolioData.Rows[_Row]["MonthlyInterest"] = _MonthlyInterest;

                //    #endregion

                //}

                #endregion

                #region "Suma Valor Presente"

                mPresenteValueValuator += _MNemonics.PresentValueCLP;

                #endregion

            }

            #endregion

            return portFolioData;



        }

        private DataTable Valuator(
                                    DataTable portFolioData,
                                    DateTime valuatorDate,
                                    DateTime yieldDate,
                                    DateTime exchangeRateDate
                                  )
        {

            #region "Definición de Variables"

            int _Row;
            cFinancialTools.Instruments.MNemonics _MNemonics;
            cFinancialTools.DayCounters.Basis _BasisTPM;
            double _ExchangeRate;
            int _Currency;
            DataRow _CurrentRow;
            int _DocumentNumber;
            double _PurchaseValue;
            double _CarryCost;
            double _CarryFactor;

            #endregion

            #region "Inicialización de Variables"

            _MNemonics = new MNemonics();
            _ExchangeRate = 0;
            mPresenteValueValuator = 0;
            _PurchaseValue = 0;
            _CarryCost = 0;
            _CarryFactor = 0;
            _BasisTPM = new cFinancialTools.DayCounters.Basis();

            #endregion

            #region "Valorización"

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {

                #region "Recupera Contrato"

                _CurrentRow = portFolioData.Rows[_Row];

                #endregion

                #region "Valoriza Hoy"

                _DocumentNumber = int.Parse(_CurrentRow["DocumentNumber"].ToString());

                _MNemonics = ValuatorTX(enumValuatorFixingRate.Valuator, _CurrentRow, valuatorDate, yieldDate, exchangeRateDate);

                portFolioData.Rows[_Row]["CourtDateCoupon"] = _MNemonics.CourtDateCoupon;
                portFolioData.Rows[_Row]["ValuatorPresentValueUM"] = _MNemonics.PresentValueUM;
                portFolioData.Rows[_Row]["ValuatorPresentValueCLP"] = _MNemonics.PresentValueCLP;
                portFolioData.Rows[_Row]["ValuatorMacaulayDuration"] = _MNemonics.DurationMacaulay;
                portFolioData.Rows[_Row]["ValuatorModifiedDuration"] = _MNemonics.DurationModificed;
                portFolioData.Rows[_Row]["ValuatorConvexity"] = _MNemonics.Convextion;
                portFolioData.Rows[_Row]["CorryCost"] = _CarryCost;

                #endregion

                #region "Recalcula en Valor Presente para las Letras de Propia Emisión"

                if (_MNemonics.MnemonicsID.Equals(cLettersOfCreditMortgageID))
                {
                    if (_MNemonics.IssuerID.Equals(cIssueID))
                    {
                        _Currency = _MNemonics.IssueCurrency;
                        _ExchangeRate = mCurrencyList.Read(_Currency, enumSource.System, exchangeRateDate).ExchangeRate;

                        _MNemonics.PresentValueUM = (_MNemonics.ParValue * 0.01) * _MNemonics.Nominal;
                        _MNemonics.PresentValueCLP = Math.Round(_MNemonics.PresentValueUM * _ExchangeRate, 0);
                    }
                }

                #endregion

                #region "Calculo del Costo de Corry"

                _CarryCost = 0;

                if (mPortFolioDateToday.Equals(valuatorDate))
                {

                    _BasisTPM = new cFinancialTools.DayCounters.Basis(enumBasis.Basis_Act_360, mPortFolioDateYesterday, mPortFolioDateToday);
                    _CarryFactor = 0.70;
                    _PurchaseValue = double.Parse(_CurrentRow["PurchaseValue"].ToString());

                    if (_MNemonics.IssuerID.Equals(97029000) || _MNemonics.IssuerID.Equals(60805000))
                    {
                        _CarryFactor = 0.25;
                    }

                    _CarryCost = _PurchaseValue * ((mTPMRate + _CarryFactor) * 0.01) * _BasisTPM.TermBasis;

                }

                #endregion

                #region "Actualiza Valorización"

                portFolioData.Rows[_Row]["CourtDateCoupon"] = _MNemonics.CourtDateCoupon;
                portFolioData.Rows[_Row]["ValuatorPresentValueUM"] = _MNemonics.PresentValueUM;
                portFolioData.Rows[_Row]["ValuatorPresentValueCLP"] = _MNemonics.PresentValueCLP;
                portFolioData.Rows[_Row]["ValuatorMacaulayDuration"] = _MNemonics.DurationMacaulay;
                portFolioData.Rows[_Row]["ValuatorModifiedDuration"] = _MNemonics.DurationModificed;
                portFolioData.Rows[_Row]["ValuatorConvexity"] = _MNemonics.Convextion;
                portFolioData.Rows[_Row]["CorryCost"] = _CarryCost;

                #endregion

                #region "Suma Valor Presente"

                mPresenteValueValuator += _MNemonics.PresentValueCLP;

                #endregion

            }

            #endregion

            return portFolioData;

        }

        private DataTable MarkToMarket(
                                        enumFlagMartTOMarketFixingRate _flagMartTOMarketFixingRate, 
                                        DataTable portFolioData,
                                        DateTime valuatorDate,
                                        DateTime yieldDate,
                                        DateTime exchangeRateDate
                                      )
        {

            #region "Definición de Variables"

            int _DocumentNumber;
            int _Row;
            cFinancialTools.Instruments.MNemonics _MNemonics;
            int _Currency;
            string _YieldName = "";
            DataRow _CurrentRow;
            cFinancialTools.Yield.Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue; ;
            YieldPoint _YieldPoint;

            #endregion

            #region "Inicialización de Variables"

            _MNemonics = new MNemonics();
            mMarkToMarketValue = 0;
            mCashFlow = 0;

            #endregion

            #region "Seteo de Curvas"

            SetYieldRateType(enumRate.RateBasis, yieldDate);

            #endregion

            #region "Valorización a Tasa de Mercado"

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {

                #region "Recupera Contrato"

                _CurrentRow = portFolioData.Rows[_Row];

                #endregion

                #region "Actualización de Datos en la Curva"

                #region "Recupera moneda emisión"

                _DocumentNumber = int.Parse(_CurrentRow["DocumentNumber"].ToString());

                _Currency = int.Parse(_CurrentRow["CurrencyIssueID"].ToString());

                #endregion

                #region "Recupera nombre y datos de la Curva"

                _YieldName = GetCurve(_Currency);
                _Yield = new cFinancialTools.Yield.Yield();
                _Yield = mYieldList.Read(_YieldName);

                #endregion

                #region "Inicializa Variables de Curva"

                _YieldSource = new YieldSource();
                _YieldValue = new YieldValue();
                _YieldPoint = new YieldPoint();

                #endregion

                #region "Asigna Tasa Base"

                _YieldSource = _Yield.Read(enumSource.System);
                _YieldValue = _YieldSource.Read(yieldDate);

                if (_flagMartTOMarketFixingRate == enumFlagMartTOMarketFixingRate.RateToday)
                {
                    _YieldValue.RateBasis = double.Parse(_CurrentRow["MarkToMarketRateToday"].ToString());
                }
                else
                {
                    _YieldValue.RateBasis = double.Parse(_CurrentRow["MarkToMarketRateYesterday"].ToString());
                }

                #endregion

                #endregion

                #region "Valoriza a Mercado"

                _MNemonics = ValuatorTX(enumValuatorFixingRate.MartToMarket, _CurrentRow, valuatorDate, yieldDate, exchangeRateDate);

                #endregion

                #region "Actualiza Valores de Mercado"

                portFolioData.Rows[_Row]["MarkToMarketCLP"] = _MNemonics.PresentValueCLP;
                portFolioData.Rows[_Row]["MarkToMarketUM"] = _MNemonics.PresentValueUM;
                portFolioData.Rows[_Row]["ValuatorMacaulayDuration"] = _MNemonics.DurationMacaulay;
                portFolioData.Rows[_Row]["ValuatorModifiedDuration"] = _MNemonics.DurationModificed;
                portFolioData.Rows[_Row]["ValuatorConvexity"] = _MNemonics.Convextion;
                portFolioData.Rows[_Row]["CashFlow"] = _MNemonics.CouponFlowCLP;

                #endregion

                #region "Suma el valor de Mercado"

                mMarkToMarketValue += _MNemonics.PresentValueCLP;
                mMarkToMarketValueUM += _MNemonics.PresentValueUM;
                mCashFlow += _MNemonics.CouponFlowCLP;

                #endregion

            }

            #endregion

            return portFolioData;

        }

        private DataSet Sensibilities(DataSet sensibilitiesData, DateTime valuatorDate, DateTime yieldDate, DateTime exchangeRateDate)
        {

            #region "Definición de Variables"

            string _YieldName;

            cFinancialTools.Instruments.MNemonics _MNemonics;
            cFinancialTools.Yield.Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue; ;
            YieldPoint _YieldPoint;
            DataTable _SensibilitiesOperationData;
            DataTable _SensibilitiesTermByOperation;
            DataTable _SensibilitiesByYield;
            DataTable _PortFolioToday;
            Hashtable _YieldData;
            Hashtable _YieldDataValue;
            Hashtable _YieldPointValue;

            DataRow _CurrentRow;
            DataRow _CurrentTermByOperation;
            DataRow _CurrentOperation;
            DataRow _CurrentYield;

            int _OperationNumber;
            int _DocumentNumber;
            int _OperationNumberID;
            int _Row;
            int _Currency;
            int _Term;
            int _Point;

            double _ValueSensibilities;
            double _ValueEstimation;
            double _ValueMarkToMarket;
            double _RateMarkToMarketToday;
            double _RateMarkToMarketYesterday;
            double _ValueSensibilitiesOperation;
            double _ValueEstimationOperation;
            double _YieldSensibilities;
            double _YieldDelta;
            double _YieldEstimation;

            #endregion

            #region "Inicialización de Variables"

            _YieldName = "";

            _MNemonics = new MNemonics();
            _SensibilitiesOperationData = new DataTable();
            _SensibilitiesTermByOperation = new DataTable();
            _SensibilitiesByYield = new DataTable();
            _PortFolioToday = new DataTable();
            _YieldData = new Hashtable();
            _YieldDataValue = new Hashtable();
            _YieldPointValue = new Hashtable();
            _Term = 0;
            _Point = 0;
            _ValueMarkToMarket = 0;
            _RateMarkToMarketToday = 0;
            _RateMarkToMarketYesterday = 0;
            _ValueSensibilitiesOperation = 0;
            _ValueEstimationOperation = 0;
            _YieldSensibilities = 0;
            _YieldDelta = 0;
            _YieldEstimation = 0;

            #endregion

            #region "Seteo de Curvas"

            //SetYieldRateType(enumRate.RateOriginalSpread, yieldDate);RateBasis
            SetYieldRateType(enumRate.RateBasis, yieldDate);

            #endregion

            #region "Seteo de Tablas"

            _SensibilitiesOperationData = sensibilitiesData.Tables[cSensibilitiesOperationData];
            _SensibilitiesTermByOperation = sensibilitiesData.Tables[cSensibilitiesOperationByTerm];
            _SensibilitiesByYield = sensibilitiesData.Tables[cSensibilitiesByYield];
            _PortFolioToday = sensibilitiesData.Tables["PortFolio"];

            #endregion

            #region "Valorización a Tasa de Mercado"

            for (_Row = 0; _Row < _PortFolioToday.Rows.Count; _Row++)
            {

                #region "Recupera Contrato"

                _CurrentRow = _PortFolioToday.Rows[_Row];

                #endregion

                #region "Actualización de Datos en la Curva"

                #region "Recupera datos necesasrios del contrato"

                _OperationNumber = int.Parse(_CurrentRow["OperationNumber"].ToString());
                _DocumentNumber = int.Parse(_CurrentRow["DocumentNumber"].ToString());
                _OperationNumberID = int.Parse(_CurrentRow["OperationID"].ToString());
                _RateMarkToMarketToday = double.Parse(_CurrentRow["MarkToMarketRateToday"].ToString());
                _RateMarkToMarketYesterday = double.Parse(_CurrentRow["MarkToMarketRateYesterday"].ToString());
                _Currency = int.Parse(_CurrentRow["CurrencyIssueID"].ToString());

                if (_DocumentNumber.Equals(68240))
                {
                    _DocumentNumber = 68240;
                }

                #endregion

                #region "Recupera nombre y datos de la Curva"

                _YieldName = GetCurve(_Currency);
                _Yield = new cFinancialTools.Yield.Yield();
                _Yield = mYieldList.Read(_YieldName);

                #endregion

                #region "Inicializa Variables de Curva"

                _YieldSource = new YieldSource();
                _YieldValue = new YieldValue();

                #endregion

                #region "Asigna Tasa Base"

                if (_OperationNumber.Equals(68240))
                {
                    _OperationNumber = 68240;
                }

                _YieldSource = _Yield.Read(enumSource.System);
                _YieldValue = _YieldSource.Read(yieldDate);
                _YieldValue.RateBasis = _RateMarkToMarketToday;

                #endregion

                #endregion

                #region "Inicialización de Valores"

                _ValueSensibilitiesOperation = 0;
                _ValueEstimationOperation = 0;
                _ValueSensibilities = 0;
                _ValueEstimation = 0;

                _MNemonics = ValuatorTX(enumValuatorFixingRate.Sensibilite, _CurrentRow, valuatorDate, yieldDate, exchangeRateDate);
                _ValueMarkToMarket = _MNemonics.PresentValueCLP;

                #endregion

                #region "Construye arreglo Curva"

                _YieldDataValue = (Hashtable)_YieldData[_YieldName];

                if (_YieldDataValue == null)
                {
                    _YieldDataValue = new Hashtable();
                    _YieldData.Add(_YieldName, _YieldDataValue);
                }

                #endregion

                #region "Rutina de sensibilización de la operación"

                for (_Point = 0; _Point < _Yield.Read(enumSource.System).Read(yieldDate).Count; _Point++)
                {

                    #region "Suma 1BPS a al punto actual"

                    _YieldPoint = new YieldPoint();
                    _YieldPoint = _YieldValue.Point(_Point);
                    _YieldPoint.Spread = 0.01;
                    _Term = _YieldPoint.Term;

                    #endregion

                    #region "Valoriza a Mercado"

                    _MNemonics = ValuatorTX(enumValuatorFixingRate.Sensibilite, _CurrentRow, valuatorDate, yieldDate, exchangeRateDate);

                    #endregion

                    #region "Restable el valor original al punto actual"

                    _YieldPoint.Spread = 0.00;

                    #endregion

                    #region "Suma el valor de la Sensibilidad"

                    _ValueSensibilities = _MNemonics.PresentValueCLP - _ValueMarkToMarket;
                    _ValueEstimation = _ValueSensibilities * (_RateMarkToMarketToday - _RateMarkToMarketYesterday) * 100.0;
                    _ValueSensibilitiesOperation += _ValueSensibilities;
                    _ValueEstimationOperation += _ValueEstimation;

                    #endregion

                    #region "Actualiza valores para la operación por plazo"

                    _CurrentTermByOperation = _SensibilitiesTermByOperation.NewRow();

                    _CurrentTermByOperation["OperationNumber"] = _OperationNumber;
                    _CurrentTermByOperation["DocumentNumber"] = _DocumentNumber;
                    _CurrentTermByOperation["OperationID"] = _OperationNumberID;
                    _CurrentTermByOperation["MNemonicsMask"] = _MNemonics.MnemonicsMask;
                    _CurrentTermByOperation["MNemonics"] = _MNemonics.Mnemonics;
                    _CurrentTermByOperation["FamilyID"] = _MNemonics.FamilyID;
                    _CurrentTermByOperation["YieldName"] = _YieldName;
                    _CurrentTermByOperation["Term"] = _Term;
                    _CurrentTermByOperation["MarktoMarketValue"] = _ValueMarkToMarket;
                    _CurrentTermByOperation["SensibilitiesValue"] = _MNemonics.PresentValueCLP;
                    _CurrentTermByOperation["Sensibilities"] = _ValueSensibilities;
                    _CurrentTermByOperation["DeltaRate"] = (_RateMarkToMarketYesterday - _RateMarkToMarketToday);
                    _CurrentTermByOperation["Estimation"] = _ValueEstimation;

                    _SensibilitiesTermByOperation.Rows.Add(_CurrentTermByOperation);

                    #endregion

                    #region "Construye valores para de la curva"

                    _YieldPointValue = (Hashtable)_YieldDataValue[_Point.ToString()];

                    if (_YieldPointValue == null)
                    {
                        _YieldPointValue = new Hashtable();
                        _YieldSensibilities = 0;
                        _YieldDelta = 0;
                        _YieldEstimation = 0;
                        _YieldPointValue.Add("Sensibilities", 0);
                        _YieldPointValue.Add("Delta", 0);
                        _YieldPointValue.Add("Estimation", 0);
                        _YieldDataValue.Add(_Point.ToString(), _YieldPointValue);
                    }
                    else
                    {
                        _YieldSensibilities = (double)_YieldPointValue["Sensibilities"];
                        _YieldDelta = (double)_YieldPointValue["Delta"];
                        _YieldEstimation = (double)_YieldPointValue["Estimation"];
                    }

                    _YieldSensibilities += _ValueSensibilities;
                    _YieldEstimation += _ValueEstimation;

                    _YieldPointValue["Sensibilities"] = _YieldSensibilities;
                    _YieldPointValue["Delta"] = _YieldDelta;
                    _YieldPointValue["Estimation"] = _YieldEstimation;

                    _YieldDataValue[_Point.ToString()] = _YieldPointValue;

                    #endregion

                }

                #endregion

                #region "Actualiza Valores de la Curva"

                _YieldData[_YieldName] = _YieldDataValue;

                #endregion

                #region "Actualiza valores de la operación"

                _CurrentOperation = _SensibilitiesOperationData.NewRow();

                _CurrentOperation["OperationNumber"] = _OperationNumber;
                _CurrentOperation["DocumentNumber"] = _DocumentNumber;
                _CurrentOperation["OperationID"] = _OperationNumberID;
                _CurrentOperation["IssueCurrency"] = _Currency;
                _CurrentOperation["MarktoMarketValue"] = _ValueMarkToMarket;
                _CurrentOperation["SensibilitiesValue"] = _ValueSensibilitiesOperation;
                _CurrentOperation["DeltaRate"] = (_RateMarkToMarketYesterday - _RateMarkToMarketToday);
                _CurrentOperation["Estimation"] = _ValueEstimationOperation;

                _SensibilitiesOperationData.Rows.Add(_CurrentOperation);

                #endregion

            }

            #endregion

            #region "Actualiza Valores de Curva"

            mSensibilitiesValue = 0;
            mEstimationValue = 0;

            for (_Row = 0; _Row < mYieldArray.Count; _Row++)
            {
                _YieldName = (String)mYieldArray[_Row];

                _YieldDataValue = (Hashtable)_YieldData[_YieldName];

                if (!(_YieldDataValue == null))
                {

                    for (_Point = 0; _Point < mYieldList.Read(_YieldName, enumSource.System, yieldDate).Count; _Point++)
                    {

                        _YieldPointValue = (Hashtable)_YieldDataValue[_Point.ToString()];

                        if (_YieldPointValue == null)
                        {
                            _YieldSensibilities = 0;
                            _YieldDelta = 0;
                            _YieldEstimation = 0;
                        }
                        else
                        {
                            _YieldSensibilities = (double)_YieldPointValue["Sensibilities"];
                            _YieldDelta = (double)_YieldPointValue["Delta"];
                            _YieldEstimation = (double)_YieldPointValue["Estimation"];
                        }

                        _CurrentYield = _SensibilitiesByYield.NewRow();

                        _CurrentYield["YieldName"] = _YieldName;
                        _CurrentYield["Term"] = mYieldList.Read(_YieldName, enumSource.System, yieldDate).Point(_Point).Term;
                        _CurrentYield["Sensibilities"] = _YieldSensibilities;
                        _CurrentYield["DeltaRate"] = _YieldDelta;
                        _CurrentYield["Estimation"] = _YieldEstimation;

                        _SensibilitiesByYield.Rows.Add(_CurrentYield);

                        mSensibilitiesValue += _YieldSensibilities;
                        mEstimationValue += _YieldEstimation;

                    }

                }

            }

            #endregion

            #region "Actualiza Valores en el DataSet"

            sensibilitiesData = new DataSet();

            sensibilitiesData.Merge(_SensibilitiesOperationData);
            sensibilitiesData.Merge(_SensibilitiesTermByOperation);
            sensibilitiesData.Merge(_SensibilitiesByYield);

            #endregion

            return sensibilitiesData;

        }

        private void SaveData()
        {

            #region "Definición de Variables a Utilizar"

            cData.PortFolio.PortFolioFixingRate _PortFolioFixingRate;
            int _Currency;
            int _CurrencyID;
            enumSource _Source;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioFixingRate = new cData.PortFolio.PortFolioFixingRate(enumSource.System);

            #endregion

            #region "Grabar Cartera"

            mPortFolio.SaveLog(1);

            _PortFolioFixingRate.SavePortFolio(PortFolioDate, PortFolioDataSet, mUserID);

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

        #region "Agrega campos necesarios para la valorización en la tabla de Cartera"

        private DataTable AddColumnPortFolio(DataTable _PortFolioData)
        {

            #region "Def Variable"

            DataColumn _DataColumn;

            #endregion

            #region "Valor Presente en UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorPresentValueUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Presente en CLP"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorPresentValueCLP";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente CLP";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Duración Macaulay"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorMacaulayDuration";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Duración Macaulay";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Duración Modificada"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorModifiedDuration";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Duración Modificada";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Convexidad"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorConvexity";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Convexidad";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Mercado"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarkToMarketCLP";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Mercado en UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MarkToMarketUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Fecha Corte Cupón"
            
            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CourtDateCoupon";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Fecha Corte Cupón";
            //_DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Flujo Caja"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CashFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Costo de Corry"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CorryCost";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Costo de Corry";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Presente Ayer"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorPresentValueYesterday";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente Ayer";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Presente Ayer UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorPresentValueYesterdayUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente Ayer";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Mercado Ayer"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorMarkToMarketYesterday";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado Ayer";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Mercado Ayer UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorMarkToMarketYesterdayUM";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Mercado Ayer UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Time Decay"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorTimeDecay";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Costo de Corry";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Efecto Tasa"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorEffectRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Costo de Corry";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Efecto Tipo Cambio"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorExchangeRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Efecto Tipo Cambio";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valorización a Fin de Mes Anterior"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorPresenteValueEndOfMonthPrevious";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valorización a Fin de Mes Anterior";
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

        #region "Elimina Vencimientos"

        private DataTable RemoveVcto(DateTime dateRemove, DataTable portFolioData)
        {

            int _Row;
            DataRow _DataRow;
            DateTime _Date;

            for (_Row = (portFolioData.Rows.Count - 1); _Row >= 0; _Row--)
            {
                _DataRow = portFolioData.Rows[_Row];
                _Date = (DateTime)_DataRow["CouponExpiryDate"];

                if (_Date <= dateRemove)
                {
                    portFolioData.Rows.Remove(_DataRow);
                }

            }

            return portFolioData;

        }

        #endregion

        #region "Suma Valor Mark To Market BAC"

        private void SumMarkToMarketBAC(DataTable portFolioData)
        {

            int _Row;
            DataRow _DataRow;

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {
                _DataRow = portFolioData.Rows[_Row];

                mMarkToMarketTodayBAC += double.Parse(_DataRow["MarkToMarketValueToday"].ToString());
                mMarkToMarketYesterdayBAC += double.Parse(_DataRow["MarkToMarketValueYesterday"].ToString());

            }

        }

        #endregion

        #region "Carga de instrumentos mencionados en la Cartera"

        private void LoadInstruments(DataTable portFolioData)
        {

            int _Row;
            String _MNemonicsMask;
            int _OperationNumber;
            int _DocumentNumber;
            int _ID;
            bool _FlagSerie;
            DateTime _PurchaseDate;
            double _PurchaseRate;
            double _Nominal;

            _Row = 0;
            _MNemonicsMask = "";
            _DocumentNumber = 0;
            _OperationNumber = 0;
            _ID = 0;
            _FlagSerie = false;
            _PurchaseDate = new DateTime(1900, 1, 1);
            _PurchaseRate = 0;
            _Nominal = 0;

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {
                _MNemonicsMask = portFolioData.Rows[_Row]["MNemonicsMask"].ToString();
                _DocumentNumber = int.Parse(portFolioData.Rows[_Row]["DocumentNumber"].ToString());
                _OperationNumber = int.Parse(portFolioData.Rows[_Row]["OperationNumber"].ToString());
                _ID = int.Parse(portFolioData.Rows[_Row]["OperationID"].ToString());
                _FlagSerie = portFolioData.Rows[_Row]["DevelonmentTable"].Equals("S");
                _Nominal = double.Parse(portFolioData.Rows[_Row]["Nominal"].ToString());

                if (_DocumentNumber.Equals(66911))
                {
                    _DocumentNumber = 66911;
                }

                if (!(portFolioData.Rows[_Row]["PurchaseDate"].ToString() == ""))
                {
                    _PurchaseDate = DateTime.Parse(portFolioData.Rows[_Row]["PurchaseDate"].ToString());
                }
                _PurchaseRate = double.Parse(portFolioData.Rows[_Row]["PurchaseRate"].ToString());

                if (_FlagSerie)
                {
                    mMnemonicsList.Load(_MNemonicsMask, enumSource.System, _Nominal, _PurchaseDate, _PurchaseRate);
                }
                else
                {
                    mMnemonicsList.Load(_DocumentNumber, _ID, enumSource.System, _Nominal, _PurchaseDate, _PurchaseRate);
                }

            }

        }

        #endregion

        #region "Metodos para la Carga de Datos básicos"

        private void SetYieldList()
        {

            mYieldArray.Add("CURVASWAPCLP");
            mYieldArray.Add("CURVASWAPUF");
            mYieldArray.Add("CURVASWAPUSDLOCAL");

        }

        private void LoadYield(DateTime _DateYield)
        {
            int _Row;
            String _YieldName;

            for (_Row = 0; _Row < mYieldArray.Count; _Row++)
            {
                _YieldName = (String)mYieldArray[_Row];
                mYieldList.Load(_YieldName, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, _DateYield);
                mYieldList.Read(_YieldName, enumSource.System, _DateYield).RateBasis = 0;
            }

        }

        private void LoadCurrency(DateTime _DateCurrency)
        {
            mCurrencyList.Load(994, enumSource.CurrencyValueAccount, _DateCurrency, "CURVAFWUSD");
            mCurrencyList.Load(998, enumSource.System, _DateCurrency, "CURVAFWUF");
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
            _DataColumnConstraints = new DataColumn[3];

            #endregion

            #region "Operation Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Operación";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[0] = _DataColumn;

            #endregion

            #region "Document Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DocumentNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Operation ID"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationID";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Correlativo";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[2] = _DataColumn;

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

            #region "Document Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DocumentNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Operation ID"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationID";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Correlativo";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[2] = _DataColumn;

            #endregion

            #region "Yield Name"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "YieldName";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Nombre Curva";
            _DataColumn.DefaultValue = "";

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
            _DataColumnConstraints = new DataColumn[6];

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

            #region "Document Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "DocumentNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[1] = _DataColumn;

            #endregion

            #region "Operation ID"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationID";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Correlativo";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[2] = _DataColumn;

            #endregion

            #region "MNemonics Mask"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MNemonicsMask";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Mascara";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "MNemonics"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "MNemonics";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Instrumento";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Family ID"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "FamilyID";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Familia";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[3] = _DataColumn;

            #endregion

            #region "Yield Name"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "YieldName";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Nombre Curva";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[4] = _DataColumn;

            #endregion

            #region "Term"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Term";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "Plazo";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);
            _DataColumnConstraints[5] = _DataColumn;

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

        #region "Metodo que retona la Curva a utilizar por moneda"

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

        #region "Cambia el Tipo de Tasa"

        private void SetYieldRateType(enumRate rateType, DateTime yieldDate)
        {

            int _Row;
            string _YieldName;

            // Cambia el tipo de tasa que se aplicará en la curva
            for (_Row = 0; _Row < mYieldList.Count; _Row++)
            {
                _YieldName = (String)mYieldArray[_Row];
                mYieldList.Read(_YieldName, enumSource.System, yieldDate).RateType = rateType;
            }
            
        }

        #endregion

        #region "Rutina de ejecución de los valorizadores de renta fija"

        protected cFinancialTools.Instruments.MNemonics ValuatorTX(
                                                                    enumValuatorFixingRate _valuatorFixingRate,
                                                                    DataRow currentRow,
                                                                    DateTime dateValuator,
                                                                    DateTime dateYield,
                                                                    DateTime dateCurrency
                                                                  )
        {

            DateTime _PaymentDate;
            int _MNnemonicsID;
            String _MNemonicsMask;
            Boolean _FlagSerie;
            int _DocumentNumber;
            int _OperationNumber;
            int _ID;
            String _MNemonicsKey = "";
            cFinancialTools.Instruments.MNemonics _MNemonics = new MNemonics();
            String _YieldName;
            int _Currency;
            DateTime _ValuatorDate;
            cFinancialTools.Yield.Yield _Yield = new cFinancialTools.Yield.Yield();

            _MNemonicsMask = currentRow["MNemonicsMask"].ToString();
            _DocumentNumber = int.Parse(currentRow["DocumentNumber"].ToString());
            _OperationNumber = int.Parse(currentRow["OperationNumber"].ToString());
            _ID = int.Parse(currentRow["OperationID"].ToString());
            _FlagSerie = currentRow["DevelonmentTable"].Equals("S");
            _MNnemonicsID = int.Parse(currentRow["MNemonicsCode"].ToString());
            _Currency = int.Parse(currentRow["CurrencyIssueID"].ToString());
            _PaymentDate = DateTime.Parse(currentRow["PaymentDate"].ToString());

            _YieldName = GetCurve(_Currency);

            _Yield = mYieldList.Read(_YieldName);

            if (_FlagSerie)
            {
                _MNemonicsKey = _MNemonicsMask;
            }
            else
            {
                _MNemonicsKey = _DocumentNumber.ToString() + "." + _ID;
            }

            if (_OperationNumber.Equals(68254) && _ID.Equals(10))
            {
                _OperationNumber = 68254;
            }


            _MNemonics = mMnemonicsList.Read(_MNemonicsKey);

            _MNemonics.Nominal = double.Parse(currentRow["Nominal"].ToString());
            _MNemonics.PurchaseDate = DateTime.Parse(currentRow["PurchaseDate"].ToString());
            _MNemonics.PurchaseRate = double.Parse(currentRow["PurchaseRate"].ToString());
            _MNemonics.StartingDate = DateTime.Parse(currentRow["IssueDate"].ToString());
            _MNemonics.ExpiryDate = DateTime.Parse(currentRow["ExpiryDate"].ToString());

            if (_PaymentDate > dateValuator && mPortFolioDateToday.Equals(dateValuator))
            {
                _ValuatorDate = _PaymentDate;
            }
            else
            {
                _ValuatorDate = dateValuator;
            }

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

                case 20:        // LCHR
                    _MNemonics.Mnemonics = currentRow["MNemonics"].ToString();

                    MnemonicsSource _MnemonicsSource = new MnemonicsSource();
                    ArrayList _CouponList = new ArrayList();
                    DevelonmentTable _DevelonmentTable = new DevelonmentTable();
                    DateTime _Date;
                    int _Cuopons;

                    _MnemonicsSource = _MNemonics.Read(enumSource.System);
                    _CouponList = _MnemonicsSource.ReadAll();
                    _Date = new DateTime(_MNemonics.StartingDate.Year, _MNemonics.StartingDate.Month, _MNemonics.StartingDate.Day);

                    for (_Cuopons = 0; _Cuopons < _CouponList.Count; _Cuopons++)
                    {
                        _DevelonmentTable = (DevelonmentTable)_CouponList[_Cuopons];

                        _Date = _Date.AddMonths(_MNemonics.ExpiryCouponPeriod);

                        _DevelonmentTable.ExpiryDate = _Date;
                        _CouponList[_Cuopons] = _DevelonmentTable;

                    }

                    _MnemonicsSource.Item(_CouponList);
                    _MNemonics.Item(enumSource.System, _MnemonicsSource);

                    LettersOfCreditMortgage _LettersOfCreditMortgage = new LettersOfCreditMortgage(enumSource.System, _valuatorFixingRate, _ValuatorDate, dateYield, dateCurrency, 2, _MNemonics, mCurrencyList, _Yield);

                    _LettersOfCreditMortgage.ValuatorLettersOfCreditMortgage();

                    _MNemonics = _LettersOfCreditMortgage.MNemonics;

                    break;


                case 888:       // BR
                case 890:       // BE
                case 891:       // BD
                case 892:       // BF
                case 889:       // CBR
                    RecognitionBonds _RecognitionBonds = new RecognitionBonds(enumSource.System, _valuatorFixingRate, _ValuatorDate, dateYield, dateCurrency, 2, _MNemonics, mCurrencyList, _Yield);

                    _RecognitionBonds.ValuatorRecognitionBonds();

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

        #endregion

        #region "Inicialización de Variables"

        private void Set()
        {

            mPortFolioDate = new DateTime();                        // Fecha de Carga de la Cartera

            mPortFolioDateYesterday = new DateTime();               // Fecha de la Cartera t(-1)
            mPortFolioDateToday = new DateTime();                   // Fecha de la Cartera t(0)
            mPortFolioDateTomorrow = new DateTime();                // Fecha de la Cartera t(1)
            mPortFolioEndofMonth = new DateTime();
            mPortFolioPreviousEndOfMonth = new DateTime();

            mYieldDateRateYesterday = new DateTime();               // Fecha de la carga de las Tasa de Mercado en t(-1)
            mYieldDateRateToday = new DateTime();                   // Fecha de la carga de las Tasa de Mercado en t(0)

            mCurrencyDateExchangeRateToday = new DateTime();        // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyDateExchangeRateYesterday = new DateTime();    // Fecha de la carga de los Tipos de Cambio en t(-1)
            
            mMnemonicsList = new MnemonicsList();                   // Lista de Instrumentos Utilizados

            mPortFolioDataSet = new DataSet();                      // Tablas de la Cartera t(0) y t(-1).
            mCurrencyList = new CurrencyList ();                    // Lista de Tipos de Cambios
            mYieldList = new YieldList();                           // Lista de Curvas
            mYieldArray = new ArrayList();                          // Arreglo de Curvas utilizadas en la valorización

            mPresenteValue = 0;                                     // Valor Presente en t(0)

            mMarkToMarketValue = 0;                                 // Valor Mercado
            mMarkToMarketValueUM = 0;                               // Valor Mercado en UM

            mMarkToMarketTodayBAC = 0;                              // Valor Mercado en t(0) BAC
            mMarkToMarketYesterdayBAC = 0;                           // Valor Mercado en t(1) BAC

            mMarkToMarketToday = 0;                                 // Valor Mercado en t(0)
            mMarkToMarketTomorrow = 0;                              // Valor Mercado en t(1)
            mMarkToMarketTimeDecay = 0;                             // Valor Mercado en Cambio de Tiempo
            mMarkToMarketExchangeRate = 0;                          // Valor Mercado en Tipo de Cambio
            mMarkToMarketTodayUM = 0;                               // Valor Mercado en t(0) en UM
            mMarkToMarketTomorrowUM = 0;                            // Valor Mercado en t(1) en UM
            mMarkToMarketTimeDecayUM = 0;                           // Valor Mercado en Cambio de Tiempo en UM
            mMarkToMarketExchangeRateUM = 0;                        // Valor Mercado en Tipo de Cambio en UM

            mSensibilitiesValue = 0;                                // Valor de la Sensibilización
            mEstimationValue = 0;                                   // Valor de la Estimación
            mTimeDecayValue = 0;                                    // Valor por Paso del Tiempo
            mCashFlowValue = 0;                                     // Valor por Flujos de Caja
            mNewOperationValue = 0;                                 // Valor por Operaciones Nuevas
            mEffectExchangeRateValue = 0;                           // Valor por el Efecto de Tipo de Cambio
            mEffectRateValue = 0;                                   // Valor por el Efecto de Tasa
            mCashFlow = 0;

            mUserID = 0;
            mPortFolio = new PortFolio();
            mTPMRate = 0;

            mCalendar = new Calendars();                            // Calendario para la valorización
            mCalendar.Load();

        }

        #endregion

        #endregion

    }

}
