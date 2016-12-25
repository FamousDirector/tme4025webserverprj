﻿<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="WebServer1.Devices" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="Devices" class="pull-left sidebar sidebar-wrapper btn-group-vertical ">
            <asp:Button ID="AddNewDeviceViewButton" class="btn" runat="server"  Text="Add A New Device..." OnClick="AddNewDeviceButton_Click"  />
            <asp:ListView ID="DeviceList" runat="server" DataSourceID="ListOfUserDevices">
                <LayoutTemplate>
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server" />                                   
                </LayoutTemplate>
                <ItemTemplate>
                        <asp:Button ID="ShowDeviceButton" class="btn" runat="server" Text='<%# Eval("DeviceName") %>' OnClick="ShowThisDevice_Click" />
                </ItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="ListOfUserDevices" runat="server" ConnectionString="<%$ ConnectionStrings:HybernateDatabaseConnectionString %>" SelectCommand="SELECT [DeviceName] FROM [UserDevices] WHERE ([UserName] = @UserName)">
                <SelectParameters>
                    <asp:SessionParameter Name="UserName" SessionField="username" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource> 
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
                <div class="jumbotron">
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="UIDTextbox" runat="server" OnTextChanged="UIDTextbox_TextChanged"></asp:TextBox>                    
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="NameTextBox" runat="server" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                    <asp:Button ID="AddNewDeviceButton" runat="server" Text="Button" OnClick="AddNewDeviceButton_Click" />
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>