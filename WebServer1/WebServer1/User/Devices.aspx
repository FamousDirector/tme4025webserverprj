<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="WebServer1.Devices" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="sidebar" class="pull-left sidebar-wrapper">
        <asp:Button ID="AddNewDeviceButton" class="btn btn-small btn-link" runat="server"  Text="Add A New Device..." OnClick="AddNewDeviceButton_Click"  />
        <hr />
        <asp:DataList ID="DeviceNameList" runat="server" DataSourceID="ListOfUserDevices">
            <ItemTemplate>
                <asp:Button ID="ShowDeviceButton" class="btn btn-small btn-link" runat="server" Text='<%# Eval("DeviceName") %>' OnClick="ShowThisDevice_Click" />
             </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="ListOfUserDevices" runat="server" ConnectionString="<%$ ConnectionStrings:HybernateDatabaseConnectionString %>" SelectCommand="SELECT [DeviceName] FROM [UserDevices] WHERE ([UserName] = @UserName)">
            <SelectParameters>
                <asp:SessionParameter Name="UserName" SessionField="username" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </div>
    <div id ="maincontent" class="container page-contentwrapper">
        <asp:MultiView ID="MainMultiView" runat="server" ActiveViewIndex="0">
            <asp:View ID="DefaultView" runat="server">
                <h3>Manage Your Devices</h3>
                <p>Use the left panel to browse your Hybernate device.</p>
            </asp:View>
            <asp:View ID="DeviceView" runat="server">
                <h3>Device</h3>
                <p>Look..</p>
            </asp:View>
            <asp:View ID="NewDeviceView" runat="server">
                <h3>Add New Device</h3>
                <p>Add.. </p>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
