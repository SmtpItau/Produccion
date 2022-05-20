using System.Text;
using Microsoft.VisualBasic;
using System.Globalization;

namespace AdminOpciones.Recursos 
{
    public class Encript
    {
        public string sEncript(string xClave, bool xEncriptar) 
        {
            int x, cont;
            string xPsw;
            string Letras;
            string Codigos;
            
            string BackSlash;

            BackSlash = "";
            BackSlash = BackSlash + Strings.ChrW(92); 

            Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzÑñ#$%&()*+/=[\\]_{}";
            Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\\`@?><Ññ1234567890;:.'~¿";
            xPsw = "";
            cont = xClave.Length;

            for (x = 1; x < cont + 1; x++)
            {

                if (xEncriptar)
                    xPsw = xPsw + Strings.ChrW((Strings.AscW(Strings.Mid(Codigos, Strings.InStr(1, Letras, Strings.Mid(xClave, x, 1), CompareMethod.Binary), 1)) - x));
                else
                {
                    string y = Strings.Mid(xClave, x, 1);
                    int u = Strings.AscW(y);
                    char i = Strings.ChrW(u + x);
                    int o = Strings.InStr(1, Codigos, i.ToString(), CompareMethod.Binary);
                    string p = Strings.Mid(Letras, o, 1);
                    xPsw = xPsw + p;

                    //xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, X, 1)) + X)), 1)
                }
            }
            return xPsw;
        }        
    }        
}   

