using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.HtmlControls;

namespace BLL.UtilityMethod
{
    //public class BuildingTree
    //{
    //    private HtmlGenericControl RenderMenu(Nodes nodes)
    //    {
    //        if (nodes == null)
    //            return null;

    //        var ul = new HtmlGenericControl("ul");

    //        foreach (Node node in nodes)
    //        {
    //            var li = new HtmlGenericControl("li");
    //            li.InnerText = node.Name;

    //            if (node.Children != null)
    //            {
    //                li.Controls.Add(RenderMenu(node.Children));
    //            }

    //            ul.Controls.Add(li);
    //        }

    //        return ul;
    //    }
    //}
    public class Node
    {
        public string Name { get; set; }
        public string ItemID { get; set; }
        public List<Node> Children { get; set; }
    }
  

    public class CreateTree
    {
        public static void Tree1(List<Comment> comments)
        {
            foreach (Comment comment in comments)
            {
                comment.ChildComments =
                  comments.Where(c => c.ParentItemID == comment.ItemID).ToList();
            }
          
        }
    public static List<Comment> ToTree(List<Comment> FlatCommentsList)
        {
            List<Comment> TopComments = FlatCommentsList.Where<Comment>(x => x.ParentItemID == 0).ToList();

            List<Comment> NestedComments = FlatCommentsList.Where<Comment>(x => x.ParentItemID > 0).ToList();

            List<int> IdsToRemove;

            while (NestedComments.Count > 0)
            {
                IdsToRemove = new List<int>();

                NestedComments.ForEach(x =>
                {
                    Comment ParentComment = TopComments.Where<Comment>(y => y.ItemID == x.ParentItemID).SingleOrDefault<Comment>();

                    if (ParentComment != null)
                    {
                        ParentComment.ChildComments.Add(x);
                        IdsToRemove.Add(x.ItemID);
                    }
                });

                NestedComments.RemoveAll(x => IdsToRemove.Contains(x.ItemID));
            }

            return TopComments;
        }
    }
    public class Comment
    {
        public int ID { get; set; }
        public int ItemID { get; set; }
        public int ParentItemID { get; set; }
        public List<Comment> ChildComments { get; set; }
    }

}


 