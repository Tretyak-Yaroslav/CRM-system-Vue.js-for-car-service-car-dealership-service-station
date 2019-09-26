using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Garage.Data.Services;
using Garage.Data.Servises;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace Garage.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; set; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
		    services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.RequireHttpsMetadata = false;
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        // укзывает, будет ли валидироваться издатель при валидации токена
                        ValidateIssuer = true,
                        // строка, представляющая издателя
                        ValidIssuer = AuthOptions.ISSUER,
                        // будет ли валидироваться потребитель токена
                        ValidateAudience = false,
                        // установка потребителя токена
                        ValidAudience = AuthOptions.AUDIENCE,
                        // будет ли валидироваться время существования
                        ValidateLifetime = true,
                        // установка ключа безопасности
                        IssuerSigningKey = AuthOptions.GetSymmetricSecurityKey(),
                        // валидация ключа безопасности
                        ValidateIssuerSigningKey = true,
                    };
                });

            AppSettings.ExportCsvPath = Configuration.GetSection("ExportCsv").Value;

            string connString = Configuration.GetConnectionString("DefaultConnection");
            services.AddTransient<IСatalogueService, IСatalogueService>(provider => new СatalogueService(connString));
            services.AddTransient<IOrderService, OrderService>(provider => new OrderService(connString));
            services.AddTransient<IUserService, UserService>(provider => new UserService(connString));

            services.AddCors();

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddSwaggerDocument(settings =>
            {
                settings.DocumentName = "API";
            });

            services.AddSpaStaticFiles(configuration => { configuration.RootPath = "wwwroot"; });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseCors(builder => builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());

            app.UseDefaultFiles();
            app.UseStaticFiles();


            app.UseSwagger(settings =>
            {
                settings.DocumentName = "API";
                settings.Path = "/swagger/{documentName}/swagger.json";

            });
            app.UseSwaggerUi3(settings =>
            {
                settings.DefaultModelExpandDepth = 3;
                settings.DefaultModelsExpandDepth = 3;
                settings.DocExpansion = "none";
                settings.EnableTryItOut = true;
            });

            app.UseAuthentication();
            app.UseMvc();

            app.UseSpaStaticFiles();
            app.UseSpa(spa => { spa.Options.SourcePath = "wwwroot"; });
        }
        public class AuthOptions
        {
            public const string ISSUER = "Garage"; // издатель токена
            public static string AUDIENCE => "address site"; // потребитель токена
            private const string KEY = "FAF609C68BCD4B61";   // ключ для шифрации 
            public const int LIFETIME = 4 * 60; // время жизни токена (в минутах)
            public static SymmetricSecurityKey GetSymmetricSecurityKey()
            {
                return new SymmetricSecurityKey(Encoding.ASCII.GetBytes(KEY));
            }
        }

        public static class AppSettings
        {
            public static string ExportCsvPath { get; set; }
        }

    }
}
