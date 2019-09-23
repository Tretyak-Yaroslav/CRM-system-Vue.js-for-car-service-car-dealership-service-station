using MailKit.Net.Smtp;
using MimeKit;
using System;
using System.Threading.Tasks;

namespace Garage.API.Utils
{

    public static class EmailSender
    {

        public static async Task SendEmailAsync(string email, string subject, string message)
        {

            try
            {
                var mimeMessage = new MimeMessage();

                mimeMessage.From.Add(new MailboxAddress("Autotechnics Maintenance", "autodistribution2@ukr.net"));

                mimeMessage.To.Add(new MailboxAddress(email));

                mimeMessage.Subject = subject;

                mimeMessage.Body = new TextPart("html")
                {
                    Text = "Вы запросили сброс пароля на Автотехникс <br /> Ваш новый пароль: <b>" + message + "</b>"
                };

                using (var client = new SmtpClient())
                {

                    //  client.ServerCertificateValidationCallback = (s, c, h, e) => true;

                    await client.ConnectAsync("smtp.ukr.net", 465);

                    await client.AuthenticateAsync("autodistribution2@ukr.net", "auto123123");

                    await client.SendAsync(mimeMessage);

                    await client.DisconnectAsync(true);
                }

            }
            catch (Exception ex)
            {
                // TODO: handle exception
                throw new InvalidOperationException(ex.Message);
            }
        }

    }
}
