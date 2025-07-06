using eMekteb.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using eMekteb.Model.Helpers;

namespace eMekteb.Services
{
    public class MailSendingService
    {

        public async Task PosaljiMail(MailObjekat obj)
        {
            string serverAddress = Environment.GetEnvironmentVariable("SERVER_ADDRESS") ?? "smtp.gmail.com";
            string mailSender = Environment.GetEnvironmentVariable("MAIL_SENDER") ?? "emektebmail@gmail.com";
            string mailPass = Environment.GetEnvironmentVariable("MAIL_PASS") ?? "dkbehufjdusohlpw";
            int port = int.Parse(Environment.GetEnvironmentVariable("MAIL_PORT") ?? "587");

            string content = $"<p>{obj.poruka}</p>";
            string subject = obj.subject;

            var message = new MailMessage()
            {
                From = new MailAddress(mailSender),
                Subject = subject,
                Body = content,
                IsBodyHtml = true
            };

            message.To.Add(new MailAddress(obj.mailAdresa));

            var smtpClient = new SmtpClient(serverAddress, port)
            {
                Credentials = new NetworkCredential(mailSender, mailPass),
                EnableSsl = true
            };

            try
            {
                Console.WriteLine($"ADDRESS: {serverAddress} | SENDER: {mailSender} | PORT: {port}");
                await smtpClient.SendMailAsync(message);
                Console.WriteLine("Mail sent");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error sending email: " + ex.Message);
                throw;
            }
        }


    }

}
