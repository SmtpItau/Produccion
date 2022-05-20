using System;
using System.Collections;
using System.Text;
using System.Data;
using cData.Instruments;
using cFinancialTools.Instruments;

namespace cFinancialTools.Instruments
{

    public class MnemonicsList
    {

        #region "Atributos privados"
        
        private Hashtable mList;
        private String mMessage;
        private String mStack;
        
        #endregion

        #region "Constructor"

        public MnemonicsList()
        {
            Set();
        }

        #endregion

        #region "Metodos Publicos"

        public enumStatus Status(int id)
        {
            return enumStatus.Already;
        }

        public enumStatus Status(int id, enumSource sourceID)
        {
            return enumStatus.Already;
        }

        public enumStatus Status(int id, enumSource sourceID, DateTime date)
        {
            return enumStatus.Already;
        }

        public String Message(int id)
        {
            return "";
        }

        public String Message(int id, enumSource sourceID)
        {
            return "";
        }

        public String Message(int id, enumSource sourceID, DateTime date)
        {
            return "";
        }

        public bool Load(String mnemonicsMask, enumSource sourceID, double nominal, DateTime purchaseDate, double purchaseRate)
        {

            cFinancialTools.Instruments.MNemonics _Mnemonics = new cFinancialTools.Instruments.MNemonics();
            MnemonicsSource _MnemonicsSource = new MnemonicsSource();

            bool _Status = false;

            try
            {

                if (!Find(mnemonicsMask))
                {
                    _Mnemonics = (cFinancialTools.Instruments.MNemonics)LoadMnemonics(mnemonicsMask, sourceID, nominal, purchaseDate, purchaseRate);
                    mList.Add(mnemonicsMask, _Mnemonics);
                }
                else
                {
                    _Mnemonics = Read(mnemonicsMask);
                }

                if (!_Mnemonics.Find(sourceID))
                {
                    _Mnemonics.Add(sourceID);
                    _Mnemonics.Item(sourceID, LoadMnemonicsDevelonmentTable(mnemonicsMask, sourceID));
                    mList[mnemonicsMask] = _Mnemonics;
                }

                return false;

            }
            catch (Exception Error)
            {
                mMessage = Error.Message;
                mStack = Error.StackTrace;
                _Status = false;
            }

            return _Status;

        }

        public bool Load(int documentNumber, int ID, enumSource sourceID, double nominal, DateTime purchaseDate, double purchaseRate)
        {

            cFinancialTools.Instruments.MNemonics _Mnemonics = new cFinancialTools.Instruments.MNemonics();
            MnemonicsSource _MnemonicsSource = new MnemonicsSource();
            String _ID = documentNumber.ToString() + "." + ID.ToString();
            bool _Status = false;

            try
            {

                if (!Find(_ID))
                {
                    _Mnemonics = (cFinancialTools.Instruments.MNemonics)LoadMnemonics(documentNumber, ID, sourceID, nominal, purchaseDate, purchaseRate);
                    mList.Add(_ID, _Mnemonics);
                }
                else
                {
                    _Mnemonics = Read(_ID);
                }

                return false;

            }
            catch (Exception Error)
            {
                mMessage = Error.Message;
                mStack = Error.StackTrace;
                _Status = false;
            }

            return _Status;

        }

        public bool Find(String mnemonicsMask)
        {
            MNemonics _MNemonics = new MNemonics();
            bool _Status = true;

            _MNemonics = (MNemonics)mList[mnemonicsMask];

            if (_MNemonics == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public cFinancialTools.Instruments.MNemonics Read(String mnemonics)
        {
            cFinancialTools.Instruments.MNemonics _Mnemonics = new cFinancialTools.Instruments.MNemonics();

            if (Find(mnemonics))
            {
                _Mnemonics = (cFinancialTools.Instruments.MNemonics)mList[mnemonics];
            }

            return _Mnemonics;
        }

        #endregion

        #region "Metodos privados"

        private cFinancialTools.Instruments.MNemonics LoadMnemonics(String mnemonicsMask, enumSource sourceID, double nominal, DateTime purchaseDate, double purchaseRate)
        {
            cData.Instruments.Mnemonics _LoadMNemonics = new cData.Instruments.Mnemonics(sourceID);
            DataTable _DataMNemonics = new DataTable();
            int _MnemonicsID;
            string _FamilyID;
            string _MnemonicsMask;
            string _Mnemonics;
            bool _FlagSerie;
            long _IssuerID;
            DateTime _StartingDate = new DateTime(1900,1,1);
            DateTime _ExpiryDate = new DateTime(1900, 1, 1);
            DateTime _PurchaseDate = purchaseDate;
            double _PurchaseRate = purchaseRate;
            double _Nominal = nominal;
            double _IssueRate;
            double _AnnualRateRealEffect;
            int _IssueCurrency;
            int _IssueBasis;
            int _RateEstimatedID;
            double _RateEstimated;
            bool _Flotanting;
            double _FlotatingRate;
            int _Coupons;
            int _AmortizationNumber;
            int _ExpiryCouponPeriod;
            string _ExpityCouponType;
            int _ExpiryCouponDay;
            int _Term;
            int _Decimals;

            _DataMNemonics = (DataTable)_LoadMNemonics.Load(mnemonicsMask);

            _MnemonicsID = int.Parse(_DataMNemonics.Rows[0]["Codigo"].ToString());
            _FamilyID = _DataMNemonics.Rows[0]["Familia"].ToString();
            _MnemonicsMask = _DataMNemonics.Rows[0]["Mascara"].ToString();
            _Mnemonics = _DataMNemonics.Rows[0]["Instrumento"].ToString();
            _FlagSerie = _DataMNemonics.Rows[0]["Seriado"].Equals("S");
            _IssuerID = long.Parse(_DataMNemonics.Rows[0]["RutEmisor"].ToString());
            if (!(_DataMNemonics.Rows[0]["FechaEmision"].ToString() == ""))
            {
                _StartingDate = DateTime.Parse(_DataMNemonics.Rows[0]["FechaEmision"].ToString());
            }
            if (!(_DataMNemonics.Rows[0]["FechaVencimiento"].ToString() == ""))
            {
                _ExpiryDate = DateTime.Parse(_DataMNemonics.Rows[0]["FechaVencimiento"].ToString());
            }
            _IssueRate = double.Parse(_DataMNemonics.Rows[0]["TasaEmision"].ToString());
            _AnnualRateRealEffect = double.Parse(_DataMNemonics.Rows[0]["TERA"].ToString());
            _IssueCurrency = int.Parse(_DataMNemonics.Rows[0]["MonedaEmision"].ToString());
            _IssueBasis = int.Parse(_DataMNemonics.Rows[0]["BaseEmision"].ToString());
            _RateEstimatedID = int.Parse(_DataMNemonics.Rows[0]["TasaEstimada"].ToString());
            _RateEstimated = 0;
            _Flotanting = false;
            _FlotatingRate = 0;
            _Coupons = int.Parse(_DataMNemonics.Rows[0]["NumeroCupones"].ToString());
            _AmortizationNumber = int.Parse(_DataMNemonics.Rows[0]["NumeroAmortizaciones"].ToString());
            _ExpiryCouponPeriod = int.Parse(_DataMNemonics.Rows[0]["PeriodoVencimientoCupon"].ToString());
            _ExpityCouponType = _DataMNemonics.Rows[0]["TipoVencimientoCupon"].ToString();
            _ExpiryCouponDay = int.Parse(_DataMNemonics.Rows[0]["DiasVencimientoCupon"].ToString());
            _Term = int.Parse(_DataMNemonics.Rows[0]["Plazo"].ToString());
            _Decimals = int.Parse(_DataMNemonics.Rows[0]["Decimales"].ToString());

            MNemonics _MNemonicsStruc;

            _MNemonicsStruc = new MNemonics(
                                             _MnemonicsID,
                                             _FamilyID,
                                             _MnemonicsMask,
                                             _Mnemonics,
                                             _FlagSerie,
                                             _IssuerID,
                                             _StartingDate,
                                             _ExpiryDate,
                                             _PurchaseDate,
                                             _PurchaseRate,
                                             _Nominal,
                                             _IssueRate,
                                             _AnnualRateRealEffect,
                                             _IssueCurrency,
                                             _IssueBasis,
                                             _RateEstimatedID,
                                             _RateEstimated,
                                             _Flotanting,
                                             _FlotatingRate,
                                             _Coupons,
                                             _AmortizationNumber,
                                             _ExpiryCouponPeriod,
                                             _ExpityCouponType,
                                             _ExpiryCouponDay,
                                             _Term,
                                             _Decimals
                                           );

            return _MNemonicsStruc;

        }

        private cFinancialTools.Instruments.MNemonics LoadMnemonics(int documentNumber, int ID, enumSource sourceID, double nominal, DateTime purchaseDate, double purchaseRate)
        {
            cData.Instruments.Mnemonics _LoadMNemonics = new cData.Instruments.Mnemonics(sourceID);
            DataTable _DataMNemonics = new DataTable();
            int _MnemonicsID;
            string _FamilyID;
            string _MnemonicsMask;
            string _Mnemonics;
            bool _FlagSerie;
            long _IssuerID;
            DateTime _StartingDate = new DateTime(1900, 1, 1);
            DateTime _ExpiryDate = new DateTime(1900, 1, 1);
            DateTime _PurchaseDate = purchaseDate;
            double _PurchaseRate = purchaseRate;
            double _Nominal = nominal;
            double _IssueRate;
            double _AnnualRateRealEffect;
            int _IssueCurrency;
            int _IssueBasis;
            int _RateEstimatedID;
            double _RateEstimated;
            bool _Flotanting;
            double _FlotatingRate;
            int _Coupons;
            int _AmortizationNumber;
            int _ExpiryCouponPeriod;
            string _ExpityCouponType;
            int _ExpiryCouponDay;
            int _Term;
            int _Decimals;

            _DataMNemonics = (DataTable)_LoadMNemonics.Load(documentNumber, ID);

            _MnemonicsID = int.Parse(_DataMNemonics.Rows[0]["Codigo"].ToString());
            _FamilyID = _DataMNemonics.Rows[0]["Familia"].ToString();
            _MnemonicsMask = _DataMNemonics.Rows[0]["Mascara"].ToString();
            _Mnemonics = _DataMNemonics.Rows[0]["Instrumento"].ToString();
            _FlagSerie = _DataMNemonics.Rows[0]["Seriado"].Equals("S");
            _IssuerID = long.Parse(_DataMNemonics.Rows[0]["RutEmisor"].ToString());
            if (!(_DataMNemonics.Rows[0]["FechaEmision"].ToString() == ""))
            {
                _StartingDate = DateTime.Parse(_DataMNemonics.Rows[0]["FechaEmision"].ToString());
            }
            if (!(_DataMNemonics.Rows[0]["FechaVencimiento"].ToString() == ""))
            {
                _ExpiryDate = DateTime.Parse(_DataMNemonics.Rows[0]["FechaVencimiento"].ToString());
            }
            _IssueRate = double.Parse(_DataMNemonics.Rows[0]["TasaEmision"].ToString());
            _AnnualRateRealEffect = double.Parse(_DataMNemonics.Rows[0]["TERA"].ToString());
            _IssueCurrency = int.Parse(_DataMNemonics.Rows[0]["MonedaEmision"].ToString());
            _IssueBasis = int.Parse(_DataMNemonics.Rows[0]["BaseEmision"].ToString());
            _RateEstimatedID = int.Parse(_DataMNemonics.Rows[0]["TasaEstimada"].ToString());
            _RateEstimated = 0;
            _Flotanting = false;
            _FlotatingRate = 0;
            _Coupons = int.Parse(_DataMNemonics.Rows[0]["NumeroCupones"].ToString());
            _AmortizationNumber = int.Parse(_DataMNemonics.Rows[0]["NumeroAmortizaciones"].ToString());
            _ExpiryCouponPeriod = int.Parse(_DataMNemonics.Rows[0]["PeriodoVencimientoCupon"].ToString());
            _ExpityCouponType = _DataMNemonics.Rows[0]["TipoVencimientoCupon"].ToString();
            _ExpiryCouponDay = int.Parse(_DataMNemonics.Rows[0]["DiasVencimientoCupon"].ToString());
            _Term = int.Parse(_DataMNemonics.Rows[0]["Plazo"].ToString());
            _Decimals = int.Parse(_DataMNemonics.Rows[0]["Decimales"].ToString());

            MNemonics _MNemonicsStruc;

            _MNemonicsStruc = new MNemonics(
                                             _MnemonicsID,
                                             _FamilyID,
                                             _MnemonicsMask,
                                             _Mnemonics,
                                             _FlagSerie,
                                             _IssuerID,
                                             _StartingDate,
                                             _ExpiryDate,
                                             _PurchaseDate,
                                             _PurchaseRate,
                                             _Nominal,
                                             _IssueRate,
                                             _AnnualRateRealEffect,
                                             _IssueCurrency,
                                             _IssueBasis,
                                             _RateEstimatedID,
                                             _RateEstimated,
                                             _Flotanting,
                                             _FlotatingRate,
                                             _Coupons,
                                             _AmortizationNumber,
                                             _ExpiryCouponPeriod,
                                             _ExpityCouponType,
                                             _ExpiryCouponDay,
                                             _Term,
                                             _Decimals
                                           );

            return _MNemonicsStruc;
        }

        private MnemonicsSource LoadMnemonicsDevelonmentTable(String mnemonicsMask, enumSource sourceID)
        {

            cFinancialTools.Instruments.DevelonmentTable _DevelonmentTable = new cFinancialTools.Instruments.DevelonmentTable();
            cData.Instruments.DevelonmentTable _LoadDevelonmentTable = new cData.Instruments.DevelonmentTable(sourceID);
            DataTable _DevelonmentTableData = new DataTable();
            MnemonicsSource _MnemonicsSource = new MnemonicsSource();

            int _Row;
            int _Coupon;
            DateTime _ExpiryDate = new DateTime(1900, 1, 1);
            double _Interest;
            double _Amortization;
            double _Flow;
            double _Balance;

            _DevelonmentTableData = _LoadDevelonmentTable.Load(mnemonicsMask);

            for (_Row = 0; _Row < _DevelonmentTableData.Rows.Count; _Row++)
            {
                _Coupon = int.Parse(_DevelonmentTableData.Rows[_Row]["NumeroCupon"].ToString());
                if (!(_DevelonmentTableData.Rows[_Row]["FechaVencimiento"].ToString() == ""))
                {
                    _ExpiryDate = DateTime.Parse(_DevelonmentTableData.Rows[_Row]["FechaVencimiento"].ToString());
                }
                _Interest = double.Parse(_DevelonmentTableData.Rows[_Row]["Interes"].ToString());
                _Amortization = double.Parse(_DevelonmentTableData.Rows[_Row]["Amortizacion"].ToString());
                _Flow = double.Parse(_DevelonmentTableData.Rows[_Row]["Flujo"].ToString());
                _Balance = double.Parse(_DevelonmentTableData.Rows[_Row]["SaldoResidual"].ToString());

                _DevelonmentTable = new DevelonmentTable(
                                                          _Coupon,
                                                          _ExpiryDate,
                                                          _Interest,
                                                          _Amortization,
                                                          _Flow,
                                                          _Balance,
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0
                                                        );

                _MnemonicsSource.Add(_DevelonmentTable);

            }

            return _MnemonicsSource;

        }

        private void Set()
        {
            mList = new Hashtable();
            mMessage = "";
            mStack = "";
        }

        #endregion

    }

}
