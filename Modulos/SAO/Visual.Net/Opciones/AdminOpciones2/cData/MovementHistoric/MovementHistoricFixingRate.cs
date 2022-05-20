using System;
using System.Collections.Generic;
using System.Text;

namespace cData.MovementHistoric
{

    class MovementHistoricFixingRate
    {

        //#region "Atributos privados"

        //private enumStatus mStatus;
        //private enumSource mSource;
        //private String mError;
        //private String mStack;

        //#endregion

        //#region "Constructores"

        //public MovementHistoricFixingRate()
        //{
        //    Set(enumSource.System);
        //}

        //public MovementHistoricFixingRate(enumSource _ID)
        //{
        //    Set(_ID);
        //}

        //#endregion

        //#region "Atributos publicos"

        //public enumStatus Status
        //{
        //    get
        //    {
        //        return mStatus;
        //    }
        //}

        //public String Message
        //{
        //    get
        //    {
        //        return ReadMessage(mStatus);
        //    }
        //}

        //public String Error
        //{
        //    get
        //    {
        //        return mError;
        //    }
        //}

        //public String Stack
        //{
        //    get
        //    {
        //        return mStack;
        //    }
        //}
        
        //#endregion

        //#region "Metodos publicos"

        //public String ReadMessage(enumStatus status)
        //{
        //    String _Message;

        //    switch (status)
        //    {
        //        case enumStatus.Already:
        //            _Message = "El movimiento de Renta Fija se encuentra cargada.";
        //            break;
        //        case enumStatus.ErrorLoadValue:
        //            _Message = "Error en la cargar del Movimiento de Renta Fija.";
        //            break;
        //        case enumStatus.ErrorLoad:
        //            _Message = "Error en la cargar del Movimiento de Renta Fija.";
        //            break;
        //        case enumStatus.ErrorLoaded:
        //            _Message = "Error en la cargar del Movimiento de Renta Fija.";
        //            break;
        //        case enumStatus.Initialize:
        //            _Message = "La clase se encuentra en estado inicializada.";
        //            break;
        //        case enumStatus.Loaded:
        //            _Message = "Ya fue cargando.";
        //            break;
        //        case enumStatus.Loading:
        //            _Message = "Se esta cargando el Movimiento de Renta Fija.";
        //            break;
        //        case enumStatus.NotFound:
        //            _Message = "No se encontro el Movimiento de Renta Fija.";
        //            break;
        //        case enumStatus.NotFoundValue:
        //            _Message = "No se encontro el Movimiento de Renta Fija.";
        //            break;
        //        default:
        //            _Message = "Estado no definido";
        //            break;
        //    }
        //    return _Message;
        //}

        //public DataTable LoadMovementHistoric(DateTime portFolioDate, DateTime martkToMarketDate)
        //{
        //    DataTable _MovementFixingRate = new DataTable();

        //    switch (mSource)
        //    {
        //        case enumSource.System:
        //        case enumSource.CurrencyValueAccount:
        //            SourceSystem _System = new SourceSystem();

        //            _MovementFixingRate = _System.LoadMovementHistoric(portFolioDate, martkToMarketDate);
        //            mStatus = _System.Status;
        //            mError = _System.Error;
        //            mStack = _System.Stack;

        //            break;

        //        case enumSource.Bloomberg:
        //            SourceBloomberg _Bloomberg = new SourceBloomberg();

        //            _MovementFixingRate = _Bloomberg.LoadMovementHistoric(portFolioDate, martkToMarketDate);
        //            mStatus = _Bloomberg.Status;
        //            mError = _Bloomberg.Error;
        //            mStack = _Bloomberg.Stack;

        //            break;

        //        case enumSource.Excel:
        //            SourceExcel _Excel = new SourceExcel();

        //            _MovementFixingRate = _Excel.LoadMovementHistoric(portFolioDate, martkToMarketDate);
        //            mStatus = _Excel.Status;
        //            mError = _Excel.Error;
        //            mStack = _Excel.Stack;

        //            break;

        //        case enumSource.XML:
        //            SourceXML _XML = new SourceXML();

        //            _MovementFixingRate = _XML.LoadMovementHistoric(portFolioDate, martkToMarketDate);
        //            mStatus = _XML.Status;
        //            mError = _XML.Error;
        //            mStack = _XML.Stack;

        //            break;

        //        default:
        //            break;
        //    }

        //    return _MovementFixingRate;

        //}

        //#endregion

        //#region "Metodos privados"

        //protected void Set(enumSource id)
        //{
        //    mStatus = enumStatus.Initialize;
        //    mSource = id;
        //}

        //#endregion

        //#region "Clases para obtener la información"

        //#region "Clase Source"

        //private class Source
        //{

        //    private enumStatus mStatus;
        //    private String mError;
        //    private String mStack;

        //    public enumStatus Status
        //    {
        //        get
        //        {
        //            return mStatus;
        //        }
        //        set
        //        {
        //            mStatus = value;
        //        }
        //    }

        //    public String Error
        //    {
        //        get
        //        {
        //            return mError;
        //        }
        //        set
        //        {
        //            mError = value;
        //        }
        //    }

        //    public String Stack
        //    {
        //        get
        //        {
        //            return mStack;
        //        }
        //        set
        //        {
        //            mStack = value;
        //        }
        //    }

        //    public Source()
        //    {
        //        mStatus = enumStatus.Initialize;
        //        mError = "";
        //        mStack = "";
        //    }

        //    public virtual DataTable LoadMovementHistoric(DateTime portFolioDate, DateTime martkToMarketDate)
        //    {
        //        DataTable _MovementFixingRate = new DataTable();

        //        return _MovementFixingRate;
        //    }

        //}

        //#endregion

        //#region "Datos que se obtienen del Sistema"

        //private class SourceSystem : Source
        //{

        //    public override DataTable LoadMovementHistoric(DateTime portFolioDate)
        //    {

        //        String _QueryRate = "SELECT 'NumeroDocumento' = monumdocu " +
        //                            "     , 'Correlativo'     = mocorrela " +
        //                            "     , 'Nominal'         = SUM( CASE WHEN motipoper = 'CP' THEN monominal ELSE -monominal END ) " +
        //                            "     , 'Valor'           = SUM( CASE WHEN motipoper = 'CP' THEN movalcomp ELSE          0 END ) - " +
        //                                                      " SUM( CASE WHEN motipoper = 'VP' THEN movalven  ELSE          0 END ) " +
        //                            "  FROM dbo.mdmh " +
        //                            " WHERE mofecpro = '" + portFolioDate.ToString("yyyyMMdd") + "' " +
        //                            "   AND motipoper in ( 'CP', 'VP' ) " +
        //                            " GROUP BY " +
        //                            "       monumdocu " +
        //                            "     , mocorrela";
        //        cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACTRADERSUDA");
        //        DataTable _MovementFixingRate;

        //        try
        //        {
        //            // Definición de la Curva
        //            Status = enumStatus.Loading;
        //            _Connect.Execute(_QueryRate);
        //            _MovementFixingRate = _Connect.QueryDataTable();
        //            _MovementFixingRate.TableName = "FixingRateMovement";

        //            if (_MovementFixingRate.Rows.Count.Equals(0))
        //            {
        //                Status = enumStatus.NotFound;
        //            }
        //            else
        //            {
        //                Status = enumStatus.Already;
        //            }

        //        }
        //        catch (Exception _Error)
        //        {
        //            _MovementFixingRate = null;
        //            Status = enumStatus.ErrorLoad;
        //            Error = _Error.StackTrace;
        //            Stack = _Error.Message;
        //        }

        //        return _MovementFixingRate;
        //    }

        //}

        //#endregion

        //#region "Datos que se obtinen del Bloomberg"

        //private class SourceBloomberg : Source
        //{

        //    public override DataTable LoadMovementHistoric(DateTime portFolioDate, DateTime martkToMarketDate)
        //    {
        //        DataTable _MovementFixingRate = new DataTable();

        //        return _MovementFixingRate;
        //    }

        //}

        //#endregion

        //#region "Datos que se obtinen de Excel"

        //private class SourceExcel : Source
        //{

        //    public override DataTable LoadMovementHistoric(DateTime portFolioDate, DateTime martkToMarketDate)
        //    {
        //        DataTable _MovementFixingRate = new DataTable();

        //        return _MovementFixingRate;
        //    }

        //}

        //#endregion

        //#region "Datos que se obtinen de XML"

        //private class SourceXML : Source
        //{

        //    public override DataTable LoadMovementHistoric(DateTime portFolioDate, DateTime martkToMarketDate)
        //    {
        //        DataTable _MovementFixingRate = new DataTable();

        //        return _MovementFixingRate;
        //    }

        //}

        //#endregion

        //#endregion

    }

}
