namespace Turing2009Definitions.Definitions
{

    // Descripción : ENUM que Administra los estados de los procesos
    public enum enumProcessStatus
    {

        aProcessToday = -3,             // Se esta procesando la cartera del día
        NotProcessToday = -2,           // No ha sido procesada la cartera del día
        ProcessToday = -1,              // Procesar la cartera del día
        Initialize = 0,                 // Inicialización
        Process = 1,                    // Procesar la fecha indicada
        NotProcess = 2,                 // No se encuentra procesada la fecha indicada
        aProcess = 3                    // Se esta procesando esta fecha

    }

}
