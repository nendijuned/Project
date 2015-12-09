﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HelpDeskRequest.aspx.cs" Inherits="PLNLite.Views.Administrator.HelpDeskRequest" %>

<%@ Import Namespace="PLNLite.Data.DataAccess" %>
<%@ Import Namespace="PLNLite.Frameworks.Validation" %>
<%@ Import Namespace="PLNLite.Frameworks.Security" %>
<%@ Import Namespace="PLNLite.Presentation.Components" %>
<%@ Import Namespace="PLNLite.Frameworks.Converter" %>
<%@ Import Namespace="PLNLite.Entity.Dictionary" %>
<%@ Import Namespace="PLNLite.Business.Activities" %>
<%@ Import Namespace="PLNLite.Workflow" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //SessionCreator();
        SetDDLSolution();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("../../Views/Application/PageSignIn.aspx");
        
    }

    protected void SessionCreator()
    {
        Session["username"] = "NDI15";
        Session["name"] = "Nendi Junaedi";
        Session["password"] = "ndi.id15";
        Session["email"] = "nendi.juned@plnlite.co.id";
        Session["jobcd"] = "STAF";
    }

    protected string GetAction(string TIKET)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        element.Append("<span class='label label-warning' style='color:white'><a style='color:white' href='HelpDeskDetail.aspx?act=1&TIKET=" + CryptographEngine.Encrypt(TIKET, true) + "'>D</a></span> ");
        element.Append("<span class='label label-primary' style='color:white'><a style='color:white' data-toggle='modal' href='#ModalApproval'>R</a></span> ");
        return element.ToString();
    }

    public static string GetStatus(string STATS)
    {
        StringBuilder element = new StringBuilder();

        switch (STATS)
        {
            case "1":
                {
                    return "<span class='label label-default' style='color:white'>PENDING</span> ";
                }

            case "2":
                {
                    return "<span class='label label-green' style='color:white'>SOLVED</span>";
                }
        }
        return element.ToString();
    }

    protected String GenerateHelpDeskRequest()
    {
        StringBuilder _tableelement = new StringBuilder();

        DataTable table = CatalogHelpDesk.GetAduan();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                string _status = GetStatus(table.Rows[i]["STATS"].ToString());
                string _action = GetAction(table.Rows[i]["TIKET"].ToString());
                _tableelement.Append("<tr class=''>");
                _tableelement.Append("<td align='center'> " + _status + "</td>");
                _tableelement.Append("<td>" + table.Rows[i]["TIKET"].ToString() + "</td>");
                _tableelement.Append("<td>" + DateTimeConverter.GetDateFormat(table.Rows[i]["BEGDA"].ToString()) + "</td>");
                _tableelement.Append("<td>" + table.Rows[i]["NMUSR"].ToString() + "</td>");
                _tableelement.Append("<td>" + table.Rows[i]["NOREK"].ToString() + "</td>");
                _tableelement.Append("<td>" + table.Rows[i]["NMKOM"].ToString() + "</td>");
                _tableelement.Append("<td>" + table.Rows[i]["ISIAD"].ToString() + "</td>");
                _tableelement.Append("<td align='center' width= '7%'>" + _action + "</td>");
                _tableelement.Append("</tr>");
            }

        return _tableelement.ToString();
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {

    }

    protected void SetDDLSolution()
    {
        DataTable data = CatalogSolution.GetSolution();

        ddlSolution.Items.Clear();
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlSolution.Items.Add(new ListItem(data.Rows[i]["NMSOL"].ToString(), data.Rows[i]["IDSOL"].ToString()));
        }
    }
    
</script>

<html lang="en">
<head>
    <% Response.Write(BasicScripts.GetMetaScript()); %>

    <title>Help Desk Request</title>

    <% Response.Write(StyleScripts.GetCoreStyle()); %>
    <% Response.Write(StyleScripts.GetCustomStyle()); %>
    <% Response.Write(StyleScripts.GetTableStyle()); %>
    <% Response.Write(StyleScripts.GetCustomStyle()); %>
</head>

<body>

    <section id="container">

        <!--header start-->
        <%Response.Write(SideBarMenu.TopMenuElement(Session["name"].ToString())); %>
        <!--header end-->

        <!--left side bar start-->
        <%Response.Write(SideBarMenu.LeftSidebarMenuElementAutoGenerated(Session["username"].ToString())); %>
        <!--left side bar end-->

        <!--main content start-->
        <section id="main-content">
            <section class="wrapper">
                <!-- page start-->
                <form runat="server">
                    <div class="row">
                        <div class="col-sm-12">
                            <section class="panel">
                                <header class="panel-heading">
                                Customer Care
                            </header>
                                <div class="panel-body">
                                    <h6>Annotation :</h6><p>
                                    <span class='label label-warning'>D</span> &nbsp; to "View Detail". &nbsp;&nbsp;&nbsp;
                                    <span class='label label-primary'>R</span> &nbsp; to "Respond". &nbsp;&nbsp;
                                    </p>
                                    <br />
                                    <div class="adv-table">
                                        <div class="clearfix">
                                            <div class="btn-group">
                                                <%--<asp:DropDownList runat="server" ID="ddlGroup" AutoPostBack="true" class="form-control input-sm m-bot15"></asp:DropDownList>--%>
                                            </div>
                                            <div class="btn-group pull-right">
                                                <button class="btn btn-green dropdown-toggle" data-toggle="dropdown">
                                                    Tools <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="#"><i class="fa fa-print"></i> Print Document</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th>Status</th>
                                                    <th>Ticket</th>       
                                                    <th>Date</th>
                                                    <th>Pelanggan</th>
                                                    <th>Kode Meteran</th>
                                                    <th>Problem</th>
                                                    <th>Keterangan</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%  Response.Write(GenerateHelpDeskRequest()); %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                           
                        </section>
                    </div>
                </div>

                    <!-- Modal -->
	                    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="ModalApproval" class="modal fade">
		                    <div class="modal-dialog">
			                    <div class="modal-content">
				                    <div class="modal-header">
					                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					                    <h4 class="modal-title">Respond HelpDesk</h4>
				                    </div>

				                    <div class="modal-body">
					                    <div class="" style="margin-left: 5px; margin-bottom: 25px;">
						                    <p align="left">Welcome,</p>
						                    <h4 style="color: #FF6C60;" align="left"><% Response.Write(Session["name"].ToString()); %></h4>
					                    </div>
                                        <h4>Solution</h4>
                                        <asp:DropDownList ID="ddlSolution" runat="server" class="form-control  m-bot15"></asp:DropDownList>
					                    <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" placeholder="Your Note If Any" class="form-control placeholder-no-fix" Style="margin-bottom: 15px;"></asp:TextBox>
					                </div>
				                    <div class="modal-footer">
					                    <asp:Button ID="btnClose" runat="server" data-dismiss="modal" class="btn btn-default" Text="Cancel"></asp:Button>
					                    <asp:Button ID="btnApprove" runat="server" class="btn btn-success" Text="Approve" OnClick="btnApprove_Click"></asp:Button>
				                    </div>
			                    </div>
		                    </div>
	                    </div>
                    <!-- modal -->

                </form>
                <!-- page end-->
            </section>
        </section>
        <!--main content end-->
        <!--right sidebar start-->
        <!--right sidebar end-->
    </section>

    <!-- Placed js at the end of the document so the pages load faster -->
    <% Response.Write(JS.GetCoreScript()); %>
    <% Response.Write(JS.GetCustomFormScript()); %>
    <% Response.Write(JS.GetDynamicTableScript()); %>
    <% Response.Write(JS.GetInitialisationScript()); %>
</body>
</html>
