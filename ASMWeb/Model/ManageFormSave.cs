using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASM
{
    public class ManageFormSave<T>
    {
        public static string SaveFormContent(string action, IActionApp<T> actionClass, T parameter)
        {
            return RunSaveToDB(action, actionClass, parameter);
        }
        public static string SaveFormContent(string action, string obj, T parameter)
        {
            IActionApp<T> actionClass = (IActionApp<T>)MapClass<T>.ClassType(obj);
            return   SaveFormContent(action, actionClass, parameter);
        }
        public static string DeleteFormContent(int id, string obj, T parameter)
        {
            IActionApp<T> actionClass = (IActionApp<T>)MapClass<T>.ClassType(obj);
            return actionClass.DeleteObj(id);
        }
        private static string RunSaveToDB(string action, IActionApp<T> actionClass, T parameter)
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