public enum enumPeriod
{
    Anual = 1,
    Weekend = 2,
    Month = 4
}

public enum enumStatus
{
    NotFoundValue = -5,
    ErrorLoadValue = -4,
    ErrorLoad = -3,
    ErrorLoaded = -2,
    NotFound = -1,
    Initialize = 0,
    Loading = 1,
    Loaded = 2,
    Already = 3
}

public enum enumSource
{
    System = 0,
    CurrencyValueAccount = 1,
    Bloomberg = 2,
    Excel = 3,
    XML = 4
}
