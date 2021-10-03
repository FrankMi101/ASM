<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessSummary.aspx.cs" Inherits="ASM.Pages.AccessSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Access Control </title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />

    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <style>
         

        .gird-container {
            margin-top: 5px;
            display: grid;
            grid-template-columns: 50% auto;
            grid-template-rows: repeat(1,100%);
            margin: auto;
            text-align: left;
            width: 100%
        }

        .gird-left {
            text-align: left;
        }

        .gird-right img {
        height:100%;
        width:100%
        }
        li {
            margin: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Content-Text">


            <div id="Principal_Instration_Area">
                <h3>School User accesss control instraction.
                </h3>
                When an user login to the application. 
                <b> First</b>,the application will get the User Apps Role, if there is no Apps Role defined, the SAP matched default role instead. 
                <b>Second </b>, application gets the user access students scope based on the user Role. it will be school, class, grade, students.
               <b>Thrid</b>, application will decide the which function and operation user can take based on the Role and Students, it could be a Read, update, Super.  
                What school principal can do to help the school staff working on the application,follow two sections:   
                <div class="gird-container">
                    <div class="gird-left">
                        <ul>
                            <li><b>Access Student Scope:</b>
                                <ul>
                                    <li>A school users access the students based on the SAP position to match a application role. 
                                    </li>
                                    <li>The Principal, Vice Principal, Secretary, Guidance, and Special Education Teacher can access all school Student automaticlly.</li>
                                    <li>Classroom Teacher can access their class students automaticlly. For example, Mr. Simth teaching 04/05 class, He can access all students who take the 04/05 class. Ms. Angela teaching ENG401, She can access all students who take the ENG401 class.   </li>
                                    <li>Education Assistant does not get students match automaticlly, School Principal need to assign the EA to a specific Student group, such as All School Studnets Work Group or Grade Students Work Group.  </li>
                                    <li>Principal can assign any school staff to a specific Student Work Group in sepecific period date by <a href="../Loading.aspx?pID=Pages/SecurityManageGroup.aspx" target="_self">Teacher Access Students Management</a>. The staff can access the Student Work Group during the assigment period.  </li>
                                    <li>School principal can create a Student Work Group and links the student to the Group by <a href="../Loading.aspx?pID=Pages/SecurityManageGroup.aspx" target="_self">Students Work Group Management</a> of School level Security management page</li>
                                    <li>All of Student Work Groups will automaticlly rollover to new school year by system Admin when new school year start. the principal create new Student Work Group only the group is not in the system</li>
                                    <li>Principal can add or remove a staff to or from a <a href="../Loading.aspx?pID=Pages/SecurityManageGroup.aspx" target="_self">Student Work Groups </a>during the school year. All Assignment is school year basis. It is only available in the current school year.  </li>

                                </ul>



                            </li>
                            <li> <b> Student's Information Content Operation:</b>
                                <ul>
                                    <li>What kind of operation login user can have? It based on the the Applicaiton defination. Principal can review the content operation permission for the school user</li>
                                    <li><a href="../Loading.aspx?pID=Pages/SecurityManagePermissionView.aspx"> Page or Form content operation permission</a> inherited from the Apps default defination. Apps developer can define a specific page operation permission by adding a the Page permission control  </li>
                                    <li>For Example, IEP from Principal, Classroom teacher , and Special Education Teacher can Update the Student IEP Form content. Other User can only Review.  </li>
                                    <li>Education Assistant can update the IEP content if their in a Student Group and set up to Update permission. </li>
                                </ul>

                            </li>
                        </ul>
                    </div>
                    <div class="gird-right">
                        <img src="../Documents/School_Security_Group.png"   /> 
<%--                        <iframe id="IframeSub" name="IframeSub" style="height: 100%; width: 100%" frameborder="0" scrolling="no" src="../Documents/School%20Security%20Group.pdf" runat="server"></iframe>
                        <a href="../Documents/School Security Group.pdf" >School Group</a>--%>
                     </div>
                </div>





            </div>
            <div id="Admin_Instration_Area">
                <div class="gird-container">
                    <div class="gird-left">
                        <h1>This is board admin  user accesss control instraction area
                <br />
                            <br />
                            We areworking on this function    </h1>
                        <ul>
                            <li><a href="../Loading.aspx?pID=Pages/SecurityManage.aspx" target="_self">Security Group Management</a></li>
                            <li><a href="../Loading.aspx?pID=Pages/SecurityManageGroup.aspx" target="_self">Security Group Member Management</a></li>
                            <li><a href="../Loading.aspx?pID=Pages/SecurityManageBaseRole.aspx" target="_self">Security SAP Basic Role Management</a></li>
                            <li><a href="../Loading.aspx?pID=Pages/SecurityManageBaseRolePermission.aspx" target="_self">Apps Access Permision Setup</a></li>
                        </ul>
                    </div>
                    <div class="gird-right"></div>
                </div>


            </div>
        </div>
        <asp:HiddenField ID="hfUserID" runat="server" />
        <asp:HiddenField ID="hfUserRole" runat="server" />
        <asp:HiddenField ID="hfAppID" runat="server" />
        <asp:HiddenField ID="hfSchoolYear" runat="server" />
        <asp:HiddenField ID="hfPageID" runat="server" />
        <asp:HiddenField ID="hfUserLoginRole" runat="server" />
        <asp:HiddenField ID="hfRunningModel" runat="server" />

    </form>
</body>
</html>

<script src="../Scripts/MoursPoint.js"></script>

<script type="text/javascript">
    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var AppID = $("#hfAPPID").val();

    function pageLoad(sender, args) {

        $(document).ready(function () {

            if ($("#hfUserRole").val() == "Principal") {
                $("#Admin_Instration_Area").hide();
            }
        });
    }


</script>
