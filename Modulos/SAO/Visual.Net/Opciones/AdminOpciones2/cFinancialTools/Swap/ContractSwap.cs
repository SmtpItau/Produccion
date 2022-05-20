using System;
using System.Collections;
using System.Data;
using System.Text;
using cFinancialTools.Swap;
using cFinancialTools.Valuation;

namespace cFinancialTools.Swap
{

    public class ContractSwap
    {

        #region "Atributos Protegidos"

        private int mOperationNumber;
        private SwapValuation mAssetLeg;
        private double mAssetPresentValue;
        private SwapValuation mLiabilitiesLeg;
        private double mLiabilitiesPresentValue;

        #endregion

        #region "Constructores"

        public ContractSwap(cFinancialTools.BussineDate.Calendars calendars)
        {

            mOperationNumber = 0;
            mAssetLeg = new SwapValuation(calendars);
            mAssetPresentValue = 0;
            mLiabilitiesLeg = new SwapValuation(calendars);
            mLiabilitiesPresentValue = 0;

        }

        #endregion

        #region "Atributos Publicos"

        public int OperationNumber
        {
            get
            {
                return mOperationNumber;
            }
            set
            {
                mOperationNumber = value;
            }
        }

        public SwapValuation AssetLeg
        {
            get
            {
                return mAssetLeg;
            }
            set
            {
                mAssetLeg = value;
            }

        }

        public double AssetPresentValue
        {
            get
            {
                return mAssetPresentValue;
            }
            set
            {
                mAssetPresentValue = value;
            }
        }

        public SwapValuation LiabilitiesLeg
        {
            get
            {
                return mLiabilitiesLeg;
            }
            set
            {
                mLiabilitiesLeg = value;
            }
        }

        public double LiabilitiesPresentValue
        {
            get
            {
                return mLiabilitiesPresentValue;
            }
            set
            {
                mLiabilitiesPresentValue = value;
            }
        }

        public DataTable ToTable()
        {

            #region "Definición y seteo de Variables"

            DataTable _DateTableFlow;

            _DateTableFlow = new DataTable();

            _DateTableFlow = FlowTable();

            #endregion

            #region "Leg Asset"

            SaveDateFlow(_DateTableFlow, 1, AssetLeg);
            SaveDateFlow(_DateTableFlow, 2, LiabilitiesLeg);

            #endregion

            return _DateTableFlow;

        }

        #endregion

        #region "Construcción Tabla de Flujos"

        private void SaveDateFlow(DataTable dateTableFlow, int leg, SwapValuation swapValuation)
        {

            int _Row;
            DataRow _DataRowFlow;

            for (_Row = 0; _Row < swapValuation.Flow.Count(); _Row++)
            {

                _DataRowFlow = dateTableFlow.NewRow();

                _DataRowFlow["OperationNumber"] = mOperationNumber;
                _DataRowFlow["Leg"] = leg;
                _DataRowFlow["FixingDate"] = swapValuation.Flow.getFlow(_Row).FixingDate;
                _DataRowFlow["StartingDate"] = swapValuation.Flow.getFlow(_Row).StartingDate;
                _DataRowFlow["ExpiryDate"] = swapValuation.Flow.getFlow(_Row).ExpiryDate;
                _DataRowFlow["PaymentDate"] = swapValuation.Flow.getFlow(_Row).PaymentDate;
                _DataRowFlow["Balance"] = swapValuation.Flow.getFlow(_Row).BalanceResidual;
                _DataRowFlow["ExchangePrincipal"] = swapValuation.Flow.getFlow(_Row).ExchangeNotionalType.ToString();
                _DataRowFlow["PostPounding"] = swapValuation.Flow.getFlow(_Row).ExchangeInterestType.ToString();
                _DataRowFlow["RateStarting"] = swapValuation.Flow.getFlow(_Row).RateStarting;
                _DataRowFlow["FactorRateStarting"] = swapValuation.Flow.getFlow(_Row).FactorRateStarting;
                _DataRowFlow["RateExpiry"] = swapValuation.Flow.getFlow(_Row).RateExpiry;
                _DataRowFlow["FactorRateExpiry"] = swapValuation.Flow.getFlow(_Row).FactorRateExpiry;
                _DataRowFlow["FactorRate"] = swapValuation.Flow.getFlow(_Row).FactorRateFra;
                _DataRowFlow["Rate"] = swapValuation.Flow.getFlow(_Row).RateProject;
                _DataRowFlow["Spread"] = swapValuation.Flow.SpreadFlotanteEnd;
                _DataRowFlow["AmortizationFlow"] = swapValuation.Flow.getFlow(_Row).AmortizationFlow;
                _DataRowFlow["InterestFlow"] = swapValuation.Flow.getFlow(_Row).InterestFlow;
                _DataRowFlow["AditionalFlow"] = swapValuation.Flow.getFlow(_Row).AditionalsFlowValue;
                _DataRowFlow["TotalFlow"] = swapValuation.Flow.getFlow(_Row).FlowEnd;
                _DataRowFlow["RateDiscount"] = swapValuation.Flow.getFlow(_Row).RateDiscount; ;
                _DataRowFlow["WellFactor"] = swapValuation.Flow.getFlow(_Row).FactorDiscount;
                _DataRowFlow["PresentValueAmortization"] = swapValuation.Flow.getFlow(_Row).AmortizationEnd;
                _DataRowFlow["PresentValueInterest"] = swapValuation.Flow.getFlow(_Row).InterestEnd;
                _DataRowFlow["PresentValueAditionalFlow"] = swapValuation.Flow.getFlow(_Row).AditionalsFlow;
                _DataRowFlow["PresentValue"] = swapValuation.Flow.getFlow(_Row).PresentValueFlow;

                dateTableFlow.Rows.Add(_DataRowFlow);

            }

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

        #endregion

    }

}
