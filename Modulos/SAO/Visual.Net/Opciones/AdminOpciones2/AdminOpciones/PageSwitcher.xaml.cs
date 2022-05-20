using System.Windows.Controls;
//Esta pagina se encarga de limpiar el cache de la aplicación
//borrando las paginas de la memoria para un trabajo mas eficiente.
namespace AdminOpciones
{
    public partial class PageSwitcher : UserControl
    {
        //ASVG Solución básica para pasar parámetros.
        public PageSwitcher(string BaseUri, string BaseDir)
        {
            InitializeComponent();
            if (this.Content == null)
            {
                this.Content = new Page(BaseUri, BaseDir);
            }
        }

        public void Navigate(UserControl nextPage) 
        {
            this.Content = nextPage;
        }
    }
}
