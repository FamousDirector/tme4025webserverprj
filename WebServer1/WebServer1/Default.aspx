<%@ Page Title="Hybernate" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebServer1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
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
                                            Control Your Energy
                                        </p>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <h2>
                                            OUR CONTROLLER
                                        </h2>
                                        <p>
                                            We aim to produce a low-cost, simple and effective solution of lowering your electricity usage
                                        </p>
                                        </asp:View>
                                        <asp:View ID="View3" runat="server">
                                            <h2>
                                            We Are HYBERNATE
                                        </h2>
                                        <p>
                                           We are a team of electrical engineering students and are here to save you money!
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
            <asp:Button CssClass="pull-left btn btn-xs" ID="BackButton" runat="server" OnClick="BackButton_Click" Text="<" />
            <asp:Button  CssClass="pull-right btn btn-xs" ID="NextButton" runat="server" OnClick="NextButton_Click" Text=">" />
            <asp:Timer ID="UpdateTimer" runat="server" OnTick="NextView_Tick" Interval="5000"></asp:Timer>                           
        </div>
        <div class="row">
            <div class="col ">
                <h2>Save Money!</h2>
                <p>
                   Our product will work to operate your water heater outside of the Time Of Use (TOU) hours set by your electric utility, saving you money.
                </p>
            </div>
            <div class="col ">
                <h2>Set &amp; Forget!</h2>
                <p>
                    After our product has been set up, it will control your water heater without any further configuration.</p>
            </div>
        </div>
    </div>
</asp:Content>
