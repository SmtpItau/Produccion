using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using cFinancialTools.Struct;
using cFinancialTools.DayCounters;

namespace cFinancialTools.Swap
{

    public class SwapLeg: cFinancialTools.Flow.CashFlow
    {

        #region "Comentario"
        // Argumentos de la funcion
        //
        //   Datos para la generacion del calendario----------
        //
        // 1. fecha_transaccion
        // 2. tipo_intervalo:    1. dia
        //                       2. dia_habil
        //                       3. mes
        //                       4. año
        // 3  numero_intervalos
        // 4. rezago_partida (cantidad de dias habiles a desplazar  a partir de la fecha de transaccion para determinar la fecha efectiva)
        // 5. tipo_intervalo_vencimiento:    5.1 dia
        //                                   5.2 dia_habil
        //                                   5.3. mes
        //                                   4. año
        // 6. numero_intervalos_vencimiento
        // 7. calendario_generacion
        // 8. convencion:                    8.1 Fin de Mes No Ajustado
        //                                   8.2. Fin de Mes - Previo
        //                                   8.3. Fin de Mes - Siguiente
        //                                   8.4. No ajustado
        //                                   8.5. Previo
        //                                   8.6. Siguiente
        //                                   8.7. Previo Modificado
        //                                   8.8. Siguiente modificado
        // 9.  flag_fijo_flotante:           9.1 fijo
        //                                   9.2 flotante
        // 10. fecha_inicial             (puede ser dada en forma explicita o determinada a partir de la fecha de transaccion mas el rezago_partida)
        // 11. fecha_vencimiento         (puede ser dada en forma explicita o determinada a partir de la fecha de inicio mas los intervalos al vencimiento)
        // 12. periodo_quebrado      :   12.1 inicial
        //                               12.2 final
        // 13. flag_backstarting     :   13.1 si
        //                           :   13.0 no
        // 14. calendario_pago           (feriados a considerar para el pago)
        // 15. calendario_fijacion       (feriados a considerar para la fijacion)
        // 16. referencia_pago       :   16.1 fecha_inicio
        //                           :   16.2 fecha_termino
        // 17. referencia_fijacion   :   17.1 fecha_inicio
        //                           :   17.2 fecha_termino
        // 18. regla_pago                (dias habiles respecto de la fecha determinada, como referencia_pago)
        // 19. regla_fijacion            (dias habiles respecto de la fecha determinada, como referencia_fijacion)
        //
        //   Datos para la generacion de tabla de desarrollo------
        //
        // 20. saldo_insoluto_primera_fecha_inicio
        // 21. tipo_tabla_desarrollo:    21.1. bullet
        //                               21.2. amortizacion_constante
        //                               21.3. cuota_fija (opcion habilitada solo si el flag_fijo_flotante==1, de lo cotrario avisar error de parametrizacion)
        // 22. intercambio_inicial_nocionales
        // 23. intercambios_intermedios_nocionales
        // 24. intercambio_final_nocionales
        // 25. flag_flujos_adicionales (debe solicitar ingreso de flujos y fechas de
        // pago, en casod e que se marque que si existen)

        // 26. saldo_insoluto_primera_fecha_inicio
        // 27. tipo_tabla_desarrollo
        // 28. intercambio_inicial_nocionales
        // 29. intercambios_intermedios_nocionales
        // 30. intercambio_final_nocionales

        // 31. tasa_fija_final
        // 32. tasa_fija_transferencia
        // 33. convencion_tasa_fija               :          1 Act/360
        //                                                   2 30/360
        //                                                   3 Act/365
        //                                                   4 Act/Act
        // 34. spread_flotante_final
        // 35. spread_flotante_transferencia
        // 36. convencion_spread_flotante         :           1 Act/360
        //                                                    2 30/360
        //                                                    3 Act/365
        //                                                    4 Act/Act
        #endregion

        #region "Variables"

        private double mBalanceResidualFirstStartDate;                // saldo_insoluto_primera_fecha_inicio
        private enumDevelopmentTableType mDevelopmentTableType;       // tipo tabla desarrollo
        private enumExchangeNotional mInitialExchangeNotional;        // intercambio inicial nocionales
        private enumExchangeNotional mIntermediateExchangeNotional;   // intercambios intermedios nocionales
        private enumExchangeNotional mExchangeNotionalEnd;            // intercambio final nocionales
        private double mFixedRateEnd;                                 // tasa fija final
        private double mTransferFixedRate;                            // tasa fija transferencia
        private enumBasis mBasisFixedRate;                            // convencion tasa fija
        private double mSpreadFlotanteEnd;                            // Spread Flotante Final
        private double mTransferSpreadFlotante;                       // spread flotante transferencia
        private enumBasis mBasisSpreadFlotante;                       // convencion spread flotante
        private double mAditionalsFlowValue;                          // flujos adicionales
        private DateTime mAditionalsFlowDate;                         // fechas flujos adicionales

        private DateTime mCourtDateCoupon;
        private int mCouponCurrent;                                   // Cupón Actual
        private enumFlagMartTOMarketFixingRate mFlagValuator;

        private ArrayList dataFlow = new ArrayList();

        #endregion

        #region "Constructores"

        public SwapLeg()
        {
            mAditionalsFlowDate = new DateTime(1900, 1, 1);
            mCourtDateCoupon = new DateTime(1900, 1, 1);
            dataFlow = new ArrayList();
            mFlagValuator = enumFlagMartTOMarketFixingRate.RateToday;
        }

        #endregion

        #region "Propiedades"

        public double BalanceResidualFirstStartDate
        {
            get
            {
                return mBalanceResidualFirstStartDate;
            }
            set
            {
                mBalanceResidualFirstStartDate = value;
            }
        }

        public enumDevelopmentTableType DevelopmentTableType
        {
            get
            {
                return mDevelopmentTableType;
            }
            set
            {
                mDevelopmentTableType = value;
            }
        }

        public enumExchangeNotional InitialExchangeNotional
        {
            get
            {
                return mInitialExchangeNotional;
            }
            set
            {
                mInitialExchangeNotional = value;
            }
        }

        public enumExchangeNotional IntermediateExchangeNotional
        {
            get
            {
                return mIntermediateExchangeNotional;
            }
            set
            {
                mIntermediateExchangeNotional = value;
            }
        }

        public enumExchangeNotional ExchangeNotionalEnd
        {
            get
            {
                return mExchangeNotionalEnd;
            }
            set
            {
                mExchangeNotionalEnd = value;
            }
        }

        public double FixedRateEnd
        {
            get
            {
                return mFixedRateEnd;
            }
            set
            {
                mFixedRateEnd = value;
            }
        }

        public double TransferFixedRate
        {
            get
            {
                return mTransferFixedRate;
            }
            set
            {
                mTransferFixedRate = value;
            }
        }

        public enumBasis BasisFixedRate
        {
            get
            {
                return mBasisFixedRate;
            }
            set
            {
                mBasisFixedRate = value;
            }
        }

        public double SpreadFlotanteEnd
        {
            get
            {
                return mSpreadFlotanteEnd;
            }
            set
            {
                mSpreadFlotanteEnd = value;
            }
        }

        public double TransferSpreadFlotante
        {
            get
            {
                return mTransferSpreadFlotante;
            }
            set
            {
                mTransferSpreadFlotante = value;
            }
        }

        public enumBasis BasisSpreadFlotante
        {
            get
            {
                return mBasisSpreadFlotante;
            }
            set
            {
                mBasisSpreadFlotante = value;
            }
        }

        public double AditionalsFlowValue
        {
            get
            {
                return mAditionalsFlowValue;
            }
            set
            {
                mAditionalsFlowValue = value;
            }
        }

        public DateTime AditionalsFlowDate
        {
            get
            {
                return mAditionalsFlowDate;
            }
            set
            {
                mAditionalsFlowDate = value;
            }
        }

        public int CouponCurrent
        {
            get
            {
                return mCouponCurrent;
            }
        }

        public DateTime CourtDateCoupon
        {
            get
            {
                return mCourtDateCoupon;
            }
            set
            {
                mCourtDateCoupon = value;
            }
        }

        public enumFlagMartTOMarketFixingRate FlagValuator
        {
            get
            {
                return mFlagValuator;
            }
            set
            {
                mFlagValuator = value;
            }
        }

        #endregion

        #region "Funciones Publicas"

        public override String ToString()
        {
            string _flow = "";
            int _flownumber = 0;
            StructDevelopmentTable _rowFlow;

            for (_flownumber = 0; _flownumber < dataFlow.Count; _flownumber++)
            {
                _rowFlow = (StructDevelopmentTable)dataFlow[_flownumber];
                _flow = _flow + 
                        _rowFlow.NumberFlow.ToString() + "," +
                        _rowFlow.StartingDate.ToString() + "," +
                        _rowFlow.ExpiryDate.ToString() + "," +
                        _rowFlow.PaymentDate.ToString() + "," +
                        _rowFlow.FixingDate.ToString() + "," +
                        _rowFlow.Term.ToString() + "," +
                        _rowFlow.TermBasis.ToString() + "," +
                        _rowFlow.Factor.ToString() + "," +
                        _rowFlow.Amortization.ToString() + "," +
                        _rowFlow.Interest.ToString() + "," +
                        _rowFlow.Flow.ToString() + "," +
                        _rowFlow.BalanceResidual.ToString() + "," +
                        _rowFlow.ExchangeNotional.ToString() + "," +
                        _rowFlow.FixedRateEnd.ToString() + "," +
                        _rowFlow.TransferFixedRate.ToString() + "," +
                        _rowFlow.SpreadFlotanteEnd.ToString() + "," +
                        _rowFlow.TransferSpreadFlotante.ToString() + "," +
                        _rowFlow.AditionalsFlowValue.ToString() + "," +
                        _rowFlow.AditionalsFlowDate.ToString() + ";";
                
                        
            }
            return _flow;
        }

        public bool FlowSwapLeg()
        {
            int _row;
            double _FixedRateEnd;
            double _TransferFixedRate;
            double _SpreadFlotanteEnd;
            double _TransferSpreadFlotante;
            StructDevelopmentTable _rowFlow;
            double _Amortizacion;
            double _factor;
            int _InitialRow;
            Basis _basis;

            // Generacion del calendario de acuerdo a la data enviada a esta funcion
            if ((FlagFixedFloating == enumFlagFixedFloating.Floating) && (mDevelopmentTableType == enumDevelopmentTableType.QuotaFixed))
            {
                return false;
            }

            CreatingFlows();

            // Determinacion de pre-view de tabla de desarrollo de acuerdo al tipo de tabla
            // Detereminacion de saldos insolutos y los intereses finales y de transferencia

            _FixedRateEnd = mFixedRateEnd;
            _TransferFixedRate = mTransferFixedRate;
            _SpreadFlotanteEnd = mSpreadFlotanteEnd;
            _TransferSpreadFlotante = mTransferSpreadFlotante;

            if (mDevelopmentTableType == enumDevelopmentTableType.QuotaFixed)
            {
                CalculateQuotaFixed(); // llamar a cuota_francesa
            }

            _Amortizacion = 0;
            _factor = (double)1 / (double)dataFlow.Count;

            for (_row = 0; _row < dataFlow.Count; _row++)
            {
                _rowFlow = (StructDevelopmentTable)dataFlow[_row];

                _basis = new Basis(mBasisFixedRate, _rowFlow.StartingDate, _rowFlow.ExpiryDate);
                _rowFlow.Term = _basis.Term;
                _rowFlow.TermBasis = _basis.TermBasis;

                switch (mDevelopmentTableType)
                {
                    case enumDevelopmentTableType.Bullet:
                        if (FlagFixedFloating == enumFlagFixedFloating.Fixed)
                        {
                            _rowFlow.BalanceResidual = mBalanceResidualFirstStartDate;
                            //_rowFlow.Interest = mBalanceResidualFirstStartDate * (1.0 + mFixedRateEnd * 0.01
                            _rowFlow.FixedRateEnd = mFixedRateEnd;
                            _rowFlow.TransferFixedRate = mTransferFixedRate;
                            _rowFlow.Interest = (mFixedRateEnd / 100) * _rowFlow.TermBasis * _rowFlow.BalanceResidual;
                        }
                        else if (FlagFixedFloating == enumFlagFixedFloating.Floating)
                        {
                            _rowFlow.BalanceResidual = mBalanceResidualFirstStartDate;
                            _rowFlow.SpreadFlotanteEnd = mSpreadFlotanteEnd;
                            _rowFlow.TransferSpreadFlotante = mTransferSpreadFlotante;
                        }
                        break;

                    case enumDevelopmentTableType.AmortizationConstant:
                        if (FlagFixedFloating == enumFlagFixedFloating.Fixed)
                        {
                            _rowFlow.Amortization = mBalanceResidualFirstStartDate * _factor;
                            _rowFlow.BalanceResidual = mBalanceResidualFirstStartDate - _Amortizacion;
                            _Amortizacion += _rowFlow.Amortization;
                            _rowFlow.FixedRateEnd = mFixedRateEnd;
                            _rowFlow.Interest = (mFixedRateEnd / 100) * _rowFlow.TermBasis * _rowFlow.BalanceResidual;
                            _rowFlow.TransferFixedRate = mTransferFixedRate;
                        }
                        else if (FlagFixedFloating == enumFlagFixedFloating.Floating)
                        {
                            _rowFlow.Amortization = mBalanceResidualFirstStartDate * _factor;
                            _rowFlow.BalanceResidual = mBalanceResidualFirstStartDate - _Amortizacion;
                            _Amortizacion += _rowFlow.Amortization;
                            _rowFlow.SpreadFlotanteEnd = mSpreadFlotanteEnd;
                            _rowFlow.TransferSpreadFlotante = mTransferSpreadFlotante;
                        }
                        break;

                    case enumDevelopmentTableType.QuotaFixed: //solo valido para tasas fijas
                        _rowFlow.FixedRateEnd = mFixedRateEnd;
                        _rowFlow.TransferFixedRate = mTransferFixedRate;
                        break;

                }

                _basis = new Basis(mBasisFixedRate, _rowFlow.StartingDate, _rowFlow.ExpiryDate);
                _rowFlow.Flow = _rowFlow.Amortization + _rowFlow.Interest;
                _rowFlow.Term = _basis.Term;
                _rowFlow.TermBasis = _basis.TermBasis;

                dataFlow[_row] = _rowFlow;

            }

            // Determinacion de las amortizaciones
            if (mDevelopmentTableType == enumDevelopmentTableType.Bullet)
            {
                mIntermediateExchangeNotional = 0;

                _row = dataFlow.Count-1;
                _rowFlow = (StructDevelopmentTable)dataFlow[_row];
                _rowFlow.Amortization = mBalanceResidualFirstStartDate;
                _rowFlow.Flow = _rowFlow.Amortization + _rowFlow.Interest;
                dataFlow[_row] = _rowFlow;
            }

            _InitialRow = 0;
            if (mInitialExchangeNotional == enumExchangeNotional.Yes)
            {
                _rowFlow = new StructDevelopmentTable(StartingDate, StartingDate, StartingDate, StartingDate);
                _rowFlow.ExchangeNotional = -mBalanceResidualFirstStartDate;
                addInitalFlow(_rowFlow);
                _InitialRow = 1;
            }

            if (mIntermediateExchangeNotional == enumExchangeNotional.Yes)
            {
                for (_row = _InitialRow; _row < dataFlow.Count - 1; _row++)
                {
                    _rowFlow = (StructDevelopmentTable)dataFlow[_row];

                    _rowFlow.ExchangeNotional = _rowFlow.Amortization;
                    dataFlow[_row] =  _rowFlow;
                }
            }

            if (mExchangeNotionalEnd == enumExchangeNotional.Yes)
            {
                _row = dataFlow.Count-1;
                _rowFlow = (StructDevelopmentTable)dataFlow[_row];

                _rowFlow.ExchangeNotional = _rowFlow.Amortization;
                dataFlow[_row] =  _rowFlow;
            }

            return true;
        }

        public void CreatingFlows()
        {

            //Dim DtFlowsRow As vbFinancialTools.dsBussine.DtFlowRow
            int _numberflow = 0;
            StructDevelopmentTable _rowflow;

            // Determinacion de la primera fecha de inicio-------------------------
            CheckStartingDate();
            CheckExpiryDate();

            // Generación de Calendario---------------------------------------------
            if (BrokenPeriod == enumBrokenPeriod.AtTheEnd)
            {
                CreatingFlowsTopBottom();
            }
            else if (BrokenPeriod == enumBrokenPeriod.AtHome)
            {
                CreatingFlowsBottomTop();
            }

            for (_numberflow = 0; _numberflow < dataFlow.Count; _numberflow++)
            {
                _rowflow = (StructDevelopmentTable)dataFlow[_numberflow];
                _rowflow.NumberFlow = _numberflow + 1;

                if (_rowflow.ExpiryDate <= ExpiryDate)
                {
                    mCouponCurrent = _numberflow;
                }

                dataFlow[_numberflow] = _rowflow;

            }

        }

        public int Count()
        {
            return dataFlow.Count;
        }

        public StructDevelopmentTable getFlow(int index)
        {
            return (StructDevelopmentTable)dataFlow[index];
        }

        public void setFlow(int index, StructDevelopmentTable rowFlow)
        {
            dataFlow[index] = rowFlow;
        }

        public void addInitalFlow(StructDevelopmentTable rowFlow)
        {
            ArrayList _dataFlow = new ArrayList();
            StructDevelopmentTable _rowFlow;
            int _row;

            _dataFlow = dataFlow;
            dataFlow = new ArrayList();

            dataFlow.Add(rowFlow);

            for (_row = 0; _row < _dataFlow.Count; _row++)
            {
                _rowFlow = (StructDevelopmentTable)_dataFlow[_row];
                dataFlow.Add(_rowFlow);
            }

        }

        public void add(StructDevelopmentTable rowFlow)
        {
            dataFlow.Add(rowFlow);
        }

        #endregion

        #region "Funciones Privadas"

        private void CalculateQuotaFixed()
        {
            int _row;
            StructDevelopmentTable _rowFlow;
            double _factor;
            double _sumfactor = 0;
            double _QuoteFrance;
            double _Amortization;
            Basis _basis;

            _factor = 1;
            for (_row = 0; _row < dataFlow.Count; _row++ )
            {
                _rowFlow = (StructDevelopmentTable)dataFlow[_row];

                _basis = new Basis(mBasisFixedRate, _rowFlow.StartingDate, _rowFlow.ExpiryDate);
                _rowFlow.Term = _basis.Term;
                _rowFlow.TermBasis = _basis.TermBasis;
                _factor = _factor / (1 + (mFixedRateEnd / 100) * _rowFlow.TermBasis);
                _rowFlow.Factor = _factor;
                dataFlow[_row] = _rowFlow;

                _sumfactor += _factor;
            }

            _QuoteFrance = mBalanceResidualFirstStartDate / _sumfactor;
            _Amortization = 0;

            for (_row = 0; _row < dataFlow.Count; _row++)
            {
                _rowFlow = (StructDevelopmentTable)dataFlow[_row];
                _rowFlow.BalanceResidual = mBalanceResidualFirstStartDate - _Amortization;
                _rowFlow.Interest = (mFixedRateEnd / 100) * _rowFlow.TermBasis * _rowFlow.BalanceResidual;
                _rowFlow.InterestTransfer = (mTransferFixedRate / 100) * _rowFlow.TermBasis * _rowFlow.BalanceResidual;
                _rowFlow.Flow = _QuoteFrance;
                _rowFlow.Amortization = _QuoteFrance - _rowFlow.Interest;
                _Amortization += _rowFlow.Amortization;

                dataFlow[_row] = _rowFlow;
            }

        }

        #endregion

        #region "Funciones protegidas"

        protected void AddFlow(
                        DateTime StartingDatevalue,
                        DateTime ExpiryDatevalue,
                        DateTime PaymentDatevalue,
                        DateTime FixingDatevalue
                      )
        {
            StructDevelopmentTable rowFlow = new StructDevelopmentTable(
                                                                         StartingDatevalue,
                                                                         ExpiryDatevalue,
                                                                         PaymentDatevalue,
                                                                         FixingDatevalue
                                                                       );
            dataFlow.Add(rowFlow);

        }

        protected void CreatingFlowsTopBottom()
        {
            int _flownumber;
            DateTime _startingdate;
            DateTime _expirydate;
            DateTime _paymentdate;
            DateTime _fixingdate;

            _flownumber = 1;

            _startingdate = StartingDate;
            _expirydate = StartingDate;

            while (this.DateNum(_expirydate) < this.DateNum(ExpiryDate))
            {

                _expirydate = MovesDate(StartingDate, IntervalType, _flownumber * IntervalNumber, Convention, 6, CreatingCalendar);
                _paymentdate = CalculatePaymentDate(_startingdate, _expirydate);
                _fixingdate = CalculateDateFixingRate(_startingdate, _expirydate);

                AddFlow(
                         _startingdate,
                         _expirydate,
                         _paymentdate,
                         _fixingdate
                       );

                _startingdate = _expirydate;

                _flownumber += 1;

            }

        }

        protected void CreatingFlowsBottomTop()
        {
            ArrayList _dataFlow = new ArrayList();
            int _flownumber;
            DateTime _startingdate;
            DateTime _expirydate;
            DateTime _paymentdate;
            DateTime _fixingdate;
            StructDevelopmentTable _rowFlow = new StructDevelopmentTable();

            _flownumber = 1;

            _expirydate = ExpiryDate;
            _startingdate = ExpiryDate;

            while (_startingdate > StartingDate)
            {

                _rowFlow = new StructDevelopmentTable();

                _startingdate = MovesDate(ExpiryDate, IntervalType, -_flownumber * IntervalNumber, Convention, 6, CreatingCalendar);
                _paymentdate = CalculatePaymentDate(_startingdate, _expirydate);
                _fixingdate = CalculateDateFixingRate(_startingdate, _expirydate);

                if (_startingdate < StartingDate)
                {
                    if (FlagBackstarting == enumFlagBackStarting.Not)
                    {
                        _startingdate = StartingDate;
                    }
                }

                _rowFlow.StartingDate = _startingdate;
                _rowFlow.ExpiryDate = _expirydate;
                _rowFlow.PaymentDate = _paymentdate;
                _rowFlow.FixingDate = _fixingdate;

                _dataFlow.Add(_rowFlow);

                _expirydate = _startingdate;

                _flownumber += 1;

            }

            for (_flownumber = (_dataFlow.Count - 1); _flownumber >= 0; _flownumber--)
            {
                _rowFlow = (StructDevelopmentTable)_dataFlow[_flownumber];
                AddFlow(
                         _rowFlow.StartingDate,
                         _rowFlow.ExpiryDate,
                         _rowFlow.PaymentDate,
                         _rowFlow.FixingDate
                         );

            }

        }

        #endregion

    }

}
