<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="WebServer1.Devices" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id ="maincontent" class="container-fluid page-contentwrapper">
        <br />
        <asp:MultiView ID="MainMultiView" runat="server" >
            <asp:View ID="DefaultView" runat="server">
                <div class="jumbotron"> 
                    <h3>Manage Your Devices</h3>
                    <ul>
                        <li><a href="/User/Devices/Add">Add Device...</a></li>
                        <asp:ListView ID="DeviceList" runat="server" DataSourceID="ListOfUserDevices">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />                                   
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li><a href="/User/Devices/<%# Eval("DeviceName") %>"><%# Eval("DeviceName") %></a></li>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="ListOfUserDevices" runat="server" ConnectionString="<%$ ConnectionStrings:HybernateDatabaseConnectionString %>" SelectCommand="SELECT [DeviceName] FROM [UserDevices] WHERE ([UserName] = @UserName)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserName" SessionField="username" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource> 
                    </ul>
                </div>
            </asp:View>
            <asp:View ID="DeviceView" runat="server">
                <div class="">                 
                    <asp:Label ID="DeviceNameLabel" CssClass="h2" runat="server" Text="Device Name"></asp:Label>
                    <asp:UpdatePanel runat="server" ID="TitlePanel">
                        <ContentTemplate>
                            <div class="row ">
                                <div class="col-md-4 ">
                                    <h2>1.1</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2 class="hybernate-fonts-main">1.2</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>1.3</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>2.1</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>2.2</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>2.3</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>3.1</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>3.2</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>3.3</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>4.1</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>4.2</h2>
                                </div>
                                <div class="col-md-4 ">
                                    <h2>4.3</h2>
                                </div>
                            </div> 
                            <br />
                            <asp:Label ID="LastUpdatedTime" CssClass="text-muted" runat="server" Text="Panel not refreshed yet."></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="UpdateTimer" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>              
                <asp:Timer ID="UpdateTimer" runat="server" OnTick="UpdateTimer_Tick" Interval="1000"></asp:Timer>                               
            </asp:View>
            <asp:View ID="NewDeviceView" runat="server">
                <div class="jumbotron">                    
                    <h3>Add New Device</h3>
                    <h4>Device UID:</h4>
                    <asp:TextBox ID="UIDTextbox" CssClass="form-control" runat="server" OnTextChanged="UIDTextbox_TextChanged"></asp:TextBox>                    
                    <h4>Device Name:</h4>
                    <asp:TextBox ID="NameTextbox" CssClass="form-control" runat="server" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                    <asp:Button ID="AddNewDeviceButton" CssClass="btn btn-primary btn-small" runat="server" Text="Add" OnClick="AddNewDeviceButton_Click" />
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
    <br />
</asp:Content>
