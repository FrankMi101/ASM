using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASM
{
    public class ManageFormSave<T2>
    {
        public static string SaveFormContent(string action,ActionApp<T2> actionClass, T2 parameter)
        {
           return RunSaveToDB(action, actionClass, parameter);
        }
        public static string SaveFormContent(string action, string obj, T2 parameter)
        {
            ActionApp<T2> actionClass = (ActionApp<T2>)MapClass<T2>.ClassType(obj);
            return   SaveFormContent(action, actionClass, parameter);
        }
        public static string DeleteFormContent(int id, string obj, T2 parameter)
        {
            ActionApp<T2> actionClass = (ActionApp<T2>)MapClass<T2>.ClassType(obj);
            return actionClass.DeleteObj(id);
        }
        private static string RunSaveToDB(string action, ActionApp<T2> actionClass, T2 parameter)
        {
            switch (action)
            {
                case "Add":
                    return actionClass.AddObj(parameter);
                case "Edit":
                    return actionClass.EditObj(parameter);
                case "Remove":
                    return actionClass.RemoveObj(parameter);
                case "Delete":   
                    return actionClass.RemoveObj(parameter);
                default:
                    return actionClass.EditObj(parameter);
            }
        }
    }
}