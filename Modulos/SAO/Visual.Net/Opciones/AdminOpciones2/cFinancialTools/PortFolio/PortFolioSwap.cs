using System;
using System.Collections;
using System.Text;
using System.Data;
using cFinancialTools.Yield;
using cFinancialTools.Swap;
using cFinancialTools.Struct;
using cFinancialTools.Valuation;
using cFinancialTools.Rate;
using cFinancialTools.Currency;
using cFinancialTools.BussineDate;

namespace cFinancialTools.PortFolio
{

    public class PortFolioSwap
    {

        #region "Constantes"

        private const string cPortFolioT0 = "PortFolioT0";
        private const string cPortFolioT1 = "PortFolioT1";
        private const string cSensibilitiesOperationData = "DatosOperacion";
        private const string cSensibilitiesOperationByYield = "OperacionesxCurva";
        private const string cSensibilitiesOperationByTerm = "OperacionesPorPlazo";
        private const string cSensibilitiesByYield = "SensibilidadxCurva";

        private const string cPortFolioTimeDecay = "PortFolioTimeDecay";
        private const string cPortFolioExchangeRate = "PortFolioExchangeRate";

        #endregion

        #region "Atributos Privados"

        private DateTime mPortFolioDate;                        // Fecha de Carga de la Cartera
        private int mPortFolioInvestment;                       // PortFolio de Inversión
        private Hashtable mConfigYield;

        private DateTime mPortFolioDateYesterday;               // Fecha de la Cartera t(-1)
        private DateTime mPortFolioDateToday;                   // Fecha de la Cartera t(0)
        private DateTime mPortFolioDateTomorrow;                // Fecha de la Cartera t(0)
        private DateTime mPortFolioEndofMonth;                  // Fecha de Fin de Mes
        private DateTime mPortFolioPreviousEndOfMonth;          // Fecha de Fin de Mes Previo

        private DateTime mYieldDateRateToday;                   // Fecha de la carga de las Tasa de Mercado en t(0)
        private DateTime mYieldDateRateYesterday;               // Fecha de la carga de las Tasa de Mercado en t(-1)

        private DateTime mCurrencyDateExchangeRateToday;        // Fecha de la carga de los Tipos de Cambio en t(0)
        private DateTime mCurrencyDateExchangeRateYesterday;    // Fecha de la carga de los Tipos de Cambio en t(-1)

        private ContractSwapList mContractSwapList;             // Lista de Contratos Swap

        private DataSet mPortFolioDataSet;                      // Tablas de la Cartera (t0 y t1).
        private RateList mRateList;                             // Lista y valores de Tasas
        private CurrencyList mCurrencyList;                     // Lista de Tipos de Cambios
        private YieldList mYieldList;                           // Lista de Curvas
        private ArrayList mYieldArray;                          // Arreglo de Curvas utilizadas en la valorización

        private double mPresenteValue;                          // Valor Presente

        private double mMarkToMarketValue;                      // Valor Mercado
        private double mMarkToMarketValueUM;                    // Valor Mercado en UM

        private double mMarkToMarketT0BAC;                      // Valor Mercado en t0 BAC
        private double mMarkToMarketT1BAC;                      // Valor Mercado en t1 BAC

        private double mMarkToMarketT0;                         // Valor Mercado en t0
        private double mMarkToMarketT1;                         // Valor Mercado en t1
        private double mMarkToMarketTimeDecay;                  // Valor Mercado en Cambio de Tiempo
        private double mMarkToMarketExchangeRate;               // Valor Mercado en Tipo de Cambio
        private double mMarkToMarketT0UM;                       // Valor Mercado en t0 en UM
        private double mMarkToMarketT1UM;                       // Valor Mercado en t1 en UM
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

        private int mUserID;
        private cFinancialTools.PortFolio.PortFolio mPortFolio;

        private Calendars mCalendar;

        #endregion

        #region "Constructores"

        public PortFolioSwap()
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
                LoadYield(mYieldDateRateToday);
                LoadYield(mYieldDateRateYesterday);
                LoadCurrency(mCurrencyDateExchangeRateToday);
                LoadCurrency(mCurrencyDateExchangeRateYesterday);
                LoadConfiguration();

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

        #region "PortFolio de Inversión"

        public int PortFolioInvestment
        {
            get
            {
                return mPortFolioInvestment;
            }
            set
            {
                mPortFolioInvestment = value;
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

        public double MarkToMarketT0BAC
        {
            get
            {
                return mMarkToMarketT0BAC;
            }
        }

        public double MarkToMarketT1BAC
        {
            get
            {
                return mMarkToMarketT1BAC;
            }
        }

        public double MarkToMarketT0
        {
            get
            {
                return mMarkToMarketT0;
            }
        }

        public double MarkToMarketT1
        {
            get
            {
                return mMarkToMarketT1;
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

        public double MarkToMarketT0UM
        {
            get
            {
                return mMarkToMarketT0UM;
            }
        }

        public double MarkToMarketT1UM
        {
            get
            {
                return mMarkToMarketT1UM;
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

            mUserID = portFolio.UserID;
            mPortFolio = portFolio;

            #endregion

            #region "Inicialización de Valores para la Cartera"

            SetYieldList();
            LoadYield(mYieldDateRateToday);
            LoadYield(mYieldDateRateYesterday);
            LoadCurrency(mCurrencyDateExchangeRateToday);
            LoadCurrency(mCurrencyDateExchangeRateYesterday);
            LoadConfiguration();

            #endregion

        }

        #endregion

        #region "Carga de Datos"

        public void Load()
        {

            DataSet _PortFolio;
            DataTable _PortFolioTO;

            _PortFolioTO = new DataTable();
            mPortFolioDataSet = new DataSet();

            _PortFolio = Load(mPortFolioDateToday);

            _PortFolioTO = _PortFolio.Tables["SwapPortFolio"];
            _PortFolioTO.TableName = cPortFolioT0;

            AddTableDataSet(cPortFolioT0, _PortFolioTO);

        }

        #endregion

        #region "Mark To Market"

        public void MarkToMarket()
        {

            DataTable _PortFolioTO = new DataTable();

            _PortFolioTO = mPortFolioDataSet.Tables[cPortFolioT0];

            _PortFolioTO = MarkToMarket(_PortFolioTO, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);

            AddTableDataSet(cPortFolioT0, _PortFolioTO);

        }

        #endregion

        #region "Calculo de la Sensibilidad"

        public void Sensibilities()
        {

            DataSet _SensibilitiesTables = new DataSet();
            DataTable _PortFolioTO = new DataTable();

            _SensibilitiesTables = SensibilitiesTables();

            _PortFolioTO = CopyTable("PortFolio", mPortFolioDataSet.Tables[cPortFolioT0]);
            _SensibilitiesTables.Tables.Add(_PortFolioTO);

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
            DataTable _PortFolioT0;
            DataTable _PortFolioFlow;
            DataTable _PortFolioT1;
            DataTable _PortFolioEstimation;
            DataTable _PortFolioTimeDecay;
            DataTable _ExchangeRate;
            DataTable _EffectRate;
            DataTable _FlowData;
            DataTable _PortFolioFlowAux;
            DataTable _PortFolioMTMYesterday;
            DataTable _PortFolioYesterday;
            DataSet _Sensibilities;
            DataRow _DataRow;
            DataRow _DataRowAux;
            DataRow _DataRowNew;
            int _OperaionNumber;
            int _Row;
            int _Column;
            int _RowPortFolio;

            DateTime _LoadPortFolioDate;
            BussineDate.BussineDate _ValidDate = new cFinancialTools.BussineDate.BussineDate(mPortFolioDateToday);

            #endregion

            #region "Inicialización de Variables"

            _PortFolio = new DataSet();
            _PortFolioT0 = new DataTable();
            _PortFolioFlow = new DataTable();
            _PortFolioT1 = new DataTable();
            _PortFolioTimeDecay = new DataTable();
            _ExchangeRate = new DataTable();
            _EffectRate = new DataTable();
            _PortFolioMTMYesterday = new DataTable();

            #endregion

            #region "Validación de Fin de Mes Especial"

            _LoadPortFolioDate = mPortFolioDateToday;

            if (mPortFolioDateToday.Equals(_ValidDate.EnfOfMonth))
            {
                _LoadPortFolioDate = mPortFolioDateYesterday;
                //mYieldDateRateYesterday = mPortFolioDateYesterday;
                //mCurrencyDateExchangeRateYesterday = mPortFolioDateYesterday;
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

            _PortFolio = Load(_LoadPortFolioDate);

            _PortFolioT0 = _PortFolio.Tables["SwapPortFolio"];
            _PortFolioT0.TableName = cPortFolioT0;

            _PortFolioFlow = _PortFolio.Tables["SwapFlow"];
            _FlowData = _PortFolio.Tables["FlowData"];
            _PortFolioMTMYesterday = _PortFolio.Tables["SwapMTMYesterday"];

            #endregion

            #region "Asigna Cartera 1 a Time Decay y Cambio de T/C"

            _PortFolioTimeDecay = CopyTable("TimeDecay", _PortFolioT0);
            _ExchangeRate = CopyTable("ExchangeRate", _PortFolioT0);
            _EffectRate = CopyTable("EffectRate", _PortFolioT0);

            #endregion

            #region "Carga Cartera 2"

            //_PortFolioT1 = Load(mPortFolioDateYesterday, mMarkToMarketDateTomorrow);
            _PortFolioT1 = CopyTable(cPortFolioT1, _PortFolioT0);
            //_PortFolioT1.TableName = cPortFolioT1;
            //LoadFlow(_PortFolioT1);

            #endregion

            #endregion

            #region "02.- Valorización y MTM de Cartera T0"

            #region "Mark To Market"

            _PortFolioT0 = MarkToMarket(_PortFolioT0, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);
            mMarkToMarketT0 = mMarkToMarketValue;
            mMarkToMarketT0UM = mMarkToMarketValueUM;

            #endregion

            #region "Generate Table Flow"

            _PortFolioFlow = FlowTable();

            for (_RowPortFolio = 0; _RowPortFolio < _PortFolioT0.Rows.Count; _RowPortFolio++)
            {

                _DataRow = _PortFolioT0.Rows[_RowPortFolio];

                _OperaionNumber = int.Parse(_DataRow["OperationNumber"].ToString());

                _PortFolioFlowAux = mContractSwapList.Read(_OperaionNumber).ToTable();

                for (_Row = 0; _Row < _PortFolioFlowAux.Rows.Count; _Row++)
                {

                    _DataRowAux = _PortFolioFlowAux.Rows[_Row];
                    _DataRowNew = _PortFolioFlow.NewRow();

                    for (_Column = 0; _Column < _PortFolioFlow.Columns.Count; _Column++)
                    {
                        _DataRowNew[_Column] = _DataRowAux[_Column];
                    }

                    _PortFolioFlow.Rows.Add(_DataRowNew);

                }

            }

            AddTableDataSet("SensibilitiesFlow", _PortFolioFlow);

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

            _PortFolioT1 = MarkToMarket(_PortFolioT1, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday); // mCurrencyDateExchangeRateYesterday

            mMarkToMarketT1 = mMarkToMarketValue;
            mMarkToMarketT1UM = mMarkToMarketValueUM;

            if (_PortFolioMTMYesterday.Rows.Count > 0)
            {
                _PortFolioYesterday = MTMYesterday(_PortFolioT0, _PortFolioMTMYesterday);
            }
            else
            {
                _PortFolioYesterday = CopyTable("PortFolioYesterday", _PortFolioT1);
            }

            AddTableDataSet("PortFolioYesterday", _PortFolioYesterday);

            #endregion

            #endregion

            #region "05.- Calculo del Valor Real"

            mBalanceReal = mMarkToMarketT1 - mMarkToMarketT0;

            #endregion

            #region "06.- Calculo de la Estimación"

            _PortFolioEstimation = CopyTable("PortFolio", _PortFolioT0);

            _Sensibilities = SensibilitiesTables();
            _Sensibilities.Merge(_PortFolioEstimation);

            _Sensibilities = Sensibilities(_Sensibilities, mPortFolioDateToday, mYieldDateRateToday, mCurrencyDateExchangeRateToday);

            AddTableDataSet(cSensibilitiesOperationData, _Sensibilities.Tables[cSensibilitiesOperationData]);
            AddTableDataSet(cSensibilitiesOperationByYield, _Sensibilities.Tables[cSensibilitiesOperationByYield]);
            AddTableDataSet(cSensibilitiesOperationByTerm, _Sensibilities.Tables[cSensibilitiesOperationByTerm]);
            AddTableDataSet(cSensibilitiesByYield, _Sensibilities.Tables[cSensibilitiesByYield]);

            #endregion

            #region "07.- Time Decay"

            _PortFolioTimeDecay = MarkToMarket(_PortFolioTimeDecay, mPortFolioDateToday, mYieldDateRateYesterday, mCurrencyDateExchangeRateYesterday);
            mMarkToMarketTimeDecay = mMarkToMarketValue;
            mMarkToMarketTimeDecayUM = mMarkToMarketValueUM;
            mTimeDecayValue = mMarkToMarketTimeDecay - mMarkToMarketT0;

            #endregion

            #region "08.- Operaciones Nuevas"

            mNewOperationValue = 0; // Falta contruir esta rutina

            #endregion

            #region "09.- Efecto Cambio / Reajuste"

            _ExchangeRate = MarkToMarket(_ExchangeRate, mPortFolioDateYesterday, mYieldDateRateYesterday, mCurrencyDateExchangeRateToday);
            mEffectExchangeRateValue = mMarkToMarketValue - mMarkToMarketT0;

            #endregion

            #region "10.- Efecto Tasa"

            _EffectRate = MarkToMarket(_EffectRate, mPortFolioDateYesterday, mYieldDateRateToday, mCurrencyDateExchangeRateYesterday);
            mEffectRateValue = mMarkToMarketValue - mMarkToMarketT0;

            #endregion

            #region "11.- Actualiza DataSet con Cartera T0 y T1"

            AddTableDataSet(cPortFolioT0, _PortFolioT0);
            AddTableDataSet(cPortFolioT1, _PortFolioT1);
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

            cData.PortFolio.PortFolioSwap _PortFolioSwap;
            int _Yield;
            string _YieldName;
            int _Currency;
            int _CurrencyID;
            enumSource _Source;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioSwap = new cData.PortFolio.PortFolioSwap(enumSource.System);

            #endregion

            #region "Grabar Cartera"

            mPortFolio.SaveLog(3);

            _PortFolioSwap.SavePortFolio(PortFolioDate, PortFolioDataSet);

            #endregion

            #region "Save Yield"

            for (_Yield = 0; _Yield < mYieldArray.Count; _Yield++)
            {
                _YieldName = (string)mYieldArray[_Yield];
                mYieldList.Save(_YieldName, mPortFolioDateToday, mYieldDateRateToday, mYieldDateRateYesterday);
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

        #region "Rutinas de Valorización privadas"

        private DataSet Load(DateTime portFolioDate)
        {

            #region "Definición de Variables a Utilizar"

            cData.PortFolio.PortFolioSwap _PortFolioSwap;
            DataSet _PortFolio;
            DataTable _PortFolioData;
            DataTable _PortFolioFlow;
            DataTable _FlowTable;
            DataTable _SwapMTMYesterday;

            #endregion

            #region "Inicialización de Variables"

            _PortFolioSwap = new cData.PortFolio.PortFolioSwap(enumSource.System);
            _PortFolio = new DataSet();
            _PortFolioData = new DataTable();
            _PortFolioFlow = new DataTable();

            #endregion

            #region "Carga de Cartera"

            _PortFolio = (DataSet)_PortFolioSwap.LoadPortFolio(portFolioDate);

            _PortFolioData = _PortFolio.Tables["SwapPortFolio"];
            _PortFolioFlow = _PortFolio.Tables["SwapFlow"];

            _FlowTable = FlowTable();

            _PortFolio.Merge(_FlowTable);

            _SwapMTMYesterday = (DataTable)_PortFolioSwap.LoadMTMYesterday(mPortFolioDateYesterday);

            _PortFolio.Merge(_SwapMTMYesterday);

            AddColumnPortFolio(_PortFolioData);

            #endregion

            #region "Carga Flujos"

            LoadFlow(_PortFolio);

            #endregion

            return _PortFolio;

        }

        private DataTable MarkToMarket(
                                        DataTable portFolioData,
                                        DateTime valuatorDate,
                                        DateTime yieldDate,
                                        DateTime exchangeRateDate
                                      )
        {

            #region "Variable utilizadas en la configuracion"

            int _Row;
            int _Column;
            DataRow _DataRow;
            DateTime _ExpiryDate;

            #endregion

            #region "Ciclo para recorrer la cartera"

            mMarkToMarketValue = 0;
            int _X = 0;

            for (_Row = 0; _Row < portFolioData.Rows.Count; _Row++)
            {

                #region "Rescata el Contrato"

                _DataRow = portFolioData.Rows[_Row];

                #endregion

                #region "Valoriza el Contrato a Mark to Market"

                if (int.Parse(_DataRow["OperationNumber"].ToString()).Equals(598))
                {
                    _X = 0;
                }

                _ExpiryDate = DateTime.Parse(_DataRow["ExpiryDate"].ToString());

                _DataRow = MarkToMarktContract(_DataRow, valuatorDate, yieldDate, exchangeRateDate);
                mMarkToMarketValue += double.Parse(_DataRow["ValuatorNetCLP"].ToString());

                if (_ExpiryDate <= valuatorDate)
                {

                    _DataRow["ValuatorNetCLP"] = 0;
                    mMarkToMarketValue += 0;

                }

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

        private DataTable FlowTable()
        {

            #region "Def Variable"

            DataTable _DataTable;
            DataColumn _DataColumn;

            #endregion

            #region "Init Variable"

            _DataTable = new DataTable();

            #endregion

            #region "Definición de Estructura"

            #region "Operation Number"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "OperationNumber";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Número Documento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Leg"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Leg";
            _DataColumn.DataType = Type.GetType("System.Int64");
            _DataColumn.Caption = "Pierna";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Fixing Date"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "FixingDate";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Fecha Fijación";
            _DataColumn.DefaultValue = new DateTime(1900, 1, 1);

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Starting Date"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "StartingDate";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Fecha Inicio";
            _DataColumn.DefaultValue = new DateTime(1900, 1, 1);

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Expiry Date"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ExpiryDate";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Fecha Termino";
            _DataColumn.DefaultValue = new DateTime(1900, 1, 1);

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Payment Date"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PaymentDate";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Fecha Pago";
            _DataColumn.DefaultValue = new DateTime(1900, 1, 1);

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Balance"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Balance";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Saldo Insoluto";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Exchange Principal"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ExchangePrincipal";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Intercambio de Principal";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "PostPounding"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PostPounding";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "PostPounding";
            _DataColumn.DefaultValue = "";

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Rate Starting"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "RateStarting";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Inicio";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Factor Rate Starting"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "FactorRateStarting";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Inicio";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Rate Expiry"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "RateExpiry";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Vencimiento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Factor Rate Expiry"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "FactorRateExpiry";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Vencimiento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Factor Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "FactorRate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa Vencimiento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Rate"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Rate";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Spread"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "Spread";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Spread";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Amortization Flow"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "AmortizationFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Flujo Amortización";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Interest Flow"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "InterestFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Flujo de Interes";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Aditional Flow"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "AditionalFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Flujo Adicional";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Total Flow"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "TotalFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Flujo Total";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "RateDiscount"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "RateDiscount";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Tasa de Descuento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "WellFactor"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "WellFactor";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Factor de Descuento";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Amortization (Present Value)"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PresentValueAmortization";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Interest (Present Value)"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PresentValueInterest";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Aditional Flow (Present Value)"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PresentValueAditionalFlow";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #region "Present Value"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "PresentValue";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Presente";
            _DataColumn.DefaultValue = 0;

            _DataTable.Columns.Add(_DataColumn);

            #endregion

            #endregion

            #region "Setting Table Name"

            _DataTable.TableName = "SensibilitiesFlow";

            #endregion

            return _DataTable;

        }

        private DataRow MarkToMarktContract(
                                             DataRow dataRow,
                                             DateTime valuatorDate,
                                             DateTime yieldDate,
                                             DateTime exchangeRateDate
                                           )
        {

            #region "Variable utilizadas en la configuracion"

            int _OperationNumber;
            ContractSwap _ContractSwap;
            SwapValuation _AssetLeg;
            SwapValuation _LiabilitiesLeg;
            int _Currency;
            double _ExchangeRateAsset;
            double _ExchangeRateLiabilities;

            #endregion

            #region "Inicializa Variables"

            _ContractSwap = new ContractSwap(mCalendar);
            _AssetLeg = new SwapValuation(mCalendar);
            _LiabilitiesLeg = new SwapValuation(mCalendar);

            #endregion

            #region "Recupera Número de Operación"

            _OperationNumber = int.Parse(dataRow["OperationNumber"].ToString());

            #endregion

            #region "Recupera contrato"

            _ContractSwap = mContractSwapList.Read(_OperationNumber);

            #endregion

            #region "Valorización Pierna Activa"

            _AssetLeg = _ContractSwap.AssetLeg;

            if (mPortFolioDateToday.Equals(valuatorDate))
            {
                _AssetLeg.Flow.FlagValuator = enumFlagMartTOMarketFixingRate.RateToday;
            }
            else if (!mPortFolio.IsBussineDays || mPortFolio.IsEndOfMonth)
            {
                _AssetLeg.Flow.FlagValuator = enumFlagMartTOMarketFixingRate.RateToday;
            }
            else
            {
                _AssetLeg.Flow.FlagValuator = enumFlagMartTOMarketFixingRate.RateYesterday;
            }

            //_AssetLeg.Valuation(PortFolioDate);
            _AssetLeg.Valuation(valuatorDate, yieldDate, exchangeRateDate);

            #endregion

            #region "Valorización Pierna Pasiva

            _LiabilitiesLeg = _ContractSwap.LiabilitiesLeg;

            if (mPortFolioDateToday.Equals(valuatorDate))
            {
                _LiabilitiesLeg.Flow.FlagValuator = enumFlagMartTOMarketFixingRate.RateToday;
            }
            else if (!mPortFolio.IsBussineDays || mPortFolio.IsEndOfMonth)
            {
                _LiabilitiesLeg.Flow.FlagValuator = enumFlagMartTOMarketFixingRate.RateToday;
            }
            else
            {
                _LiabilitiesLeg.Flow.FlagValuator = enumFlagMartTOMarketFixingRate.RateYesterday;
            }


            //_LiabilitiesLeg.Valuation(PortFolioDate);
            _LiabilitiesLeg.Valuation(valuatorDate, yieldDate, exchangeRateDate);

            #endregion

            #region "Tiempo de Valorización"

            dataRow["EvaluationTime"] = DateTime.Now.ToString("HH:mm:sss.fff");

            #endregion

            #region "Seteo de Valor Presente Pierna Activa"

            _Currency = int.Parse(dataRow["AssetCurrency"].ToString());

            switch (_Currency)
            {
                case 13:
                    _ExchangeRateAsset = mCurrencyList.Read(994).Read(enumSource.CurrencyValueAccount).Read(exchangeRateDate).ExchangeRate;
                    if (_ExchangeRateAsset.Equals(0))
                    {
                        _ExchangeRateAsset = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                    }
                    break;
                case 998:
                    _ExchangeRateAsset = mCurrencyList.Read(_Currency).Read(enumSource.System).Read(exchangeRateDate).ExchangeRate;
                    break;
                case 999:
                    _ExchangeRateAsset = 1.0;
                    break;
                default:
                    _ExchangeRateAsset = 0;
                    break;
            }

            dataRow["ValuatorAsset"] = _AssetLeg.PresentValue;
            dataRow["ValuatorAssetCLP"] = _AssetLeg.PresentValue * _ExchangeRateAsset;

            #endregion

            #region  "Seteo de Valor Presente Pierna Pasiva"

            _Currency = int.Parse(dataRow["LiabilitiesCurrency"].ToString());

            switch (_Currency)
            {
                case 13:
                    _ExchangeRateLiabilities = mCurrencyList.Read(994).Read(enumSource.CurrencyValueAccount).Read(exchangeRateDate).ExchangeRate;
                    if (_ExchangeRateLiabilities.Equals(0))
                    {
                        _ExchangeRateLiabilities = mCurrencyList.Read(994, enumSource.CurrencyValueAccount, mCurrencyDateExchangeRateYesterday).ExchangeRate;
                    }
                    break;
                case 998:
                    _ExchangeRateLiabilities = mCurrencyList.Read(_Currency).Read(enumSource.System).Read(exchangeRateDate).ExchangeRate;
                    break;
                case 999:
                    _ExchangeRateLiabilities = 1.0;
                    break;
                default:
                    _ExchangeRateLiabilities = 0;
                    break;
            }

            dataRow["ValuatorLiabilities"] = _LiabilitiesLeg.PresentValue;
            dataRow["ValuatorLiabilitiesCLP"] = _LiabilitiesLeg.PresentValue * _ExchangeRateLiabilities;

            #endregion

            #region "Seteo de Valor Presente Neto"

            dataRow["ValuatorNetCLP"] = (_AssetLeg.PresentValue * _ExchangeRateAsset) -
                                             (_LiabilitiesLeg.PresentValue * _ExchangeRateLiabilities);

            if (dataRow["StatusOperation"].ToString().Equals("N"))
            {
                dataRow["CashFlow"] = dataRow["CashFlowUnwind"];
            }
            else
            {
                dataRow["CashFlow"] = (_AssetLeg.CashFlow * _ExchangeRateAsset) -
                                      (_LiabilitiesLeg.CashFlow * _ExchangeRateLiabilities);
            }

            dataRow["CourtDateCouponAsset"] = _AssetLeg.Flow.CourtDateCoupon;
            dataRow["CourtDateCouponLiabilities"] = _LiabilitiesLeg.Flow.CourtDateCoupon;

            #endregion

            return dataRow;

        }

        private DataSet Sensibilities(
                                       DataSet sensibilitiesData,
                                       DateTime valuatorDate,
                                       DateTime yieldDate,
                                       DateTime exchangeRateDate
                                     )
        {

            #region "Definición de Variables"

            DataTable _SensibilitiesOperation;
            DataTable _SensibilitiesOperationByYield;
            DataTable _SensibilitiesOperationByTerm;
            DataTable _SensibilitiesByYield;
            DataTable _PortFolioTO;
            DataTable _PortFolioOriginal;

            string _YieldName;

            cFinancialTools.Yield.Yield _Yield;
            YieldSource _YieldSource;
            YieldValue _YieldValue;
            YieldPoint _YieldPoint;

            int _Point;
            int _Term;
            int _Row;

            DataRow _DataRow;

            DataRow _CurrentOperationByTerm;

            int _OperationNumber;

            double _ValueSensibilities;
            double _ValueEstimation;
            double _ValuatorSensibilities;
            double _ValuatorMarkToMarket;
            double _RateMarkToMarketT0;
            double _RateMarkToMarketT1;
            double _DeltaSensibilidad;
            int _YieldID;

            string _YieldNameProjectLeg1;
            string _YieldNameDiscountLeg1;
            string _YieldNameProjectLeg2;
            string _YieldNameDiscountLeg2;

            #endregion

            #region "Inicialización de Variables"

            _SensibilitiesOperation = new DataTable();
            _SensibilitiesOperationByYield = new DataTable();
            _SensibilitiesOperationByTerm = new DataTable();
            _SensibilitiesByYield = new DataTable();
            _PortFolioTO = new DataTable();
            _PortFolioOriginal = new DataTable();

            _YieldName = "";
            _YieldID = 0;


            _Yield = new cFinancialTools.Yield.Yield();
            _YieldSource = new YieldSource();
            _YieldValue = new YieldValue();
            _YieldPoint = new YieldPoint();

            _Point = 0;
            _Row = 0;
            _Term = 0;

            #endregion

            #region "Seteo de Tablas"

            _SensibilitiesOperation = sensibilitiesData.Tables[cSensibilitiesOperationData];
            _SensibilitiesOperationByTerm = sensibilitiesData.Tables[cSensibilitiesOperationByTerm];
            _SensibilitiesByYield = sensibilitiesData.Tables[cSensibilitiesByYield];
            _PortFolioTO = sensibilitiesData.Tables["PortFolio"];
            _PortFolioOriginal = CopyTable("PortFolioOriginal", _PortFolioTO);

            #endregion

            #region "Seteo de Curvas"

            SetYieldRateType(enumRate.RateOriginalSpread, yieldDate);

            #endregion

            #region "Valorización a Tasa de Mercado"

            int _YieldCount = 0;

            for (_YieldCount = 0; _YieldCount < mYieldArray.Count; _YieldCount++)
            {
                _YieldName = (string)mYieldArray[_YieldCount];

                _Yield = mYieldList.Read(_YieldName);

                #region "Inicializa Variables de Curva"

                _YieldSource = new YieldSource();
                _YieldValue = new YieldValue();

                #endregion

                #region "Asigna Tasa Base"

                _YieldSource = _Yield.Read(enumSource.System);
                _YieldValue = _YieldSource.Read(mYieldDateRateToday);

                #endregion
                
                for (_Point = 0; _Point < _Yield.Read(enumSource.System).Read(yieldDate).Count; _Point++)
                {

                    #region "Suma 1BPS a al punto actual"

                    _YieldPoint = new YieldPoint();
                    _YieldPoint = _YieldValue.Point(_Point);
                    _YieldPoint.Spread = 0.01;
                    _Term = _YieldPoint.Term;

                    #endregion

                    #region "Recupera Tasas de Mercado"

                    _RateMarkToMarketT0 = _Yield.Read(enumSource.System).Read(mYieldDateRateToday).Point(_Point).Rate;
                    _RateMarkToMarketT1 = _Yield.Read(enumSource.System).Read(mYieldDateRateYesterday).Read(_Term).Rate;

                    #endregion

                    for (_Row = 0; _Row < _PortFolioTO.Rows.Count; _Row++)
                    {

                        #region "Rescata el Contrato"

                        _DataRow = _PortFolioTO.Rows[_Row];

                        #endregion

                        #region "Actualiza valores para la operación por plazo"

                        _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());
                        _YieldNameProjectLeg1 = _DataRow["SwapYieldAssetProject"].ToString();
                        _YieldNameDiscountLeg1 = _DataRow["SwapYieldAssetDiscount"].ToString();
                        _YieldNameProjectLeg2 = _DataRow["SwapYieldLiabilitiesProject"].ToString();
                        _YieldNameDiscountLeg2 = _DataRow["SwapYieldLiabilitiesDiscount"].ToString();

                        if (_OperationNumber.Equals(462))
                        {
                            _OperationNumber = 462;
                        }

                        #endregion

                        if (_YieldNameProjectLeg1.Equals(_YieldName) || _YieldNameDiscountLeg1.Equals(_YieldName) || _YieldNameProjectLeg2.Equals(_YieldName) || _YieldNameDiscountLeg2.Equals(_YieldName))
                        {

                            #region "Valoriza el Contrato a Mark to Market"

                            _DataRow = MarkToMarktContract(_DataRow, valuatorDate, yieldDate, exchangeRateDate);

                            #endregion

                            #region "Pierna Activo"

                            if (_YieldNameProjectLeg1.Equals(_YieldName) || _YieldNameDiscountLeg1.Equals(_YieldName))
                            {

                                _ValuatorMarkToMarket = double.Parse(_PortFolioOriginal.Rows[_Row]["ValuatorAssetCLP"].ToString());
                                _ValuatorSensibilities = double.Parse(_DataRow["ValuatorAssetCLP"].ToString());
                                _ValueSensibilities = _ValuatorSensibilities - _ValuatorMarkToMarket;
                                _DeltaSensibilidad = (_RateMarkToMarketT0 - _RateMarkToMarketT1) * 100.0;
                                _ValueEstimation = _ValueSensibilities * _DeltaSensibilidad;

                                _CurrentOperationByTerm = _SensibilitiesOperationByTerm.NewRow();

                                _CurrentOperationByTerm["OperationNumber"] = _OperationNumber;
                                _CurrentOperationByTerm["Leg"] = 1;
                                _CurrentOperationByTerm["YieldName"] = _YieldName;
                                _CurrentOperationByTerm["Term"] = _Term;
                                _CurrentOperationByTerm["MarkToMarketValue"] = _ValuatorMarkToMarket;
                                _CurrentOperationByTerm["SensibilitiesValue"] = _ValuatorSensibilities;
                                _CurrentOperationByTerm["Sensibilities"] = _ValueSensibilities;
                                _CurrentOperationByTerm["DeltaRate"] = _DeltaSensibilidad;
                                _CurrentOperationByTerm["Estimation"] = _ValueEstimation;

                                _SensibilitiesOperationByTerm.Rows.Add(_CurrentOperationByTerm);

                            }

                            #endregion

                            #region "Pierna Pasivo"

                            if (_YieldNameProjectLeg2.Equals(_YieldName) || _YieldNameDiscountLeg2.Equals(_YieldName))
                            {

                                _ValuatorMarkToMarket = double.Parse(_PortFolioOriginal.Rows[_Row]["ValuatorLiabilitiesCLP"].ToString());
                                _ValuatorSensibilities = double.Parse(_DataRow["ValuatorLiabilitiesCLP"].ToString());
                                _ValueSensibilities = _ValuatorSensibilities - _ValuatorMarkToMarket;
                                _DeltaSensibilidad = (_RateMarkToMarketT0 - _RateMarkToMarketT1) * 100.0;
                                _ValueEstimation = _ValueSensibilities * _DeltaSensibilidad;

                                _CurrentOperationByTerm = _SensibilitiesOperationByTerm.NewRow();

                                _CurrentOperationByTerm["OperationNumber"] = _OperationNumber;
                                _CurrentOperationByTerm["Leg"] = 2;
                                _CurrentOperationByTerm["YieldName"] = _YieldName;
                                _CurrentOperationByTerm["Term"] = _Term;
                                _CurrentOperationByTerm["MarkToMarketValue"] = -_ValuatorMarkToMarket;
                                _CurrentOperationByTerm["SensibilitiesValue"] = -_ValuatorSensibilities;
                                _CurrentOperationByTerm["Sensibilities"] = -_ValueSensibilities;
                                _CurrentOperationByTerm["DeltaRate"] = _DeltaSensibilidad;
                                _CurrentOperationByTerm["Estimation"] = -_ValueEstimation;

                                _SensibilitiesOperationByTerm.Rows.Add(_CurrentOperationByTerm);

                            }

                            #endregion

                        }

                    }

                    #region "Restable el valor original al punto actual"

                    _YieldPoint.Spread = 0.00;

                    #endregion

                }

            }

            #endregion

            #region "Genera Datos Curva"

            for (_YieldID = 0; _YieldID < mYieldArray.Count; _YieldID++)
            {
                _YieldName = (string)mYieldArray[_YieldID];

                _Yield = (cFinancialTools.Yield.Yield)mYieldList.Read(_YieldName);
                _YieldSource = _Yield.Read(enumSource.System);
                _YieldValue = _YieldSource.Read(yieldDate);

                for (_Point=0; _Point < _YieldValue.Count; _Point++)
                {

                    _YieldPoint = _YieldValue.Point(_Point);

                    _DataRow = _SensibilitiesByYield.NewRow();

                    _DataRow["YieldName"] = _Yield.ID;
                    _DataRow["Term"] = _YieldPoint.Term;

                    _SensibilitiesByYield.Rows.Add(_DataRow);

                }

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
                //sensibilitiesYield.Rows.Remove(_DataRow);
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
            _IssueCurrency = 0; // falta campo int.Parse(dataRow["IssueCurrency"].ToString());
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
                //sensibilitiesYield.Rows.Remove(_DataRow);
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

        private SwapValuation Valuator(DateTime valuatorDate, DateTime yieldDate, DateTime currencyDate, DataRow portFolioRow, SwapValuation swapValuation)
        {

            #region "Valorizador"

            swapValuation.Valuation(valuatorDate, yieldDate, currencyDate);

            #endregion

            return swapValuation;

        }

        #endregion

        #region "Agrega campos necesarios para la valorización en la tabla de Cartera"

        private DataTable AddColumnPortFolio(DataTable _PortFolioData)
        {

            #region "Definición Variable"

            DataColumn _DataColumn;

            #endregion

            #region "Curva para Proyeccion pierna Activa"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SwapYieldAssetProject";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Curva para Proyeccion pierna Activa";
            _DataColumn.DefaultValue = "";

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Curva de Descuento pierna Activa"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SwapYieldAssetDiscount";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Curva de Descuento pierna Activa";
            _DataColumn.DefaultValue = "";

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Curva para Proyeccion pierna Pasiva"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SwapYieldLiabilitiesProject";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Curva para Proyeccion pierna Pasiva";
            _DataColumn.DefaultValue = "";

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Curva para Descuento pierna Pasiva"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "SwapYieldLiabilitiesDiscount";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Curva para Descuento pierna Pasiva";
            _DataColumn.DefaultValue = "";

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Tiempo de Evaluación"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "EvaluationTime";
            _DataColumn.DataType = Type.GetType("System.String");
            _DataColumn.Caption = "Tiempo de Evaluación";
            _DataColumn.DefaultValue = "";

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Activo en UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorAsset";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Activo en UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Pasivo en UM"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorLiabilities";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Pasivo en UM";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Activo en CLP"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorAssetCLP";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Activo en CLP";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Valor Pasivo en CLP"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorLiabilitiesCLP";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Valor Pasivo en CLP";
            _DataColumn.DefaultValue = 0;

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

            #region "Corte de Cupon Activo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CourtDateCouponAsset";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Corte de Cupon Activo";
            _DataColumn.DefaultValue = DateTime.Now;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Corte de Cupon Pasivo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "CourtDateCouponLiabilities";
            _DataColumn.DataType = Type.GetType("System.DateTime");
            _DataColumn.Caption = "Corte de Cupon Pasivo";
            _DataColumn.DefaultValue = DateTime.Now;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Neto"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "ValuatorNetCLP";
            _DataColumn.DataType = Type.GetType("System.Double");
            _DataColumn.Caption = "Neto";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Plazo BenchMark Activo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "TermBenchmarkP1";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "Plazo BenchMark Activo";
            _DataColumn.DefaultValue = 0;

            _PortFolioData.Columns.Add(_DataColumn);

            #endregion

            #region "Plazo BenchMark Pasivo"

            _DataColumn = new DataColumn();
            _DataColumn.ColumnName = "TermBenchmarkP2";
            _DataColumn.DataType = Type.GetType("System.Int16");
            _DataColumn.Caption = "Plazo BenchMark Pasivo";
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

        #region "Carga de flujos del PortFolio"

        private void LoadFlow(DataSet portFolioData)
        {

            int _Row;
            DataRow _DataRow;
            int _RateTypeID;
            int _CurrencyPrimaryID;
            int _CurrencySecondaryID;
            string _YieldNameProjected;
            string _YieldnameDiscount;
            int _TermBenchmark;
            int _OperationNumber;
            DataTable _portFolio;
            DataTable _portFolioFlow;

            _portFolio = portFolioData.Tables["SwapPortFolio"];
            _portFolioFlow = portFolioData.Tables["SwapFlow"];

            for (_Row = 0; _Row < _portFolio.Rows.Count; _Row++)
            {

                _DataRow = _portFolio.Rows[_Row];

                _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());

                #region "Busca Curva Pierna 1"

                _RateTypeID = int.Parse(_DataRow["AssetRateID"].ToString());
                _CurrencyPrimaryID = int.Parse(_DataRow["AssetCurrency"].ToString());
                _CurrencySecondaryID = int.Parse(_DataRow["LiabilitiesCurrency"].ToString());
                _YieldNameProjected = "";
                _YieldnameDiscount = "";
                _TermBenchmark = 0;

                GetYield(_RateTypeID, _CurrencyPrimaryID, _CurrencySecondaryID, ref _YieldNameProjected, ref _YieldnameDiscount, ref _TermBenchmark);

                _DataRow["SwapYieldAssetProject"] = _YieldNameProjected;
                _DataRow["SwapYieldAssetDiscount"] = _YieldnameDiscount;
                _DataRow["TermBenchmarkP1"] = _TermBenchmark;

                mRateList.Load(
                                _RateTypeID, 
                                _CurrencyPrimaryID, 
                                enumPeriod.Anual, 
                                enumSource.System, 
                                mCurrencyDateExchangeRateYesterday, 
                                mCurrencyDateExchangeRateToday
                              );

                #endregion

                #region "Busca Curva Pierna 2"

                _RateTypeID = int.Parse(_DataRow["LiabilitiesRateID"].ToString());
                _CurrencyPrimaryID = int.Parse(_DataRow["LiabilitiesCurrency"].ToString());
                _CurrencySecondaryID = int.Parse(_DataRow["AssetCurrency"].ToString());
                _YieldNameProjected = "";
                _YieldnameDiscount = "";
                _TermBenchmark = 0;

                GetYield(_RateTypeID, _CurrencyPrimaryID, _CurrencySecondaryID, ref _YieldNameProjected, ref _YieldnameDiscount, ref _TermBenchmark);

                _DataRow["SwapYieldLiabilitiesProject"] = _YieldNameProjected;
                _DataRow["SwapYieldLiabilitiesDiscount"] = _YieldnameDiscount;
                _DataRow["TermBenchmarkP2"] = _TermBenchmark;

                mRateList.Load(
                                _RateTypeID, 
                                _CurrencyPrimaryID, 
                                enumPeriod.Anual, 
                                enumSource.System, 
                                mCurrencyDateExchangeRateYesterday, 
                                mCurrencyDateExchangeRateToday
                              );

                #endregion

                mContractSwapList.Load(mPortFolioDate, _DataRow, _portFolioFlow, mYieldList, mCurrencyList, mRateList);

            }

        }

        #endregion

        #region "Metodos para la Carga de Datos básicos"

        private void SetYieldList()
        {

            mYieldArray.Add("CURVASWAPCLP");
            mYieldArray.Add("CURVASWAPTABCLP");
            mYieldArray.Add("CURVASWAPUF");
            mYieldArray.Add("CURVASWAPUSD");
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

            mCurrencyList.Load(994, enumSource.CurrencyValueAccount, _DateCurrency, "CURVASWAPUSDLOCAL");
            mCurrencyList.Load(998, enumSource.System, _DateCurrency, "CURVASWAPUF");
            mCurrencyList.Load(999, enumSource.System, _DateCurrency, "CURVASWAPCLP");
            mCurrencyList.Load(13, enumSource.System, _DateCurrency, "CURVASWAPUSD");

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

        #region "Metodo que retona la Curva a utilizar por moneda"

        private void GetYield(
                               int rateTypeID,
                               int currencyPrimaryID,
                               int currencySecondaryID,
                               ref string yieldNameProjected,
                               ref string yieldnameDiscount,
                               ref int termBenchmark
                             )
        {
            string _Key;

            Hashtable _YieldConfiguration;

            _YieldConfiguration = new Hashtable();


            switch (rateTypeID)
            {
                case 8:
                case 9:
                case 10:
                case 15:
                    currencyPrimaryID = 0;
                    currencySecondaryID = 0;
                    break;

                case 13:
                    currencySecondaryID = 0;
                    break;

                case 0:
                    if (!currencyPrimaryID.Equals(13))
                    {
                        currencySecondaryID = 0;
                    }
                    else if (!(currencySecondaryID.Equals(998) || currencySecondaryID.Equals(999)))
                    {
                        currencySecondaryID = 0;
                    }
                    break;

                case 5:
                case 6:
                case 7:
                case 14:
                    if (!(currencySecondaryID.Equals(998) || currencySecondaryID.Equals(999)))
                    {
                        currencySecondaryID = 0;
                    }
                    break;

                default:
                    rateTypeID = -1;
                    currencyPrimaryID = 0;
                    currencySecondaryID = 0;
                    break;

            }

            if (!rateTypeID.Equals(-1))
            {

                _Key = rateTypeID.ToString("000") + currencyPrimaryID.ToString("000") + currencySecondaryID.ToString("000");

                _YieldConfiguration = (Hashtable)mConfigYield[_Key];

                yieldNameProjected = (string)_YieldConfiguration["CurveProjected"].ToString();
                yieldnameDiscount = (string)_YieldConfiguration["CurveDiscount"].ToString();
                termBenchmark = int.Parse(_YieldConfiguration["TermBenchmark"].ToString());
            }
            else
            {
                yieldNameProjected = "";
                yieldnameDiscount = "";
                termBenchmark = 0;
            }

            if (yieldNameProjected.Equals(""))
            {
                yieldNameProjected = "";
            }

            if (yieldnameDiscount.Equals(""))
            {
                yieldnameDiscount = "";
            }

        }

        #endregion

        #region "Carga de la configuración de las curvas"

        private void LoadConfiguration()
        {

            #region "Inicialización de Variables"

            mConfigYield = new Hashtable();

            #endregion

            #region "TASA FIJA"

            // Registro 1
            AddConfiguration(0, "TASA FIJA", 998, "UF", 0, "", "CURVASWAPUF", "", 0);

            // Registro 2
            AddConfiguration(0, "TASA FIJA", 999, "CLP", 0, "", "CURVASWAPCLP", "", 0);

            // Registro 3
            AddConfiguration(0, "TASA FIJA", 13, "CLP", 998, "UF", "CURVASWAPUSDLOCAL", "", 0);

            // Registro 4
            AddConfiguration(0, "TASA FIJA", 13, "CLP", 999, "CLP", "CURVASWAPUSDLOCAL", "", 0);

            // Registro 5
            AddConfiguration(0, "TASA FIJA", 13, "CLP", 0, "", "CURVASWAPUSD", "", 0);

            #endregion

            #region "TASA ICP"

            // Registro 6
            AddConfiguration(13, "TASA ICP", 998, "UF", 0, "", "CURVASWAPUF", "CURVASWAPUF", 0);

            // Registro 7
            AddConfiguration(13, "TASA ICP", 999, "CLP", 0, "", "CURVASWAPCLP", "CURVASWAPCLP", 0);

            #endregion

            #region "TASA LIBOR 30"

            // Registro 8
            AddConfiguration(5, "TASA LIBOR 30", 13, "USD", 998, "UF", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 30);

            // Registro 9
            AddConfiguration(5, "TASA LIBOR 30", 13, "USD", 999, "CLP", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 30);

            // Registro 10
            AddConfiguration(5, "TASA LIBOR 30", 13, "USD", 0, "", "CURVASWAPUSD", "CURVASWAPUSD", 30);

            #endregion

            #region "TASA LIBOR 90"

            // Registro 11
            AddConfiguration(6, "TASA LIBOR 90", 13, "USD", 998, "UF", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 90);

            // Registro 12
            AddConfiguration(6, "TASA LIBOR 90", 13, "USD", 999, "CLP", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 90);

            // Registro 13
            AddConfiguration(6, "TASA LIBOR 90", 13, "USD", 0, "", "CURVASWAPUSD", "CURVASWAPUSD", 90);

            #endregion

            #region "TASA LIBOR 180"

            // Registro 14
            AddConfiguration(7, "TASA LIBOR 180", 13, "USD", 998, "UF", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 180);

            // Registro 15
            AddConfiguration(7, "TASA LIBOR 180", 13, "USD", 999, "CLP", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 180);

            // Registro 16
            AddConfiguration(7, "TASA LIBOR 180", 13, "USD", 0, "", "CURVASWAPUSD", "CURVASWAPUSD", 180);

            #endregion

            #region "TASA LIBOR 360"

            // Registro 17
            AddConfiguration(14, "TASA LIBOR 360", 13, "USD", 998, "UF", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 360);

            // Registro 18
            AddConfiguration(14, "TASA LIBOR 360", 13, "USD", 999, "CLP", "CURVASWAPUSD", "CURVASWAPUSDLOCAL", 360);

            // Registro 19
            AddConfiguration(14, "TASA LIBOR 360", 13, "USD", 0, "", "CURVASWAPUSD", "CURVASWAPUSD", 360);

            #endregion

            #region "TASA TAB 30"

            // Registro 20
            AddConfiguration(9, "TASA TAB 30", 0, "", 0, "", "CURVASWAPTABCLP", "CURVASWAPCLP", 30);

            #endregion
            
            #region "TASA TAB 90"

            // Registro 20
            AddConfiguration(8, "TASA TAB 90", 0, "", 0, "", "CURVASWAPTABCLP", "CURVASWAPCLP", 90);

            #endregion

            #region "TASA TAB 180"

            // Registro 21
            AddConfiguration(10, "TASA TAB 180", 0, "", 0, "", "CURVASWAPTABCLP", "CURVASWAPCLP", 180);

            #endregion

            #region "TASA TAB 360"

            // Registro 22
            AddConfiguration(15, "TASA TAB 360", 0, "", 0, "", "CURVASWAPTABCLP", "CURVASWAPCLP", 360);

            #endregion

        }

        private void AddConfiguration(
                                       int tipoTasaID,
                                       string tipoTasa,
                                       int currencyPrimaryID,
                                       string currencyPrimary,
                                       int currencySecondaryID,
                                       string currencySecondary,
                                       string yieldNameProjected,
                                       string yieldnameDiscount,
                                       int termBenchmark
                                     )
        {

            string _Key;
            Hashtable _YieldConfiguration;

            _YieldConfiguration = new Hashtable();

            _Key = tipoTasaID.ToString("000") + currencyPrimaryID.ToString("000") + currencySecondaryID.ToString("000");

            _YieldConfiguration.Add("Key", _Key);
            _YieldConfiguration.Add("RateID", tipoTasaID);
            _YieldConfiguration.Add("Rate", tipoTasa);
            _YieldConfiguration.Add("CurrencyPrincipalID", currencyPrimaryID);
            _YieldConfiguration.Add("CurrencyPrincipal", currencyPrimary);
            _YieldConfiguration.Add("CurrencySecundaryID", currencySecondaryID);
            _YieldConfiguration.Add("CurrencySecundary", currencySecondary);
            _YieldConfiguration.Add("CurveProjected", yieldNameProjected);
            _YieldConfiguration.Add("CurveDiscount", yieldnameDiscount);
            _YieldConfiguration.Add("TermBenchmark", termBenchmark);

            mConfigYield.Add(_Key, _YieldConfiguration);


        }



        #endregion

        #region "Inicialización de Variables"

        private void Set()
        {

            mPortFolioDate = new DateTime();                                        // Fecha de Carga de la Cartera

            mConfigYield = new Hashtable();

            mPortFolioDateYesterday = new DateTime();                               // Fecha de la Cartera t(-1)
            mPortFolioDateToday = new DateTime();                                   // Fecha de la Cartera t(0)
            mPortFolioDateTomorrow = new DateTime();                                // Fecha de la Cartera t(1)
            mPortFolioEndofMonth = new DateTime();
            mPortFolioPreviousEndOfMonth = new DateTime();

            mYieldDateRateYesterday = new DateTime();                               // Fecha de la carga de las Tasa de Mercado en t(-1)
            mYieldDateRateToday = new DateTime();                                   // Fecha de la carga de las Tasa de Mercado en t(0)

            mCurrencyDateExchangeRateToday = new DateTime();                        // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyDateExchangeRateYesterday = new DateTime();                    // Fecha de la carga de los Tipos de Cambio en t(-1)

            mPortFolioDataSet = new DataSet();                                      // Tablas de la Cartera (t0 y t1).
            mRateList = new RateList();                                             // Lista de Tasas y sus valores
            mCurrencyList = new CurrencyList ();                                    // Lista de Tipos de Cambios
            mYieldList = new YieldList();                                           // Lista de Curvas
            mYieldArray = new ArrayList();                                          // Arreglo de Curvas utilizadas en la valorización

            mContractSwapList = new ContractSwapList();                             // Lista de Flujos y Piernas por contratos

            mPresenteValue = 0;                                                     // Valor Presente en t0

            mMarkToMarketValue = 0;                                                 // Valor Mercado
            mMarkToMarketValueUM = 0;                                               // Valor Mercado en UM

            mMarkToMarketT0BAC = 0;                                                 // Valor Mercado en t0 BAC
            mMarkToMarketT1BAC = 0;                                                 // Valor Mercado en t1 BAC

            mMarkToMarketT0 = 0;                                                    // Valor Mercado en t0
            mMarkToMarketT1 = 0;                                                    // Valor Mercado en t1
            mMarkToMarketTimeDecay = 0;                                             // Valor Mercado en Cambio de Tiempo
            mMarkToMarketExchangeRate = 0;                                          // Valor Mercado en Tipo de Cambio
            mMarkToMarketT0UM = 0;                                                  // Valor Mercado en t0 en UM
            mMarkToMarketT1UM = 0;                                                  // Valor Mercado en t1 en UM
            mMarkToMarketTimeDecayUM = 0;                                           // Valor Mercado en Cambio de Tiempo en UM
            mMarkToMarketExchangeRateUM = 0;                                        // Valor Mercado en Tipo de Cambio en UM

            mBalanceReal = 0;
            mSensibilitiesValue = 0;                                                // Valor de la Sensibilización
            mEstimationValue = 0;                                                   // Valor de la Estimación
            mTimeDecayValue = 0;                                                    // Valor por Paso del Tiempo
            mCashFlowValue = 0;                                                     // Valor por Flujos de Caja
            mNewOperationValue = 0;                                                 // Valor por Operaciones Nuevas
            mEffectExchangeRateValue = 0;                                           // Valor por el Efecto de Tipo de Cambio
            mEffectRateValue = 0;                                                   // Valor por el Efecto de Tasa
            mCashFlow = 0;                                                          // Valor por Flujos de Caja

            mUserID = 0;
            mPortFolio = new PortFolio();

            mCalendar = new Calendars();                                            // Calendario para la valorización
            mCalendar.Load();

        }

        #endregion

        #region "MTM de Ayer del Portfolio"

        private DataTable MTMYesterday(DataTable portfoliodata, DataTable portfoliomtmyesterday)
        {

            DataTable _PortFolioYesterday;
            DataRow _DataRow;
            DataRow[] _DataRowsYesterday;
            int _Row;
            int _OperationNumber;
            double _MarktoMarketToday;
            double _MarktoMarketUMToday;
            double _FairValueAsset;
            double _FairValueAssetUM;
            double _FairValueLiabilities;
            double _FairValueLiabilitiesUM;
            double _FairValueNet;

            _PortFolioYesterday = CopyTable("PortFolioYesterday", portfoliodata);

            for (_Row = 0; _Row < _PortFolioYesterday.Rows.Count; _Row++)
            {

                _DataRow = _PortFolioYesterday.Rows[_Row];
                _OperationNumber = int.Parse(_DataRow["OperationNumber"].ToString());

                _DataRowsYesterday = portfoliomtmyesterday.Select("OperationNumber = " + _OperationNumber.ToString());

                _MarktoMarketToday = 0;
                _MarktoMarketUMToday = 0;
                _FairValueAsset = 0;
                _FairValueAssetUM = 0;
                _FairValueLiabilities = 0;
                _FairValueLiabilitiesUM = 0;
                _FairValueNet = 0;

                if (_DataRowsYesterday.Length > 0)
                {
                    _MarktoMarketToday = double.Parse(_DataRowsYesterday[0]["MarktoMarketToday"].ToString());
                    _MarktoMarketUMToday = double.Parse(_DataRowsYesterday[0]["MarktoMarketUMToday"].ToString());
                    _FairValueAsset = double.Parse(_DataRowsYesterday[0]["FairValueAsset"].ToString());
                    _FairValueAssetUM = double.Parse(_DataRowsYesterday[0]["FairValueAssetUM"].ToString());
                    _FairValueLiabilities = double.Parse(_DataRowsYesterday[0]["FairValueLiabilities"].ToString());
                    _FairValueLiabilitiesUM = double.Parse(_DataRowsYesterday[0]["FairValueLiabilitiesUM"].ToString());
                    _FairValueNet = double.Parse(_DataRowsYesterday[0]["FairValueNet"].ToString());
                }

                _DataRow["ValuatorAsset"] = _FairValueAssetUM;
                _DataRow["ValuatorAssetCLP"] = _FairValueAsset;
                _DataRow["ValuatorLiabilities"] = _FairValueLiabilitiesUM;
                _DataRow["ValuatorLiabilitiesCLP"] = _FairValueLiabilities;
                _DataRow["ValuatorNetCLP"] = _FairValueNet;
                _DataRow["CashFlow"] = 0;

            }

            return _PortFolioYesterday;

        }

        #endregion

        #endregion

    }

}
