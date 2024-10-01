using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Connections;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class MailService : IMailService
    {
        public async Task startConnection(MailObject obj)
        {
            var hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
            var username = Environment.GetEnvironmentVariable("RABBITMQ_USER") ?? "guest";
            var password = Environment.GetEnvironmentVariable("RABBITMQ_PASS") ?? "guest";

            var factory = new ConnectionFactory { HostName = hostname, UserName = username, Password = password };
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();

            channel.QueueDeclare(queue: "email_sending",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);




            var body = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(obj));

            channel.BasicPublish(exchange: string.Empty,
                                 routingKey: "email_sending",
                                 basicProperties: null,
                                 body: body);
        }


    }
}
