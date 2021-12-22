﻿using System;
using System.Collections.Generic;

namespace BLL
{
    public interface ICommonOperate<T>
    {
        List<T> ListOfT(string sp, object parameter);
        List<T> ListOfT(string sp, object parameter, string DapperCommandType);
        List<T> ListOfT(string db, string sp, object parameter);
        List<T> ListOfT(string db, string sp, object parameter, string DapperCommandType);
        //string ValueOfString(string sp, object parameter);
        T ValueOfT(string sp, object parameter);
        T ValueOfT(string sp, object parameter, string DapperCommandType);
        T ValueOfT(string db, string sp, object parameter);
        T ValueOfT(string db, string sp, object parameter, string DapperCommandType);
    }

    public class CommonOperate<T> : ICommonOperate<T>
    {

        public List<T> ListOfT(string sp, object parameter)
        {
            try
            {
                sp = CheckStoreProcedureParameters.GetParamerters(sp, parameter);
                var list = MyDapper.EasyDataAccess<T>.ListOfT(sp, parameter);
                return list;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                return null;
            }
        }
        public List<T> ListOfT(string sp, object parameter, string DapperCommandType)
        {
            try
            {
                var list = MyDapper.EasyDataAccess<T>.ListOfT(sp, parameter, DapperCommandType);
                return list;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                return null;
            }
        }
        public List<T> ListOfT(string db, string sp, object parameter)
        {
            try
            {
                sp = CheckStoreProcedureParameters.GetParamerters(sp, parameter);
                var list = MyDapper.EasyDataAccess<T>.ListOfT(db, sp, parameter);
                return list;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                return null;
            }
        }
        public List<T> ListOfT(string db, string sp, object parameter, string DapperCommeandType)
        {
            try
            {
                var list = MyDapper.EasyDataAccess<T>.ListOfT(db, sp, parameter, DapperCommeandType);
                return list;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                return null;
            }
        }



        public T ValueOfT(string sp, object parameter)
        {
            try
            {
                sp = CheckStoreProcedureParameters.GetParamerters(sp, parameter);
                var result = MyDapper.EasyDataAccess<T>.ValueOfT(sp, parameter);
                return result;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                throw;
            }
        }
  
        public T ValueOfT(string sp, object parameter, string DapperComandType)
        {
            try
            {
                var result = MyDapper.EasyDataAccess<T>.ValueOfT(sp, parameter, DapperComandType);
                return result;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                throw;
            }
        }

        public T ValueOfT(string db, string sp, object parameter)
        {
            try
            {
                sp = CheckStoreProcedureParameters.GetParamerters(sp, parameter);
                var result = MyDapper.EasyDataAccess<T>.ValueOfT(db, sp, parameter);
                return result;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                throw;
            }
        }
  
        public T ValueOfT(string db, string sp, object parameter, string DapperComandType)
        {
            try
            {
                var result = MyDapper.EasyDataAccess<T>.ValueOfT(db, sp, parameter, DapperComandType);
                return result;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                throw;
            }
        }

        //public string ValueOfString(string sp, object parameter)
        //{
        //    try
        //    {
        //        sp = CheckStoreProcedureParameters.GetParamerters(sp, parameter);
        //        var result = MyDapper.EasyDataAccess<String>.ValueOfT(sp, parameter);
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        var exm = ex.Message;
        //        return "";
        //    }
        //}
    }


}

