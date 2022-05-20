using System;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Web;
using System.Net;
using System.Security.Cryptography;

namespace AdminOpciones.Web.Recursos 
{
   public class SecureQueryString : NameValueCollection
   {
      private const string timeStampKey = "__TimeStamp__";
      // The key used for generating the encrypted string
      private const string cryptoKey = "ChangeThis!";
      // The Initialization Vector for the DES encryption routine
      private readonly byte[] IV = new byte[8] { 240, 3, 45, 29, 0, 76, 173, 59 };
      private DateTime _expireTime = DateTime.MaxValue;


      public SecureQueryString() : base() { }

      public SecureQueryString(string encryptedString)
      {
         deserialize(decrypt(encryptedString));
         // Compare the Expiration Time with the current Time to ensure
         // that the queryString has not expired.
         //if (DateTime.Compare(ExpireTime, DateTime.Now) < 0)
         //   //throw new ExpiredQueryStringException();
      }

      public string EncryptedString
      {
         get { return HttpUtility.UrlEncode(encrypt(serialize())); }
      }

      
      public DateTime ExpireTime
      {
         get { return _expireTime; }
         set { _expireTime = value; }
      }

      public override string ToString()
      {
         return EncryptedString;
      }

      private string encrypt(string serializedQueryString)
      {
         byte[] buffer = Encoding.ASCII.GetBytes(serializedQueryString);
         TripleDESCryptoServiceProvider des = new TripleDESCryptoServiceProvider();
         MD5CryptoServiceProvider MD5 = new MD5CryptoServiceProvider();
         des.Key = MD5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(cryptoKey));
         des.IV = IV;
         return Convert.ToBase64String(
            des.CreateEncryptor().TransformFinalBlock(
               buffer,
               0,
               buffer.Length
            )
         );
      }

      private string decrypt(string encryptedQueryString)
      {
          try
          {
              byte[] buffer = Convert.FromBase64String(encryptedQueryString);
              TripleDESCryptoServiceProvider des = new TripleDESCryptoServiceProvider();
              MD5CryptoServiceProvider MD5 = new MD5CryptoServiceProvider();
              des.Key = MD5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(cryptoKey));
              des.IV = IV;
              return Encoding.ASCII.GetString(
                 des.CreateDecryptor().TransformFinalBlock(
                    buffer,
                    0,
                    buffer.Length
                 )
              );
          }
          //catch (CryptographicException)
          //{
          //   throw new InvalidQueryStringException();
          //}
          //catch (FormatException)
          //{
          //   throw new InvalidQueryStringException();
          //}
          catch { }
          return null;
      }

      private void deserialize(string decryptedQueryString)
      {
         string[] nameValuePairs = decryptedQueryString.Split('&');
         for (int i = 0; i < nameValuePairs.Length; i++)
         {
            string[] nameValue = nameValuePairs[i].Split('=');
            if (nameValue.Length == 2)
            {
               base.Add(nameValue[0], nameValue[1]);
            }
         }
         // Ensure that timeStampKey exists and update the expiration time.
         if (base[timeStampKey] != null)
            _expireTime = DateTime.Parse(base[timeStampKey]);
      }

      private string serialize()
      {
         StringBuilder sb = new StringBuilder();
         foreach (string key in base.AllKeys)
         {
            sb.Append(key);
            sb.Append('=');
            sb.Append(base[key]);
            sb.Append('&');
         }

         // Append timestamp
         sb.Append(timeStampKey);
         sb.Append('=');
         sb.Append(_expireTime);

         return sb.ToString();
      }
   }
}
