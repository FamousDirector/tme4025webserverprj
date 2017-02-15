<%@ Page Title="Hybernate" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebServer1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid">
        <div class="row jumbotron">
            <div class="col-md-8">
                 <asp:UpdatePanel runat="server" ID="TitlePanel" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:MultiView ID="MainMultiView" runat="server" ActiveViewIndex=0 OnActiveViewChanged="MultiView1_ActiveViewChanged">
                            <asp:View ID="View1" runat="server">
                                <img src="../images/CaseView1.png" class="img-responsive" max-width:100% alt="interface screenshot">
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <img src="../images/CaseView2.png" class="img-responsive" max-width:100% alt="interface screenshot">
                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <img src="../images/CaseView3.png" class="img-responsive" max-width:100% alt="interface screenshot">
                            </asp:View>
                            <asp:View ID="View4" runat="server">
                                <img src="../images/CaseView4.png" class="img-responsive" max-width:100% alt="interface screenshot">
                            </asp:View>                                            
                        </asp:MultiView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="UpdateTimer" />
                        <asp:AsyncPostBackTrigger ControlID="BackButton" />
                        <asp:AsyncPostBackTrigger ControlID="NextButton" />                            
                    </Triggers>
                </asp:UpdatePanel>
                <div>
                    <asp:Button CssClass="pull-left btn btn-xs btn-off" ID="BackButton" runat="server" OnClick="BackButton_Click" Text="<" />
                    <asp:Button  CssClass="pull-right btn btn-xs btn-off" ID="NextButton" runat="server" OnClick="NextButton_Click" Text=">" />
                    <asp:Timer ID="UpdateTimer" runat="server" OnTick="NextView_Tick" Interval="5000"></asp:Timer>
                </div>
            </div>
            <div class="col-md-4">
                <br />
                <h1 class="text-center">&check; Save Power</h1>
                <hr class="coloured-hr" />
                <h1 class="text-center">&check; Save Money</h1>
                <br />
                <div class="text-center">                    
                    <asp:Button ID="StartButtonNow" runat="server" CssClass="btn btn-on" Text="Start Now &rarr;" OnClick="StartButtonNow_Click" />
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-md-5 jumbotron"> 
                <div id="img_container">
                    <h1 class="text-center">Start Today!</h1>
                    <img src="../images/interface-screenshot.png" class="img-thumbnail" max-width:100% alt="interface screenshot">
                    <asp:Button runat="server" ID="TrialButton" CssClass="btn btn-overlay btn-on" Text="Request A Trial" OnClick="TrialButton_Click" />
                </div>
            </div>
            <div class="col-md-6 col-md-offset-1 jumbotron">
                <h1 class="text-center">WE ARE</h1>
                <hr class ="coloured-hr"/>
                <a href="About">
                    <img src="../images/full-logo.png" class="img-responsive" max-width:100% alt="full-logo">
                </a>
            </div>
        </div>
    </div>      
</asp:Content>
