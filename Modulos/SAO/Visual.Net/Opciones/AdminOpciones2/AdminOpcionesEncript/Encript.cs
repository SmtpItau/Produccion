using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualBasic;
using System.IO;
using System.Security.Cryptography;

namespace AdminOpcionesEncript
{
    public static class Encript
    {
        private const string RGBKEY = "12121212";
        private const string RGBIV = "34343434";

        public static string DesEcrypt(string encrypted)
        {
            byte[] data = System.Convert.FromBase64String(encrypted);
            byte[] rgbKey = System.Text.ASCIIEncoding.ASCII.GetBytes(RGBKEY);
            byte[] rgbIV = System.Text.ASCIIEncoding.ASCII.GetBytes(RGBIV);

            MemoryStream memoryStream = new MemoryStream(data.Length);
            DESCryptoServiceProvider desCryptoServiceProvider = new DESCryptoServiceProvider();
            CryptoStream cryptoStream = new CryptoStream(memoryStream, desCryptoServiceProvider.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Read);

            memoryStream.Write(data, 0, data.Length);
            memoryStream.Position = 0;

            string decrypted = new StreamReader(cryptoStream).ReadToEnd();

            cryptoStream.Close();

            return decrypted;
        }

        public static string Encrypt(string decrypted)
        {
            byte[] data = System.Text.ASCIIEncoding.ASCII.GetBytes(decrypted);
            byte[] rgbKey = System.Text.ASCIIEncoding.ASCII.GetBytes(RGBKEY);
            byte[] rgbIV = System.Text.ASCIIEncoding.ASCII.GetBytes(RGBIV);

            MemoryStream memoryStream = new MemoryStream(1024);
            DESCryptoServiceProvider desCryptoServiceProvider = new DESCryptoServiceProvider();

            CryptoStream cryptoStream = new CryptoStream(memoryStream, desCryptoServiceProvider.CreateEncryptor(rgbKey, rgbIV), CryptoStreamMode.Write);

            cryptoStream.Write(data, 0, data.Length);
            cryptoStream.FlushFinalBlock();

            byte[] result = new byte[(int)memoryStream.Position];

            memoryStream.Position = 0;
            memoryStream.Read(result, 0, result.Length);
            cryptoStream.Close();

            return System.Convert.ToBase64String(result);
        }

        public static string PwdDecrypts(string xClave, bool xEncriptar)
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
