using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Principal;
using ClassLibrary;
using System.Net.Http;

namespace JwtAuth
{
   public class JwtManager
    {
        private const string secret = "db3OIsj+BXE9NZDy0t8W3TcNekrF+2d/1sFnWG4HnV8TZY30iTOdtVWJG8abWvB1GlOgJuQZdcF2Luqm/hccMw==";


        static string key = WebConfigurationManager.AppSettings["JwtPrivateKey"];
        public static string GenerateToken(AuthUser user, int expireMinutes = 30)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var secToken = new JwtSecurityToken(
                signingCredentials: credentials,
                issuer: "www.tcdsb.org",
                audience: "School Teacher",
                claims: new[]
                 { new Claim("UserName", user.UserName),
                   new Claim("UserRole", user.UserRole)},
                expires: DateTime.UtcNow.AddDays(1)
                );

            var handler = new JwtSecurityTokenHandler();
            return handler.WriteToken(secToken);
        }

        public static string GenerateToken(string userName, string userRole, int expireMinutes = 30)
        {

            var symmetricKey = Convert.FromBase64String(secret);

            var now = DateTime.UtcNow;
            var _expires = now.AddMinutes(Convert.ToInt32(expireMinutes));
            var _issuer = "www.tcdsb.org/ASM";
            var _subject = new ClaimsIdentity(new[] { new Claim("UserName", userName),
                                                      new Claim("UserRole", userRole)});
            var _signing = new SigningCredentials(new SymmetricSecurityKey(symmetricKey),
                                                    SecurityAlgorithms.HmacSha256Signature);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = _subject,
                Issuer = _issuer,
                Expires = _expires,
                SigningCredentials = _signing
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var stoken = tokenHandler.CreateToken(tokenDescriptor);
            var token = tokenHandler.WriteToken(stoken);

            return token;
        }

        public static ClaimsPrincipal GetPrincipal(string token)
        {
            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var jwtToken = tokenHandler.ReadToken(token) as JwtSecurityToken;

                if (jwtToken == null)
                    return null;

                var symmetricKey = Convert.FromBase64String(secret);

                var validationParameters = new TokenValidationParameters()
                {
                    RequireExpirationTime = true,
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    IssuerSigningKey = new SymmetricSecurityKey(symmetricKey)
                };

                SecurityToken securityToken;
                var principal = tokenHandler.ValidateToken(token, validationParameters, out securityToken);

                return principal;
            }
            catch (Exception)
            {
                //should write log
                return null;
            }
        }
        public static bool ValidateToken2(string token)
        {
            try
            {
                var result = GetPrincipal(token);
                if (result.Identity.IsAuthenticated) return true;

                return false;
            }
            catch (Exception)
            {

                return false; ;
            }

        }
        public static bool ValidateToken( HttpRequestMessage  Request)
        {
            try
            {
                if (Request.Headers.Authorization == null) return false;
                var authToken = Request.Headers.Authorization.Parameter;

                var tokenHandler = new JwtSecurityTokenHandler();
                var validationParameters = GetValidationParameters();

                SecurityToken validatedToken;
                IPrincipal principal = tokenHandler.ValidateToken(authToken, validationParameters, out validatedToken);
                if (principal.Identity.IsAuthenticated) return true;
                return false;

            }
            catch (Exception)
            {

                return false;
            }
        }

        private static TokenValidationParameters GetValidationParameters()
        {
            return new TokenValidationParameters()
            {
                ValidateLifetime = false, // Because there is no expiration in the generated token
                ValidateAudience = false, // Because there is no audiance in the generated token
                ValidateIssuer = false,   // Because there is no issuer in the generated token
                ValidIssuer = "www.tcdsb.org",
                ValidAudience = "Sample",
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key)) // The same key as the one that generate the token
            };
        }
    }
}
