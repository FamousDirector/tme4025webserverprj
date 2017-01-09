<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebServer1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <div class="panel panel-default">
            <div class="panel-body">
                <asp:UpdatePanel runat="server" ID="TitlePanel">
                        <ContentTemplate>
                            <asp:MultiView ID="MainMultiView" runat="server" ActiveViewIndex=0 OnActiveViewChanged="MultiView1_ActiveViewChanged">
                                <asp:View ID="View1" runat="server">
                                    <h2>
                                        HYBERNATE
                                    </h2>
                                    <p>
                                        Control your Energy
                                    </p>
                                    </asp:View>
                                    <asp:View ID="View2" runat="server">
                                        <h2>
                                        Our Controller
                                    </h2>
                                    <p>
                                        We aim to blah...
                                    </p>
                                    </asp:View>
                                    <asp:View ID="View3" runat="server">
                                        <h2>
                                        More Stuff!
                                    </h2>
                                    <p>
                                        We aim to blah...
                                    </p>
                                    </asp:View>
                            </asp:MultiView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="UpdateTimer" />
                            <asp:AsyncPostBackTrigger ControlID="BackButton" />
                            <asp:AsyncPostBackTrigger ControlID="NextButton" />                            
                        </Triggers>
                    </asp:UpdatePanel>          
                
            </div>
        </div>  
        <asp:Button CssClass="pull-left btn" ID="BackButton" runat="server" OnClick="BackButton_Click" Text="<" />
        <asp:Button  CssClass="pull-right btn" ID="NextButton" runat="server" OnClick="NextButton_Click" Text=">" />
        <asp:Timer ID="UpdateTimer" runat="server" OnTick="NextView_Tick" Interval="5000"></asp:Timer>                           
    </div>
    <div class="row">
        <div class="col-md-4 ">
            <h2>Save Money!</h2>
            <p>
                BLah BLah</p>
        </div>
        <div class="col-md-4 col-centered">
            <h2>Set &amp; Forget!</h2>
            <p>
                Blah Blah</p>
        </div>
        <div class="col-md-4 ">
            <h2>Get Paid!</h2>
            <p>
                BLah blah</p>
        </div>
    </div>
    <br />
</asp:Content>
