using System;
using System.Data;
using System.Collections;
using System.Text;

namespace cFinancialTools.Data
{

    public class SensibilitiesData
    {

        private DataSet mDataSet;

        public SensibilitiesData()
        {

            mDataSet = new DataSet();

        }

        ~SensibilitiesData()
        {

            mDataSet.Dispose();

        }

        public void Load()
        {

            mDataSet = new DataSet();

            cData.Parameters.TuringData _TuringData;

            _TuringData = new cData.Parameters.TuringData();

            mDataSet = _TuringData.Load();

            _TuringData = null;

        }

        public string Customer(int customerID, int customerCode)
        {

            DataTable _Customer;
            string _Value;
            DataRow[] _DataRow;
            string _Key;

            _Customer = mDataSet.Tables["Customer"];
            _Value = "NO DEFINIDO";

            if (!(_Customer == null))
            {
                _Key = "Rut = " + customerID.ToString() + " AND codigo = " + customerCode.ToString();
                _DataRow = _Customer.Select(_Key);

                if (_DataRow.Length > 0)
                {
                    _Value = _DataRow[0]["Nombre"].ToString().Trim();
                }

            }

            _Customer = null;

            return _Value;

        }

        public string Rate(int id)
        {

            DataTable _Rate;
            string _Value;
            DataRow[] _DataRow;
            string _Key;

            _Rate = mDataSet.Tables["Rate"];
            _Value = "NO DEFINIDO";

            if (!(_Rate == null))
            {
                _Key = "Codigo = " + id.ToString();
                _DataRow = _Rate.Select(_Key);

                if (_DataRow.Length > 0)
                {
                    _Value = _DataRow[0]["Descripcion"].ToString().Trim();
                }

            }

            _Rate = null;

            return _Value;

        }

        public string Currency(int id)
        {

            DataTable _Currency;
            string _Value;
            DataRow[] _DataRow;
            string _Key;

            _Currency = mDataSet.Tables["Currency"];
            _Value = "NO DEFINIDO";

            if (!(_Currency == null))
            {
                _Key = "Codigo = " + id.ToString();
                _DataRow = _Currency.Select(_Key);

                if (_DataRow.Length > 0)
                {
                    _Value = _DataRow[0]["Nemotecnico"].ToString().Trim();
                }

            }

            _Currency = null;

            return _Value;

        }

        public string Book(int id)
        {

            DataTable _Book;
            string _Value;
            DataRow[] _DataRow;
            string _Key;

            _Book = mDataSet.Tables["Book"];
            _Value = "NO DEFINIDO";

            if (!(_Book == null))
            {
                _Key = "Codigo = " + id.ToString();
                _DataRow = _Book.Select(_Key);

                if (_DataRow.Length > 0)
                {
                    _Value = _DataRow[0]["Descripcion"].ToString().Trim();
                }

            }

            _Book = null;

            return _Value;

        }

        public string PortFolioRules(string id)
        {

            DataTable _PortFolioRules;
            string _Value;
            DataRow[] _DataRow;
            string _Key;

            _PortFolioRules = mDataSet.Tables["PortFolioRules"];
            _Value = "NO DEFINIDO";

            if (!(_PortFolioRules == null))
            {
                _Key = "Codigo = '" + id + "'";
                _DataRow = _PortFolioRules.Select(_Key);

                if (_DataRow.Length > 0)
                {
                    _Value = _DataRow[0]["Descripcion"].ToString().Trim();
                }

            }

            _PortFolioRules = null;

            return _Value;

        }

        public string FinancialPortFolio(int id)
        {

            DataTable _FinancialPortFolio;
            string _Value;
            DataRow[] _DataRow;
            string _Key;

            _FinancialPortFolio = mDataSet.Tables["FinancialPortFolio"];
            _Value = "NO DEFINIDO";

            if (!(_FinancialPortFolio == null))
            {
                _Key = "Codigo = " + id.ToString();
                _DataRow = _FinancialPortFolio.Select(_Key);

                if (_DataRow.Length > 0)
                {
                    _Value = _DataRow[0]["Descripcion"].ToString().Trim();
                }

            }

            _FinancialPortFolio = null;

            return _Value;

        }

        public string Product(string system, string product)
        {

            string _Value;

            _Value = "NO DEFINIDO";

            switch (system)
            {
                case "BTR":

                    switch (product)
                    {
                        case "CP":
                            _Value = "COMPRA PROPIA";
                            break;
                        case "VP":
                            _Value = "VENTA DEFINITIVA";
                            break;
                        case "IN":
                            _Value = "INTERMEDIACION";
                            break;
                        default:
                            break;
                    }

                    break;

                case "PCS":
                    switch (product)
                    {
                        case "SM":
                            _Value = "SWAP MONEDA";
                            break;
                        case "ST":
                            _Value = "SWAP TASA";
                            break;
                        case "SP":
                            _Value = "SWAP PROMEDIO CAMARA";
                            break;
                        default:
                            break;
                    }

                    break;

                case "BFW":
                    switch (product)
                    {
                        case "1":
                            _Value = "SEGURO CAMBIO";
                            break;
                        case "2":
                            _Value = "ARBITRAJE";
                            break;
                        case "3":
                            _Value = "SEGURO INFLACION";
                            break;
                        case "10":
                            _Value = "FORWARD RENTA FIJA";
                            break;
                        case "13":
                            _Value = "FORWARD ANIDADOS";
                            break;
                        default:
                            break;
                    }

                    break;

                default:
                    break;
            }

            return _Value;

        }

        public string OperationType(string operationType)
        {
            string _Value;

            _Value = "NO DEFINIDO";

            switch (operationType)
            {
                case "C":
                    _Value = "COMPRA";
                    break;
                case "V":
                    _Value = "VENTA";
                    break;
                default:
                    break;
            }

            return _Value;
        }

        public string PaymentType(string operationType)
        {
            string _Value;

            _Value = "NO DEFINIDO";

            switch (operationType)
            {
                case "C":
                    _Value = "COMPENSACION";
                    break;
                case "E":
                    _Value = "ENTREGA FISICA";
                    break;
                default:
                    break;
            }

            return _Value;
        }

        public string UnWind(string operationType)
        {
            string _Value;

            _Value = "";

            switch (operationType.Trim())
            {
                case "A":
                    _Value = "SI";
                    break;
                default:
                    break;
            }

            return _Value;
        }

    }

}
