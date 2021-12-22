using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace BLL
{
  
    public class AssemblingList
    {
        public static void SetLists(ListControl myListControl, List<NameValueList> myListData)
        {           
                AssemblingMyList(myListControl, myListData, "Value", "Name");
        }
        public static void SetLists(string ValueField, string NameField,ListControl myListControl, List<NameValueList> myListData)
        {
            AssemblingMyList(myListControl, myListData, ValueField, NameField);
        }
        public static void SetLists(ListControl myListControl, List<NameValueList> myListData, object initialValue)
        {

            SetLists(myListControl, myListData);
            SetValue(myListControl, initialValue);
        }
        public static void SetLists(string JsonSource, ListControl myListControl, string ddlType, CommonListParameter parameter)
        {
            List<NameValueList> myListData = ListDataSource(JsonSource, ddlType, parameter,"DDList");
            SetLists(myListControl, myListData);
        }
        public static void SetLists(string JsonSource, ListControl myListControl, string ddlType, CommonListParameter parameter, object initialValue)
        {
            SetLists(JsonSource, myListControl, ddlType, parameter);
            SetValue(myListControl, initialValue);
        }
        public static void SetLists(string ValueField, string NameField, string JsonSource,  ListControl myListControl, string ddlType, CommonListParameter parameter)
        {
            List<NameValueList> myListData = ListDataSource(JsonSource, ddlType, parameter, "DDList");
            SetLists(ValueField, NameField,myListControl, myListData);
        }
        public static void SetLists(string ValueField, string NameField, string JsonSource,  ListControl myListControl, string ddlType, CommonListParameter parameter, object initialValue)
        {
            SetLists(ValueField, NameField,JsonSource, myListControl, ddlType, parameter);
            SetValue(myListControl, initialValue);
        }

        public static void SetValue(ListControl myListControl, object objectValue)
        {
            try
            {
                myListControl.ClearSelection();
                if (myListControl.Items.Count == 0) return;

                if (objectValue != null)
                {
                    //  myListControl.Items.FindByValue(objectValue.ToString()).Selected = true;

                    foreach (ListItem item in myListControl.Items)
                    {
                        if (item.Value.ToString().ToLower() == objectValue.ToString().ToLower())
                        {
                            item.Selected = true;
                            break;
                        }
                    }
                }
            }
            catch
            {
                myListControl.SelectedIndex = 0;
           }
        }
        public static void SetValueMultiple(System.Web.UI.WebControls.ListControl myListControl, string value)
        {
            try
            {
                if (myListControl.Items.Count > 0)
                {
                    if (value != null)
                    {
                        myListControl.ClearSelection();
                        foreach (ListItem item in myListControl.Items)
                        {
                            if (value.IndexOf(item.Value) != -1)
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void SetValueCBL(ListControl myListControl, string objectValue)
        {
            try
            {
                ListItem li = new ListItem();
                int x = 1;
                foreach (ListItem item in myListControl.Items)
                {
                    if (objectValue.Substring(x, 1) == "1") item.Selected = true;
                    x++;
                }
            }
            catch
            {
                myListControl.SelectedIndex = 0;
            }
        }
        private static void AssemblingMyList( ListControl myListControl, object myList, string ValueField, string TextField)
        {
            try
            {
                // List<List2Item> myList = myList;
                myListControl.Items.Clear();
                myListControl.DataSource = myList;
                myListControl.DataTextField = TextField;
                myListControl.DataValueField = ValueField;
                myListControl.DataBind();
                myListControl.SelectedIndex = 0;

                if (myListControl.Items.Count > 1)
                    myListControl.Enabled = true;
                else
                    myListControl.Enabled = false;

            }
            catch (Exception ex)
            { var em = ex.Message; }
            finally
            { }
        }

        public static void SetListSchool( ListControl myListControl1,  ListControl myListControl2, string ddlType, CommonListParameter parameter, object initialValue)
        {
            SetListSchool(myListControl1, myListControl2, ddlType, parameter);
            SetValue(myListControl1, initialValue);
            SetValue(myListControl2, initialValue);
        }
        public static void SetListSchool(System.Web.UI.WebControls.ListControl myListControl1, System.Web.UI.WebControls.ListControl myListControl2, string ddlType, CommonListParameter parameter)
        {
          //  string SP = SPandParameters.GetSPNameAndParameters("General", "Schools");

            List<NameValueList> myListData = ListDataSource("", ddlType, parameter, "DDLListSchool");  // CommonExcute<CommonList>.ListOfT(SP, parameter);
            AssemblingSchoolList(myListControl1, myListControl2, myListData);

        }
        private static void AssemblingSchoolList(System.Web.UI.WebControls.ListControl myListControl1, System.Web.UI.WebControls.ListControl myListControl2, List<NameValueList> myList)
        {
            try
            {
                var byList = myList.OrderBy(o => o.Value); 
                //var sList = from c in myList
                //             orderby c.Code
                //             select c;
                AssemblingMyList(myListControl2, myList, "Value", "Name"); // School Name DDL
                AssemblingMyList(myListControl1, byList, "Value", "Value"); // school Code DDL
                myListControl2.SelectedIndex = 0;
                SetValue(myListControl1, myListControl2.SelectedValue);
            }
            catch (Exception ex)
            { var em = ex.Message; }
            finally
            { }
        }

        private static List<NameValueList> ListDataSource(string JsonSource, string ddlType, CommonListParameter parameter, string action)
        {
            List<NameValueList> myListData;
            if (JsonSource == "")
            {
                parameter.Operate = ddlType;

                //  string SP = SPandParameters.GetSPNameAndParameters("General", "DDList");
                //   myListData = CommonListExecute<NVListItem>.GeneralList(SP, parameter);
                myListData = GeneralList.CommonList<NameValueList>(action, parameter); //  CommonExcute<CommonList>.ListOfT(SP, parameter);
            }
            else
            {
                myListData = GeneralList.JsonSourceList<NameValueList>(JsonSource, ddlType, action);
            } 
            return myListData;

        }

    }
}
