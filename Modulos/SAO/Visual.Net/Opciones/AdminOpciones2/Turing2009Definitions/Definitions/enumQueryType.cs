namespace Turing2009Definitions.Definitions
{

    public enum enumQueryType
    {
        Init = 0,           // Inicializado
        Load = 1,           // Only Load
        Insert = 2,         // Only Insert
        Delete = 3,         // Only Delete
        Update = 4,         // Only Update
        Customer = 5,       // Insert/Delete/Update
        CustomerLoad = 6    // Insert/Delete/Update/Load
    }

}
