using ClassLibrary;
using System.Collections.Generic;
using System.Data;
using System.Linq;
/// <summary>
/// Summary description for WorkingProfile
/// </summary>
/// 
using System.Web.UI.WebControls;

namespace ASM
{
    public class TreeViewNode : System.Web.UI.Page
    {
        public TreeViewNode()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static void BuildingTree(ref TreeView treeView1, DataSet myDs, string category, string pageSource)
        {

            TreeNode myroot = new TreeNode("EPASummary");
            string rootText = category + " Appraisal Process Step Summary";
            if (pageSource == "Incomplete")
            { rootText = category + " Appraisal Process Step Incomplete Summary"; }
            myroot.Text = rootText;
            treeView1.Nodes.Add(myroot);
            int n1 = 0;
            int n2 = 0;
            try
            {
                foreach (DataRow row in myDs.Tables[0].Rows)
                {
                    string myLevel = row["TreeLevel"].ToString();
                    TreeNode myNode = GetLevelNode(row["AppraisalCode"].ToString(), row["AppraisalText"].ToString(), row["AppraisalStatus"].ToString(), myLevel);
                    if (myLevel == "1")
                    {
                        treeView1.Nodes[0].ChildNodes.Add(myNode);
                        n1++;
                        n2 = 0;
                    }
                    if (myLevel == "2")
                    {
                        treeView1.Nodes[0].ChildNodes[n1 - 1].ChildNodes.Add(myNode);
                        n2++;
                    }
                    if (myLevel == "3")
                    {
                        treeView1.Nodes[0].ChildNodes[n1 - 1].ChildNodes[n2 - 1].ChildNodes.Add(myNode);
                    }
                }
            }
            catch
            { }
        }

        private static TreeNode GetLevelNode(string nodecode, string nodeText, string nodeStatus, string myLevel)
        {
            TreeNode levelNode = new TreeNode(nodecode);
            // bool check = (nodeStatus == "1") ? true : false;
            levelNode.Checked = (nodeStatus == "1") ? true : false;
            if (myLevel == "2" || myLevel == "3")
                levelNode.Text = (nodeStatus == "1") ? nodeText : "<span  style='color: red'>" + nodeText + "</span >";
            else
                levelNode.Text = nodeText;
            return levelNode;
        }
        public static void BuildingTree(ref TreeView treeView1, List<StrategyBank> myList, string category, string pageSource)
        {

            TreeNode myroot = new TreeNode("EPASummary");
            string rootText = category + " Appraisal Process Step Summary";
            if (pageSource == "Incomplete")
            { rootText = category + " Appraisal Process Step Incomplete Summary"; }
            myroot.Text = rootText;
            treeView1.Nodes.Add(myroot);
            int n1 = 0;
            int n2 = 0;
            try
            {

                foreach (var item in myList)
                {
                    string myLevel = item.TreeLevel.ToString();
                    TreeNode myNode = GetLevelNode(item.ItemCode, item.Notes, item.Shared, myLevel);
                    if (myLevel == "1")
                    {
                        treeView1.Nodes[0].ChildNodes.Add(myNode);
                        n1++;
                        n2 = 0;
                    }
                    if (myLevel == "2")
                    {
                        treeView1.Nodes[0].ChildNodes[n1 - 1].ChildNodes.Add(myNode);
                        n2++;
                    }
                    if (myLevel == "3")
                    {
                        treeView1.Nodes[0].ChildNodes[n1 - 1].ChildNodes[n2 - 1].ChildNodes.Add(myNode);
                    }
                }
            }
            catch
            { }
        }

        public static TreeNode GetStrategyTreebyCase(TreeNode myroot, List<StrategyBank> myList)
        {



            int n1 = 0;
            int n2 = 0;
            int n3 = 0;
            //TreeNode myroot = new TreeNode("RootStrategies");

            TreeNode parentsNode = new TreeNode();
            foreach (var item in myList)
            {

                string level = item.TreeLevel.ToString();
                switch (level)
                {
                    case "1":
                        break;
                    case "2":
                        parentsNode = myroot;
                        n1++;
                        n2 = 0;
                        break;
                    case "3":
                        parentsNode = myroot.ChildNodes[n1 - 1];
                        n2++;
                        n3 = 0;
                        break;
                    case "4":
                        parentsNode = myroot.ChildNodes[n1 - 1].ChildNodes[n2 - 1];
                        n3++;
                        break;
                    default:
                        parentsNode = myroot.ChildNodes[n1 - 1].ChildNodes[n2 - 1].ChildNodes[n3 - 1];
                        break;
                }

                TreeNode node = new TreeNode();// "T-" + item.RowNo.ToString());
                node.Text = item.Notes.ToString();
                parentsNode.ChildNodes.Add(node);
            }

            return myroot;
        }



        public static TreeNode GetStrategyTreebyLoop(TreeNode myroot, List<StrategyBank> myList)
        {


            var Level1 = GetTreeNodeList(myList, "0", "0", "0", "0", 1);

            foreach (var item1 in Level1)
            {
                var node1 = GetNode(item1.Notes.ToString());
                myroot.ChildNodes.Add(node1);

                var code1 = item1.ItemCode;
                var domainID = item1.DomainID;
                var Level2 = GetTreeNodeList(myList, domainID, "0", "0", "0", 3);
                //  Loop2(Level2,ref  myroot);
                foreach (var item2 in Level2)
                {
                    var node2 = GetNode(item2.Notes.ToString());
                    node1.ChildNodes.Add(node2);

                    var code2 = item2.ItemCode;
                    var competencyID = item2.CompetencyID;
                    var Level3 = GetTreeNodeList(myList, domainID, competencyID, "0", "0", 5);

                    foreach (var item3 in Level3)
                    {
                        var node3 = GetNode(item3.Notes.ToString());
                        node2.ChildNodes.Add(node3);
                        var lookforsID = item3.LookForsID;
                        var code3 = item3.ItemCode;

                        var Level4 = GetTreeNodeList(myList, domainID, competencyID, lookforsID, "0", 7);


                        foreach (var item4 in Level4)
                        {
                            var node4 = GetNode(item4.Notes.ToString());
                            node3.ChildNodes.Add(node4);
                            //  var tipsID = item4.LookForsID;
                            // var code4 = item4.ItemCode;


                        }

                    }

                }
            }

            return myroot;

        }



        public static TreeNode GetStrategyTreebyRecuision(TreeNode myroot, List<StrategyBank> myList)
        {

            var Level1 = GetTreeNodeList(myList, "0", "0", "0", "0", 1);
            var code = "6";

            var node = GetNodebyRecuision(myList, Level1, myroot, code);

            return node;
        }



        private static TreeNode GetNodebyRecuision(List<StrategyBank> myList, List<StrategyBank> myLevel, TreeNode node, string parentCode)
        {

            foreach (var item1 in myLevel)
            {
                var newNode = GetNode(item1.Notes.ToString());
                node.ChildNodes.Add(newNode);
                var code = item1.ItemCode;
                var domainID = item1.DomainID;
                var competencyID = item1.CompetencyID;
                var lookforID = item1.LookForsID;
                var tipsID =   item1.TipsID;
                int codeL = item1.ItemCode.Length + 2;


                var newLevel = GetTreeNodeList(myList, domainID, competencyID, lookforID, tipsID, codeL);
                if (newLevel != null)
                    GetNodebyRecuision(myList, newLevel, newNode, code);

            }
            return node;
        }
        private static TreeNode GetNode(string notes)
        {
            try
            {
                var node = new TreeNode();
                node.Text = notes;

                return node;

            }
            catch (System.Exception ex)
            { var em = ex.Message;
                return null;
            }
         }

        private static List<StrategyBank> GetTreeNodeList(List<StrategyBank> myList, string domainID, string competencyID, string lookForsID, string tipsID, int nodeLevel)
        {
            try
            {
                switch (nodeLevel)
                {
                    case 1:
                        return myList.Where(s => s.CompetencyID == "0" && s.DomainID != "0")
                                     .ToList<StrategyBank>();
                    //var Level1 = from s in myList
                    //             where s.CompetencyID == "0"
                    //             orderby s.DomainID
                    //             select new { s.DomainID, s.Notes };

                    case 3:
                        return myList.Where(s => s.DomainID == domainID && s.CompetencyID != "0" && s.LookForsID == "0")
                                    .ToList<StrategyBank>();
                    //var Level2 = from s in myList
                    //             where s.DomainID == domainID && s.CompetencyID != "0" && s.LookForsID == "0"
                    //             orderby s.CompetencyID
                    //             select new { s.CompetencyID, s.Notes };
                    case 5:
                        return myList.Where(s => s.DomainID == domainID && s.CompetencyID == competencyID && s.LookForsID != "0" && s.TipsID == "0")
                                    .ToList<StrategyBank>();
                    //var Level3 = from s in myList
                    //             where s.DomainID == domainID && s.CompetencyID == competencyID && s.LookForsID != "0" && s.TipsID == "0"
                    //             orderby s.CompetencyID
                    //             select new { s.LookForsID, s.Notes };
                    case 7:
                        return myList.Where(s => s.DomainID == domainID && s.CompetencyID == competencyID && s.LookForsID == lookForsID && s.TipsID != "0")
                                    .ToList<StrategyBank>();
                    //var Level4 = from s in myList
                    //             where s.DomainID == domainID && s.CompetencyID == competencyID && s.LookForsID == lookForsID && s.TipsID != "0"
                    //             orderby s.LookForsID
                    //             select new { s.TipsID, s.Notes };

                    //case 9:
                    //    return myList.Where(s => s.DomainID == domainID && s.CompetencyID == competencyID && s.LookForsID == lookForsID && s.TipsID  == tipsID)
                    //                .ToList<StrategyBank>();
                    default:
                        return myList.Where(s => s.DomainID == domainID && s.CompetencyID == competencyID && s.LookForsID == lookForsID)
                                .ToList<StrategyBank>();
                }


            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                throw;
            }



        }

        private static List<StrategyBank> GetTreeNodeList(List<StrategyBank> myList, string code, int codeLength)
        {
            try
            {
                //var Level = from s in myList
                //            where s.ItemCode.Substring(0, code.Length) == code && s.ItemCode.Length == codeLength // s.DomainID == domainID && s.CompetencyID != "0" && s.LookForsID == "0"
                //            orderby s.ItemCode
                //            select s;// new { s.ItemCode, s.Notes };


                var Level = myList.Where(s => s.ItemCode.Substring(0, code.Length) == code && s.ItemCode.Length == codeLength) // s.DomainID == domainID && s.CompetencyID != "0" && s.LookForsID == "0"
                            .ToList<StrategyBank>();


                return Level;
            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                throw;
            }



        }

        public static TreeNode GetLearningPlanTreebyLoop(TreeNode myRoot, List<CommentBank> myList)
        {

            TreeNode pNode = myRoot;
            string domainName = "";
            string shared = "";
            string comments = "";
            int n1 = 0;
            int n2 = 0;

            foreach (var item in myList)
            {
                if (domainName != item.DomainName.ToString())
                {
                    domainName = item.DomainName.ToString();
                    pNode = myRoot;
                    AddTreeNodeToParentNode(pNode, domainName);
                    n1++;
                    n2 = 0;
                }
                if (shared != item.Shared.ToString())
                {
                    try
                    {
                        shared = item.Shared.ToString();
                        pNode = myRoot.ChildNodes[n1 - 1];
                        AddTreeNodeToParentNode(pNode, shared);
                        n2++;
                    }
                    catch { }
                }
                if (comments != item.Comments.ToString())
                {
                    try
                    {
                        comments = item.Comments.ToString();
                        pNode = myRoot.ChildNodes[n1 - 1].ChildNodes[n2 - 1];
                        AddTreeNodeToParentNode(pNode, comments);
                    }
                    catch { }
                }

            }

            return myRoot;
        }

        private static void AddTreeNodeToParentNode(TreeNode pNode, string textNode)
        {
            TreeNode node = GetNode(textNode);
            pNode.ChildNodes.Add(node);

        }

        private static TreeNode GetNodebyRecuisionLearningPaln(List<CommentBank> myList, List<CommentBank> myLevel, TreeNode node)
        {

            foreach (var item1 in myLevel)
            {

                string domainName = item1.DomainName;
                string shared = item1.Shared;
                string comments = item1.Comments;
                var newNode = GetNode(comments);
                node.ChildNodes.Add(newNode);
                string level = "1";
                var newLevel = GetTreeNodeListLearningPlan(myList, domainName, shared, level);
                if (newLevel != null)
                    GetNodebyRecuisionLearningPaln(myList, newLevel, newNode);

            }
            return node;
        }
        private static List<CommentBank> GetTreeNodeListLearningPlan(List<CommentBank> myList, string dName, string sName, string level)
        {
            try
            {

                //switch (level)
                //{
                //    case "1":
                //        return myList.Where(x => x.DomainName != "").Select(x => new { Name = x.DomainName }).Distinct().ToList<CommentBank>(); //.ToList<CommentBank>();
                //    case "2":
                //        return myList.Where(x => x.DomainName == dName).Select(x =>  new { Name = x.Shared}).Distinct().ToList<CommentBank>() ; //.ToList<CommentBank>();

                //    default:
                //        return myList.Where(x => x.DomainName == dName && x.Shared == sName).Select(x => new { Name = x.Comments}).Distinct().ToList<CommentBank>();  
                // }

                return myList.Where(s => s.DomainID == dName && s.Shared == sName).ToList<CommentBank>();

            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                throw;
            }



        }
    }

    public class TreeNodeItem
    {
        public string Name { get; set; }
    }
}