<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="WebServer1.Devices" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="wrapper">
        <div id="sidebar-wrapper">
            <asp:Button ID="AddNewDeviceButton" class="btn btn-link" runat="server"  Text="Add A New Device..." OnClick="AddNewDeviceButton_Click"  />
            <hr />
            <asp:DataList ID="DeviceNameList" runat="server" DataSourceID="ListOfUserDevices">
                <ItemTemplate>
                    <asp:Button ID="ShowDeviceButton" class="btn btn-link" runat="server" Text='<%# Eval("DeviceName") %>' OnClick="ShowThisDevice_Click" />
                    <br />
                    <br />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="ListOfUserDevices" runat="server" ConnectionString="<%$ ConnectionStrings:HybernateDatabaseConnectionString %>" SelectCommand="SELECT [DeviceName] FROM [UserDevices] WHERE ([UserName] = @UserName)">
                <SelectParameters>
                    <asp:SessionParameter Name="UserName" SessionField="username" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </div>
        <div id ="page-contentwrapper">
        </div>
    </div>

</asp:Content>
