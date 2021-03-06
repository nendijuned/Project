﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HelpDeskRequest.aspx.cs" Inherits="PLNLite.Views.Administrator.HelpDeskRequest" %>

<%@ Import Namespace="PLNLite.Data.DataAccess" %>
<%@ Import Namespace="PLNLite.Frameworks.Validation" %>
<%@ Import Namespace="PLNLite.Frameworks.Security" %>
<%@ Import Namespace="PLNLite.Presentation.Components" %>
<%@ Import Namespace="PLNLite.Frameworks.Converter" %>
<%@ Import Namespace="PLNLite.Entity.Dictionary" %>
<%@ Import Namespace="PLNLite.Business.Activities" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="PLNLite.Workflow" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SessionCreator();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("../../Views/Application/PageSignIn.aspx");

        if (!IsPostBack)
        {
            if (Request.QueryString["TIKET"] != null && (Request.QueryString["act"] == "1"))
            {
                string _tiket = CryptographEngine.Decrypt(Request.QueryString["TIKET"], true);
                CreateTestDetail(_tiket);
            }
        }
    }

    protected void SessionCreator()
    {
        Session["username"] = "NDI15";
        Session["name"] = "Nendi Junaedi";
        Session["password"] = "ndi.id15";
        Session["email"] = "nendi.juned@plnlite.co.id";
        Session["jobcd"] = "STAF";
    }

    public static string GetStatus(string STATS)
    {
        StringBuilder element = new StringBuilder();

        switch (STATS)
        {
            case "1":
                {
                    return "Pending";
                }

            case "2":
                {
                    return "Solved";
                }
        }
        return element.ToString();
    }

    protected void CreateTestDetail(string _tiket)
    {
        object[] data = CatalogHelpDesk.GetAduanByTiket(_tiket);
        txtDate.Text = DateTimeConverter.GetDateFormat(data[2].ToString());
        txtTicket.Text = data[1].ToString();
        txtUser.Text = data[3].ToString();
        txtKodeMeteran.Text = data[4].ToString();
        txtProblem.Text = data[5].ToString();
        txtKeterangan.Text = data[6].ToString();
        txtStatus.Text = GetStatus(data[0].ToString());
        
    }

    //OK btn
    protected void btnOk_Click(object sender, EventArgs e)
    {
        Response.Redirect("HelpDeskRequest.aspx");
    }

    
</script>

<html lang="en">
<head>
    <% Response.Write(BasicScripts.GetMetaScript()); %>

    <title>Customer Care</title>

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
                                Customer Care Detail
                            </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tanggal</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtDate" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Tiket</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtTicket" runat="server" class="form-control m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Pelanggan</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtUser" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Kode Meteran</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtKodeMeteran" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">Masalah</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtProblem" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Keterangan</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:TextBox ID="txtKeterangan" runat="server" class="form-control m-bot15" Style="height:100px;" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Status</label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:TextBox ID="txtStatus" runat="server" class="form-control m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:LinkButton class="btn btn-round btn-danger" Visible="true" ID="btnSave1" runat="server" Text="Back <i class='fa fa-undo'></i>" OnClick="btnOk_Click"  ></asp:LinkButton>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                           
                        </section>
                    </div>
                </div>
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
