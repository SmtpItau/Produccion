#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Net;
using System.Net.Mail;
using CoreLib.Common;

namespace CoreLib.Helpers
{
    public static class MailHelper
    {
        private const string MSG_MAILER_OFF = "No esta habilitado el envio de mensajes de correo";

        /// <summary>
        /// Indica si el email fue enviado o no
        /// </summary>
        public static bool MailSended { get { return _mailsend; } }

        private static bool _mailsend = false;

        /// <summary>
        /// Devuelve mensaje del proceso
        /// </summary>
        public static string Results { get { return _str_result; } }

        private static string _str_result = string.Empty;

        /// <summary>
        /// Devuelve una lista de direcciones de correos erroneos
        /// </summary>
        public static List<string> BadEmailAddres { get { return _badEmails; } set { _badEmails = value; } }

        private static List<string> _badEmails = new List<string>();

        /// <summary>
        /// Devuelve una lista de archivos no encontrados
        /// </summary>
        public static List<string> FilesNotFound { get { return _filesNotFound; } set { _filesNotFound = value; } }

        private static List<string> _filesNotFound = new List<string>();

        /// <summary>
        /// Verifica si la direccion de correo tenga el formato correcto.
        /// </summary>
        /// <param name="email">Direccion de correo a verificar</param>
        /// <returns>True/False</returns>
        public static bool IsValidEmail(string email)
        {
            try
            {
                MailAddress direccion = new MailAddress(email);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// Envia mensaje de correo sin adjunto.
        /// </summary>
        /// <param name="ctx">Contexto de Mailer</param>
        /// <param name="mail">Direccion a la cual se envia el mensaje</param>
        /// <param name="asunto">Asunto del mensaje</param>
        /// <param name="mensaje">Objeto mensaje</param>
        /// <param name="format" value="Text">Formato del mensaje</param>
        /// <param name="SendAsync" value="False">Indica si se envia de modo Asyncrono</param>
        public static void SendMail(MailContext ctx,
            string mail,
            string asunto,
            object mensaje,
            MailFormat format = MailFormat.Text,
            bool SendAsync = false
            )
        {
            if (ctx.MailEnable == false)
            {
                MailHelper._mailsend = false;
                MailHelper._str_result = MSG_MAILER_OFF;
                return;
            }

            SmtpClient cliente = new SmtpClient();
            cliente.Host = ctx.MailServer;
            cliente.Port = ctx.MailPort;
            cliente.Timeout = ctx.TimeOut;
            if (SendAsync == true)
            {
                cliente.SendCompleted += new SendCompletedEventHandler(SendCompletedCallBack);
            }

            NetworkCredential credencial = new NetworkCredential();

            if (IsValidEmail(ctx.MailAccount))
            {
                credencial.UserName = ctx.MailAccount;
            }
            else
            {
                throw new ArgumentException("MailContext.MailAccount", "El parametro mail no tienen un formato valido");
            }

            if (ctx.MailSSL == true)
            {
                credencial.Password = ctx.MailAccountPass;
                cliente.EnableSsl = true;
            }
            else if (ctx.UseNetworkForDelivery == true)
            {
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
            }

            MailMessage message = new MailMessage();
            message.From = new MailAddress(ctx.MailAccount);
            if (IsValidEmail(mail))
            {
                message.To.Add(mail);
            }
            else
            {
                throw new ArgumentException("mail", "El parametro mail no tienen un formato valido");
            }

            message.Subject = asunto;
            message.Body = mensaje.ToString();
            if (format == MailFormat.HTML)
            {
                message.IsBodyHtml = true;
            }
            else
            {
                message.IsBodyHtml = false;
            }

            if (SendAsync == true)
            {
                cliente.SendAsync(message, "OK");
            }
            else
            {
                cliente.Send(message);
            }
        }

        /// <summary>
        /// Envia mensaje de correo con adjunto.
        /// </summary>
        /// <param name="ctx">Contexto de Mailer</param>
        /// <param name="mail">Direccion a la cual se envia el mensaje</param>
        /// <param name="asunto">Asunto del mensaje</param>
        /// <param name="mensaje">Objeto mensaje</param>
        /// <param name="format" value="Text">Formato del mensaje</param>
        /// <param name="SendAsync" value="False">Indica si se envia de modo Asyncrono</param>
        public static void SendMail(MailContext ctx,
            string mail,
            string asunto,
            object mensaje,
            FileInfo attachment,
            MailFormat format = MailFormat.Text,
            bool SendAsync = false
            )
        {
            if (ctx.MailEnable == false)
            {
                MailHelper._mailsend = false;
                MailHelper._str_result = MSG_MAILER_OFF;
                return;
            }

            SmtpClient cliente = new SmtpClient();
            cliente.Host = ctx.MailServer;
            cliente.Port = ctx.MailPort;
            if (SendAsync == true)
            {
                cliente.SendCompleted += new SendCompletedEventHandler(SendCompletedCallBack);
            }

            NetworkCredential credencial = new NetworkCredential();

            if (IsValidEmail(ctx.MailAccount))
            {
                credencial.UserName = ctx.MailAccount;
            }
            else
            {
                throw new ArgumentException("MailContext.MailAccount", "El parametro mail no tienen un formato valido");
            }

            if (ctx.MailSSL == true)
            {
                credencial.Password = ctx.MailAccountPass;
                cliente.EnableSsl = true;
            }
            else if (ctx.UseNetworkForDelivery == true)
            {
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
            }

            MailMessage message = new MailMessage();
            message.From = new MailAddress(ctx.MailAccount);

            if (IsValidEmail(mail)) { message.To.Add(mail); } else { throw new ArgumentException("mail", "El parametro mail no tienen un formato valido"); }

            message.Subject = asunto;
            message.Body = mensaje.ToString();

            if (attachment.Exists == false)
            {
                string msg = "El archivo {0}, no se encuentra";
                msg = string.Format(msg, attachment.Name);
                throw new FileNotFoundException(msg, attachment.Name);
            }
            else
            {
                message.Attachments.Add(new Attachment(attachment.FullName));
            }

            if (format == MailFormat.HTML) { message.IsBodyHtml = true; } else { message.IsBodyHtml = false; }

            if (SendAsync == true) { cliente.SendAsync(message, "OK"); } else { cliente.Send(message); }
        }

        /// <summary>
        /// Envia mensaje de correo a multiples destinatarios, con multiples archivos adjuntos
        /// </summary>
        /// <param name="ctx">Contexto de Mailer</param>
        /// <param name="mail">Lista de direcciones de correo</param>
        /// <param name="asunto">Asunto para el mensaje</param>
        /// <param name="mensaje">Mensaje a enviar</param>
        /// <param name="attachment">Lista de archivos adjuntos</param>
        /// <param name="format" value="Text">Formato del mensaje</param>
        /// <param name="SendAsync" value="False">Indica si se envia de modo Asyncrono</param>
        public static void SendMail(MailContext ctx,
            string[] mail,
            string asunto,
            object mensaje,
            FileInfo[] attachment,
            MailFormat format = MailFormat.Text,
            bool SendAsync = false
            )
        {
            if (ctx.MailEnable == false)
            {
                MailHelper._mailsend = false;
                MailHelper._str_result = MSG_MAILER_OFF;
                return;
            }

            SmtpClient cliente = new SmtpClient();
            cliente.Host = ctx.MailServer;
            cliente.Port = ctx.MailPort;
            if (SendAsync == true)
            {
                cliente.SendCompleted += new SendCompletedEventHandler(SendCompletedCallBack);
            }

            NetworkCredential credencial = new NetworkCredential();

            if (IsValidEmail(ctx.MailAccount))
            {
                credencial.UserName = ctx.MailAccount;
            }
            else
            {
                throw new ArgumentException("MailContext.MailAccount", "El parametro mail no tienen un formato valido");
            }

            if (ctx.MailSSL == true)
            {
                credencial.Password = ctx.MailAccountPass;
                cliente.EnableSsl = true;
            }
            else if (ctx.UseNetworkForDelivery == true)
            {
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
            }

            MailMessage message = new MailMessage();
            message.From = new MailAddress(ctx.MailAccount);

            int counter = mail.Length;
            int bad_email = 0;
            foreach (string email in mail)
            {
                if (!IsValidEmail(email))
                {
                    bad_email++;
                    BadEmailAddres.Add(email);
                }
                else
                {
                    message.To.Add(email);
                }
            }

            if (bad_email == counter)
            {
                throw new ArgumentException("mail", "Las direcciones de correo no tienen un formato valido");
            }

            message.Subject = asunto;
            message.Body = mensaje.ToString();

            counter = attachment.Length;
            bad_email = 0;
            foreach (FileInfo file in attachment)
            {
                if (!file.Exists)
                {
                    bad_email++;
                    FilesNotFound.Add(file.FullName);
                }
                else
                {
                    message.Attachments.Add(new Attachment(file.FullName));
                }
            }
            if (bad_email == counter)
            {
                throw new FileNotFoundException("No se encuentran los archivos para adjuntar");
            }

            if (format == MailFormat.HTML) { message.IsBodyHtml = true; } else { message.IsBodyHtml = false; }

            if (SendAsync == true) { cliente.SendAsync(message, "OK"); } else { cliente.Send(message); }
        }

        /// <summary>
        /// CallBack para envio asyncrono
        /// </summary>
        private static void SendCompletedCallBack(object sender, AsyncCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                MailHelper._str_result = e.Error.Message;
                MailHelper._mailsend = false;
                throw e.Error;
            }
            else if (e.Cancelled)
            {
                MailHelper._str_result = "La operación de envio fue cancelada";
                MailHelper._mailsend = false;
            }
            else
            {
                MailHelper._str_result = "OK";
                MailHelper._mailsend = true;
            }
        }
    }
}