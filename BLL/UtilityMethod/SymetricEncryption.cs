using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Configuration;
using System.Web;


public class mySymetricEncryption
{

    private static readonly String IV = "SuFjcEmp/TE=";
    private static readonly String Key = "KIPSToILGp6fl+3gXJvMsN4IajizYBBT";
    private static readonly String DateTimeFormatString = "yyyy/MM/dd HH:mm:ss";
    private static readonly String SsoFormatString = "userid={0}";
    private static readonly Int32 DefaultMaxMinutes = 30;
    private static readonly String ValidationKeySeparator = "***";
    private static readonly String CombinedUidValidationKeyFormatString = "{0}{1}{2}";


    public static string GetSsoQueryString(string userid)
    {
        try
        {
            string currentDateTimeString = DateTime.Now.ToString(DateTimeFormatString);
            string sso = String.Format(CombinedUidValidationKeyFormatString, userid, ValidationKeySeparator, currentDateTimeString);
            string encryptedSso = EncryptValueForQueryString(sso);
            string encryptedSsoQuerystring = String.Format(SsoFormatString, encryptedSso);
            return encryptedSsoQuerystring;
        }
        catch 
        {
            return string.Empty;
        }

    }
    public static string GetValidatedSsoFromQueryString(string queryStringKeyValue, string signal)
    {
        return GetValidatedSsoFromQueryString(queryStringKeyValue, signal, DefaultMaxMinutes);

    }
    public static string GetValidatedSsoFromQueryString(string queryStringKeyValue, string signal, int maxMinutes)
    {
        try
        {
            if (signal == "NameOnly")
            { return queryStringKeyValue; }

            var decryptedValue = GetDecryptedValue(queryStringKeyValue);
            var startValidationKeySeparator = decryptedValue.IndexOf(ValidationKeySeparator);
            if (startValidationKeySeparator < 0)
            {
                return string.Empty;
            }

            var queryStringDateTimePortion = decryptedValue.Substring(startValidationKeySeparator + ValidationKeySeparator.Length);
            string queryStringUidPortion = decryptedValue.Substring(0, startValidationKeySeparator);

            DateTime queryStringDateTimeParsed = DateTime.ParseExact(queryStringDateTimePortion, DateTimeFormatString, System.Globalization.CultureInfo.InvariantCulture);

            DateTime currentDateTime = DateTime.Now;
            TimeSpan timeDiff = currentDateTime - queryStringDateTimeParsed;
            if (timeDiff.TotalMinutes > maxMinutes)
            {
                return string.Empty;
            }
            else
            {
                return queryStringUidPortion;
            }
        }
        catch  
        {
            return string.Empty;
        }
    }
    public static string EncryptValueForQueryString(string inputValue)
    {
        try
        {
            var encryptedValue = GetEncryptedValue(inputValue);
            string urlEncodedValue = HttpUtility.UrlEncode(encryptedValue);
            return urlEncodedValue;
        }
        catch
        {
            return string.Empty;
        }
    }

    public static string DecryptValueFromQueryString(string inputValue)
    {
        string urlUnEncodedValue = HttpUtility.UrlDecode(inputValue);
        var decryptedValue = GetDecryptedValue(urlUnEncodedValue);
        return decryptedValue;
    }

    public static string GetEncryptedValue(string inputValue)
    {
        MemoryStream mStream = null;
        CryptoStream cStream = null;
        try
        {
            TripleDESCryptoServiceProvider provider = GetCryptoProvider();
            mStream = new MemoryStream();

            cStream = new CryptoStream(mStream, provider.CreateEncryptor(), CryptoStreamMode.Write);

            byte[] toEncrypt = new UTF8Encoding().GetBytes(inputValue);

            cStream.Write(toEncrypt, 0, toEncrypt.Length);
            cStream.FlushFinalBlock();

            byte[] ret = mStream.ToArray();
            return Convert.ToBase64String(ret);
        }
        catch  
        {
            return string.Empty;
        }
        finally
        {
            if (mStream != null)
            {
                mStream.Close();
            }
            if (cStream != null)
            {
                cStream.Close();
            }
        }
    }

    public static string GetDecryptedValue(string inputValue)
    {
        CryptoStream csDecrypt = null;
        try
        {
            TripleDESCryptoServiceProvider provider = GetCryptoProvider();
            byte[] inputEquivalent = Convert.FromBase64String(inputValue);
            MemoryStream msDecrypt = new MemoryStream();

            csDecrypt = new CryptoStream(msDecrypt, provider.CreateDecryptor(), CryptoStreamMode.Write);
            csDecrypt.Write(inputEquivalent, 0, inputEquivalent.Length);
            csDecrypt.FlushFinalBlock();
            return new UTF8Encoding().GetString(msDecrypt.ToArray());
        }
        catch  
        {
            return string.Empty;
        }
        finally
        {
            if (csDecrypt != null)
            {
                csDecrypt.Close();
            }
        }

    }

    private static TripleDESCryptoServiceProvider GetCryptoProvider()
    {
        TripleDESCryptoServiceProvider provider = new TripleDESCryptoServiceProvider();
        provider.IV = Convert.FromBase64String(IV);
        provider.Key = Convert.FromBase64String(Key);
        return provider;
    }

}

